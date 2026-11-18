"""Combined PDF of all figures, each followed by its legend.

Usage: python3 tools/make_figures_pdf.py manuscript/figure_legends.md manuscript/PRINCE_figures_with_legends.pdf
Reads the markdown legends file (image line followed by its legend paragraph(s)); images are resolved
relative to that file. Needs the python package reportlab; uses the Arial fonts shipped with macOS when
available (Helvetica otherwise).
"""
import os, re, sys
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import ParagraphStyle
from reportlab.lib.units import mm
from reportlab.lib.utils import ImageReader
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Image, PageBreak
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.lib.fonts import addMapping

SRC, OUT = sys.argv[1], sys.argv[2]
BASE = os.path.dirname(os.path.abspath(SRC))

font = "Helvetica"
fd = "/System/Library/Fonts/Supplemental"
if os.path.exists(os.path.join(fd, "Arial.ttf")):
    for name, f in [("Arial", "Arial.ttf"), ("Arial-Bold", "Arial Bold.ttf"),
                    ("Arial-Italic", "Arial Italic.ttf"), ("Arial-BoldItalic", "Arial Bold Italic.ttf")]:
        pdfmetrics.registerFont(TTFont(name, os.path.join(fd, f)))
    addMapping("Arial", 0, 0, "Arial"); addMapping("Arial", 1, 0, "Arial-Bold")
    addMapping("Arial", 0, 1, "Arial-Italic"); addMapping("Arial", 1, 1, "Arial-BoldItalic")
    font = "Arial"

body = ParagraphStyle("body", fontName=font, fontSize=8.6, leading=11.2, spaceAfter=5)
h1 = ParagraphStyle("h1", fontName=font, fontSize=17, leading=21, spaceAfter=10)
h2 = ParagraphStyle("h2", fontName=font, fontSize=12.5, leading=16, spaceAfter=8)

SUP = {"⁴": "4", "⁺": "+", "⁻": "−", "²": "2"}
SUB = {"₀": "0", "₁": "1", "₂": "2"}

def markup(s):
    s = s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
    s = re.sub(r"`([^`]+)`", r"\1", s)
    s = re.sub(r"\*\*(.+?)\*\*", r"<b>\1</b>", s)
    s = re.sub(r"(?<![\w*])\*(?!\s)(.+?)(?<!\s)\*(?![\w*])", r"<i>\1</i>", s)
    s = re.sub("[" + "".join(SUP) + "]+", lambda m: "<super>" + "".join(SUP[c] for c in m.group(0)) + "</super>", s)
    s = re.sub("[" + "".join(SUB) + "]+", lambda m: "<sub>" + "".join(SUB[c] for c in m.group(0)) + "</sub>", s)
    return s

doc = SimpleDocTemplate(OUT, pagesize=A4, leftMargin=16 * mm, rightMargin=16 * mm, topMargin=14 * mm,
                        bottomMargin=14 * mm, title="PRINCE figures and legends", author="Ramyar Molania")
FW, FH = doc.width, doc.height
story = []
blocks = [b.strip() for b in open(SRC, encoding="utf-8").read().split("\n\n") if b.strip()]
i = 0
while i < len(blocks):
    b = blocks[i]
    if b.startswith("# "):
        story.append(Paragraph(markup(b[2:]), h1))
    elif b.startswith("## "):                       # each section starts on a new page
        story.append(PageBreak()); story.append(Paragraph(markup(b[3:]), h2))
    elif b.startswith("!["):
        path = os.path.join(BASE, re.search(r"\]\(([^)]+)\)", b).group(1))
        iw, ih = ImageReader(path).getSize()
        sc = min(FW / iw, (FH - 30 * mm) / ih)
        if not (isinstance(story[-1], Paragraph) and story[-1].style is h2):
            story.append(PageBreak())                  # one figure per page, legend below (continuing if long)
        story.append(Image(path, width=iw * sc, height=ih * sc)); story.append(Spacer(1, 4 * mm))
        i += 1
        while i < len(blocks) and not blocks[i].startswith(("!", "#")):   # legend paragraph(s)
            story.append(Paragraph(markup(blocks[i]), body)); i += 1
        continue
    else:
        story.append(Paragraph(markup(b), body))
    i += 1

def footer(c, d):
    c.saveState(); c.setFont(font, 7.5); c.drawRightString(A4[0] - 16 * mm, 8 * mm, str(d.page)); c.restoreState()

doc.build(story, onFirstPage=footer, onLaterPages=footer)
print("wrote", OUT)
