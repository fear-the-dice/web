module.exports = function(grunt) {
    grunt.registerTask('production', [
        'clean:wipe', 
        'bower_concat', 
        'copy',
        'jade',
        'mustache_render:production',
        'coffee:production', 
        'jshint',
        'sass:production', 
        'uglify:bower', 
        'uglify:production', 
        'cssmin',
        'clean:js',
        'clean:css', 
        'clean:release'
        ]
    );
};
