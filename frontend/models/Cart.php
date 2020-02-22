<?php

namespace frontend\models;

use Yii;
use yii\base\Model;
use frontend\models\Product;
use frontend\models\Cart;
use yii\web\NotFoundHttpException;
use yii\helpers\Html;
use yii\db\ActiveRecord;
use yii\web\Session;


class Cart extends ActiveRecord
{
    
    public $productModel;
    public $userSessionId;
    public $cartItemLifeTime = 5*24*60*60; //5 day

    public function init() {
        $this->productModel = new Product();
        $session = Yii::$app->session;
        $this->userSessionId = $session->get('userSessionId');
    }
    

    public function rules()
    {
        return [
            ['user_session_id', 'string', 'max' => 150],
            [['quantity', 'product_id', 'created_at', 'cost'], 'integer'], 
           
        ];
    }


    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'quantity' => 'Количество'
        ];
    }


    /**
     * Add product in cart of user
     *
     * @param ineger $id
     * @param ineger $count
     * @return void
     */
    public function add($productId, $count) 
    {   
        $product = $this->productModel->getProduct($productId);
        if ($this->load(Yii::$app->request->post())) {
            $count = Yii::$app->request->post()['Cart']['quantity'];
        }

        $quantity = $this->getQuantity($count, $product->quantity);
        $cartItem = $this->getCartItem($product->id);
        if ($cartItem !== null && !empty($cartItem)) {
            // update count this Product in Cart
            $cartItem->quantity = $quantity + $cartItem->quantity;
            $cartItem->created_at = time(); 
            $cartItem->cost = $cartItem->quantity * $product->price;
            $cartItem->save(); //true
        } else {
            $cartItem = new self();
            // add new Product in Cart
            $cartItem->product_id = $product->id; 
            $cartItem->user_session_id = "$this->userSessionId"; 
            $cartItem->quantity = $quantity;
            $cartItem->created_at = time(); 
            $cartItem->cost = $this->quantity * $product->price;
            $cartItem->save();
        }
        
    }


    /**
     * Delete cartItem from cart of user.
     *
     * @param ineger $id
     * @throws NotFoundHttpException
     * @return void
     */
    public function remove($productId)  
    {
        $product = $this->productModel->getProduct($productId);
        $cartItem = $this->getCartItem($product->id);
        if ($cartItem == null) {
            throw new NotFoundHttpException('Невозможно удалить товар');
        }
        $cartItem->delete($cartItem->id);
    }

    /**
     * Delete all cartItems from cart of user.
     *
     * @return void
     */
    public function clear() 
    {
        self::deleteAll([
            'user_session_id' => $this->userSessionId  //В корзине пользователя с id $this->userSessionId
        ]);
    }


    /**
     * @param integer $count
     * @param integer $maxCount
     * @return integer
     * @throws NotFoundHttpException if the product cannot be found
     */
    private function getQuantity($count, $maxCount)
    {
        $count = (int)$count;
        //$quantity д.б. целым числом, которое > 0
        if ($count > 0) {
            $quantity = $count;
        } else {
            $quantity = 1;
        }
        if ($quantity > $maxCount) {
            throw new NotFoundHttpException('Товара в наличии всего ' . Html::encode($maxCount) . ' шт.');
        }
        return $quantity;
    }

    /**
     * Get cartItem from  cart of user
     *
     * @param integer $productId
     * @return mixed
     */
    public function getCartItem($productId) 
    {
        $endTime = time() - $this->cartItemLifeTime;
        $obj = self::find()
            ->where(['product_id' => $productId])
            ->andWhere(['user_session_id' => $this->userSessionId])  
            ->andWhere(['>', 'created_at', $endTime])  // time life of product in cart not end
            ->one();

        if ($obj !== null && !empty($obj)) {
            return $obj;
        } else {
            return null;
        }
    }

    /**
     * Get cartItem from cart of user for Update
     *
     * @param integer $id itemId
     * @return mixed
     */
    public function getCartItemForUpdate($id) 
    {
        $endTime = time() - $this->cartItemLifeTime;
        $obj = self::find()
            ->where(['id' => $id])  
            ->andWhere(['user_session_id' => $this->userSessionId]) 
            ->andWhere(['>', 'created_at', $endTime])  
            ->one();

        if ($obj !== null && !empty($obj)) {
            return $obj;
        } else {
            return null;
        }
    }

    /**
     * Get cartItems from cart of user
     *
     * @return mixed
     */
    public function getCartItems() 
    {
        $endTime = time() - $this->cartItemLifeTime;
        $obj = self::find()
            ->where(['user_session_id' => $this->userSessionId]) 
            ->andWhere(['>', 'created_at', $endTime])   
            ->all();

        if ($obj !== null && !empty($obj)) {
            return $obj;
        } else {
            return null;
        }
    }

 
    /**
     * Relation  One CartItem - One Product
     *
     */
    public function getProduct()
    {
        return $this->hasOne(Product::className(), ['id' => 'product_id']);
    }

    /**
     * Get cartItems whit title of products (from cart of user) 
     *
     * @return mixed
     */
    public function getCartItemsWithTitle() 
    {
        $endTime = time() - $this->cartItemLifeTime;

        $obj = self::find()
            ->select("cart.id, cart.product_id, cart.user_session_id, cart.quantity, cart.cost, cart.created_at, product.title, product.price")
            ->joinWith('product', 'cart.product_id = product.id')
            ->where(['product.status' => 1])
            ->andWhere(['cart.user_session_id' => $this->userSessionId])  
            ->andWhere(['>', 'cart.created_at', $endTime])  
            ->orderBy('cart.product_id')
            ->all();

        if ($obj !== null && !empty($obj)) {
            return $obj;
        } else {
            return null;
        }
    }

    /**
     *
     * @return integer
     */
    public function getTotalQuantity() 
    {
        $endTime = time() - $this->cartItemLifeTime;
        $arr = self::find()
            ->select('quantity')
            ->andWhere(['user_session_id' => $this->userSessionId]) 
            ->andWhere(['>', 'created_at', $endTime]) 
            ->asArray()->all();
        $count = 0;
        foreach ($arr as $row) {
            $count = $count + $row['quantity'];
        }
        return $count;
    }

    /**
     *
     * @return integer
     */
    public function getTotalCost() 
    {
        $endTime = time() - $this->cartItemLifeTime;
        $arr = self::find()
            ->select('cost')
            ->andWhere(['user_session_id' => $this->userSessionId]) 
            ->andWhere(['>', 'created_at', $endTime])
            ->asArray()->all();
        $cost = 0;
        foreach ($arr as $row) {
            $cost = $cost + $row['cost'];
        }
        return $cost;
    }


    /**
     * Calculate decreased quantity 
     *
     * @param string $className
     * @return integer
     */ 
    public function calcDecreasedQuntity($className) 
    {
        $quantity = Yii::$app->request->post()[$className]['quantity']; 
        if ($quantity > 1) {
            $quantity = $quantity - 1;
        } else {
            $quantity = 1;
        }
        return $quantity;
    }

    /**
     * Calculate increased quantity 
     *
     * @param string $className
     * @return integer
     */ 
    public function calcIncreasedQuntity($className) 
    {
        $quantity = Yii::$app->request->post()[$className]['quantity'];    
        if ($quantity > 1 || $quantity == 1) { 
            $quantity = $quantity + 1;
        } else {
            $quantity = 1;
        }
        return $quantity;
    }

}



