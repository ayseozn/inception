# inception

## Docker Compose
  Birden fazla Docker koneynerini tanımlamak, yapılandırmak, ve yönetmek için kullanılan bir araçtır.Genellikle birden fazla servisin birlikte çalıştığı microservis mimarisinde kullanılır.

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

## Dockerfile
  Bir docker imajını oluşturmak için kullanılan bir betik dosyadır. Dockerfile, bir uygulama veya hizmetin Docker konteyneri olarak nasıl paketleneceğini belirler ve bu dosya, Docker'ın imaj oluşturma sürecini otomatikleştirir.

  Dockerfile Nasıl Çalışır?

  Bazı Temel Dockerfile Talimatları:
  - ```FORM``` : Docker imajını oluşturmak için kullanılacak taban imajı belirtir. Her dockerfile taban imajla başlar.
  - ```RUN``` : Konteynerin içinde çalıştırılacak bir komut tanımlar. Yazılım kurulumu, paketlerin güncellenmesi vb.
  - ``COPY`` veya ``ADD`` : Dosyaları veya dizinleri yerel sistemden docker imajına kopyalar.
  - ``WORKDIR`` : Komutların çalıştırılacağı çalışma dizinini belirler. bu komutta belirtilen dizin sonraki komutların çalıştırılacağı yer olur.
  - ``CMD`` : konteyner çalıştırıldığında varsayılan olarak çalıştırılacak komutu belirler. her Dockerfile'da bir tane cmd olabilir.
  - ``EXPOSE`` : Konteynerin dinleyeceği portu belirtir, yani konteynerin iletişim kuracağı port
  - ``ENV`` : Ortam değişkenlerini tanımlar.
  - ``ENTRYPOINT`` : konteynerin her zaman çalıştırması gereken ana komutu belirtir. CMD ile kulanılabilir, ancak konteyner başladığında başka bir komut verilse bile ENTRYPOINT her zaman çalışır.

örnek Dockerfile:
  ```Dockerfile
# Python 3.9 ile çalışan hafif bir taban imaj kullanır.
FROM python:3.9-slim

# Çalışma dizinini belirler.
WORKDIR /app

# Gereken dosyaları imaja kopyalar.
COPY requirements.txt requirements.txt

# Gerekli bağımlılıkları kuruyoruz
RUN pip install -r requirements.txt

# Uygulama dosyalarını kopyalıyoruz
COPY . .

# Uygulamanın 5000 portunda çalışacağını belirtiyoruz
EXPOSE 5000

# Varsayılan çalıştırma komutunu belirtiyoruz
CMD ["python", "app.py"]

```

geçerli dizinde bulunan dockerfil'a göre myapp isimli docker imajı oluşturur.
```bash
 docker build -t myapp .
```

Dockerfile Avantajları:
- Tekrar edilebilirlik : Bir uygulamanın çalışması için gereken tüm ayarlar, bağımlılıklar ve yapılandırmalar tek bir dosyada tutulur, bu da imajın tekrar tekrar oluşturulmasını kolaylaştırır.
- Paylaşılabilirlik : Dockerfile'ı paylaşarak, birden fazla kişi aynı ortamda uygulamayı çalıştırabilir.
- Otomasyon : İmaj oluşturma süreci otomatik hale getirildiğinden, manuel müdahale gerekmeden kolayca imaj oluşturulabilir.

Dockerfile, Docker imajlarının nasıl oluşturulacağını belirleyen bir betik dosyasıdır. İçerisinde kullanılan talimatlarla, bir uygulamanın çalışması için gereken ortamı tanımlayarak, imajın tekrarlanabilir ve paylaşılabilir olmasını sağlar. Dockerfile, Docker ekosisteminin temel taşlarından biridir ve konteynerleştirilmiş uygulamaların yönetimini büyük ölçüde kolaylaştırır.








