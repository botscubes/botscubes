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
        'CREATE TABLE %s%s.component_group
        (
            id BIGSERIAL NOT NULL,
            name TEXT,
            new_component_id BIGINT NOT NULL DEFAULT 1,
            PRIMARY KEY (id)
        )', prefix, _id);

    EXECUTE format(
        'CREATE TABLE %1$s%2$s.component
        (
            id bigserial NOT NULL,
            type VARCHAR(20),
            component_id BIGINT NOT NULL UNIQUE,
            next_id BIGINT,
            path text NOT NULL DEFAULT '''',
            position POINT,
            group_id BIGINT,
            PRIMARY KEY (id),
            FOREIGN KEY(group_id)
                REFERENCES %1$s%2$s.component_group(id)
                ON DELETE CASCADE
        )', prefix, _id);

    EXECUTE format(
        'CREATE TABLE %1$s%2$s.connection_point
        (
            id bigserial NOT NULL,
            source_component_id BIGINT,
            source_point_id TEXT,
            relative_position POINT,
            component_id BIGINT,
            PRIMARY KEY (id),
            FOREIGN KEY(component_id)
                REFERENCES %1$s%2$s.component(component_id)
                ON DELETE CASCADE
        )', prefix, _id);


    
--   EXECUTE format(
--        'CREATE TABLE %s%s.command
--        (
--            id bigserial NOT NULL,
--            type character varying(20) NOT NULL,
--            data text NOT NULL,
--            component_id bigint NOT NULL,
--            next_step_id bigint,
--            status integer NOT NULL,
--            PRIMARY KEY (id)
--        )', prefix, _id);
END;
$$ LANGUAGE plpgsql;
