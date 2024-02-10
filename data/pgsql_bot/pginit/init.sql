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
            name TEXT UNIQUE,
            new_component_id BIGINT NOT NULL DEFAULT 1,
            PRIMARY KEY (id)
        )', prefix, _id);

    EXECUTE format(
        'CREATE TABLE %1$s%2$s.component
        (
            id bigserial NOT NULL,
            type VARCHAR(20),
            component_id BIGINT NOT NULL UNIQUE,
            data JSONB,
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

    EXECUTE format(
        'CREATE OR REPLACE FUNCTION %1$s%2$s.set_component_id()
        RETURNS TRIGGER 
        AS
        $PROC$
        DECLARE
            g_id BIGINT;
        BEGIN
            SELECT new_component_id INTO g_id FROM %1$s%2$s.component_group WHERE id = NEW.group_id;
            
            NEW.component_id = g_id;

            g_id = g_id + 1;

            UPDATE %1$s%2$s.component_group
                SET new_component_id = g_id
                WHERE id = NEW.group_id;

            RETURN NEW;
        END;
        $PROC$
        LANGUAGE PLPGSQL', prefix, _id);

    EXECUTE format(
        'CREATE TRIGGER component_id_trigger
        BEFORE INSERT
        ON %1$s%2$s.component
        FOR EACH ROW
        EXECUTE PROCEDURE %1$s%2$s.set_component_id()',
        prefix, _id);

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
