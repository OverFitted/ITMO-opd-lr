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

SET default_tablespace = '';

SET default_table_access_method = heap;

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
    expert_id integer,
    result_list_id_lr3 integer,
    params_list_id_lr3 integer
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
-- Name: params_list_lr2; Type: TABLE; Schema: public; Owner: master
--

CREATE TABLE public.params_list_lr2 (
    id integer NOT NULL,
    params_list float[]
);


ALTER TABLE public.params_list_lr2 OWNER TO master;

--
-- Name: params_list_lr2_id_seq; Type: SEQUENCE; Schema: public; Owner: master
--

CREATE SEQUENCE public.params_list_lr2_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.params_list_lr2_id_seq OWNER TO master;

--
-- Name: params_list_lr2_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: master
--

ALTER SEQUENCE public.params_list_lr2_id_seq OWNED BY public.params_list_lr2.id;


--
-- Name: params_list_lr3; Type: TABLE; Schema: public; Owner: master
--

CREATE TABLE public.params_list_lr3 (
    id integer NOT NULL,
    params_list float[]
);


ALTER TABLE public.params_list_lr3 OWNER TO master;

--
-- Name: params_list_lr3_id_seq; Type: SEQUENCE; Schema: public; Owner: master
--

CREATE SEQUENCE public.params_list_lr3_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.params_list_lr3_id_seq OWNER TO master;

--
-- Name: params_list_lr3_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: master
--

ALTER SEQUENCE public.params_list_lr3_id_seq OWNED BY public.params_list_lr3.id;


--
-- Name: presets; Type: TABLE; Schema: public; Owner: master
--

CREATE TABLE public.presets (
    preset_id integer NOT NULL,
    lab_name text,
    test_in_lab_name text,
    name text,
    description text,
    avail_time_sec integer,
    show_time boolean,
    res_in_1min_and_full_test boolean,
    show_progress boolean,
    obj_acc_factor integer,
    obj_acc_time integer
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
-- Name: results_list_lr2; Type: TABLE; Schema: public; Owner: master
--

CREATE TABLE public.results_list_lr2 (
    id integer NOT NULL,
    result_list float[]
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
    result_list float[]
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
-- Name: params_list_lr2 id; Type: DEFAULT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.params_list_lr2 ALTER COLUMN id SET DEFAULT nextval('public.params_list_lr2_id_seq'::regclass);


--
-- Name: params_list_lr3 id; Type: DEFAULT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.params_list_lr3 ALTER COLUMN id SET DEFAULT nextval('public.params_list_lr3_id_seq'::regclass);


--
-- Name: presets preset_id; Type: DEFAULT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.presets ALTER COLUMN preset_id SET DEFAULT nextval('public.presets_preset_id_seq'::regclass);


--
-- Name: professions_lab1 id; Type: DEFAULT; Schema: public; Owner: graevsky
--

ALTER TABLE ONLY public.professions_lab1 ALTER COLUMN id SET DEFAULT nextval('public.professions_id_seq'::regclass);


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
-- Name: users usr_id; Type: DEFAULT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.users ALTER COLUMN usr_id SET DEFAULT nextval('public.users_usr_id_seq'::regclass);


--
-- Data for Name: expert_profession_quality_lab1; Type: TABLE DATA; Schema: public; Owner: graevsky
--

COPY public.expert_profession_quality_lab1 (id, expert_id, profession_id, pvk_id, importance) FROM stdin;
\.


--
-- Data for Name: lr2_to_resp; Type: TABLE DATA; Schema: public; Owner: master
--

COPY public.lr2_to_resp (id, respondent_id, expert_id, result_id_lr2, test_id) FROM stdin;
1	1	1	6	1
\.


--
-- Data for Name: lr3_to_resp; Type: TABLE DATA; Schema: public; Owner: master
--

COPY public.lr3_to_resp (id, respondent_id, expert_id, result_list_id_lr3, params_list_id_lr3) FROM stdin;
\.


--
-- Data for Name: params_list_lr2; Type: TABLE DATA; Schema: public; Owner: master
--

COPY public.params_list_lr2 (id, params_list) FROM stdin;
\.


--
-- Data for Name: params_list_lr3; Type: TABLE DATA; Schema: public; Owner: master
--

COPY public.params_list_lr3 (id, params_list) FROM stdin;
\.


--
-- Data for Name: presets; Type: TABLE DATA; Schema: public; Owner: master
--

COPY public.presets (preset_id, lab_name, test_in_lab_name, name, description, avail_time_sec, show_time, res_in_1min_and_full_test, show_progress, obj_acc_factor, obj_acc_time) FROM stdin;
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
\.


--
-- Data for Name: results_list_lr3; Type: TABLE DATA; Schema: public; Owner: master
--

COPY public.results_list_lr3 (id, result_list) FROM stdin;
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
\.


--
-- Name: expert_profession_quality_id_seq; Type: SEQUENCE SET; Schema: public; Owner: graevsky
--

SELECT pg_catalog.setval('public.expert_profession_quality_id_seq', 24, true);


--
-- Name: lr2_to_resp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: master
--

SELECT pg_catalog.setval('public.lr2_to_resp_id_seq', 1, true);


--
-- Name: lr3_to_resp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: master
--

SELECT pg_catalog.setval('public.lr3_to_resp_id_seq', 1, false);


--
-- Name: params_list_lr2_id_seq; Type: SEQUENCE SET; Schema: public; Owner: master
--

SELECT pg_catalog.setval('public.params_list_lr2_id_seq', 1, false);


--
-- Name: params_list_lr3_id_seq; Type: SEQUENCE SET; Schema: public; Owner: master
--

SELECT pg_catalog.setval('public.params_list_lr3_id_seq', 1, false);


--
-- Name: presets_preset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: master
--

SELECT pg_catalog.setval('public.presets_preset_id_seq', 1, false);


--
-- Name: professions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: graevsky
--

SELECT pg_catalog.setval('public.professions_id_seq', 15, true);


--
-- Name: pvk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: graevsky
--

SELECT pg_catalog.setval('public.pvk_id_seq', 179, true);


--
-- Name: results_list_lr2_id_seq; Type: SEQUENCE SET; Schema: public; Owner: master
--

SELECT pg_catalog.setval('public.results_list_lr2_id_seq', 9, true);


--
-- Name: results_list_lr3_id_seq; Type: SEQUENCE SET; Schema: public; Owner: master
--

SELECT pg_catalog.setval('public.results_list_lr3_id_seq', 1, false);


--
-- Name: users_usr_id_seq; Type: SEQUENCE SET; Schema: public; Owner: master
--

SELECT pg_catalog.setval('public.users_usr_id_seq', 15, true);


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
-- Name: params_list_lr2 params_list_lr2_pkey; Type: CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.params_list_lr2
    ADD CONSTRAINT params_list_lr2_pkey PRIMARY KEY (id);


--
-- Name: params_list_lr3 params_list_lr3_pkey; Type: CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.params_list_lr3
    ADD CONSTRAINT params_list_lr3_pkey PRIMARY KEY (id);


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
-- Name: pvk_lab1 pvk_pkey; Type: CONSTRAINT; Schema: public; Owner: graevsky
--

ALTER TABLE ONLY public.pvk_lab1
    ADD CONSTRAINT pvk_pkey PRIMARY KEY (id);


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
-- Name: fki_fkey_params_list_lr3; Type: INDEX; Schema: public; Owner: master
--

CREATE INDEX fki_fkey_params_list_lr3 ON public.lr3_to_resp USING btree (params_list_id_lr3);


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
-- Name: lr3_to_resp fkey_exp; Type: FK CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.lr3_to_resp
    ADD CONSTRAINT fkey_exp FOREIGN KEY (expert_id) REFERENCES public.users(usr_id) NOT VALID;


--
-- Name: expert_profession_quality_lab1 fkey_expert_id; Type: FK CONSTRAINT; Schema: public; Owner: graevsky
--

ALTER TABLE ONLY public.expert_profession_quality_lab1
    ADD CONSTRAINT fkey_expert_id FOREIGN KEY (expert_id) REFERENCES public.users(usr_id) NOT VALID;


--
-- Name: lr3_to_resp fkey_params_list_lr3; Type: FK CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.lr3_to_resp
    ADD CONSTRAINT fkey_params_list_lr3 FOREIGN KEY (params_list_id_lr3) REFERENCES public.params_list_lr3(id) NOT VALID;


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
-- PostgreSQL database dump complete
--

