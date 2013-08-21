window.Phonebook =
  init: ->
    $(document).on("ajax:success", "#new_contact", @create_contact_success)
    $(document).on("ajax:error"  , "#new_contact", @create_contact_error)

    $(document).on("ajax:success", ".delete", @destroy_contact_success)
    $(document).on("ajax:error"  , ".delete", @destroy_contact_error)

    $('.best_in_place').best_in_place()

  flash_message: (type, message) ->
    $(".alert").addClass("alert-#{type}").html(message)
    $('.alert').fadeIn(200).delay(1000).fadeOut 200, ->
      $(@).removeClass("alert-#{type}").html("")

  create_contact_success: (xhr, data, status)->
    Phonebook.flash_message("success", "<strong>Hooray!</strong> Contact has been successfully added!")

    $("#new_contact").trigger("reset")

    $("#contacts").append(Phonebook.construct_contact_html(data))
    $("#contacts tr:last").effect("highlight", {}, 1500)

  construct_contact_html: (contact) ->
    new_contact_html = $("#contacts tbody tr.template").clone()
    new_contact_html.removeClass("template")

    $(".name .best_in_place", new_contact_html).attr("id", "best_in_place_contact_#{contact.id}_name")
    $(".name .best_in_place", new_contact_html).attr("data-url", "/contacts/#{contact.id}")
    $(".name .best_in_place", new_contact_html).html(contact.name)

    $(".phone .best_in_place", new_contact_html).attr("id", "best_in_place_contact_#{contact.id}_phone")
    $(".phone .best_in_place", new_contact_html).attr("data-url", "/contacts/#{contact.id}")
    $(".phone .best_in_place", new_contact_html).html(contact.phone)

    $(".delete", new_contact_html).attr("href", "/contacts/#{contact.id}")

    new_contact_html

  create_contact_error: (xhr, status, error) ->
    Phonebook.flash_message("error", "<strong>Opps!</strong> Please fill in both contact's name and phone number!")

  destroy_contact_success: (xhr, data, status) ->
    Phonebook.flash_message("success", "<strong>Hooray!</strong> Contact has been successfully deleted!")

    $(@).closest("tr").fadeOut 200, ->
      @.remove()

  destroy_contact_error: (xhr, status, error) ->
    Phonebook.flash_message("error", "<strong>Opps!</strong> Something went wrong!")
