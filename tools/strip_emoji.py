# tools/strip_emoji.py
# Usage: python tools/strip_emoji.py IN.md OUT.md
import re, sys, pathlib

if len(sys.argv) != 3:
    print("Usage: python tools/strip_emoji.py IN.md OUT.md")
    sys.exit(1)

src = pathlib.Path(sys.argv[1]).read_text(encoding="utf-8")

# Remove common emoji & symbols that LaTeX lacks by default (keep ASCII clean for ATS)
emoji_rx = re.compile(
    "[\U0001F300-\U0001FAFF"  # symbols & pictographs, supplemental symbols & pictographs, etc.
    "\U00002700-\U000027BF"   # dingbats
    "\U00002600-\U000026FF"   # misc symbols
    "\U0001F1E6-\U0001F1FF"   # flags
    "\U000024C2-\U0001F251"   # enclosed characters
    "\u200d"                  # ZWJ
    "\ufe0e\ufe0f"            # VS15/VS16
    "]", flags=re.UNICODE
)

clean = emoji_rx.sub("", src)

# Normalize a few “smart” characters to keep it machine-readable
clean = clean.replace("•", "- ").replace("–", "-").replace("—", "-").replace("’", "'").replace("“", '"').replace("”", '"')

pathlib.Path(sys.argv[2]).write_text(clean, encoding="utf-8")
