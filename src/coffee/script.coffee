$(document).ready ->
	$('.editor').summernote {
		minHeight: 300,
		toolbar: [
			['style', ['style']],
			['font', ['bold', 'italic', 'underline', 'clear']],
			['fontname', ['fontname']],
			['color', ['color']],
			['para', ['ul', 'ol', 'paragraph']],
			['height', ['height']],
			['table', ['table']],
			['insert', ['link', 'picture', 'hr']],
			['codeWrapper', ['codeWrapper']],
			['view', ['fullscreen', 'codeview']],
			['help', ['help']]
		]
	}