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

Для получения одной акций:
```ruby
client.stock(:sber) # => MoexIss::Market::Stock
```
Для получения всех акций:
```ruby
client.stocks # => MoexIss::Market::Stocks
```
Получаем класс, по которому можно итерироваться а так же вызывать искомую ценную бумагу по ее `isin`
```ruby
stocks.sber
```
Экземпляр класса `MoexIss::Market::Stocks` отвечает на методы:
```ruby
%i[bid market_price_today market_price secid short_name lat_name board_id board_name isin prev_price prev_date response market_data]
```
где `response` содержит полный ответ от MOEX ISS, из которого можно получать доп.параметры


## Лицензия

Исходный код распространяется под лицензией [MIT License](http://opensource.org/licenses/MIT).
