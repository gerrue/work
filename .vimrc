filetype plugin on
syntax on

" Some random defaults
set number
set foldmethod=indent
set foldlevel=99
hi Folded       guifg=grey guibg=darkblue ctermfg=grey ctermbg=darkblue

"""""""" Plugin stuff

""" FuzzyFinder
nmap <SPACE> :FufFile<CR>A**/<backspace>
