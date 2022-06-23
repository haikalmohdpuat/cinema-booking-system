<%-- 
    Document   : login
    Created on : 22 Apr 2022, 5:41:13 pm
    Project    : CINEMA BOOKING SYSTEM @ CSE3999
    Lecturer   : DR. NORAIDA BINTI HJ ALI
    Group      : GROUP 10

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT (@haikalmohdpuat)
2. NURIN NAZIFA BINTI ROHADI
3. NOR HIDAYAH BINTI MOHD DZAHIR
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/Customer/bootstrap.jsp"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body{
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #1E1E1E;
        }

        .container{
            position: relative;
            max-width: 430px;
            width: 100%;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            margin: 0 20px;
        }

        .container .forms{
            display: flex;
            align-items: center;
            height: 440px;
            width: 200%;
            transition: height 0.2s ease;
        }


        .container .form{
            width: 50%;
            padding: 30px;
            background-color: #fff;
            transition: margin-left 0.18s ease;
        }

        .container.active .login{
            margin-left: -50%;
            opacity: 0;
            transition: margin-left 0.18s ease, opacity 0.15s ease;
        }

        .container .signup{
            opacity: 0;
            transition: opacity 0.09s ease;
        }
        .container.active .signup{
            opacity: 1;
            transition: opacity 0.2s ease;
        }

        .container.active .forms{
            height: 600px;
        }
        .container .form .title{
            position: relative;
            font-size: 27px;
            font-weight: 600;
            font-family: cursive;
        }

        .form .title::before{
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            height: 3px;
            width: 30px;
            background-color: #571B7E;
            border-radius: 25px;
        }

        .form .input-field{
            position: relative;
            height: 50px;
            width: 100%;
            margin-top: 30px;
        }

        .input-field input{
            position: absolute;
            height: 100%;
            width: 100%;
            padding: 0 35px;
            border: none;
            outline: none;
            font-size: 16px;
            border-bottom: 2px solid #ccc;
            border-top: 2px solid transparent;
            transition: all 0.2s ease;
        }

        .input-field input:focus{
            border-bottom-color: #571B7E;
        }

        .input-field i{
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
            font-size: 23px;
            transition: all 0.2s ease;
        }

        .input-field input:focus ~ i{
            color: #571B7E;
        }

        .input-field i.icon{
            left: 0;
        }
        .input-field i.showHidePw{
            right: 0;
            cursor: pointer;
            padding: 10px;
        }

        .form .checkbox-text{
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: 20px;
        }

        .checkbox-text .checkbox-content{
            display: flex;
            align-items: center;
        }

        .checkbox-content input{
            margin: 0 8px -2px 4px;
            accent-color: #571B7E;
        }

        .form .text{
            color: #333;
            font-size: 14px;
        }

        .form a.text{
            color: #571B7E;
            text-decoration: none;
        }
        .form a:hover{
            text-decoration: underline;
        }

        .form .button{
            margin-top: 35px;
        }

        .form .button input{
            border: none;
            color: #fff;
            font-size: 17px;
            font-weight: 500;
            letter-spacing: 1px;
            border-radius: 6px;
            background-color: #571B7E;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .button input:hover{
            background-color: #C38Ec7;
        }

        .form .login-signup{
            margin-top: 30px;
            text-align: center;
        }   
    </style>
</head>
<body>
    <div class="container">
        <div class="forms">
            <div class="form login">
                <span class="title">Login</span>
                <form action="../UserController?action=login" method="post">
                    <div class="input-field">
                        <input type="text" name="logID" placeholder="Enter your ID" required>
                        <i class="uil uil-chat-bubble-user icon"></i>
                    </div>
                    <div class="input-field">
                        <input type="password" name="logPassword" class="password" placeholder="Enter your password" required>
                        <i class="uil uil-lock icon"></i>
                        <i class="uil uil-eye-slash showHidePw"></i>
                    </div><br>
                    
            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <label class="input-group-text text-dark" for="inputGroupSelect01">Role</label>
                </div>
                <select name="logRole" class="custom-select" id="inputGroupSelect01">
                    <option value="customer" selected="">Customer</option>
                    <option value="admin">Admin</option>
                </select>
            </div>            

                    <div class="input-field button">
                        <input type="submit" name="action" value="Login">
                    </div>
                </form>
                

                <div class="login-signup">
                    <span class="text">Not a member?
                        <a href="#" class="text signup-link">Signup now</a>
                    </span>
                </div>
            </div>

<!--             Registration Form -->
            <div class="form signup">
                <span class="title">Registration</span>

                <form action="../UserController?action=register" method="post">
                    <div class="input-field">
                        <input type="text" name="logName" placeholder="Enter your name" required>
                        <i class="uil uil-user"></i>
                    </div>
                    <div class="input-field">
                        <input type="text" name="logEmail" placeholder="Enter your email" required>
                        <i class="uil uil-envelope icon"></i>
                    </div>
                    <div class="input-field">
                        <input type="text" name="logMobileNumber" placeholder="Enter your mobile number" required>
                        <i class="uil uil-phone icon"></i>
                    </div>                    
                    <div class="input-field">
                        <input type="password" name="createPassword" class="password" placeholder="Create a password" required>
                        <i class="uil uil-lock icon"></i>
                    </div>


                    <div class="input-field button">
                        <input type="submit" name="action" value="Sign Up">
                    </div>
                </form>

                <div class="login-signup">
                    <span class="text">Already have an account?
                        <a href="#" class="text login-link">Login now</a>
                    </span>
                </div>
            </div>
        </div>
    </div>
    <script> 
        const container = document.querySelector(".container"),
      pwShowHide = document.querySelectorAll(".showHidePw"),
      pwFields = document.querySelectorAll(".password"),
      signUp = document.querySelector(".signup-link"),
      login = document.querySelector(".login-link");

    //   js code to show/hide password and change icon
    pwShowHide.forEach(eyeIcon =>{
        eyeIcon.addEventListener("click", ()=>{
            pwFields.forEach(pwField =>{
                if(pwField.type ==="password"){
                    pwField.type = "text";

                    pwShowHide.forEach(icon =>{
                        icon.classList.replace("uil-eye-slash", "uil-eye");
                    });
                }else{
                    pwField.type = "password";

                    pwShowHide.forEach(icon =>{
                        icon.classList.replace("uil-eye", "uil-eye-slash");
                    });
                }
            }) ;
        });
    });

    // js code to appear signup and login form
    signUp.addEventListener("click", ( )=>{
        container.classList.add("active");
    });
    login.addEventListener("click", ( )=>{
        container.classList.remove("active");
    });
    </script>
</body>
</html>

