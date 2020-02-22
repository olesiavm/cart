<?php

/* @var $cartItems frontend\models\Cart */
/* @var $form yii\widgets\ActiveForm */
/* @var $totalQuantity */
/* @var $totalCost */

use yii\helpers\Html;
use yii\helpers\Url;
use yii\widgets\ActiveForm;
use frontend\models\Cart;

?>

<?php if ($cartItems !== null):  ?>
	<div>
	    <table class="table">
	        <thead>
		        <tr class="active">
		            <th class="table-cart-width">id</th>
		            <th class="table-cart-width">Наименование</th>
		            <th class="table-cart-width">Кол-во</th>
		            <th class="table-cart-width">Цена</th>
		            <th class="table-cart-width">Сумма</th>
		            <th class="table-cart-width"><i>&times;</i></th>
		        </tr>
	        </thead>
		</table>

		        	
		<?php foreach ($cartItems as $item): ?>
			<?php  $form = ActiveForm::begin([
					'action' => Url::to(['cart/edit', 'itemId' => $item->id]),
					'options' => [
	                    'class' => 'cart-item cart-item-description',
	                    'data-item-id' => $item->id 
	                ]
			]); ?>
			<table class="table table-responsive">  
		       <tbody> 	
					<tr>
						<td class="table-cart-width cart-wrapper">
							<?php echo $item->id; ?><br>
						</td>
	                	<td class="table-cart-width cart-wrapper">
	                		<?php echo $item->product->title; ?>	
	                	</td>
	                	
	                	<td class="table-cart-width cart-descr">
						<div>
	                		<?php echo $form->field($item, 'product_id')->textInput([
	                			'type' => 'hidden', 
	                			'style' => 'display:inline; float:left'
	                		])->label(false); ?>
						
							<i class="glyphicon glyphicon-minus decrease-quantity cart-icon" aria-hidden="true">&nbsp;</i>

                            <?php echo $form->field($item, 'quantity')->textInput([
                                    'class' => 'result-quantity', 
                                    'data-quantity-id' => $item->id, 
                                    'style' => 'width:100px; float: left; margin-right:10px'
                            ])->label(false); ?>
                            
                            <i class="glyphicon glyphicon-plus increase-quantity cart-icon-increase" aria-hidden="true" style="top: 5px">&nbsp;</i><br><br>
						</div>
	                	</td> 

						<td class="table-cart-width" style="padding-top:18px;">
							<?php echo $item->product->price; ?>
						</td>
						<td class="table-cart-width cart-wrapper">
							<div class='result-cost' data-cost-id='<?= $item->id ?>'>
								<?php echo $item->cost; ?>	
							</div>
						</td>
						<td class="table-cart-width cart-wrapper">
							<a href="<?php echo Url::to(['cart/remove', 'productId' => $item->product_id]) ?>">Удалить</a>
						</td>
					</tr>
				</tbody>
			</table>		
						
			<?php ActiveForm::end(); ?>
			<?php endforeach; ?>
				
		<table class="table">
				<tbody>
					<tr class="active">
			            <td colspan="4">Общее кол-во:</td>
			            <td colspan="2"><div id='result-total-q'><?php echo $totalQuantity; ?></div></td>
			        </tr>
			        <tr class="active">
			            <td colspan="4">Общая сумма:</td>
			            <td colspan="2"><div id='result-total-cost'><?php echo $totalCost; ?></div></td>
			        </tr>
				</tbody>
		</table>
	</div>
<?php else: ?>
	<?php echo "Корзина пуста"; ?>
<?php endif; ?>


