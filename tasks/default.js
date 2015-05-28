module.exports = function(grunt) {
    grunt.registerTask('default', [
        'clean:wipe', 
        'bower_concat', 
        'copy',
        'jade',
        'mustache_render:development',
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
