--liquibase formatted sql

--changeset parshakov-as:20221015-01 failOnError:true
create table sp.game_user
(
    id          uuid                                               not null,
    creation_dt timestamp with time zone DEFAULT CURRENT_TIMESTAMP not null,
    primary key (id)
);