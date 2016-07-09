$(function(){
    setup_buttons();
});

function setup_buttons() {
    $('#tickets .actions a').each(function(){
        var el = $(this);
        el.click(function(){
            $.ajax({
                url: el.attr('href'),
                dataType: 'json',
            }).done(function(data) {
                if ( ! data.success == 'OK' ) {
                    alert("Request failed");
                    return;
                }
                el.toggleClass('btn-' + el.attr('data-type'));
                el.toggleClass('btn-default');
            });

            return false;
        });
    });
}
