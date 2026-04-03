# Resume

Single source of truth: `ResumeMaster.md` → `output/Ben-Hays-Resume.pdf` + `output/Ben-Hays-Resume.docx`

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

Outputs both files to `output/`.

## Watch mode

```bash
./build-resume.sh --watch
```

Rebuilds on every save to `ResumeMaster.md` or `resume.css`. `Ctrl+C` to stop.

## Files

| File                 | Purpose                                        |
| -------------------- | ---------------------------------------------- |
| `ResumeMaster.md`    | Source of truth — edit this                    |
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

- **Job applications** — upload `output/Ben-Hays-Resume.docx` (ATS-safe)
- **Human eyes / portfolio / cold outreach** — share `output/Ben-Hays-Resume.pdf`
