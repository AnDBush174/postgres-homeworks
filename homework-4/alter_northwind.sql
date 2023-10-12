-- Подключиться к БД Northwind и сделать следующие изменения:
-- 1. Добавить ограничение на поле unit_price таблицы products (цена должна быть больше 0)
ALTER TABLE products
ADD CONSTRAINT check_unit_price CHECK (unit_price > 0);

-- 2. Добавить ограничение, что поле discontinued таблицы products может содержать только значения 0 или 1
ALTER TABLE products
ADD CONSTRAINT check_discontinued CHECK (discontinued IN (0, 1));

-- 3. Создать новую таблицу, содержащую все продукты, снятые с продажи (discontinued = 1)
CREATE TABLE discontinued_products AS
SELECT *
FROM products
WHERE discontinued = 1;

-- 4. Удалить из products товары, снятые с продажи (discontinued = 1)
-- Для 4-го пункта может потребоваться удаление ограничения, связанного с foreign_key. Подумайте, как это можно решить, чтобы связь с таблицей order_details все же осталась.
Для выполнения задания "Удалить из таблицы products товары, снятые с продажи (discontinued = 1)"
без удаления ограничения внешнего ключа "fk_order_details_products", можно использовать следующий подход:
Эти команды выполняются в последовательности и используются только после того,
когда все операции с таблицей уже завершены и нет необходимости внесения новых записей в таблицу "products".
Также рекомендуется создать резервную копию таблицы "products" перед выполнением данных действий.
-- Создание резервной копии таблицы "products"
CREATE TABLE products_backup AS
SELECT * FROM products;

1. Создайте новую таблицу "products_new" с теми же столбцами и ограничениями, что и у таблицы "products".
2. Скопируйте все строки из таблицы "products", за исключением товаров, снятых с продажи (discontinued = 1), в новую таблицу "products_new".
3. Удалите таблицу "products".
4. Переименуйте таблицу "products_new" в "products".

Это позволит сохранить связь с таблицей "order_details", так как новая таблица будет содержать только те товары, которые не были сняты с продажи.

-- Шаг 1: Создание новой таблицы "products_new"
CREATE TABLE products_new (
    product_id        smallint,
    product_name      character varying(40),
    supplier_id       smallint,
    category_id       smallint,
    quantity_per_unit character varying(20),
    unit_price        real,
    units_in_stock    smallint,
    units_on_order    smallint,
    reorder_level     smallint,
    discontinued      integer,
    CONSTRAINT pk_products_new PRIMARY KEY (product_id),
    CONSTRAINT check_discontinued_new CHECK (discontinued = ANY (ARRAY[0, 1])),
    CONSTRAINT check_unit_price_new CHECK (unit_price > 0::double precision),
    CONSTRAINT fk_products_categories_new FOREIGN KEY (category_id) REFERENCES categories(category_id),
    CONSTRAINT fk_products_suppliers_new FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- Шаг 2: Копирование строк из таблицы "products" в "products_new"
INSERT INTO products_new SELECT * FROM products WHERE discontinued = 0;

-- Шаг 3: Удаление таблицы "products"
DROP TABLE products;

-- Шаг 4: Переименование таблицы "products_new" в "products"
ALTER TABLE products_new RENAME TO products;

