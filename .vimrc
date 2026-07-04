" --- Bewegungstasten neu belegen (jkli statt hjkl) ---
" j = links (vorher h)
" k = unten (vorher j)
" l = oben  (vorher k)
" i = rechts (vorher l)
noremap j h
noremap k j
noremap i k

" --- Einfügen-Modus auf 'h' legen ---
" Da 'i' jetzt für Bewegung genutzt wird, schaltet 'h' nun in den Insert-Modus
noremap h i
noremap H I
