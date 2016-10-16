React = require('react')
ReactDOM = require('react-dom')

module.exports.HistoryComponent =
class HistoryComponent extends React.Component
  constructor: (props) ->
    super props

  render: ->
    <div className="history">
      <div className="form-group left">
        <button onClick={@props.history.back.bind(@props.history)} className="withripple"><i className="material-icons previous">keyboard_arrow_left</i></button>
      </div>
      <div className="form-group">
        <button onClick={@props.history.next.bind(@props.history)} className="withripple"><i className="material-icons next">keyboard_arrow_right</i></button>
      </div>
    </div>

module.exports.HistoryView =
class HistoryView
  constructor: (@history, cantik) ->
    @element = document.createElement('div')
    ReactDOM.render(
      <HistoryComponent history=@history />,
      @element
    )
    cantik.pluginManager.plugins.sidebar.sidebarView.getElement().appendChild(@element);

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element
