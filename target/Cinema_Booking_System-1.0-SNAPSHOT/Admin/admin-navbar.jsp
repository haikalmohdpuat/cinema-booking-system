<%-- 
    Document   : navbar
    Created on : 23 Apr 2022, 12:58:08 pm
    Project    : CINEMA BOOKING SYSTEM @ CSE3999
    Lecturer   : DR. NORAIDA BINTI HJ ALI
    Group      : GROUP 10

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT (@haikalmohdpuat)
2. NURIN NAZIFA BINTI ROHADI
3. NOR HIDAYAH BINTI MOHD DZAHIR
--%>

<%@page import="model.Admin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="../Customer/bootstrap.jsp"/>
<%@page import="java.io.Serializable"%>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
        <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/solid.js" integrity="sha384-tzzSw1/Vo+0N5UhStP3bvwWPq+uvzCMfrN1fEFe+xBmv1C/AtVX5K0uZtmcHitFZ" crossorigin="anonymous"></script>
        <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/fontawesome.js" integrity="sha384-6OIrr52G08NpOFSZdxxz1xdNSndlD4vdcf/q2myIUVO0VsqaGHJsB0RaBE01VTOY" crossorigin="anonymous"></script>
        <style>
            @import "https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700";
            body {
                font-family: 'Poppins', sans-serif;
                background: black;
            }

            p {
                font-family: 'Poppins', sans-serif;
                font-size: 1.5em;
                font-weight: 300;
                line-height: 1.7em;
                color: #999;
            }

            td{
                font-size: 1em;
            }

            a,
            a:hover,
            a:focus {
                color: inherit;
                text-decoration: none;
                transition: all 0.3s;
            }

            .navbar {
                padding: 15px 10px;
                background: #36454F;
                border: none;
                border-radius: 0;
                margin-bottom: 40px;
                box-shadow: 1px 1px 3px rgba(0, 0, 0, 0.1);
            }

            .navbar-btn {
                box-shadow: none;
                outline: none !important;
                border: none;
            }

            .line {
                width: 100%;
                height: 1px;
                border-bottom: 1px dashed #ddd;
                margin: 40px 0;
            }

            i,
            span {
                display: inline-block;
            }

            /* ---------------------------------------------------
                SIDEBAR STYLE
            ----------------------------------------------------- */

            .wrapper {
                display: flex;
                align-items: stretch;
            }

            #sidebar {
                min-width: 180px;
                max-width: 180px;
                background: #571B7E;
                color: #fff;
                transition: all 0.3s;
            }

            #sidebarCollapse {
                background: black;
            }

            #sidebar.active {
                min-width: 80px;
                max-width: 80px;
                text-align: center;
            }

            #sidebar.active .sidebar-header h3,
            #sidebar.active .CTAs {
                display: none;
            }

            #sidebar.active .sidebar-header strong {
                display: block;
            }

            #sidebar ul li a {
                text-align: left;
            }

            #sidebar.active ul li a {
                padding: 20px 10px;
                text-align: center;
                font-size: 0.85em;
            }

            #sidebar.active ul li a i {
                margin-right: 0;
                display: block;
                font-size: 1.8em;
                margin-bottom: 5px;
            }

            #sidebar.active ul ul a {
                padding: 10px !important;
            }

            #sidebar .sidebar-header {
                padding: 20px;
                background: #6d7fcc;
            }

            #sidebar .sidebar-header strong {
                display: none;
                font-size: 1.8em;
            }

            #sidebar ul li a {
                padding: 10px;
                font-size: 1.1em;
                display: block;
            }

            #sidebar ul li a:hover {
                color: #7386D5;
                background: #fff;
            }

            #sidebar ul li a i {
                margin-right: 10px;
            }

            #sidebar ul li.active>a,
            a[aria-expanded="true"] {
                color: #fff;
                background: #BF40BF;
                ;
            }

            a[data-toggle="collapse"] {
                position: relative;
            }

            ul ul a {
                font-size: 1.1em !important;
                padding-left: 30px !important;
                background: #6d7fcc;
            }

            modal-body-profile {
                display: block !important;
            }

            .modal-title, .modal-header {
                background-color: #571B7E !important;
                color: white !important;
            }

            .modal-body-profile label {
                color: black !important;
                display: block !important;
            }

            .modal-body-profile input {
                width: 100% !important;
            }

            /* ---------------------------------------------------
                CONTENT STYLE
            ----------------------------------------------------- */

            #content {
                width: 100%;
                padding: 20px;
                min-height: 100vh;
                transition: all 0.3s;
            }

            /* ---------------------------------------------------
                MEDIAQUERIES
            ----------------------------------------------------- */

            @media (max-width: 768px) {
                #sidebar {
                    min-width: 80px;
                    max-width: 80px;
                    text-align: center;
                    margin-left: -80px !important;
                }

                #sidebar.active {
                    margin-left: 0 !important;
                }
                #sidebar .sidebar-header h3,
                #sidebar .CTAs {
                    display: none;
                }
                #sidebar .sidebar-header strong {
                    display: block;
                }
                #sidebar ul li a {
                    padding: 20px 10px;
                }
                #sidebar ul li a span {
                    font-size: 0.85em;
                }
                #sidebar ul li a i {
                    margin-right: 0;
                    display: block;
                }
                #sidebar ul ul a {
                    padding: 10px !important;
                }
                #sidebar ul li a i {
                    font-size: 1.3em;
                }
                #sidebar {
                    margin-left: 0;
                }
                #sidebarCollapse span {
                    display: none;
                }
            }
        </style>
    </head>
    <body>
        <%
            Admin admin = (Admin) request.getSession().getAttribute("admin");
        %>
        <div class="modal fade" id="adminProfile" tabindex="-1" role="dialog" aria-labelledby="adminProfileLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="adminProfileLabel">Admin Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body modal-body-profile">
                        <label>Admin ID : </label>
                        <input type="text" disabled placeholder='<%=admin.getAdminID()%>'><br><br>
                        <label>Admin Name : </label>
                        <input type="text" disabled placeholder='<%=admin.getAdminName()%>'><br><br>
                        <label>Admin Email : </label>
                        <input type="text" disabled placeholder='<%=admin.getAdminEmail()%>'><br><br>
                        <label>Admin Password : </label>
                        <input type="password" disabled placeholder='<%=admin.getAdminPassword()%>'><br><br>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#sidebarCollapse').on('click', function () {
                    $('#sidebar').toggleClass('active');
                });
            });
        </script>
    </body>

</html>