#Fear the Dice
A tool for helping manage combat in a turn based environment. Allowing DM's/GM's to control stats such as AC, HP, and damage taken for a group.

##Node
We use Node for a lot of things from build tools to our socket server. To get this setup you will have to run the following commands.

* **Build tools:**
        
    ```
    $ cd web
    $ npm install
    ```

* **Socket server:**

    ```
    $ cd socket
    $ npm install
    ```

##Bower
We use Bower to manage packages such as jQuery and Backbone.

If you haven't used [Bower](http://bower.io/) before, be sure to check out the documentation, as it explains exactly what it does, and all its cool features. You can install Bower with the following command:

* **Installation:** 
    
    ```
    $ cd web
    $ npm install -g bower
    ```

* **Use:**
    > Once you have Bower installed you can run the following command in the "public" folder to setup all the requirements for this project:

    ```
    $ cd web
    $ bower install
    ```

##Grunt
We use Grunt to compile source, and also watch folders during development.
If you haven't used [Grunt](http://gruntjs.com/) before, be sure to check out the [Getting Started](http://gruntjs.com/getting-started) guide. You can install Grunt with the following command:

* **Installation:**

    ```
    $ npm install -g grunt-cli 
    ```

* **Use:**

    > Once you have Grunt installed you can run the following command to build the site (note grunt will automatically build into the "public" folder, as specificed in "Gruntfile.js"):

    ``` 
    $ cd web
    $ grunt 
    ```

##License
This tool is protected by the [GNU General Public License v2](http://www.gnu.org/licenses/gpl-2.0.html).

Copyright [Jeffrey Hann](http://jeffreyhann.ca/) 2015
