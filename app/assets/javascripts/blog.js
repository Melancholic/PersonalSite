$(document).ready(function(){
    $.getJSON( "/blog/categories", function( data ) {
        for(i in data){
            console.log(data[i])
            if(data[i].parrent_id==null){
                alert("IS NUL");
                $("#categories_tree").append('\
                    <li><label class="tree-toggle nav-header">'+data[i].title+'</label>\
                    <ul class="nav nav-list tree" id="' +data[i].id+'childs" >\
                    </ul>\
                    </li>\
                    ')
            }else{
                $("#"+data[i].parrent_id+"childs").append('\
                    <li><a href="'+data[i].url+'">'+data[i].title+'</a></li>\
                    ')
            }
        }
        //for categories tree
        $('.tree-toggle').click(function () {
            $(this).parent().children('ul.tree').toggle(200);
        });
        $(function(){
            $('.tree-toggle').parent().children('ul.tree').toggle(200);
        })
    });
});

