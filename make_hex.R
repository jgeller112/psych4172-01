library(hexSticker)
library(magick)
library(sysfonts)
library(showtext)

# ── Font setup ──
tryCatch({
  font_add_google("Source Sans 3", "sourcesans")
}, error = function(e) {
  font_add("sourcesans", regular = "/System/Library/Fonts/Helvetica.ttc")
})
showtext_auto()

# ── Create brain SVG (just the brain, no extra labels) ──
brain_svg <- '
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 220" width="200" height="220">
  <defs>
    <linearGradient id="brainGrad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:#FFFFFF;stop-opacity:1"/>
      <stop offset="100%" style="stop-color:#DBCBA0;stop-opacity:0.9"/>
    </linearGradient>
    <filter id="glow">
      <feGaussianBlur stdDeviation="3" result="blur"/>
      <feComposite in="SourceGraphic" in2="blur" operator="over"/>
    </filter>
  </defs>

  <!-- Brain body centered at 100,95 -->
  <g transform="translate(100,95) scale(1.6)" filter="url(#glow)">
    <!-- Left hemisphere -->
    <path d="M -2,-48 C -8,-50 -18,-50 -26,-46 C -34,-42 -40,-34 -44,-24
             C -48,-14 -50,-4 -48,6 C -52,8 -56,14 -56,22
             C -56,30 -52,36 -48,40 C -48,46 -44,52 -36,54
             C -30,56 -22,56 -16,54 C -12,56 -6,56 -2,54"
          fill="url(#brainGrad)" fill-opacity="0.95" stroke="#DBCBA0" stroke-width="1"/>
    <!-- Right hemisphere -->
    <path d="M 2,-48 C 8,-50 18,-50 26,-46 C 34,-42 40,-34 44,-24
             C 48,-14 50,-4 48,6 C 52,8 56,14 56,22
             C 56,30 52,36 48,40 C 48,46 44,52 36,54
             C 30,56 22,56 16,54 C 12,56 6,56 2,54"
          fill="url(#brainGrad)" fill-opacity="0.9" stroke="#DBCBA0" stroke-width="1"/>
    <!-- Fissure -->
    <line x1="0" y1="-48" x2="0" y2="54" stroke="#98002E" stroke-width="1.2" stroke-opacity="0.5"/>
    <!-- Sulci - left -->
    <path d="M -2,-20 C -14,-18 -26,-12 -38,-2" fill="none" stroke="#98002E" stroke-width="1" stroke-opacity="0.45"/>
    <path d="M -2,4 C -12,6 -24,10 -36,18" fill="none" stroke="#98002E" stroke-width="1" stroke-opacity="0.45"/>
    <path d="M -2,26 C -10,28 -22,32 -34,38" fill="none" stroke="#98002E" stroke-width="1" stroke-opacity="0.45"/>
    <path d="M -16,-44 C -22,-36 -28,-26 -30,-18" fill="none" stroke="#98002E" stroke-width="0.8" stroke-opacity="0.3"/>
    <path d="M -40,-14 C -44,-4 -48,8 -46,18" fill="none" stroke="#98002E" stroke-width="0.8" stroke-opacity="0.3"/>
    <!-- Sulci - right -->
    <path d="M 2,-20 C 14,-18 26,-12 38,-2" fill="none" stroke="#98002E" stroke-width="1" stroke-opacity="0.45"/>
    <path d="M 2,4 C 12,6 24,10 36,18" fill="none" stroke="#98002E" stroke-width="1" stroke-opacity="0.45"/>
    <path d="M 2,26 C 10,28 22,32 34,38" fill="none" stroke="#98002E" stroke-width="1" stroke-opacity="0.45"/>
    <path d="M 16,-44 C 22,-36 28,-26 30,-18" fill="none" stroke="#98002E" stroke-width="0.8" stroke-opacity="0.3"/>
    <path d="M 40,-14 C 44,-4 48,8 46,18" fill="none" stroke="#98002E" stroke-width="0.8" stroke-opacity="0.3"/>
    <!-- Brain stem -->
    <path d="M -6,54 C -6,60 -4,66 0,70 C 4,66 6,60 6,54"
          fill="url(#brainGrad)" fill-opacity="0.9" stroke="#DBCBA0" stroke-width="1"/>
    <!-- Neural nodes -->
    <circle cx="-20" cy="-30" r="2.5" fill="#BC9B6A" opacity="0.8"/>
    <circle cx="22" cy="-28" r="2.5" fill="#BC9B6A" opacity="0.8"/>
    <circle cx="-32" cy="8" r="2" fill="#BC9B6A" opacity="0.7"/>
    <circle cx="34" cy="10" r="2" fill="#BC9B6A" opacity="0.7"/>
    <circle cx="-14" cy="40" r="2" fill="#BC9B6A" opacity="0.7"/>
    <circle cx="16" cy="42" r="2" fill="#BC9B6A" opacity="0.7"/>
    <circle cx="0" cy="-36" r="2" fill="#BC9B6A" opacity="0.8"/>
    <!-- Neural connections -->
    <line x1="-20" y1="-30" x2="0" y2="-36" stroke="#BC9B6A" stroke-width="0.7" opacity="0.5"/>
    <line x1="0" y1="-36" x2="22" y2="-28" stroke="#BC9B6A" stroke-width="0.7" opacity="0.5"/>
    <line x1="-20" y1="-30" x2="-32" y2="8" stroke="#BC9B6A" stroke-width="0.7" opacity="0.5"/>
    <line x1="22" y1="-28" x2="34" y2="10" stroke="#BC9B6A" stroke-width="0.7" opacity="0.5"/>
    <line x1="-32" y1="8" x2="-14" y2="40" stroke="#BC9B6A" stroke-width="0.7" opacity="0.5"/>
    <line x1="34" y1="10" x2="16" y2="42" stroke="#BC9B6A" stroke-width="0.7" opacity="0.5"/>
    <line x1="-14" y1="40" x2="16" y2="42" stroke="#BC9B6A" stroke-width="0.7" opacity="0.5"/>
  </g>
</svg>'

# Write brain SVG and convert to transparent PNG
svg_path <- "images/brain_only.svg"
png_path <- "images/brain_only.png"
writeLines(brain_svg, svg_path)

brain_img <- image_read_svg(svg_path, width = 600)
image_write(brain_img, png_path, format = "png")

# ── Build hex sticker ──
sticker(
  subplot   = png_path,
  s_x       = 1,
  s_y       = 1.15,
  s_width   = 0.85,
  s_height  = 0.85,

  package   = "REPLICABLE &\nREPRODUCIBLE",
  p_size    = 6,
  p_color   = "#FFFFFF",
  p_family  = "sourcesans",
  p_fontface = "bold",
  p_y       = 0.45,
  p_x       = 1,

  h_fill    = "#98002E",
  h_color   = "#BC9B6A",
  h_size    = 2,

  spotlight = TRUE,
  l_x       = 1,
  l_y       = 1.3,
  l_width   = 3,
  l_height  = 3,
  l_alpha   = 0.12,

  url       = "PSYC4172-01 · Boston College",
  u_size    = 4,
  u_color   = "#BC9B6A",
  u_family  = "sourcesans",
  u_x       = 1,
  u_y       = 0.08,

  filename  = "images/hex-sticker.png",
  dpi       = 600
)

cat("Hex sticker saved to images/hex-sticker.png\n")
