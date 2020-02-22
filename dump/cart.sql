-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Фев 22 2020 г., 13:30
-- Версия сервера: 5.5.62
-- Версия PHP: 5.6.38

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `landing_withcart`
--

-- --------------------------------------------------------

--
-- Структура таблицы `callback`
--

CREATE TABLE `callback` (
  `id` int(11) NOT NULL,
  `name` varchar(80) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `agree` smallint(1) NOT NULL,
  `created_at` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `callback`
--

INSERT INTO `callback` (`id`, `name`, `phone`, `agree`, `created_at`) VALUES
(1, 'TEST', '+7 (444)-444-44', 1, 1565244555),
(9, 'ававп', '+7 (444)-444-44', 1, 1565689391),
(12, 'ававп2', '+7 (444)-444-44', 1, 1565689476),
(13, 'TEST', '+7 (444)-444-44', 1, 1566373626),
(14, 'TEST', '+7 (444)-444-44', 1, 1566373702),
(15, 'TEST', '+7 (444)-444-44', 1, 1566374970);

-- --------------------------------------------------------

--
-- Структура таблицы `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `user_session_id` varchar(150) NOT NULL,
  `quantity` int(20) NOT NULL,
  `cost` int(20) DEFAULT NULL,
  `created_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `cart`
--

INSERT INTO `cart` (`id`, `product_id`, `user_session_id`, `quantity`, `cost`, `created_at`) VALUES
(9, 6, 'zh-CN1', 140, 14000, 1578818152),
(10, 58, 'zh-CN1', 16, 320, 1578817237),
(11, 59, 'zh-CN1', 7, 7, 1578817240),
(12, 61, 'zh-CN1', 1, 4000, 1578817693),
(15, 6, 'zh-CN', 14, 1400, 1579705614),
(16, 58, 'zh-CN', 17, 340, 1579705614),
(17, 6, '797124', 49, 4900, 1579885152),
(18, 58, '797124', 897, 17940, 1579885154),
(19, 59, '797124', 260, 260, 1579885158),
(20, 6, '', 1, 100, 1580019657),
(21, 58, '9599040', 1, 20, 1580019856),
(22, 6, '', 1, 100, 1580137754),
(23, 58, '2168141', 22, 440, 1580139277),
(24, 59, '2168141', 1005, 1005, 1580139282),
(25, 6, '4349625', 51, 5100, 1580218625),
(26, 58, '4349625', 10, 200, 1580218619),
(27, 59, '4349625', 6, 6, 1580218622),
(28, 61, '4349625', 3, 12000, 1580218623),
(29, 6, 'A79aTnNQES', 3, 300, 1580630287),
(30, 58, 'A79aTnNQES', 10, 200, 1580630293),
(31, 59, 'A79aTnNQES', 9, 9, 1580630291),
(32, 61, 'A79aTnNQES', 14, 56000, 1580630282),
(33, 58, 'd86Z76eszz', 1, 20, 1580631839),
(35, 58, 'yzGFZTtDSG', 12, 240, 1580653198),
(36, 59, 'yzGFZTtDSG', 11, 11, 1580653230),
(37, 6, 'T9KZ83aaef', 7, 700, 1581233145),
(38, 59, 'T9KZ83aaef', 100, 100, 1581236713),
(39, 58, 'T9KZ83aaef', 12, 240, 1581236687),
(40, 61, 'T9KZ83aaef', 5, 20000, 1581236704),
(43, 6, 'HRn4rB3Fi3', 1, 100, 1582367275);

-- --------------------------------------------------------

--
-- Структура таблицы `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `title` varchar(150) NOT NULL,
  `parent_id` int(11) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `category`
--

INSERT INTO `category` (`id`, `title`, `parent_id`) VALUES
(1, 'catalog', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `feedback`
--

CREATE TABLE `feedback` (
  `name` varchar(80) NOT NULL,
  `email` varchar(50) NOT NULL,
  `message` varchar(10000) NOT NULL,
  `agree` smallint(1) NOT NULL,
  `created_at` int(10) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `feedback`
--

INSERT INTO `feedback` (`name`, `email`, `message`, `agree`, `created_at`, `phone`, `id`) VALUES
('test', 'test@mail.ru', 'yrtryryyryry', 1, 1565250150, '+7 (999)-999-9999', 1),
('test', 'test@mail.ru', 'qqqq', 1, 1566373749, '+7 (890)-999-9999', 2);

-- --------------------------------------------------------

--
-- Структура таблицы `field`
--

CREATE TABLE `field` (
  `field` varchar(100) NOT NULL,
  `description` varchar(500) NOT NULL,
  `path` varchar(100) NOT NULL DEFAULT '/img/primenenie/',
  `image` varchar(100) NOT NULL,
  `status` smallint(1) NOT NULL DEFAULT '1',
  `created_at` int(11) NOT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `field`
--

INSERT INTO `field` (`field`, `description`, `path`, `image`, `status`, `created_at`, `id`) VALUES
('Подвес', '<div><span style=\"color: #333333; font-family: Helvetica Neue, Helvetica, Arial, sans-serif;\"><span style=\"font-size: 14px; background-color: #f2f1ef;\">Подвес на опорах линий электропередач</span></span></div>\r\n<div><span style=\"color: #333333; font-family: Helvetica Neue, Helvetica, Arial, sans-serif;\"><span style=\"font-size: 14px; background-color: #f2f1ef;\">и столбах освещения, между зданиями.</span></span></div>', '/img/primenenie/', 'levelnum5.png', 1, 0, 1),
('В КАНАЛИЗАЦИЮ', '<div>Применяется в кабельной канализации, лотках, блоках,</div>\r\n<div>тоннелях, коллекторах при опасности повреждения грызунами.</div>', '/img/primenenie/', 'levelnum3.png', 1, 0, 2),
('ДРОП', '<div>Подвес в качестве магистрали в коттеджном</div>\r\n<div>поселке. Подвес от столба до дома в качестве</div>\r\n<div>&laquo;последней&raquo; мили в коттеджных поселках.</div>', '/img/primenenie/', 'levelnum4.png', 1, 0, 3),
('ТРУБЫ', '<div>Применяется для задувки в ЗПТ</div>\r\n<div>(защитные полиэтиленовые трубы)</div>', '/img/primenenie/', 'levelnum.png', 1, 0, 4),
('В ГРУНТ', '<div>Применяется при наличии особо высоких требований&nbsp;</div>\r\n<div>по механической устойчивости: в грунтах всех групп,</div>\r\n<div>в болотах, неглубоких несудоходных реках.</div>', '/img/primenenie/', 'levelnum2.png', 1, 0, 5);

-- --------------------------------------------------------

--
-- Структура таблицы `main`
--

CREATE TABLE `main` (
  `id` int(11) NOT NULL,
  `part_page` varchar(40) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `content` varchar(10000) DEFAULT NULL,
  `type` smallint(1) DEFAULT NULL COMMENT 'text 1 or image 0',
  `path` varchar(100) DEFAULT NULL COMMENT 'path to image',
  `image` varchar(180) DEFAULT NULL,
  `status` smallint(1) NOT NULL DEFAULT '1',
  `created_at` int(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `main`
--

INSERT INTO `main` (`id`, `part_page`, `title`, `content`, `type`, `path`, `image`, `status`, `created_at`) VALUES
(1, 'logo', '', '', 0, '/header/', 'logo-header.png', 1, 2147483647),
(2, 'map', '', NULL, 0, '/', 'map33.png', 1, 2147483647),
(3, 'banner', '', '', 0, '/header/', 'banner3.png', 1, 2147483647),
(5, 'cooperation', 'Мы развиваем дилерскую сеть', 'по продаже оптического кабеля<br>\r\n                        на территории России и СНГ<br>\r\n                        <a href=\"/feedback\">Стать партнером</a>', 2, '/', 'cooperation3.jpg', 1, 2147483647),
(6, 'cityContacts', '', '<h3>Контакты</h3>\r\n<div class=\"row\">\r\n<div class=\"col-md-4 col-xs-8\">Барнаул1<br />Москва<br />Новосибирск<br />Красноярск<br />Иркутск</div>\r\n<div class=\"col-md-4 col-xs-8\">Хабаровск<br />Владивосток<br />Ростов-на-Дону<br />Алматы<br /><br /><br /></div>\r\n<div class=\"col-md-4 col-xs-4\">&nbsp;</div>\r\n</div>', 1, NULL, '', 0, 2147483647);

-- --------------------------------------------------------

--
-- Структура таблицы `migration`
--

CREATE TABLE `migration` (
  `version` varchar(180) NOT NULL,
  `apply_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `migration`
--

INSERT INTO `migration` (`version`, `apply_time`) VALUES
('m000000_000000_base', 1564655825),
('m140506_102106_rbac_init', 1564713602),
('m170907_052038_rbac_add_index_on_auth_assignment_user_id', 1564713602),
('m180523_151638_rbac_updates_indexes_without_prefix', 1564713602);

-- --------------------------------------------------------

--
-- Структура таблицы `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL DEFAULT '1',
  `title` varchar(100) NOT NULL,
  `path` varchar(150) DEFAULT NULL,
  `image` varchar(150) DEFAULT NULL,
  `link` varchar(150) NOT NULL,
  `description` varchar(10000) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `status` smallint(1) NOT NULL DEFAULT '1',
  `quantity` int(11) NOT NULL DEFAULT '999999999',
  `created_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `product`
--

INSERT INTO `product` (`id`, `category_id`, `title`, `path`, `image`, `link`, `description`, `price`, `status`, `quantity`, `created_at`) VALUES
(6, 1, 'product', '', '1.png', 'product1', 'gfhfdh', 100, 1, 99999999, 1565347874),
(58, 1, 'product2', '', '2.png', 'product2', 'fdf hjghhj iki ', 20, 1, 99999999, 1565605349),
(59, 1, 'product3', '', '3.png', 'product3', 'hgfhf fhff55', 1, 1, 99999999, 1565849002),
(61, 1, 'product4', '', '4.png', 'product4', 'dgdfhgf4jh&nbsp; тпр', 4000, 1, 99999999, 1565848973);

-- --------------------------------------------------------

--
-- Структура таблицы `reserve`
--

CREATE TABLE `reserve` (
  `product_id` int(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `city` varchar(80) NOT NULL,
  `email` varchar(50) NOT NULL,
  `message` varchar(10000) NOT NULL,
  `agree` smallint(1) NOT NULL,
  `created_at` int(10) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `amount` int(10) NOT NULL,
  `id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `reserve`
--

INSERT INTO `reserve` (`product_id`, `name`, `city`, `email`, `message`, `agree`, `created_at`, `phone`, `amount`, `id`) VALUES
(6, 'ijoupo', 'oiuouo', 'tast@mail.ru', 'jkl', 1, 1565949022, '+7-(645)-787-8979', 7, 1),
(59, 'ijoupo', 'oiuouo', 'tast@mail.ru', '', 1, 1565950064, '+7-(645)-787-8979', 7, 2),
(59, 'ijoupo', 'oiuouo', 'tast@mail.ru', 'пр', 1, 1565950096, '+7-(645)-787-8979', 10, 3),
(59, 'ijoupo', 'oiuouo', 'tast@mail.ru', '', 1, 1565950334, '+7-(645)-787-8979', 366, 4),
(59, 'ijoupo', 'oiuouo', 'tast@mail.ru', '', 1, 1565950404, '+7-(645)-787-8979', 366, 5),
(59, 'ijoupo', 'oiuouo', 'tast@mail.ru', '', 1, 1565950489, '+7-(645)-787-8979', 366, 6),
(59, 'test', 'hgfhf', 'test@mail.ru', 'hghjgj', 1, 1566192838, '67575676587', 6, 7),
(59, 'test', 'hgfhf', 'test@mail.ru', 'ooo', 1, 1566193205, 'fhgh', 7, 8),
(58, 'test', 'новосибирск', 'test@mail.ru', 'test', 1, 1566201163, '+7 (333)-333-3333', 2, 9),
(58, 'test', 'новосибирск', 'test@mail.ru', 'test', 1, 1566276998, '+7 (333)-333-3333', 56545645, 10),
(58, 'test', 'новосибирск', 'test@mail.ru', 'test', 1, 1566277095, '+7 (333)-333-3333', 56545645, 11),
(58, 'test', 'новосибирск', 'test@mail.ru', 'test', 1, 1566277197, '+7 (333)-333-3333', 56545645, 12),
(58, 'test', 'новосибирск', 'test@mail.ru', 'kiuiyi', 1, 1566277752, '+7 (333)-333-3333', 33, 13),
(58, 'test', 'новосибирск', 'test@mail.ru', 'kiuiyi', 1, 1566277919, '+7 (333)-333-3333', 33, 14),
(58, 'test', 'новосибирск', 'test@mail.ru', 'kiuiyi', 1, 1566278067, '+7 (333)-333-3333', 33, 15),
(58, 'test', 'новосибирск', 'test@mail.ru', 'kiuiyi', 1, 1566278158, '+7 (333)-333-3333', 33, 16),
(58, 'test', 'новосибирск', 'test@mail.ru', 'kiuiyi', 1, 1566278524, '+7 (333)-333-3333', 33, 17),
(58, 'test', 'новосибирск', 'test@mail.ru', 'tttttttt', 1, 1566278857, '+7 (333)-333-3333', 33, 18),
(58, 'test', 'новосибирск', 'test@mail.ru', 'tttttttt', 1, 1566278924, '+7 (333)-333-3333', 33, 19),
(58, 'test', 'новосибирск', 'test@mail.ru', 'tttttttt', 1, 1566278963, '+7 (333)-333-3333', 33, 20),
(6, 'test', 'новосибирск', 'test@mail.ru', 'fsds', 1, 1566375036, '+7 (777)-777-7777', 25, 21);

-- --------------------------------------------------------

--
-- Структура таблицы `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `role` varchar(50) NOT NULL,
  `password_hash` varchar(100) NOT NULL,
  `auth_key` varchar(100) NOT NULL,
  `verification_token` varchar(100) NOT NULL,
  `status` int(5) NOT NULL,
  `created_at` int(40) NOT NULL,
  `updated_at` int(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `role`, `password_hash`, `auth_key`, `verification_token`, `status`, `created_at`, `updated_at`) VALUES
(1, 'user1', 'user@mail.ru', '', '$2y$13$gfwAFoGrEmZYE0rlgpeRv.SxmO8HBTQaJlpFxN6ciFCYP72ylkuUW', 'ThL28SKz-N3sSq00YpFLpFp7FbRkL-S9', 'AIl7_KmProa159-t94f7yECah_nqRjbc_1564635915', 1, 1564635915, 1564635915),
(2, 'user2', 'user2@mail.ru', 'admin', '$2y$13$YnEvLbjQyUkcP3MgvwPts.kr9IvWFKn0Ac4xlxRzSOlRR99NTiwpm', 'zmrSwEc3DTzjnBQ7Xvk-4ON2AXLs7bHe', 'Zva_vj34wsvydk9-_r2QU2qzYHhudbp__1564636078', 10, 1564636078, 1564636078),
(3, 'user3', 'user3@mail.ru', '', '$2y$13$e1qb7rb9mEVEUsZ7q/fBVuEx08v37xfcb68CVdCFl2OW1QAksMuNK', 'M34TzkbL3T27nDZOEbwhFLxApa4M__DV', 'pbOvUuxczPmIiZ29ASRCCyswq4WZSNiu_1564636237', 1, 1564636237, 1564636237),
(4, 'user4', 'user4@mail.ru', '', '$2y$13$yKsuVPnnDKIezwrVgrrSCeefw8/K80VDL/AvLVQI7B2sk75kke43C', 'dJHRJzFeX2Cu7uJQcvrlbsv9DntTWfOO', 'ctm8LIoR3jH_HtJYMvRiTAih74a22fMX_1565058447', 9, 1565058447, 1565058447);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `callback`
--
ALTER TABLE `callback`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `field`
--
ALTER TABLE `field`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `main`
--
ALTER TABLE `main`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `migration`
--
ALTER TABLE `migration`
  ADD PRIMARY KEY (`version`);

--
-- Индексы таблицы `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `reserve`
--
ALTER TABLE `reserve`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `callback`
--
ALTER TABLE `callback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT для таблицы `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT для таблицы `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `feedback`
--
ALTER TABLE `feedback`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `field`
--
ALTER TABLE `field`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `main`
--
ALTER TABLE `main`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT для таблицы `reserve`
--
ALTER TABLE `reserve`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT для таблицы `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
