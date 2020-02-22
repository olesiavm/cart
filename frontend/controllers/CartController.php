<?php
namespace frontend\controllers;

use Yii;
use yii\web\Controller;
use frontend\models\Cart;
use frontend\models\Product;
use yii\web\NotFoundHttpException;
use yii\web\Request;
use yii\web\Response;
use yii\web\Cookie;

/**
 * Cart controller
 */
class CartController extends Controller
{
    public $cartModel;
    public $productModel;
    public $itemLifeTime = 60*60*24*7;

    public function init() 
    {
        $this->productModel = new Product();
        // get cookie
        $cookies = Yii::$app->request->cookies;
        $cookie = $cookies->get('userSessionId');
        if ($cookie == null) {
            // set cookie
            $cookiesResp = Yii::$app->response->cookies;
            $userSessionId = $this->getRandomStr(10); 
            $cookiesResp->add(new \yii\web\Cookie([
                'name' => 'userSessionId',
                'value' => $userSessionId,
                'expire' => time() + $this->itemLifeTime
            ]));
            $session = Yii::$app->session;
            $session->set('userSessionId', $userSessionId);
            $products = $this->productModel->getProducts();
        } else {
            $userSessionId = $cookie->value;
            // set sesiion
            $session = Yii::$app->session;
            $session->set('userSessionId', $userSessionId);
        }
        $this->cartModel = new Cart();
    }

    /**
     * Displays index page.
     *
     * @return string
     */
    public function actionIndex()
    {
        $productModel = new Product();
    	$products = $productModel->getProducts();
        return $this->render('index', ['products' => $products]);
    }

    /**
     * Displays cartItems of user.
     *
     * @return string
     */
    public function actionShow()
    {
        $cartItems = $this->cartModel->getCartItemsWithTitle();
        $totalQuantity = $this->cartModel->getTotalQuantity();
        $totalCost = $this->cartModel->getTotalCost();
        return $this->render('show', [
            'cartItems' => $cartItems, 
            'totalCost' => $totalCost, 
            'totalQuantity' => $totalQuantity
        ]);
    }

    /**
     * Add product in cart of user
     *
     * @param ineger $id
     * @param ineger $count
     * @throws NotFoundHttpException 
     * @return mixed
     */
 	public function actionAdd($productId, $count = 1) 
 	{ 
 		$this->cartModel->add($productId, $count); 
 		return $this->redirect(['index']);
 	}


    /**
     * Delete product from cart of user
     *
     * @param ineger $id
     * @throws NotFoundHttpException 
     * @return mixed
     */
 	public function actionRemove($productId) 
 	{
 		$this->cartModel->remove($productId);
 		return $this->redirect(['index']);
 	}

    /**
     * Delete all products from cart of user
     *
     * @return mixed
     */
 	public function actionClear() 
 	{
 		$this->cartModel->clear(); 
 		return $this->redirect(['index']);
 	}

 	
    /**
     * Change quantity of cartItem in cart of user
     *
     * @param ineger $itemId
     * @throws NotFoundHttpException 
     * @return string
     */
    public function actionChangeQuantity($itemId) 
    {
        $model = $this->cartModel->getCartItemForUpdate($itemId);
        if (!Yii::$app->request->isAjax) {
           throw new NotFoundHttpException;
        }
        $quantity = Yii::$app->request->post()['Cart']['quantity'];

        $productModel = new Product();
        $product = $productModel->getProduct($model->product_id);
        $model->quantity = $quantity;
        $model->cost = $quantity * $product->price;
        $model->created_at = time();
        $result = $model->save();

        $totalQuantity = $this->cartModel->getTotalQuantity(); 
        $totalCost = $this->cartModel->getTotalCost(); 

         if ($result == true) {
            return json_encode([
                'status' => $result, 
                'message' => $quantity,
                'cost' => $model->cost,
                'totalCost' => $totalCost, 
                'totalQuantity' => $totalQuantity
            ]); 
        }

        return json_encode([
            'status' => 0
        ]);
    }

    /**
     * Increase quantity of cartItem in cart of user and save in DB
     *
     * @param ineger $itemId
     * @throws NotFoundHttpException 
     * @return string
     */
    public function actionIncreaseQuantityAndSave($itemId) 
    {
        $model = $this->cartModel->getCartItemForUpdate($itemId);

        if (!Yii::$app->request->isAjax) {
           throw new NotFoundHttpException;
        }
        
        $quantity = $this->cartModel->calcIncreasedQuntity("Cart");

        $productModel = new Product();
        $product = $productModel->getProduct($model->product_id);
        $model->quantity = $quantity;
        $model->cost = $quantity * $product->price;
        $model->created_at = time();
        $result = $model->save();

        $totalQuantity = $this->cartModel->getTotalQuantity(); 
        $totalCost = $this->cartModel->getTotalCost();
        
        if ($result == true) {
             return json_encode([
                'status' => $result, 
                'message' => $quantity,
                'cost' => $model->cost,
                'totalCost' => $totalCost, 
                'totalQuantity' => $totalQuantity
            ]); 
        }

        return json_encode([
            'status' => 0
        ]);
        
    }

    /**
     * Decrease quantity of cartItem in cart of user and save in DB
     *
     * @param ineger $itemId
     * @throws NotFoundHttpException 
     * @return string
     */  
    public function actionDecreaseQuantityAndSave($itemId) 
    {
        $model = $this->cartModel->getCartItemForUpdate($itemId);

        if (!Yii::$app->request->isAjax) {
           throw new NotFoundHttpException;
        }
        
        $quantity = $this->cartModel->calcDecreasedQuntity("Cart");

        $model->quantity = $quantity;
        $productModel = new Product();
        $product = $productModel->getProduct($model->product_id);
        $model->cost = $quantity * $product->price;
        $model->created_at = time();
        $result = $model->save();
        
        $totalQuantity = $this->cartModel->getTotalQuantity(); 
        $totalCost = $this->cartModel->getTotalCost();
        
        if ($result == true) {
            return json_encode([
                'status' => $result, 
                'message' => $quantity,
                'cost' => $model->cost,
                'totalCost' => $totalCost, 
                'totalQuantity' => $totalQuantity
            ]); 
        }

        return json_encode([
            'status' => 0
        ]);
        
    }

    /**
     * Change quantity of cartItem in Cataog 
     *
     * @param ineger $productId
     * @throws NotFoundHttpException 
     * @return string
     */
    public function actionChangeQuantityInCatalog($productId) 
    {
        if (!Yii::$app->request->isAjax) {
           throw new NotFoundHttpException;
        }
      
        $quantity = Yii::$app->request->post()['Cart']['quantity'];

        return json_encode([
            'status' => 1, 
            'quantity' => $quantity
        ]);

    }

    /**
     * Increase quantity of cartItem in Catalog 
     *
     * @param ineger $productId
     * @throws NotFoundHttpException 
     * @return string
     */  
    public function actionIncreaseQuantityInCatalog($productId) 
    {
        if (!Yii::$app->request->isAjax) {
           throw new NotFoundHttpException;
        }
        
        $quantity = $this->cartModel->calcIncreasedQuntity("Cart");

        return json_encode([
            'status' => 1, 
            'message' => $quantity
            
        ]); 
        
    }

    /**
     * Decrease quantity of cartItem in Catalog 
     *
     * @param ineger $productId
     * @throws NotFoundHttpException 
     * @return string
     */   
    public function actionDecreaseQuantityInCatalog($productId) 
    {
        if (!Yii::$app->request->isAjax) {
           throw new NotFoundHttpException;
        }
        
        $quantity = $this->cartModel->calcDecreasedQuntity("Cart");

        return json_encode([
            'status' => 1, 
            'message' => $quantity
        ]); 
        
    }

    /**
     * @param ineger $maxCharCount
     * @return string
     */
    public function getRandomStr($maxCharCount) 
    {
        $string = '';
        for ($i = 0; $i < $maxCharCount; $i++) { 
            $string .= substr('abdefhiknrstyzABDEFGHKNQRSTYZ23456789', rand(1, 37) - 1, 1); 
        }
        return $string;
    }
    
}
