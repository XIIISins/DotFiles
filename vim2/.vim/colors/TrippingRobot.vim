""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  _____     _             _             ____       _           _    "
" |_   _| __(_)_ __  _ __ (_)_ __   __ _|  _ \ ___ | |__   ___ | |_  "
"   | || '__| | '_ \| '_ \| | '_ \ / _` | |_) / _ \| '_ \ / _ \| __| "
"   | || |  | | |_) | |_) | | | | | (_| |  _ < (_) | |_) | (_) | |_  "
"   |_||_|  |_| .__/| .__/|_|_| |_|\__, |_| \_\___/|_.__/ \___/ \__| "
"             |_|   |_|            |___/                             "
"                                                                    "
" Vim colorscheme                                                    "
" By: Chewtoy                                                        "
" Available at: https://github.com/qwelyt/TrippingRobot              "
"                                                                    "
" Support for 256 colour terminal. No GUI.                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
highlight clear
if exists("syntax_on")
	syntax reset
endif

set t_Co=256
let g:colors_name = "TrippingRobot"



" General colours
hi Normal	ctermfg=251	ctermbg=NONE	cterm=NONE
hi NonText	ctermfg=36	ctermbg=NONE	cterm=NONE

hi Cursor	ctermfg=0	ctermbg=255	cterm=REVERSE
hi LineNr	ctermfg=242	ctermbg=NONE	cterm=NONE
hi CursorLineNr	ctermfg=247	ctermbg=NONE	cterm=BOLD

hi VertSplit	ctermfg=233	ctermbg=233	cterm=NONE
hi StatusLine	ctermfg=85	ctermbg=233	cterm=NONE
hi StatusLineNC	ctermfg=242	ctermbg=233	cterm=BOLD

hi FoldColumn	ctermfg=244	ctermbg=235	cterm=NONE
hi Folded	ctermfg=244	ctermbg=235	cterm=BOLD

hi Title	ctermfg=NONE	ctermbg=NONE	cterm=NONE
hi TabLine	ctermfg=247	ctermbg=NONE	cterm=NONE
hi TabLineFill	ctermfg=0	ctermbg=NONE	cterm=NONE
hi TabLineSel	ctermfg=85	ctermbg=236	cterm=NONE

hi Visual	ctermfg=NONE	ctermbg=238	cterm=NONE

hi SpecialKey	ctermfg=239	ctermbg=0	cterm=NONE

hi WildMenu	ctermfg=85	ctermbg=235	cterm=BOLD
hi PmenuSbar	ctermfg=0	ctermbg=240	cterm=NONE

hi Error	ctermfg=15	ctermbg=88	cterm=NONE
hi ErrorMsg	ctermfg=15	ctermbg=88	cterm=BOLD
hi WarningMsg	ctermfg=15	ctermbg=88	cterm=BOLD

hi IncSearch	ctermfg=234	ctermbg=6	cterm=NONE
hi Search	ctermfg=176	ctermbg=53	cterm=UNDERLINE

hi ModeMsg	ctermfg=246	ctermbg=NONE	cterm=BOLD

hi CursorLine	ctermfg=NONE	ctermbg=NONE	cterm=NONE
hi CursorColumn	ctermfg=NONE	ctermbg=NONE	cterm=NONE

hi MathParen	ctermfg=NONE	ctermbg=240	cterm=NONE

hi Pmenu	ctermfg=7	ctermbg=238	cterm=NONE
hi PmenuSel	ctermfg=7	ctermbg=186	cterm=NONE

hi MatchParen	ctermfg=9	ctermbg=245	cterm=BOLD



" Syntax
hi Comment	ctermfg=248	ctermbg=NONE	cterm=NONE
hi String	ctermfg=143	ctermbg=NONE	cterm=NONE
hi Character	ctermfg=210	ctermbg=NONE	cterm=NONE
hi Number	ctermfg=166	ctermbg=NONE	cterm=NONE
hi link Float Number
hi Boolean	ctermfg=77	ctermbg=NONE	cterm=NONE
hi Constant	ctermfg=131	ctermbg=NONE	cterm=BOLD

hi Keyword	ctermfg=172	ctermbg=NONE	cterm=NONE
hi PreProc	ctermfg=78	ctermbg=NONE	cterm=NONE
hi Conditional	ctermfg=136	ctermbg=NONE	cterm=BOLD
hi Repeat	ctermfg=166	ctermbg=NONE	cterm=BOLD

hi Identifier	ctermfg=65	ctermbg=NONE	cterm=NONE
hi Type		ctermfg=208	ctermbg=NONE	cterm=NONE
hi TypeDef	ctermfg=166	ctermbg=NONE	cterm=NONE
hi Special	ctermfg=210	ctermbg=NONE	cterm=NONE
" Don't know what parts use Delimiter, so yellow for now.
hi Delimiter	ctermfg=11	ctermbg=NONE	cterm=NONE

hi Function	ctermfg=208	ctermbg=NONE	cterm=NONE
hi Statement	ctermfg=166	ctermbg=NONE	cterm=NONE
hi Operator	ctermfg=160	ctermbg=NONE	cterm=NONE
hi Exception	ctermfg=130	ctermbg=NONE	cterm=UNDERLINE

hi ToDo		ctermfg=14	ctermbg=238	cterm=BOLD,UNDERLINE


" VimDiff
hi DiffAdd	ctermfg=251	ctermbg=22	cterm=NONE
hi DiffChange	ctermfg=251	ctermbg=98	cterm=NONE
hi DiffDelete	ctermfg=88	ctermbg=88	cterm=NONE
hi DiffText	ctermfg=251	ctermbg=NONE	cterm=NONE


" Special for Java
hi link javaScopeDecl         Identifier
hi link javaCommentTitle      javaDocSeeTag
hi link javaDocTags           javaDocSeeTag
hi link javaDocParam          javaDocSeeTag
hi link javaDocSeeTagParam    javaDocSeeTag

hi  javaDocSeeTag ctermfg=229 ctermbg=NONE cterm=NONE


" Special for Python
hi link pythonStatement Identifier
hi pythonBuiltin	ctermfg=42	ctermbg=NONE	cterm=UNDERLINE
hi pythonOperator	ctermfg=166	ctermbg=NONE	cterm=NONE

