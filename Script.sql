--Criação do banco de dados com o nome concessionária

create database concessionaria;

--Criação de tabela com nome endereco e com as colunas, id, rua, bairro, numero, complemento, cep, cidade, estado

create table endereco(
	end_cd_id serial not null primary key,
	end_tx_cep varchar(10) not null,
	end_tx_rua varchar(100) not null,
	end_int_numero int4 not null,
	end_tx_complemento varchar(20),
	end_tx_bairro varchar(25),
	end_tx_cidade varchar(20),
	end_tx_estado varchar(2)
);

--Criação de tabela com nome pessoa e com as colunas id, nome, cpf, nascimento

create table pessoa(
	pes_cd_id serial not null primary key,
	pes_tx_nome varchar(50) not null,
	pes_tx_cpf varchar(14) not null unique,
	pes_tx_nascimento date not null,
	pes_fk_end int4 not null,
	FOREIGN KEY (pes_fk_end) REFERENCES endereco(end_cd_id)
	);

--Criação de tabela com nome carro e com as colunas id, nome, modelo, marca, anoFabricacao, valor

create table carro(
	car_cd_id  serial not null primary key,
	car_tx_nome varchar(25),
	car_tx_modelo varchar(25),
	car_tx_marca varchar(25),
	car_tx_placa varchar(6) not null,
	car_int_anoFabricacao int4,
	car_fl_valor float
);


--Criação de tabela com nome concessionaria e com as colunas id, nome, CNPJ, telefone, valorTotal, dataVendaVeiculo

create table concessionaria(
	conc_cd_id serial not null primary key,
	conc_tx_nome varchar(25),
	conc_tx_cnpj varchar(14),
	conc_tx_telefone varchar(14),
	conc_fl_valorTotal float,
	conc_dt_dataVenda date,
	conc_fk_pes int4 not null,
	conc_fk_car int4 not null,
	conc_fk_end int4 not null,
	FOREIGN KEY (conc_fk_pes) REFERENCES pessoa(pes_cd_id),
	FOREIGN KEY (conc_fk_car) REFERENCES carro(car_cd_id),
	FOREIGN KEY (conc_fk_end) REFERENCES endereco(end_cd_id)
	);




--Inserindo dados na tabela endereco

insert into endereco(end_tx_cep, end_tx_rua, end_int_numero, end_tx_complemento, end_tx_bairro, end_tx_cidade, end_tx_estado)values
 ('12345-678', 'Rua das Palmeiras', 200, 'Bloco A, Ap. 302', 'Jardim Primavera', 'Campinas', 'SP'),
 ('54321-987', 'Avenida das Acácias', 500, 'Casa 3', 'Centro', 'Goiânia', 'Go'),
 ('98765-432', 'Rua dos Girassóis', 75, 'Sala 5', 'Setor Norte', 'Brasília', 'DF'),
 ('13579-246', 'Rua das Orquídeas', 1000, 'Apt. 201', 'Vila Nova', 'Porto Alegre', 'RS'),
 ('24680-135', 'Avenida das Magnólias', 300, 'Casa 1', 'Barra da Tijuca', 'Rio de Janeiro', 'RJ');


-- Inserindo dados na tabela pessoa 

insert into pessoa (pes_tx_nome, pes_tx_cpf,  pes_tx_nascimento, pes_fk_end) values
('João da Silva', '123.456.789-10', '1990-05-15',1),
('Maria Oliveira', '987.654.321-98', '1985-08-20',2),
('Pedro Santos', '111.222.333-44', '1978-11-25',3),
('Ana Souza', '555.666.777-88', '2000-03-10',4),
('Carlos Ferreira', '999.888.777-66', '1995-12-03',5);


-- Inserindo dados na tabela carro

insert into carro (car_tx_nome, car_tx_modelo, car_tx_marca, car_tx_placa, car_int_anoFabricacao, car_fl_valor) values
('Fusca', 'Classic', 'Volkswagen', 'ABC123', 1972, 15000.00),
('Corolla', 'XEi', 'Toyota', 'DEF567', 2018, 60000.00),
('Gol', 'Power', 'Volkswagen', 'GHI901', 2015, 35000.00),
('Civic', 'Touring', 'Honda', 'JKL345', 2020, 80000.00),
('Onix', 'LT', 'Chevrolet', 'MNO780', 2017, 40000.00);



--inserindo dados na tabela concessionaria 

INSERT INTO concessionaria (conc_tx_nome, conc_tx_cnpj, conc_tx_telefone, conc_fl_valorTotal, conc_dt_dataVenda, conc_fk_pes, conc_fk_car, conc_fk_end)
VALUES 
    ('Concessionária A', '12345678901234', '987654321', 50000.00, '2023-05-10', 1, 1, 1),
    ('Concessionária B', '56789012345678', '123456789', 60000.00, '2023-06-15', 2, 2, 2),
    ('Concessionária C', '90123456781234', '456789012', 75000.00, '2023-07-20', 3, 3, 3),
    ('Concessionária D', '34567812345678', '789012345', 45000.00, '2023-08-25', 4, 4, 4),
    ('Concessionária E', '67812345678901', '012345678', 55000.00, '2023-09-30', 5, 5, 5);




-- Consulta de menor valor de velda e maior valor de venda feitos pela concessionária
SELECT 
    MIN(conc_fl_valorTotal) AS menor_valor_venda,
    MAX(conc_fl_valorTotal) AS maior_valor_venda
FROM concessionaria;
    
    
  
-- Consulta de quantidade de carros em determinada concessionaria 
SELECT 
	cs.conc_fk_car as carro_dispd,
	count(cs.conc_cd_id) as "concessionaria" 
FROM 
	concessionaria cs
where 
conc_cd_id = 1
GROUP BY 
	cs.conc_fk_car;
	


-- Consulta de nome e endereço respectivo usando join 

select p.pes_tx_nome, en.end_tx_cep, en.end_tx_rua, en.end_int_numero, en.end_tx_complemento, en.end_tx_bairro, en.end_tx_cidade, en.end_tx_estado

from endereco en

join pessoa p on en.end_cd_id = p.pes_fk_end
where p.pes_cd_id = 1
;



























