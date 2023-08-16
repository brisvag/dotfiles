if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.ipy setfiletype python
  au! BufRead,BufNewFile *.qss setfiletype css
  au! BufRead,BufNewFile *.star setfiletype starfile
augroup END
