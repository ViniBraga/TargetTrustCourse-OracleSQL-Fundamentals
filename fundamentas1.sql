/*update tclientes
set end = 'RUA X'
WHERE ID = 1;

COMMIT / ROLLBACK;

create table tclientes 
(id number, nome varchar2(30), end varchar2(30)
);

insert into tclientes
values
(1, 'THIAGO', 'RUA X');

---------------------
export ORACLE_SID=ora12c

cd /u01/setup/fundamentals1

sqlplus / as sysdba

@criausuario.sql

conn lazza/lazza

@setup

----------------------
SELECT * FROM tclientes;
select nome from tclientes;
select upper(nome) from tclientes;
select distinct estado from tclientes;
select nome || '(' || estado || ')' nome_estado from tclientes;

select 
   c.nome
   ,d.nome 
from 
   tclientes c
   ,tcursos d
/

*/
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';

select * from tclientes;
select substr(nome,1,30), preco,preco from tcursos;
select 'THIAGO', NOME from tclientes;

select 'alter index ' || index_name || ' rebuild;' from user_indexes;

alter index TCLIENTES_ID_PK rebuild;
alter index TCONTRATOS_ID_PK rebuild;
alter index TCURSOS_ID_PK rebuild;
alter index TDS_CLASSE_PK rebuild;
alter index TIT_TCONTRATOS_ID_SEQ_PK rebuild;
select count(1) from tclientes;

select sysdate, sysdate + 1 / 24 from dual;

select * from tclientes;
update tclientes
set cidade=null
where id =110;
commit;

select nome NM_CLI_NULL from tclientes where cidade is null;

select id || '#' || rpad(nome,30,' ') || '#' || rpad(endereco,30,' ') || '#' || cep from tclientes;

select '#Oracle''s quo''te oper''''ator#' from dual;

SELECT * FROM TCLIENTES;

SELECT * FROM TPEDIDOS WHERE DT_PEDIDO = '09/01/2017';

SELECT * FROM v$nls_parameters;

select * from tab;
select * from user_tables;
select * from user_tab_columns where table_name = 'TCLIENTES';

select preco as Preço_Promocional, nome from tcursos;

select distinct estado from tclientes where estado is not null;

select id, dt_compra, desconto, total from tcontratos;

SELECT id, nome, dt_nascimento, estado, nvl(cep,'N/A') FROM  tclientes WHERE estado in ('RS','rs');

select * from tclientes where id between 110 and 150;
select * from tclientes where id >= 110 and id <= 150;
select * from tclientes where nome like 'A%a';

select * from tclientes where nome like 'Ant_nio%';

select * from tclientes where nome like '\_nt%' escape '\';

select * from tclientes where (id = 110 or nome like 'Thiago%') and estado = 'RS';
select * from tclientes where (id = 110 and nome like 'Thiago%') or (estado = 'RS');

select * from tclientes order by nome;

-- 3.2
select id, dt_compra from tcontratos where total >= 10000;

-- 3.3
select nome, endereco, cidade, cep, telefone from tclientes where id = 140;

-- 3.4
select id, dt_compra, desconto, total from tcontratos where total not between 2000 and 5000;

-- 3.5
select id, dt_compra, desconto, total from tcontratos where desconto > 0 order by dt_compra;

-- 3.6
select upper(nome), cidade, estado from tclientes where estado in ('RS','SP') order by nome;

-- 3.7
select * from tcontratos where desconto is null or desconto = 0;
select * from tcontratos where nvl(desconto,0) = 0;

select nome,
       lower(nome), 
       upper(nome), 
       initcap(nome), 
       substr(nome,1,5),
       length(nome),
       instr(nome,'da',1),
       rpad(nome,30,' '),
       replace(replace(replace(replace(nome,'á','a'),'ã','a'),'é','e'),'â','a'),
       translate(nome,'áâôéã','aaoea')
from tclientes;

select sqrt(144),power(2,80), round(45.926,2), trunc(45.926) from dual;

alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
select sysdate, trunc(sysdate), add_months(sysdate,2), sysdate+60, last_day(sysdate) from dual;

select 140, to_char(140), '#123123#THIAGO#' || SYSDATE || 12, TO_CHAR(SYSDATE,'DD/MM/YYYY') from dual;

SELECT TO_CHAR (.89,'999G999G999G990D99') FROM DUAL;

sELECT id, dt_compra,  to_char(total, 'L99G999G999D99') FROM  tcontratos;

select CIDADE,nvl2(cidade,'NAO É NULL', 'É NULL') from tclientes;

SELECT 
ESTADO,
CASE WHEN ESTADO IN ('RS') THEN 'REGIAO SUL' ELSE CASE WHEN ESTADO IN ('SP','RJ') THEN 'REGIAO SUDESTE' END END
FROM
TCLIENTES;

SELECT CURRENT_TIMESTAMP FROM DUAL;

SELECT DECODE(estado,'RS','Rio grande do sul','SP', 'São Paulo','outro') from tclientes;

/* pelamor nao mexa no codigo abaixo */
select 
  upper(substr(nome,1,10)), 
  substr(upper(nome),1,20), 
  instr(nome,' '),
  instr(nome,' ',1,2),
  replace(upper(substr(nome,instr(nome,' ')+1,instr(nome,' ',1,2)-instr(nome,' ')-1)),'A','X')
  from tclientes;

---------------------
-- 4.3
select id, cod_trg, preco, preco * 1.15  "Novo Preço"
from tcursos
where 
--instr(to_char(id),'1') > 0
to_char(id) like '%1%'
;

-- 4.4
select id, cod_trg, preco, preco * 1.15  "Novo Preço",  preco * 1.15 - preco "Aumento"
from tcursos
where 
--instr(to_char(id),'1') > 0
to_char(id) like '%1%'
;

-- 4.5
select nome, DT_NASCIMENTO, 
round(months_between(sysdate,dt_nascimento)) "Meses de vida"
from tclientes
order by 3;

-- 4.6
select cod_trg, to_char(preco,'L999G990D99') "Valor Curso" from tcursos;

----------------------------
-- cap 5
select *
from tclientes, tcursos;

select * from tdescontos;

SELECT cli.id    codigo_cliente,
       cli.nome  nome,
       con.id    codigo_contrato,
       con.total total,
       cur.nome  nome
  FROM tclientes cli, tcontratos con, titens it, tcursos cur
 WHERE con.tclientes_id = cli.id 
   AND con.id = it.tcontratos_id
   AND it.tcursos_id = cur.id
   AND cli.nome LIKE 'Amarildo%'
 ORDER BY 1, 3;


select * from tclientes;
select * from tcontratos where tclientes_id = 110;
select * from titens;

SELECT * FROM FUNCIONARIOS f, dependentes d
where d.ID_FUNC(+) = f.id;

select f.nome, f.id, chefes.nome from funcionarios f, funcionarios chefes
where f.chefe = chefes.id(+);

select substr(cur.nome,1,40) curso, substr(pre.nome,1,40) prereq 
from tcursos cur, tcursos pre
where cur.pre_requisito = pre.id;

select lpad (' ', 3*level, ' ') || cur.nome
from tcursos cur
connect by prior cur.id = cur.PRE_REQUISITO
start with cur.PRE_REQUISITO is null;

select lpad(' ', 3*level, ' ') || nome
from funcionarios 
connect by prior id = chefe
start with chefe is null;

-------------
-- 5.2
select cli.nome, con.id, con.DT_COMPRA
from tclientes cli, tcontratos con
where cli.id = con.tclientes_id
order by nome;
;

-- 5.3
select con.id, cli.nome
from tclientes cli, tcontratos con
where cli.id = con.tclientes_id
and upper(cli.nome) like '%A%'
order by nome;
;

-- 5.4
select cli.nome, con.id, con.total
from tclientes cli, tcontratos con
where cli.id = con.tclientes_id
and nvl(desconto,0) = 0
order by nome;
;

-- 5.5
select cli.nome, con.id, con.total, con.desconto, des.classe
from tclientes cli, tcontratos con, tdescontos des
where cli.id = con.tclientes_id
and con.desconto between des.base_inferior and des.base_superior
order by nome;
;

-- 5.6
select cur.id, cur.cod_trg, cur.dt_criacao, req.id, req.cod_trg, req.dt_criacao
from tcursos cur, tcursos req
where cur.pre_requisito = req.id;

------------------
SELECT max(nvl(total,0)), min(nvl(total,0)), round(avg(nvl(total,0))), sum(nvl(total,0))
FROM tcontratos
where tclientes_id = 110;

select count(distinct estado) from tclientes;
select estado from tclientes;


select cli.nome, sum(con.total)
from tclientes cli, tcontratos con
where cli.id = con.tclientes_id
and nvl(desconto,0) = 0
group by cli.nome
order by nome;

select cidade, count(1)
from tclientes
group by cidade
order by 1,2;

select 
   case when 
      to_number(to_char(DT_NASCIMENTO,'MM')) in (1,2,3,4,5,6) then '1º Semestre'
      Else
      '2º Semestre'
      end Semestre_do_Nascimento
      ,count(1)
from tclientes
group by 
    case when 
      to_number(to_char(DT_NASCIMENTO,'MM')) in (1,2,3,4,5,6) then '1º Semestre'
      Else
      '2º Semestre'
      end 
;

SELECT tclientes_id, sum(total)
FROM tcontratos
GROUP  BY tclientes_id
HAVING sum(total) > 5000
ORDER  BY sum(total);

select nome, count(1)
from tclientes
group by nome
having count(1) > 1;

SELECT estado, MIN(dt_nascimento)
FROM   tclientes
GROUP  BY estado
HAVING MIN(dt_nascimento) < (ADD_MONTHS(sysdate, -1 * (40*12)));

select estado, min(dt_nascimento)
from tclientes
where dt_nascimento < ADD_MONTHS(sysdate, -1 * (40*12))
group by estado;

select avg(total)
from tcontratos
group by tclientes_id;

-- 6.3
select round(max(total)), round(min(total)), round(sum(total)), round(avg(total))
from tcontratos con;

-- 6.4
select cli.estado, round(max(total)), round(min(total)), round(sum(total)), round(avg(total))
from tcontratos con, tclientes cli
where con.TCLIENTES_ID = cli.id
group by cli.estado;

-- 6.5
select round(max(total)) - round(min(total)) DIFERENÇA
from tcontratos con;

-- 6.6
select cli.estado, count(1), round(avg(total))
from tcontratos con, tclientes cli
where con.TCLIENTES_ID = cli.id
group by cli.estado;

select round(7.5) from dual;
select round(6.5) from dual;
select round(7.5) from dual;

select * from tclientes where id = &cliente;
select * from tclientes where estado = '&estado';

------------------------
-- Cap 8
select * from
(
   select nome, count(1) qtde
   from tclientes
   group by nome
)
where qtde > 1
;

select * 
from tcontratos
where total in (select total
               from tcontratos x 
               where x.TCLIENTES_ID in (110,120, 130));

-- id, nome, total de contratos por cliente
select cli.id, cli.nome, round(sum(total))
from tcontratos con, tclientes cli
where con.TCLIENTES_ID = cli.id
group by cli.id, cli.nome;

select cli.id, 
       cli.nome, 
      (select sum(con.total) from tcontratos con where con.TCLIENTES_ID = cli.id) total
from tclientes cli;

select * from tb_pedidos
where 
PEDIDO = (SELECT MAX(PEDIDO) FROM TB_PEDIDOS WHERE CLIENTE = 'THIAGO');

SELECT * FROM TCLIENTES;

SELECT id, nome
FROM tclientes
WHERE TO_CHAR(dt_nascimento,'MON') = ( 
                                    SELECT TO_CHAR(dt_nascimento,'MON')
                                    FROM tclientes
                                    WHERE  id = 130)
AND estado = (SELECT estado FROM tclientes WHERE  id = 100);


SELECT dt_compra, AVG (total)
FROM   tcontratos
GROUP  BY  dt_compra
HAVING AVG(total) > (SELECT AVG(total)
                    FROM   tcontratos WHERE TCLIENTES_ID = 1000);

SELECT id, cod_trg, preco
FROM tcursos
WHERE preco NOT IN (                
SELECT MIN(preco)
FROM   tcursos
GROUP  BY carga_horaria);

SELECT id, dt_compra, desconto, total
FROM tcontratos
WHERE (total, NVL(desconto,0)) IN
                               ( SELECT total, NVL(desconto,0)
                                 FROM   tcontratos
                                 WHERE  total < 3000
                                );
                                
SELECT id, dt_compra, desconto, total
FROM tcontratos
WHERE total IN
            (SELECT total
             FROM   tcontratos
             WHERE  total < 3000
             )
AND NVL(desconto,0) IN (SELECT NVL(desconto,0)
                        FROM   tcontratos
                        WHERE  total < 3000
                        );

select * from (                                
select 
   id, 
   nome,
   (case when 
      to_number(to_char(DT_NASCIMENTO,'MM')) in (1,2,3,4,5,6) then '1º Semestre'
    Else
      '2º Semestre'
    end) Semestre_do_Nascimento,
    upper(nome) MAI
from tclientes
) interna
where interna.Semestre_do_Nascimento = '2º Semestre'
and interna.mai like '%NIO%'
;                                
                                
SELECT cs.cod_trg, cs.preco
FROM   tcursos cs
WHERE  cs.id NOT IN
       (SELECT nvl(cs2.pre_requisito,0)
        FROM   tcursos cs2
        )
;

-----------------
-- 8.1

select nome, dt_nascimento
from tclientes a
where a.estado = (
    select estado
    from tclientes x
    where x.nome = 'Mário Cardoso'
    )
and
a.nome <> 'Mário Cardoso';

-- 8.2
select con.id, con.total, cli.nome
from tcontratos con, tclientes cli
where con.tclientes_id = cli.id
and con.total > (select avg(x.total) from tcontratos X )
order by con.total desc;

-- 8.3
select id, nome
from tclientes
where estado in (select estado from tclientes where nome like '%v%')
;
                                
-- 8.4
SELECT * FROM TCURSOS WHERE PRE_REQUISITO IN (
            select ID from tcursos where cod_trg = 'THTML4');
                                
-- 8.5
SELECT NOME, TELEFONE
FROM TCLIENTES
where id in (select tclientes_id 
             from tcontratos 
             where to_char(dt_compra,'dd/mm/yyyy') = '06/01/2005'
             );

SELECT NOME, TELEFONE
FROM TCLIENTES CLI
where EXISTS (select 1
             from tcontratos CON
             where to_char(dt_compra,'dd/mm/yyyy') = '06/01/2005'
             and con.tclientes_id  = cli.id
             );

SELECT distinct NOME, TELEFONE
FROM TCLIENTES CLI, tcontratos CON
where to_char(dt_compra,'dd/mm/yyyy') = '06/01/2005'
and con.tclientes_id  = cli.id
;
                                
                                
-----------------------------
SELECT ID, NOME, TELEFONE, ESTADO, DT_NASCIMENTO
FROM TCLIENTES
WHERE ESTADO = 'RS'
MINUS --INTERSECT --UNION ALL
SELECT ID, NOME, TELEFONE, ESTADO, DT_NASCIMENTO
FROM TCLIENTES
WHERE DT_NASCIMENTO < TO_DATE('01/01/1970','DD/MM/YYYY')
ORDER BY 1
;

SELECT ID, NOME, TELEFONE, ESTADO, DT_NASCIMENTO
FROM TCLIENTES
WHERE ESTADO = 'RS'
UNION ALL
SELECT ID, NOME, NULL, NULL, NULL
FROM TCURSOS
ORDER BY 1
;


-----------------
-- 9.1
SELECT ID, TOTAL, 'CONTRATROS' STRING
FROM TCONTRATOS
UNION
SELECT TCONTRATOS_ID, SUM(TOTAL), 'ITENS'
FROM TITENS
GROUP BY TCONTRATOS_ID
ORDER BY 3, 1;

-- 9.2
SELECT ID, DT_COMPRA, TOTAL FROM TCONTRATOS
MINUS
SELECT ID, DT_COMPRA, TOTAL FROM TCONTRATOS WHERE NVL(DESCONTO,0) = 0
intersect
SELECT con.ID, con.DT_COMPRA, con.TOTAL 
FROM TCONTRATOS con, TCLIENTES cli
where con.tclientes_id = cli.id
and cli.estado = 'SP';

------------------
-- 10
insert into tclientes (id, nome)
values (260, 'ROBERTO CARLOS');

commit;
rollback;

insert into tclientes_rs (id, nome, estado)
select id, nome, estado
from tclientes where estado = 'RS';


insert into tclientes_rs
select * from tcontratos;

update tclientes
set estado='SC'
where id = 210;

INSERT INTO TCLIENTES
(ID, NOME)
VALUES
(100, 'THIAGO');


UPDATE TCLIENTES SET NOME = NULL WHERE ID = 100;

DELETE FROM TITENS;
COMMIT;
INSERT INTO TITENS
SELECT * FROM TITENS AS OF TIMESTAMP SYSDATE -1/24;

SELECT * FROM TCONTRATOS;

----------
--10.0 
create table tclientes_vip
(id number,
sobrenome varchar2(20),
nome varchar2(20),
clienteid varchar2(20),
credito number);

--10.2
insert into tclientes_vip
values(1,'Tapes','Carlos','ctapes',795);

--10.3
insert into tclientes_vip
values(2,'Moura','Ana','amoura',860);

--10.4
select * from tclientes_vip;

--10.5
insert into tclientes_vip
values(3,'Pinheiro','Viviane','vpinheiro',1100);
insert into tclientes_vip
values(4,'Dutra','Manuel','mdutra',750);
insert into tclientes_vip
values(5,'Silva','Cesar','csilva',1550);

commit;

-- 10.8
update tclientes_vip
set sobrenome='Souza'
where id=3;

update tclientes_vip
set credito=1000
where credito<900;

delete from tclientes_vip
where id =2;

commit;

insert into tclientes_vip
values(6,'Pires','Roberto','rpires',2000);

select * from tclientes_vip;

savepoint xuxu;

delete from tclientes_vip;

rollback to savepoint xuxu;

select * from tclientes_vip;

commit;

----------------
CREATE TABLE VENDAS
(
   ID       NUMBER                 NOT NULL,
   DT_VENDA DATE   DEFAULT SYSDATE NOT NULL,
   VL_VENDA NUMBER DEFAULT 0       NOT NULL
);

SELECT * FROM USER_OBJECTS;
SELECT * FROM DBA_DATA_FILES WHERE TABLESPACE_NAME = 'USERS';

SELECT DATA_TYPE, COUNT(1) FROM ALL_TAB_COLUMNS
WHERE DATA_TYPE NOT LIKE 'KU$%'
GROUP BY DATA_TYPE ORDER BY 2 DESC;


CREATE TABLE TCLIENTES_BKP
AS SELECT * FROM TCLIENTES;

SELECT * FROM TCLIENTES_BKP;

DROP TABLE TFORNECEDORES;

CREATE TABLE TFORNECEDORES
AS SELECT ID, NOME Nome_fornecedor, TELEFONE FROM TCLIENTES WHERE 1=2;

alter table tfornecedores add (obs varchar2(2000));
alter table tfornecedores modify (obs varchar2(20));
alter table tfornecedores modify (obs varchar2(100));
alter table tfornecedores rename column obs to observacao;

create table tb_xuxu as select * from all_objects;
select count(1) from tb_xuxu;
insert into tb_xuxu select * from tb_xuxu;

delete from tb_xuxu;

truncate table tb_xuxu;

select bytes/1024/1024 from user_segments where segment_name='TB_XUXU';


---------------
-- 11.1
create table pessoas
(
  id number(7)
  ,nome varchar2(25)
);

insert into pessoas
select id, nome from tclientes where rownum <= 2;

create table contratos
(
  id number(5)
  ,pessoa_id number(7)
  ,data date
  ,desconto number(7,2)
  ,total number(7,2)
);

alter table contratos modify (id number(7));

select * from user_tables;

comment on table contratos is 'Esses são os contratos';


create table tb_clientes
(
id number not null
,nome varchar2(30) not null
,dt_nascimento date
,dt_cadastro date default sysdate not null 
);

alter table tb_clientes add constraint tb_clientes_pk primary key(id);
alter table tb_clientes add constraint tb_clientes_uk unique (nome) ENABLE NOVALIDATE;
ALTER TABLE TB_CLIENTES DROP CONSTRAINT TB_CLIENTES_UK;

select * from user_constraints where table_name = 'TB_CONTRATOS';
select * from user_indexes where table_name = 'TB_CLIENTES';

insert into tb_clientes (id, nome) values (20, 'THIAGO');

select * from tb_clientes;

create table tb_contratos
(
 id number not null constraint cont_pk primary key,
 valor_contrato number,
 id_cliente not null constraint fk_cliente references tb_clientes(id) ON DELETE SET NULL
);

INSERT INTO TB_CONTRATOS VALUES (1, 5000, 10);

-- 12.1
alter table CONTRATOS add constraint PK_CONTRATOS primary key(id);
-- 12.2
alter table PESSOAS add constraint PK_PESSOAS primary key(id);
-- 12.3
alter table CONTRATOS add constraint FK_PESSOAS foreign key(pessoa_id) references pessoas(id);
-- 12.4
select * from user_constraints where table_name in ('PESSOAS','CONTRATOS');
-- 12.5
alter table contratos add imposto number(7,2) check (imposto >= 0);


---------------
create or replace view vw_gauchos as 
select id, nome from tclientes where estado='RS';

create or replace view vw_paulistas as 
select id, nome  from tclientes where estado='SP';

select * from vw_gauchos;

select * from vw_paulistas;
select * from (select id, nome  from tclientes where estado='SP');

insert into tclientes (id, nome, estado) values (300, 'JOSE', 'RS');


create or replace view vw_clientes
as 
select id, upper(nome) NOME, endereco from tclientes;

select * from vw_clientes;

select * from user_views;

------
-- 13.1
create or replace view vcontratos 
as
select id, dt_compra, tclientes_ID CLIENTE
from tcontratos;
select * from vcontratos;

-- 13.5
create or replace view vclienters
as
select id, nome, cidade, estado
from tclientes
where estado='RS'
with read only;

update vclienters set cidade = 'Canoas';

create sequence sq_clientes 
increment by 10
start with 300
nocache
nocycle;

select sq_clientes.nextval from dual;
alter sequence sq_clientes increment by -51002;
select sq_clientes.nextval from dual;
alter sequence sq_clientes increment by 10 nocache;

create sequence sq_volta 
start with 1
increment by 1
maxvalue 10
cycle
nocache;

select sq_volta.nextval from dual;

select * from user_sequences;
/*
declare
 i number;
begin
 for x in 1..20000
 loop
  select sq_clientes.nextval into i from dual;
 end loop;
end;
*/
insert into tclientes (id, nome) values (sq_clientes.nextval, 'Pedro');

select c.*, rowid from tclientes c where nome = 'Thiago Lazzarotto';
create index ix_nome on tclientes(nome);

select * from tclientes where rowid = 'AAAft7AAGAAAC++AAH';

select * from vinicius.tclientes;

create synonym vini_cli for vinicius.tclientes;

select * from vini_cli;

create public synonym vini_cli for vinicius.tclientes;

---------------
-- 14.1
create sequence spessoas_id
start with 10
maxvalue 200
increment by 1;

select * from user_sequences where sequence_name = 'SPESSOAS_ID';

@z:\sala01\e14q3.sql

select * from pessoas;

select * from contratos;
select * from user_constraints where table_name = 'CONTRATOS';
select * from user_cons_columns where constraint_name = 'FK_PESSOAS';
create index ix_pessoa_id on contratos (PESSOA_ID);

select * from user_indexes where table_name = 'CONTRATOS';
select * from user_ind_columns where index_name = 'IX_PESSOA_ID';
