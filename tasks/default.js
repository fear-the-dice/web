module.exports = function(grunt) {
    grunt.registerTask('default', [
        'clean:wipe', 
        'bower_concat', 
        'copy',
        'jade',
        'coffee', 
        'jshint',
        'uglify', 
        'clean:js',
        'sass', 
        'cssmin',
        'clean:css', 
        ]);
};
