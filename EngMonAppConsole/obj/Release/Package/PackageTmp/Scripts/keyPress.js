function isCapslock(e) {

    e = (e) ? e : window.event;

    var charCode = false;

    if (e.which) {
        charCode = e.which;
    } else if (e.keyCode) {
        charCode = e.keyCode;
    }

    var shifton = false;
    if (e.shiftKey) {
        shifton = e.shiftKey;
    } else if (e.modifiers) {
        shifton = !!(e.modifiers & 4);
    }

    if (charCode >= 97 && charCode <= 122 && shifton) {
        document.getElementById("txtCapsMsg").value = "Caps Lock on";
       
        return true;
    }

    if (charCode >= 65 && charCode <= 90 && !shifton) {
        document.getElementById("txtCapsMsg").value = "Caps Lock on";
       
        return true;
    }

    document.getElementById("txtCapsMsg").value = "";
    return false;

}
