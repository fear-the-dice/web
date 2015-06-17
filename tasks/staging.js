module.exports = function(grunt) {
    grunt.registerTask('staging', [
        'clean:wipe', 
        'jade',
        'mustache_render:staging',
        'replace:staging',
        'coffee:development', 
        'jshint',
        'sass:development', 
        'uglify:development', 
        'cssmin',
        'clean:js',
        'clean:css', 
        'clean:mustache', 
        'shell:staging'
        ]);
};
