# XR7 Etherpad Lite Dockerfile
#
# https://github.com/ether/etherpad-lite
# https://github.com/dtroyer/test-me
#
# Author: dtroyer

FROM etherpad/etherpad:1.8.0
LABEL maintainer="dtroyer"

# plugins to install while building the container. By default no plugins are
# installed.
# If given a value, it has to be a space-separated, quoted list of plugin names.
#
# EXAMPLE:
#   ETHERPAD_PLUGINS="ep_codepad ep_author_neat"
ARG ETHERPAD_PLUGINS="ep_headings2 ep_hide_referrer ep_markdown"

# Set the following to production to avoid installing devDeps
# this can be done with build args (and is mandatory to build ARM version)
ENV NODE_ENV=production

USER etherpad:etherpad

WORKDIR /opt/etherpad-lite

# Install the plugins, if ETHERPAD_PLUGINS is not empty.
#
# Bash trick: in the for loop ${ETHERPAD_PLUGINS} is NOT quoted, in order to be
# able to split at spaces.
RUN for PLUGIN_NAME in ${ETHERPAD_PLUGINS}; do npm install "${PLUGIN_NAME}"; done

EXPOSE 9001
CMD ["node", "node_modules/ep_etherpad-lite/node/server.js"]
