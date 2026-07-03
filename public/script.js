(function () {
  "use strict";

  var target = document.getElementById("typewriter");
  var cursor = document.getElementById("cursor");
  if (!target) return;

  var reduceMotion = window.matchMedia("(prefers-reduced-motion: reduce)").matches;

  var script = [
    { text: "$ node bin/zen.js run server.zen", pause: 500 },
    { text: "Zen listening on :8080", pause: 700 },
    { text: "", pause: 300 },
    { text: "$ curl http://localhost:8080/", pause: 500 },
    { text: "HTTP/1.1 200 OK", pause: 120 },
    { text: "Content-Type: text/html; charset=UTF-8", pause: 900 }
  ];

  function fullText() {
    return script.map(function (line) { return line.text; }).join("\n");
  }

  if (reduceMotion) {
    target.textContent = fullText();
    if (cursor) cursor.style.display = "none";
    return;
  }

  var lineIndex = 0;
  var charIndex = 0;
  var buffer = "";

  function tick() {
    if (lineIndex >= script.length) {
      return; // done, leave cursor blinking
    }

    var line = script[lineIndex];

    if (charIndex < line.text.length) {
      buffer += line.text.charAt(charIndex);
      charIndex++;
      target.textContent = buffer;
      window.setTimeout(tick, 18 + Math.random() * 22);
    } else {
      buffer += "\n";
      target.textContent = buffer;
      lineIndex++;
      charIndex = 0;
      window.setTimeout(tick, line.pause || 300);
    }
  }

  window.setTimeout(tick, 400);
})();

