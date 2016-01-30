$(document).ready(function(){
    var x={};
    if(document.location.pathname.match(/categories\/([0-9]+)/)){
        x.id= document.location.pathname.match(/categories\/([0-9]+)/)[1];
    }
    $.getJSON( "/blog/categories",x, function( data ) {
        for(i in data){
            $('#treeview').treeview({
                data: data,         // data is not optional
                levels: 2,
                backColor: '#999',
                onhoverColor: '#777',
                color: '#fff',
                selectedBackColor: '#555',
                enableLinks:true,
                showTags: true
            });
            $('#treeview').on('nodeSelected', function(event, data) {
              document.location=data.href
            });
            var x=$('#treeview').treeview('getSelected')[0];
            do {
                x=$('#treeview').treeview('getParent',x)
                $('#treeview').treeview('expandNode',[x, { silent: true }]);
            }while(x.parentId)
            
        }
    });
});

