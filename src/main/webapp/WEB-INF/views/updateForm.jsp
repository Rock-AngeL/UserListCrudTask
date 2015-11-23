<%@ taglib uri='http://www.springframework.org/tags/form' prefix='form' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN' 'http://www.w3.org/TR/html4/loose.dtd'>
<html>
<head>
    <title>Редактирование пользователя</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!----------------------------------- bootstrap ------------------------------------------------------------------->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
    <!----------------------------------------------------------------------------------------------------------------->
    <!--Мои стили------------------------------------------------------------------------------------------------------>
    <link type='text/css' rel='stylesheet'
          href='${pageContext.request.contextPath}/resources/css/createForm.css'>
</head>
<body>

<div class="container">
    <h2>Редактирование пользователя</h2>
    <form:form role="form" modelAttribute="user" action='update' accept-charset='utf-8'>
        <div class="form-group">
            <label>ID:</label>
            <input type="text" disabled class="form-control" value=${user.id}>
            <input name="createdDate" type="hidden" value=${user.createdDate}>
            <input name="id" type="hidden" value=${user.id}>
            <input name="makeUpdate" type="hidden" value=''>
        </div>
        <div class="form-group">
            <label>Имя:</label>
            <input name="source" type="hidden" value=${source}>
            <form:input path="name" type="text" class="form-control required"/>
            <c:if test="${name_err==1}">
                <input type="text" disabled class="form-control warning" value="Минимальная длина - 3 символа">
            </c:if>
            <c:if test="${name_err==2}">
                <input type="text" disabled class="form-control warning" value="Максимальная длина - 25 символа">
            </c:if>
        </div>
        <div class="form-group">
            <label>Возраст:</label>
            <form:input path="age" type="text" class="form-control required" />
            <c:if test="${age_err==1}">
                <input type="text" disabled class="form-control warning" value="Возрастной ценз - не менее 5 лет">
            </c:if>
            <c:if test="${age_err==2}">
                <input type="text" disabled class="form-control warning" value="Возрастной ценз - не более 100 лет">
            </c:if>
        </div>
        <div class="checkbox">
            <form:checkbox path="isAdmin" label = "Администратор"/>
        </div>
        <div id=submit>
            <button type="submit" class="btn btn-default">Готово</button>
            <button class="btn btn-default">Назад</button>
        </div>
    </form:form>
</div>

<!--------------------------------------------------------------------------------------------------------------------->
<!-- jQuery -->
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<!--bootstrap-->
<script type="text/javascript" src='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js'></script>
<!--мои скрипты-->
<script type="text/javascript" src="resources/js/createForm.js"></script>
</body>
</html>
