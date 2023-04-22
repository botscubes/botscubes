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