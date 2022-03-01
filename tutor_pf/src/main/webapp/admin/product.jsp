<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@page import="java.util.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <script type="text/javascript">
        if ("${msg}" != "") {
            alert("${msg}");
        }
    </script>

    <c:remove var="msg"></c:remove>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bright.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addBook.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <title></title>
</head>
<script type="text/javascript">
    //選擇全部
    function allClick() {
        // 取得勾選狀態
        var flag = $("#all").prop("checked");
        // 其他產品狀態
        $("input[name='ck']").each(function () {
            this.checked = flag;
        })
    }

    //單一勾選格 判斷全部選擇
    function ckClick() {
        //取得前五個複選格
        var ck = $("input[name='ck']").length;
        //有被選
        var chked = $("input[name='ck']:checked").length;
        //做比對
        if (ck == chked) {
            $('#all').prop("checked", true);
        } else {
            $('#all').prop("checked", false);
        }
    }
</script>
<body style="margin: 10px 10px">
<div id="brall">
    <div id="condition" style="text-align: center">
        <%--		action="${pageContext.request.contextPath}/prod/condition.action" method="post" --%>
        <form id="myform" style="padding-top: 15px">
            <br><br><br>
            商品名稱：<input id="pname" name="pname">&nbsp;&nbsp;&nbsp;
            商品類型：<select id="typeid" name="typeid">
            <option value="-1">請選擇</option>
            <c:forEach items="${typeList}" var="pt">
                <option value="${pt.typeId}">${pt.typeName}</option>
            </c:forEach>
                    </select>&nbsp;&nbsp;&nbsp;
            價格區間：<input id="lprice" name="lprice" placeholder="輸入最低價格"> ~ <input id="hprice" name="hprice"
                                                                                 placeholder="輸入最高價格">
            <input type="button" value="查詢" onclick="condition()">
        </form>
    </div>
    <br>
    <div id="table">

        <c:choose>
            <c:when test="${info.list.size()!=0}">

                <div id="top">
                    <input type="checkbox" id="all" onclick="allClick()" style="margin-left: 50px">&nbsp;&nbsp選擇全部
                    <a href="${pageContext.request.contextPath}/admin/addproduct.jsp">

                        <input type="button" class="btn btn-warning" id="btn1"
                               value="新增商品">
                    </a>
                    <input type="button" class="btn btn-warning" id="btn1"
                           value="勾選移除" onclick="deleteBatch()">
                </div>
                <!--顯示分頁商品-->
                <div id="middle">
                    <table class="table table-bordered table-striped">
                        <tr>
                            <th></th>
                            <th>商品名稱</th>
                            <th>商品介绍</th>
                            <th>價格</th>
                            <th>商品圖片</th>
                            <th>商品數量</th>
                            <th>編輯</th>
                        </tr>
                        <c:forEach items="${info.list}" var="p">
                            <tr>
                                <td valign="center" align="center">
                                    <input type="checkbox" name="ck" id="ck" value="${p.pId}" onclick="ckClick()"></td>
                                <td>${p.pName}</td>
                                <td>${p.pContent}</td>
                                <td>${p.pPrice}</td>
                                <td><img width="55px" height="45px"
                                         src="${pageContext.request.contextPath}/image_big/${p.pImage}"></td>
                                <td>${p.pNumber}</td>

                                <td>
                                    <button type="button" class="btn btn-info "
                                            onclick="one(${p.pId},${info.pageNum})">編輯
                                    </button>
                                    <button type="button" class="btn btn-warning" id="mydel"
                                            onclick="del(${p.pId},${info.pageNum})">刪除
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                    <!--分頁欄位-->
                    <div id="bottom">
                        <div>
                            <nav aria-label="..." style="text-align:center;">
                                <ul class="pagination">
                                    <li>
                                            <%--                                        <a href="${pageContext.request.contextPath}/prod/split.action?page=${info.prePage}" aria-label="Previous">--%>
                                        <a href="javascript:ajaxsplit(${info.prePage})" aria-label="Previous">

                                            <span aria-hidden="true">«</span></a>
                                    </li>
                                        <%--									頁碼 --%>
                                    <c:forEach begin="1" end="${info.pages}" var="i">
                                        <c:if test="${info.pageNum==i}">
                                            <%--											如果目前頁數等於現在頁數 就會顯示下面的li--%>
                                            <li>
                                                    <%--                                                <a href="${pageContext.request.contextPath}/prod/split.action?page=${i}" style="background-color: grey">${i}</a>--%>
                                                <a href="javascript:ajaxsplit(${i})"
                                                   style="background-color: grey">${i}</a>
                                            </li>
                                        </c:if>
                                        <c:if test="${info.pageNum!=i}">
                                            <%--											如果 目前頁數等於現在頁數 就會顯示下面的l--%>
                                            <li>
                                                    <%--                                                <a href="${pageContext.request.contextPath}/prod/split.action?page=${i}">${i}</a>--%>
                                                <a href="javascript:ajaxsplit(${i})">${i}</a>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                    <li>
                                            <%--  <a href="${pageContext.request.contextPath}/prod/split.action?page=1" aria-label="Next">--%>
                                        <a href="javascript:ajaxsplit(${info.nextPage})" aria-label="Next">
                                            <span aria-hidden="true">»</span></a>
                                    </li>
                                    <li style=" margin-left:150px;color: #0e90d2;height: 35px; line-height: 35px;">總共&nbsp;&nbsp;&nbsp;<font
                                            style="color:orange;">${info.pages}</font>&nbsp;&nbsp;&nbsp;頁&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <c:if test="${info.pageNum!=0}">
                                            目前&nbsp;&nbsp;&nbsp;<font
                                            style="color:orange;">${info.pageNum}</font>&nbsp;&nbsp;&nbsp;頁&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </c:if>
                                        <c:if test="${info.pageNum==0}">
                                            目前&nbsp;&nbsp;&nbsp;<font
                                            style="color:orange;">1</font>&nbsp;&nbsp;&nbsp;頁&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </c:if>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div>
                    <h2 style="width:700px; text-align: center;color: salmon;margin-top: 100px">暫時沒有滿足需求的產品！</h2>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>

<script type="text/javascript">
    function mysubmit() {
        $("#myform").submit();
    }

    //勾選刪除
    function deleteBatch() {

        // 取得有勾選的商品
        var cks = $("input[name='ck']:checked");
        // 如果有選中 ， concat 商品id 以String傳到controller
        if (cks.length == 0) {
            alert("你沒有做勾選喔!!!")
        } else {
            var str = "";
            var id = "";
            if (confirm("你確定要刪除 " + cks.length + " 個商品 ?")) {
                // alert("可以進行刪除")
                // 做concat
                $.each(cks, function () {
                    pid = $(this).val(); //被選中的id
                    // 防null
                    if (pid != null) {
                        str += pid + ",";
                    }
                });
                $.ajax({
                    url: "${pageContext.request.contextPath}/prod/deleteBatch.action",
                    data: {"pids": str},
                    type: "post",
                    dataType: "text",
                    success: function (msg) {
                        alert(msg);
                        $("#table").load("http://localhost:8080/admin/product.jsp #table");
                    }
                })
            }
        }
        // ajax request

    }

    //刪除一個
    function del(pid, page) {
        // 刪除警告
        if (confirm("確定要刪除該產品 ?")) {
            var pname = $("#pname").val();
            var typeid = $("#typeid").val();
            var lprice = $("#lprice").val();
            var hprice = $("#hprice").val();
            // ajax request
            $.ajax({
                url: "${pageContext.request.contextPath}/prod/delete.action",
                data: {
                    "pid":pid,
                    "page": page,
                    "pname": pname,
                    "typeid": typeid,
                    "lprice": lprice,
                    "hprice": hprice
                },
                type: "post",
                dataType: "text",
                success: function (msg) {
                    alert(msg);
                    //只在table load
                    $("#table").load("http://localhost:8080/admin/product.jsp #table");
                }
            })
        }
    }

    // 更新
    function one(pid, page) {
        // 查詢條件
        var pname = $("#pname").val();
        var typeid = $("#typeid").val();
        var lprice = $("#lprice").val();
        var hprice = $("#hprice").val();

        var str = "?pid="+pid+
                  "&pname="+pname+
                  "&typeid="+typeid+
                  "&lprice="+lprice+
                  "&hprice="+hprice+
                   "&page="+page;
        console.log("${pageContext.request.contextPath}/prod/one.action"+str);
        // 向伺服器交出請求，傳商品id
        location.href = "${pageContext.request.contextPath}/prod/one.action"+str;
    }
</script>
<!--分頁ajax方法-->
<script type="text/javascript">
    function ajaxsplit(page) {
        // 像伺服器做ajax request 並在目前頁面做非同步顯示
        // 1. link jquery
        // 2.
        var pname = $("#pname").val();
        var typeid = $("#typeid").val();
        var lprice = $("#lprice").val();
        var hprice = $("#hprice").val();

        $.ajax({
            url: "${pageContext.request.contextPath}/prod/ajaxSplit.action",
            data: {"page": page,
                "pname": pname,
                "typeid": typeid,
                "lprice": lprice,
                "hprice": hprice
            },
            type: "post",
            // 重新載入 局部  所以要找相對應的標籤
            success: function () {
                // 表示重新載入url 並指在#table做重新載入
                $("#table").load("http://localhost:8080/admin/product.jsp #table")
            }
        })

    }

    function condition() {
        // 取得條件
        var pname = $("#pname").val();
        var typeid = $("#typeid").val();
        var lprice = $("#lprice").val();
        var hprice = $("#hprice").val();

        $.ajax({
            url: "${pageContext.request.contextPath}/prod/ajaxSplit.action",
            type: "post",
            data: {
                "pname": pname,
                "typeid": typeid,
                "lprice": lprice,
                "hprice": hprice
            },
            // 返回data 已到session
            success: function () {
                console.log('here');
                // 重整頁面
                $("#table").load("http://localhost:8080/admin/product.jsp #table");
            }
        })
    }
</script>

</html>