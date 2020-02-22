<?php

namespace frontend\models;

use Yii;
use yii\base\Model;
use yii\db\ActiveRecord;
use yii\web\NotFoundHttpException;
/**
 * 
 */
class Product extends ActiveRecord
{
    public function rules()
    {
        return [
            ['link', 'string', 'max' => 100],
            ['description', 'string', 'max' => 15000],
            ['image', 'string', 'max' => 70],
            ['title', 'string', 'max' => 100],
            [['quantity', 'price'], 'integer'], 
        ];
    }


    /**
     * @param integer $id
     * @throws NotFoundHttpException 
     * @return Product
     */ 
    public function getProduct($id) 
    {
        $model = self::find()
                ->where(['status' => 1])
                ->andWhere(['id' => $id])
                ->one();

        if ($model !== null && !empty($model)) {
            return $model;
        } else {
            throw new NotFoundHttpException('Запрошенного товара не существует.');
        }
    }


    /**
     * @return Product
     */ 
    public function getProducts() 
    {
        return self::find()
                ->where(['status' => 1])
                ->all();
    }     
}
