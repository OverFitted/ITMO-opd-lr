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
-- Name: admins; Type: TABLE; Schema: public; Owner: master
--

CREATE TABLE public.admins (
    id integer NOT NULL,
    username text,
    password text
);


ALTER TABLE public.admins OWNER TO master;

--
-- Name: admins_id_seq; Type: SEQUENCE; Schema: public; Owner: master
--

CREATE SEQUENCE public.admins_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admins_id_seq OWNER TO master;

--
-- Name: admins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: master
--

ALTER SEQUENCE public.admins_id_seq OWNED BY public.admins.id;


--
-- Name: profession_pvk; Type: TABLE; Schema: public; Owner: master
--

CREATE TABLE public.profession_pvk (
    profession_id integer NOT NULL,
    pvk_id integer NOT NULL
);


ALTER TABLE public.profession_pvk OWNER TO master;

--
-- Name: professions; Type: TABLE; Schema: public; Owner: master
--

CREATE TABLE public.professions (
    id integer NOT NULL,
    name text,
    pvk_list integer[]
);


ALTER TABLE public.professions OWNER TO master;

--
-- Name: professions_id_seq; Type: SEQUENCE; Schema: public; Owner: master
--

CREATE SEQUENCE public.professions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.professions_id_seq OWNER TO master;

--
-- Name: professions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: master
--

ALTER SEQUENCE public.professions_id_seq OWNED BY public.professions.id;


--
-- Name: pvk; Type: TABLE; Schema: public; Owner: master
--

CREATE TABLE public.pvk (
    id integer NOT NULL,
    name text
);


ALTER TABLE public.pvk OWNER TO master;

--
-- Name: pvk_id_seq; Type: SEQUENCE; Schema: public; Owner: master
--

CREATE SEQUENCE public.pvk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pvk_id_seq OWNER TO master;

--
-- Name: pvk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: master
--

ALTER SEQUENCE public.pvk_id_seq OWNED BY public.pvk.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: master
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name text NOT NULL,
    pvk_list integer[] NOT NULL,
    profession_id integer
);


ALTER TABLE public.users OWNER TO master;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: master
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO master;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: master
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: admins id; Type: DEFAULT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.admins ALTER COLUMN id SET DEFAULT nextval('public.admins_id_seq'::regclass);


--
-- Name: professions id; Type: DEFAULT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.professions ALTER COLUMN id SET DEFAULT nextval('public.professions_id_seq'::regclass);


--
-- Name: pvk id; Type: DEFAULT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.pvk ALTER COLUMN id SET DEFAULT nextval('public.pvk_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: admins; Type: TABLE DATA; Schema: public; Owner: master
--

COPY public.admins (id, username, password) FROM stdin;
1	graevsk	1234
2	OverFitter	Na_hue_visel_korol
3	calm_harmony	Chess
\.


--
-- Data for Name: profession_pvk; Type: TABLE DATA; Schema: public; Owner: master
--

COPY public.profession_pvk (profession_id, pvk_id) FROM stdin;
\.


--
-- Data for Name: professions; Type: TABLE DATA; Schema: public; Owner: master
--

COPY public.professions (id, name, pvk_list) FROM stdin;
\.


--
-- Data for Name: pvk; Type: TABLE DATA; Schema: public; Owner: master
--

COPY public.pvk (id, name) FROM stdin;
1	Аккуратность в работе
2	Старательность и исполнительность
3	Способность принимать решения в нестандартных ситуациях
4	Способность к воссозданию образа по словесному описанию
5	Аналитичность (способность выделять отдельные элементы действительности, способность к классификации)
6	Креативность (способность порождать необычные идеи, отклоняться от традиционных схем мышления)
7	Калькулятивность (цифровой материал)
8	Зрительная долговременная память
9	Зрительная оперативная память
10	Свойства внимания
11	Сохранение бдительности в условиях однообразной деятельности (монотонии)
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: master
--

COPY public.users (id, name, pvk_list, profession_id) FROM stdin;
\.


--
-- Name: admins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: master
--

SELECT pg_catalog.setval('public.admins_id_seq', 3, true);


--
-- Name: professions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: master
--

SELECT pg_catalog.setval('public.professions_id_seq', 7, true);


--
-- Name: pvk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: master
--

SELECT pg_catalog.setval('public.pvk_id_seq', 19, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: master
--

SELECT pg_catalog.setval('public.users_id_seq', 7, true);


--
-- Name: admins id_pkey; Type: CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT id_pkey PRIMARY KEY (id);


--
-- Name: admins password_unique; Type: CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT password_unique UNIQUE (password);


--
-- Name: profession_pvk profession_pvk_pkey; Type: CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.profession_pvk
    ADD CONSTRAINT profession_pvk_pkey PRIMARY KEY (profession_id, pvk_id);


--
-- Name: professions professions_pkey; Type: CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.professions
    ADD CONSTRAINT professions_pkey PRIMARY KEY (id);


--
-- Name: pvk pvk_pkey; Type: CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.pvk
    ADD CONSTRAINT pvk_pkey PRIMARY KEY (id);


--
-- Name: admins username_unique; Type: CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT username_unique UNIQUE (username);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: profession_pvk profession_pvk_profession_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.profession_pvk
    ADD CONSTRAINT profession_pvk_profession_id_fkey FOREIGN KEY (profession_id) REFERENCES public.professions(id);


--
-- Name: profession_pvk profession_pvk_pvk_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.profession_pvk
    ADD CONSTRAINT profession_pvk_pvk_id_fkey FOREIGN KEY (pvk_id) REFERENCES public.pvk(id);


--
-- Name: users users_profession_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_profession_id_fkey FOREIGN KEY (profession_id) REFERENCES public.professions(id);


--
-- PostgreSQL database dump complete
--

