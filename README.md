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
  - ``EXPOSE`` : Konteynerin dinleyeceği portu belirtir, yani konteynerin iletişim kuracağı port
  - ``ENV`` : Ortam değişkenlerini tanımlar.
  - ``CMD`` : konteyner çalıştırıldığında varsayılan olarak çalıştırılacak komutu belirler. her Dockerfile'da bir tane cmd olabilir. container çalıştığında varsayılan değerleri ayarlamak için kullanılır. 
  - ``ENTRYPOINT`` : konteynerin her zaman çalıştırması gereken ana komutu belirtir. CMD ile kulanılabilir, ancak konteyner başladığında başka bir komut verilse bile ENTRYPOINT her zaman çalışır.

    CMD / ENTRYPOINT: ```docker run <image_name> <command>``` şeklinde bir komut gelirse CMD geçersiz kılınır, ancak ENTRYPOINT komutunda run komutuyla eklenen argümanlar, ENTRYPOINT komutuna eklenir. ikisi beraber kullanıldığı durumda da CMD, ENTRYPOINT komutuna argüman olarak kabul edilir.

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

## MariaDB:
  Popüler bir açık kaynaklı ilişkisel vertabanı yönetim sistemi (RDBMS) olan MySQL'in bir forku olarak geliştirilmiştir.
  MariaDB, açık kaynaklı, güvenilir, performanslı ve esnek bir ilişkisel veritabanı sistemidir. MySQL ile tam uyumlu olduğu için, MySQL'den MariaDB'ye geçiş oldukça kolaydır. Özellikle güvenlik, hız ve topluluk desteği konularında avantaj

MariaDB özellikleri:
- açık kaynak: tamamen açık kaynaklı bir proje olarak geliştirilmektedir ve GPl lisansı altında dağıtılmaktadır.
- MySQL uyumluluğu: MySQL'in komutlarına, API'lerine ve kütüphanelerine tam uyumluluk sağlar.
- İleri düzey performans ve optimizasyon: performans iyileştirmeleri ve yeni özelliklerle MySQL'e göre avantajlar sağlar. Özellikle MySQL'e göre sorgu performansı ve ölçeklenebilirlik konusunda iyileştirmeler yapılmıştır.
- Gelişmiş depolama metodları:  MariaDB'de varsayılan depolama motoru olarak Aria kullanılır. Ayrıca, TokuDB, MyRocks, Spider ve diğerleri gibi çeşitli depolama motorlarını destekler.
- Güvenlik iyileştirmeleri: şifrelenmiş tablolar ve veritabanı işlemleri için çeşitli güvenlik geliştirmeleri yapılmıştır.
- Topluluk Odaklı: MySQL’in aksine, MariaDB tamamen topluluk odaklı bir projedir ve kararlar topluluk tarafından alınır.
- MySQL'de bulunmayan bazı ek özellikler ve iyileştirmeler içerir
    - Sanal sütünlar: Veri saklama sırasında hesaplanan sütunlar ekleyebilirsiniz.
    - yayınla-Abone ol (Publish-Subscribe): Bir tabloya gelen değişiklikleri başka bir tabloya veya veritabanına yayınlayabilir.
    - JSON ve Dinamik kolon desteği: JSON verilerini saklamak için gelişmiş destek sunar.

MariaDB kullanım alanları:
- web uygulamaları: Tıpkı MySQL gibi dinamik web siteleri ve uygulamalar için popüler bir veritabanı çözümüdür. WordPress gibi içerik yönetim sistemleri MariaDB kullanabilir.
- İşletme Uygulamaları: Büyük ölçekli işletmeler, MariaDB'nin güvenilirliği ve ölçeklenebilirliği nedeniyle bu sistemi kullanmayı tercih edebilir.
- Clout (bulut) ortamları: MariaDB, bulut tabanlı hizmetler ve platformlarla da uyumludur ve AWS, Google Cloud, Azure gibi birçok bulut sağlayıcı tarafından desteklenir.

## WordPress
  Wen siteleri ve blok oluiturmak için kullanılan açık kaynaklı bir içerik yönetim sistemidir(CMS). Teknik bilgiye gerek kalmadan web sitesi geliştirebilmenizi sağlar. 

Temel Özellikleri:
- Kullanıcı dostu arayüz: Teknik bilgi gerektirmeyen basit bir yönetim paneline sahiptir.
- Esneklik: Farklı amaçlara uygun web siteleri oluşturmak için temalar ve eklentiler sunar.
- Açık kaynak: Ücretsizdir ve geliştiriciler tarafından sürekli geliştirilir.
- SEO Uyumlu: Arama motoru optimizasyonu (SEO) için uygun alt yapıya sahiptir.

## NGINX
  Yüksek performanslı, açık kaynaklı bir web sunucusu ve ters proxy sunucusudur. ilk başta web sunucusu olarak geliştirilmiştir ancak aynı zamanda load balancer (yük dengeleme), HTTP ön bellek sunucusu, ve IMAP/POP3 proxy sunucusu gibi işlevlerde sunar.

NGINX Kullanım Alanları:
- web sunucusu: Yüksek performanslı web siteleri ve uygulamaları için statik ve dinamik içerik sunma görevini üstlenir. Dünya çapındaki en yoğun trafikli web siteleri arasında, NGINX çok yaygın olarak kullanılır (örneğin, Netflix, Dropbox, WordPress).
- Ters Proxy: NGINX, istemci isteklerini arka uç sunuculara yönlendirmek için kullanılır. Bu sayede istemciler, arka plandaki sunucuların doğrudan IP adreslerini göremezler, bu da güvenlik sağlar.
- Yük dengeleme: Yüksek trafikli sitelerde ve uygulamalarda, NGINX, istekleri birden fazla sunucuya dağıtarak sistemin daha dengeli ve hızlı çalışmasını sağlar.
- Önbellekleme: NGINX, sık kullanılan içerikleri önbelleğe alarak sunucunun iş yükünü azaltır ve yanıt süresini hızlandırır. Bu özellik, özellikle performansın önemli olduğu projelerde kullanılır.
- Mikroservis Mimarileri: Mikroservis tabanlı uygulamalarda NGINX, her bir mikroservise gelen istekleri yönlendirmek için kullanılabilir.

NGINX, yüksek performanslı bir web ve ters proxy sunucusu olup, aynı zamanda yük dengeleme, HTTP önbellekleme ve SSL/TLS desteği sunar. Olay tabanlı mimarisi sayesinde düşük bellek kullanımıyla çok sayıda eşzamanlı bağlantıyı yönetebilir. Hem HTTP hem de TCP/UDP trafiğini yönlendirebilir, dinamik ve statik içerikleri sunabilir, ayrıca güvenliği artıran ters proxy işlevi görür. Gelişmiş yapılandırma seçenekleri ve modüler yapısı ile büyük ölçekli sistemlerde güvenilir bir çözüm sağlar.


### TLS sertifikası (Transport Layer Security sertifikası)
  Bir web sitesi sunucusu ile istemci arasında güvenli bir bağlantı sağlamak için kullanılan bir dijital sertifikadır. Bu sertifika, bir web sitesibin kimliğini doğrular ve site ile kullanıcılar arasında iletilen verilerin şifrelenmesini sağlar. 
  Kısaca internet üzerindeki veri güvenliğini sağlamak, kimlik doğrulaması yapmak ve kullanıcıların güvende hissetmesini sağlamak için önemlidir.

  TLS, ```SSL```'in (Secure Sockets Layer) geliştirilmiş bir sürümüdür. SSL artık güncel olmadığı için TLS kullanılır, ancak genellikle SSL sertifikası terimi TLS sertifikalarıyla birbirinin yerine kullanılabilir.

TLS Sertifikalarının Çalışma Şekli:
  - Sertifika Otoritesi (CA): CA bir güvenilir üçüncü taraf olarak web sitesinin gerçekten iddia ettiği kişi ya da kuruluş tarafından yönetilip yönetilmediğini denetler,  başvuru sahibinin kimliğini ve alan adı üzerinde yetkisi olup olmadığını çeşitli yöntemlerle doğrular. denetlemeler sonucu onay alırsa TLS sertifikası verir. CA, web sitelerinin güvenilirliğini sağlayan bir yetkilendirme otoritesidir.
  - Anahtar Çifti: TLS sertifikaları, açık anahtar ve özel anahtar olmak üzere iki anahtarla çalışır. Açık anahtar, sertifikada yer alır ve herkes tarafından kullanılabilir. Özel anahtar ise sunucuda tutulur ve şifreleme işlemlerinde kullanılır.
  - El Sıkışma (Handshake):stemci (örneğin bir tarayıcı), web sunucusuna bağlanmaya çalıştığında bir el sıkışma işlemi başlatılır. Bu işlem sırasında sunucu, istemciye TLS sertifikasını gönderir ve taraflar arasında güvenli bir bağlantı kurulur.

TLS sertifikasının işlevleri:
  - Kimlik Doğrulama: Sertifika, web sunucusunun gerçek bir işletme veya kişi tarafından yönetildiğini doğrular.
  - Veri Şifreleme: TLS, sunucu ile istemci (örneğin, bir tarayıcı ve web sitesi) arasındaki veri iletimini şifreler. Bu, hassas verilerin (şifreler, kredi kartı bilgileri, kişisel bilgiler) güvenli bir şekilde iletilmesini sağlar ve bu verilerin üçüncü şahıslar tarafından ele geçirilmesini engeller.
  - Veri Bütünlüğü: Sertifika ayrıca iletilen verilerin bütünlüğünü sağlar, yani verilerin gönderilirken değişmediğinden emin olunur.

TLS Sertifikasının Türleri:
  - Domain Doğrulamalı (DV) Sertifikalar: Yalnızca domain adının sahipliğini doğrular. En basit ve en yaygın sertifika türüdür.
  - Kuruluş Doğrulama (OV) Sertifikalar: Domain sahibinin kimliğinin yanı sıra kuruluşun varlığını da doğrular.
  - Genişletilmiş Doğrulamalı (EV) Sertifikalar: En güvenilir sertifika türüdür ve şirketlerin kimliğini ayrıntılı bir doğrulama sürecinden geçirir. Bu tür sertifikalar, tarayıcıda şirket adının gösterilmesine olanak tanır.

# Aklımda Bulunması Gereken Komutlar:
- ``docker version`` : yüklü docker engine versiyonunu öğrenmek ve docker engine ile iletişim kurabilecek client versiyonunu görebilir.
- ``docker info`` : sistemde yüklü olan docker engine hakkında bilgi edinmek için kullanılır.
- ``docker`` : docker CLI ile kullanabileceğim komutları göserir.
- ``docker 'komut_Adı' --help`` : girilen komutun ne olduğu, nasıl kullanıldığı, altındaki opsiyonlar hakkında bilgiler verir.
- ``docker run ...`` : yeni bir container çalıştırmak veiçerisinde komut çalıştırmak için kullanılır.
- ``docker run -d ...`` : containeri detached modda çalıştırır.(container arkada çalışır ve terminalime stdout ve stderror çıkışlarını bağlamaz.)
- ``docker ps`` : çalışan container listesine bakmak için.
- ``docker ps -a`` : hem çalışan hem durdurulmuş containerlere bakmak için.
- ``inspect`` : docker objesi hakkında daha detaylı bilgi için. (docker container(yada image) inspect ID(yada ismi))
- ``docker stop ID(isim)`` : çalışsan containeri durdurmak için kullanılır. Container silinmez daha sonra yeniden başlatılabilir.
- ``docker start ID(isim)`` : stop durumdaki containeri yaniden çalıştırmak için. Sade durdurlmuş containerleri çalıştırır. yeni container oluşturamaz.
- ``docker-compose up`` : docker compose tarafından yönetilen tüm servisleri ve konteynerleri durdurur ve siler. docker-compose projesini durdurmak ve kaynakları serbest bırakmak için kullanılır. ``-v`` eki ile konteynerle beraber bağlı kaynaklar (Network ve volume) da silinir.
- ``docker-compose down`` : docker-compose.yml dosyasındaki tüm servisleri başlatmak için kullanılır. servis yoksa yeniden oluşturulur. ``-d`` ile arka planda çalıştırılabilir.
- ``docker logs ID(isim)`` : containerin içerisindeki logara bakmak için.
- ``docker rm ID(yada ismi)`` : stop durumundaki containeri sistemden silmek için kullanılır.
- ``docker rm -f ID(yada isim)`` : çalışır durumdaki containeri silmek için.














































