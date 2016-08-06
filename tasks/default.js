module.exports = function(grunt) {
    grunt.registerTask('default', [
        'clean:wipe', 
        'jade',
        'mustache_render:development',
        'replace:local',
        'copy:development',
        'clean:mustache',
        ]);
};
