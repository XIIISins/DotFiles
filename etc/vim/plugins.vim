" Setup plug
set runtimepath+=$HOME/etc/vim/

if empty(glob('$HOME/etc/vim/autoload/plug.vim'))
  silent call system('mkdir -p $HOME/etc/vim/{autoload,bundle,cache,undo,backups,swaps}')
  silent call system('curl -fLo $HOME/etc/vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
  execute 'source  $HOME/etc/vim/autoload/plug.vim'
  augroup plugsetup
    au!
    autocmd VimEnter * PlugInstall
  augroup end
endif

call plug#begin('$HOME/etc/vim/plugged')

" colors
Plug 'xero/sourcerer.vim'

" Autocompletion
Plug 'shougo/deoplete.nvim', has('nvim') ? {} : { 'do': [':UpdateRemotePlugins', ':set runtimepath+=$HOME/etc/vim/plugged/deoplete.nvim/'] }

" Linter
Plug 'w0rp/ale'

" Language Collection (syntax,compiler,autoload,ftplugin,indents etc)
Plug 'sheerun/vim-polyglot'

" Undo
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

" Statusbar
Plug 'itchyny/lightline.vim'

" Colored colorcodes from #rgb(a) #rrggbb(aa), rg(), rgba() 
Plug 'lilydjwg/colorizer'

" GIT integration
Plug 'tpope/vim-fugitive'

" NetRW enhancement
Plug 'tpope/vim-vinegar'

" Git gutter
Plug 'airblade/vim-gitgutter'

" Resize vim panes
Plug 'simeji/winresizer'

" Clipboard with tmux
Plug 'roxma/vim-tmux-clipboard'

" Distraction free mode
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Goyo' }

" Visual move of code blocks
Plug 'matze/vim-move'

" Tags in a bar
Plug 'majutsushi/tagbar', { 'on': 'Tagbar' }

" Nerdtree because netrw is a pain
Plug 'scrooloose/nerdtree'

" Alignment
Plug 'godlygeek/tabular'

call plug#end()
