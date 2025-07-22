return {
   {
      "lervag/vimtex",
      config = function()
         vim.cmd([[
         filetype plugin indent on
         " Set Skim as the PDF viewer
         let g:vimtex_view_method = 'skim'
         " Enable compiler callback hooks for continuous compilation
         let g:vimtex_compiler_latexmk = {
             \ 'options' : [
             \   '-verbose',
             \   '-file-line-error',
             \   '-synctex=1',
             \   '-interaction=nonstopmode',
             \ ],
             \}
         " Enable reverse search from PDF to Neovim
         let g:vimtex_view_skim_sync = 1
         let g:vimtex_view_skim_activate = 1

         " Optional: Enable TOC window
         let g:vimtex_toc_config = {
             \ 'name' : 'TOC',
             \ 'layers' : ['content', 'todo', 'include'],
             \ 'resize' : 1,
             \ 'split_width' : 30,
             \ 'todo_sorted' : 0,
             \ 'show_help' : 1,
             \ 'show_numbers' : 1,
             \ 'mode' : 2,
             \}

         " Disable custom warnings
         let g:vimtex_quickfix_ignore_filters = [
             \ 'Underfull',
             \ 'Overfull',
             \ 'specifier changed to',
             \]
         ]])
      end,
   },
}
