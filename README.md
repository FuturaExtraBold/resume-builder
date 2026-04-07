# Resume

Single source of truth for resume, cover letter, and GitHub README generation.

- `ResumeMaster.md` → `output/Ben-Hays-Resume.pdf` + `output/Ben-Hays-Resume.docx`
- `CoverMaster.md` → `output/Ben-Hays-Cover-Letter.pdf` + `output/Ben-Hays-Cover-Letter.docx`
- `ResumeMaster.md` + `CoverMaster.md` + `GitHubMaster.md` → `output/GitHubREADME.md`

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
./build-resume.sh
```

Outputs five files to `output/`:
- `Ben-Hays-Resume.pdf` / `Ben-Hays-Resume.docx`
- `Ben-Hays-Cover-Letter.pdf` / `Ben-Hays-Cover-Letter.docx`
- `GitHubREADME.md`

## Watch mode

```bash
./build-resume.sh --watch
```

Rebuilds on every save to `ResumeMaster.md`, `CoverMaster.md`, `GitHubMaster.md`, or `resume.css`. `Ctrl+C` to stop.

## Files

| File                 | Purpose                                        |
| -------------------- | ---------------------------------------------- |
| `ResumeMaster.md`    | Resume source of truth — edit this             |
| `CoverMaster.md`     | Cover letter template — edit this              |
| `GitHubMaster.md`    | GitHub README static sections — edit this      |
| `resume.css`         | PDF visual styles                              |
| `reference.docx`     | DOCX style template                            |
| `style-reference.py` | Script that applies styles to `reference.docx` |
| `build-resume.sh`    | Build script                                   |
| `fonts/`             | Local Inter TTF files (not tracked in git)     |
| `output/`            | Generated files (not tracked in git)           |

## Modifying styles

**PDF** — edit `resume.css`, then rebuild.

**DOCX** — edit `style-reference.py`, then run:

```bash
python3 style-reference.py
./build-resume.sh
```

## Workflow

- **Job applications** — upload `output/Ben-Hays-Resume.docx` + `output/Ben-Hays-Cover-Letter.docx` (ATS-safe)
- **Human eyes / portfolio / cold outreach** — share `output/Ben-Hays-Resume.pdf` + `output/Ben-Hays-Cover-Letter.pdf`
- **GitHub profile** — copy `output/GitHubREADME.md` to your GitHub profile repo as `README.md`
