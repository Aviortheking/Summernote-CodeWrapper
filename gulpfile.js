var gulp = require('gulp');
var gutil = require('gutil');
var pug = require('gulp-pug');
var sftp = require('gulp-sftp');
var coffee = require('gulp-coffee');
var combiner = require('stream-combiner2');
var sourcemaps = require('gulp-sourcemaps');
var uglifyhtml = require('gulp-html-minifier');
var browserSync = require('browser-sync').create();

gulp.task('pug-process', function(){
	var res = combiner.obj([
		gulp.src('src/pug/*.pug'),
		pug(),
		uglifyhtml({collapseWhitespace: true}),
		gulp.dest('build/')
	]);

	res.on('error', gutil.log);

	return res;
});

gulp.task('pug', ['pug-process'], function (done) {
	browserSync.reload();
	done();
});

gulp.task('coffee-process', function(){
	var res = combiner.obj([
		gulp.src('src/coffee/**/*'),
		sourcemaps.init(),
		coffee({bare: true}),
		sourcemaps.write(''),
		gulp.dest('build/js')
	]);
	res.on('error', gutil.log);

	return res;
});

gulp.task('coffee', ['coffee-process'], function (done) {
	browserSync.reload();
	done();
});

gulp.task('import', function() {
	var list = [
		//bootstrap
		['node_modules/bootstrap/dist/js/bootstrap.min.js', 'js/'],
		['node_modules/bootstrap/dist/js/bootstrap.min.js.map', 'js/'],
		['node_modules/bootstrap/dist/css/bootstrap.min.css', 'css/'],
		['node_modules/bootstrap/dist/css/bootstrap.min.css.map', 'css/'],

		['node_modules/popper.js/dist/umd/popper.min.js', 'js/'],
		['node_modules/popper.js/dist/umd/popper.min.js.map', 'js/'],

		//jquery
		['node_modules/jquery/dist/jquery.min.js', 'js/'],
		['node_modules/jquery/dist/jquery.min.js.map', 'js/'],

		//summernote
		['src/css/summernote-bs4.css', 'css/'],
		['node_modules/summernote/dist/summernote-bs4.min.js', 'js/'],
		['node_modules/summernote/dist/summernote-bs4.min.js.map', 'js/'],
		['node_modules/summernote/dist/font/*', 'fonts/'],

		//highlight.js
		['src/js/highlight.pack.js', 'js/'], //come with CSS, javascript, php, sql, c#, diff, json, markdown, shell session, c++, html xml, java, python
		['src/css/androidstudio.css', 'css/'],
	];

	list.forEach(element => {
		gulp.src(element[0]).pipe(gulp.dest('./build/'+element[1])).on('error', gutil.log);
	});
});

gulp.task('build', [ 'pug', 'coffee', 'import']);

gulp.task('default', ['build'], function() {
	browserSync.init({
		server: {
			baseDir: "build/"
		}
	});
	gulp.watch("src/pug/**/*", ['pug']);
	gulp.watch("src/coffee/**/*", ['coffee']);
});

gulp.task('stop', function() {
	process.exit();
});