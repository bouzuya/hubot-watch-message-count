# Description
#   message-count
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot message-count - display message count.
#
# Author:
#   bouzuya <m@bouzuya.net>
#
module.exports = (robot) ->
  brainKey = 'hubot-watch-message-count'
  storage = robot.brain.get(brainKey) or {}
  robot.brain.set(brainKey, storage)

  robot.hear /^.*$/i, (res) ->
    storage.count = (storage.count ? 0) + 1

  robot.respond /message-count$/i, (res) ->
    res.send "message count: #{storage.count}"
