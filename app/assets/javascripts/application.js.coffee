# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require jquery-ui
#= require turbolinks
#= require bootstrap-sprockets
#= require_tree .


window.slot_update = (slot)->
  card_id = null
  card = slot.find(".card").first()
  if card.length
    card_id = card.data("card-id")
  slot_id = slot.data("slot-id")
  #update slot
  console.log("setting slot:"+slot_id+ " card to: "+card_id)
  $.ajax '/slots/'+slot_id,
    method: 'patch'
    data: slot:
      card_id: card_id
    dataType: 'script'
    complete: (e)->
      console.log(e)
      console.log('card slot changed')

window.make_cards_draggable = ->
  $(".card").draggable revert: "invalid"

  $('.slot').droppable
    drop: (event, ui) ->
      console.log(this)
      console.log(ui.draggable)
      content = $(this).children().first()
      #swap content
      card_slot = ui.draggable.parents(".slot")
      content.detach().appendTo(card_slot)
      $(ui.draggable).detach().appendTo(this).css({left:0,top:0,height: ""})
      #save new slots content
      #TODO: should be in one ajax call, and one trasaction server side, current version is only for prototype
      #TODO: if no feedback from server revert position
      slot_update(card_slot)
      slot_update($(this))

    accept: ".card"
    hoverClass: "card-hover"

$ ->
  make_cards_draggable()
  $(document).on 'click', '.empty_slot_content', ->
    card_name = prompt('Card name')
    if card_name
      $.ajax '/cards',
        method: 'post'
        data: card:
          name: card_name
          slot_id: $(this).parents(".slot").data('slot-id')
        dataType: 'script'
