# inception

## Docker Compose nedir?
  
birden fazla Docker koneynerini tanımlamak, yapılandırmak, ve yönetmek için kullanılan bir araçtır.Genellikle birden fazla servisin birlikte çalıştığı microservis mimarisinde kullanılır.

temel işlevleri:
- Birden fazla containeri tanımlamak: docker-compose.yml adında bir dosya kullanarak birden fazla containerin yapılandırılmasını tek bir dosyada tanımlar.
- Servis bağımlılıklarını yönetmek: farklı servislerin birbirine olan bağımlılıklarını tanımlar ve tüm servisi bir komutla başlatır.
- containerleri aynı anda başlatmak ve durdurmak: Tüm servisleri başlatır (docker-compose up) yada durdurur (docker-compose down).
- Ortam değişkenleri ve yapılandırmalar: Konteynerlerin her biri için özel ayarlar ve ortam değişkenleri belirleyerek farklı ortamlarda çalışmasını sağlar.

Önemli docker komutları:
- ```docker-compose up``` : docker-compose.yml dosyasını okuyarak tanımlanan tüm servisleri başlatır.
- ```docker-compose down``` : çalışan tüm servisleri durdurur, kaldırır.
- ```docker-compose ps``` : çalışan containerlerin listelerini gösterir.
- ```docker-compose build``` : Tanımlanan docker imajlarını oluşturur.
- ```docker-compose logs``` : Servislerin loglsrını gösterir.

Docker compose nasıl çalışır:
  

```yaml
  version: '3'

services:
  web:
    image: nginx
    ports:
      - "80:80"
    volumes:
      - ./html:/usr/share/nginx/html
  db:
    image: mysql
    environment:
      MYSQL_ROOT_PASSWORD: example
    volumes:
      - db_data:/var/lib/mysql

volumes:
  db_data:
```

bu örnek iki servis tanımlar:
- web: Nginx web sunucusunu çalıştırır ve ./html klasörünü konteynerdeki /usr/share/nginx/html klasörüne bağlar. ayrıca 80 numaralı portu harici 80 portuna yönlendirir.
- db: MYSQL veritabanını çalıştırır ve ortam değişkeni ile roor şifresini tanımlar. veritabanı verilerini kalıcı hale getirmek için hacim(volume) tanımlar.














