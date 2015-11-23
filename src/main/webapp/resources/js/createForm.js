$(document).ready(function () {
    var check = true;

    $("input[name=age]").keyup(function checkAge(input) {
        var value = this.value;
        var forbiddenSymbs = /[^0-9]/;
        if (forbiddenSymbs.test(value)) {
            $(this).val(value.replace(forbiddenSymbs, ''));
        }
    });

    var chkEnter = function () {
        result = true;
        if (check) {
            $.each($("input.required"), function (i, field) {
                if (!field.value) {
                    field.focus();
                    result = false;
                    return result;
                }
            });
        }
        return result;
    };

    $("form[role='form']").submit(function () {
        if (!chkEnter()) return false;
    });

    $('button').click(function () {
        if ($(this).attr('type') == 'submit') {
            check = true;
        } else {
            check = false;
        };
        $("input[name='makeUpdate']").val(check);
    });

});
