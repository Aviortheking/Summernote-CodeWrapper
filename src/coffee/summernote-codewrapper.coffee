(
	((factory) ->
		if typeof define is 'function' and define.amd
			define ['jquery'], factory
		else if typeof module is 'object' and module.exports
			module.exports = factory require 'jquery'
		else
			factory window.jQuery
		return
	) (($) ->
		$.extend $.summernote.options, {
			codewrapper: {
				menu: [
					'Update',
					'javascript',
					'css',
					'html'
				]
			}
		},

		$.extend $.summernote.plugins, {
			'codeWrapper': (context) ->
				this.events = {
					'summernote.enter': (u, e, $editable) ->
						selection = window.getSelection()
						correct = selection.anchorNode.nodeName is "CODE" or selection.anchorNode.parentNode.nodeName is "CODE"
						if correct
							e.preventDefault()
							range = window.getSelection().getRangeAt 0
							range.deleteContents()
							range.insertNode document.createElement('br')
							range.addRange 4
							range.collapse()
							return

					'summernote.keydown': (u, e) ->
						selection = window.getSelection()
						correct = selection.anchorNode.nodeName is "CODE" or selection.anchorNode.parentNode.nodeName is "CODE"
						if e.key is 'Tab' and correct
							e.preventDefault()
							range = selection.getRangeAt 0
							range.deleteContents()
							range.insertNode document.createTextNode('	')
							range.collapse()
							return
				}

				ui = $.summernote.ui
				options = context.options

				context.memo 'button.codeWrapper', ->
					button = ui.buttonGroup [
						ui.button {
							container: false
							contents: '<i /> Code'
							tooltip: 'Code Wrapper'
							data: {
								toggle: 'dropdown'
							}
						}
						ui.dropdown {
							items: options.codewrapper.menu
							click: (e) ->
								button = e.target.innerText
								highlight = window.getSelection()
								correct = highlight.anchorNode.nodeName is "CODE" or highlight.anchorNode.parentNode.nodeName is "CODE"
								if button is "Update"
									$('pre code').each (i, code) ->
										node = document.createElement 'code'
										code.childNodes.forEach (el) ->
											if el.nodeName is '#text' then node.innerHTML += el.wholeText
											else if el.nodeName is 'BR' then node.innerHTML += '<br />'
											else node.innerHTML += el.innerText
											return
										node.classList = code.classList
										node.classList.remove 'hljs'
										parent = code.parentNode
										parent.removeChild code
										if hljs then hljs.highlightBlock node
										parent.appendChild node
										return
								else if correct then null
								else
									pre = document.createElement 'pre'
									pre.setAttribute 'autocomplete', 'off'
									pre.setAttribute 'spellcheck', false
									code = document.createElement 'code'
									code.classList.add button
									code.innerText = highlight
									pre.appendChild code
									range = highlight.getRangeAt 0
									range.deleteContents()
									range.insertNode pre
									if hljs then hljs.highlightBlock code
									range.collapse()
								return
						}
					]

					button.render()

				@destroy = ->
					@$panel.remove()
					@$panel = null
					return
				return
		}
		return
	)
)
