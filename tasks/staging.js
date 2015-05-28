module.exports = function(grunt) {
    grunt.registerTask('staging', [
        'clean:wipe', 
        'bower_concat', 
        'copy',
        'jade',
        'mustache_render:staging',
        'coffee:development', 
        'jshint',
        'sass:development', 
        'uglify:bower', 
        'uglify:development', 
        'cssmin',
        'clean:js',
        'clean:css', 
        ]);
};
