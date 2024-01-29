" Make sure to disable these hotkeys: close current tab (Ctrl + w), Delete paragraph (Ctrl + D)
" to see command names (e.g. workspace:close) look at vault/.obsidian/hotkeys.json after binding a custom hotkey to that commend

set tabstop=4

" Emulate Original gt and gT
exmap nextTab obcommand workspace:next-tab
exmap prevTab obcommand workspace:previous-tab
nmap gt :nextTab
nmap gT :prevTab

" Emulate vim folding command
exmap togglefold obcommand editor:toggle-fold
map za :togglefold
nmap zo :togglefold
nmap zc :togglefold
exmap unfoldall obcommand editor:unfold-all
exmap foldall obcommand editor:fold-all
nmap zm :foldall
nmap zr :unfoldall

" Have j and k navigate visual lines rather than logical ones
nmap j gj
nmap k gk
" clear highlights
nmap <F5> :nohl
" Yank to system clipboard
set clipboard=unnamed

" Go back and forward with Ctrl+O and Ctrl+I
" (make sure to remove default Obsidian shortcuts for these to work)
"exmap back obcommand app:go-back
"nmap <C-o> :back
"exmap forward obcommand app:go-forward
"nmap <C-i> :forward

" Window commands (unmap: close current tab Ctrl+w)
exmap wq obcommand workspace:close
exmap q obcommand workspace:close
nmap <C-w>c :wq
exmap splitVertical obcommand workspace:split-vertical
nmap <C-w>v :splitVertical
exmap splitHorizontal obcommand workspace:split-horizontal
nmap <C-w>s :splitHorizontal
exmap focusRight obcommand editor:focus-right
nmap <C-w>l :focusRight
exmap focusLeft obcommand editor:focus-left
nmap <C-w>h :focusLeft
exmap focusTop obcommand editor:focus-top
nmap <C-w>k :focusTop
exmap focusBottom obcommand editor:focus-bottom
nmap <C-w>j :focusBottom

" spell check
exmap contextMenu obcommand editor:context-menu
nmap z= :contextMenu
vmap z= :contextMenu
