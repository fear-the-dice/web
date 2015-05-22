module.exports = function(grunt) {
    grunt.registerTask('release', [
        'default',
        'mustache_render:release',
        'clean:release']);
};
