new:
  npx zenn new:article --publication-name smartcamp --published true
  just create-image-dir

create-image-dir:
  #!/usr/bin/env bash
  article_path=$(ls -t articles/*.md | head -n 1)
  article_id=$(basename "$article_path" .md)
  mkdir -p "images/$article_id"
  echo "Created directory: images/$article_id"
