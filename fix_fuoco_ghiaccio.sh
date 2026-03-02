#!/bin/bash
cd /home/salvatore/audiobookitaliani-blog/content/libri
file="2026-03-01T10:10:27Z-fuoco-e-ghiaccio.md"

# Fix YAML frontmatter
sed -i "s|cover: image: '/images/covers/fuoco-e-ghiaccio.jpg' alt: 'Copertina Fuoco e Ghiaccio'|cover: '/images/covers/fuoco-e-ghiaccio.jpg'|" "$file"

echo "✅ Frontmatter fixato!"
hugo --gc --minify || echo "❌ Errore ancora"
ls -la public/libri/ | grep ghiaccio || echo "File non generato"
