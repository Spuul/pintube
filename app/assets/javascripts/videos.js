// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.

$(document).on('ready page:load', function(event) {
    
    // opens a modal dialog with our video details (and player)
    $('a.open-details').click(function() {
        var link = $(this);
        $('.modal-body').load('/videos/' + $(this).data('video-id'),
            function() {
                $('#modal .modal-title').text(link.closest('.video').find('.video-title').text());
                $('#modal').modal('show');
            });
    });

    // trigger a reload of videos belonging to the selected board #@todo via ajax
    $('select#current_board_id').change(function() {
        this.form.submit();
    });
});