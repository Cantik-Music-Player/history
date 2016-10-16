HistoryView = require('../lib/history-view').HistoryView
HistoryComponent = require('../lib/history-view').HistoryComponent

assert = require 'assert'
jsdom = require 'mocha-jsdom'

describe "History Component", ->
  jsdom()

  beforeEach ->
    @history =  {
      'next': -> true,
      'back': -> true
    }

  it "Render", ->
    new HistoryView(@history, {
        pluginManager: {
          plugins: {
            sidebar: {
              sidebarView: {
                getElement: ->
                  document.getElementsByTagName("body")[0]
              }
            }
          }
      }
    })

    # Clean data-react-id
    html = document.getElementsByTagName("body")[0].innerHTML.replace(/ data-reactroot=""/g, '')

    assert.equal(html,
    '<div><div class="history"><div class="form-group left"><button class="withripple"><i class="material-icons previous">keyboard_arrow_left</i></button></div><div class="form-group"><button class="withripple"><i class="material-icons next">keyboard_arrow_right</i></button></div></div></div>')
