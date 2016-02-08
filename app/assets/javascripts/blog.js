$(document).ready(function(){
    hljs.initHighlightingOnLoad();
    $('pre code').each(function(i, block) {
        hljs.highlightBlock(block);
    });
    $(".fancybox").fancybox( {padding : 0, closeClick: true});

    $(".panel-heading > .panel-title > .minimize").on('click', function(e){
        $(this).parent().parent().parent().children('.panel-body').toggle();
        $(this).children('i.fa').toggleClass('fa-chevron-up fa-chevron-down');
    });

});
