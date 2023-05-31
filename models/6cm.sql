--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7 (Homebrew)
-- Dumped by pg_dump version 14.7 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: schema_name; Type: SCHEMA; Schema: -; Owner: graevsky
--

CREATE SCHEMA schema_name;


ALTER SCHEMA schema_name OWNER TO graevsky;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: criteria; Type: TABLE; Schema: public; Owner: master
--

CREATE TABLE public.criteria (
    criteria_id integer NOT NULL,
    criteria_fields json
);


ALTER TABLE public.criteria OWNER TO master;

--
-- Name: criteria_criteria_id_seq; Type: SEQUENCE; Schema: public; Owner: master
--

CREATE SEQUENCE public.criteria_criteria_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.criteria_criteria_id_seq OWNER TO master;

--
-- Name: criteria_criteria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: master
--

ALTER SEQUENCE public.criteria_criteria_id_seq OWNED BY public.criteria.criteria_id;


--
-- Name: expert_profession_pvk_lab6; Type: TABLE; Schema: public; Owner: master
--

CREATE TABLE public.expert_profession_pvk_lab6 (
    respondent_profession_id integer NOT NULL,
    fields json
);


ALTER TABLE public.expert_profession_pvk_lab6 OWNER TO master;

--
-- Name: expert_profession_pvk_lab6_respondent_profession_id_seq; Type: SEQUENCE; Schema: public; Owner: master
--

CREATE SEQUENCE public.expert_profession_pvk_lab6_respondent_profession_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.expert_profession_pvk_lab6_respondent_profession_id_seq OWNER TO master;

--
-- Name: expert_profession_pvk_lab6_respondent_profession_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: master
--

ALTER SEQUENCE public.expert_profession_pvk_lab6_respondent_profession_id_seq OWNED BY public.expert_profession_pvk_lab6.respondent_profession_id;


--
-- Name: expert_profession_quality_lab1; Type: TABLE; Schema: public; Owner: graevsky
--

CREATE TABLE public.expert_profession_quality_lab1 (
    id integer NOT NULL,
    expert_id integer,
    profession_id integer,
    pvk_id integer,
    importance integer NOT NULL,
    CONSTRAINT expert_profession_quality_importance_check CHECK (((importance >= 0) AND (importance <= 5)))
);


ALTER TABLE public.expert_profession_quality_lab1 OWNER TO graevsky;

--
-- Name: expert_profession_quality_id_seq; Type: SEQUENCE; Schema: public; Owner: graevsky
--

CREATE SEQUENCE public.expert_profession_quality_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.expert_profession_quality_id_seq OWNER TO graevsky;

--
-- Name: expert_profession_quality_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: graevsky
--

ALTER SEQUENCE public.expert_profession_quality_id_seq OWNED BY public.expert_profession_quality_lab1.id;


--
-- Name: lr2_to_resp; Type: TABLE; Schema: public; Owner: master
--

CREATE TABLE public.lr2_to_resp (
    id integer NOT NULL,
    respondent_id integer,
    expert_id integer,
    result_id_lr2 integer,
    test_id integer
);


ALTER TABLE public.lr2_to_resp OWNER TO master;

--
-- Name: COLUMN lr2_to_resp.test_id; Type: COMMENT; Schema: public; Owner: master
--

COMMENT ON COLUMN public.lr2_to_resp.test_id IS 'num of the test';


--
-- Name: lr2_to_resp_id_seq; Type: SEQUENCE; Schema: public; Owner: master
--

CREATE SEQUENCE public.lr2_to_resp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lr2_to_resp_id_seq OWNER TO master;

--
-- Name: lr2_to_resp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: master
--

ALTER SEQUENCE public.lr2_to_resp_id_seq OWNED BY public.lr2_to_resp.id;


--
-- Name: lr3_to_resp; Type: TABLE; Schema: public; Owner: master
--

CREATE TABLE public.lr3_to_resp (
    id integer NOT NULL,
    respondent_id integer,
    result_list_id_lr3 integer,
    preset_id integer
);


ALTER TABLE public.lr3_to_resp OWNER TO master;

--
-- Name: lr3_to_resp_id_seq; Type: SEQUENCE; Schema: public; Owner: master
--

CREATE SEQUENCE public.lr3_to_resp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lr3_to_resp_id_seq OWNER TO master;

--
-- Name: lr3_to_resp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: master
--

ALTER SEQUENCE public.lr3_to_resp_id_seq OWNED BY public.lr3_to_resp.id;


--
-- Name: lr4_to_resp; Type: TABLE; Schema: public; Owner: master
--

CREATE TABLE public.lr4_to_resp (
    id integer NOT NULL,
    respondent_id integer,
    result_list_id_lr4 integer,
    preset_id integer
);


ALTER TABLE public.lr4_to_resp OWNER TO master;

--
-- Name: lr4_to_resp_id_seq; Type: SEQUENCE; Schema: public; Owner: master
--

CREATE SEQUENCE public.lr4_to_resp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lr4_to_resp_id_seq OWNER TO master;

--
-- Name: lr4_to_resp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: master
--

ALTER SEQUENCE public.lr4_to_resp_id_seq OWNED BY public.lr4_to_resp.id;


--
-- Name: lr5_to_resp; Type: TABLE; Schema: public; Owner: master
--

CREATE TABLE public.lr5_to_resp (
    id integer NOT NULL,
    respondent_id integer,
    result_list_id_lr5 integer,
    preset_id integer
);


ALTER TABLE public.lr5_to_resp OWNER TO master;

--
-- Name: lr5_to_resp_id_seq; Type: SEQUENCE; Schema: public; Owner: master
--

CREATE SEQUENCE public.lr5_to_resp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lr5_to_resp_id_seq OWNER TO master;

--
-- Name: lr5_to_resp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: master
--

ALTER SEQUENCE public.lr5_to_resp_id_seq OWNED BY public.lr5_to_resp.id;


--
-- Name: preset_to_resp; Type: TABLE; Schema: public; Owner: master
--

CREATE TABLE public.preset_to_resp (
    id integer NOT NULL,
    user_id integer,
    preset_id integer
);


ALTER TABLE public.preset_to_resp OWNER TO master;

--
-- Name: preset_to_resp_id_seq; Type: SEQUENCE; Schema: public; Owner: master
--

CREATE SEQUENCE public.preset_to_resp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.preset_to_resp_id_seq OWNER TO master;

--
-- Name: preset_to_resp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: master
--

ALTER SEQUENCE public.preset_to_resp_id_seq OWNED BY public.preset_to_resp.id;


--
-- Name: presets; Type: TABLE; Schema: public; Owner: master
--

CREATE TABLE public.presets (
    preset_id integer NOT NULL,
    lab_id integer NOT NULL,
    test_in_lab_id integer NOT NULL,
    params json,
    preset_name text
);


ALTER TABLE public.presets OWNER TO master;

--
-- Name: presets_preset_id_seq; Type: SEQUENCE; Schema: public; Owner: master
--

CREATE SEQUENCE public.presets_preset_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.presets_preset_id_seq OWNER TO master;

--
-- Name: presets_preset_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: master
--

ALTER SEQUENCE public.presets_preset_id_seq OWNED BY public.presets.preset_id;


--
-- Name: professions_lab1; Type: TABLE; Schema: public; Owner: graevsky
--

CREATE TABLE public.professions_lab1 (
    id integer NOT NULL,
    name text NOT NULL,
    description text
);


ALTER TABLE public.professions_lab1 OWNER TO graevsky;

--
-- Name: professions_id_seq; Type: SEQUENCE; Schema: public; Owner: graevsky
--

CREATE SEQUENCE public.professions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.professions_id_seq OWNER TO graevsky;

--
-- Name: professions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: graevsky
--

ALTER SEQUENCE public.professions_id_seq OWNED BY public.professions_lab1.id;


--
-- Name: pvk_criteria_list; Type: TABLE; Schema: public; Owner: master
--

CREATE TABLE public.pvk_criteria_list (
    list_id integer NOT NULL,
    criteria_list_for_pvk json
);


ALTER TABLE public.pvk_criteria_list OWNER TO master;

--
-- Name: pvk_criteria_list_list_id_seq; Type: SEQUENCE; Schema: public; Owner: master
--

CREATE SEQUENCE public.pvk_criteria_list_list_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pvk_criteria_list_list_id_seq OWNER TO master;

--
-- Name: pvk_criteria_list_list_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: master
--

ALTER SEQUENCE public.pvk_criteria_list_list_id_seq OWNED BY public.pvk_criteria_list.list_id;


--
-- Name: pvk_lab1; Type: TABLE; Schema: public; Owner: graevsky
--

CREATE TABLE public.pvk_lab1 (
    id integer NOT NULL,
    name text NOT NULL,
    description text
);


ALTER TABLE public.pvk_lab1 OWNER TO graevsky;

--
-- Name: pvk_id_seq; Type: SEQUENCE; Schema: public; Owner: graevsky
--

CREATE SEQUENCE public.pvk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pvk_id_seq OWNER TO graevsky;

--
-- Name: pvk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: graevsky
--

ALTER SEQUENCE public.pvk_id_seq OWNED BY public.pvk_lab1.id;


--
-- Name: results_list_lr4; Type: TABLE; Schema: public; Owner: master
--

CREATE TABLE public.results_list_lr4 (
    id integer NOT NULL,
    result_list double precision[]
);


ALTER TABLE public.results_list_lr4 OWNER TO master;

--
-- Name: result_list_lr4_id_seq; Type: SEQUENCE; Schema: public; Owner: master
--

CREATE SEQUENCE public.result_list_lr4_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.result_list_lr4_id_seq OWNER TO master;

--
-- Name: result_list_lr4_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: master
--

ALTER SEQUENCE public.result_list_lr4_id_seq OWNED BY public.results_list_lr4.id;


--
-- Name: results_list_lr2; Type: TABLE; Schema: public; Owner: master
--

CREATE TABLE public.results_list_lr2 (
    id integer NOT NULL,
    result_list double precision[]
);


ALTER TABLE public.results_list_lr2 OWNER TO master;

--
-- Name: results_list_lr2_id_seq; Type: SEQUENCE; Schema: public; Owner: master
--

CREATE SEQUENCE public.results_list_lr2_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.results_list_lr2_id_seq OWNER TO master;

--
-- Name: results_list_lr2_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: master
--

ALTER SEQUENCE public.results_list_lr2_id_seq OWNED BY public.results_list_lr2.id;


--
-- Name: results_list_lr3; Type: TABLE; Schema: public; Owner: master
--

CREATE TABLE public.results_list_lr3 (
    id integer NOT NULL,
    result_list double precision[]
);


ALTER TABLE public.results_list_lr3 OWNER TO master;

--
-- Name: results_list_lr3_id_seq; Type: SEQUENCE; Schema: public; Owner: master
--

CREATE SEQUENCE public.results_list_lr3_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.results_list_lr3_id_seq OWNER TO master;

--
-- Name: results_list_lr3_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: master
--

ALTER SEQUENCE public.results_list_lr3_id_seq OWNED BY public.results_list_lr3.id;


--
-- Name: results_list_lr5; Type: TABLE; Schema: public; Owner: master
--

CREATE TABLE public.results_list_lr5 (
    id integer NOT NULL,
    result_list double precision[]
);


ALTER TABLE public.results_list_lr5 OWNER TO master;

--
-- Name: results_list_lr5_id_seq; Type: SEQUENCE; Schema: public; Owner: master
--

CREATE SEQUENCE public.results_list_lr5_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.results_list_lr5_id_seq OWNER TO master;

--
-- Name: results_list_lr5_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: master
--

ALTER SEQUENCE public.results_list_lr5_id_seq OWNED BY public.results_list_lr5.id;


--
-- Name: test_name; Type: TABLE; Schema: public; Owner: master
--

CREATE TABLE public.test_name (
    lab_id integer NOT NULL,
    test_id integer NOT NULL,
    test_name text
);


ALTER TABLE public.test_name OWNER TO master;

--
-- Name: test_name_lr2; Type: TABLE; Schema: public; Owner: master
--

CREATE TABLE public.test_name_lr2 (
    test_id integer,
    test_name text
);


ALTER TABLE public.test_name_lr2 OWNER TO master;

--
-- Name: users; Type: TABLE; Schema: public; Owner: master
--

CREATE TABLE public.users (
    usr_id integer NOT NULL,
    name text,
    surname text,
    usrname text,
    passwd text,
    email text,
    age integer,
    is_expert boolean,
    gender character(1)
);


ALTER TABLE public.users OWNER TO master;

--
-- Name: users_usr_id_seq; Type: SEQUENCE; Schema: public; Owner: master
--

CREATE SEQUENCE public.users_usr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_usr_id_seq OWNER TO master;

--
-- Name: users_usr_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: master
--

ALTER SEQUENCE public.users_usr_id_seq OWNED BY public.users.usr_id;


--
-- Name: criteria criteria_id; Type: DEFAULT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.criteria ALTER COLUMN criteria_id SET DEFAULT nextval('public.criteria_criteria_id_seq'::regclass);


--
-- Name: expert_profession_pvk_lab6 respondent_profession_id; Type: DEFAULT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.expert_profession_pvk_lab6 ALTER COLUMN respondent_profession_id SET DEFAULT nextval('public.expert_profession_pvk_lab6_respondent_profession_id_seq'::regclass);


--
-- Name: expert_profession_quality_lab1 id; Type: DEFAULT; Schema: public; Owner: graevsky
--

ALTER TABLE ONLY public.expert_profession_quality_lab1 ALTER COLUMN id SET DEFAULT nextval('public.expert_profession_quality_id_seq'::regclass);


--
-- Name: lr2_to_resp id; Type: DEFAULT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.lr2_to_resp ALTER COLUMN id SET DEFAULT nextval('public.lr2_to_resp_id_seq'::regclass);


--
-- Name: lr3_to_resp id; Type: DEFAULT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.lr3_to_resp ALTER COLUMN id SET DEFAULT nextval('public.lr3_to_resp_id_seq'::regclass);


--
-- Name: lr4_to_resp id; Type: DEFAULT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.lr4_to_resp ALTER COLUMN id SET DEFAULT nextval('public.lr4_to_resp_id_seq'::regclass);


--
-- Name: lr5_to_resp id; Type: DEFAULT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.lr5_to_resp ALTER COLUMN id SET DEFAULT nextval('public.lr5_to_resp_id_seq'::regclass);


--
-- Name: preset_to_resp id; Type: DEFAULT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.preset_to_resp ALTER COLUMN id SET DEFAULT nextval('public.preset_to_resp_id_seq'::regclass);


--
-- Name: presets preset_id; Type: DEFAULT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.presets ALTER COLUMN preset_id SET DEFAULT nextval('public.presets_preset_id_seq'::regclass);


--
-- Name: professions_lab1 id; Type: DEFAULT; Schema: public; Owner: graevsky
--

ALTER TABLE ONLY public.professions_lab1 ALTER COLUMN id SET DEFAULT nextval('public.professions_id_seq'::regclass);


--
-- Name: pvk_criteria_list list_id; Type: DEFAULT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.pvk_criteria_list ALTER COLUMN list_id SET DEFAULT nextval('public.pvk_criteria_list_list_id_seq'::regclass);


--
-- Name: pvk_lab1 id; Type: DEFAULT; Schema: public; Owner: graevsky
--

ALTER TABLE ONLY public.pvk_lab1 ALTER COLUMN id SET DEFAULT nextval('public.pvk_id_seq'::regclass);


--
-- Name: results_list_lr2 id; Type: DEFAULT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.results_list_lr2 ALTER COLUMN id SET DEFAULT nextval('public.results_list_lr2_id_seq'::regclass);


--
-- Name: results_list_lr3 id; Type: DEFAULT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.results_list_lr3 ALTER COLUMN id SET DEFAULT nextval('public.results_list_lr3_id_seq'::regclass);


--
-- Name: results_list_lr4 id; Type: DEFAULT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.results_list_lr4 ALTER COLUMN id SET DEFAULT nextval('public.result_list_lr4_id_seq'::regclass);


--
-- Name: results_list_lr5 id; Type: DEFAULT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.results_list_lr5 ALTER COLUMN id SET DEFAULT nextval('public.results_list_lr5_id_seq'::regclass);


--
-- Name: users usr_id; Type: DEFAULT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.users ALTER COLUMN usr_id SET DEFAULT nextval('public.users_usr_id_seq'::regclass);


--
-- Data for Name: criteria; Type: TABLE DATA; Schema: public; Owner: master
--

COPY public.criteria (criteria_id, criteria_fields) FROM stdin;
\.


--
-- Data for Name: expert_profession_pvk_lab6; Type: TABLE DATA; Schema: public; Owner: master
--

COPY public.expert_profession_pvk_lab6 (respondent_profession_id, fields) FROM stdin;
\.


--
-- Data for Name: expert_profession_quality_lab1; Type: TABLE DATA; Schema: public; Owner: graevsky
--

COPY public.expert_profession_quality_lab1 (id, expert_id, profession_id, pvk_id, importance) FROM stdin;
25	1902235510	1	23	3
26	1902235510	1	24	3
27	1902235510	1	25	3
28	1902235510	1	26	3
29	1902235510	1	27	3
30	1902235510	1	28	3
31	1902235510	1	29	3
32	1902235510	1	30	3
33	1902235510	1	31	3
34	1902235510	1	32	3
35	1902235510	2	5	3
36	1902235510	2	7	3
37	1902235510	2	8	3
38	1902235510	2	11	3
39	1902235510	2	13	3
40	1902235510	2	15	3
41	1902235510	2	17	3
42	1902235510	2	19	3
43	1902235510	2	21	3
44	1902235510	2	23	3
45	1902235510	3	5	3
46	1902235510	3	6	3
47	1902235510	3	7	3
48	1902235510	3	8	3
49	1902235510	3	9	3
50	1902235510	3	10	3
51	1902235510	3	11	3
52	1902235510	3	12	3
53	1902235510	3	13	3
54	1902235510	3	71	3
\.


--
-- Data for Name: lr2_to_resp; Type: TABLE DATA; Schema: public; Owner: master
--

COPY public.lr2_to_resp (id, respondent_id, expert_id, result_id_lr2, test_id) FROM stdin;
1	1	1	6	1
2	1232473507	\N	10	1
3	1232473507	\N	11	1
4	1232473507	\N	12	2
5	1232473507	\N	13	4
6	1232473507	\N	14	5
7	1232473507	\N	15	5
8	1232473507	\N	16	3
\.


--
-- Data for Name: lr3_to_resp; Type: TABLE DATA; Schema: public; Owner: master
--

COPY public.lr3_to_resp (id, respondent_id, result_list_id_lr3, preset_id) FROM stdin;
\.


--
-- Data for Name: lr4_to_resp; Type: TABLE DATA; Schema: public; Owner: master
--

COPY public.lr4_to_resp (id, respondent_id, result_list_id_lr4, preset_id) FROM stdin;
\.


--
-- Data for Name: lr5_to_resp; Type: TABLE DATA; Schema: public; Owner: master
--

COPY public.lr5_to_resp (id, respondent_id, result_list_id_lr5, preset_id) FROM stdin;
\.


--
-- Data for Name: preset_to_resp; Type: TABLE DATA; Schema: public; Owner: master
--

COPY public.preset_to_resp (id, user_id, preset_id) FROM stdin;
\.


--
-- Data for Name: presets; Type: TABLE DATA; Schema: public; Owner: master
--

COPY public.presets (preset_id, lab_id, test_in_lab_id, params, preset_name) FROM stdin;
\.


--
-- Data for Name: professions_lab1; Type: TABLE DATA; Schema: public; Owner: graevsky
--

COPY public.professions_lab1 (id, name, description) FROM stdin;
1	Программист 1С	Программист 1С – специалист, занимающийся разработкой, настройкой и сопровождением программных решений на платформе 1С:Предприятие. Этот профессионал работает с автоматизацией учета, анализа и управления различными бизнес-процессами компаний.
2	Программист PHP	Программист PHP – специалист, ответственный за создание, разработку и поддержку веб-приложений с использованием серверного языка программирования PHP. Этот профессионал участвует во всех этапах разработки, начиная от проектирования архитектуры и заканчивая тестированием и оптимизацией кода.
3	Программист HTML	Программист HTML – специалист, занимающийся созданием и доработкой структуры веб-страниц с помощью языка разметки HTML. Он работает в тесном сотрудничестве с дизайнерами и разработчиками CSS и JavaScript, чтобы обеспечить отличный пользовательский опыт и качественное отображение контента на сайтах.
\.


--
-- Data for Name: pvk_criteria_list; Type: TABLE DATA; Schema: public; Owner: master
--

COPY public.pvk_criteria_list (list_id, criteria_list_for_pvk) FROM stdin;
\.


--
-- Data for Name: pvk_lab1; Type: TABLE DATA; Schema: public; Owner: graevsky
--

COPY public.pvk_lab1 (id, name, description) FROM stdin;
9	Адекватная самооценка	
8	Стремление к профессиональному совершенству	
71	Логичность	
5	Защита Родины	Готовность к защите Родины с оружием в руках
6	Военно-профессиональная направленность	
7	Прямые внутренние мотивы военно-профессиональной деятельности	
10	Самостоятельность	
11	Пунктуальность, педантичность	
12	Дисциплинированность	
13	Аккуратность в работе	
14	Организованность, самодисциплина	
15	Старательность, исполнительность	
16	Ответственность	
17	Трудолюбие	
18	Инициативность	
19	Самокритичность	
20	Оптимизм, доминирование положительных эмоций	
21	Самообладание, эмоциональная уравновешенность, выдержка	
22	Самоконтроль, способность к самонаблюдению	
23	Предусмотрительность	
24	Фрустрационная толерантность	Отсутствие агрессивности или депрессивности в ситуациях неудач
25	Самомобилизующийся тип реакции на препятствия	
26	Интернальность	Погруженность в себя, самодостаточность, необщительность
27	Экстернальность	Ориентация на взаимодействие с людьми, общительность
28	Интрапунитивность	Ориентация на собственные силы, уверенность в себе, чувство самоэффективности
29	Экстрапунитивность	Ориентация на помощь других людей, надежда на благоприятные обстоятельства, неуверенность в себе
30	Способность планировать свою деятельность во времени	
31	Способность организовывать свою деятельность в условиях большого потока информации	
32	Способность брать на себя ответственность за принимаемые решения и действия	
33	Способность принимать решение в нестандартных ситуациях	
34	Способность рационально действовать в экстремальных ситуациях	
35	Способность эффективно действовать в условиях дефицита времени	
36	Способность переносить неприятные ощущения	
37	Способность аргументировано отстаивать свое мнение	
38	Способность к переключениям с одной деятельности на другую	
39	Способность преодолевать страх	
40	Решительность	
41	Сильная воля	
42	Смелость	
43	Чувство долга	
44	Честность	
45	Порядочность	
46	Товарищество	
47	Зрительная оценка размеров предметов	
48	Зрительное восприятие расстояний между предметами	
49	Глазомер: линейный, угловой, объемный	
50	Глазомер динамический	Способность оценивать направление и скорость движения предмета
51	Способность к различению фигуры на малоконтрастном фоне	
52	Способность различать и опознавать замаскированные объекты	
53	Способность к восприятию пространственного соотношения предметов	
54	Точность и оценка направления на источник звука	
55	Способность узнавать и различать ритмы	
56	Речевой слух	
57	Различение отрезков времени	
58	Способность к распознаванию небольших отклонений параметров технологических процессов по визуальным признакам	
59	Способность к распознаванию небольших отклонений параметров технологических процессов по акустическим признакам	
60	Способность к распознаванию небольших отклонений параметров технологических процессов по кинестетическим признакам	
61	Способность к зрительным представлениям	
62	Способность к пространственному воображению	
63	Способность к образному представлению предметов, процессов и явлений	
64	Представление явлений	Способность наглядно представлять себе новое явление, ранее не встречающееся в опыте, или старое, но в новых условиях
65	Способность к переводу образа в словесное описание	
66	Способность к воссозданию образа по словесному описанию	
67	Функциональные свойства мышления	
68	Аналитичность	Способность выделять отдельные элементы действительности, способность к классификации
69	Синтетичность	Способность к обобщениям, установлению связей, закономерностей, формирование понятий
70	Транссонантность	Способность к актуализации и вовлечению в процесс мышления информации, хранящейся в памяти, ассоциативность мышления
72	Креативность	Способность порождать необычные идеи, отклоняться от традиционных схем мышления
73	Оперативность	Скорость мыслительных процессов, интеллектуальная лабильность
74	Предметность	Объектные свойства мышления:объекты реального мира и их признаки
75	Образность	Объектные свойства мышления:наглядные образы, схемы, планы
76	Абстрактность	Объектные свойства мышления:абстрктаные образы и понятия
77	Вербальность	Объектные свойства мышления:устная и письменная речь
78	Калькулятивность	Объектные свойства мышления:цифровой материал
79	Зрительная долговременная память на лица	
80	Зрительная долговременная память на образы предметного мира	
81	Зрительная долговременная память на условные обозначения	
82	Зрительная долговременная память на цифры, даты	
83	Зрительная долговременная память на слова и фразы	
84	Зрительная долговременная память на семантику текста	
85	Зрительная оперативная память на лица	
86	Зрительная оперативная память на образы предметного мира	
87	Зрительная оперативная память на условные обозначения	
88	Зрительная оперативная память на цифры, даты	
89	Зрительная оперативная память на слова и фразы	
90	Зрительная оперативная память на семантику текста	
91	Слуховая долговременная память на голоса	
92	Слуховая долговременная память на цифры	
93	Слуховая долговременная память на условные сигналы	
94	Слуховая долговременная память на мелодии	
95	Слуховая долговременная память на семантику сообщений	
96	Слуховая оперативная память на цифры	
97	Слуховая оперативная память на семантику сообщений	
98	Кинестетическая (моторная) память на простые движения	
99	Кинестетическая (моторная) память на сложные движения	
100	Кинестетическая (моторная) память на положение и перемещение тела в пространстве	
101	Тактильная память	
102	Обонятельная память	
103	Вкусовая память	
104	Энергичность, витальность (активность)	
105	Умственная работоспособность	
106	Физическая работоспособность (выносливость)	
107	Нервно-эмоциональная устойчивость, выносливость по отношению к эмоциональным нагрузкам	
108	Острота зрения	
109	Адаптация зрения к темноте, свету	
110	Контрастная чувствительность монохроматического зрения	
111	Цветовая дифференциальная чувствительность	
112	Устойчивость зрительной чувствительности во времени	
113	Острота слуха	
114	Контрастная чувствительность слуха	
115	Слуховая дифференциальная чувствительность	Способность различать: тембр, длительность, высоту, силу звука, ритм, фоновые или разнообразные шумы
116	Переносимость длительно действующего звукового раздражителя	
117	Чувствительность (осязание) пальцев	
118	Вибрационная чувствительность	
119	Мышечно-суставная чувствительность усилий или сопротивления	
120	Ощущение равновесия	
121	Ощущение ускорения	
122	Обонятельная чувствительность	
123	Способность узнавать и различать вкусовые ощущения	
124	Объем внимания	Количество объектов, на которые может быть направлено внимание при их одновременном восприятии
125	Концентрированность внимания	
126	Устойчивость внимания во времени	
127	Переключаемость внимания	Способность быстрого переключения внимания с одного объекта на другой или с одной деятельности на другую
128	Способность к распределению внимания между несколькими объектами или видами деятельности	
129	Помехоустойчивость внимания	
130	Способность подмечать изменения в окружающей обстановке, не сосредотачивая сознательно на них внимание	
131	Умение подмечать незначительные (малозаметные) изменения в исследуемом объекте, в показаниях приборов	
132	Способность реагировать на неожиданный зрительный сигнал посредством определённых движений	
133	Способность реагировать на неожиданный слуховой сигнал посредством определённых движений	
134	Согласованность движений с процессами восприятия (сложноорганизованная деятельность)	
135	Способность к сенсомоторному слежению за движущимся объектом	
136	Способность к выполнению мелких точных движений	
137	Способность к выполнению сложных двигательных действий (актов)	
138	Способность к выполнению плавных соразмерных движений	
139	Координация движений ведущей руки.	
140	Координация движений обеих рук.	
141	Координация движений рук и ног.	
142	Координация работы кистей рук и пальцев.	
143	Твердость руки, устойчивость кистей рук (низкий тремор)	
144	Умение быстро записывать	
145	Красивый почерк	
146	Физическая сила.	
147	Способность к быстрой выработке сенсомоторных навыков	
148	Способность к быстрой перестройке сенсомоторных навыков	
149	Пластичность и выразительность движений	
150	Отсутствие дефектов речи, хорошая дикция.	
151	Способность речевого аппарата к интенсивной и длительной работе.	
152	Способность к изменению тембра.	
153	Способность к изменению силы звучания.	
154	Переносимость динамических физических нагрузок	
155	Переносимость статических физических нагрузок	
156	Быстрый переход из состояния покоя к интенсивной работе	
157	Сохранение работоспособности при недостатке сна	
158	Сохранение работоспособности при развивающемся утомлении	
159	Сохранение бдительности в условиях однообразной деятельности (монотонии)	
160	Сохранение бдительности в режиме ожидания	
161	Сохранение работоспособности в некомфортных температурных условиях	
162	Сохранение работоспособности в условиях знакопеременных перегрузок (в том числе укачивания)	
163	Сохранение работоспособности в условиях воздействия вибрации	
164	Сохранение работоспособности в условиях воздействия разнонаправленных перегрузок	
165	Сохранение работоспособности в условиях гипо(гипер) барометрических колебаний	
166	Сохранение работоспособности в условиях пониженного парциального давления кислорода	
167	Сохранение работоспособности в условиях пониженного парциального давления углекислого газа	
168	Работоспособность с недостатком потребностей	Сохранение работоспособности в условиях ограничения возможностей удовлетворения базовых жизненных потребностей (голод, жажда, отдых, сексуальная потребность)
169	Сохранение работоспособности в разных природно-климатических условиях	
170	Способность переадаптироваться к новым средовым условиям	
171	Характеристика тела	Антропометрические характеристики (в соответствии с требованиями профессии)
172	Особенности телосложения (в соответствии с требованиями профессии)	
173	Хорошее общее физическое развитие – выносливость, координированность, сила, быстрота	
174	Физическая подготовленность к воздействию неблагоприятных факторов профессиональной деятельности.	
\.


--
-- Data for Name: results_list_lr2; Type: TABLE DATA; Schema: public; Owner: master
--

COPY public.results_list_lr2 (id, result_list) FROM stdin;
1	{500}
2	{340}
3	{650}
4	{570}
5	{520}
6	{3,400,10,300}
7	{3,560,12,210}
8	{4,670,5,670}
9	{5,340,8,900}
10	{922.8,967.11}
11	{375.8,62.37}
12	{501.43,438.16}
13	{2109.75,2499.67,769,543.77}
14	{2296.6,1230.19,0,NaN}
15	{1850.25,887.16,1883,1331.48}
16	{1145.76,740.31,979,692.26}
\.


--
-- Data for Name: results_list_lr3; Type: TABLE DATA; Schema: public; Owner: master
--

COPY public.results_list_lr3 (id, result_list) FROM stdin;
\.


--
-- Data for Name: results_list_lr4; Type: TABLE DATA; Schema: public; Owner: master
--

COPY public.results_list_lr4 (id, result_list) FROM stdin;
\.


--
-- Data for Name: results_list_lr5; Type: TABLE DATA; Schema: public; Owner: master
--

COPY public.results_list_lr5 (id, result_list) FROM stdin;
\.


--
-- Data for Name: test_name; Type: TABLE DATA; Schema: public; Owner: master
--

COPY public.test_name (lab_id, test_id, test_name) FROM stdin;
3	1	Простое движение
3	2	Сложное движение
4	1	Аналоговое слежение
4	2	Слежение с преследованием
5	1	Внимание. Устойчивость
5	2	Внимание. Переключаемость
5	3	Зрительная память
5	4	Кратковременная память
5	5	Анализ, сравнение
5	6	Дедукция, абстракция
\.


--
-- Data for Name: test_name_lr2; Type: TABLE DATA; Schema: public; Owner: master
--

COPY public.test_name_lr2 (test_id, test_name) FROM stdin;
1	Простой, свет
2	Простой, звук
3	Разные цвета
4	Сложный, звук, сложение
5	Сложный, визауально, сложение
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: master
--

COPY public.users (usr_id, name, surname, usrname, passwd, email, age, is_expert, gender) FROM stdin;
1	Boris	Kozak	Overfitter	1234	fakeMail@mail.ru	99	t	M
2	Boris	Kozar	Overfitter	1234	fakeMail0@mail.ru	99	t	F
3	Grigorii	Raevskii	graevsky	1234	fakeMail1@mail.ru	98	t	M
4	Alexander	Pevzner	CalmHarmony	1234	fakeMail2@mail.ru	97	t	M
5	TestName1	TestSurname1	testlogin1	1234	fakeMail3@mail.ru	97	f	F
6	TestName2	TestSurname2	testlogin2	1234	fakeMail4@mail.ru	96	f	M
7	TestName3	TestSurname3	testlogin3	1234	fakeMail5@mail.ru	95	f	M
8	TestName4	TestSurname4	testlogin4	1234	fakeMail6@mail.ru	94	f	F
1232473507	testuser	testuser	testuser	1234	1234@mail.ru	12	t	M
1902235510	aboba	aboba	aboba	aboba	aboba@mail.ru	12	t	M
598787172	AMD	NVIDIA	1234	1234	AS@ITMO.RU	99	t	M
\.


--
-- Name: criteria_criteria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: master
--

SELECT pg_catalog.setval('public.criteria_criteria_id_seq', 1, false);


--
-- Name: expert_profession_pvk_lab6_respondent_profession_id_seq; Type: SEQUENCE SET; Schema: public; Owner: master
--

SELECT pg_catalog.setval('public.expert_profession_pvk_lab6_respondent_profession_id_seq', 1, false);


--
-- Name: expert_profession_quality_id_seq; Type: SEQUENCE SET; Schema: public; Owner: graevsky
--

SELECT pg_catalog.setval('public.expert_profession_quality_id_seq', 54, true);


--
-- Name: lr2_to_resp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: master
--

SELECT pg_catalog.setval('public.lr2_to_resp_id_seq', 8, true);


--
-- Name: lr3_to_resp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: master
--

SELECT pg_catalog.setval('public.lr3_to_resp_id_seq', 1, false);


--
-- Name: lr4_to_resp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: master
--

SELECT pg_catalog.setval('public.lr4_to_resp_id_seq', 1, false);


--
-- Name: lr5_to_resp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: master
--

SELECT pg_catalog.setval('public.lr5_to_resp_id_seq', 1, false);


--
-- Name: preset_to_resp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: master
--

SELECT pg_catalog.setval('public.preset_to_resp_id_seq', 1, false);


--
-- Name: presets_preset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: master
--

SELECT pg_catalog.setval('public.presets_preset_id_seq', 1, false);


--
-- Name: professions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: graevsky
--

SELECT pg_catalog.setval('public.professions_id_seq', 15, true);


--
-- Name: pvk_criteria_list_list_id_seq; Type: SEQUENCE SET; Schema: public; Owner: master
--

SELECT pg_catalog.setval('public.pvk_criteria_list_list_id_seq', 1, false);


--
-- Name: pvk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: graevsky
--

SELECT pg_catalog.setval('public.pvk_id_seq', 179, true);


--
-- Name: result_list_lr4_id_seq; Type: SEQUENCE SET; Schema: public; Owner: master
--

SELECT pg_catalog.setval('public.result_list_lr4_id_seq', 1, false);


--
-- Name: results_list_lr2_id_seq; Type: SEQUENCE SET; Schema: public; Owner: master
--

SELECT pg_catalog.setval('public.results_list_lr2_id_seq', 16, true);


--
-- Name: results_list_lr3_id_seq; Type: SEQUENCE SET; Schema: public; Owner: master
--

SELECT pg_catalog.setval('public.results_list_lr3_id_seq', 1, false);


--
-- Name: results_list_lr5_id_seq; Type: SEQUENCE SET; Schema: public; Owner: master
--

SELECT pg_catalog.setval('public.results_list_lr5_id_seq', 1, false);


--
-- Name: users_usr_id_seq; Type: SEQUENCE SET; Schema: public; Owner: master
--

SELECT pg_catalog.setval('public.users_usr_id_seq', 15, true);


--
-- Name: criteria criteria_pkey; Type: CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.criteria
    ADD CONSTRAINT criteria_pkey PRIMARY KEY (criteria_id);


--
-- Name: expert_profession_pvk_lab6 expert_profession_pvk_lab6_pkey; Type: CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.expert_profession_pvk_lab6
    ADD CONSTRAINT expert_profession_pvk_lab6_pkey PRIMARY KEY (respondent_profession_id);


--
-- Name: expert_profession_quality_lab1 expert_profession_quality_pkey; Type: CONSTRAINT; Schema: public; Owner: graevsky
--

ALTER TABLE ONLY public.expert_profession_quality_lab1
    ADD CONSTRAINT expert_profession_quality_pkey PRIMARY KEY (id);


--
-- Name: lr2_to_resp lr2_to_resp_pkey; Type: CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.lr2_to_resp
    ADD CONSTRAINT lr2_to_resp_pkey PRIMARY KEY (id);


--
-- Name: lr3_to_resp lr3_to_resp_pkey; Type: CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.lr3_to_resp
    ADD CONSTRAINT lr3_to_resp_pkey PRIMARY KEY (id);


--
-- Name: lr4_to_resp lr4_to_resp_pkey; Type: CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.lr4_to_resp
    ADD CONSTRAINT lr4_to_resp_pkey PRIMARY KEY (id);


--
-- Name: lr5_to_resp lr5_to_resp_pkey; Type: CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.lr5_to_resp
    ADD CONSTRAINT lr5_to_resp_pkey PRIMARY KEY (id);


--
-- Name: test_name pk_test_and_lab_id; Type: CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.test_name
    ADD CONSTRAINT pk_test_and_lab_id PRIMARY KEY (lab_id, test_id);


--
-- Name: preset_to_resp preset_to_resp_pkey; Type: CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.preset_to_resp
    ADD CONSTRAINT preset_to_resp_pkey PRIMARY KEY (id);


--
-- Name: presets presets_pkey; Type: CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.presets
    ADD CONSTRAINT presets_pkey PRIMARY KEY (preset_id);


--
-- Name: professions_lab1 professions_pkey; Type: CONSTRAINT; Schema: public; Owner: graevsky
--

ALTER TABLE ONLY public.professions_lab1
    ADD CONSTRAINT professions_pkey PRIMARY KEY (id);


--
-- Name: pvk_criteria_list pvk_criteria_list_pkey; Type: CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.pvk_criteria_list
    ADD CONSTRAINT pvk_criteria_list_pkey PRIMARY KEY (list_id);


--
-- Name: pvk_lab1 pvk_pkey; Type: CONSTRAINT; Schema: public; Owner: graevsky
--

ALTER TABLE ONLY public.pvk_lab1
    ADD CONSTRAINT pvk_pkey PRIMARY KEY (id);


--
-- Name: results_list_lr4 result_list_lr4_pkey; Type: CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.results_list_lr4
    ADD CONSTRAINT result_list_lr4_pkey PRIMARY KEY (id);


--
-- Name: results_list_lr2 results_list_lr2_pkey; Type: CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.results_list_lr2
    ADD CONSTRAINT results_list_lr2_pkey PRIMARY KEY (id);


--
-- Name: results_list_lr3 results_list_lr3_pkey; Type: CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.results_list_lr3
    ADD CONSTRAINT results_list_lr3_pkey PRIMARY KEY (id);


--
-- Name: results_list_lr5 results_list_lr5_pkey; Type: CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.results_list_lr5
    ADD CONSTRAINT results_list_lr5_pkey PRIMARY KEY (id);


--
-- Name: presets uniq_lab_i_test; Type: CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.presets
    ADD CONSTRAINT uniq_lab_i_test UNIQUE (lab_id, test_in_lab_id);


--
-- Name: test_name_lr2 unique_id; Type: CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.test_name_lr2
    ADD CONSTRAINT unique_id UNIQUE (test_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (usr_id);


--
-- Name: fki_fk_id_to_name; Type: INDEX; Schema: public; Owner: master
--

CREATE INDEX fki_fk_id_to_name ON public.test_name_lr2 USING btree (test_id);


--
-- Name: fki_fk_lab_id; Type: INDEX; Schema: public; Owner: master
--

CREATE INDEX fki_fk_lab_id ON public.test_name USING btree (lab_id);


--
-- Name: fki_fkey_exp; Type: INDEX; Schema: public; Owner: master
--

CREATE INDEX fki_fkey_exp ON public.lr2_to_resp USING btree (expert_id);


--
-- Name: fki_fkey_expert; Type: INDEX; Schema: public; Owner: master
--

CREATE INDEX fki_fkey_expert ON public.lr2_to_resp USING btree (expert_id);


--
-- Name: fki_fkey_expert_id; Type: INDEX; Schema: public; Owner: graevsky
--

CREATE INDEX fki_fkey_expert_id ON public.expert_profession_quality_lab1 USING btree (expert_id);


--
-- Name: fki_fkey_lab_id_test_name; Type: INDEX; Schema: public; Owner: master
--

CREATE INDEX fki_fkey_lab_id_test_name ON public.presets USING btree (lab_id);


--
-- Name: fki_fkey_params_list_lr3; Type: INDEX; Schema: public; Owner: master
--

CREATE INDEX fki_fkey_params_list_lr3 ON public.lr3_to_resp USING btree (preset_id);


--
-- Name: fki_fkey_preset_id; Type: INDEX; Schema: public; Owner: master
--

CREATE INDEX fki_fkey_preset_id ON public.lr4_to_resp USING btree (preset_id);


--
-- Name: fki_fkey_resp; Type: INDEX; Schema: public; Owner: master
--

CREATE INDEX fki_fkey_resp ON public.lr2_to_resp USING btree (respondent_id);


--
-- Name: fki_fkey_result_list_lr3; Type: INDEX; Schema: public; Owner: master
--

CREATE INDEX fki_fkey_result_list_lr3 ON public.lr3_to_resp USING btree (result_list_id_lr3);


--
-- Name: fki_fkey_results; Type: INDEX; Schema: public; Owner: master
--

CREATE INDEX fki_fkey_results ON public.lr2_to_resp USING btree (result_id_lr2);


--
-- Name: fki_g; Type: INDEX; Schema: public; Owner: master
--

CREATE INDEX fki_g ON public.lr3_to_resp USING btree (respondent_id);


--
-- Name: fki_h; Type: INDEX; Schema: public; Owner: master
--

CREATE INDEX fki_h ON public.lr3_to_resp USING btree (result_list_id_lr3);


--
-- Name: fki_а; Type: INDEX; Schema: public; Owner: master
--

CREATE INDEX "fki_а" ON public.lr3_to_resp USING btree (id);


--
-- Name: expert_profession_quality_lab1 expert_profession_quality_profession_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: graevsky
--

ALTER TABLE ONLY public.expert_profession_quality_lab1
    ADD CONSTRAINT expert_profession_quality_profession_id_fkey FOREIGN KEY (profession_id) REFERENCES public.professions_lab1(id);


--
-- Name: expert_profession_quality_lab1 expert_profession_quality_pvk_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: graevsky
--

ALTER TABLE ONLY public.expert_profession_quality_lab1
    ADD CONSTRAINT expert_profession_quality_pvk_id_fkey FOREIGN KEY (pvk_id) REFERENCES public.pvk_lab1(id);


--
-- Name: lr5_to_resp fk_prest_id; Type: FK CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.lr5_to_resp
    ADD CONSTRAINT fk_prest_id FOREIGN KEY (preset_id) REFERENCES public.presets(preset_id);


--
-- Name: preset_to_resp fk_resp_id; Type: FK CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.preset_to_resp
    ADD CONSTRAINT fk_resp_id FOREIGN KEY (user_id) REFERENCES public.users(usr_id);


--
-- Name: lr5_to_resp fk_respondent_id; Type: FK CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.lr5_to_resp
    ADD CONSTRAINT fk_respondent_id FOREIGN KEY (respondent_id) REFERENCES public.users(usr_id);


--
-- Name: lr5_to_resp fk_result_list; Type: FK CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.lr5_to_resp
    ADD CONSTRAINT fk_result_list FOREIGN KEY (result_list_id_lr5) REFERENCES public.results_list_lr5(id);


--
-- Name: lr2_to_resp fk_test_id_to_name; Type: FK CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.lr2_to_resp
    ADD CONSTRAINT fk_test_id_to_name FOREIGN KEY (test_id) REFERENCES public.test_name_lr2(test_id) NOT VALID;


--
-- Name: lr2_to_resp fkey_exp; Type: FK CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.lr2_to_resp
    ADD CONSTRAINT fkey_exp FOREIGN KEY (expert_id) REFERENCES public.users(usr_id) NOT VALID;


--
-- Name: expert_profession_quality_lab1 fkey_expert_id; Type: FK CONSTRAINT; Schema: public; Owner: graevsky
--

ALTER TABLE ONLY public.expert_profession_quality_lab1
    ADD CONSTRAINT fkey_expert_id FOREIGN KEY (expert_id) REFERENCES public.users(usr_id) NOT VALID;


--
-- Name: lr4_to_resp fkey_preset_id; Type: FK CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.lr4_to_resp
    ADD CONSTRAINT fkey_preset_id FOREIGN KEY (preset_id) REFERENCES public.presets(preset_id) NOT VALID;


--
-- Name: lr3_to_resp fkey_preset_id; Type: FK CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.lr3_to_resp
    ADD CONSTRAINT fkey_preset_id FOREIGN KEY (preset_id) REFERENCES public.presets(preset_id) NOT VALID;


--
-- Name: lr2_to_resp fkey_resp; Type: FK CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.lr2_to_resp
    ADD CONSTRAINT fkey_resp FOREIGN KEY (respondent_id) REFERENCES public.users(usr_id) NOT VALID;


--
-- Name: lr3_to_resp fkey_resp; Type: FK CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.lr3_to_resp
    ADD CONSTRAINT fkey_resp FOREIGN KEY (respondent_id) REFERENCES public.users(usr_id) NOT VALID;


--
-- Name: lr3_to_resp fkey_result_list_lr3; Type: FK CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.lr3_to_resp
    ADD CONSTRAINT fkey_result_list_lr3 FOREIGN KEY (result_list_id_lr3) REFERENCES public.results_list_lr3(id) NOT VALID;


--
-- Name: lr2_to_resp fkey_results; Type: FK CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.lr2_to_resp
    ADD CONSTRAINT fkey_results FOREIGN KEY (result_id_lr2) REFERENCES public.results_list_lr2(id) NOT VALID;


--
-- Name: lr4_to_resp lr4_to_resp_respondent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.lr4_to_resp
    ADD CONSTRAINT lr4_to_resp_respondent_id_fkey FOREIGN KEY (respondent_id) REFERENCES public.users(usr_id);


--
-- Name: lr4_to_resp lr4_to_resp_result_list_id_lr4_fkey; Type: FK CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.lr4_to_resp
    ADD CONSTRAINT lr4_to_resp_result_list_id_lr4_fkey FOREIGN KEY (result_list_id_lr4) REFERENCES public.results_list_lr4(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: master
--

GRANT ALL ON SCHEMA public TO graevsky;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: SCHEMA schema_name; Type: ACL; Schema: -; Owner: graevsky
--

GRANT ALL ON SCHEMA schema_name TO PUBLIC;


--
-- PostgreSQL database dump complete
--
