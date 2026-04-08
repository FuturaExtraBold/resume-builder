#!/bin/bash
# build-resume.sh  —  Builds resume, cover letter, and GitHub/LinkedIn assets
#
# USAGE:
#   ./build-resume.sh          → build all (Ben + Litza)
#   ./build-resume.sh --ben    → build Ben's files only
#   ./build-resume.sh --litza  → build Litza's files only

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REF="$SCRIPT_DIR/reference.docx"
PDF_OPTIONS='{"format":"Letter","printBackground":true,"margin":{"top":"0","bottom":"0","left":"0","right":"0"}}'

# Ben's paths
BEN_DIR="$SCRIPT_DIR/ben"
BEN_OUT="$SCRIPT_DIR/output/Ben"
BEN_RESUME="$BEN_DIR/ResumeMaster.md"
BEN_COVER="$BEN_DIR/CoverMaster.md"
BEN_GITHUB="$BEN_DIR/GitHubMaster.md"
BEN_LINKEDIN="$BEN_DIR/LinkedInMaster.txt"
BEN_CSS="$BEN_DIR/resume.css"

# Litza's paths
LITZA_DIR="$SCRIPT_DIR/litza"
LITZA_OUT="$SCRIPT_DIR/output/Litza"
LITZA_RESUME="$LITZA_DIR/ResumeMaster.md"
LITZA_COVER="$LITZA_DIR/CoverMaster.md"
LITZA_CSS="$LITZA_DIR/resume.css"

build_ben() {
  echo "Building Ben..."

  # Resume PDF
  md-to-pdf "$BEN_RESUME" --stylesheet "$BEN_CSS" --pdf-options "$PDF_OPTIONS"
  mv "$BEN_DIR/ResumeMaster.pdf" "$BEN_OUT/Ben-Hays-Resume.pdf"
  echo "  ✓ output/Ben/Ben-Hays-Resume.pdf"

  # Resume DOCX
  pandoc "$BEN_RESUME" --reference-doc="$REF" -o "$BEN_OUT/Ben-Hays-Resume.docx"
  echo "  ✓ output/Ben/Ben-Hays-Resume.docx"

  # Cover Letter PDF
  md-to-pdf "$BEN_COVER" --stylesheet "$BEN_CSS" --pdf-options "$PDF_OPTIONS"
  mv "$BEN_DIR/CoverMaster.pdf" "$BEN_OUT/Ben-Hays-Cover-Letter.pdf"
  echo "  ✓ output/Ben/Ben-Hays-Cover-Letter.pdf"

  # Cover Letter DOCX
  pandoc "$BEN_COVER" --reference-doc="$REF" -o "$BEN_OUT/Ben-Hays-Cover-Letter.docx"
  echo "  ✓ output/Ben/Ben-Hays-Cover-Letter.docx"

  # GitHub README (assembled from ResumeMaster.md + CoverMaster.md + GitHubMaster.md)
  SUMMARY=$(grep '^\*\*Award-winning' "$BEN_RESUME")
  SKILLS=$(awk '/^## SKILLS/{found=1; next} /^## PROJECTS/{exit} found' "$BEN_RESUME" | sed '/^[[:space:]]*$/d')
  LINKS=$(awk '/^Ben$/{found=1; next} found && /^- /{print}' "$BEN_COVER")
  printf '%s\n\n---\n\n### Skills:\n\n%s\n\n' "$SUMMARY" "$SKILLS" > "$BEN_OUT/GitHubREADME.md"
  cat "$BEN_GITHUB" >> "$BEN_OUT/GitHubREADME.md"
  printf '\n---\n\n### Links:\n\n%s\n' "$LINKS" >> "$BEN_OUT/GitHubREADME.md"
  echo "  ✓ output/Ben/GitHubREADME.md"

  # LinkedIn About (intro + skills injected from ResumeMaster.md)
  SKILLS_TMP=$(mktemp)
  INTRO_TMP=$(mktemp)
  awk '/^## SKILLS/{found=1; next} /^## PROJECTS/{exit} found' "$BEN_RESUME" | \
    sed '/^[[:space:]]*$/d' | \
    sed 's/^- \*\*\([^*]*\)\*\*: /• \1: /' | \
    sed 'G' > "$SKILLS_TMP"
  grep '^\*\*Award-winning' "$BEN_RESUME" | sed 's/\*\*//g' > "$INTRO_TMP"
  sed "/{{INTRO}}/{
r $INTRO_TMP
d
}" "$BEN_LINKEDIN" | sed "/{{SKILLS}}/{
r $SKILLS_TMP
d
}" > "$BEN_OUT/LinkedInAbout.txt"
  rm "$SKILLS_TMP" "$INTRO_TMP"
  echo "  ✓ output/Ben/LinkedInAbout.txt"

  echo "Done (Ben)."
}

build_litza() {
  echo "Building Litza..."

  # Resume PDF
  md-to-pdf "$LITZA_RESUME" --stylesheet "$LITZA_CSS" --pdf-options "$PDF_OPTIONS"
  mv "$LITZA_DIR/ResumeMaster.pdf" "$LITZA_OUT/Litza-Hays-Resume.pdf"
  echo "  ✓ output/Litza/Litza-Hays-Resume.pdf"

  # Resume DOCX
  pandoc "$LITZA_RESUME" --reference-doc="$REF" -o "$LITZA_OUT/Litza-Hays-Resume.docx"
  echo "  ✓ output/Litza/Litza-Hays-Resume.docx"

  # Cover Letter PDF
  md-to-pdf "$LITZA_COVER" --stylesheet "$LITZA_CSS" --pdf-options "$PDF_OPTIONS"
  mv "$LITZA_DIR/CoverMaster.pdf" "$LITZA_OUT/Litza-Hays-Cover-Letter.pdf"
  echo "  ✓ output/Litza/Litza-Hays-Cover-Letter.pdf"

  # Cover Letter DOCX
  pandoc "$LITZA_COVER" --reference-doc="$REF" -o "$LITZA_OUT/Litza-Hays-Cover-Letter.docx"
  echo "  ✓ output/Litza/Litza-Hays-Cover-Letter.docx"

  echo "Done (Litza)."
}

case "$1" in
  --ben)   build_ben ;;
  --litza) build_litza ;;
  *)
    build_ben
    build_litza
    ;;
esac
