function requireAll(requireContext) {
  return requireContext.keys().map(requireContext);
}

require('./sass/style.scss');
require('./coffee/config.coffee');
require('./coffee/init.coffee');

requireAll(require.context("./coffee/collections", true, /^\.\/.*\.coffee$/));
requireAll(require.context("./coffee/models", true, /^\.\/.*\.coffee$/));
requireAll(require.context("./coffee/views", true, /^\.\/.*\.coffee$/));
