import csv
import psycopg2
import os


def insert_data(data_name, file_name):
    # Получение имени пользователя из переменной среды
    pg_user = os.environ.get('PG_USER')
    # Получение пароля из переменной среды
    pg_password = os.environ.get('PG_PASSWORD')

    conn = psycopg2.connect(
        host="localhost",
        database="north",
        user=pg_user,
        password=pg_password
    )
    cur = conn.cursor()
    # Открываем файл с данными
    with open(file_name, 'r') as file:
        reader = csv.reader(file)
        next(reader)  # Пропускаем заголовки
        # Вставляем данные в таблицу
        cur.executemany(f"INSERT INTO {data_name} VALUES ({','.join(['%s'] * len(next(reader)))})", reader)
    # Фиксируем транзакцию
    conn.commit()
    # Закрываем соединение
    cur.close()
    conn.close()
# Вставка данных в таблицу customers_table
insert_data('customers_table', 'north_data/customers_data.csv')
# Вставка данных в таблицу employees_table
insert_data('employees_table', 'north_data/employees_data.csv')
# Вставка данных в таблицу orders_table
insert_data('orders_table', 'north_data/orders_data.csv')
