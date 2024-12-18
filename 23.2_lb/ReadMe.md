## 23.2 Вычислительные мощности. Балансировщики нагрузки - Вячеслав Закариев

### Подготовка к выполнению задания

1. Домашнее задание состоит из обязательной части, которую нужно выполнить на провайдере Yandex Cloud, и дополнительной части в AWS (выполняется по желанию). 
2. Все домашние задания в блоке 15 связаны друг с другом и в конце представляют пример законченной инфраструктуры.  
3. Все задания нужно выполнить с помощью Terraform. Результатом выполненного домашнего задания будет код в репозитории. 
4. Перед началом работы настройте доступ к облачным ресурсам из Terraform, используя материалы прошлых лекций и домашних заданий.

---
### Задание 1. Yandex Cloud 

**Что нужно сделать**

1. Создать бакет Object Storage и разместить в нём файл с картинкой:

 - Создать бакет в Object Storage с произвольным именем (например, _имя_студента_дата_).
 - Положить в бакет файл с картинкой.
 - Сделать файл доступным из интернета.
 
2. Создать группу ВМ в public подсети фиксированного размера с шаблоном LAMP и веб-страницей, содержащей ссылку на картинку из бакета:

 - Создать Instance Group с тремя ВМ и шаблоном LAMP. Для LAMP рекомендуется использовать `image_id = fd827b91d99psvq5fjit`.
 - Для создания стартовой веб-страницы рекомендуется использовать раздел `user_data` в [meta_data](https://cloud.yandex.ru/docs/compute/concepts/vm-metadata).
 - Разместить в стартовой веб-странице шаблонной ВМ ссылку на картинку из бакета.
 - Настроить проверку состояния ВМ.
 
3. Подключить группу к сетевому балансировщику:

 - Создать сетевой балансировщик.
 - Проверить работоспособность, удалив одну или несколько ВМ.

4. (дополнительно)* Создать Application Load Balancer с использованием Instance group и проверкой состояния.

Полезные документы:

- [Compute instance group](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance_group).
- [Network Load Balancer](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/lb_network_load_balancer).
- [Группа ВМ с сетевым балансировщиком](https://cloud.yandex.ru/docs/compute/operations/instance-groups/create-with-balancer).

---

### Задание 2*. AWS (задание со звёздочкой)

Это необязательное задание. Его выполнение не влияет на получение зачёта по домашней работе.

**Что нужно сделать**

Используя конфигурации, выполненные в домашнем задании из предыдущего занятия, добавить к Production like сети Autoscaling group из трёх EC2-инстансов с  автоматической установкой веб-сервера в private домен.

1. Создать бакет S3 и разместить в нём файл с картинкой:

 - Создать бакет в S3 с произвольным именем (например, _имя_студента_дата_).
 - Положить в бакет файл с картинкой.
 - Сделать доступным из интернета.
2. Сделать Launch configurations с использованием bootstrap-скрипта с созданием веб-страницы, на которой будет ссылка на картинку в S3. 
3. Загрузить три ЕС2-инстанса и настроить LB с помощью Autoscaling Group.

Resource Terraform:

- [S3 bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)
- [Launch Template](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template).
- [Autoscaling group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group).
- [Launch configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration).

Пример bootstrap-скрипта:

```
#!/bin/bash
yum install httpd -y
service httpd start
chkconfig httpd on
cd /var/www/html
echo "<html><h1>My cool web-server</h1></html>" > index.html
```
### Правила приёма работы

Домашняя работа оформляется в своём Git репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
Файл README.md должен содержать скриншоты вывода необходимых команд, а также скриншоты результатов.
Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.

---

### Решение 1

1. Создаём файлы проекта:

- [bucker.tf - файл с описанием бакета](https://github.com/SlavaZakariev/netology-cloud/blob/main/23.2_lb/git/bucket.tf)
- [instance-group.tf - файл с описанием инстанса ВМ](https://github.com/SlavaZakariev/netology-cloud/blob/main/23.2_lb/git/instance-group.tf)
- [vars.instance-group.tf - файл с переменными для инстанса](https://github.com/SlavaZakariev/netology-cloud/blob/main/23.2_lb/git/vars.instance-group.tf)
- [load-balancer.tf - файл с описанием балансировщика](https://github.com/SlavaZakariev/netology-cloud/blob/main/23.2_lb/git/load-balancer.tf)
- [network.tf - файл с описанием сети](https://github.com/SlavaZakariev/netology-cloud/blob/main/23.2_lb/git/network.tf)
- [vars.network.tf - файл с переменными для сети](https://github.com/SlavaZakariev/netology-cloud/blob/main/23.2_lb/git/vars.network.tf)
- [provider.tf - файл с описанием провайдера](https://github.com/SlavaZakariev/netology-cloud/blob/main/23.2_lb/git/provider.tf)
- [vars.provider.tf файл с переменными для провайдера](https://github.com/SlavaZakariev/netology-cloud/blob/main/23.2_lb/git/vars.provider.tf)
- [files/Picture-01.jpg - Графический файл](https://github.com/SlavaZakariev/netology-cloud/blob/main/23.2_lb/git/files/Picture-01.jpg)

2. Инициализируем проект

![init](https://github.com/SlavaZakariev/netology-cloud/blob/main/23.2_lb/resources/yc_2_1.1.jpg)

3. Запускаем выполнение проекта

![apply](https://github.com/SlavaZakariev/netology-cloud/blob/main/23.2_lb/resources/yc_2_1.2.jpg)

4. Проверяем созданный бакет

![buck](https://github.com/SlavaZakariev/netology-cloud/blob/main/23.2_lb/resources/yc_2_1.3.jpg)

Прямая ссылка для скачивания файла:
[https://storage.yandexcloud.net/zakariev-netology-bucket/Picture-01.jpg](https://storage.yandexcloud.net/zakariev-netology-bucket/Picture-01.jpg)

5. Проверяем созданный бакет через терминал Яндекс

![yc-buck](https://github.com/SlavaZakariev/netology-cloud/blob/main/23.2_lb/resources/yc_2_1.4.jpg)

6. Проверяем созданные ВМ (LAMP) через веб-консоль

![console](https://github.com/SlavaZakariev/netology-cloud/blob/main/23.2_lb/resources/yc_2_1.5.jpg)

7. Проверяем ВМ через терминал Яндекс

![yc-console](https://github.com/SlavaZakariev/netology-cloud/blob/main/23.2_lb/resources/yc_2_1.6.jpg)

8. Проверяем балансировщик и привязанные ВМ

![lb](https://github.com/SlavaZakariev/netology-cloud/blob/main/23.2_lb/resources/yc_2_1.7.jpg)

9. Проверяем балансировщик и статус ВМ через терминал Яндекс

![yc-lb](https://github.com/SlavaZakariev/netology-cloud/blob/main/23.2_lb/resources/yc_2_1.8.jpg)

10. Проверяем по IP-адресу LB доступность графического файла

![jpg1](https://github.com/SlavaZakariev/netology-cloud/blob/main/23.2_lb/resources/yc_2_1.9.jpg)

11. Удаляем 2 ВМ для проверки работы отказоустойчивости LB

![del-vmjpg1](https://github.com/SlavaZakariev/netology-cloud/blob/main/23.2_lb/resources/yc_2_1.10.jpg)

12. Проверяем статус через терминал Яндекс

- 1 машина - Доступна
- 2 машины - Удаляются
- 1 машина - Создаётся автоматически

![yc-lb-status](https://github.com/SlavaZakariev/netology-cloud/blob/main/23.2_lb/resources/yc_2_1.11.jpg)

13. Повторно проверяем по IP-адресу LB доступность графического файла

![jpg2](https://github.com/SlavaZakariev/netology-cloud/blob/main/23.2_lb/resources/yc_2_1.12.jpg)
