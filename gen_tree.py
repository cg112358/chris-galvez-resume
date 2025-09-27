# gen_tree.py
from pathlib import Path
import re

ROOT = Path(__file__).parent
README = ROOT / "README.md"
OUT = ROOT / "repo_tree.md"

EXCLUDE_DIRS = {".git", ".github", ".venv", "__pycache__", "node_modules"}
EXCLUDE_FILES = {".DS_Store", ".gitignore", "gen_tree.py", "repo_tree.md"}

def build_tree(path: Path, prefix=""):
    lines = []
    # folders first (alpha), then files (alpha)
    entries = sorted(
        [p for p in path.iterdir()
         if p.name not in EXCLUDE_FILES and p.name not in EXCLUDE_DIRS],
        key=lambda p: (p.is_file(), p.name.lower())
    )
    for i, p in enumerate(entries):
        elbow = "└── " if i == len(entries) - 1 else "├── "
        lines.append(prefix + elbow + p.name)
        if p.is_dir():
            more = "    " if i == len(entries) - 1 else "│   "
            lines.extend(build_tree(p, prefix + more))
    return lines

def make_md_tree():
    body = ["```text", "text"]
    body.extend(build_tree(ROOT))
    body.append("```")
    return "\n".join(body)

def ensure_block_in_readme(readme_text: str, md_tree: str) -> str:
    start = "<!-- BEGIN REPO TREE -->"
    end = "<!-- END REPO TREE -->"
    payload = f"""{start}
<!-- autogen: do not edit inside this block -->
{md_tree}
{end}"""
    if start in readme_text and end in readme_text:
        return re.sub(rf"{start}.*?{end}", payload, readme_text, flags=re.S)
    else:
        # If markers not present, append a fresh section at the end
        return readme_text.rstrip() + "\n\n## Repository structure\n\n" + payload + "\n"

def main():
    md_tree = make_md_tree()
    OUT.write_text(md_tree, encoding="utf-8")

    readme = README.read_text(encoding="utf-8")
    updated = ensure_block_in_readme(readme, md_tree)
    README.write_text(updated, encoding="utf-8")

    print("Repo tree updated in README.md and repo_tree.md")

if __name__ == "__main__":
    main()
