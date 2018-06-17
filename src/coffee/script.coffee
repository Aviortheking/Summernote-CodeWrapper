$(document).ready ->
	$('.editor').summernote {
		minHeight: 300,
		toolbar: [
			['style', ['bold', 'italic', 'underline', 'clear']],
			['font', ['strikethrough', 'superscript', 'subscript']],
			['fontsize', ['fontsize']],
			['color', ['color']],
			['para', ['ul', 'ol', 'paragraph']],
			['height', ['height']],
			['codeWrapper', ['codeWrapper']],
			['insert', ['gxcode']],
			['misc', ['codeview']]
		]
	}