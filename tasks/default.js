module.exports = function(grunt) {
    grunt.registerTask('default', [
        'clean:wipe', 
        'jade',
        'mustache_render:development',
        'replace:local',
        'coffee:development', 
        'jshint',
        'sass:development', 
        'bower_concat:development',
        'copy:development',
        'uglify:bower', 
        'uglify:development', 
        'cssmin',
        'clean:js',
        'clean:css', 
        'clean:mustache',
        ]);
};
