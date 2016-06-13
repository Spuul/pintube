// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.

$( document ).ready(function() {

    $('a.open-details').click(function() {
        var link = $(this);
        $('.modal-body').load('/videos/' + $(this).data('video-id'),
            function() {
                $('#modal .modal-title').text(link.closest('.video').find('.video-title').text());
                $('#modal').modal('show');
            });
    });

});