-- Напишите запросы, которые выводят следующую информацию:
-- 1. заказы, отправленные в города, заканчивающиеся на 'burg'. Вывести без повторений две колонки (город, страна) (см. таблица orders, колонки ship_city, ship_country)
SELECT DISTINCT ship_city AS город, ship_country AS страна
FROM orders
WHERE ship_city ILIKE '%burg'


-- 2. из таблицы orders идентификатор заказа, идентификатор заказчика, вес и страну отгрузки. Заказ отгружен в страны, начинающиеся на 'P'. Результат отсортирован по весу (по убыванию). Вывести первые 10 записей.
SELECT order_id, customer_id, freight, ship_country
FROM orders
WHERE ship_country ILIKE 'P%'
ORDER BY freight DESC
LIMIT 10

-- 3. фамилию, имя и телефон сотрудников, у которых в данных отсутствует регион (см таблицу employees)
SELECT last_name, first_name, home_phone
FROM employees
WHERE region IS NULL

-- 4. количество поставщиков (suppliers) в каждой из стран. Результат отсортировать по убыванию количества поставщиков в стране
SELECT country, COUNT(*) AS количетсво_поставщиков
FROM suppliers
GROUP BY country
ORDER BY COUNT(*) DESC


-- 5. суммарный вес заказов (в которых известен регион) по странам, но вывести только те результаты, где суммарный вес на страну больше 2750. Отсортировать по убыванию суммарного веса (см таблицу orders, колонки ship_region, ship_country, freight)
SELECT ship_country AS страна, SUM(freight) AS суммарный_вес
FROM orders
WHERE ship_region IS NOT NULL
GROUP BY ship_country
HAVING SUM(freight) > 2750
ORDER BY суммарный_вес DESC

-- 6. страны, в которых зарегистрированы и заказчики (customers) и поставщики (suppliers) и работники (employees).
SELECT DISTINCT customers.country
FROM customers
JOIN suppliers ON customers.country = suppliers.country
JOIN employees ON customers.country = employees.country


-- 7. страны, в которых зарегистрированы и заказчики (customers) и поставщики (suppliers), но не зарегистрированы работники (employees).
SELECT DISTINCT customers.country
FROM customers
JOIN suppliers ON customers.country = suppliers.country
LEFT JOIN employees ON customers.country = employees.country
WHERE employees.country IS NULL
