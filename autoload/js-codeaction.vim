vnoremap <leader>g :<c-u>call CodeActions()<cr>

function! CodeActions() abort
	let selected = @@

	normal! `<v`>y

	let s:code = @@
	let @@ = selected

	let actions = eval(trim(system('codeaction-engine detect ' . shellescape(s:code))))

	let s:popupMap = {}
	let popupOpt = []

	let i = 1

	for action in actions
		let s:popupMap[i] = action
		call add(popupOpt, action.description)
		let i += 1
	endfor

	echom g:popupMap

	call popup_menu(popupOpt, #{callback: 'OptionChosen'})

	function! OptionChosen(id, result)
		let item = s:popupMap[a:result]

		let out = system('codeaction-engine fix ' . item.id .  ' ' . shellescape(s:code))

		delete

		let splitted = split(out, '\n')
		let lineNo = line('.')

		for line in splitted
			call append(lineNo, line)
			normal! j
			let lineNo += 1
		endfor

		normal! mzgg=G`z
	endfunction

endfunction
