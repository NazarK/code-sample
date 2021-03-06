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


window.card_edit = (event) ->
  event.stopPropagation()
  (card_name_view = $(this).parents(".card").find(".card_name_view")).hide()
  (card_name_input = $(this).parents(".card").find(".card_name_input")).show().val(card_name_view.html()).focus()
  card_name_input[0].setSelectionRange(0, card_name_input.val().length)

window.card_name_save = (event) ->
  card = $(this).parents(".card")
  input = card.find(".card_name_input")
  if(!input.is(":visible"))
    return;
  console.log("SAVE")
  input.hide()
  (view = card.find(".card_name_view")).show().html(input.val())
  console.log("SAVE DONE")
  $.ajax '/cards/'+card.data("card-id"),
    method: 'patch'
    data: card:
      name: input.val()
    dataType: 'script'
    #TODO: add error handler (with message no connection or something) with alert and probably reverting card name
    complete: (e)->
      console.log("card name patch ajax done")



window.list_name_edit = () ->
  input_control = $(this).parents(".list").find(".list_name_edit")
  input_control.show().focus().val($(this).html())
  input_control[0].setSelectionRange(0, input_control.val().length)
  $(this).hide()

window.list_name_edit_key = (e) ->
  if(e.keyCode==13)
    console.log("enter handler")
    list_name_save.apply(this)

window.list_name_save = (e) ->
  console.log(e)
  console.log("LIST_NAME_SAVING", window.LIST_NAME_SAVING)
  if(window.LIST_NAME_SAVING)
    return;
  if(!$(this).is(":visible"))
    console.log("input not visible, ignoring")
    return;
  if($(this).val()==window.LIST_NAME_EDIT_IGNORE)
    console.log("same value, assuming after alert")
    return;
  window.LIST_NAME_SAVING = true
  self = this
  list_id = $(this).parents(".list").data("list-id")
  console.log("ajax")
  $.ajax '/lists/'+list_id,
    method: 'patch'
    data: list:
      name: $(self).val()
    dataType: 'script'
    complete: (e)->
      console.log("complete")



window.card_new = (list_id)->
  $("#new_card_form [name='card[list_id]']").val(list_id)
  $("#new_card_form [name='card[name]']").val("")
  #$("#slot_form [name='card[card_type]']").val("")
  $("#new_card_form").modal("show")

window.slot_new = (list_id)->
  $("#slot_form [name='slot[card_type]']").val("")
  $("#slot_form [name='slot[list_id]']").val(list_id)
  $("#slot_form").modal("show")


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

window.slots_switch = (slot, slot_other) ->
  $.ajax '/slots/switch',
    method: 'post'
    data:
      slot_id: slot.data("slot-id")
      slot_other: slot_other.data("slot-id")
    dataType: 'script'
    complete: (e)->
      console.log(e)
      console.log('slots exchanged')

window.apply_draggable = ->
  $(".card").draggable
    revert: "invalid"
    stack: ".card"
    zIndex: 100
    cursor: "pointer"

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
      #TODO: if no feedback from server revert position
      slots_switch(card_slot, $(this))

    accept: ".card"
    hoverClass: "card-hover"

  $("#sortable").sortable
    update: (event,ui) ->
      new_order = []
      $("#sortable td div.list").each () ->
        console.log this
        new_order.push $(this).data("list-id")
      console.log(new_order)
      $.ajax '/lists/reorder',
        method: 'post'
        data:
          new_order: new_order
        dataType: 'script'
        complete: (e)->
          console.log(e)
          console.log('lists reordered')

$ ->
  apply_draggable()

  $(document).on 'click', '.empty_slot_content', ->
    card_name = prompt('Card name')
    if card_name
      $.ajax '/cards',
        method: 'post'
        data: card:
          name: card_name
          slot_id: $(this).parents(".slot").data('slot-id')
        dataType: 'script'

  $(document).on 'click', 'div.card', (e)->
    console.log("click card",e)
    card_id = $(this).data("card-id")
    $("#card_view_handle").html(($(".card_view[data-card-id=#{card_id}]")).html())
    $("#card_view_handle").modal("show")

  setInterval (->
    timestamp = $("#lists_content").attr("data-timestamp")
    if !timestamp
      return
    $.ajax '/check_for_updates',
      method: 'get'
      data:
        timestamp: timestamp
      dataType: 'script'
      complete: (e)->
        console.log('checked for updates')

    ), 2000
