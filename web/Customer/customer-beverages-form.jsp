<%-- 
    Document   : customer-beverages-form
    Created on : 5 May 2022, 2:05:47 pm
    Project    : CINEMA BOOKING SYSTEM @ CSE3999
    Lecturer   : DR. NORAIDA BINTI HJ ALI
    Group      : GROUP 10

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT (@haikalmohdpuat)
2. NURIN NAZIFA BINTI ROHADI
3. NOR HIDAYAH BINTI MOHD DZAHIR
--%>

<%@page import="dao.FoodDAO"%>
<%@page import="model.Food"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Seat"%>
<%@page import="java.util.List"%>
<%@page import="java.io.Serializable"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="customer-navbar.jsp"/>
<jsp:include page="progress-bar.jsp"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Food & Beverages</title>
        <style>
            [data-tab-content] {
                display: none;
            }

            .active[data-tab-content] {
                display: flex;
                justify-content: space-around;
                flex-wrap: wrap;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            html {
                overflow: scroll;
                overflow-x: hidden;
            }
            ::-webkit-scrollbar {
                width: 0;  /* Remove scrollbar space */
                background: transparent;  /* Optional: just make scrollbar invisible */
            }

            .card {
                background: #222131;
            }

            body {
                background-color: black;
            }

            .tabs {
                display: flex;
                justify-content: space-around;
                list-style-type: none;
                margin: 0;
                padding: 0;
            }

            li[name='tab1'], li[name='tab2'],
            li[name='tab3'], li[name='tab4'], li[name='tab5']{
                margin: 0 50px 0;
                width: 120px;
                text-align: center;
                border: 2px solid #C38EC7;
            }

            .tab {
                cursor: pointer;
                padding: 10px;
                background-color: black;
                color: #C38EC7;
                font-weight: bold;
            }

            .tab.active {
                background-color: #C38EC7;
                color: black;
                font-weight: bold;
                border: 2px solid black;
            }

            .tab:hover {
                background-color: #571B7E;
                color: white;
            }

            .card-child {
                background: #0f0f0f;
            }

            .card-title, .card-text {
                color: white;
            }

            .btn {
                background-color: #C38EC7;
                color: black;
                margin-left: 60px;
                font-weight: bold;
            }

            @media only screen and (max-width: 1207px) {
                .tabs {
                    flex-wrap:  wrap;
                }
            }


            input[name='itemDetails'], input[name='itemPrice']
            , input[name='totalPrice']{
                display: none;
            }
            /* -----------------CART ---------------- */
            .content-section {
                flex-direction: column;
                margin-left: 50px;
                width: 90%;
            }
            .cart-header {
                color: white;
                font-weight: bold;
                font-size: 1.25em;
            }

            .cart-column {
                display: flex;
                align-items: center;
                border-bottom: 1px solid white;
                margin-right: 1.5em;
                padding-bottom: 10px;
                margin-top: 10px;
            }

            .cart-row {
                display: flex;
            }

            .cart-item {
                width: 45%;
                color: white;
            }

            .cart-quantity {
                width: 35%;
            }

            .cart-price {
                width: 20%;
                font-size: 1.2em;
            }

            .cart-item-title {
                color: white;
                margin-left: 0.5em;
                font-size: 1.2em;
            }

            .cart-item-image {
                width: 75px;
                height: auto;
            }

            .btn-danger {
                color: white;
                background-color: #eb5757;
                border: none;
                border-radius: 0.3em;
            }

            .btn-danger:hover {
                color: black;
                background-color: #cc4c4c;
            }
            .cart-quantity-input {
                height: 34px;
                width: 50px;
                text-align: center;
                font-size: 1.2em;
                margin-right: 25px;
            }

            .cart-row:last-child {
                border-bottom: 1px solid white;
            }

            .cart-row:last-child .cart-column {
                border: none;
            }

            .cart-total {
                margin-right: 10px;
            }

            .cart-total-title {
                font-size: 2em;
                margin-right: 20px;
            }

            .btn-purchase {
                width: 15%;
                font-size: 1.75em;
                margin-right: 0.5rem;
                margin-left: auto;
            }

            .cart-item, .cart-price, .cart-quantity
            .cart-total-title, .cart-total-price{
                color: white;
            }

            .cart-total-price {
                font-size: 1.5em;
            }
        </style>
    </head>
    <body>       
        <div class="rings mt-3">
            <div class="container-step">
                <div class="text">Details</div>
                <div class="completed"><i class="fa-solid fa-check"></i></div>
            </div>
            <span class="connector">></span>
            <div class="container-step">
                <div class="text">Seating</div>
                <div class="completed"><i class="fa-solid fa-check"></i></div>
            </div>
            <span class="connector">></span>
            <div class="container-step">
                <div class="text" style="color: #C38EC7">Beverages</div>
                <div class="current"></div>
            </div>
            <span class="connector" style="color: gray">></span>
            <div class="container-step">
                <div class="text" style="color: gray">Payment</div>
                <div class="next"></div>
            </div>
        </div>
        <form action="../BookingController" method="POST">
            <div class="container mt-5 mb-5 d-flex justify-content-center">
                <div class="card px-100 py-4 w-100">
                    <div class="card-body">
                        <div class="card px-1 py-4">
                            <ul class="tabs justify-content-center">
                                <li class="tab active" name="tab1" data-tab-target="#combo">Combo</li>
                                <li class="tab" name="tab2" data-tab-target="#alacarte">A La Carte</li>
                                <li class="tab" name="tab3"  data-tab-target="#drinks">Drinks</li>
                                <li class="tab" name="tab4"  data-tab-target="#snacks">Snacks</li>
                                <li class="tab" name="tab5"  data-tab-target="#cart">Cart</li>
                            </ul>
                        </div>                  
                        <div class='tab-content'>
                            <%
                                List<Food> comboList = new ArrayList<>();
                                List<Food> alacarteList = new ArrayList<>();
                                List<Food> drinksList = new ArrayList<>();
                                List<Food> snacksList = new ArrayList<>();
                                List<Food> foodList = new ArrayList<>();

                                //Retrieve all food with the respective category from the database
                                comboList = FoodDAO.findAllFoodByFoodType("combo");
                                alacarteList = FoodDAO.findAllFoodByFoodType("alacarte");
                                drinksList = FoodDAO.findAllFoodByFoodType("drinks");
                                snacksList = FoodDAO.findAllFoodByFoodType("snacks");

                                String foodType = "";

                                for (int i = 0; i < 4; i++) {

                                    //Check the current i value and point the respective list to foodList
                                    foodList = i == 0 ? comboList : i == 1 ? alacarteList : i == 2 ? drinksList : snacksList;
                                    //Check the current i value and point the respective string to foodType
                                    foodType = i == 0 ? "combo" : i == 1 ? "alacarte" : i == 2 ? "drinks" : "snacks";

                                    //If i == 0, add the element with id of the respective foodType with "active" class
                                    if (i == 0) {
                                        out.println("<div id='" + foodType + "'data-tab-content class='container active'>");
                                    } else {
                                        out.println("<div id='" + foodType + "'data-tab-content class='container'>");
                                    }

                                    //Iterate over the foodlist and print it
                                    for (int k = 0; k < foodList.size(); k++) {
                                        out.println("<div class='card card-child' style='width: 18rem;'>");
                                        out.println("<img class='card-img-top shop-item-image' src='" + foodList.get(k).getFoodImage() + "' alt='food image'>");
                                        out.println("<div class='card-body'>");
                                        out.println("<h5 class='card-title shop-item-title value='" + foodList.get(k).getFoodDescription() + "'>" + foodList.get(k).getFoodDescription() + "</h5>");
                                        out.println("<p class='card-text shop-item-price' value='" + (int) foodList.get(k).getFoodPrice() + "'>RM" + foodList.get(k).getFoodPrice() + "</p>");
                                        out.println("<button class='btn btn-primary shop-item-button' type='button'>Add to Cart &#8594;</button>");
                                        out.println("</div>");
                                        out.println("</div>");
                                    }
                                    out.println("</div>");
                                }
                            %>             
                            <div id="cart" class="content-section" data-tab-content>
                                <h2 class="section-header" style="color: white;">CART</h2><br>
                                <div class="cart-row">
                                    <span class="cart-item cart-header cart-column">ITEM</span>
                                    <span class="cart-price cart-header cart-column">PRICE</span>
                                    <span class="cart-quantity cart-header cart-column">QUANTITY</span>
                                </div>
                                <div class="cart-items"></div>
                                <div class="cart-total">
                                    <strong class="cart-total-title" style="color: white;">Total</strong>
                                    <span class="cart-total-price">RM0</span>
                                </div>
                                <button class="btn btn-primary btn-purchase" type="submit" value="chooseFood" name="action">Checkout</button>
                                <input name="itemDetails"  id="detailsInput" value=''/>
                                <input name="itemPrice" id="priceInput" value=''/>
                                <input name="totalPrice" id="totalPrice" value=''/>
                            </div>
                        </div>                    
                    </div>
                </div>
            </div>
        </form>
        <script>
            var i = 0;
            var qArr = [];
            const tabs = document.querySelectorAll('[data-tab-target]');
            const tabContents = document.querySelectorAll('[data-tab-content]');

            tabs.forEach(tab => {
                tab.addEventListener('click', () => {
                    const target = document.querySelector(tab.dataset.tabTarget);
                    tabContents.forEach(tabContent => {
                        tabContent.classList.remove('active');
                    });
                    tabs.forEach(tab => {
                        tab.classList.remove('active');
                    });
                    tab.classList.add('active');
                    target.classList.add('active');
                });
            });

            //Add button to remove cart items from the cart
            var removeCartItemButtons = document.getElementsByClassName('btn-danger');

            for (var i = 0; i < removeCartItemButtons.length; i++) {
                var button = removeCartItemButtons[i];
                button.addEventListener('click', removeCartItem);
            }

            //Add column to change quantity of items added to cart
            var quantityInputs = document.getElementsByClassName('cart-quantity-input');
            for (var i = 0; i < quantityInputs.length; i++) {
                var input = quantityInputs[i];
                input.addEventListener('change', quantityChanged);
            }

            //Add functionality to add to cart button to actual cart
            var addToCartButtons = document.getElementsByClassName('shop-item-button');
            for (var i = 0; i < addToCartButtons.length; i++) {
                var button = addToCartButtons[i];
                button.addEventListener('click', addToCartClicked);
            }

            //Change button content and background color after added to cart
            var buttons = document.querySelectorAll(".shop-item-button");

            buttons.forEach(button => {
                button.addEventListener('click', () => {
                    button.style.margin = '0 0 0 3rem';
                    button.style.backgroundColor = 'black';//button to black
                    button.style.color = '#fff';//font color to white
                    button.innerHTML = 'Added to Cart &#10003;';//add content in button
                });
            });

            //function tu change button content from "Added to Cart"
            //to "Add to Cart" if item is removed from cart
            function buttonToNormal(event) {
                var buttonClicked = event.target;
                //get the title of selected removed product
                var titleRemoved = buttonClicked.parentElement.parentElement.getElementsByClassName("cart-item-title")[0];
                var titleInShop = document.getElementsByTagName('h5');//get array of tag 'h5'
                var buttonInShop = document.querySelectorAll('.shop-item-button');//get array of class 'shop-item-button'

                for (var i = 0; i < titleInShop.length; i++) {

                    var titles = titleInShop[i];//Iterate array of title names
                    var normalButton = buttonInShop[i];//Iterate array of button

                    //If title of removed product is the same with any of the available titles in the shop
                    //change the respective button back to orange
                    if (titleRemoved.innerText === titles.innerText) {
                        normalButton.style.margin = '0 0 0 3.7rem';
                        normalButton.style.color = 'black';
                        normalButton.style.backgroundColor = '#C38EC7';//button back to purple
                        normalButton.innerHTML = 'Add to Cart &#8594;';//button content back to 'Add to Cart'
                    }
                }
            }
            //function to remove item from cart
            function removeCartItem(event) {
                buttonToNormal(event);
                var buttonClicked = event.target;
                var title = buttonClicked.parentElement.parentElement.querySelector(".cart-item-title").innerText;
                var price = buttonClicked.parentElement.parentElement.querySelector(".cart-price-title").innerText;
                var text = buttonClicked.parentElement.querySelector(".cart-quantity-input").getAttribute("name");
                console.log(text);
                var quantity = text.replace("quantity", "");
                console.log(quantity);

                removeTitle(document.getElementById('detailsInput'), title);
                removePrice(document.getElementById('priceInput'), price);

                i--;
                buttonClicked.parentElement.parentElement.remove();//remove row of selected product
                updateCartTotal(quantity);
            }

            function quantityChanged(event) {
                var input = event.target;
                updateCartTotal();
            }

            //function to add item to cart
            function addToCartClicked(event) {
                var button = event.target;
                var shopItem1 = button.parentElement;
                var shopItem2 = button.parentElement.parentElement;
                var title = shopItem1.getElementsByClassName('shop-item-title')[0].innerText;
                var price = shopItem1.getElementsByClassName('shop-item-price')[0].innerText;
                var imageSrc = shopItem2.getElementsByClassName('shop-item-image')[0].src;

                addTitle(document.getElementById('detailsInput'), title);
                addPrice(document.getElementById('priceInput'), price);

                addItemToCart(title, price, imageSrc);
                updateCartTotal();
            }

            //function to display item image, price and title in the cart using newly created div
            function addItemToCart(title, price, imageSrc) {
                var cartRow = document.createElement('div');//create a div
                cartRow.classList.add('cart-row');//add class 'cart-row' to the new div
                var cartItems = document.getElementsByClassName('cart-items')[0];//get element first element in cart-items array
                var cartItemNames = cartItems.getElementsByClassName('cart-item-title');//get node list of cart-item-title

                //Iterate over cart-item-title nodelist/array
                for (var i = 0; i < cartItemNames.length; i++) {

                    //Add alert message when user clicks two times to add to cart button
                    if (cartItemNames[i].innerText === title) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Oops...',
                            text: 'This item has already been added to the cart!'
                        });
                        return;
                    }
                }
                //Add row content consists of item picture, title and price
                var cartRowContents = `
                <div class="cart-item cart-column">
                     <img class="cart-item-image" src="\${imageSrc}" width="400" height="400">
                     <p class="cart-item-title">\${title}</p>
                </div>
                <div class="cart-price cart-column">
                    <p class='cart-price-title'>\${price}</p>
                </div>
                <div class="cart-quantity cart-column">
                     <select class="cart-quantity-input" name="quantity\${i}">
                        <option value='1' selected>1</option>
                        <option value='2'>2</option>
                        <option value='3'>3</option>
                     </select>

                     <button class="btn btn-danger" type="button">REMOVE</button>
                </div>`;
                i++;
                cartRow.innerHTML = cartRowContents; //Set the cart row content to cartRowContents
                cartItems.append(cartRow); //append cart row to the cartItems
                //Trigger function when button or quantity input is clicked
                cartRow.getElementsByClassName('btn-danger')[0].addEventListener('click', removeCartItem);
                cartRow.getElementsByClassName('cart-quantity-input')[0].addEventListener('change', quantityChanged);
            }

            //function to update cart total price
            function updateCartTotal(quantity) {
                var cartItemContainer = document.getElementsByClassName('cart-items')[0];
                var cartRows = cartItemContainer.getElementsByClassName('cart-row');
                total = 0;
                for (var i = 0; i < cartRows.length; i++) {
                    var cartRow = cartRows[i];
                    var priceElement = cartRow.getElementsByClassName('cart-price')[0];
                    var quantityElement = cartRow.getElementsByClassName('cart-quantity-input')[0];
                    var price = parseFloat(priceElement.innerText.replace('RM', ''));
                    var quantity = quantityElement.value;
                    total = total + (price * quantity);
                }
                ;
                total = Math.round(total * 100) / 100;
                document.getElementsByClassName('cart-total-price')[0].innerText = 'RM' + total;
                document.getElementById('totalPrice').value = total;
            }

            function addTitle(titleListElm, titleValue) {
                var arr = titleListElm.value.split(',');
                if (arr.join() === '') {
                    arr = [];
                }

                var p = arr.indexOf(titleValue);
                if (p === -1) {
                    arr.push(titleValue); //append
                    titleListElm.value = arr.join(',');
                }
            }

            function addPrice(priceListElm, priceValue) {
                var arr = priceListElm.value.split(',');
                if (arr.join() === '') {
                    arr = [];
                }

                var p = arr.indexOf(priceValue);
                if (p === -1) {
                    arr.push(priceValue); //append 
                    priceListElm.value = arr.join(',');
                }
            }

            function removeTitle(titleListElm, titleValue) {
                var arr = titleListElm.value.split(',');

                var p = arr.indexOf(titleValue);
                if (p !== -1) {
                    arr.splice(p, 1);
                    titleListElm.value = arr.join(',');
                }
            }

            function removePrice(priceListElm, priceValue) {
                var arr = priceListElm.value.split(',');

                var p = arr.indexOf(priceValue);
                if (p !== -1) {
                    arr.splice(p, 1);
                    priceListElm.value = arr.join(',');
                }
            }
        </script>
    </body>
</html>
