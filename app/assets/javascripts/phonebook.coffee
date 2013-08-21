window.Phonebook =
  init: ->
    $(document).on("ajax:success", "#new_contact", @create_contact_success)
    $(document).on("ajax:error"  , "#new_contact", @create_contact_error)

    $(document).on("ajax:success", ".delete", @destroy_contact_success)
    $(document).on("ajax:error"  , ".delete", @destroy_contact_error)

  flash_message: (type, message) ->
    $(".alert").addClass("alert-#{type}").html(message)
    $('.alert').fadeIn(200).delay(1000).fadeOut 200, ->
      $(@).removeClass("alert-#{type}").html("")

  create_contact_success: (xhr, data, status)->
    Phonebook.flash_message("success", "<strong>Hooray!</strong> Contact has been successfully added!")

    $("#new_contact").trigger("reset")

    $("#contacts").append(
      "
        <tr data-test-name=contact>
          <td data-test-name=contact_name>#{data.name}</td>
          <td data-test-name=contact_phone>#{data.phone}</td>
          <td>
            <i class='icon-trash'></i>
            <a class='delete' data-method='delete' data-remote='true' data-test-name='delete_link' href='/contacts/#{data.id}' rel='nofollow'>Delete</a>
          </td>
        </tr>
      "
    )
    $("#contacts tr:last").effect("highlight", {}, 1500)

  create_contact_error: (xhr, status, error) ->
    Phonebook.flash_message("error", "<strong>Opps!</strong> Please fill in both contact's name and phone number!")

  destroy_contact_success: (xhr, data, status)->
    Phonebook.flash_message("success", "<strong>Hooray!</strong> Contact has been successfully deleted!")

    $(@).closest("tr").fadeOut 200, ->
      @.remove()

  destroy_contact_error: (xhr, status, error) ->
    Phonebook.flash_message("error", "<strong>Opps!</strong> Something went wrong!")
