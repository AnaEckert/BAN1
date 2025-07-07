--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2025-07-06 23:33:35

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 240 (class 1255 OID 16856)
-- Name: validar_tipo_pessoa_historico(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.validar_tipo_pessoa_historico() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    tipo_funcionario_encontrado NUMERIC;
BEGIN
    -- Verifica o tipo da pessoa associada ao idFuncionario
    SELECT tipo INTO tipo_funcionario_encontrado
    FROM Pessoa
    WHERE idPessoa = NEW.idFuncionario; -- NEW.idFuncionario refere-se ao valor que está sendo inserido/atualizado

    -- Se não encontrou o funcionário ou o tipo não é 2 (Funcionário), levanta um erro
    IF NOT FOUND OR tipo_funcionario_encontrado IS DISTINCT FROM 2 THEN
        RAISE EXCEPTION 'O idFuncionario (%) não corresponde a uma pessoa do tipo Funcionario (tipo = 2).', NEW.idFuncionario;
    END IF;

    RETURN NEW; -- Retorna a nova linha (necessário para triggers BEFORE)
END;
$$;


ALTER FUNCTION public.validar_tipo_pessoa_historico() OWNER TO postgres;

--
-- TOC entry 239 (class 1255 OID 16854)
-- Name: validar_tipo_pessoa_venda(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.validar_tipo_pessoa_venda() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    tipo_funcionario_encontrado NUMERIC;
BEGIN
    -- Verifica o tipo da pessoa associada ao idFuncionario
    SELECT tipo INTO tipo_funcionario_encontrado
    FROM Pessoa
    WHERE idPessoa = NEW.idFuncionario; -- NEW.idFuncionario refere-se ao valor que está sendo inserido/atualizado

    -- Se não encontrou o funcionário ou o tipo não é 2 (Funcionário), levanta um erro
    IF NOT FOUND OR tipo_funcionario_encontrado IS DISTINCT FROM 2 THEN
        RAISE EXCEPTION 'O idFuncionario (%) não corresponde a uma pessoa do tipo Funcionario (tipo = 2).', NEW.idFuncionario;
    END IF;

    RETURN NEW; -- Retorna a nova linha (necessário para triggers BEFORE)
END;
$$;


ALTER FUNCTION public.validar_tipo_pessoa_venda() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 228 (class 1259 OID 16778)
-- Name: autor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.autor (
    idautor integer NOT NULL,
    nome character varying(50) NOT NULL,
    idiomaprincipal character varying(20),
    nacionalidade character varying(20) NOT NULL,
    numobrasacervo numeric(3,0) NOT NULL,
    sexo character varying(10)
);


ALTER TABLE public.autor OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16777)
-- Name: autor_idautor_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.autor_idautor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.autor_idautor_seq OWNER TO postgres;

--
-- TOC entry 5015 (class 0 OID 0)
-- Dependencies: 227
-- Name: autor_idautor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.autor_idautor_seq OWNED BY public.autor.idautor;


--
-- TOC entry 236 (class 1259 OID 16821)
-- Name: autorgenero; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.autorgenero (
    idautorgenero integer NOT NULL,
    idautor integer NOT NULL,
    idgenero integer NOT NULL
);


ALTER TABLE public.autorgenero OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16820)
-- Name: autorgenero_idautorgenero_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.autorgenero_idautorgenero_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.autorgenero_idautorgenero_seq OWNER TO postgres;

--
-- TOC entry 5016 (class 0 OID 0)
-- Dependencies: 235
-- Name: autorgenero_idautorgenero_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.autorgenero_idautorgenero_seq OWNED BY public.autorgenero.idautorgenero;


--
-- TOC entry 238 (class 1259 OID 16838)
-- Name: autoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.autoria (
    idautoria integer NOT NULL,
    idproduto integer NOT NULL,
    idautor integer NOT NULL
);


ALTER TABLE public.autoria OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16837)
-- Name: autoria_idautoria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.autoria_idautoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.autoria_idautoria_seq OWNER TO postgres;

--
-- TOC entry 5017 (class 0 OID 0)
-- Dependencies: 237
-- Name: autoria_idautoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.autoria_idautoria_seq OWNED BY public.autoria.idautoria;


--
-- TOC entry 226 (class 1259 OID 16766)
-- Name: edicao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.edicao (
    idedicao integer NOT NULL,
    idproduto integer NOT NULL,
    numedicao numeric(3,0) NOT NULL,
    nomeeditora character varying(20) NOT NULL,
    localpublicacao character varying(50),
    datapublicacao date NOT NULL
);


ALTER TABLE public.edicao OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16765)
-- Name: edicao_idedicao_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.edicao_idedicao_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.edicao_idedicao_seq OWNER TO postgres;

--
-- TOC entry 5018 (class 0 OID 0)
-- Dependencies: 225
-- Name: edicao_idedicao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.edicao_idedicao_seq OWNED BY public.edicao.idedicao;


--
-- TOC entry 222 (class 1259 OID 16747)
-- Name: estante; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estante (
    idestante integer NOT NULL,
    andar numeric(1,0) NOT NULL,
    secao character varying(20) NOT NULL
);


ALTER TABLE public.estante OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16746)
-- Name: estante_idestante_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estante_idestante_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.estante_idestante_seq OWNER TO postgres;

--
-- TOC entry 5019 (class 0 OID 0)
-- Dependencies: 221
-- Name: estante_idestante_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estante_idestante_seq OWNED BY public.estante.idestante;


--
-- TOC entry 234 (class 1259 OID 16814)
-- Name: genero; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genero (
    idgenero integer NOT NULL,
    nome character varying(50) NOT NULL
);


ALTER TABLE public.genero OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16813)
-- Name: genero_idgenero_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.genero_idgenero_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.genero_idgenero_seq OWNER TO postgres;

--
-- TOC entry 5020 (class 0 OID 0)
-- Dependencies: 233
-- Name: genero_idgenero_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.genero_idgenero_seq OWNED BY public.genero.idgenero;


--
-- TOC entry 232 (class 1259 OID 16802)
-- Name: historicofuncionario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.historicofuncionario (
    idhistorico integer NOT NULL,
    idfuncionario integer NOT NULL,
    dataatualizacao date NOT NULL,
    datacontratacao date NOT NULL,
    datademissao date,
    cargo character varying(30),
    salario numeric(6,2) NOT NULL,
    status character varying(20)
);


ALTER TABLE public.historicofuncionario OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16801)
-- Name: historicofuncionario_idhistorico_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.historicofuncionario_idhistorico_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.historicofuncionario_idhistorico_seq OWNER TO postgres;

--
-- TOC entry 5021 (class 0 OID 0)
-- Dependencies: 231
-- Name: historicofuncionario_idhistorico_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.historicofuncionario_idhistorico_seq OWNED BY public.historicofuncionario.idhistorico;


--
-- TOC entry 230 (class 1259 OID 16785)
-- Name: item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item (
    iditem integer NOT NULL,
    quantidade numeric(2,0) NOT NULL,
    idproduto integer NOT NULL,
    idvenda integer NOT NULL
);


ALTER TABLE public.item OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16784)
-- Name: item_iditem_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.item_iditem_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.item_iditem_seq OWNER TO postgres;

--
-- TOC entry 5022 (class 0 OID 0)
-- Dependencies: 229
-- Name: item_iditem_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.item_iditem_seq OWNED BY public.item.iditem;


--
-- TOC entry 224 (class 1259 OID 16754)
-- Name: livro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.livro (
    idproduto integer NOT NULL,
    idestante integer NOT NULL,
    qtdestoque numeric(2,0),
    preco numeric(6,2) NOT NULL,
    nome character varying(50) NOT NULL,
    tipo character varying(20) NOT NULL,
    genero character varying(20) NOT NULL,
    estado character varying(10),
    formato character varying(20)
);


ALTER TABLE public.livro OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16753)
-- Name: livro_idproduto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.livro_idproduto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.livro_idproduto_seq OWNER TO postgres;

--
-- TOC entry 5023 (class 0 OID 0)
-- Dependencies: 223
-- Name: livro_idproduto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.livro_idproduto_seq OWNED BY public.livro.idproduto;


--
-- TOC entry 218 (class 1259 OID 16720)
-- Name: pessoa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pessoa (
    idpessoa integer NOT NULL,
    nome character varying(50) NOT NULL,
    datanascimento date NOT NULL,
    endereco character varying(50) NOT NULL,
    telefone numeric(12,0) NOT NULL,
    cpf numeric(11,0) NOT NULL,
    email character varying(50) NOT NULL,
    observacao character varying(150),
    tipo numeric(1,0) NOT NULL,
    CONSTRAINT restricao_tipo CHECK ((tipo = ANY (ARRAY[(1)::numeric, (2)::numeric])))
);


ALTER TABLE public.pessoa OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16719)
-- Name: pessoa_idpessoa_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pessoa_idpessoa_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pessoa_idpessoa_seq OWNER TO postgres;

--
-- TOC entry 5024 (class 0 OID 0)
-- Dependencies: 217
-- Name: pessoa_idpessoa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pessoa_idpessoa_seq OWNED BY public.pessoa.idpessoa;


--
-- TOC entry 220 (class 1259 OID 16730)
-- Name: venda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.venda (
    idvenda integer NOT NULL,
    datavenda date NOT NULL,
    horavenda time without time zone NOT NULL,
    parcelamento numeric(2,0),
    formapagamento character varying(20) NOT NULL,
    notafiscal character varying(200),
    idcliente integer NOT NULL,
    idfuncionario integer NOT NULL
);


ALTER TABLE public.venda OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16729)
-- Name: venda_idvenda_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.venda_idvenda_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.venda_idvenda_seq OWNER TO postgres;

--
-- TOC entry 5025 (class 0 OID 0)
-- Dependencies: 219
-- Name: venda_idvenda_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.venda_idvenda_seq OWNED BY public.venda.idvenda;


--
-- TOC entry 4799 (class 2604 OID 16781)
-- Name: autor idautor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autor ALTER COLUMN idautor SET DEFAULT nextval('public.autor_idautor_seq'::regclass);


--
-- TOC entry 4803 (class 2604 OID 16824)
-- Name: autorgenero idautorgenero; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autorgenero ALTER COLUMN idautorgenero SET DEFAULT nextval('public.autorgenero_idautorgenero_seq'::regclass);


--
-- TOC entry 4804 (class 2604 OID 16841)
-- Name: autoria idautoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autoria ALTER COLUMN idautoria SET DEFAULT nextval('public.autoria_idautoria_seq'::regclass);


--
-- TOC entry 4798 (class 2604 OID 16769)
-- Name: edicao idedicao; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edicao ALTER COLUMN idedicao SET DEFAULT nextval('public.edicao_idedicao_seq'::regclass);


--
-- TOC entry 4796 (class 2604 OID 16750)
-- Name: estante idestante; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estante ALTER COLUMN idestante SET DEFAULT nextval('public.estante_idestante_seq'::regclass);


--
-- TOC entry 4802 (class 2604 OID 16817)
-- Name: genero idgenero; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genero ALTER COLUMN idgenero SET DEFAULT nextval('public.genero_idgenero_seq'::regclass);


--
-- TOC entry 4801 (class 2604 OID 16805)
-- Name: historicofuncionario idhistorico; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historicofuncionario ALTER COLUMN idhistorico SET DEFAULT nextval('public.historicofuncionario_idhistorico_seq'::regclass);


--
-- TOC entry 4800 (class 2604 OID 16788)
-- Name: item iditem; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item ALTER COLUMN iditem SET DEFAULT nextval('public.item_iditem_seq'::regclass);


--
-- TOC entry 4797 (class 2604 OID 16757)
-- Name: livro idproduto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livro ALTER COLUMN idproduto SET DEFAULT nextval('public.livro_idproduto_seq'::regclass);


--
-- TOC entry 4794 (class 2604 OID 16723)
-- Name: pessoa idpessoa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pessoa ALTER COLUMN idpessoa SET DEFAULT nextval('public.pessoa_idpessoa_seq'::regclass);


--
-- TOC entry 4795 (class 2604 OID 16733)
-- Name: venda idvenda; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda ALTER COLUMN idvenda SET DEFAULT nextval('public.venda_idvenda_seq'::regclass);


--
-- TOC entry 4999 (class 0 OID 16778)
-- Dependencies: 228
-- Data for Name: autor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.autor (idautor, nome, idiomaprincipal, nacionalidade, numobrasacervo, sexo) FROM stdin;
1	Nicholas Sparks	Ingles	Estados Unidos	50	masculino
2	Stephen King	Ingles	Estados Unidos	60	masculino
3	Machado de Assis	Portugues	Brasil	87	masculino
4	Jose de Alencar	Portugues	Brasil	45	masculino
5	Eiichiro Oda	Japones	Japao	98	masculino
\.


--
-- TOC entry 5007 (class 0 OID 16821)
-- Dependencies: 236
-- Data for Name: autorgenero; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.autorgenero (idautorgenero, idautor, idgenero) FROM stdin;
1	1	1
2	2	3
3	3	4
4	4	4
5	5	2
\.


--
-- TOC entry 5009 (class 0 OID 16838)
-- Dependencies: 238
-- Data for Name: autoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.autoria (idautoria, idproduto, idautor) FROM stdin;
1	1	1
2	2	1
3	3	2
4	4	3
5	5	4
6	6	5
\.


--
-- TOC entry 4997 (class 0 OID 16766)
-- Dependencies: 226
-- Data for Name: edicao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.edicao (idedicao, idproduto, numedicao, nomeeditora, localpublicacao, datapublicacao) FROM stdin;
1	1	5	Sextante	Sao Paulo	2009-12-12
2	2	7	Sextante	Sao Paulo	2011-05-09
3	3	4	Suma	Rio de Janeiro	2017-11-19
4	4	97	Objetivo	Belo Horizonte	2018-04-03
5	5	90	Ciranda Cultural	Porto Alegre	2019-07-10
6	6	2	Panini	Sao Paulo	2014-06-15
\.


--
-- TOC entry 4993 (class 0 OID 16747)
-- Dependencies: 222
-- Data for Name: estante; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estante (idestante, andar, secao) FROM stdin;
1	1	Romance
2	1	Terror
3	1	Nacionais
4	2	Internacionais
\.


--
-- TOC entry 5005 (class 0 OID 16814)
-- Dependencies: 234
-- Data for Name: genero; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genero (idgenero, nome) FROM stdin;
1	Romance
2	Aventura
3	Terror
4	Literatura
\.


--
-- TOC entry 5003 (class 0 OID 16802)
-- Dependencies: 232
-- Data for Name: historicofuncionario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.historicofuncionario (idhistorico, idfuncionario, dataatualizacao, datacontratacao, datademissao, cargo, salario, status) FROM stdin;
1	5	2025-05-31	2025-05-10	\N	vendedora	1800.00	\N
2	5	2025-06-30	2025-05-10	\N	gerente	2100.00	\N
3	3	2025-05-31	2025-05-03	\N	vendedor	1600.00	\N
4	3	2025-06-30	2025-05-03	\N	vendedor	1800.00	\N
\.


--
-- TOC entry 5001 (class 0 OID 16785)
-- Dependencies: 230
-- Data for Name: item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.item (iditem, quantidade, idproduto, idvenda) FROM stdin;
1	1	2	1
2	2	5	4
3	3	4	2
4	1	1	2
5	1	3	3
\.


--
-- TOC entry 4995 (class 0 OID 16754)
-- Dependencies: 224
-- Data for Name: livro; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.livro (idproduto, idestante, qtdestoque, preco, nome, tipo, genero, estado, formato) FROM stdin;
1	1	2	15.99	O Melhor de Mim	livro	Romance	novo	brochura
2	1	1	20.00	Uma Longa Jornada	livro	Romance	usado1	brochura
3	2	4	23.99	It: A Coisa	livro	Terror	novo	colecionador
4	3	3	10.00	Dom Casmurro	livro	Classico Brasileiro	usado2	bolso
5	3	1	5.99	Senhora	livro	Classico Brasileiro	usado3	capa dura
6	4	2	35.00	One Piece 1	manga	Aventura	novo	brochura
\.


--
-- TOC entry 4989 (class 0 OID 16720)
-- Dependencies: 218
-- Data for Name: pessoa; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pessoa (idpessoa, nome, datanascimento, endereco, telefone, cpf, email, observacao, tipo) FROM stdin;
1	Ana	2004-11-08	Vila Nova	999888	123456	ana@gmail.com	\N	1
2	Caio	2005-03-16	Bom Retiro	999777	123457	caio@gmail.com	\N	1
3	Bruno	1995-03-15	Centro	987654	789012	bruno@email.com	\N	2
4	Carla	1988-07-22	Boa Vista	112233	345678	carla@gmail.com	\N	1
5	Olivia	1988-07-22	Saguacu	112233	345876	olivia@hotmail.com	\N	2
\.


--
-- TOC entry 4991 (class 0 OID 16730)
-- Dependencies: 220
-- Data for Name: venda; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.venda (idvenda, datavenda, horavenda, parcelamento, formapagamento, notafiscal, idcliente, idfuncionario) FROM stdin;
1	2025-06-29	14:00:00	\N	dinheiro	\N	1	3
2	2025-06-30	11:00:00	\N	debito	\N	2	5
3	2025-07-01	15:30:00	\N	dinheiro	\N	3	5
4	2025-07-01	09:00:00	\N	pix	\N	4	3
\.


--
-- TOC entry 5026 (class 0 OID 0)
-- Dependencies: 227
-- Name: autor_idautor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.autor_idautor_seq', 1, false);


--
-- TOC entry 5027 (class 0 OID 0)
-- Dependencies: 235
-- Name: autorgenero_idautorgenero_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.autorgenero_idautorgenero_seq', 1, false);


--
-- TOC entry 5028 (class 0 OID 0)
-- Dependencies: 237
-- Name: autoria_idautoria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.autoria_idautoria_seq', 1, false);


--
-- TOC entry 5029 (class 0 OID 0)
-- Dependencies: 225
-- Name: edicao_idedicao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.edicao_idedicao_seq', 1, false);


--
-- TOC entry 5030 (class 0 OID 0)
-- Dependencies: 221
-- Name: estante_idestante_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estante_idestante_seq', 1, false);


--
-- TOC entry 5031 (class 0 OID 0)
-- Dependencies: 233
-- Name: genero_idgenero_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genero_idgenero_seq', 1, false);


--
-- TOC entry 5032 (class 0 OID 0)
-- Dependencies: 231
-- Name: historicofuncionario_idhistorico_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.historicofuncionario_idhistorico_seq', 1, false);


--
-- TOC entry 5033 (class 0 OID 0)
-- Dependencies: 229
-- Name: item_iditem_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.item_iditem_seq', 1, false);


--
-- TOC entry 5034 (class 0 OID 0)
-- Dependencies: 223
-- Name: livro_idproduto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.livro_idproduto_seq', 1, false);


--
-- TOC entry 5035 (class 0 OID 0)
-- Dependencies: 217
-- Name: pessoa_idpessoa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pessoa_idpessoa_seq', 1, true);


--
-- TOC entry 5036 (class 0 OID 0)
-- Dependencies: 219
-- Name: venda_idvenda_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.venda_idvenda_seq', 1, false);


--
-- TOC entry 4819 (class 2606 OID 16783)
-- Name: autor autor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autor
    ADD CONSTRAINT autor_pkey PRIMARY KEY (idautor);


--
-- TOC entry 4827 (class 2606 OID 16826)
-- Name: autorgenero autorgenero_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autorgenero
    ADD CONSTRAINT autorgenero_pkey PRIMARY KEY (idautorgenero);


--
-- TOC entry 4829 (class 2606 OID 16843)
-- Name: autoria autoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autoria
    ADD CONSTRAINT autoria_pkey PRIMARY KEY (idautoria);


--
-- TOC entry 4817 (class 2606 OID 16771)
-- Name: edicao edicao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edicao
    ADD CONSTRAINT edicao_pkey PRIMARY KEY (idedicao);


--
-- TOC entry 4813 (class 2606 OID 16752)
-- Name: estante estante_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estante
    ADD CONSTRAINT estante_pkey PRIMARY KEY (idestante);


--
-- TOC entry 4825 (class 2606 OID 16819)
-- Name: genero genero_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genero
    ADD CONSTRAINT genero_pkey PRIMARY KEY (idgenero);


--
-- TOC entry 4823 (class 2606 OID 16807)
-- Name: historicofuncionario historicofuncionario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historicofuncionario
    ADD CONSTRAINT historicofuncionario_pkey PRIMARY KEY (idhistorico);


--
-- TOC entry 4821 (class 2606 OID 16790)
-- Name: item item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item
    ADD CONSTRAINT item_pkey PRIMARY KEY (iditem);


--
-- TOC entry 4815 (class 2606 OID 16759)
-- Name: livro livro_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livro
    ADD CONSTRAINT livro_pkey PRIMARY KEY (idproduto);


--
-- TOC entry 4807 (class 2606 OID 16728)
-- Name: pessoa pessoa_cpf_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pessoa
    ADD CONSTRAINT pessoa_cpf_key UNIQUE (cpf);


--
-- TOC entry 4809 (class 2606 OID 16726)
-- Name: pessoa pessoa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pessoa
    ADD CONSTRAINT pessoa_pkey PRIMARY KEY (idpessoa);


--
-- TOC entry 4811 (class 2606 OID 16735)
-- Name: venda venda_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT venda_pkey PRIMARY KEY (idvenda);


--
-- TOC entry 4842 (class 2620 OID 16857)
-- Name: historicofuncionario trg_validar_tipos_historico; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_validar_tipos_historico BEFORE INSERT OR UPDATE ON public.historicofuncionario FOR EACH ROW EXECUTE FUNCTION public.validar_tipo_pessoa_historico();


--
-- TOC entry 4841 (class 2620 OID 16855)
-- Name: venda trg_validar_tipos_venda; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_validar_tipos_venda BEFORE INSERT OR UPDATE ON public.venda FOR EACH ROW EXECUTE FUNCTION public.validar_tipo_pessoa_venda();


--
-- TOC entry 4837 (class 2606 OID 16827)
-- Name: autorgenero autorgenero_idautor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autorgenero
    ADD CONSTRAINT autorgenero_idautor_fkey FOREIGN KEY (idautor) REFERENCES public.autor(idautor);


--
-- TOC entry 4838 (class 2606 OID 16832)
-- Name: autorgenero autorgenero_idgenero_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autorgenero
    ADD CONSTRAINT autorgenero_idgenero_fkey FOREIGN KEY (idgenero) REFERENCES public.genero(idgenero);


--
-- TOC entry 4839 (class 2606 OID 16849)
-- Name: autoria autoria_idautor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autoria
    ADD CONSTRAINT autoria_idautor_fkey FOREIGN KEY (idautor) REFERENCES public.autor(idautor);


--
-- TOC entry 4840 (class 2606 OID 16844)
-- Name: autoria autoria_idproduto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autoria
    ADD CONSTRAINT autoria_idproduto_fkey FOREIGN KEY (idproduto) REFERENCES public.livro(idproduto);


--
-- TOC entry 4833 (class 2606 OID 16772)
-- Name: edicao edicao_idproduto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edicao
    ADD CONSTRAINT edicao_idproduto_fkey FOREIGN KEY (idproduto) REFERENCES public.livro(idproduto);


--
-- TOC entry 4836 (class 2606 OID 16808)
-- Name: historicofuncionario historicofuncionario_idfuncionario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historicofuncionario
    ADD CONSTRAINT historicofuncionario_idfuncionario_fkey FOREIGN KEY (idfuncionario) REFERENCES public.pessoa(idpessoa);


--
-- TOC entry 4834 (class 2606 OID 16791)
-- Name: item item_idproduto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item
    ADD CONSTRAINT item_idproduto_fkey FOREIGN KEY (idproduto) REFERENCES public.livro(idproduto);


--
-- TOC entry 4835 (class 2606 OID 16796)
-- Name: item item_idvenda_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item
    ADD CONSTRAINT item_idvenda_fkey FOREIGN KEY (idvenda) REFERENCES public.venda(idvenda);


--
-- TOC entry 4832 (class 2606 OID 16760)
-- Name: livro livro_idestante_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livro
    ADD CONSTRAINT livro_idestante_fkey FOREIGN KEY (idestante) REFERENCES public.estante(idestante);


--
-- TOC entry 4830 (class 2606 OID 16736)
-- Name: venda venda_idcliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT venda_idcliente_fkey FOREIGN KEY (idcliente) REFERENCES public.pessoa(idpessoa);


--
-- TOC entry 4831 (class 2606 OID 16741)
-- Name: venda venda_idfuncionario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT venda_idfuncionario_fkey FOREIGN KEY (idfuncionario) REFERENCES public.pessoa(idpessoa);


-- Completed on 2025-07-06 23:33:36

--
-- PostgreSQL database dump complete
--

