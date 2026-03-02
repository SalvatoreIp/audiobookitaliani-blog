#!/bin/bash
cd /home/salvatore/audiobookitaliani-blog
hugo --gc --minify && echo "✅ HUGO OK!" && ls -la public/libri/ | grep ghiaccio
