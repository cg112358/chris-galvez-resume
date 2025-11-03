# tools/fix_pdf_metadata.py
"""
Overwrite PDF metadata in place using pypdf (no *_fixed.pdf copies).
Usage:
  python tools/fix_pdf_metadata.py PATH/TO/file.pdf --title "New Title" --author "Your Name" --subject "Resume" --keywords "keyword1, keyword2"
"""

import argparse
import shutil
import tempfile
from pathlib import Path
from pypdf import PdfReader, PdfWriter

def fix_inplace(pdf_path: Path, title=None, author=None, subject=None, keywords=None):
    pdf_path = pdf_path.resolve()
    tmp_dir = pdf_path.parent
    with tempfile.NamedTemporaryFile(dir=tmp_dir, delete=False, suffix=".pdf") as tmp:
        tmp_path = Path(tmp.name)

    reader = PdfReader(str(pdf_path))
    writer = PdfWriter()

    # Copy pages
    for page in reader.pages:
        writer.add_page(page)

    # Start from existing metadata (if any), then update
    meta = {}
    if reader.metadata:
        # pypdf uses keys like '/Title'—normalize to strings
        for k, v in reader.metadata.items():
            if v is not None:
                meta[str(k)] = str(v)

    if title is not None:   meta["/Title"] = title
    if author is not None:  meta["/Author"] = author
    if subject is not None: meta["/Subject"] = subject
    if keywords is not None:
        # PDF uses a single Keywords string
        if isinstance(keywords, (list, tuple)):
            meta["/Keywords"] = ", ".join(map(str, keywords))
        else:
            meta["/Keywords"] = str(keywords)

    writer.add_metadata(meta)

    # Write to temp, then replace original atomically
    with open(tmp_path, "wb") as f:
        writer.write(f)

    shutil.move(str(tmp_path), str(pdf_path))

def parse_args():
    ap = argparse.ArgumentParser()
    ap.add_argument("pdf", type=Path)
    ap.add_argument("--title")
    ap.add_argument("--author")
    ap.add_argument("--subject")
    ap.add_argument("--keywords", help="Comma-separated list")
    return ap.parse_args()

def main():
    args = parse_args()
    kws = None
    if args.keywords:
        # allow either a single string or comma list
        kws = [x.strip() for x in args.keywords.split(",")] if "," in args.keywords else args.keywords
    fix_inplace(args.pdf, title=args.title, author=args.author, subject=args.subject, keywords=kws)

if __name__ == "__main__":
    main()
