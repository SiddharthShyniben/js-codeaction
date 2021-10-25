vnoremap <leader>g :<c-u>call CodeActions()<cr>

function! CodeActions() abort
	let selected = @@

	normal! `<v`>y

	let code = @@
	let @@ = selected

	let out = system('codeaction-engine 1 "' . code . '"')

	delete

	let splitted = split(out, '\n')
	let lineNo = line('.')

	for line in splitted
		call append(lineNo, line)
		normal! j
		let lineNo += 1
	endfor

	" Possible formating problems fix
	normal! mzgg=G`z
endfunction
