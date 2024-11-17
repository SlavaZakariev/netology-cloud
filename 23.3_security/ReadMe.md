## 23.3 Безопасность в облачных провайдерах - Вячеслав Закариев

Используя конфигурации, выполненные в рамках предыдущих домашних заданий, нужно добавить возможность шифрования бакета.

---

### Задание 1. Yandex Cloud   

1. С помощью ключа в KMS необходимо зашифровать содержимое бакета:

 - создать ключ в KMS;
 - с помощью ключа зашифровать содержимое бакета, созданного ранее.

2. (Выполняется не в Terraform)* \
   Создать статический сайт в Object Storage c собственным публичным адресом и сделать доступным по HTTPS:

 - создать сертификат;
 - создать статическую страницу в Object Storage и применить сертификат HTTPS;
 - в качестве результата предоставить скриншот на страницу с сертификатом в заголовке (замочек).

Полезные документы:

- [Настройка HTTPS статичного сайта](https://cloud.yandex.ru/docs/storage/operations/hosting/certificate).
- [Object Storage bucket](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/storage_bucket).
- [KMS key](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kms_symmetric_key).

--- 

### Задание 2*. AWS (задание со звёздочкой)

Это необязательное задание. Его выполнение не влияет на получение зачёта по домашней работе.

**Что нужно сделать**

1. С помощью роли IAM записать файлы ЕС2 в S3-бакет:
 - создать роль в IAM для возможности записи в S3 бакет;
 - применить роль к ЕС2-инстансу;
 - с помощью bootstrap-скрипта записать в бакет файл веб-страницы.
2. Организация шифрования содержимого S3-бакета:

 - используя конфигурации, выполненные в домашнем задании из предыдущего занятия, добавить к созданному ранее бакету S3 возможность шифрования Server-Side, используя общий ключ;
 - включить шифрование SSE-S3 бакету S3 для шифрования всех вновь добавляемых объектов в этот бакет.

3. *Создание сертификата SSL и применение его к ALB:

 - создать сертификат с подтверждением по email;
 - сделать запись в Route53 на собственный поддомен, указав адрес LB;
 - применить к HTTPS-запросам на LB созданный ранее сертификат.

Resource Terraform:

- [IAM Role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role).
- [AWS KMS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key).
- [S3 encrypt with KMS key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object#encrypting-with-kms-key).

Пример bootstrap-скрипта:

```
#!/bin/bash
yum install httpd -y
service httpd start
chkconfig httpd on
cd /var/www/html
echo "<html><h1>My cool web-server</h1></html>" > index.html
aws s3 mb s3://mysuperbacketname2021
aws s3 cp index.html s3://mysuperbacketname2021
```

### Правила приёма работы

Домашняя работа оформляется в своём Git репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
Файл README.md должен содержать скриншоты вывода необходимых команд, а также скриншоты результатов.
Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.

---

### Решение 1

1. Создаём файлы проекта:

- [bucker.tf - файл с описанием бакета](https://github.com/SlavaZakariev/netology-cloud/blob/main/23.3_security/git/bucker.tf)
- [network.tf - файл с описанием сети](https://github.com/SlavaZakariev/netology-cloud/blob/main/23.3_security/git/network.tf)
- [vars.network.tf - файл с переменными для сети](https://github.com/SlavaZakariev/netology-cloud/blob/main/23.3_security/git/vars.network.tf)
- [provider.tf - файл с описанием провайдера](https://github.com/SlavaZakariev/netology-cloud/blob/main/23.3_security/git/provider.tf)
- [vars.provider.tf файл с переменными для провайдера](https://github.com/SlavaZakariev/netology-cloud/blob/main/23.3_security/git/vars.provider.tf)
- [files/Picture-01.jpg - Графический файл](https://github.com/SlavaZakariev/netology-cloud/blob/main/23.3_security/git/files/Picture-01.jpg)

2. Инициализируем проект

![init](https://github.com/SlavaZakariev/netology-cloud/blob/b5a5eba99bec53d9a70f88c6ec8ea04fd7b6c406/23.3_security/resources/yc_3_1.1.jpg)

3. Запускаем выполнение проекта

![apply](https://github.com/SlavaZakariev/netology-cloud/blob/main/23.3_security/resources/yc_3_1.2.jpg)

4. Проверяем созданный ключ

![key](https://github.com/SlavaZakariev/netology-cloud/blob/main/23.3_security/resources/yc_3_1.3.jpg)

5. Проверяем созданный ключ через терминал Яндекс

![yc-key](https://github.com/SlavaZakariev/netology-cloud/blob/50160e319d97f06382ffd21fdb22a642ef6fbce9/23.3_security/resources/yc_3_1.3.1.jpg)

6. Проверяем созданный бакет

![buck](https://github.com/SlavaZakariev/netology-cloud/blob/main/23.3_security/resources/yc_3_1.4.jpg)

7. Проверяем доступность нашего объекта по прямой ссылке:
[https://storage.yandexcloud.net/zakariev-netology-bucket/Picture-01.jpg](https://storage.yandexcloud.net/zakariev-netology-bucket/Picture-01.jpg)

Объект недоступен, так как зашифрован

![buck](https://github.com/SlavaZakariev/netology-cloud/blob/main/23.3_security/resources/yc_3_1.5.jpg)
