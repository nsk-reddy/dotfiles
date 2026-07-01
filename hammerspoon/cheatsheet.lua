-- Searchable keybind cheatsheet — auto-parses ~/.config/aerospace/aerospace.toml
local M = {}

-- Static sections (not derived from aerospace.toml)
local STATIC = {
  {section = "Hammerspoon (Hyper = cmd+alt+ctrl)", keys = {
    {"hyper + E",              "window hint mode (letters on windows)", "vim hint letter jump vimium homerow"},
    {"hyper + /",              "open this cheatsheet",            "help shortcuts cheat keybinds guide list search"},
    {"hyper + R",              "reload Hammerspoon config",       "reload restart refresh hammerspoon"},
    {"hyper + B",              "open Safari",                     "launch open browser safari"},
    {"hyper + C",              "open Visual Studio Code",         "launch open editor vscode code ide"},
    {"hyper + T",              "open Terminal",                   "launch open terminal shell"},
    {"hyper + F",              "open Finder",                     "launch open finder files"},
    {"hyper + M",              "open Mail",                       "launch open mail email"},
    {"hyper + S",              "open Slack",                      "launch open chat slack"},
  }},
  {section = "VS Code — quick nav", keys = {
    {"Cmd + P",                "quick open file (fuzzy)",          "vscode open file fuzzy quick goto"},
    {"Cmd + Shift + P",        "command palette",                  "vscode command palette commands run"},
    {"Cmd + Shift + E",        "focus explorer (file tree)",       "vscode explorer file tree sidebar focus"},
    {"Cmd + Shift + F",        "search in files (project)",        "vscode search find project workspace grep"},
    {"Cmd + Shift + H",        "search and replace in files",      "vscode search replace project find"},
    {"Cmd + T",                "go to symbol in workspace",        "vscode goto symbol workspace project"},
    {"Cmd + Shift + O",        "go to symbol in file",             "vscode goto symbol file outline"},
    {"Ctrl + G",               "go to line",                       "vscode goto line jump"},
    {"Cmd + B",                "toggle sidebar",                   "vscode toggle sidebar explorer hide show"},
    {"Cmd + J",                "toggle bottom panel (terminal)",   "vscode toggle panel bottom terminal"},
    {"Ctrl + `",               "toggle integrated terminal",       "vscode terminal toggle open"},
    {"Cmd + 0",                "focus sidebar",                    "vscode focus sidebar"},
    {"Cmd + 1 / 2 / 3",        "focus editor group 1 / 2 / 3",     "vscode focus editor group split"},
  }},
  {section = "VS Code — explorer keyboard nav", keys = {
    {"Cmd + Shift + E",        "focus explorer",                   "vscode explorer focus tree files"},
    {"arrows",                 "move up/down/expand/collapse",     "vscode explorer navigate move"},
    {"Enter",                  "open file / expand folder",        "vscode explorer open file folder"},
    {"a",                      "new file (when explorer focused)", "vscode explorer new file create"},
    {"Shift + a",              "new folder (explorer)",            "vscode explorer new folder create"},
    {"F2",                     "rename file",                      "vscode rename file explorer"},
    {"Cmd + Backspace",        "move to trash",                    "vscode delete file trash"},
    {"Esc / Cmd + 1",          "back to editor",                   "vscode escape editor focus back"},
  }},
  {section = "VS Code — buffers / tabs / splits", keys = {
    {"Cmd + W",                "close active tab",                 "vscode close tab buffer"},
    {"Cmd + Shift + T",        "reopen closed tab",                "vscode reopen tab restore"},
    {"Ctrl + Tab",             "next tab in MRU order",            "vscode tab switch next mru recent"},
    {"Cmd + Option + ← / →",   "prev / next tab",                  "vscode tab switch prev next"},
    {"Cmd + \\",               "split editor right",               "vscode split editor right vertical"},
    {"Cmd + K then \\",        "split editor down",                "vscode split editor down horizontal"},
    {"Cmd + K then W",         "close all editors in group",       "vscode close all editors group"},
    {"Cmd + K then arrow",     "move focus across split direction","vscode focus split direction"},
  }},
  {section = "VS Code — LSP / code", keys = {
    {"F12",                    "go to definition",                 "vscode lsp definition goto"},
    {"Option + F12",           "peek definition",                  "vscode lsp peek definition inline"},
    {"Shift + F12",            "find references",                  "vscode lsp references find usages"},
    {"F2",                     "rename symbol",                    "vscode lsp rename refactor"},
    {"Cmd + .",                "quick fix / code action",          "vscode lsp code action quick fix lightbulb"},
    {"Cmd + K then I",         "hover docs",                       "vscode lsp hover docs"},
    {"Cmd + Shift + M",        "problems panel (diagnostics)",     "vscode diagnostics problems errors warnings"},
    {"F8 / Shift + F8",        "next / prev problem",              "vscode diagnostic next prev problem"},
    {"Cmd + /",                "toggle line comment",              "vscode comment toggle line"},
    {"Option + Shift + F",     "format document",                  "vscode format document prettier"},
  }},
  {section = "VS Code — Claude Code panel", keys = {
    {"Cmd + Esc",              "toggle focus editor ↔ Claude",     "vscode claude toggle focus panel"},
    {"Cmd + Shift + Esc",      "open Claude in new tab",           "vscode claude new tab open"},
    {"Option + K (in editor)", "insert @-mention to Claude",       "vscode claude mention insert reference"},
    {"/",                      "Claude command menu (in panel)",   "vscode claude command menu slash"},
    {"Shift + Enter",          "newline in Claude prompt",         "vscode claude prompt newline multiline"},
  }},
  {section = "VS Code — git", keys = {
    {"Ctrl + Shift + G",       "open source control panel",        "vscode git source control panel"},
    {"Cmd + Shift + P → git",  "git commands via palette",         "vscode git commit pull push palette"},
    {"Cmd + K then V",         "open file diff (changes)",         "vscode git diff changes file"},
  }},
  {section = "VS Code — multi-cursor / select", keys = {
    {"Cmd + D",                "select next match (add cursor)",   "vscode multicursor select next match word"},
    {"Cmd + Shift + L",        "select all matches",               "vscode multicursor select all matches"},
    {"Option + click",         "add cursor at click",              "vscode multicursor add click"},
    {"Cmd + Option + ↑ / ↓",   "add cursor above / below",         "vscode multicursor add above below"},
    {"Cmd + L",                "select current line",              "vscode select line current"},
    {"Cmd + A",                "select all",                       "vscode select all"},
    {"Cmd + Shift + K",        "delete line",                      "vscode delete line"},
    {"Cmd + Enter",            "insert line below",                "vscode insert line below"},
    {"Option + ↑ / ↓",         "move line up / down",              "vscode move line up down"},
    {"Shift + Option + ↑ / ↓", "copy line up / down",              "vscode copy line up down duplicate"},
  }},
  {section = "Nvim — motions / edit basics", keys = {
    {":w / :wq / ZZ",          "save / save+quit",                "nvim write save quit"},
    {":q / :q!",                "quit / force quit",              "nvim quit exit discard"},
    {"u / Ctrl + r",           "undo / redo",                     "nvim undo redo"},
    {"/ + term / n / N",       "search forward / next / prev",    "nvim search find next previous"},
    {"gg / G",                 "top / bottom of file",            "nvim go top bottom"},
    {"dd / yy / p",            "delete / yank / paste line",      "nvim delete yank copy paste"},
    {"c + i + w",              "change inner word",               "nvim change inner word"},
    {"v + i + (",              "select inside parens",            "nvim select inside text object"},
  }},
  {section = "Nvim — select / visual mode", keys = {
    {"v",                      "start visual (char) select",       "nvim select visual start begin character"},
    {"V",                      "select whole line (visual line)",  "nvim select line whole entire row visual"},
    {"Ctrl + v",               "block / column / rectangle select","nvim select block column rectangle visual box vertical"},
    {"gg + V + G",             "select all lines in file",         "nvim select all everything entire buffer file whole"},
    {":%y+ / :%y",             "yank / copy all lines to clipboard","nvim copy all yank entire buffer file clipboard"},
    {"V + 5 + j",              "select 5 lines down (N lines)",    "nvim select n lines multiple down linewise"},
    {"V + 5 + k",              "select 5 lines up (N lines)",      "nvim select n lines multiple up linewise"},
    {"v + 5 + w",              "select 5 words forward (N words)", "nvim select n words multiple forward count"},
    {"v + 5 + b",              "select 5 words back (N words)",    "nvim select n words multiple backward count"},
    {"v + i + w",              "select inside word (no spaces)",   "nvim select inner word text object inside"},
    {"v + a + w",              "select around word (with spaces)", "nvim select around word text object whole"},
    {"v + i + p",              "select inside paragraph",          "nvim select inner paragraph text object"},
    {"v + a + p",              "select around paragraph",          "nvim select around paragraph text object"},
    {"v + i + (   v + i + {",  "select inside () or {}",           "nvim select inside parens braces brackets"},
    {"v + i + \"   v + i + '", "select inside quotes",             "nvim select inside quotes string"},
    {"v + i + t",              "select inside HTML/XML tag",       "nvim select inside tag html xml element"},
    {"v + f + X",              "select until char X (inclusive)",  "nvim select until char find forward"},
    {"v + t + X",              "select until char X (exclusive)",  "nvim select till char find forward exclusive"},
    {"v + $ / v + 0",          "select to end / start of line",    "nvim select end start line dollar zero"},
    {"v + gg / v + G",         "select to file top / bottom",      "nvim select top bottom file"},
    {"gv",                     "reselect last visual selection",   "nvim select last previous visual reselect again"},
    {"o (in visual)",          "jump to other end of selection",   "nvim select swap end visual other"},
    {"Esc / v",                "exit visual mode",                 "nvim exit leave visual mode escape"},
  }},
  {section = "Nvim — copy / paste / delete", keys = {
    {"y",                      "yank (copy) selection",            "nvim yank copy selection clipboard visual"},
    {"yy / Y",                 "yank whole line",                  "nvim yank copy line whole"},
    {"5 + y + y",              "yank 5 lines (N lines)",           "nvim yank copy n lines multiple count"},
    {"y + i + w",              "yank inside word",                 "nvim yank copy inner word text object"},
    {"y + a + p",              "yank around paragraph",            "nvim yank copy paragraph"},
    {"d",                      "delete (cut) selection",           "nvim delete cut selection visual"},
    {"dd",                     "delete (cut) whole line",          "nvim delete cut line whole"},
    {"5 + d + d",              "delete 5 lines (N lines)",         "nvim delete cut n lines multiple"},
    {"d + i + w / d + a + w",  "delete inside / around word",      "nvim delete word text object"},
    {"c + i + w / c + a + w",  "change inside / around word",      "nvim change replace word text object"},
    {"x / X",                  "delete char under / before cursor","nvim delete char backspace"},
    {"p / P",                  "paste after / before cursor",      "nvim paste put after before"},
    {"\"+y  /  \"+p",          "yank / paste system clipboard",    "nvim copy paste system clipboard register plus"},
    {"\"+Y  /  \"+yy",         "yank whole line to clipboard",     "nvim copy line clipboard system register"},
  }},
  {section = "Nvim — navigation / motions", keys = {
    {"h / j / k / l",          "left / down / up / right",         "nvim navigate move cursor arrow direction"},
    {"w / b",                  "next / prev word start",           "nvim navigate word forward backward next prev"},
    {"e / ge",                 "next / prev word end",             "nvim navigate word end"},
    {"0 / ^ / $",              "line start / first non-blank / end","nvim navigate line start end column"},
    {"gg / G",                 "top / bottom of file",             "nvim navigate top bottom file"},
    {"5 + G / :5",             "jump to line 5 (N line)",          "nvim goto line number jump specific"},
    {"Ctrl + d / Ctrl + u",    "half-page down / up",              "nvim scroll half page down up"},
    {"Ctrl + f / Ctrl + b",    "full-page forward / back",         "nvim scroll full page forward back"},
    {"zz / zt / zb",           "center / top / bottom scroll line","nvim scroll center top bottom align"},
    {"%",                      "jump to matching bracket",         "nvim jump match bracket brace paren"},
    {"* / #",                  "search word under cursor fwd/back","nvim search word under cursor forward back"},
    {"f + X / F + X",          "find next / prev char X on line",  "nvim find char forward back line"},
    {"; / ,",                  "repeat last f/t / reverse",        "nvim repeat find char forward back"},
    {"m + a  /  ' + a",        "mark a / jump to mark a",          "nvim mark bookmark jump location"},
    {"Ctrl + o / Ctrl + i",    "jump back / forward in history",   "nvim jump history back forward prev next"},
  }},
  {section = "Nvim — edit / replace", keys = {
    {"i / a",                  "insert before / after cursor",     "nvim insert edit mode before after"},
    {"I / A",                  "insert start of line / end",       "nvim insert edit line start end"},
    {"o / O",                  "new line below / above",           "nvim new line below above open"},
    {"r + X",                  "replace char with X",              "nvim replace char single"},
    {"R",                      "enter replace mode (overwrite)",   "nvim replace mode overwrite"},
    {":%s/foo/bar/g",          "replace all foo→bar in file",      "nvim replace substitute find all global file"},
    {":s/foo/bar/g",           "replace all on current line",      "nvim replace substitute line current"},
    {":%s/foo/bar/gc",         "replace with confirm each",        "nvim replace substitute confirm ask prompt"},
    {":'<,'>s/foo/bar/g",      "replace only in visual selection", "nvim replace substitute selection visual range"},
    {"Ctrl + a / Ctrl + x",    "increment / decrement number",     "nvim increment decrement number counter"},
    {">> / <<",                "indent / outdent line",            "nvim indent outdent shift line"},
    {">  (in visual)",         "indent selection",                 "nvim indent shift selection visual"},
    {"= + G",                  "auto-indent to end of file",       "nvim format indent auto file end"},
  }},
  {section = "Nvim — search", keys = {
    {"/ + pattern",            "search forward",                   "nvim search find forward pattern"},
    {"? + pattern",            "search backward",                  "nvim search find backward pattern"},
    {"n / N",                  "next / prev match",                "nvim search next previous match"},
    {":noh",                   "clear search highlight",           "nvim search clear highlight noh"},
    {"space + s + g",          "LazyVim live grep (project)",      "lazyvim grep search project live text"},
    {"space + s + w",          "LazyVim grep word under cursor",   "lazyvim grep word cursor"},
  }},
  {section = "System", keys = {
    {"alt + /",                "open this cheatsheet",             "help shortcuts cheat keybinds guide search"},
    {"alt + shift + r",        "reload SketchyBar",                "reload refresh bar statusbar menubar"},
    {"alt + shift + c",        "reload AeroSpace config",          "reload refresh aerospace config"},
    {"alt + shift + a",        "reassign windows to rule workspaces","fix reassign reorganize rules windows"},
  }},
}

-- Parse aerospace.toml — extract [mode.main.binding] entries w/ preceding comments as section hints
local function parseAerospace()
  local path = os.getenv("HOME").."/.config/aerospace/aerospace.toml"
  local f = io.open(path, "r")
  if not f then return {} end
  local content = f:read("*a")
  f:close()

  local sections = {}
  local current = nil
  local cur_section = "AeroSpace"
  local in_main = false
  local pending_desc = nil

  for line in content:gmatch("([^\r\n]*)[\r\n]") do
    local hdr = line:match("^%s*%[([^%]]+)%]")
    if hdr then
      in_main = (hdr == "mode.main.binding")
      pending_desc = nil
      if in_main then
        cur_section = "AeroSpace"
        current = { section = cur_section, keys = {} }
        table.insert(sections, current)
      else
        current = nil
      end
    elseif in_main then
      local comment = line:match("^%s*#%s*(.-)%s*$")
      if comment and comment ~= "" and not comment:match("^%-+$") and not comment:match("^See:") and not comment:match("^Possible") and not comment:match("^Fallback") then
        if #comment < 50 and not comment:match("%.") then
          cur_section = "AeroSpace — " .. comment
          current = { section = cur_section, keys = {} }
          table.insert(sections, current)
          pending_desc = nil
        else
          pending_desc = comment
        end
      else
        local key, rhs = line:match("^%s*([%w%-%+]+)%s*=%s*(.+)%s*$")
        if key and rhs and current then
          local desc = pending_desc
          if not desc then
            local clean = rhs
              :gsub("^'(.-)'%s*$", "%1")
              :gsub("^%[(.-)%]%s*$", "%1")
              :gsub("exec%-and%-forget%s+", "run: ")
              :gsub("'", "")
              :gsub("osascript.-keystroke \"(%a)\".-down}", "cmd+%1")
            desc = clean:sub(1, 80)
          end
          local display_key = key:gsub("%-", " + ")
          local keywords = (display_key .. " " .. desc .. " " .. cur_section):lower()
          table.insert(current.keys, {display_key, desc, keywords})
          pending_desc = nil
        end
      end
    end
  end

  -- Remove empty sections
  local result = {}
  for _, s in ipairs(sections) do
    if #s.keys > 0 then table.insert(result, s) end
  end
  return result
end

local function buildChoices()
  local all = {}
  for _, s in ipairs(parseAerospace()) do table.insert(all, s) end
  for _, s in ipairs(STATIC)             do table.insert(all, s) end

  local choices = {}
  for _, sec in ipairs(all) do
    for _, kv in ipairs(sec.keys) do
      local key, desc, kw = kv[1], kv[2], (kv[3] or "")
      table.insert(choices, {
        text = desc,
        subText = key .. "   " .. sec.section .. "   " .. kw,
        search = (desc .. " " .. key .. " " .. sec.section .. " " .. kw):lower(),
      })
    end
  end
  return choices
end

local function escape(s)
  return (s:gsub("&","&amp;"):gsub("<","&lt;"):gsub(">","&gt;"):gsub('"',"&quot;"))
end

local function buildHTML()
  local rows = {}
  for _, sec in ipairs(parseAerospace()) do
    for _, kv in ipairs(sec.keys) do
      local key, desc, kw = kv[1], kv[2], (kv[3] or "")
      local search = (desc .. " " .. key .. " " .. sec.section .. " " .. kw):lower()
      table.insert(rows, string.format(
        '<div class="row" data-search="%s"><div class="desc">%s</div><div class="meta"><span class="kbd">%s</span><span class="sec">%s</span></div></div>',
        escape(search), escape(desc), escape(key), escape(sec.section)
      ))
    end
  end
  for _, sec in ipairs(STATIC) do
    for _, kv in ipairs(sec.keys) do
      local key, desc, kw = kv[1], kv[2], (kv[3] or "")
      local search = (desc .. " " .. key .. " " .. sec.section .. " " .. kw):lower()
      table.insert(rows, string.format(
        '<div class="row" data-search="%s"><div class="desc">%s</div><div class="meta"><span class="kbd">%s</span><span class="sec">%s</span></div></div>',
        escape(search), escape(desc), escape(key), escape(sec.section)
      ))
    end
  end
  return [[
<!DOCTYPE html><html><head><meta charset="utf-8"><style>
:root { color-scheme: dark; }
* { box-sizing: border-box; margin: 0; padding: 0; }
html, body {
  background: transparent;
  font-family: -apple-system, BlinkMacSystemFont, "SF Pro Text", sans-serif;
  color: #cdd6f4;
  -webkit-font-smoothing: antialiased;
  overflow: hidden;
}
.panel {
  height: 100vh;
  background: rgba(30,30,46,0.85);
  backdrop-filter: blur(32px) saturate(1.5);
  -webkit-backdrop-filter: blur(32px) saturate(1.5);
  border: 1px solid rgba(205,214,244,0.08);
  border-radius: 16px;
  display: flex; flex-direction: column; overflow: hidden;
}
.search { padding: 16px 18px 12px; border-bottom: 1px solid rgba(205,214,244,0.06); }
input {
  width: 100%; padding: 6px 4px; font-size: 22px;
  background: transparent; color: #cdd6f4; border: 0; outline: 0;
  caret-color: #89b4fa;
}
input::placeholder { color: #6c7086; }
.list { flex: 1; overflow-y: auto; padding: 6px; }
.list::-webkit-scrollbar { width: 0; }
.row {
  display: flex; justify-content: space-between; align-items: center;
  padding: 10px 14px; border-radius: 10px; gap: 14px;
}
.row.active { background: rgba(137,180,250,0.18); }
.row.hidden { display: none; }
.desc { font-size: 14px; color: #cdd6f4; flex: 1; }
.meta { display: flex; gap: 8px; align-items: center; flex-shrink: 0; }
.kbd {
  font-family: "JetBrains Mono", "SF Mono", ui-monospace, monospace;
  font-size: 11px; color: #bac2de;
  background: rgba(205,214,244,0.08); padding: 3px 8px; border-radius: 5px;
}
.sec {
  font-size: 10px; color: #6c7086; text-transform: uppercase;
  letter-spacing: 0.5px;
}
.empty { padding: 40px; text-align: center; color: #6c7086; font-size: 13px; }
</style></head><body>
<div class="panel">
  <div class="search"><input id="q" placeholder="Search keybinds…" autofocus></div>
  <div class="list" id="list">]]..table.concat(rows,"\n")..[[<div class="empty" id="empty" style="display:none">No match</div></div>
</div>
<script>
const q = document.getElementById('q');
const rows = [...document.querySelectorAll('.row')];
const empty = document.getElementById('empty');
let active = 0;
function render() {
  const term = q.value.toLowerCase().trim();
  let vcount = 0;
  rows.forEach(r => {
    const match = !term || term.split(/\s+/).every(w => r.dataset.search.includes(w));
    r.classList.toggle('hidden', !match);
    r.classList.remove('active');
    if (match) vcount++;
  });
  empty.style.display = vcount === 0 ? 'block' : 'none';
  const vis = rows.filter(r => !r.classList.contains('hidden'));
  active = 0;
  if (vis[0]) vis[0].classList.add('active');
}
q.addEventListener('input', render);
document.addEventListener('keydown', e => {
  const vis = rows.filter(r => !r.classList.contains('hidden'));
  if (e.key === 'Escape') { window.location = 'hammerspoon://cheatclose'; return; }
  if (e.key === 'ArrowDown') {
    e.preventDefault();
    vis[active] && vis[active].classList.remove('active');
    active = Math.min(active + 1, vis.length - 1);
    vis[active] && (vis[active].classList.add('active'), vis[active].scrollIntoView({block:'nearest'}));
  }
  if (e.key === 'ArrowUp') {
    e.preventDefault();
    vis[active] && vis[active].classList.remove('active');
    active = Math.max(active - 1, 0);
    vis[active] && (vis[active].classList.add('active'), vis[active].scrollIntoView({block:'nearest'}));
  }
});
setTimeout(() => q.focus(), 20);
render();
</script></body></html>
]]
end

local webview = nil

function M.close()
  if webview then webview:delete(); webview = nil end
end

function M.toggle()
  if webview then M.close(); return end
  local screen = hs.screen.mainScreen():frame()
  local w, h = 680, 480
  local rect = {
    x = screen.x + (screen.w - w) / 2,
    y = screen.y + screen.h * 0.22,
    w = w, h = h,
  }
  webview = hs.webview.new(rect, { developerExtrasEnabled = false })
    :windowStyle({"borderless","closable"})
    :closeOnEscape(true)
    :shadow(true)
    :level(hs.drawing.windowLevels.modalPanel)
    :allowTextEntry(true)
    :transparent(true)
    :bringToFront(true)
    :html(buildHTML())
    :show()
  hs.application.get("Hammerspoon"):activate(true)
  hs.timer.doAfter(0.08, function()
    if webview and webview:hswindow() then
      webview:hswindow():becomeMain()
      webview:hswindow():focus()
      webview:hswindow():raise()
    end
  end)
end

hs.urlevent.bind("cheatclose", function() M.close() end)

return M
