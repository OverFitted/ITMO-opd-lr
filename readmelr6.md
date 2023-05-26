This is how lr6 structure looks:
/*create table criteria(
	criteria_id serial primary key,
	criteria_name text,
	labs_for_criteria integer[],
	criteria_weight float
);
*/
/*
create table lab_in_criteria(
	lab_for_criteria_id serial primary key,
	lab_id integer,
	test_id integer,
	selected_parameter text,
	weight float,
	growth_course boolean,
	cut_level float
);
*/
/*
create table user_pvk_profession_result (
	id serial primary key,
	respondent_id integer,
	pvk_id integer,
	profession integer,
	criteria_list integer[]
);
*/

