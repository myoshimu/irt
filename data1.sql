1) totalが0のレコードを排除

CREATE TABLE saled_item (
PRIMARY KEY(tid, tdid), INDEX(cid), INDEX(pid)
)
select t.cid cid,
td.tid tid,
td.tdid tdid,
td.pid pid,
max.mtotal mtotal,
td.total total,
td.sale sale
from
tdetail td,
transaction t,
(select pid,max(total) mtotal
from tdetail td
group by pid) max
where td.pid=max.pid
and t.tid=td.tid
and total > 1

2) 

CREATE TABLE item_rate  (
PRIMARY KEY(tid,tdid),INDEX(cid),INDEX(category1)
)  
select distinct s.tid,s.tdid,s.cid,s.pid,i.category1 ,mtotal,total,s.sale 
from saled_item s,item i
where s.pid=i.pid
and ((mtotal=total and sale='0') #価格が定価と同じでセールフラグ0
or (mtotal>total and sale='1'))   #価格が定価より低くてセールフラグがゼロ

3) 
 UPDATE item_rate SET category1 = 1 WHERE category1 = "その他 ";
 UPDATE item_rate SET category1 =2 WHERE category1 = "アクセサリー";
 UPDATE item_rate SET category1 =3 WHERE category1 = "アンダーウェア";
 UPDATE item_rate SET category1 =4 WHERE category1 = "インテリア";
 UPDATE item_rate SET category1 =5 WHERE category1 = "オールインワン・サロペット ";
 UPDATE item_rate SET category1 =6 WHERE category1 = "コスメ/香水 ";
 UPDATE item_rate SET category1 =7 WHERE category1 = "シューズ  ";
 UPDATE item_rate SET category1 =8 WHERE category1 = "ジャケット/アウター";
 UPDATE item_rate SET category1 =9 WHERE category1 = "スカート  ";
 UPDATE item_rate SET category1 = 10 WHERE category1 = "スーツ/ネクタイ";
 UPDATE item_rate SET category1 = 11 WHERE category1 = "トップス  ";
 UPDATE item_rate SET category1 = 12 WHERE category1 = "バッグ ";
 UPDATE item_rate SET category1 = 13 WHERE category1 = "パンツ ";
 UPDATE item_rate SET category1 = 14 WHERE category1 = "ファッション雑貨 ";
 UPDATE item_rate SET category1 = 15 WHERE category1 = "ヘアアクセサリー ";
 UPDATE item_rate SET category1 = 16 WHERE category1 = "マタニティ・ベビー  ";
 UPDATE item_rate SET category1 = 17 WHERE category1 = "レッグウェア ";
 UPDATE item_rate SET category1 = 18 WHERE category1 = "ワンピース";
 UPDATE item_rate SET category1 = 19 WHERE category1 = "帽子 ";
 UPDATE item_rate SET category1 = 20 WHERE category1 = "時計 ";
 UPDATE item_rate SET category1 = 21 WHERE category1 = "水着/着物・浴衣";
 UPDATE item_rate SET category1 = 22 WHERE category1 = "財布/小物 ";
 UPDATE item_rate SET category1 = 23 WHERE category1 = "雑貨/ホビー/スポーツ";
 UPDATE item_rate SET category1 = 24 WHERE category1 = "音楽/本・雑誌  ";
 UPDATE item_rate SET category1 = 25 WHERE category1 = "食器/キッチン  ";


4) 最終クエリ
#箱ひげ図に入っててかつセールフラグがあるアイテム
select distinct cid,category1,sale,avg((mtotal-total)/mtotal) srate
from item_rate i
where  cid in (
select t.cid
from transaction t, tdetail td 
where t.tid=td.tid
group by t.cid
having count(*) < 117
)
and pid in
(select distinct pid from item_rate
where sale='1')
group by cid,category1,sale
