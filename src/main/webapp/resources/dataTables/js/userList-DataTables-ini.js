/**
 * Created by Valk on 10.08.15.
 */
$(document).ready(function () {
    //------------инициализация DataTables
    $('#table_id tfoot th').each(function () {
        $(this).html('<input type="text" placeholder=""/>');
    });

    var table = $('#table_id').DataTable({
        "language": {
            "processing": "Подождите...",
            "search": "Поиск:",
            "lengthMenu": "Показать _MENU_ записей",
            "info": "Записи с _START_ до _END_ из _TOTAL_ записей",
            "infoEmpty": "Записи с 0 до 0 из 0 записей",
            "infoFiltered": "(отфильтровано из _MAX_ записей)",
            "infoPostFix": "",
            "loadingRecords": "Загрузка записей...",
            "zeroRecords": "Записи отсутствуют.",
            "emptyTable": "В таблице отсутствуют данные",
            "paginate": {
                "first": "Первая",
                "previous": "Предыдущая",
                "next": "Следующая",
                "last": "Последняя"
            },
            "aria": {
                "sortAscending": ": активировать для сортировки столбца по возрастанию",
                "sortDescending": ": активировать для сортировки столбца по убыванию"
            }
        }
    });

    table.columns().every(function () {
        var that = this;
        $('input', this.footer()).on('keyup change', function () {
            that
                .search($(this).val())
                .draw();
        });
    });

    $("tbody td a[id^=deletelocal]").click(function () {
        var row = $(this).parentsUntil("tr").parent();
        var userId = row.children(".user-id").text();
        $.ajax({
            type: 'POST',
            url: 'delete?id=' + userId,
            data: 'id=' + userId,
            success: function (result) {
                $("#out").val($("#out").val() + " : " + result);
                if (result > 0) {
                    row.remove();
                }
            }
        });
    });
});
/*$("#out").val($("#out").val()+"  "+($(this).parentsUntil("tr").parent().children().eq(0).text()));*/