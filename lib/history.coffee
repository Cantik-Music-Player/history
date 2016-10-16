require 'coffee-react/register'
HistoryView = require('./history-view').HistoryView
HistoryComponent = require('./history-view').HistoryComponent

module.exports =
class History
  constructor: (@cantik) ->
    @history = []
    @historyIndex = -1
    @avoidNewEntry = false

  activate: (state) ->
    @historyView = new HistoryView(@, @cantik)

  deactivate: ->
    if @historyView?
      @historyView.destroy()

  serialize: ->
    historyViewState: @historyView.serialize()

  # Add an entry to the history
  addHistoryEntry: (entry) ->
    if not @avoidNewEntry
      @history = @history[0..@historyIndex]
      @history.push(entry)
      @historyIndex = -1 + @history.length

  goToEntry: (index) ->
    # Avoid creating new history entry when accessing it thought history
    @avoidNewEntry = true
    try
      do @history[index]
      @historyIndex = index
    catch error
      console.log "Cannot go to index #{index}: #{error}"
    setTimeout((=> @avoidNewEntry = false), 10) # Wait the history function for a short period

  next: ->
    @goToEntry @historyIndex + 1

  back: ->
    @goToEntry @historyIndex - 1
