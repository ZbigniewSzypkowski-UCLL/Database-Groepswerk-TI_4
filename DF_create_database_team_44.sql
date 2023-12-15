CREATE  TABLE r0991100.medewerker ( 
	medewerker_nummer    integer  NOT NULL,
	voornaam             varchar(100)  NOT NULL,
	achternaam           varchar(100)  NOT NULL,
	emailadres           varchar(150)  NOT NULL,
	CONSTRAINT pk_medewerker PRIMARY KEY ( medewerker_nummer )
 );

 CREATE  TABLE r0991100.rijbewijs ( 
	rijbewijs_id         integer  NOT NULL,
	type_rijbewijs       varchar(2) NOT NULL,
	CONSTRAINT pk_rijbewijs PRIMARY KEY ( rijbewijs_id )
 );

 CREATE  TABLE r0991100.vestiging ( 
	vestiging_id         integer  NOT NULL,
	locatie              varchar(200) NOT NULL,
	adres                varchar(200) NOT NULL,
	CONSTRAINT pk_vestiging PRIMARY KEY ( vestiging_id )
 );

CREATE  TABLE r0991100.voertuig ( 
	voertuig_kenteken    varchar(8)  NOT NULL,
	type_wagen           varchar(100) NOT NULL,
	CONSTRAINT pk_voertuig PRIMARY KEY ( voertuig_kenteken )
 );


CREATE  TABLE r0991100.lesgever ( 
	lesgever_id          integer  NOT NULL,
	medewerker_nummer    integer  NOT NULL,
	rijbewijs_id         integer  NOT NULL,
	CONSTRAINT pk_lesgever PRIMARY KEY ( lesgever_id ),
	CONSTRAINT fk_lesgever_medewerker FOREIGN KEY (medewerker_nummer) REFERENCES r0991100.medewerker(medewerker_nummer),
    CONSTRAINT fk_lesgever_rijbewijs FOREIGN KEY (rijbewijs_id) REFERENCES r0991100.rijbewijs(rijbewijs_id)
);

CREATE  TABLE r0991100.administrator ( 
	administrator_id     integer  NOT NULL,
	medewerker_nummer    integer  NOT NULL,
	vestiging_id         integer  NOT NULL,
	CONSTRAINT pk_administrator PRIMARY KEY ( administrator_id ),
    CONSTRAINT fk_administrator_medewerker FOREIGN KEY (medewerker_nummer) REFERENCES r0991100.medewerker(medewerker_nummer),
    CONSTRAINT fk_administrator_vestiging FOREIGN KEY (vestiging_id) REFERENCES r0991100.vestiging(vestiging_id)
);

CREATE  TABLE r0991100.lestopic ( 
	lestopic_id          integer  NOT NULL,
	topic                text NOT NULL,
	boek                 varchar(200),
	prijs                char(5) NOT NULL,
	CONSTRAINT pk_lestopic PRIMARY KEY ( lestopic_id )
 );

CREATE  TABLE r0991100.les ( 
	les_nummer           integer  NOT NULL,
	type_les             varchar(200) NOT NULL,
	datum                date NOT NULL,
	begin_tijd           time NOT NULL,
	duur                 smallint  NOT NULL,
	lesgever_id          integer  NOT NULL,
	lestopic_id          integer  NOT NULL,
	CONSTRAINT pk_les PRIMARY KEY ( les_nummer ),
    CONSTRAINT fk_les_lesgever FOREIGN KEY (lesgever_id) REFERENCES r0991100.lesgever(lesgever_id),
    CONSTRAINT fk_les_lestopic FOREIGN KEY (lestopic_id) REFERENCES r0991100.lestopic(lestopic_id)
);

CREATE  TABLE r0991100.theorieles ( 
	theorieles_id        integer  NOT NULL,
	les_nummer           integer  NOT NULL,
	les_lokaal           char(3)  NOT NULL,
	leerling_capaciteit  char(3)  NOT NULL,
	CONSTRAINT pk_theorieles PRIMARY KEY ( theorieles_id ),
	CONSTRAINT fk_theorieles_les FOREIGN KEY (les_nummer) REFERENCES r0991100.les(les_nummer)
);

CREATE  TABLE r0991100.praktijkles ( 
	praktijkles_id       integer  NOT NULL,
	les_nummer           integer  NOT NULL,
	voertuig_kenteken    varchar(8)  NOT NULL,
	CONSTRAINT pk_praktijkles PRIMARY KEY ( praktijkles_id ),
	CONSTRAINT fk_praktijkles_les FOREIGN KEY (les_nummer) REFERENCES r0991100.les(les_nummer),
    CONSTRAINT fk_praktijkles_voertuig FOREIGN KEY (voertuig_kenteken) REFERENCES r0991100.voertuig(voertuig_kenteken)
);

CREATE  TABLE r0991100.leerling ( 
	leerling_nummer      integer  NOT NULL,
	voornaam             varchar(100)  NOT NULL,
	achternaam           varchar(100)  NOT NULL,
	emailadres           varchar(150)  NOT NULL,
	gsm_nummer           char(10)   NOT NULL,
	les_type             varchar(200)  NOT NULL ,
	CONSTRAINT pk_leerling PRIMARY KEY ( leerling_nummer )
);

CREATE  TABLE r0991100.evaluatie ( 
	evaluatie_id         integer  NOT NULL,
	leerling_nummer      integer  NOT NULL,
	praktijkles_id       integer  NOT NULL,
	opmerking            text  NOT NULL,
	score                char(3)  NOT NULL,
	CONSTRAINT pk_evaluatie PRIMARY KEY ( evaluatie_id ),
	CONSTRAINT fk_evaluatie_evaluatie FOREIGN KEY (leerling_nummer) REFERENCES r0991100.leerling(leerling_nummer),
    CONSTRAINT fk_evaluatie_praktijkles FOREIGN KEY (praktijkles_id) REFERENCES r0991100.praktijkles(praktijkles_id)
);