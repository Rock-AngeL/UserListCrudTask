<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html >
<html ng-app="userCRUDApp">
<head>

    <title>Список пользователей</title>
    <meta content="text/html;charset=UTF-8">
    <!-- ======================================== bootstrap ============================================================ -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
    <!--=================================================================================================================-->
    <!-- ======================================== Angularjs ============================================================ -->
    <script src="http://code.angularjs.org/1.1.5/angular.min.js"></script>
    <!-- ======================================== для работы с $resource =============================================== -->
    <script src="http://code.angularjs.org/1.1.5/angular-resource.min.js"></script>
    <!-- ======================================== ========= ============================================================ -->
    <script type='text/javascript' src='${pageContext.request.contextPath}/resources/myTableAngular/js/userList-myTableAngular-ini.js'></script>
    <link type='text/css' rel='stylesheet'
          href='${pageContext.request.contextPath}/resources/myTableAngular/css/style.css'>
</head>
<body >
<div class="container" ng-controller="userCRUDController">

    <h2>Список пользователей</h2>

    <div id="main-panel" class="panel-group" style="margin-bottom: 100px;">
        <div class="panel panel-default">
            <div class="panel-heading">
                <div>
                    <form action='createForm?source=userList-myTableAngular' method="get">
                        <button id='createForm' class="btn btn-default">
                            Добавить пользователя
                        </button>
                    </form>
                </div>
            </div>
            <div class="panel-body">
                <div class="well well-sm">
                    <div id="table-header" class="container-fluid">
                        <div class="row">
                            <div class="col-xs-1">
                                <p>
                                    ID
                                </p>
                            </div>
                            <div class="col-xs-4">
                                <p>
                                    Имя
                                </p>
                            </div>
                            <div class="col-xs-1">
                                <p>
                                    Возраст
                                </p>
                            </div>
                            <div class="col-xs-2">
                                <p>
                                    Дата создания
                                </p>
                            </div>
                            <div class="col-xs-1">
                                <p>
                                    Админ
                                </p>
                            </div>
                            <div class="col-xs-1">
                                <p>
                                </p>
                            </div>
                            <div class="col-xs-1">
                                <p>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="table-body" class="container-fluid">
                    <div id=pageBlock>
                        <div class="row table-row" ng-repeat="user in userList">
                            <div class="col-xs-1 user-id"><p>{{user.id}}</p></div>
                            <div class="col-xs-4 user-name"><p>{{user.name}}</p></div>
                            <div class="col-xs-1"><p>{{user.age}}</p></div>
                            <div class="col-xs-2 user-date"><p>{{user.createdDate | date}}</p></div>
                            <!-- чтобы работал ng-if нужна версия 1.1.5+ -->
                            <div class="col-xs-2 user-date"><img ng-if="user.isAdmin" src="resources/images/admin.png"/></div>
                            <div class="col-xs-1"><a id='update'
                                                     href='updateForm?id={{user.id}}&source=userList-myTableAngular'><img
                                    src="resources/images/edit.png"/></a></div>
                            <div class="col-xs-1"><a id='delete' href='#' ng-click="deleteUser({{user.id}})"><img
                                    src="resources/images/trash.png"/></a></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-xs-3 user-id">

                        <label for="order-field">
                            Сортировать по полю:
                        </label>
                        <select class="form-control" id="order-field" ng-model="orderField" ng-change="getPageList()" ng-options="variant.fieldDescr for variant in orderFieldVariants"></select>

                        <div class="checkbox">
                            <label class="checkbox-inline">
                                <input id=desc-order type="checkbox"  ng-model="orderFieldDesc" ng-change="getPageList()" ng-init="orderFieldDesc=false">
                                по убыванию
                            </label>
                        </div>
                    </div>
                    <div class="col-xs-1 user-id">
                    </div>
                    <div class="col-xs-3 user-id">
                        <label for="search-field">
                            Искать по полю:
                        </label>
                        <select class="form-control" id="search-field" ng-model="filterField" ng-options="variant.fieldDescr for variant in filterFieldVariants"></select>

                        <div class="checkbox">
                            <label class="checkbox-inline">
                                <input id=strict-search type="checkbox" ng-model="strictFilter" ng-init="strictFilter=false" >
                                Строгий поиск
                            </label>
                        </div>
                    </div>
                    <div class="col-xs-5 user-id">
                        <label for="search-field-enter">
                            Значение для поиска
                        </label>

                        <div class="input-group" id='search-field-enter'>
                            <input type="text" class="form-control" ng-model = "filterFieldValue" placeholder="Search" name="srch-term" id="srch-term">

                            <div class="input-group-btn">
                                <button id=do-search class="btn btn-default" type="button" ng-click = "applyFilter()">
                                    <i
                                            class="glyphicon glyphicon-search">
                                    </i>
                                </button>
                                <button id=do-refresh class="btn btn-default" type="button" ng-click = "refreshPageList()">
                                    <i
                                            class="glyphicon glyphicon-refresh">
                                    </i>
                                </button>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <nav class="navbar navbar-inverse navbar-fixed-bottom">
        <div class="panel panel-default">
            <div class="panel-footer">
                <div class="row">
                    <div class="col-xs-6">
                    </div>
                    <div class="col-xs-6">
                        <div class="btn-toolbar" role="toolbar">
                            <div id="btn-left-group" class="btn-group">
                                <button id="btn-left" class="btn btn-default" ng-click="moveButton(-1)">
                                    &lang;
                                </button>
                            </div>

                            <div id="btn-less-group" class="btn-group ">
                                <button class="btn btn-default disabled" ng-hide="startNumber==1">
                                    ...
                                </button>
                            </div>

                            <div id="btn-main-group" class="btn-group">
                                <button class="btn btn-default pagination-btn" ng-repeat="butt in buttons" ng-class="butt.active" ng-click="setButton(butt.number)"> {{butt.number}} </button>
                            </div>

                            <div id="btn-more-group" class="btn-group">
                                <button class="btn btn-default disabled" ng-hide="endNumber==pagesCount">
                                    ...
                                </button>
                            </div>

                            <div id="btn-right-group" class="btn-group">
                                <button id="btn-right" class="btn btn-default" ng-click="moveButton(1)">
                                    &rang;
                                </button>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </nav>

</div>



<!-- jQuery -->
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<!--bootstrap-->
<script type="text/javascript"
        src='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js'></script>

</body>



</html>
