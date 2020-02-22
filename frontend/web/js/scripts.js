// если нажимаем на кнопку  плюс или минус на странице корзины
$(document).ready(function() {  
    function increase() {
      var buttons = document.getElementsByClassName('increase-quantity'); 
      var action = 'increase-quantity-and-save';
      increaseOrDecrease(buttons, action);
    }
    increase();  

    function decrease() {
      var buttons = document.getElementsByClassName('decrease-quantity');
      var action = 'decrease-quantity-and-save';
      increaseOrDecrease(buttons, action);
    }
    decrease();
   
    change();  
    function change() {
      var action = "change-quantity";  
      var buttons = document.getElementsByClassName('result-quantity');
      for (var i=0; i < buttons.length; i++) {
        buttons[i].onchange = function() {
            var item_id = $(this).parents('.cart-item-description').attr('data-item-id');
            var url = '/cart/' + action + '?itemId=' + item_id;    
            var data = $(this).parents('.cart-item').serialize(); 

            $.ajax({
                  url: url,
                  type: "POST", 
                  dataType: "html", 
                  data: data,  
                  success: function(response) { 
                      var result = $.parseJSON(response);                      
                      if (result.status == 1) {
                         $(this).val(result.quantity);

                          updateCost(item_id, result);
                        
                          updateTotalCostAndTotalQuantity(item_id, result);
                      } 
                  }
            });
        }
      }
    }
  
    
    function increaseOrDecrease(buttons, action) {
      for (var i=0; i < buttons.length; i++) {
        buttons[i].onclick = function(e) {
              e.preventDefault();
             
              var item_id = $(this).parents('.cart-item-description').attr('data-item-id');
              var url = '/cart/' + action + '?itemId=' + item_id; 
              var data = $(this).parents('.cart-item').serialize(); ; 

              $.ajax({
                    url: url,
                    type: "POST", 
                    dataType: "html", 
                    data: data,  // передаем строку вида имяПоля1=значение1&имяПоля2=значение2..
                    success: function(response) { 
                      var result = $.parseJSON(response); 
                        
                      if (result.status == 1) {
                        
                        updateQuantity(item_id, result);

                        updateCost(item_id, result);
                        
                        updateTotalCostAndTotalQuantity(item_id, result);
                   
                      }    
                                   
                    }
              });
          }
        }
    }


    function updateCost(item_id, result) {
      var fields_cost = $('.result-cost'); 
      if (fields_cost.length > 0) {
        for (var i = 0; i < fields_cost.length; i++) {
            //Если поле находится внутри карточки товара
            if (fields_cost[i].getAttribute('data-cost-id') == item_id) {  
                  //Меняем значение поля 
                  $(fields_cost[i]).text('');
                  $(fields_cost[i]).text(result.cost);
            }
        }
      }
    }

    function updateTotalCostAndTotalQuantity(item_id, result) {
      if ($('#result-total-cost').length) {
        $('#result-total-cost').text(result.totalCost); 
      }
      if ($("#result-total-q").length) {
        $('#result-total-q').text(result.totalQuantity);
      }
    }        

       

    // если нажимаем на кнопку  плюс или минус на странице каталога
    function increaseInCatalog() {
      var buttons = document.getElementsByClassName('increase-quantity-in-catalog'); 
      var action = 'increase-quantity-in-catalog';
      increaseOrDecreaseInCatalog(buttons, action);
    }
    
    function decreaseInCatalog() {
      var buttons = document.getElementsByClassName('decrease-quantity-in-catalog');
      var action = 'decrease-quantity-in-catalog';
      increaseOrDecreaseInCatalog(buttons, action);
    }  
    
    function increaseOrDecreaseInCatalog(buttons, action) {
      for (var i=0; i < buttons.length; i++) {
        buttons[i].onclick = function(e) { 
              e.preventDefault();  
              var item_id = $(this).parents('.product-card').attr('data-product-id');  //product_id
              var url = '/cart/' + action + '?productId=' + item_id; 
              var data = $(this).parents('.product-card').serialize(); 

              $.ajax({
                    url: url,
                    type: "POST", 
                    dataType: "html", 
                    data: data,  
                    success: function(response) { 
                      var result = $.parseJSON(response); 
                        
                      if (result.status == 1) {
                        updateQuantity(item_id, result);
                      }    
                                   
                    }
              });
          }
        }
    }

    function changeInCatalog() {
      var action = "change-quantity-in-catalog";  
      var buttons = document.getElementsByClassName('result-quantity-in-catalog');   ///
     
      for (var i=0; i < buttons.length; i++) {
        buttons[i].onchange = function() { 
            var product_id = $(this).parents('.product-card').attr('data-product-id');  //product_id
            var url = '/cart/' + action + '?productId=' + product_id; 
            var data = $(this).parents('.product-card').serialize(); 

            $.ajax({
                  url: url,
                  type: "POST", 
                  dataType: "html", 
                  data: data,  
                  success: function(response) { 
                      var result = $.parseJSON(response);                      
                      if (result.status == 1) {
                         
                         $(this).val(result.quantity);

                      } 
                  }
            });
        }
      }
    }


    function updateQuantity(id, result) { //product_id or item_id
      var fields_quantity = $('.result-quantity'); //Получаем поле с количеством товара для всех элементов с классом result-quantity
      if (!fields_quantity.length) {
          fields_quantity = $('.result-quantity-in-catalog');
      }
      //Ищем в dom поле конкретного товара, которое находится внутри конкретной формы и за которое отвечает определенная кнопка_минус
      if (fields_quantity.length > 0) {
        for (var i = 0; i < fields_quantity.length; i++) {
            //Если поле находится внутри карточки товара
            if (fields_quantity[i].getAttribute('data-quantity-id') == id) { 
                  //Меняем значение поля с количеством товара
                  $(fields_quantity[i]).val(result.message);
            }
        }
      }
    }

    increaseInCatalog();  
    decreaseInCatalog();
    changeInCatalog();

});



   




   

    