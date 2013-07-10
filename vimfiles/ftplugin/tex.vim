noremap <F5> <ESC>:silent !pdflatex %:t<CR>
noremap <F6> <ESC>:silent !biber %:r<CR>
noremap <F7> <ESC>:silent !ii %:r.pdf<CR>
" For glossaries and acronyms
noremap <F8> <ESC>:silent !makeindex -s %:r.ist -t %:r.glg -o %:r.gls %:r.glo<CR>
