from pypdf import PdfReader, PdfWriter

def set_pdf_metadata(input_path, output_path, title, author="Chris Galvez", subject="Resume"):
    reader = PdfReader(input_path)
    writer = PdfWriter()

    # Copy all pages
    for page in reader. pages:
        writer.add_page(page)

    # Add metadata
    writer.add_metadata({
        "/Title": title,
        "/Author": author,
        "/Subject": subject,
        "/Creator": "Chris Galvez Resume Builder",
        "/Producer": "pypdf"
    })

    # Save new PDF
    with open(output_path, "wb") as f:
        writer.write(f)

if __name__ == "__main__":
    # Example for ATS-safe
    set_pdf_metadata(
        "Chris_Galvez_Resume_FINAL.pdf",
        "Chris_Galvez_Resume_FINAL_updated.pdf",
        "Chris Galvez — Resume (ATS)"
    )

    # Example for Color version
    set_pdf_metadata(
        "alt_versions/Chris_Galvez_Resume_COLOR.pdf",
        "alt_versions/Chris_Galvez_Resume_COLOR_updated.pdf",
        "Chris Galvez — Resume (Color)"
    )
