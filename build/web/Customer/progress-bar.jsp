<%-- 
    Document   : completion-bar
    Created on : 7 May 2022, 4:36:18 pm
    Project    : CINEMA BOOKING SYSTEM @ CSE3999
    Lecturer   : DR. NORAIDA BINTI HJ ALI
    Group      : GROUP 10

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT (@haikalmohdpuat)
2. NURIN NAZIFA BINTI ROHADI
3. NOR HIDAYAH BINTI MOHD DZAHIR
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.Serializable"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            body {
              background-color: black;
            }

            .rings {
                display: flex;
                justify-content: center;
                align-items: center;
            }
            
            .completed, .current, .next {
                margin: 0 40px 0;
                width: 50px;
                height: 50px;
                background: #C38EC7;
                border-radius: 50%;
                color: #C38EC7;
            }
                        
            .current {
                background: black;
                border: 8px solid #C38EC7;
            }
            
            .next {
                background: black;
                border: 8px solid gray;
                color: gray;
            }

            .text {
                text-align: center;
                color: white;
                font-weight: bold;
                margin-bottom: 4px;
            }
            
            .connector{
                color: #C38EC7;
                font-size: 20px;
                font-weight: bold;
                margin-top: 12px;
            }
         
            .fa-check {
                color: black;
                font-size: 20px;
                font-weight: 800;
                margin-left: 17px;
                margin-top: 15px;
            }
        </style>
    </head>
</html>
