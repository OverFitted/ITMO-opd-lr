--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2023-04-18 18:35:42

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
-- TOC entry 221 (class 1259 OID 17955)
-- Name: expert_profession_quality; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.expert_profession_quality (
    id integer NOT NULL,
    expert_id integer,
    profession_id integer,
    pvk_id integer,
    importance integer NOT NULL,
    CONSTRAINT expert_profession_quality_importance_check CHECK (((importance >= 0) AND (importance <= 5)))
);


ALTER TABLE public.expert_profession_quality OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17954)
-- Name: expert_profession_quality_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.expert_profession_quality_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.expert_profession_quality_id_seq OWNER TO postgres;

--
-- TOC entry 3359 (class 0 OID 0)
-- Dependencies: 220
-- Name: expert_profession_quality_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.expert_profession_quality_id_seq OWNED BY public.expert_profession_quality.id;


--
-- TOC entry 215 (class 1259 OID 17928)
-- Name: experts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.experts (
    id integer NOT NULL,
    username text NOT NULL,
    password text NOT NULL
);


ALTER TABLE public.experts OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 17927)
-- Name: experts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.experts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.experts_id_seq OWNER TO postgres;

--
-- TOC entry 3360 (class 0 OID 0)
-- Dependencies: 214
-- Name: experts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.experts_id_seq OWNED BY public.experts.id;


--
-- TOC entry 217 (class 1259 OID 17937)
-- Name: professions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.professions (
    id integer NOT NULL,
    name text NOT NULL,
    description text
);


ALTER TABLE public.professions OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 17936)
-- Name: professions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.professions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.professions_id_seq OWNER TO postgres;

--
-- TOC entry 3361 (class 0 OID 0)
-- Dependencies: 216
-- Name: professions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.professions_id_seq OWNED BY public.professions.id;


--
-- TOC entry 219 (class 1259 OID 17946)
-- Name: pvk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pvk (
    id integer NOT NULL,
    name text NOT NULL,
    description text
);


ALTER TABLE public.pvk OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 17945)
-- Name: pvk_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pvk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pvk_id_seq OWNER TO postgres;

--
-- TOC entry 3362 (class 0 OID 0)
-- Dependencies: 218
-- Name: pvk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pvk_id_seq OWNED BY public.pvk.id;


--
-- TOC entry 3191 (class 2604 OID 17958)
-- Name: expert_profession_quality id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expert_profession_quality ALTER COLUMN id SET DEFAULT nextval('public.expert_profession_quality_id_seq'::regclass);


--
-- TOC entry 3188 (class 2604 OID 17931)
-- Name: experts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.experts ALTER COLUMN id SET DEFAULT nextval('public.experts_id_seq'::regclass);


--
-- TOC entry 3189 (class 2604 OID 17940)
-- Name: professions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professions ALTER COLUMN id SET DEFAULT nextval('public.professions_id_seq'::regclass);


--
-- TOC entry 3190 (class 2604 OID 17949)
-- Name: pvk id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pvk ALTER COLUMN id SET DEFAULT nextval('public.pvk_id_seq'::regclass);


--
-- TOC entry 3353 (class 0 OID 17955)
-- Dependencies: 221
-- Data for Name: expert_profession_quality; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.expert_profession_quality (id, expert_id, profession_id, pvk_id, importance) FROM stdin;
\.


--
-- TOC entry 3347 (class 0 OID 17928)
-- Dependencies: 215
-- Data for Name: experts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.experts (id, username, password) FROM stdin;
1	OverFitter	123
2	CalmHarmony	456
3	graevsky	789
\.


--
-- TOC entry 3349 (class 0 OID 17937)
-- Dependencies: 217
-- Data for Name: professions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.professions (id, name, description) FROM stdin;
1	Программист 1С	Программист 1С – специалист, занимающийся разработкой, настройкой и сопровождением программных решений на платформе 1С:Предприятие. Этот профессионал работает с автоматизацией учета, анализа и управления различными бизнес-процессами компаний.
2	Программист PHP	Программист PHP – специалист, ответственный за создание, разработку и поддержку веб-приложений с использованием серверного языка программирования PHP. Этот профессионал участвует во всех этапах разработки, начиная от проектирования архитектуры и заканчивая тестированием и оптимизацией кода.
3	Программист HTML	Программист HTML – специалист, занимающийся созданием и доработкой структуры веб-страниц с помощью языка разметки HTML. Он работает в тесном сотрудничестве с дизайнерами и разработчиками CSS и JavaScript, чтобы обеспечить отличный пользовательский опыт и качественное отображение контента на сайтах.
\.


--
-- TOC entry 3351 (class 0 OID 17946)
-- Dependencies: 219
-- Data for Name: pvk; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pvk (id, name, description) FROM stdin;
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
-- TOC entry 3363 (class 0 OID 0)
-- Dependencies: 220
-- Name: expert_profession_quality_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.expert_profession_quality_id_seq', 6, true);


--
-- TOC entry 3364 (class 0 OID 0)
-- Dependencies: 214
-- Name: experts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.experts_id_seq', 15, true);


--
-- TOC entry 3365 (class 0 OID 0)
-- Dependencies: 216
-- Name: professions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.professions_id_seq', 15, true);


--
-- TOC entry 3366 (class 0 OID 0)
-- Dependencies: 218
-- Name: pvk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pvk_id_seq', 179, true);


--
-- TOC entry 3200 (class 2606 OID 17961)
-- Name: expert_profession_quality expert_profession_quality_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expert_profession_quality
    ADD CONSTRAINT expert_profession_quality_pkey PRIMARY KEY (id);


--
-- TOC entry 3194 (class 2606 OID 17935)
-- Name: experts experts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.experts
    ADD CONSTRAINT experts_pkey PRIMARY KEY (id);


--
-- TOC entry 3196 (class 2606 OID 17944)
-- Name: professions professions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professions
    ADD CONSTRAINT professions_pkey PRIMARY KEY (id);


--
-- TOC entry 3198 (class 2606 OID 17953)
-- Name: pvk pvk_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pvk
    ADD CONSTRAINT pvk_pkey PRIMARY KEY (id);


--
-- TOC entry 3201 (class 2606 OID 17962)
-- Name: expert_profession_quality expert_profession_quality_expert_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expert_profession_quality
    ADD CONSTRAINT expert_profession_quality_expert_id_fkey FOREIGN KEY (expert_id) REFERENCES public.experts(id);


--
-- TOC entry 3202 (class 2606 OID 17967)
-- Name: expert_profession_quality expert_profession_quality_profession_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expert_profession_quality
    ADD CONSTRAINT expert_profession_quality_profession_id_fkey FOREIGN KEY (profession_id) REFERENCES public.professions(id);


--
-- TOC entry 3203 (class 2606 OID 17972)
-- Name: expert_profession_quality expert_profession_quality_pvk_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expert_profession_quality
    ADD CONSTRAINT expert_profession_quality_pvk_id_fkey FOREIGN KEY (pvk_id) REFERENCES public.pvk(id);


-- Completed on 2023-04-18 18:35:42

--
-- PostgreSQL database dump complete
--

