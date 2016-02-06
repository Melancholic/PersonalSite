CKEDITOR.plugins.add( 'codearea', {
    icons: 'code',
    init: function( editor ) {
        editor.addCommand( 'insertCodeTag', {
            exec: function( editor ) {
                selection = editor.getSelection();
                if (selection.getType() == CKEDITOR.SELECTION_ELEMENT) {
                    selectedContent = selection.getSelectedElement().getAttribute("alt");
                }
                else if (selection.getType() == CKEDITOR.SELECTION_TEXT) {
                    selectedContent = selection.getSelectedText();
                }
                editor.insertHtml( '<pre> <code>' +selectedContent  + '</code> </pre>' );
            }
        });
        editor.ui.addButton( 'Code', {
            label: 'Insert Code',
            command: 'insertCodeTag',
            toolbar: 'insert'
        });
    }
});