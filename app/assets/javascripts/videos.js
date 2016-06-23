// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.

$(document).on('ready page:load', function(event) {

    // opens the modal dialog with our video details (and player)
    $('a.open-details').click(function() {
        var link = $(this);

        $.get('/videos/' + $(this).data('video-id'))
            .done(function(data) {
                displayInDialog(link.closest('.video').find('.video_title').text(), data);
            })
            .fail(function (_jqXhr, _textStatus, errorThrown) {
                displayAjaxError('Unexpected Error', errorThrown);
            });
    });



    // opens the modal dialog with a form to create a new video from the supplied url
    $('form#add_video').submit(function(event) {
        var form = $(this);

        $.get('/videos/new', form.serialize())
            .done(function(data) {
                displayInDialog('Add Video', data);
            })
            .fail(function (_jqXhr, _textStatus, errorThrown) {
                displayAjaxError('Unexpected Error', errorThrown);
            });
        event.preventDefault();
    });



    // triggers a reload of videos belonging to the selected board @todo via ajax
    $('select#current_board_id').change(function() {
        this.form.submit();
    });
});


function displayAjaxError(title, errorThrown) {
    var errorMessage = errorThrown;

    // rather naive way of detecting that the server is gone or inaccessible, but that will do for now
    if (errorMessage == '') {
        errorMessage = 'Lost connection with server. Try again later.';
    }    

    displayInDialog(title, '<div class="alert alert-danger">'+ errorMessage +'</div>');
}

function displayInDialog(title, html) {
    $('#modal .modal-title').text(title);
    $('.modal-body').html(html);
    $('#modal').modal('show');
}