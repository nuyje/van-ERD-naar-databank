/* =========================================================
   Van ERD naar databank – script
   - bouwt de stappenlijst (zijbalk) en vorige/volgende-knoppen
   - bewaart de vinkjes van de controlelijsten in de browser
   - kleurt SQL-code in, nummert de regels en voegt een kopieerknop toe

   Een pagina toevoegen of hernoemen? Pas enkel de lijst NAV aan.
   ========================================================= */

const NAV = [
  { href: "index.html", nr: "S", title: "Start", extra: true },
  { href: "1-erd-naar-ontwerp.html", nr: "1", title: "Van ERD naar databaseontwerp" },
  { href: "2-voorbeeld-festival.html", nr: "2", title: "Ons voorbeeld: festival Zomerklanken" },
  { href: "3-nieuw-model.html", nr: "3", title: "Een nieuw model in Workbench" },
  { href: "4-tabellen.html", nr: "4", title: "Tabellen en kolommen" },
  { href: "5-relaties.html", nr: "5", title: "Relaties leggen" },
  { href: "6-forward-engineer.html", nr: "6", title: "Forward engineer" },
  { href: "7-gegevens-invoeren.html", nr: "7", title: "Gegevens invoeren met INSERT INTO" },
  { href: "8-integriteit.html", nr: "8", title: "Referentiële integriteit testen" },
  { sep: true },
  { href: "oefeningen.html", nr: "O", title: "Oefeningen", extra: true },
  { href: "spiekbrief.html", nr: "?", title: "Spiekbrief", extra: true }
];

const STORE = "erd2db:";

/* ---------- veilige opslag (localStorage kan geblokkeerd zijn) ---------- */
function load(key, fallback) {
  try {
    const v = localStorage.getItem(STORE + key);
    return v === null ? fallback : JSON.parse(v);
  } catch (e) { return fallback; }
}
function save(key, value) {
  try { localStorage.setItem(STORE + key, JSON.stringify(value)); } catch (e) { /* niets */ }
}

function currentPage() {
  const last = location.pathname.split("/").pop();
  return last === "" ? "index.html" : last;
}

/* ---------- zijbalk ---------- */
function buildSidebar() {
  const nav = document.getElementById("stappen");
  if (!nav) return;
  const here = currentPage();
  const done = load("done", {});
  let html = '<div class="sidebar-inner"><h2>Stappenplan</h2><ol class="route">';
  for (const item of NAV) {
    if (item.sep) { html += '<li class="route-sep" aria-hidden="true"></li>'; continue; }
    const cls = [item.extra ? "extra" : "", done[item.href] ? "done" : ""].join(" ").trim();
    const cur = item.href === here ? ' aria-current="page"' : "";
    const mark = done[item.href] ? '<span class="sr-only"> (afgewerkt)</span>' : "";
    html += `<li class="${cls}"><a href="${item.href}"${cur}><span class="node" aria-hidden="true">${done[item.href] ? "✓" : item.nr}</span><span class="route-label">${item.title}${mark}</span></a></li>`;
  }
  html += "</ol>";
  html += '<p class="progress-note">Een stap kleurt groen als je alle vinkjes onder <b>Controle</b> hebt aangeduid. De vinkjes worden enkel in deze browser bewaard.</p>';
  html += "</div>";
  nav.innerHTML = html;
}

/* ---------- vorige / volgende ---------- */
function buildPager() {
  const pager = document.querySelector(".pager[data-auto]");
  if (!pager) return;
  const pages = NAV.filter(i => !i.sep);
  const idx = pages.findIndex(i => i.href === currentPage());
  if (idx < 0) return;
  let html = "";
  if (idx > 0) {
    const p = pages[idx - 1];
    html += `<a class="prev" href="${p.href}"><span class="dir">Vorige</span><span class="ttl">${p.title}</span></a>`;
  }
  if (idx < pages.length - 1) {
    const n = pages[idx + 1];
    html += `<a class="next" href="${n.href}"><span class="dir">Volgende</span><span class="ttl">${n.title}</span></a>`;
  }
  pager.innerHTML = html;
}

/* ---------- menu op smal scherm ---------- */
function setupToggle() {
  const btn = document.querySelector(".menu-toggle");
  if (!btn) return;
  btn.addEventListener("click", () => {
    const open = document.body.classList.toggle("nav-open");
    btn.setAttribute("aria-expanded", open ? "true" : "false");
  });
  document.addEventListener("keydown", e => {
    if (e.key === "Escape" && document.body.classList.contains("nav-open")) {
      document.body.classList.remove("nav-open");
      btn.setAttribute("aria-expanded", "false");
      btn.focus();
    }
  });
}

/* ---------- controlelijsten ---------- */
function setupChecklists() {
  const lists = document.querySelectorAll(".checklist[data-key]");
  if (!lists.length) return;
  const here = currentPage();

  function updateDone() {
    const all = document.querySelectorAll(".checklist[data-key] input[type=checkbox]");
    const allChecked = all.length > 0 && Array.from(all).every(i => i.checked);
    const done = load("done", {});
    if (allChecked) done[here] = true; else delete done[here];
    save("done", done);
    buildSidebar();
  }

  lists.forEach(list => {
    const key = "check:" + list.dataset.key;
    const state = load(key, []);
    const boxes = list.querySelectorAll("input[type=checkbox]");
    boxes.forEach((box, i) => {
      box.checked = !!state[i];
      box.addEventListener("change", () => {
        const now = Array.from(boxes).map(b => b.checked);
        save(key, now);
        updateDone();
      });
    });
  });
}

/* ---------- SQL inkleuren ---------- */
const KW = new Set(("SELECT FROM WHERE INSERT INTO VALUES UPDATE SET DELETE CREATE TABLE SCHEMA DATABASE IF NOT EXISTS " +
  "NULL PRIMARY KEY FOREIGN REFERENCES CONSTRAINT ON CASCADE RESTRICT NO ACTION DEFAULT AUTO_INCREMENT UNIQUE INDEX " +
  "ENGINE USE DROP ALTER ADD AND OR AS UNION ALL ORDER BY GROUP SHOW TABLES DESCRIBE TRUNCATE CHARACTER COLLATE " +
  "VISIBLE ASC DESC LIMIT JOIN INNER LEFT IS IN DATABASES COLUMNS").split(" "));
const TYPES = new Set("INT INTEGER VARCHAR CHAR TEXT DATE TIME DATETIME YEAR DECIMAL TINYINT BOOLEAN BOOL FLOAT DOUBLE ENUM BIGINT SMALLINT".split(" "));
const FN = new Set(["COUNT", "SUM", "AVG", "MIN", "MAX", "NOW", "CURDATE"]);

function esc(s) {
  return s.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
}
function span(cls, s) { return `<span class="tok-${cls}">${esc(s)}</span>`; }

function highlightLine(src) {
  let out = "", i = 0;
  const n = src.length;
  while (i < n) {
    const c = src[i];
    if (src.startsWith("--", i) || c === "#") {
      out += span("com", src.slice(i)); break;
    }
    if (c === "'") {
      let j = i + 1;
      while (j < n) {
        if (src[j] === "\\") { j += 2; continue; }
        if (src[j] === "'") {
          if (src[j + 1] === "'") { j += 2; continue; }
          j++; break;
        }
        j++;
      }
      out += span("str", src.slice(i, j)); i = j; continue;
    }
    if (c === "`") {
      let j = src.indexOf("`", i + 1);
      j = j < 0 ? n : j + 1;
      out += span("id", src.slice(i, j)); i = j; continue;
    }
    if (/[0-9]/.test(c) && !/[A-Za-z_]/.test(src[i - 1] || "")) {
      const m = /^[0-9]+(\.[0-9]+)?/.exec(src.slice(i));
      out += span("num", m[0]); i += m[0].length; continue;
    }
    if (/[A-Za-z_]/.test(c)) {
      const m = /^[A-Za-z_][A-Za-z0-9_]*/.exec(src.slice(i));
      const w = m[0], u = w.toUpperCase();
      let cls = null;
      if (FN.has(u) && src[i + w.length] === "(") cls = "fn";
      else if (KW.has(u)) cls = "kw";
      else if (TYPES.has(u)) cls = "type";
      out += cls ? span(cls, w) : esc(w);
      i += w.length; continue;
    }
    out += esc(c); i++;
  }
  return out;
}

function copyText(text, btn) {
  const done = () => {
    const old = btn.textContent;
    btn.textContent = "Gekopieerd";
    setTimeout(() => { btn.textContent = old; }, 1600);
  };
  if (navigator.clipboard && window.isSecureContext) {
    navigator.clipboard.writeText(text).then(done, () => fallbackCopy(text, done));
  } else {
    fallbackCopy(text, done);
  }
}
function fallbackCopy(text, done) {
  const ta = document.createElement("textarea");
  ta.value = text; ta.setAttribute("readonly", ""); ta.style.position = "absolute"; ta.style.left = "-9999px";
  document.body.appendChild(ta); ta.select();
  try { document.execCommand("copy"); done(); } catch (e) { /* niets */ }
  document.body.removeChild(ta);
}

function setupCode() {
  document.querySelectorAll(".code").forEach(box => {
    const codeEl = box.querySelector("pre code");
    if (!codeEl) return;
    const raw = codeEl.textContent.replace(/^\n/, "").replace(/\s+$/, "");
    const lang = box.dataset.lang || "sql";
    const lines = raw.split("\n").map(l => `<span class="ln">${lang === "sql" ? highlightLine(l) : esc(l)}${l === "" ? " " : ""}</span>`);
    codeEl.innerHTML = lines.join("");

    const bar = document.createElement("div");
    bar.className = "code-bar";
    const name = box.dataset.file ? `<span class="fname">${esc(box.dataset.file)}</span>` : `<span>${lang === "sql" ? "SQL" : "Tekst"}</span>`;
    let actions = '<span class="actions"><button type="button" class="copy">Kopieer</button>';
    if (box.dataset.download) actions += `<a class="dl" href="${box.dataset.download}" download>Download</a>`;
    actions += "</span>";
    bar.innerHTML = name + actions;
    box.insertBefore(bar, box.firstChild);
    bar.querySelector(".copy").addEventListener("click", e => copyText(raw, e.currentTarget));
  });
}

document.addEventListener("DOMContentLoaded", () => {
  buildSidebar();
  buildPager();
  setupToggle();
  setupChecklists();
  setupCode();
});
