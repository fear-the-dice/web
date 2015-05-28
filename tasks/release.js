module.exports = function(grunt) {
    grunt.registerTask('release', [
        'clean:wipe', 
        'bower_concat', 
        'copy',
        'jade',
        'mustache_render:release',
        'coffee', 
        'jshint',
        'uglify', 
        'clean:js',
        'sass', 
        'cssmin',
        'clean:css', 
        ]);
};
