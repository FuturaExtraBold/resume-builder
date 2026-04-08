# Resume

Single source of truth for resume, cover letter, GitHub README, and LinkedIn About generation.

**Ben** (`ben/`) — resume, cover letter, GitHub README, LinkedIn About
**Litza** (`litza/`) — resume and cover letter

## Setup

Install dependencies once:

```bash
npm install -g md-to-pdf
brew install pandoc
pip3 install python-docx --break-system-packages
```

Download local Inter fonts (required for clean PDF text encoding):

```bash
mkdir -p fonts
curl -s "https://fonts.gstatic.com/s/inter/v20/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuLyfMZg.ttf" -o fonts/Inter-400.ttf
curl -s "https://fonts.gstatic.com/s/inter/v20/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuI6fMZg.ttf" -o fonts/Inter-500.ttf
curl -s "https://fonts.gstatic.com/s/inter/v20/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuGKYMZg.ttf" -o fonts/Inter-600.ttf
curl -s "https://fonts.gstatic.com/s/inter/v20/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuFuYMZg.ttf" -o fonts/Inter-700.ttf
```

## Build

```bash
./build-resume.sh          # build all (Ben + Litza)
./build-resume.sh --ben    # Ben only
./build-resume.sh --litza  # Litza only
```

**Ben outputs** (`output/Ben/`):
- `Ben-Hays-Resume.pdf` / `Ben-Hays-Resume.docx`
- `Ben-Hays-Cover-Letter.pdf` / `Ben-Hays-Cover-Letter.docx`
- `GitHubREADME.md`
- `LinkedInAbout.txt`

**Litza outputs** (`output/Litza/`):
- `Litza-Hays-Resume.pdf` / `Litza-Hays-Resume.docx`
- `Litza-Hays-Cover-Letter.pdf` / `Litza-Hays-Cover-Letter.docx`

## Files

| File                        | Purpose                                        |
| --------------------------- | ---------------------------------------------- |
| `ben/ResumeMaster.md`       | Ben's resume source — edit this               |
| `ben/CoverMaster.md`        | Ben's cover letter template — edit this       |
| `ben/GitHubMaster.md`       | Ben's GitHub README static sections           |
| `ben/LinkedInMaster.txt`    | Ben's LinkedIn About source                   |
| `ben/resume.css`            | Ben's PDF styles                              |
| `litza/ResumeMaster.md`     | Litza's resume source — edit this             |
| `litza/CoverMaster.md`      | Litza's cover letter template — edit this     |
| `litza/resume.css`          | Litza's PDF styles                            |
| `reference.docx`            | Shared DOCX style template                    |
| `style-reference.py`        | Script that applies styles to `reference.docx`|
| `build-resume.sh`           | Build script                                  |
| `fonts/`                    | Local Inter TTF files (not tracked in git)    |
| `output/`                   | Generated files (not tracked in git)          |

## Modifying styles

**PDF** — edit `ben/resume.css` or `litza/resume.css`, then rebuild.

**DOCX** — edit `style-reference.py`, then run:

```bash
python3 style-reference.py
./build-resume.sh
```

## Workflow

**Ben**
- Job applications — `output/Ben/Ben-Hays-Resume.docx` + `output/Ben/Ben-Hays-Cover-Letter.docx` (ATS-safe)
- Portfolio / outreach — `output/Ben/Ben-Hays-Resume.pdf` + `output/Ben/Ben-Hays-Cover-Letter.pdf`
- GitHub profile — copy `output/Ben/GitHubREADME.md` to GitHub profile repo as `README.md`
- LinkedIn — paste `output/Ben/LinkedInAbout.txt` into LinkedIn About section

**Litza**
- Job applications — `output/Litza/Litza-Hays-Resume.docx` + `output/Litza/Litza-Hays-Cover-Letter.docx` (ATS-safe)
- Portfolio / outreach — `output/Litza/Litza-Hays-Resume.pdf` + `output/Litza/Litza-Hays-Cover-Letter.pdf`
