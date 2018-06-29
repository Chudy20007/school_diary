
window.onload = "sprawdz()";

function sprawdz() {
    var elements = document.getElementById("form").elements;

    for (var i = 0; i < elements.length; i++) {
        var item = elements.item(i);
        console.log(item.value);
        switch (item.type) {
            case "text":
            {
                if (sprawdzTekst(item.value))
                    document.forms.form.elements[i].style.backgroundColor = "#4ef442";
                else
                    document.forms.form.elements[i].style.backgroundColor = "#f44c2e";

                break;
            }

            case "email":
            {
                if (sprawdzEmail(item.value))
                    document.forms.form.elements[i].style.backgroundColor = "#4ef442";
                else
                    document.forms.form.elements[i].style.backgroundColor = "#f44c2e";
                break;
            }

            case "password":
            {
                if (sprawdzHaslo(item.value))
                    document.forms.form.elements[i].style.backgroundColor = "#4ef442";
                else
                    document.forms.form.elements[i].style.backgroundColor = "#f44c2e";
                break;
            }


            case "number":
            {
                if (sprawdzNumer(item.value))
                    document.forms.form.elements[i].style.backgroundColor = "#4ef442";
                else
                    document.forms.form.elements[i].style.backgroundColor = "#f44c2e";
                break;
            }


        }
    }
    var bool = true;
    for (var i = 0; i < elements.length; i++) {
        var item = elements.item(i);
        if (document.forms.form.elements[i].style.backgroundColor == "rgb(244, 76, 46)")
            bool = false;
    }
    console.log(bool);
    if (bool)
        document.getElementById("form").submit();
    else
        return false;
}
function sprawdzHaslo(wartosc) {
    var emailReg = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])\w{6,}$/;
    var codeReg = /[0-9]{2}-[0-9]{3}/g;
    if (emailReg.test(wartosc) || codeReg.test(wartosc))
        return true;
    else
        return false;
}

function sprawdzTekst(wartosc) {
    var nameReg = /^[a-zA-Z]{3,}$/;
    var codeReg = /[0-9]{2}-[0-9]{3}/g;
    var name2Reg = /^[a-zA-Z]{3,}/;
    var dateReg = /[0-9]{4}-[0-9]{2}-[0-9]{2}/g;
    if (nameReg.test(wartosc) || codeReg.test(wartosc) || dateReg.test(wartosc) || name2Reg.test(wartosc))
        return true;
    else
        return false;
}

function sprawdzNumer(wartosc) {
    var name2Reg = /^\d{11,11}$/;
    var nameReg = /^\d{1,}$/;
    if (nameReg.test(wartosc) || name2Reg.test(wartosc))
        return true;
    else
        return false;
}

function sprawdzEmail(wartosc) {
    var mailReg = /^[0-9a-zA-Z_.-]+@[0-9a-zA-Z.-]+\.[a-zA-Z]{2,3}$/i;
    if (mailReg.test(wartosc))
        return true;
    else
        return false;
}

function sprawdzCheckbox(wartosc) {

}
