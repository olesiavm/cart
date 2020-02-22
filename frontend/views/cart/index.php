<?php

/* @var $products frontend\models\Product */
/* @var $cart frontend\models\Cart */
/* @var $form yii\widgets\ActiveForm */

use yii\helpers\Url;
use yii\helpers\Html;
use yii\widgets\ActiveForm;
use frontend\models\Cart;
$cart = new Cart();

?>
<div class="row">              
    <?php foreach ($products as $product): ?>
        <div class="col-md-4 col-sx-4 product-wrapper">
        	<div class="pruduct-wrapper-card">
		        <?php $form = ActiveForm::begin([
	        		'action' => Url::to(['cart/add', 'productId' => $product['id']]),
	        		'options' => [
	                    'class' => 'product-card product-description',
	                    'data-product-id' => $product['id']
	                ],
			    ]);  ?>	

	            <?php $path = "/img/products/"; ?>
	            <img src="<?= $path . $product['image'] ?>"><br>

	            <div class="product-property">
		           	<?= Html::a($product['title'], ['/product', 'id' => $product['id']]) ?><br>
		           	<i class="glyphicon glyphicon-minus decrease-quantity-in-catalog product-icon" aria-hidden="true" style="top: 19px">&nbsp;</i>

		           	<?php echo $form->field($cart, 'quantity', ['template' => "{label}\n{input}"])
		           		->textInput([
				           	'class' => 'result-quantity-in-catalog', 
				           	'data-quantity-id' => $product['id'], 
				           	'style' => 'width: 28%; float:left; margin-top:10px', 
				           	'value' => 1])
				        ->label(false); ?>&nbsp;&nbsp;&nbsp;

		           	<i class="glyphicon glyphicon-plus increase-quantity-in-catalog product-icon-increase" aria-hidden="true">&nbsp;</i><br><br>
		           	
		            <?= Html::submitButton('Добавить в корзину', ['class' => 'btn btn-primary']) ?>
	        	</div>
            	<?php ActiveForm::end(); ?>
            </div>
        </div>
    <?php endforeach; ?>
</div>

