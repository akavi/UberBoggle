$ = require('jquery')
template = require('./template')

Component = require('../component')
Word = require('../../models/word')

class WordsPanel extends Component
  template: template

  constructor: (opts)->
    super
    @state = opts.state

    @state.on 'change:game', @render
    @state.on 'change:currentWord', @render
    @state.on 'change:currentWord:change:isReal', @subRender('.word-input-points')
    @state.on 'change:currentWord:change:literal', @subRender('.word-input-points')
    @state.on 'change:game:addWord', @subRender('.word-list')
    
    @el.on 'input', '.word-input-input', @updateWordLiteral
    @el.on 'submit', '.word-input-form', @submitWord
    @render()

  data: ->
    time = new Date()
    game = @state.get('game')
    words = game?.get('words') || []
    currentWord = @state.get('currentWord')

    canEnterWords  = game?.isInGame(time)
    checkable = currentWord?.get('literal').length > 0
    currentPoints = currentWord?.points()
    isChecking = !currentWord?.get('isReal')?
    isReal = currentWord?.get('isReal') is true
    isUnique = game?.isWordUnique(currentWord)
    isOnBoard = game?.isWordPresent(currentWord)

    canEnterWords: canEnterWords
    words: words.map (w)->
      {literal: w.get('literal'), points: w.points()}
    currentWord: currentWord.get('literal')
    currentPoints:
      checkable && isReal && isUnique && isOnBoard && currentPoints
    isChecking: checkable and isChecking
    isntReal: checkable and !isChecking && !isReal
    isntOnBoard: checkable and isReal and !isOnBoard
    isntUnique: checkable and isReal and !isUnique

  #  DOM -> State 
 
  submitWord: (ev)=>
    game = @state.get('game')
    currentWord = @state.get('currentWord')
    submittable = currentWord.get('literal').length > 0
    submittable &&= currentWord.get('isReal') is true
    submittable &&= game.isWordUnique(currentWord)
    submittable  &&= game.isWordPresent(currentWord)

    if submittable
      game.get('words').push(new Word(literal: currentWord.get('literal')))
      game.trigger('addWord')
      currentWord.set('literal', '')
      @el.find('.word-input-input').val('')

    ev.preventDefault()

  updateWordLiteral: =>
    word = @state.get('currentWord')
    literal = @el.find('.word-input-input').val()
    word.set('literal', literal)
    word.checkReality()
    

module.exports = WordsPanel
