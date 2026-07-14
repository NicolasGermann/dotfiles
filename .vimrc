" --- Bewegungstasten neu belegen (jkli statt hjkl) ---
" j = links (vorher h)
" k = unten (vorher j)
" l = oben  (vorher k)
" ö = rechts (vorher l)
noremap j h
noremap k j
noremap l k
noremap ö l

" --- Fenstersteuerung mit den neuen Richtungstasten ---
nnoremap <C-w>j <C-w>h
nnoremap <C-w>k <C-w>j
nnoremap <C-w>l <C-w>k
nnoremap <C-w>ö <C-w>l

