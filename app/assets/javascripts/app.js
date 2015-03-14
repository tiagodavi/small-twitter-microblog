$(function(){
    
    var user_signed_in =  $("#user-signed-in").val();    
    if(user_signed_in == 'true'){        
        if(typeof(EventSource) !== "undefined") {           
            var modal_content = $('#modal-content');
            var total_notify  = $('#total-notify');
            var source = new EventSource("/connect");
            source.addEventListener("message",function(e) {
                var html = [];  
                var data = jQuery.parseJSON(e.data);
                if(jQuery.isEmptyObject(data) == false){                   
                    total_notify.text(data.length);
                    jQuery.each(data, function(i, user) {
                        html.push('<div class="alert alert-info" role="alert">'+user+' está seguindo você.</div>');
                    });                      
                    modal_content.html(html.join(''));                 
                };                  
            });
        };
    };
    
    var profiles = new Bloodhound({
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace('text'),
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        remote: {
            url: '/users.json',
            replace: function(url, uriEncodedQuery) {                    
              return url + '?name=' + uriEncodedQuery;
            },
            filter: function (response) {
              return response;
            }
        }
    });
     
    profiles.initialize();
     
    $('.typeahead').typeahead(null, {
      name: 'Perfis',
      displayKey: 'login',
      source: profiles.ttAdapter()     
    }).on('typeahead:selected', function(e, data){
       return window.location.href = '/profile/' + data.login;
    });


    $(".maxlength").keyup(function(event){     
        var btn_publish = $("#btn-publish");
        var target = $("#content-countdown");         
        var max = target.attr('title');        
        var len = $(this).val().length;    
        var remain = max - len;     

        if(len > 0){
            btn_publish.removeClass('disabled');
        } else{
            btn_publish.addClass('disabled');
        }

        target.html(remain); 
    }); 

});

