module.exports = function(grunt) {
    grunt.registerTask('test', [
        'coffee:development', 
        'jshint',
        ]);
};
