require '../helper'

describe 'watch-message-count', ->
  beforeEach (done) ->
    @kakashi.scripts = [require '../../src/scripts/watch-message-count']
    @kakashi.users = [{ id: 'bouzuya', room: 'hitoridokusho' }]
    @kakashi.start().then done, done

  afterEach (done) ->
    @kakashi.stop().then done, done

  describe 'receive "@hubot message-count"', ->
    it 'receive 2 message and send 2', (done) ->
      sender = id: 'bouzuya', room: 'hitoridokusho'
      message = '@hubot message-count'
      @kakashi
        .receive sender, 'hoge'
        .then =>
          @kakashi.receive sender, message
        , =>
          @kakashi.receive sender, message
        .then =>
          expect(@kakashi.robot.brain.data._private).to
            .deep.equal({ 'hubot-watch-message-count': { count: 2 } })
          expect(@kakashi.send).to.have.callCount(1)
          expect(@kakashi.send.firstCall.args[1]).to.equal('message count: 2')
        .then (-> done()), done
