# gen_tree.py
from pathlib import Path

EXCLUDE_DIRS = {".git", ".github", ".venv", "__pycache__", "node_modules"}
EXCLUDE_FILES = {"gen_tree.py"}

ROOT = Path(__file__).parent
README = ROOT / "README.md"
OUT = ROOT / "repo_tree.md"

def build_tree(path: Path, prefix=""):
    lines = []
    entries = sorted([p for p in path.iterdir()
                      if p.name not in EXCLUDE_FILES and p.name not in EXCLUDE_DIRS],
                     key=lambda p: (p.is_file(), p.name.lower()))
    for i, p in enumerate(entries):
        connector = "└── " if i == len(entries)-1 else "├── "
        lines.append(prefix + connector + p.name)
        if p.is_dir():
            extension = "    " if i == len(entries)-1 else "│   "
            lines.extend(build_tree(p, prefix + extension))
    return lines

def make_md_tree():
    lines = ["```text"]
    lines.append("text")
    lines.extend(build_tree(ROOT))
    lines.append("```")
    return "\n".join(lines)

def update_readme(md_tree: str):
    txt = README.read_text(encoding="utf-8")
    start = "<!-- BEGIN REPO TREE -->"
    end = "<!-- END REPO TREE -->"
    new = f"{start}\n<!-- autogen: do not edit inside this block -->\n{md_tree}\n{end}"
    import re
    updated = re.sub(rf"{start}.*?{end}", new, txt, flags=re.S)
    README.write_text(updated, encoding="utf-8")

def main():
    md_tree = make_md_tree()
    OUT.write_text(md_tree, encoding="utf-8")
    update_readme(md_tree)
    print("Repo tree updated.")

if __name__ == "__main__":
    main()
