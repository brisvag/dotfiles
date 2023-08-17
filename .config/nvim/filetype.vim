if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.ipy setfiletype python
  au! BufRead,BufNewFile *.qss setfiletype css
  au! BufRead,BufNewFile *.star,*.cif setfiletype starfile
  au! BufRead,BufNewFile *.pdb setfiletype pdb
augroup END
