"""
style-reference.py
Styles reference.docx to match resume.css visually while keeping ATS-safe named styles.
Run once: python3 style-reference.py
"""

from docx import Document
from docx.shared import Pt, RGBColor, Inches
from docx.enum.text import WD_ALIGN_PARAGRAPH
from docx.oxml.ns import qn
from docx.oxml import OxmlElement
import copy

FONT = "Inter"
DOC_PATH = "reference.docx"

doc = Document(DOC_PATH)

# --- Page margins ---
for section in doc.sections:
    section.top_margin    = Inches(0.5)
    section.bottom_margin = Inches(0.5)
    section.left_margin   = Inches(0.5)
    section.right_margin  = Inches(0.5)

def set_font(run_or_font, name, size_pt, bold=False, color_hex=None):
    f = run_or_font if hasattr(run_or_font, 'name') else run_or_font.font
    f.name  = name
    f.size  = Pt(size_pt)
    f.bold  = bold
    if color_hex:
        r = int(color_hex[0:2], 16)
        g = int(color_hex[2:4], 16)
        b = int(color_hex[4:6], 16)
        f.color.rgb = RGBColor(r, g, b)

def add_bottom_border(paragraph, color_hex="e5e5e5", size=4):
    """Add a bottom border to a paragraph (used for section headers)."""
    pPr = paragraph._p.get_or_add_pPr()
    pBdr = OxmlElement('w:pBdr')
    bottom = OxmlElement('w:bottom')
    bottom.set(qn('w:val'), 'single')
    bottom.set(qn('w:sz'), str(size))
    bottom.set(qn('w:space'), '1')
    bottom.set(qn('w:color'), color_hex)
    pBdr.append(bottom)
    pPr.append(pBdr)

def set_spacing(style, before_pt=0, after_pt=0, line=None):
    pPr = style.paragraph_format
    pPr.space_before = Pt(before_pt)
    pPr.space_after  = Pt(after_pt)
    if line:
        from docx.shared import Length
        pPr.line_spacing = line

def style_exists(doc, name):
    return any(s.name == name for s in doc.styles)

# --- Normal (body / bullets) ---
normal = doc.styles['Normal']
set_font(normal.font, FONT, 9, color_hex="1a1a1a")
set_spacing(normal, before_pt=0, after_pt=2)
normal.paragraph_format.line_spacing = Pt(13)

# --- Heading 1 — Name ---
h1 = doc.styles['Heading 1']
set_font(h1.font, FONT, 24, bold=True, color_hex="111111")
set_spacing(h1, before_pt=0, after_pt=1)
h1.font.all_caps = False
h1.paragraph_format.keep_with_next = True

# --- Heading 2 — Section headers (SKILLS, EXPERIENCE, etc.) ---
h2 = doc.styles['Heading 2']
set_font(h2.font, FONT, 9, bold=True, color_hex="888888")
h2.font.all_caps = True
set_spacing(h2, before_pt=14, after_pt=6)
h2.paragraph_format.keep_with_next = True

# --- Heading 3 — Company name ---
h3 = doc.styles['Heading 3']
set_font(h3.font, FONT, 11, bold=True, color_hex="111111")
h3.font.all_caps = False
set_spacing(h3, before_pt=10, after_pt=1)
h3.paragraph_format.keep_with_next = True

# --- Heading 4 — Job title + date ---
h4 = doc.styles['Heading 4']
set_font(h4.font, FONT, 9.5, bold=False, color_hex="555555")
h4.font.all_caps = False
set_spacing(h4, before_pt=0, after_pt=4)
h4.paragraph_format.keep_with_next = True

# --- List Bullet / List Paragraph ---
for style_name in ('List Bullet', 'List Paragraph', 'List Bullet 2'):
    if style_exists(doc, style_name):
        s = doc.styles[style_name]
        set_font(s.font, FONT, 9, color_hex="1a1a1a")
        set_spacing(s, before_pt=0, after_pt=2)

doc.save(DOC_PATH)
print("reference.docx styled.")
