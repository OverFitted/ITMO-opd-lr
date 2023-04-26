--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2023-04-13 17:42:15

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
\.


--
-- TOC entry 3349 (class 0 OID 17937)
-- Dependencies: 217
-- Data for Name: professions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.professions (id, name, description) FROM stdin;
\.


--
-- TOC entry 3351 (class 0 OID 17946)
-- Dependencies: 219
-- Data for Name: pvk; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pvk (id, name, description) FROM stdin;
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

SELECT pg_catalog.setval('public.experts_id_seq', 12, true);


--
-- TOC entry 3365 (class 0 OID 0)
-- Dependencies: 216
-- Name: professions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.professions_id_seq', 12, true);


--
-- TOC entry 3366 (class 0 OID 0)
-- Dependencies: 218
-- Name: pvk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pvk_id_seq', 9, true);


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


-- Completed on 2023-04-13 17:42:15

--
-- PostgreSQL database dump complete
--

