module.exports = function(grunt) {
    grunt.registerTask('production', [
        'clean:wipe', 
        'jade',
        'mustache_render:production',
        'replace:production',
        'coffee:production', 
        'jshint',
        'sass:production', 
        'uglify:production', 
        'cssmin',
        'clean:js',
        'clean:css', 
        'clean:release'
        ]
    );
};
