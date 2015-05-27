module.exports = function(grunt) {
    grunt.registerTask('release', [
        'default',
        'mustache_render:staging',
        'clean:release']);
};
