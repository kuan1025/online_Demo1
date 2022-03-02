<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addBook.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/ajaxfileupload.js"></script>
</head>
<script type="text/javascript">

    // ajax 非同步照片返回顯示
    function fileChange() {//注意：不能使用jQuery中的change事件，因為只觸發一次，因此使用：onchange
        $.ajaxFileUpload({
            url: "${pageContext.request.contextPath}/prod/ajaxImg.action",
            //是否接受安全協議
            secureuri: false,
            // 要上傳的檔案id
            fileElementId: "pimage",
            // 返回屬性
            dataType: "json",
            success: function (obj) {

                // 建立圖片標籤
                var imgObj = $("<img>");
                imgObj.attr("src", "/image_big/" + obj.imgurl);
                imgObj.attr("width", "100px");
                imgObj.attr("height", "100px");
                // 將圖片追加到imgDiv中
                $("#imgDiv").append(imgObj);
            }
        })
    }
</script>
<body>


<div id="addAll">
    <div id="nav">
    </div>

    <div id="table">
        <form action="${pageContext.request.contextPath}/prod/save.action" enctype="multipart/form-data"
              method="post" id="myform">
            <input type="hidden" name="pimageName" id="pimageName"/>
            <table>
                <tr>
                    <td class="one">商品名稱</td>
                    <td><input type="text" name="pName" class="two"></td>
                </tr>
                <!--錯誤提示-->
                <tr class="three">
                    <td class="four"></td>
                    <td><span id="pnameerr"></span></td>
                </tr>
                <tr>
                    <td class="one">商品介紹</td>
                    <td><input type="text" name="pContent" class="two"></td>
                </tr>
                <!--錯誤提示-->
                <tr class="three">
                    <td class="four"></td>
                    <td><span id="pcontenterr"></span></td>
                </tr>
                <tr>
                    <td class="one">價格</td>
                    <td><input type="number" name="pPrice" class="two"></td>
                </tr>
                <!--錯誤提示-->
                <tr class="three">
                    <td class="four"></td>
                    <td><span id="priceerr"></span></td>
                </tr>

                <tr>
                    <td class="three">產品圖片</td>
                    <td><br>
                        <div id="imgDiv" style="display:block; width: 40px; height: 50px;">
                        </div>
                        <br><br><br><br>
                        <%--<input type="file" id="pimage" name="pimage" onchange="fileChange()">--%>
                        <input type="file" id="pimage" name="pimage" onchange="fileChange()">
                        <%--<span id="imgName" >

                        </span>--%>
                        <br>
                    </td>
                </tr>
                <tr class="three">
                    <td class="four"></td>
                    <td><span></span></td>
                </tr>

                <tr>
                    <td class="one">總數量</td>
                    <td><input type="number" name="pNumber" class="two"></td>
                </tr>

                <tr class="three">
                    <td class="four"></td>
                    <td><span id="numerr"></span></td>
                </tr>


                <tr>
                    <td class="one">類別</td>
                    <td>
                        <%--取 name 之後傳給後台--%>
                        <select name="typeId">
                            <c:forEach items="${typeList}" var="type">
                                <option value="${type.typeId}">${type.typeName}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>

                <tr class="three">
                    <td class="four"></td>
                    <td><span></span></td>
                </tr>

                <tr>
                    <td>
                        <input type="submit" value="送出" class="btn btn-success">
                    </td>
                    <td>
                        <input type="reset" value="取消" class="btn btn-default" onclick="myclose(${param.page})">
                        <script type="text/javascript">
                            function myclose(ispage) {
                                window.location = "${pageContext.request.contextPath}/prod/split.action?page=" + ispage;
                            }
                        </script>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>

</body>

</html>