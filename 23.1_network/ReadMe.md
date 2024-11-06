## 23.1 Организация сети - Вячеслав Закариев

### Подготовка к выполнению задания

1. Домашнее задание состоит из обязательной части, которую нужно выполнить на провайдере Yandex Cloud, и дополнительной части в AWS (выполняется по желанию). 
2. Все домашние задания в блоке 15 связаны друг с другом и в конце представляют пример законченной инфраструктуры.  
3. Все задания нужно выполнить с помощью Terraform. Результатом выполненного домашнего задания будет код в репозитории. 
4. Перед началом работы настройте доступ к облачным ресурсам из Terraform, используя материалы прошлых лекций и домашнее задание по теме «Облачные провайдеры и синтаксис Terraform». Заранее выберите регион (в случае AWS) и зону.

---
### Задание 1. Yandex Cloud 

**Что нужно сделать**

1. Создать пустую VPC. Выбрать зону.
2. Публичная подсеть.

 - Создать в VPC subnet с названием public, сетью 192.168.10.0/24.
 - Создать в этой подсети NAT-инстанс, присвоив ему адрес 192.168.10.254. В качестве image_id использовать fd80mrhj8fl2oe87o4e1.
 - Создать в этой публичной подсети виртуалку с публичным IP, подключиться к ней и убедиться, что есть доступ к интернету.
3. Приватная подсеть.
 - Создать в VPC subnet с названием private, сетью 192.168.20.0/24.
 - Создать route table. Добавить статический маршрут, направляющий весь исходящий трафик private сети в NAT-инстанс.
 - Создать в этой приватной подсети виртуалку с внутренним IP, подключиться к ней через виртуалку, созданную ранее, и убедиться, что есть доступ к интернету.

Resource Terraform для Yandex Cloud:

- [VPC subnet](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet).
- [Route table](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_route_table).
- [Compute Instance](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance).

---
### Задание 2. AWS* (задание со звёздочкой)

Это необязательное задание. Его выполнение не влияет на получение зачёта по домашней работе.

**Что нужно сделать**

1. Создать пустую VPC с подсетью 10.10.0.0/16.
2. Публичная подсеть.
 - Создать в VPC subnet с названием public, сетью 10.10.1.0/24.
 - Разрешить в этой subnet присвоение public IP по-умолчанию.
 - Создать Internet gateway.
 - Добавить в таблицу маршрутизации маршрут, направляющий весь исходящий трафик в Internet gateway.
 - Создать security group с разрешающими правилами на SSH и ICMP. Привязать эту security group на все, создаваемые в этом ДЗ, виртуалки.
 - Создать в этой подсети виртуалку и убедиться, что инстанс имеет публичный IP. Подключиться к ней, убедиться, что есть доступ к интернету.
 - Добавить NAT gateway в public subnet.

3. Приватная подсеть.
 - Создать в VPC subnet с названием private, сетью 10.10.2.0/24.
 - Создать отдельную таблицу маршрутизации и привязать её к private подсети.
 - Добавить Route, направляющий весь исходящий трафик private сети в NAT.
 - Создать виртуалку в приватной сети.
 - Подключиться к ней по SSH по приватному IP через виртуалку, созданную ранее в публичной подсети, и убедиться, что с виртуалки есть выход в интернет.

Resource Terraform:

1. [VPC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc).
1. [Subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet).
1. [Internet Gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway).

### Правила приёма работы

Домашняя работа оформляется в своём Git репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
Файл README.md должен содержать скриншоты вывода необходимых команд, а также скриншоты результатов.
Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.

---

### Решение 1

1. Устанавливаем стабильную версию **terraform**

![ver](https://github.com/SlavaZakariev/netology-cloud/blob/48735da52175d45e08b644de617bede50009a806/23.1_network/resources/yc_1_1.1.jpg)

2. Создаём [файлы проекта](https://github.com/SlavaZakariev/netology-cloud/tree/main/23.1_network/git)

3. Инициализируем проект

![init](https://github.com/SlavaZakariev/netology-cloud/blob/48735da52175d45e08b644de617bede50009a806/23.1_network/resources/yc_1_1.2.jpg)

3. Запускаем проект **terraform apply**

![apply](https://github.com/SlavaZakariev/netology-cloud/blob/48735da52175d45e08b644de617bede50009a806/23.1_network/resources/yc_1_1.3.jpg)

4. Проверяем рабобоспособность консольной утилиты **yandex**

![yc](https://github.com/SlavaZakariev/netology-cloud/blob/48735da52175d45e08b644de617bede50009a806/23.1_network/resources/yc_1_1.4.jpg)

5. Проверяем созданные ВМ через веб-консоль в браузере

![consol](https://github.com/SlavaZakariev/netology-cloud/blob/48735da52175d45e08b644de617bede50009a806/23.1_network/resources/yc_1_1.5.jpg)

6. Проверяем созданную облачную сеть **VPC** и подсети **Public** и **Private**

![vpc](https://github.com/SlavaZakariev/netology-cloud/blob/48735da52175d45e08b644de617bede50009a806/23.1_network/resources/yc_1_1.6.jpg)

7. Проверяем созданную таблицу маршрутизации

![router](https://github.com/SlavaZakariev/netology-cloud/blob/48735da52175d45e08b644de617bede50009a806/23.1_network/resources/yc_1_1.7.jpg)

8. Проверяем подключение по **ssh** и наличие выхода в интернет на ВМ `vm-01 (public)`

```bash
PS C:\Users\Администратор> ssh ubuntu@89.169.134.184
The authenticity of host '89.169.134.184 (89.169.134.184)' can't be established.
ED25519 key fingerprint is SHA256:tYL5J371R4hKndZ3r6z2x+2gAuh5dHWSg+tsuzIbxD4.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '89.169.134.184' (ED25519) to the list of known hosts.
Welcome to Ubuntu 22.04.5 LTS (GNU/Linux 5.15.0-124-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Wed Nov  6 04:08:02 PM UTC 2024

  System load:  0.08              Processes:             128
  Usage of /:   52.1% of 7.79GB   Users logged in:       0
  Memory usage: 10%               IPv4 address for eth0: 192.168.10.10
  Swap usage:   0%

ubuntu@vm-public:~$ ping yandex.ru
PING yandex.ru (77.88.44.55) 56(84) bytes of data.
64 bytes from yandex.ru (77.88.44.55): icmp_seq=1 ttl=56 time=7.45 ms
64 bytes from yandex.ru (77.88.44.55): icmp_seq=2 ttl=56 time=7.17 ms
64 bytes from yandex.ru (77.88.44.55): icmp_seq=3 ttl=56 time=7.17 ms
64 bytes from yandex.ru (77.88.44.55): icmp_seq=4 ttl=56 time=7.18 ms
^C
--- yandex.ru ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3005ms
rtt min/avg/max/mdev = 7.167/7.240/7.453/0.122 ms
```

9. Проверяем подключение по **ssh** и наличие выхода в интернет на ВМ `nat-vm-01`

```bash
PS C:\Users\Администратор> ssh ubuntu@89.169.154.70
The authenticity of host '89.169.154.70 (89.169.154.70)' can't be established.
ED25519 key fingerprint is SHA256:iGPyOa109ZDSjJLc+w+q1ZmlTH5ADW4vykWXp22WBAs.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '89.169.154.70' (ED25519) to the list of known hosts.
Welcome to Ubuntu 22.04.5 LTS (GNU/Linux 5.15.0-124-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Wed Nov  6 04:09:45 PM UTC 2024

  System load:  0.0               Processes:             128
  Usage of /:   52.1% of 7.79GB   Users logged in:       0
  Memory usage: 10%               IPv4 address for eth0: 192.168.10.254
  Swap usage:   0%

ubuntu@nat-instance-vm-01:~$ ping yandex.ru
PING yandex.ru (5.255.255.77) 56(84) bytes of data.
64 bytes from yandex.ru (5.255.255.77): icmp_seq=1 ttl=57 time=1.15 ms
64 bytes from yandex.ru (5.255.255.77): icmp_seq=2 ttl=57 time=0.344 ms
64 bytes from yandex.ru (5.255.255.77): icmp_seq=3 ttl=57 time=0.552 ms
64 bytes from yandex.ru (5.255.255.77): icmp_seq=4 ttl=57 time=0.382 ms
^C
--- yandex.ru ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3004ms
rtt min/avg/max/mdev = 0.344/0.607/1.151/0.323 ms
```

10. Делаем из ВМ `nat-vm-01` bridge для ВМ `vm-02 (private)`, добавив строки в конфигурацию ssh по пути: `/.ssh/config`

```bash
Host vm-nat-01
  IdentityFile ~/.ssh/id_ed25519
  HostName 89.169.154.70
  User ubuntu
Host 192.168.20.10
  IdentityFile ~/.ssh/id_ed25519
  HostName 192.168.20.10
  User ubuntu
  ProxyCommand ssh -W %h:%p ubuntu@vm-nat-01 -p 22
```

11. Теперь проверяем подключение по **ssh** и наличие выхода в интернет на ВМ `vm-02 (private)`

```bash
PS C:\Users\Администратор> ssh ubuntu@192.168.20.10
The authenticity of host '192.168.20.10 (<no hostip for proxy command>)' can't be established.
ED25519 key fingerprint is SHA256:0IdhcdE2YKrFLy090rd/fYm931f/s+o6hD5Relce8Io.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '192.168.20.10' (ED25519) to the list of known hosts.
Welcome to Ubuntu 22.04.5 LTS (GNU/Linux 5.15.0-124-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Wed Nov  6 04:32:06 PM UTC 2024

  System load:  0.08              Processes:             128
  Usage of /:   51.6% of 7.79GB   Users logged in:       0
  Memory usage: 10%               IPv4 address for eth0: 192.168.20.10
  Swap usage:   0%

ubuntu@vm-private:~$ ping mail.ru
PING mail.ru (94.100.180.200) 56(84) bytes of data.
64 bytes from mail.ru (94.100.180.200): icmp_seq=1 ttl=57 time=52.2 ms
64 bytes from mail.ru (94.100.180.200): icmp_seq=2 ttl=57 time=103 ms
64 bytes from mail.ru (94.100.180.200): icmp_seq=3 ttl=57 time=51.4 ms
64 bytes from mail.ru (94.100.180.200): icmp_seq=4 ttl=57 time=119 ms
^C
--- mail.ru ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3005ms
rtt min/avg/max/mdev = 51.382/81.529/119.380/30.278 ms
```
