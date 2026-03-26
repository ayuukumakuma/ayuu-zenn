_:
  @just --list

new:
  pnpm exec zenn new:article --publication-name smartcamp --published true
  just create-image-dir

preview:
  pnpm exec zenn preview --open
alias p := preview

create-image-dir:
  #!/usr/bin/env bash
  article_path=$(ls -t articles/*.md | head -n 1)
  article_id=$(basename "$article_path" .md)
  mkdir -p "images/$article_id"
  echo "Created directory: images/$article_id"

textlint file:
  pnpm textlint {{file}}
alias tl := textlint
