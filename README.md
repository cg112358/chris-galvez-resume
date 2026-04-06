# Christopher “Chris” Galvez — Resume

This repository contains the source, build pipeline, and published versions of my technical resume.

The resume is written in Markdown and automatically converted into polished PDFs for ATS systems and recruiter viewing.

---

## 🌐 Live Resume Hub

https://cg112358.github.io/

This GitHub Pages site is the canonical ResumeHub entry point for viewing my resume and portfolio.

The repository here focuses on the resume source, build pipeline, and generated artifacts.

---

## 📄 Resume Downloads

- **ATS Resume (PDF):**
  https://cg112358.github.io/chris-galvez-resume/Chris_Galvez_Resume_FINAL.pdf

- **Color Resume (PDF):**
  https://cg112358.github.io/chris-galvez-resume/alt_versions/Chris_Galvez_Resume_COLOR.pdf

---

## 🔗 Professional Links

- LinkedIn
  https://www.linkedin.com/in/christopher-galvez-98bb5333b

- GitHub Portfolio
  https://github.com/cg112358

- Crypto Price Tracker (Python, React, CoinGecko API)
  https://github.com/cg112358/crypto-price-tracker

---

## ⚙️ Resume Build Workflow

**Generate updated PDFs:**

```bash
./build_pdfs.bat
```

Promote the generated PDF from the gitignored output/ directory to the repository root:

`cp output/Chris_Galvez_Resume_FINAL.pdf .`

## Repository structure

<!-- BEGIN REPO TREE -->
<!-- autogen: do not edit inside this block -->
```text
chris-galvez-resume
├── alt_versions
│   └── Chris_Galvez_Resume_COLOR.pdf
├── docs
├── output
│   └── Chris_Galvez_Resume_FINAL.pdf
├── tex_includes
│   ├── color_headers.tex
│   ├── margins.tex
│   └── typography.tex
├── tools
│   ├── build_pdfs_ps.ps1
│   ├── fix_pdf_metadata.py
│   ├── preview_pdfs.ps1
│   └── strip_emoji.py
├── build_pdfs.bat
├── build_pdfs.sh
├── Chris_Galvez_Resume.md
├── Chris_Galvez_Resume_FINAL.pdf
├── fix_pdf_metadata.py
├── README.md
└── requirements.txt
```
<!-- END REPO TREE -->
