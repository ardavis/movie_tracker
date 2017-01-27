ready = ->

  # When we click on a movie poster
  # we want to add the movie to the database in the
  # background. Then show the user that it worked
  # Maybe some kind of checkmark or something.

  $('.searches a').click (event) ->
    # Don't actually follow the GET link
    event.preventDefault()

    add_button = $(this)
    loading_indicator = add_button.find('.loading')
    button_text = add_button.find('.text')
    add_indicator = $(this).find('.glyph_add')
    confirmed_indicator = $(this).find('.glyph_confirmed')
    error_indicator = $(this).find('.glyph_error')

    # Make the request in the background
    $.ajax add_button.attr('href'),
      type: 'POST',
      beforeSend: ->
        console.log $(this)
        loading_indicator.show()
        add_indicator.hide()
        confirmed_indicator.hide()
        error_indicator.hide()
      success: ->
        confirmed_indicator.show()
        add_button.addClass('btn-success')
      error: ->
        error_indicator.show()
        add_button.addClass('btn-danger')
      complete: ->
        loading_indicator.hide()

      # We'd use this if the link was a POST request
      # return false

$(document).on 'turbolinks:load', ready