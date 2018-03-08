const gulp = require('gulp');
const run = require('gulp-run');

const path = require('path');
const del = require('del');

gulp.task('clean:sim', () => {
  return del('sim/**/*');
});

gulp.task('compile:a:vhdl', () => {
  return gulp.src('vhdl/*.vhd')
    .pipe(run('ghdl -a --ieee=synopsys --std=08 <%= file.path %>', {
      cwd: path.resolve(process.cwd(), './sim'),
      verbosity: 3,
      silent: false
    }));
});

gulp.task('compile:a:tb', () => {
  return gulp.src('tb/*.vhd')
    .pipe(run('ghdl -a --ieee=synopsys --std=08 <%= file.path %>', {
      cwd: path.resolve(process.cwd(), './sim'),
      verbosity: 3,
      silent: false
    }));
});

gulp.task('compile:a', gulp.series('compile:a:vhdl', 'compile:a:tb'));

gulp.task('compile:e', () => {
  return run('ghdl -e --ieee=synopsys --std=08 tb_vga', {
    cwd: path.resolve(process.cwd(), './sim'),
    verbosity: 3,
    silent: false
  }).exec();
});

gulp.task('simulate:r', () => {
  return run('ghdl -r --ieee=synopsys --std=08 tb_vga', {
    cwd: path.resolve(process.cwd(), './sim'),
    verbosity: 3,
    silent: false
  }).exec();
});

gulp.task('compile', gulp.series('clean:sim', 'compile:a', 'compile:e', 'simulate:r'));
gulp.task('simulate', gulp.series('simulate:r'));
gulp.task('simulate:compile:tb', gulp.series('compile:a:tb', 'compile:e', 'simulate:r'));
gulp.task('simulate:compile:all', gulp.series('compile', 'simulate:r'));