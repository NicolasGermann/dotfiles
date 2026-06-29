" --- Cursor-Navigation ---
nnoremap i k
vnoremap i <ESC>k
nnoremap j h
vnoremap j <ESC>h
nnoremap k j
vnoremap k <ESC>j
nnoremap l l
vnoremap l <ESC>l

" --- Select-Mode ---
nnoremap I vk
vnoremap I k
nnoremap J vh
vnoremap J h
nnoremap K vj
vnoremap K j
nnoremap L vl
vnoremap L l

" --- Wort-Navigation ---
nnoremap u b
vnoremap u b
nnoremap o e
vnoremap o e

" --- Undo & Redo ---
nnoremap h u
nnoremap H <C-r>

" --- Kopieren & Einfügen ---
nnoremap c yy
vnoremap c y
nnoremap v p
vnoremap v p

" --- Auswahl (Visual Mode) ---
nnoremap w vi(
vnoremap w i(
nnoremap x vt
nnoremap y vf
nnoremap a viw
vnoremap a iw
nnoremap A viW
vnoremap A iW
nnoremap s ^v$h
vnoremap s j$
vnoremap p <ESC>

" q = Bereich Ende obere Zeile bis Anfang aktuelle Zeile
" (Hebt im Visual Mode die bestehende Auswahl erst auf)
nnoremap q k$vj^h
vnoremap q <Esc>k$vj^h

" --- Suche ---
vnoremap z y/<C-R>"<CR>
nnoremap z n

" --- Makros ---
nnoremap g qm
nnoremap G @m


" --- Visual Mode ---
vnoremap ä o

" --- Löschen & Ändern ---
nnoremap t x
vnoremap d d
vnoremap f c
nnoremap f c

" --- Insert Mode ---
nnoremap e i
vnoremap e o<Esc>i
nnoremap r a
vnoremap r <Esc>a

nnoremap E O
nnoremap R o
