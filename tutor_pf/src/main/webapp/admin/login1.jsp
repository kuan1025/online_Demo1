<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <title>會員登入</title>
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img1/favicon.ico"/>
    <!-- Font Awesome icons (free version)-->
    <script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" crossorigin="anonymous"></script>
    <!-- Google fonts-->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css"/>
    <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css"/>
    <!-- Core theme CSS (includes Bootstrap)-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css1/login.css"/>
<style>
    .gc{
        background-color: #212529;
        background-image: url("../img1/map-image.png");
        background-repeat: no-repeat;
        background-position: center;
    }
</style>
</head>

<body>
<!-- 帳號註冊-->
<form action="${pageContext.request.contextPath}/admin/login.action" method="post">
    <section class="gc">
        <div class="container py-5 h-50">
            <div class="row d-flex justify-content-center align-items-center h-50">
                <div class="col-12 col-md-8 col-lg-6 col-xl-5">
                    <div class="card bg-light text-black" style="border-radius: 1rem;">
                        <div class="card-body p-5 text-center">

                            <div class="mb-md-5 mt-md-4 pb-5">

                                <h2 class="fw-bold mb-2 text-uppercase">Login</h2>
                                <p class="text-dark-50 mb-5">使用者登入</p>

                                    <div class="form-outline form-white mb-4">
                                        <input type="text" placeholder="Username" name="name" class="form-control form-control-lg" value="admin"/>
                                        <label class="form-label text-black"></label>
                                    </div>

                                    <div class="form-outline form-white mb-4">
                                        <input type="password" placeholder="Password" value="123"  name="pwd" id="typePasswordX"
                                               class="form-control form-control-lg"/>
                                        <label class="form-label" for="typePasswordX"></label>
                                    </div>
                                    <p class="small mb-5 pb-lg-2" style="color: red">${errmsg}</p>
                                    <p class="small mb-5 pb-lg-2"><a class="text-dark-50" href="#!">Forgot password?</a>
                                    </p>

                                    <button class="btn btn-outline-dark btn-lg px-5" type="submit">Login</button>

                                <div class="d-flex justify-content-center text-center mt-4 pt-1">
                                    <a href="#!" class="text-dark logMark"><i class="fab fa-facebook-f fa-lg"></i></a>
                                    <a href="#!" class="text-dark logMark"><i class="fab fa-twitter fa-lg"></i></a>
                                    <a href="#!" class="text-dark logMark"><i class="fab fa-google fa-lg"></i></a>
                                </div>

                            </div>

                            <div>
                                <p class="mb-0">還沒有帳號 <a href="${pageContext.request.contextPath}/regist.jsp" class="text-dark-50 fw-bold">Sign Up</a></p>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</form>
</body>

</html>
