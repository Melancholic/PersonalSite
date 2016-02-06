$(document).ready(function(){
    hljs.initHighlightingOnLoad();
    $('pre code').each(function(i, block) {
        hljs.highlightBlock(block);
    });
    $(".fancybox").fancybox( {padding : 0, closeClick: true});
});
