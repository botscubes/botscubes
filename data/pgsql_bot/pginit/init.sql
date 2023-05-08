CREATE TABLE IF NOT EXISTS public.bot
(
    id bigserial NOT NULL,
    user_id bigint,
    token character varying(50) NOT NULL,
    title character varying(50) NOT NULL,
    status integer,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.bot
    OWNER to bc_bot_user;

CREATE OR REPLACE PROCEDURE create_bot_schema (
    _id bigint
)
AS $$
DECLARE prefix text;
BEGIN
	prefix := 'bot_';
	
    EXECUTE format('CREATE SCHEMA IF NOT EXISTS %s%s', prefix, _id);
	
	EXECUTE format(
		'CREATE TABLE %s%s.user
		(
			id bigserial NOT NULL,
			tg_id bigint NOT NULL,
			first_name text,
			last_name text,
			username text,
			step_id bigint NOT NULL DEFAULT 1,
			status integer NOT NULL,
			PRIMARY KEY (id)
		)', prefix, _id);
		
	EXECUTE format(
		'CREATE TABLE %s%s.component
		(
			id bigserial NOT NULL,
			data jsonb,
			keyboard jsonb,
			next_step_id bigint,
			is_main boolean DEFAULT false,
			position point,
			status integer NOT NULL,
			PRIMARY KEY (id)
		)', prefix, _id);
	
    EXECUTE format(
		'CREATE TABLE %s%s.command
		(
			id bigserial NOT NULL,
			type character varying(20) NOT NULL,
			data text NOT NULL,
			component_id bigint NOT NULL,
			next_step_id bigint,
			status integer NOT NULL,
			PRIMARY KEY (id)
		)', prefix, _id);
END;
$$ LANGUAGE plpgsql;