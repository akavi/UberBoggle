gulp = require('gulp')

gutil = require('gulp-util')
transform = require('vinyl-transform')
source = require('vinyl-source-stream')
changeExtension = require('gulp-ext-replace')

coffee = require('gulp-coffee')
handlebars = require('hbsfy')
browserify = require('browserify')

gulp.task 'coffeescript', ->
  gulp.src('./src/**/*.coffee')
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest('./build/'))

gulp.task 'handlebars', ->
  handlebarred = transform (filename)->
    handlebars(filename)

  gulp.src('./src/**/*.hbs')
    .pipe(handlebarred)
    .pipe(changeExtension('.js'))
    .pipe(gulp.dest('./build/'))

gulp.task 'browserify', ['coffeescript', 'handlebars'], ->
  browserify(entries: ['./build/index.js'])
    .bundle()
    .pipe(source('./index.js'))
    .pipe(gulp.dest('./public/'))

gulp.task 'watch', ->
  gulp.watch('./src/**/*.coffee', ['coffeescript', 'browserify'])
  gulp.watch('./src/**/*.hbs', ['handlebars', 'browserify'])
