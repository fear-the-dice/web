(function () {
    'use strict';
}());

module.exports = function(grunt) {
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
    });

    grunt.loadNpmTasks('grunt-contrib-jade');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-clean');
    grunt.loadNpmTasks('grunt-contrib-copy');
    grunt.loadNpmTasks('grunt-text-replace');
    grunt.loadNpmTasks('grunt-mustache-render');
    grunt.loadNpmTasks('grunt-shell');

    var configs = require('load-grunt-configs')(grunt);
    grunt.initConfig(configs);

    grunt.loadTasks('tasks');
    grunt.loadNpmTasks('grunt-bower-concat');
};
