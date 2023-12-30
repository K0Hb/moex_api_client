[![Gem Version](https://badge.fury.io/rb/moex_iss.svg)](https://badge.fury.io/rb/moex_iss)
[![Build](https://github.com/K0Hb/moex_iss/workflows/Build/badge.svg)](https://github.com/palkan/moex_iss/actions)
[![JRuby Build](https://github.com/K0Hb/moex_iss/workflows/JRuby%20Build/badge.svg)](https://github.com/K0Hb/moex_iss/actions)

# Moex Iss

Реализация части запросов к [MOEX Informational & Statistical Server](https://www.moex.com/a2193).

Реализовано несколько функций-запросов информации о торгуемых ценных бумаг, результаты которых напрямую конвертируются в Ruby класс.

Класс ценной бумаги имеет методы для получения наиболее часто использумеых показателей ценной бумаги а так же метод для получения полного ответа полученного от MOEX ISS.

## Установка

```ruby
# Gemfile
gem "moex_iss"
```
А затем выполнить:

    $ bundle install

Или установите его самостоятельно как:

    $ gem install moex_api

### Поддерживаемые Ruby версии

- Ruby (MRI) >= 2.7.0
- JRuby >= 9.3.0

## Использование

### Создаем клиент

```ruby
client = MoexIss.client
```

### Акции

Для получения последних актульных данных:
- Все акции
```ruby
client.stocks # => MoexIss::Market::Stocks
```
Получаем класс, по которому можно итерироваться а так же вызывать искомую ценную бумагу по ее `isin`
```ruby
stocks.sber # => MoexIss::Market::Stock
```
- Одна Акция
```ruby
client.stock(:sber) # => MoexIss::Market::Stock
```
+ Для получения данные об исторических данных:
```ruby
client.stock(:sber, from: '2023-12-01', till: '2023-12-05') # => MoexIss::Market::History::Stocks
```
Есть возможность работы с коллекцией через дату:
```ruby
stocks = client.stock(:sber, from: '2023-12-01', till: '2023-12-05') # => MoexIss::Market::History::Stocks
stocks['2023-12-03']  # => MoexIss::Market::History::Stock
```
Максимальное количесво дней: _100_

Аргументы `from` и `till` можно использовать по одиночке


Все экземпляры классов отвечает на метод `response`, который содержит полный ответ от MOEX ISS, из которого можно получать доп.параметры,
так же у кажого класса свой набор спецефических методов для удобства работы с данными.
```ruby
# Пример
client.stock(:sber).market_price # => 271.37
client.stock(:sber).prev_date # => 2023-12-2
...
```


## Лицензия

Исходный код распространяется под лицензией [MIT License](http://opensource.org/licenses/MIT).
