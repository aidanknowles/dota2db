/*								  UCD SCHOOL OF COMPUTER SCIENCE & INFORMATICS
* 	==========================================================================================================
*
* 		MODLUE:			Intro to Relational Databases & SQL Programming [COMP40725]
* 		LECTURER:		Dr Mark Scanlon
* 		ASSIGNMENT:		Final Project  (SQL File)
*		DATABASE:		Oracle Express Database 11g
*
* 		AUTHOR: 		Aidan Knowles
* 		STUDENT_NO:			
* 		DATE:			24.4.2014
*
*	
*		This file contains the Oracle SQL and PL/SQL code for the final project database. 
*		Please also see accompanying PDF and database dump for detailed schema and implementation.
*
* 	==========================================================================================================
*/


/* 1. 	CREATE TABLES 	*/


CREATE TABLE Computer (
    ComputerID number  NOT NULL,
    ComputerIP varchar2(80)  NOT NULL,
    PlayerID number  NOT NULL,
    MouseID number  NOT NULL,
    KeyboardID number  NOT NULL,
    HeadsetID number  NOT NULL,
    CONSTRAINT Computer_pk PRIMARY KEY (ComputerID),
    CONSTRAINT UniquePlayer Unique (PlayerID)
) ;

-- Table: Country
CREATE TABLE Country (
    CountryID number  NOT NULL,
    CountryName nvarchar2(120)  NOT NULL,
    CONSTRAINT Country_pk PRIMARY KEY (CountryID)
) ;



-- Table: Headset
CREATE TABLE Headset (
    HeadsetID number  NOT NULL,
    HeadsetName nvarchar2(80)  NOT NULL,
    CONSTRAINT Headset_pk PRIMARY KEY (HeadsetID)
) ;



-- Table: Hero
CREATE TABLE Hero (
    HeroID number  NOT NULL,
    HeroName varchar2(50)  NOT NULL,
    HeroType varchar2(20)  NOT NULL,
    CONSTRAINT Hero_pk PRIMARY KEY (HeroID)
) ;



-- Table: Item
CREATE TABLE Item (
    ItemID number  NOT NULL,
    ItemName varchar2(50)  NOT NULL,
    CONSTRAINT Item_pk PRIMARY KEY (ItemID)
) ;



-- Table: Keyboard
CREATE TABLE Keyboard (
    KeyboardID number  NOT NULL,
    KeyboardName nvarchar2(80)  NOT NULL,
    CONSTRAINT Keyboard_pk PRIMARY KEY (KeyboardID)
) ;



-- Table: MatchDetails
CREATE TABLE MatchDetails (
    MatchID number  NOT NULL,
    PlayerID number  NOT NULL,
    TeamID number  NOT NULL,
    Lvl number(2)  NOT NULL,
    Kills number  NOT NULL,
    Deaths number  NOT NULL,
    Assists number  NOT NULL,
    LastHits number  NOT NULL,
    Denies number  NOT NULL,
    XPM number  NOT NULL,
    GPM number  NOT NULL,
    CONSTRAINT MatchDetails_pk PRIMARY KEY (MatchID,PlayerID)
    CONSTRAINT CheckHeroLevel CHECK (Lvl <= 25);
) ;


-- Table: MatchHeroes
CREATE TABLE MatchHeroes (
    MatchID number  NOT NULL,
    PlayerID number  NOT NULL,
    HeroID number  NOT NULL,
    CONSTRAINT MatchHeroes_pk PRIMARY KEY (MatchID,PlayerID,HeroID)
) ;



-- Table: MatchInventory
CREATE TABLE MatchInventory (
    MatchID number  NOT NULL,
    PlayerID number  NOT NULL,
    ItemID number  NOT NULL,
    CONSTRAINT MatchInventory_pk PRIMARY KEY (MatchID,PlayerID,ItemID)
) ;



-- Table: MatchOverview
CREATE TABLE MatchOverview (
    MatchID number  NOT NULL,
    MatchDate date  NOT NULL,
    MatchWinnerID number  NOT NULL,
    CONSTRAINT MatchOverview_pk PRIMARY KEY (MatchID)
) ;



-- Table: MatchRoster
CREATE TABLE MatchRoster (
    MatchID number  NOT NULL,
    TeamID number  NOT NULL,
    TournID number  NOT NULL,
    CONSTRAINT MatchRoster_pk PRIMARY KEY (MatchID,TeamID)
) ;



-- Table: Mouse
CREATE TABLE Mouse (
    MouseID number  NOT NULL,
    MouseName nvarchar2(80)  NOT NULL,
    CONSTRAINT Mouse_pk PRIMARY KEY (MouseID)
) ;



-- Table: Player
CREATE TABLE Player (
    PlayerID number  NOT NULL,
    PlayerHandle nvarchar2(60)  NOT NULL,
    PlayerName nvarchar2(100)  NOT NULL,
    TeamID number  NOT NULL,
    CountryID number  NOT NULL,
    PlayerDOB date NULL,
    CONSTRAINT Player_pk PRIMARY KEY (PlayerID)
) ;



-- Table: Team
CREATE TABLE Team (
    TeamID number  NOT NULL,
    TeamName nvarchar2(80)  NOT NULL,
    CountryID number  NOT NULL,
    TeamYearFounded number(4) NOT NULL,
    CONSTRAINT Team_pk PRIMARY KEY (TeamID)
) ;



-- Table: Tournament
CREATE TABLE Tournament (
    TournID number  NOT NULL,
    TournName nvarchar2(100)  NOT NULL,
    TournStart date  NOT NULL,
    TournEnd date  NOT NULL,
    TournPrizePool number  NOT NULL,
    TournCurrency varchar2(3)  NOT NULL,
    CountryID number  NULL,
    CONSTRAINT Tournament_pk PRIMARY KEY (TournID)
) ;



-- Table: TournamentRegistration
CREATE TABLE TournamentRegistration (
    TournID number  NOT NULL,
    TeamID number  NOT NULL,
    FinishingPlace number  NULL,
    CONSTRAINT TournamentRegistration_pk PRIMARY KEY (TournID,TeamID)
) ;


--------------------------------------------------------------------------------------------------------------



/* 1b. 	ADDING FOREIGN KEY CONSTRAINTS TO TABLES	 */


-- Reference:  fk_Computer_Headset (table: Computer)


ALTER TABLE Computer ADD CONSTRAINT fk_Computer_Headset 
    FOREIGN KEY (HeadsetID)
    REFERENCES Headset (HeadsetID)
    ;

-- Reference:  fk_Computer_Keyboard (table: Computer)


ALTER TABLE Computer ADD CONSTRAINT fk_Computer_Keyboard 
    FOREIGN KEY (KeyboardID)
    REFERENCES Keyboard (KeyboardID)
    ;

-- Reference:  fk_Computer_Mouse (table: Computer)


ALTER TABLE Computer ADD CONSTRAINT fk_Computer_Mouse 
    FOREIGN KEY (MouseID)
    REFERENCES Mouse (MouseID)
    ;

-- Reference:  fk_Computer_Player (table: Computer)


ALTER TABLE Computer ADD CONSTRAINT fk_Computer_Player 
    FOREIGN KEY (PlayerID)
    REFERENCES Player (PlayerID)
    ;

-- Reference:  fk_MatchDetails_MatchRoster (table: MatchDetails)


ALTER TABLE MatchDetails ADD CONSTRAINT fk_MatchDetails_MatchRoster 
    FOREIGN KEY (MatchID,TeamID)
    REFERENCES MatchRoster (MatchID,TeamID)
    ;

-- Reference:  fk_MatchDetails_Player (table: MatchDetails)


ALTER TABLE MatchDetails ADD CONSTRAINT fk_MatchDetails_Player 
    FOREIGN KEY (PlayerID)
    REFERENCES Player (PlayerID)
    ;

-- Reference:  fk_MatchHeroes_Hero (table: MatchHeroes)


ALTER TABLE MatchHeroes ADD CONSTRAINT fk_MatchHeroes_Hero 
    FOREIGN KEY (HeroID)
    REFERENCES Hero (HeroID)
    ;

-- Reference:  fk_MatchHeroes_MatchDetails (table: MatchHeroes)


ALTER TABLE MatchHeroes ADD CONSTRAINT fk_MatchHeroes_MatchDetails 
    FOREIGN KEY (MatchID,PlayerID)
    REFERENCES MatchDetails (MatchID,PlayerID)
    ON DELETE CASCADE
    ;

-- Reference:  fk_MatchInventory_MatchDetails (table: MatchInventory)


ALTER TABLE MatchInventory ADD CONSTRAINT fk_MatchInventory_MatchDetails 
    FOREIGN KEY (MatchID,PlayerID)
    REFERENCES MatchDetails (MatchID,PlayerID)
    ON DELETE CASCADE
    ;

-- Reference:  fk_MatchInventory_Item (table: MatchInventory)


ALTER TABLE MatchInventory ADD CONSTRAINT fk_MatchInventory_Item 
    FOREIGN KEY (ItemID)
    REFERENCES Item (ItemID)
	;

-- Reference:  fk_MatchOverview_MatchTeams (table: MatchOverview)


ALTER TABLE MatchOverview ADD CONSTRAINT fk_MatchOverview_MatchTeams 
    FOREIGN KEY (MatchID,MatchWinnerID)
    REFERENCES MatchRoster (MatchID,TeamID)
    ;

-- Reference:  fk_MatchRoster_TournamentReg (table: MatchRoster)


ALTER TABLE MatchRoster ADD CONSTRAINT fk_MatchRoster_TournamentReg 
    FOREIGN KEY (TournID,TeamID)
    REFERENCES TournamentRegistration (TournID,TeamID)
    ;

-- Reference:  fk_Player_Country (table: Player)


ALTER TABLE Player ADD CONSTRAINT fk_Player_Country 
    FOREIGN KEY (CountryID)
    REFERENCES Country (CountryID)
    ;

-- Reference:  fk_Player_Team (table: Player)


ALTER TABLE Player ADD CONSTRAINT fk_Player_Team 
    FOREIGN KEY (TeamID)
    REFERENCES Team (TeamID)
    ;

-- Reference:  fk_Team_Country (table: Team)


ALTER TABLE Team ADD CONSTRAINT fk_Team_Country 
    FOREIGN KEY (CountryID)
    REFERENCES Country (CountryID)
    ;

-- Reference:  fk_TournamentReg_Team (table: TournamentRegistration)


ALTER TABLE TournamentRegistration ADD CONSTRAINT fk_TournamentReg_Team 
    FOREIGN KEY (TeamID)
    REFERENCES Team (TeamID)
    ;

-- Reference:  fk_TournamentReg_Tournament (table: TournamentRegistration)


ALTER TABLE TournamentRegistration ADD CONSTRAINT fk_TournamentReg_Tournament 
    FOREIGN KEY (TournID)
    REFERENCES Tournament (TournID)
    ;

-- Reference:  fk_Tournament_Country (table: Tournament)


ALTER TABLE Tournament ADD CONSTRAINT fk_Tournament_Country 
    FOREIGN KEY (CountryID)
    REFERENCES Country (CountryID)
    ;


--------------------------------------------------------------------------------------------------------------


/* 1c. 	AUTOINCREMENTING SEQUENCES AND TRIGGERS	 */


-- TournamentID

CREATE SEQUENCE SEQ_TournID;

CREATE OR REPLACE TRIGGER TRIG_TournID
	BEFORE INSERT ON Tournament
	FOR EACH ROW
BEGIN
	:NEW.TournID := SEQ_TournID.NEXTVAL;
END;
/

-- TeamID

CREATE SEQUENCE SEQ_TeamID;

CREATE OR REPLACE TRIGGER TRIG_TeamID
	BEFORE INSERT ON Team
	FOR EACH ROW
BEGIN
	:NEW.TeamID := SEQ_TeamID.NEXTVAL;
END;
/

-- PlayerID

CREATE SEQUENCE SEQ_PlayerID;

CREATE OR REPLACE TRIGGER TRIG_PlayerID
	BEFORE INSERT ON Player
	FOR EACH ROW
BEGIN
	:NEW.PlayerID := SEQ_PlayerID.NEXTVAL;
END;
/

-- ItemID

CREATE SEQUENCE SEQ_ItemID;

CREATE OR REPLACE TRIGGER TRIG_ItemID
	BEFORE INSERT ON Item
	FOR EACH ROW
BEGIN
	:NEW.ItemID := SEQ_ItemID.NEXTVAL;
END;
/

-- HeroID

CREATE SEQUENCE SEQ_HeroID;

CREATE OR REPLACE TRIGGER TRIG_HeroID
	BEFORE INSERT ON Hero
	FOR EACH ROW
BEGIN
	:NEW.HeroID := SEQ_HeroID.NEXTVAL;
END;
/

-- CountryID

CREATE SEQUENCE SEQ_CountryID;

CREATE OR REPLACE TRIGGER TRIG_CountryID
	BEFORE INSERT ON Country
	FOR EACH ROW
BEGIN
	:NEW.CountryID := SEQ_CountryID.NEXTVAL;
END;
/

-- ComputerID

CREATE SEQUENCE SEQ_ComputerID;

CREATE OR REPLACE TRIGGER TRIG_ComputerID
	BEFORE INSERT ON Computer
	FOR EACH ROW
BEGIN
	:NEW.ComputerID := SEQ_ComputerID.NEXTVAL;
END;
/

-- MouseID

CREATE SEQUENCE SEQ_MouseID;

CREATE OR REPLACE TRIGGER TRIG_MouseID
	BEFORE INSERT ON Mouse
	FOR EACH ROW
BEGIN
	:NEW.MouseID := SEQ_MouseID.NEXTVAL;
END;
/

-- HeadsetID

CREATE SEQUENCE SEQ_HeadsetID;

CREATE OR REPLACE TRIGGER TRIG_HeadsetID
	BEFORE INSERT ON Headset
	FOR EACH ROW
BEGIN
	:NEW.HeadsetID := SEQ_HeadsetID.NEXTVAL;
END;
/

-- KeyboardID

CREATE SEQUENCE SEQ_KeyboardID;

CREATE OR REPLACE TRIGGER TRIG_KeyboardID
	BEFORE INSERT ON Keyboard
	FOR EACH ROW
BEGIN
	:NEW.KeyboardID := SEQ_KeyboardID.NEXTVAL;
END;
/


--------------------------------------------------------------------------------------------------------------


/* 2. 	INNER JOINS (4)	 	*/



/*  
*	INNER JOIN 1 
*  	============
*
*  	Objective: 
*  	----------
*
*	Show the full names, date of birth, nationality and IP addresses of all players in the teams 'Navi' and 'DK' 
*
*/

Select 
	TeamName "TeamName", PlayerHandle "PlayerHandle", PlayerName "PlayerFullName", PlayerDOB "DateOfBirth", CountryName "Nationality", ComputerIP "IPAddress"
FROM 
	Player 
INNER JOIN 
	COUNTRY 
		ON Country.CountryID = Player.CountryID
INNER JOIN  
	TEAM 
		ON Team.TeamID = Player.TeamID
INNER JOIN
	Computer 
		ON Computer.PlayerID = Player.PlayerID
WHERE 
	Team.TeamName = 'Navi'
	OR Team.TeamName = 'DK'
ORDER BY
    Team.TeamName;


/* 
*	INNER JOIN 2
*	============
*
*	Objective: 
* 	----------
*
*	Find the names, teams and computer loadout of players using at least one piece of 'Razer' Hardware (headset/keyboard/mouse).
*
*/

Select 
	PlayerHandle "PlayerHandle", TeamName "Team", MouseName "MouseName", KeyboardName "KeyboardName", HeadsetName "HeadsetName"
FROM 
	Player
INNER JOIN 
	Computer 
		ON Computer.PlayerID = Player.PlayerID
INNER JOIN 
	Mouse 
		ON Computer.MouseID = Mouse.MouseID
INNER JOIN 
	Keyboard 
		ON Computer.KeyboardID = Keyboard.KeyboardID
INNER JOIN
	Headset 
		ON Computer.HeadsetID = Headset.HeadsetID
INNER JOIN
	Team 
		ON Player.TeamID = Team.TeamID
WHERE 
	Headset.HeadsetName LIKE 'Razer%'
	OR Keyboard.KeyboardName LIKE 'Razer%' 
	OR Mouse.MouseName LIKE 'Razer%'
ORDER BY
	Player.PlayerName;


/*	
*	INNER JOIN 3
*	============
*
*	Objective:
*	----------
*
*	List all the Chinese and USA teams that participated in tournaments in 2013. 
*   Inlcude the tournament name and the place the team finished in for each tournament.
*
*/

Select
	TeamName "TeamName", CountryName "TeamOrigin" , TournName "TournamentName", 
	FinishingPlace "PLACE", TournStart "Tournstart", TournEnd "TournEnd"
FROM 
	TournamentRegistration 
INNER JOIN 
	Team 
		ON TournamentRegistration.TeamID = Team.TeamID
INNER JOIN 
	Country 
		ON Team.CountryID = Country.CountryID
INNER JOIN
	Tournament 
		ON TournamentRegistration.TournID = Tournament.TournID
WHERE 
	EXTRACT(year from Tournament.TournStart) = 2013
    	AND Country.CountryName = 'China'
	OR 
	EXTRACT(year from Tournament.TournStart) = 2013
		AND Country.CountryName = 'United States of America'
ORDER BY
	Country.CountryName, Team.TeamName;


/*
*	INNER JOIN 4
*	============
*
*	Objective: 
*	----------
*
*	Count the players in the database according to their nationality.
*
*/

SELECT 
	CountryName "Nationality", Count(Player.CountryID) "NumPlayers" 
FROM 
	Player
INNER JOIN
	Country 
		ON Player.CountryID = Country.CountryID
GROUP BY 
	ROLLUP(CountryName)
ORDER BY 
	Count(Player.CountryID) DESC;


--------------------------------------------------------------------------------------------------------------


/* 3. 	OUTER JOINS (6) - 2 left outer joins, 2 right outer joins, 2 full outer joins	*/


/*  
*	LEFT OUTER JOIN 1
*  	=================
*
*  	Objective:
*  	---------- 
*
*	Find the match info, participants and outcome of all matches from tournaments which were hosted in the USA in Summer 2013.
*	
*/

SELECT 
	MatchRoster.MatchID "MatchID", Tournament.TournID "TournID", TournName "TournName", 
	MatchRoster.TeamID "TeamID", Team.TeamName "TeamName", MatchOverview.MatchWinnerID "MatchWinnerID"
FROM 
	MatchRoster 
LEFT OUTER JOIN 
	MatchOverview 
		ON MatchRoster.TeamID = MatchOverview.MatchWinnerID 
		AND MatchRoster.MatchID = MatchOverview.MatchID
LEFT OUTER JOIN
	Tournament	
		ON MatchRoster.TournID = Tournament.TournID
INNER JOIN
	Team 
		ON MatchRoster.TeamID = Team.TeamID
WHERE 
	Tournament.TournStart > TO_DATE('2013/06/01', 'yyyy/mm/dd') 
	AND Tournament.TournEnd < TO_DATE('2013/08/31', 'yyyy/mm/dd') 
	AND Tournament.CountryID = '1'
ORDER BY
	MatchRoster.TournID, MatchRoster.MatchID;


/*  
*	LEFT OUTER JOIN 2
*  	=================
*
*  	Objective:
*  	----------
*
*	Rank all players in MatchID 267995420 and MatchID 267885392 according to their individual number of last hits.
*	Include the experience per minute (XPM), gold per minute (GPM) and level stats for each player also, but these are not ranked.
*
*	Generally, the higher the last hits - the higher the XPM and GPM a player will have.
*	Use a left outer join to also each player's player handle, chosen hero and team info in this match.
*
*/

SELECT 
	MatchDetails.MatchID, DENSE_RANK() OVER (PARTITION BY MatchDetails.MatchID ORDER BY LastHits DESC) AS Rank, LastHits,
	Player.PlayerHandle "PlayerName", TeamName "TeamName",  XPM "XPM", GPM "GPM", HeroName "HeroPlayed", Lvl, HeroType "HeroType"
FROM 
	MatchDetails
LEFT OUTER JOIN
	Player 
		ON Player.PlayerID = MatchDetails.PlayerID
LEFT OUTER JOIN
	Team 
		ON Team.TeamID = MatchDetails.TeamID
LEFT OUTER JOIN
	MatchHeroes
		ON MatchHeroes.MatchID = MatchDetails.MatchID 
		AND MatchHeroes.PlayerID = MatchDetails.PlayerID
INNER JOIN 
	Hero 
		ON MatchHeroes.HeroID = Hero.HeroID
WHERE 
 	MatchDetails.MatchID = 267795420 
 	OR MatchDetails.MatchID = 267885392
ORDER BY 
	MatchDetails.MatchID, Rank;


/*  
*	RIGHT OUTER JOIN 1
*  	==================
*
*  	Objective: 
*  	----------
*	
*	Show all items bought by the team 'Evil Geniuses'.
*
*/

SELECT 
	MatchInventory.MatchID "MatchID", MatchInventory.PlayerID "PlayerID", PlayerHandle "PlayerHandle", MatchInventory.ItemID "ItemID", ItemName "ItemName"
FROM
	MatchInventory
RIGHT OUTER JOIN
	Item 
		ON MatchInventory.ItemID = Item.ItemID
RIGHT OUTER JOIN 
	MatchOverview 
		ON MatchOverview.MatchID = MatchInventory.MatchID
INNER JOIN
	Player 
		ON MatchInventory.PlayerID = Player.PlayerID
WHERE
	Player.TeamID = 5
ORDER BY 
	MatchInventory.MatchID, MatchInventory.PlayerID;



/*  
*	RIGHT OUTER JOIN 2
*  	==================
*
*  	Objective: 
*  	---------
*	
*	Show the age of all player's from all teams, including teams and players that do not have any player or age data.
*/

SELECT 
	PlayerHandle "PlayerName", TeamName "TeamName", TRUNC((MONTHS_BETWEEN(SYSDATE, PlayerDOB))/12) AS AGE
FROM 
	PLAYER
RIGHT OUTER JOIN
	TEAM
	ON Player.TeamID = Team.TeamID
ORDER BY AGE, TeamName;



/*  
*	FULL OUTER JOIN 1
*  	=================
*
*  	Objective:
*  	---------- 
*
*  	Show the computer info of all players, including those who have not yet registered their computer.
*  	Also list the names of all computer hardware in the database, including any hardware that has not been registered by players.
*
*/

SELECT 
	Player.PlayerID "PlayerID", PlayerHandle "PlayerHandle", ComputerID "ComputerID", ComputerIP "ComputerIP", 
	MouseName "MouseName", KeyboardName "KeyboardName", HeadsetName "HeadsetName"
FROM 
	Player
FULL OUTER JOIN 
	Computer 
		ON Player.PlayerID = Computer.PlayerID
FULL OUTER JOIN 
	Mouse 
		ON Computer.MouseID = Mouse.MouseID
FULL OUTER JOIN 
	Keyboard 
		ON Computer.KeyboardID = Keyboard.KeyboardID
FULL OUTER JOIN 
	Headset 
		ON Computer.HeadsetID = Headset.HeadsetID
ORDER BY 
	ComputerID, Player.PlayerID;


/*  
*	FULL OUTER JOIN 2
*  	=================
*
*  	Objective: 
*  	----------
*
*  	List the top three winning teams of all tournaments of the past 3 years, fully joined with their team info.
*
*/

SELECT 
	TournName "Tournament", EXTRACT(year from Tournament.TournStart) AS "TournYear", FinishingPlace "Place", 
	TeamName "Team", CountryName "TeamCountry", TeamYearFounded "TeamFounded", TournamentRegistration.TeamID "TeamID"
FROM 
	TournamentRegistration
FULL OUTER JOIN 
	Team 
		ON TournamentRegistration.TeamID = Team.TeamID
INNER JOIN 
	Country
		ON Team.CountryID = Country.CountryID
INNER JOIN 
	Tournament
		ON TournamentRegistration.TournID = Tournament.TournID
WHERE 
	FinishingPlace <= 3
	AND Tournament.TournStart > (SYSDATE - 1095)
ORDER BY 
	TournName, FinishingPlace;


--------------------------------------------------------------------------------------------------------------


/* 4. 	CUBE QUERY (1) 		*/


/* 
*	CUBE QUERY 1
*	============
*
*	Objective:
*	----------
*
*	Get the aggregate total number of sums, deaths, assists, last hits and denies for all teams and players from matches in the tournament 'The International 2013'.
*
*/

SELECT 
	MatchDetails.MatchID "MatchID", PlayerHandle "PlayerHandle", TeamName "TeamName", 
	Sum(Kills)"Kills", Sum(Deaths) "Deaths", Sum(Assists) "Assists", Sum(LastHits) "LastHits", Sum(Denies) "Denies"
FROM
	MatchDetails
LEFT OUTER JOIN 
	MatchRoster ON MatchRoster.MatchID = MatchDetails.MatchID
INNER JOIN
	Player ON Player.PlayerID = MatchDetails.PlayerID
INNER JOIN
	Team ON MatchDetails.TeamID = Team.TeamID
LEFT OUTER JOIN
	Tournament ON MatchRoster.TournID = Tournament.TournID
WHERE 
	Tournament.TournName = 'The International 2013'
GROUP BY 
	CUBE(MatchDetails.MatchID, PlayerHandle), TeamName
ORDER BY 
	MatchDetails.MatchID, TeamName, PlayerHandle;


--------------------------------------------------------------------------------------------------------------


/* 5. 	SUB QUERIES (5) 	*/


/* 
*   SUBQUERY 1
*   ==========
*
*  	Objective:
*   ----------
*
*  	List top 20 most popular items used across all matches.
*
*/

SELECT 
	*
FROM 
	(SELECT  
		ItemName "ItemName", Count(MatchInventory.ItemID) "Occurences" 
	FROM 
		MatchInventory
	INNER JOIN
		Item 
			ON MatchInventory.ItemID = Item.ItemID 
	GROUP BY 
		ItemName
	ORDER BY 
		Count(MatchInventory.ItemID) DESC)
WHERE 
	ROWNUM <= 20; 


/* 	
*	SUBQUERY 2
*	==========
*
*	Objective: 
* 	----------
*
* 	List top 10 most popular heroes used across all matches.
* 
 */

SELECT 
	*
FROM 
	(SELECT  
		HeroName "HeroName", HeroType "HeroType", Count(MatchHeroes.HeroID) "TimesPlayed"
	FROM 
		MatchHeroes
	INNER JOIN
		Hero 
			ON MatchHeroes.HeroID = Hero.HeroID 
	GROUP BY 
		HeroName, HeroType
	ORDER BY 
		Count(MatchHeroes.HeroID) DESC)
WHERE 
	ROWNUM <= 10; 


/* 	
*	SUBQUERY 3
*	==========
*
*	Objective: 
* 	----------
*
*	Find the tournament info and winning team for the tournament with the biggest USD prize pool.
* 
 */

SELECT 
	TournName "TournamentName", TournStart "TournStartDate", TournEnd "TournEndDate", 
	'$' || TournPrizePool "TournPrizePool", TeamName "WinningTeam", CountryName "TeamCountry", 
	TeamYearFounded "TeamYearFounded"
FROM
	TournamentRegistration
INNER JOIN 
	Tournament 
		ON TournamentRegistration.TournID = Tournament.TournID
INNER JOIN
	Team 
		ON TournamentRegistration.TeamID = Team.TeamID
INNER JOIN
	Country 
		ON Team.CountryID = Country.CountryID
WHERE
	TournamentRegistration.TournID = 
		(SELECT 
			TournID 
		 FROM 
		 	Tournament 
		 WHERE 
		 	TournPrizePool = (SELECT MAX(TournPrizePool) FROM Tournament WHERE Tournament.TournCurrency = 'USD')
		)
	AND TournamentRegistration.FinishingPlace = 1;


/* 	
*	SUBQUERY 4
*	==========
*
* 	Objective:
* 	----------
*
*	Show the player and match statistics for the player with the most number of kills from a single match in the database.
*
*/

SELECT
	*
FROM 
(
	SELECT 
		MatchDetails.MatchID "MatchID", MatchDate "MatchDate", PlayerHandle "PlayerHandle", CountryName "Nationality", TeamName "Team", HeroName "Hero", 
		Lvl "Level", Kills "Kills", Deaths "Deaths", Assists "Assists", LastHits "LastHits", Denies "Denies", XPM, GPM
	FROM 
		MatchDetails
	INNER JOIN
		MatchOverview 
			ON MatchDetails.MatchID = MatchOverview.MatchID
	RIGHT OUTER JOIN
		MatchHeroes 
			ON MatchHeroes.PlayerID = MatchDetails.PlayerID
	INNER JOIN
		Hero 
			ON MatchHeroes.HeroID = Hero.HeroID
	INNER JOIN
		Team
			ON Team.TeamID = MatchDetails.TeamID
	INNER JOIN
		Player 
			ON MatchDetails.PlayerID = Player.PlayerID
	INNER JOIN 
		Country 
			ON Country.CountryID = Player.CountryID
	WHERE 
		Kills = (SELECT MAX(Kills) FROM MatchDetails)
) 
WHERE ROWNUM = 1;


/* 	
*	SUBQUERY 5
*	==========
*
* 	Objective: 
* 	----------
* 	
*	Show the match statistics of all players that obtained a level above the median level and are part of a Chinese team.
*
*/

SELECT 
	MatchDetails.MatchID "MatchID", PlayerHandle "PlayerHandle", TeamName "Team",
	Lvl "Level", Kills "Kills", Deaths "Deaths", Assists "Assists", LastHits "LastHits", Denies "Denies", XPM, GPM
FROM 
	MatchDetails
INNER JOIN
	Team
		ON Team.TeamID = MatchDetails.TeamID
INNER JOIN
	Player 
		ON MatchDetails.PlayerID = Player.PlayerID
WHERE 
	Lvl > (SELECT MEDIAN(Lvl) FROM MatchDetails)
	AND Team.CountryID = 2
ORDER BY
	MatchDetails.MatchID;


--------------------------------------------------------------------------------------------------------------


/* 6. 	PL/SQL PROCEDURES (5) - in single package	 */



-- Package specification
CREATE OR REPLACE PACKAGE DOTA AS 
	PROCEDURE MatchStats(mID IN NUMBER);
	PROCEDURE PlayerStats(pID IN NUMBER);
	PROCEDURE TeamStats(tID IN NUMBER);
	PROCEDURE MatchItems(mID IN NUMBER);
	PROCEDURE InsertPlayer(pHandle IN nvarchar2, pName IN nvarchar2, tID IN number, cID IN number);
END DOTA;
/

-- Package body
CREATE OR REPLACE PACKAGE BODY DOTA AS

	/* 
	*	This is a private helper procedure for 'MatchStats' procedure.
	*	It is called by the MatchStats procedure when printing the information about the match heroes.
	*/
	PROCEDURE ListMatchHeroes(mID IN NUMBER)
	IS
		-- Hero name variable
		hName nvarchar2(50);
		-- Player name variable
		PName nvarchar2(50);
		-- Cursor to get player ID and Hero ID from MatchHeroes table
		CURSOR HeroesPlayed_CURSOR IS SELECT HeroID, PlayerID FROM MatchHeroes WHERE MatchID = mID;
		-- Variable to store fetched row from cursor
		HeroRow HeroesPlayed_CURSOR%ROWTYPE;
	BEGIN 
		-- Open cursor
		OPEN HeroesPlayed_CURSOR;
		-- Fetch cursor, store in "Hero Row"
		FETCH HeroesPlayed_CURSOR INTO HeroRow;
		-- Check if more data can be found by cursor
		IF (HeroesPlayed_CURSOR%NOTFOUND) THEN
			RAISE NO_DATA_FOUND;
		END IF;
		-- Fetch data from cursor while it is found
		<<CURSOR_FETCHING_LOOP>>
		WHILE (HeroesPlayed_CURSOR%FOUND) LOOP
			-- Get hero name for cur Hero ID, store in hName
			SELECT HeroName INTO hName FROM Hero WHERE HeroID = HeroRow.HeroID;
			-- Get player name for cur Player ID, store in pName
			SELECT PlayerHandle INTO pName FROM Player WHERE PlayerID = HeroRow.PlayerID;
			-- Print hero and player name
			DBMS_OUTPUT.PUT_LINE('|  Hero: ' || hName || '     (Played by: ' || pName || ')');
			-- Fetch a new row from cursor, store in 'Hero Row'
			FETCH HeroesPlayed_CURSOR INTO HeroRow;
		END LOOP CURSOR_FETCHING_LOOP;
		-- Close cursor
		Close HeroesPlayed_CURSOR;
	EXCEPTION
		-- Catch when no data is found
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('ERROR: No data found for Match ID ' || mID);
		-- Default catch-all when some other exception occurs
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE('An error occured.');
	END ListMatchHeroes;


	/* 
	*	This is a private helper function for 'PlayerStats' procedure.
	*	Returns the most played hero (HeroID) of a given player.
	*/
	FUNCTION MostPlayedHero(pID IN NUMBER)
	RETURN NUMBER
	IS
		-- Cursor get player's most played hero, first row in the cursor will be the most played hero (most match counts)
		CURSOR HeroPlayed_CURSOR IS SELECT HeroID, COUNT(HeroID) FROM MatchHEroes WHERE PlayerID = pID GROUP BY HeroID ORDER BY Count(HeroID) DESC;
		-- Var to store the row fetched by 'HeroPlayed_CURSOR'
		HeroPlayedRow HeroPlayed_CURSOR%ROWTYPE;
	BEGIN
		-- Open cursor
		OPEN HeroPlayed_CURSOR;
		-- Fetch first row in cursor, store in 'HeroPlayedRow'
		FETCH HeroPlayed_CURSOR INTO HeroPlayedRow;
		-- Close cursor as we only need the first row
		CLOSE HeroPlayed_CURSOR;

		-- Returns the ID of the player's most frequently played hero
		RETURN HeroPlayedRow.HeroID;
	END MostPlayedHero;


	/* 
	*	This is a private helper function for 'TeamStats' procedure.
	*	Returns the average age of a team's players.
	*/
	FUNCTION AvgAgeTeam(tID IN NUMBER)
	RETURN NUMBER 
	IS
		-- Variable to store num players in team
		playerCount number;
		-- Variable to store total of ages on team
		ageTotal number := 0;
		-- Variable to temporarily store a player's age
		playerAge number;
		-- Variable to store the average age on the team, will be returned
		ageAverage number;
		-- Cursor to get Player's date of birth
		CURSOR teamP_CURSOR IS SELECT PlayerDOB FROM Player WHERE TeamID = tID;
		-- Variable to store each row fetched by cursor
		playersRow teamP_CURSOR%ROWTYPE;
	BEGIN
		-- Get number of players on team, store in 'playerCount'
		SELECT Count(TeamID) INTO playerCount FROM Player WHERE TeamID = tID; 
		-- Open cursor
		OPEN teamP_CURSOR;
		-- Fetch row from cursor, store in 'playersRow'
		FETCH teamP_CURSOR INTO playersRow;
		-- Loop to keep fetching rows from cursor while there are rows to be fetched
		<<CURSOR_FETCHING_LOOP>>
		WHILE (teamP_CURSOR%FOUND) LOOP
			-- Calculate the player age based on their date of birth, store in 'playerAge'
			playerAge := TRUNC((MONTHS_BETWEEN(SYSDATE, playersRow.PlayerDOB))/12);
			-- Age player age to the total of all ages
			ageTotal := ageTotal + playerAge;
			-- Fetch a new row, store in 'playersRow'
			FETCH teamP_CURSOR INTO playersRow;
		END LOOP CURSOR_FETCHING_LOOP;
		-- Close Cursor
		CLOSE teamP_CURSOR;
		-- Calculate the team-wide average for age
		ageAverage := ageTotal / playerCount;
		-- Return the average
		RETURN ageAverage;
	END AvgAgeTeam;


	/* 
	*	PROCEDURE 1
	*	===========
	*
	*	Objective:
	*	----------
	*
	*	Calculate + print all the info/statistics about a given match (eg date, tournament, winner, num team kills etc) using DBMS_OUTPUT.
	*	Raises and catches NO_DATA_FOUND exception if there is no data for the specified Match ID.
	*
	*/

	PROCEDURE MatchStats(mID IN NUMBER)
	IS
		-- Date variable to store match date
		mDate date;
		-- Number variale to store match winner ID
		mWinner number;
		-- Number variable to store number of kills per team
		teamKills number;
		-- Nvarchar2 variable to store a team name
		teamName nvarchar2(50);
		-- Nvarchar2 variable to store a tournament name
		tournamentName nvarchar2(80);
		-- Cursor delcaration to get Match, Team and Tournament IDs from MatchRoster for the specified MatchID
		CURSOR MatchRoster_CURSOR IS SELECT MatchID, TeamID, TournID FROM MatchRoster WHERE MatchID = mID;
		-- Variable to store fetched row by cursor
		MatchRosterRow MatchRoster_CURSOR%ROWTYPE;
	BEGIN
		-- Open cursor
		OPEN MatchRoster_CURSOR;
		-- Fetch row from cursor, store in 'MatchRosterRow'
		FETCH MatchRoster_CURSOR INTO MatchRosterRow;

		-- Fetch and store match date and winner ID in 'mDate' and 'mWinner'
		SELECT MatchDate, MatchWinnerID INTO mDate, mWinner FROM MatchOverview WHERE MatchID = mID;
		-- Print Match ID and Match Date
		DBMS_OUTPUT.PUT_LINE('================================================================');
		DBMS_OUTPUT.PUT_LINE('|  Match ID: ' || mid);
		DBMS_OUTPUT.PUT_LINE('|  Match Date: ' || mDate);
		
		-- Fetch and store tournament info in 'Tournament', uses MatchRosterRow to get the tournament ID
		SELECT TournName INTO tournamentName FROM Tournament WHERE TournID = MatchRosterRow.TournID;
		-- Print tournament info
		DBMS_OUTPUT.PUT_LINE('|  Tournament: ' || tournamentName);
		DBMS_OUTPUT.PUT_LINE('|  -------------------------------------------------------------');
		DBMS_OUTPUT.PUT_LINE('|  Opponents:');

		-- While cursor still has more rows to fetch
		<<CURSOR_FETCHING_LOOP>>
		WHILE (MatchRoster_CURSOR%FOUND) LOOP
			-- Get team name from MatchRosterRow, store in teamName var
			SELECT TeamName INTO teamName FROM Team WHERE TeamID = MatchRosterRow.TeamID;
			-- Calculate the number of kills this team had, store in teamKills var
			SELECT SUM(Kills) INTO teamKills FROM MatchDetails WHERE MatchDetails.TeamID = MatchRosterRow.TeamID AND MatchDetails.MatchID = mID;
			-- Print the team name and number of kills
			DBMS_OUTPUT.PUT_LINE('|  ' || teamName || '   (kills: ' || teamKills || ')');
			-- Fetch next row from cursor, store in 'MatchRosterRow'
			FETCH MatchRoster_CURSOR INTO MatchRosterRow;
		END LOOP CURSOR_FETCHING_LOOP;

		-- Get winner of match, store in 'teamName'
		SELECT TeamName into teamName FROM Team WHERE TeamID = mWinner;
		-- Print winning team
		DBMS_OUTPUT.PUT_LINE('|  Winning team:');
		DBMS_OUTPUT.PUT_LINE('|  *** ' || teamName || ' ***');
		DBMS_OUTPUT.PUT_LINE('|  -------------------------------------------------------------');
		ListMatchHeroes(mID);
		DBMS_OUTPUT.PUT_LINE('================================================================');

		-- Close cursor
		CLOSE MatchRoster_CURSOR;

		EXCEPTION
			-- Catch when no data is found
			WHEN NO_DATA_FOUND THEN
				DBMS_OUTPUT.PUT_LINE('ERROR: No data found for Match ID ' || mID);
			-- Default catch-all when some other exception occurs
			WHEN OTHERS THEN
				DBMS_OUTPUT.PUT_LINE('An error occured.');
	END MatchStats;



	/* 
	*	PROCEDURE 2
	*	============
	*	
	*	Objective:
	*	----------
	*
	*	Calculate + print all the info/statistics about a given player (eg nationality, matches played, most played hero etc) using DBMS_OUTPUT.
	*	Raises and catches NO_DATA_FOUND exception if there is no data for the specified PlayerID.
	*	Raises and catches NO_MATCH_DATA_FOUND exception when we have the player details, but no match data for them.
	*
	*/

	PROCEDURE PlayerStats(pID IN NUMBER)
	IS
		-- Nvarchar2 variable to store player's nationality
		pNationality nvarchar2(100);
		-- Nvarchar2 variable to store player's team name 
		tName nvarchar2(80);
		-- Number to store the ID of the player's favourite hero
		favHeroID number;
		-- Varchar2 variable to store player's most played hero
		favHero varchar2(80);
		-- Number variable to store number of matches played by player
		numMatchesPlayed number;
		-- Cursor to fetch player info from Player table
		CURSOR Player_CURSOR IS SELECT PlayerHandle, PlayerName, PlayerDOB, TeamID, CountryID FROM Player WHERE PlayerID = pID;
		-- Variable to store player info row from 'Player_CURSOR'
		PlayerRow Player_CURSOR%ROWTYPE;
		-- Cursor to fetch calculated player match stats from 'MatchDetails' table
		CURSOR PlayerMaxStat_CURSOR IS 
			SELECT Max(Kills) AS Kills, Max(Deaths) AS Deaths, Max(LastHits) AS LastHits, Max(Denies) AS Denies, Max(GPM) AS GPM, Max(XPM) AS XPM 
			FROM MatchDetails 
			WHERE PlayerID = pID;
		-- Variable to store player stat row from 'PlayerMaxStat_CURSOR'
		PlayerMaxStats PlayerMaxStat_CURSOR%ROWTYPE;
		-- Declaring custom exception to be raised when we have no match data for the player
		NO_MATCH_DATA Exception;
	BEGIN
		-- Open cursor 'Player_CURSOR'
		OPEN Player_CURSOR;
		-- Fetch row from cursor, store in 'PlayerRow'
		FETCH Player_CURSOR INTO PlayerRow;
		-- Open cursor 'PlayerMaxStat_CURSOR'
		OPEN PlayerMaxStat_CURSOR;
		-- Fetch row from cursor, store in 'PlayerMaxStats'
		FETCH PlayerMaxStat_CURSOR INTO PlayerMaxStats;
		-- Get nationality from 'Country' table using CountryID from 'PlayerRow', store in pNationality
		SELECT CountryName INTO pNationality FROM Country WHERE CountryID = PlayerRow.CountryID;
		-- Get team name from 'Team' table using TeamID from 'PlayerRow', store in tName
		SELECT TeamName INTO tName FROM TEAM WHERE TeamID = PlayerRow.TeamID;
		-- Calculate number of matches played by player, store in numMatchesPlayed
		SELECT Count(MatchID) INTO numMatchesPlayed FROM MatchDetails WHERE PlayerID = pID;

		-- Print general player info
		DBMS_OUTPUT.PUT_LINE('============================================================');
		DBMS_OUTPUT.PUT_LINE('|  Player ID : ' || pID);
		DBMS_OUTPUT.PUT_LINE('|  Player Handle : ' || PlayerRow.PlayerHandle);
		DBMS_OUTPUT.PUT_LINE('|  Player Name : ' || PlayerRow.PlayerName);
		DBMS_OUTPUT.PUT_LINE('|  Player DOB : ' || PlayerRow.PlayerDOB);
		DBMS_OUTPUT.PUT_LINE('|  Player Nationality : ' || pNationality);
		DBMS_OUTPUT.PUT_LINE('|  Primary Team : ' || tName);
		
		-- Check if we have any match data for player
		IF (numMatchesPlayed) = 0 THEN
			DBMS_OUTPUT.PUT_LINE('============================================================');
			-- If player has no match data stored in db, raise NO_MATCH_DATA exception
			RAISE NO_MATCH_DATA;
		END IF;

		favHeroID := MostPlayedHero(pID);

		-- Get player's most played hero using the MostPlayedHero helper function stored privately in this package
		SELECT HeroName INTO favHero FROM HERO WHERE HeroID = favHeroID;

		-- Print player's matches played and most played hero
		DBMS_OUTPUT.PUT_LINE('|  ---------------------------------------------------------');
		DBMS_OUTPUT.PUT_LINE('|  Matches Played: ' || numMatchesPlayed);
		DBMS_OUTPUT.PUT_LINE('|  Most Played Hero: ' || favHero);

		-- Print player's best match stats using data stored in 'PlayerMaxStats' as fetched by 'PlayerMaxStat_CURSOR'
		DBMS_OUTPUT.PUT_LINE('|  Most Kills: ' || PlayerMaxStats.Kills);
		DBMS_OUTPUT.PUT_LINE('|  Most Deaths: ' || PlayerMaxStats.Deaths);
		DBMS_OUTPUT.PUT_LINE('|  Most Last Hits: ' || PlayerMaxStats.LastHits);
		DBMS_OUTPUT.PUT_LINE('|  Most Denies: ' || PlayerMaxStats.Denies);
		DBMS_OUTPUT.PUT_LINE('|  Highest Gold Per Minute (GPM): ' || PlayerMaxStats.GPM);
		DBMS_OUTPUT.PUT_LINE('|  Highest Experience Per Minute (XPM): ' || PlayerMaxStats.XPM);
		DBMS_OUTPUT.PUT_LINE('============================================================');

		-- Close this cursor
		CLOSE Player_CURSOR;
		-- Close this cursor
		CLOSE PlayerMaxStat_CURSOR;

		EXCEPTION 
			-- Catch when no data is found
			WHEN NO_DATA_FOUND THEN
				DBMS_OUTPUT.PUT_LINE('ERROR: No data found for Player ID ' || pID);
			-- Catch when no match data is found
			WHEN NO_MATCH_DATA THEN
				DBMS_OUTPUT.PUT_LINE('No match data found for Player ID ' || pID);
			-- Default catch-all when some other exception occurs
			WHEN OTHERS THEN
				DBMS_OUTPUT.PUT_LINE('An error occured.');
	END PlayerStats;
	

	/* 
	*	PROCEDURE 3
	*	============
	*	
	*	Objective:
	*	----------
	*
	*	Calculate + print all the info/statistics about a given team (eg year founded, matches played, average age of their players etc) using DBMS_OUTPUT.
	*	Raises and catches NO_DATA_FOUND exception if there is no data for the specified TeamID.
	*
	*/

	PROCEDURE TeamStats(tID IN NUMBER)
	IS
		-- Variable to store number of matches played by team
		matchesPlayed number; 
		-- Variable to store number of tournaments entered by team
		tournsParticipated number;
		-- Variable to store number of first places obtained by team in tournaments
		numFirstPlaces number;
		-- Variable to store number of second places obtained by team in tournaments
		numSecondPlaces number;
		-- Variable to store number of third places obtained by team in tournaments
		numThirdPlaces number;
		-- Variable to store the average age of players on the team, we will use the AvgAgeTeam function to calculate this
		averagePlayerAge number;
		-- Name of country team is from
		cName nvarchar2(100);
		-- Cursor which obtains the team's record from the 'Team' table
		CURSOR team_CURSOR IS SELECT * FROM Team WHERE TeamID = tID;
		-- Variable to store the row fetched by team_CURSOR
		tRow team_CURSOR%ROWTYPE;
	BEGIN
		-- Open Cursor 
		OPEN team_CURSOR;
		-- Fetch row from cursor, store in 'tRow'
		FETCH team_CURSOR INTO tRow;
		-- Calculate average age of players on the team, store in 'averagePlayerAge'
		averagePlayerAge := AvgAgeTeam(tID);
		-- Get num matches played, store in 'matchesPlayed'
		SELECT Count(TeamID) INTO matchesPlayed FROM MatchRoster WHERE TeamID = tID;
		-- Get num tournaments entered, store in 'tournsParticipated'
		SELECT Count(TeamID) INTO tournsParticipated FROM TournamentRegistration WHERE TeamID = tID;
		-- Get num first places in tournaments, stored in 'numFirstPlaces'
		SELECT Count(TeamID) INTO numFirstPlaces FROM TournamentRegistration WHERE TeamID = tID AND FinishingPlace = 1;
		-- Get num second places in tournaments, stored in 'numSecondPlaces'
		SELECT Count(TeamID) INTO numSecondPlaces FROM TournamentRegistration WHERE TeamID = tID AND FinishingPlace = 2;
		-- Get num third places in tournaments, stored in 'numThirdPlaces'
		SELECT Count(TeamID) INTO numThirdPlaces FROM TournamentRegistration WHERE TeamID = tID AND FinishingPlace = 3;
		-- Get name of the country team is from, store in 'cName'
		SELECT CountryName INTO cName FROM Country WHERE CountryID = tRow.CountryID;

		-- Print general team statistics
		DBMS_OUTPUT.PUT_LINE('===============================================================');
		DBMS_OUTPUT.PUT_LINE('|  Team ID: ' || tID);
		DBMS_OUTPUT.PUT_LINE('|  Team Name: ' || tRow.TeamName);
		DBMS_OUTPUT.PUT_LINE('|  Nationality: ' || cName);
		DBMS_OUTPUT.PUT_LINE('|  Year Founded: ' || tRow.TeamYearFounded);
		DBMS_OUTPUT.PUT_LINE('|  Matches Played: ' || tID);
		DBMS_OUTPUT.PUT_LINE('|  Average Player Age: ' || averagePlayerAge);
		DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------');
		-- Print tournament statistics for the team
		DBMS_OUTPUT.PUT_LINE('|  Tournaments Entered: ' || tournsParticipated);
		DBMS_OUTPUT.PUT_LINE('|  Number 1st Places in Tournaments: ' || numFirstPlaces);
		DBMS_OUTPUT.PUT_LINE('|  Number 2nd Places in Tournaments: ' || numSecondPlaces);
		DBMS_OUTPUT.PUT_LINE('|  Number 3rd Places in Tournaments: ' || numThirdPlaces);
		DBMS_OUTPUT.PUT_LINE('===============================================================');

		-- Close cursor
		CLOSE team_CURSOR;

		EXCEPTION
			-- Catch when no data is found
			WHEN NO_DATA_FOUND THEN
				DBMS_OUTPUT.PUT_LINE('ERROR: No data found for Team ID ' || tID);
			-- Catch when there is a zero divide
			WHEN ZERO_DIVIDE THEN
				DBMS_OUTPUT.PUT_LINE('ERROR: There was an attempt to divide by zero');
			-- Default catch-all when some other exception occurs
			WHEN OTHERS THEN
				DBMS_OUTPUT.PUT_LINE('An error occured.');
	END TeamStats;
	

	/* 
	*	PROCEDURE 4
	*	============
	*
	*	Objective:
	*	----------
	*
	*	Print all items carried players in a given match.
	*	Also calculate the total number of items in the match. 
	*
	*/

	PROCEDURE MatchItems(mID IN NUMBER)
	IS
		-- Variable to store item name
		iName nvarchar2(50);
		-- Variable to store player name
		PName nvarchar2(50);
		-- Variable to store number of items in the match
		numItems number(3);
		-- Cursor to get the inventory items and players in the given match id 
		CURSOR MatchItems_CURSOR IS SELECT ItemID, PlayerID FROM MatchInventory WHERE MatchID = mID ORDER BY PlayerID;
		-- Variable to store each row from the cursor
		ItemsRow MatchItems_CURSOR%ROWTYPE;
	BEGIN 
		-- Open cursor
		OPEN MatchItems_CURSOR;
		-- Fetch row from cursor, store in 'ItemsRow'
		FETCH MatchItems_CURSOR INTO ItemsRow;
		-- Calculate number of items in match, store in 'numItems'
		SELECT COUNT(ItemID) INTO numItems FROM MatchInventory WHERE MatchID = mID;
		
		-- If cursor cannot find any more data
		IF (MatchItems_CURSOR%NOTFOUND) THEN
			-- Throw now data found exception
			RAISE NO_DATA_FOUND;
		END IF;

		-- Print match ID and number of items in match
		DBMS_OUTPUT.PUT_LINE('============================================================');
		DBMS_OUTPUT.PUT_LINE('Match ID: ' || mID);
		DBMS_OUTPUT.PUT_LINE('Total number of items: ' || numItems);
		DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------');

		-- Loop to keep fetching a new row from the cursor and store in 'ItemsRow' while there is a row to fetch
		<<CURSOR_FETCHING_LOOP>>
		WHILE (MatchItems_CURSOR%FOUND) LOOP
			-- Get item name of cur item ID in 'ItemsRow', store in 'iName'
			SELECT ItemName INTO iName FROM Item WHERE ItemID = ItemsRow.ItemID;
			-- Get player name of cur player ID in 'ItemsRow', store in 'iName'
			SELECT PlayerHandle INTO pName FROM Player WHERE PlayerID = ItemsRow.PlayerID;
			-- Print item and player name
			DBMS_OUTPUT.PUT_LINE('Item: ' || iName || '     (Player: ' || pName || ')');
			-- Fetch new row from cursor, store in 'ItemsRow'
			FETCH MatchItems_CURSOR INTO ItemsRow;
		END LOOP CURSOR_FETCHING_LOOP;

		DBMS_OUTPUT.PUT_LINE('============================================================');
		CLOSE MatchItems_CURSOR;

	EXCEPTION
		-- Catch when no data is found
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('ERROR: No data found for Match ID ' || mID);
		-- Default catch-all when some other exception occurs
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE('An error occured.');
	END MatchItems;
	

	/* 
	*	PROCEDURE 5
	*	===========
	*
	*	Objective:
	*	----------
	*
	*	Inserts a new row to the Player table with the provided values. 
	*	Creates a savepoint before every insert and rollbacks to this whenever an error occurs.
	*
	*/
	PROCEDURE InsertPlayer(pHandle IN nvarchar2, pName IN nvarchar2, tID IN number, cID IN number)
	IS
		CURSOR CheckPlayer_CURSOR IS SELECT PlayerHandle, TeamID FROM Player WHERE PlayerHandle = pHandle AND TeamID = tID;
		PlayerRow CheckPlayer_CURSOR%ROWTYPE;
		PLAYER_EXISTS Exception;
	BEGIN
		-- Create a save point, we will rollback to this if the insert fails
		SAVEPOINT SAVEP_BeforeRowInsert;
		
		OPEN CheckPlayer_CURSOR;
		FETCH CheckPlayer_CURSOR INTO PlayerRow;

		IF (CheckPlayer_CURSOR%FOUND) THEN
			RAISE PLAYER_EXISTS;
		END IF;

		-- Notify user of an insert
		DBMS_OUTPUT.PUT_LINE('Attempting to insert player ' || pHandle || ' to the database.');
		-- Attempt an insert to Player table with data provided to procedure
		INSERT INTO Player(PlayerHandle, PlayerName, TeamID, CountryID) VALUES (pHandle, pName, tID, cID);
		
		EXCEPTION
			WHEN PLAYER_EXISTS THEN
				DBMS_OUTPUT.PUT_LINE('Error: Player ' || pHandle || ' already exists in the player table');
			-- When any error occurs
			WHEN OTHERS THEN
				-- Notify user 
				DBMS_OUTPUT.PUT_LINE('Error occured in inserting player ' || pHandle || '. Rolling back to before this insert was attempted.');
				-- Rollback to save point 'BeforeRowInsert'
				ROLLBACK TO SAVEP_BeforeRowInsert;
	END InsertPlayer;
	

END;
/


/*	CODE TO TEST PROCEDURES IN ABOVE PACKAGE */

-- Procedure 1 'MatchStats': This anonymous PL/SQL block will call the procedure to print the match statistics for MatchID 26795420
BEGIN
	Dota.MatchStats(267795420);
END;
/

-- Procedure 2 'PlayerStats': This anonymous PL/SQL block will call the procedure to print the player statistics for PlayerID 2 (Dendi)
BEGIN
	Dota.PlayerStats(2);
END;
/

-- Procedure 3 'TeamStats': This anonymous PL/SQL block will call the procedure to print the team statistics for TeamID 2 (Alliance)
BEGIN
	Dota.TeamStats(2);
END;
/

-- Procedure 4 'MatchInventory': This anonymous PL/SQL block will call the procedure to print all items carried by players in MatchID 26795420
BEGIN
	Dota.MatchItems(267795420);
END;
/


-- Procedure 5 'InsertPlayer': This anonymous PL/SQL block will create a new Team and then call on the procedure to insert the players.
SET AUTOCOMMIT OFF;
-- Insert team 'Titan Esports'
INSERT INTO Team(TeamName, CountryID, TeamYearFounded) VALUES ('Titan Esports', 5, 2013);
-- Commit team creation
COMMIT;

BEGIN 

	-- Insert players for team Titan Esports using the procedure
	Dota.InsertPlayer('XtiNcT', 'Chan Zhan Leong', 32, 5);
	Dota.InsertPlayer('ky.xy', 'Kang Yang Lee', 32, 5);
	Dota.InsertPlayer('Net', 'Wai Pern Lim', 32, 5);
	Dota.InsertPlayer('Ohaiyo', 'Chong Xin Khoo', 32, 5);
	Dota.InsertPlayer('YamateH', 'Ng Wei Poong', 32, 5);

	-- This is a deliberately failing insert as there is no TeamID 100, procedure will perform a rollback to state before insert
	Dota.InsertPlayer('Jazq', 'Wong Tee Lu', 100, 5);

	-- Commit player creation
	COMMIT;

END;
/
-- Show players in Titan Esports
SELECT * FROM Player WHERE TeamID = 32;


--------------------------------------------------------------------------------------------------------------


/* 7. 	PL/SQL FUNCTIONS (2) 	*/



/*  
*	FUNCTION 1  
*  	==========
*
*  	Objective: 
*  	----------
*
*  	Caclulate and return the average KDA ratio (Kills / Deaths / Assists) for a given Player.
*  	The function takes the Player's ID as an IN parameter.
*  	KDA is returned as number to a two point precision - eg 3.21.
*
*  	Formula for calculating a match KDA is: Player's Kills +  Player's Deaths / Player's Assists. 
*
*/

-- Create function or replace function with name 'AvgKDA'
CREATE OR REPLACE FUNCTION PlayerAvgKDA (pID IN number)
-- Declaring that this function will return a number
RETURN number
IS
	-- Number variable to store number of games played by the player
	gamesPlayed number(8);
	-- Number variable to store the kda, set to 0 initially. This will modified and returned by function.
	kda number (3, 2) := 0;
	-- Declare cursor 'kda_CURSOR', assign to a select from MatchDetails with given PlayerID (pID parameter).
	CURSOR kda_CURSOR IS SELECT Kills, Deaths, Assists FROM MatchDetails WHERE PlayerID = pID;
	-- Declare 'mDetailsRow' to be of the row type fetched by 'kda_CURSOR'
	mDetailsRow kda_CURSOR%ROWTYPE;
BEGIN
	BEGIN
		-- Get number of games played by player
		SELECT COUNT(MatchID) INTO gamesPlayed FROM MatchDetails WHERE PlayerID = pID;
		
		-- Check if we don't have any game data for this player
		IF (gamesPlayed = 0) THEN
			-- Throw NO_DATA_FOUND exception
			RAISE NO_DATA_FOUND;
		END IF;
		
		-- Open cursor
		OPEN kda_CURSOR;
		-- Fetch row from cursor, store in 'mDetailsRow'
		FETCH kda_CURSOR INTO mDetailsRow;

		-- While cursor still has rows, continue to loop
		<<CURSOR_FETCHING_LOOP>>
		WHILE (kda_CURSOR%FOUND) LOOP
			-- Caclulate kda for this match, add to existing kda value
			kda := kda + ((mDetailsRow.Kills + mDetailsRow.Deaths) / mDetailsRow.Assists);
			-- Fetch next row from cursor and store in var
			FETCH kda_CURSOR INTO mDetailsRow;
		END LOOP CURSOR_FETCHING_LOOP;

		-- Close cursor
		CLOSE kda_CURSOR;

		-- Calculate average kda for all matches played by player
		kda := kda / gamesPlayed;

	EXCEPTION
		-- Catch a divise by zero
		WHEN ZERO_DIVIDE THEN
			DBMS_OUTPUT.PUT_LINE('ERROR: Divide by zero attempted');
		-- Catch when no data is found
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('ERROR: No data found for Player ID ' || pID);
		-- Default catch-all when some other exception occurs
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE('An error occured.');
	END;
	-- If we reach this point, no exceptions have occured and we are safe to return the calculated kda
	RETURN kda;
END PlayerAvgKDA;
/



/*  
*	
*	FUNCTION 2
* 	==========
*
*  	Objective: 
*  	----------
*
*	Calculate and return the win rate (%) of a given Team from all their matches played.
*	The function takes the Team's ID as an IN parameter.
*	Win rate is returned as number to a two point precision - eg 47.86(%).
*
*	Formula for caculating a team's win rate is: (num wins / matches played) * 100
*
*/

-- Create function or replace function with name 'TeamWinRate'
CREATE OR REPLACE FUNCTION TeamWinRate (tID IN number) 
-- Declare function will return a number
RETURN number
IS 
	-- Number variable to store the win rate, will be returned by function
	winRate number(4,2);
	-- Number variable to store number of matches played by the specified team
	timesPlayed number  (10);
	-- Number variable to store number of matches won by the specified team
	tWins number (9);
	-- Number variable to store number of matches lost by the specified team
	tLosses number (9);
BEGIN
	BEGIN
		-- Get number of matches played by team from MatchRoster table, store in 'timesPlayed'
		SELECT COUNT(TeamID) INTO timesPlayed FROM MatchRoster WHERE TeamID = tID;
		
		-- Check if database does not have any match data for this team
		IF (timesPlayed = 0) THEN
			-- Raise NO_DATA_FOUND exception
			RAISE NO_DATA_FOUND;
		END IF;
		
		-- Count number of wins for the team, store in 'tWins'
		SELECT COUNT(MatchWinnerID) INTO tWins FROM MatchOverview WHERE MatchOverview.MatchWinnerID = tID;
		
		-- Calculate win rate for the team
		winRate := (tWins / timesPlayed) * 100;
		
		EXCEPTION
			-- Catch a divise by zero
			WHEN ZERO_DIVIDE THEN
				DBMS_OUTPUT.PUT_LINE('ERROR: Divide by zero attempted');
			-- Catch when no data is found
			WHEN NO_DATA_FOUND THEN
				DBMS_OUTPUT.PUT_LINE('ERROR: No data found for Team ID ' || tID);
			-- Default catch-all when some other exception occurs
			WHEN OTHERS THEN
				DBMS_OUTPUT.PUT_LINE('An error occured.');
	END;
	-- If we reach this point, no exceptions have occured and we are safe to return the calculated win rate
	RETURN winRate;
END TeamWinRate;
/



/*	CODE TO TEST ABOVE FUNCTIONS */

/* 
	Testing Function 1: 'PlayerAvgKDA'
	Here we get the KDA ratio of the Player with PlayerID 2 (PlayerName: Dendi).
*/
SELECT PlayerAvgKDA(2) FROM DUAL; 

/* 
	Testing Function 2: 'TeamWinRate'
	Here we get the percentage of matches won by TeamID 1 (TeamName: Navi).
*/
SELECT TeamWinRate(1) || '%' AS "WinRate (TeamID = 1)" FROM DUAL; 



--------------------------------------------------------------------------------------------------------------



/* 8. 	TRIGGERS (3) - 2 before, 1 after 	*/



/* 	
*	TRIGGER 1 (BEFORE)
*	================== 
*
*	Objective:
* 	---------- 
*
*	Enforce the business rule that a match must have no more than 10 players.
* 
 */

-- Create or replace a Trigger with the name 'TRIG_CheckMatch' 
CREATE OR REPLACE TRIGGER TRIG_CheckMatch
-- This trigger will fire for every row before an INSERT or UPDATE statement is applied to the 'MatchDetails' table
BEFORE INSERT OR UPDATE ON MatchDetails
FOR EACH ROW
DECLARE
	-- Number variable to store number of players counted in a given match
	numPlayersTotal number(2);
BEGIN
	-- Get number of players currently recorded in MatchDetails for the specified match
	SELECT Count(MatchID) INTO numPlayersTotal FROM MatchDetails WHERE MatchID = :NEW.MatchID;
	
	-- Check if there are already 10 players recorded for this match
	IF (numPlayersTotal >= 10) THEN
		-- Raise application error, will cause the offending insert / update statement to fail
		RAISE_APPLICATION_ERROR(-20000, 'Error: Already 10 players in Match ID ' || :NEW.MatchID);
	END IF;

END TRIG_CheckMatch;
/ 


/* 	
*	TRIGGER 2 (BEFORE) 
*	==================
*
*	Objective: 
*	----------
*
*	Enforce the business rule that no match can have duplicate heroes.
*
*/

-- Create or replace a Trigger with the name 'TRIG_CheckHero' 
CREATE OR REPLACE TRIGGER TRIG_CheckHero
-- To fire for each row before an insert or update statement is applied to the table 'MatchHeroes'
BEFORE INSERT OR UPDATE ON MatchHeroes
FOR EACH ROW
DECLARE
	-- Cursor to obtain the a row from MatchHeroes for the specified HeroID and MatchID
	CURSOR MatchHeroes_CURSOR IS SELECT MatchID, HeroID FROM MatchHeroes WHERE MatchID = :NEW.MatchID AND HeroID = :NEW.HeroID;
	-- Variable of type MatchHeroes_CURSOR row to store the data fetched by cursor
	MatchHeroes_ROW MatchHeroes_CURSOR%ROWTYPE;
BEGIN
	-- Open cursor
	OPEN MatchHeroes_CURSOR;
	-- Fetch first row obtained by cursor, store in 'MatchHeros_ROW'
	FETCH MatchHeroes_CURSOR INTO MatchHeroes_ROW;

	-- If the cursor has found data already in the 'MatchHeroes' table corresponding to the specified MatchID / HeroID 
	IF (MatchHeroes_CURSOR%FOUND) THEN
			-- Raise an application error as this hero already exists in this match, this will stop the INSERT / UPDATE statement from occuring
			RAISE_APPLICATION_ERROR(-20002, 'Error: Hero ID ' || MatchHeroes_ROW.HeroID || ' already exists in Match ID ' || :NEW.MatchID);
	END IF;

	-- Close cursor
	CLOSE MatchHeroes_CURSOR;

	EXCEPTION
		-- Catch when no data is found
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('Error: No data found');
END TRIG_CheckHero;
/ 


/* 	
*	TRIGGER 3 (AFTER) 
*	=================
*
*	Objective: 
*	----------
*
*	Notfiy (using DBMS_OUTPUT) when a Player's team is modified in the Player table using an update statement.
*	This trigger will also fire when a new row is inserted to the Player table, printing the new player's details using DBMS_OUTPUT.
*
*/

-- Create or replace a Trigger with the name 'TRIG_CheckHero' 
CREATE OR REPLACE TRIGGER TRIG_HeroUpdateInsertAction
-- Trigger to fire for each row after an UPDATE statement affecting Player.TeamID or an INSERT statement has been applied to the 'Player' table
AFTER UPDATE OF TeamID OR INSERT ON Player
FOR EACH ROW 
DECLARE
	-- Variable to store new team name 
	tNameNew nvarchar2(80);
	-- Variable to store old team
	tNameOld nvarchar2(80);
	-- Variable to store new nationality
	cNameNew nvarchar2(100);
BEGIN
	-- Get the name of the team using the new Team ID specified
	SELECT TeamName into tNameNew FROM Team WHERE TeamID = :NEW.TeamID;
	
	-- If trigger is firing after an INSERT statement
	IF INSERTING THEN
		-- Get the country name for the new player 
		SELECT CountryName into cNameNew FROM Country WHERE CountryID = :NEW.CountryID;
		-- Notify that a row was inserted to Player, list the new player's details
		DBMS_OUTPUT.PUT_LINE('Player ' || :NEW.PlayerHandle || ' (' || :NEW.PlayerName || ') with primary team ' || tNameNew || ' and nationality ' || cNameNew || ' was inserted into the PLAYER table.');
	END IF;	

	-- If trigger is firing after an UPDATE statement
	IF UPDATING THEN
		-- Get the name of the player's Team before the update statement changed it
		SELECT TeamName into tNameOld FROM Team WHERE TeamID = :OLD.TeamID;
		-- Notify that an update statement has occured, name the player's old team and the player's new team
		DBMS_OUTPUT.PUT_LINE('Player ' || :NEW.PlayerHandle || ' (' || :NEW.PlayerName || ') has had their primary team changed from ' || tNameOld || ' to ' || tNameNew || '.');
	END IF;

	EXCEPTION
		-- Catch when no data is found
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('Error: No data found');
		-- Default catch-all when some other exception occurs
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE('An error occured.');
END TRIG_HeroUpdateInsertAction;
/



/*	SQL CODE TO TEST ABOVE TRIGGERS */


-- 	Testing Trigger 1: 'TRIG_CheckMatch'

/* 	We attempt to add a player to MatchDetails table with a MatchID that already has 10 players attached to it.
   	This shoud fire the trigger, and the insert will be prevented from occuring. */
INSERT INTO MatchDetails(MatchID, PlayerID, TeamID, Lvl, Kills, Deaths, Assists, LastHits, Denies, XPM, GPM)
VALUES (269910097, 28, 2, 12, 4, 3, 4, 38, 7, 332, 304);


-- 	Testing Trigger 2: 'TRIG_CheckHero'

/* 	Here we attempt to add a Hero to a Match that already has this hero
   	This should fire the trigger, and the insert will be prevented from occuring. */
INSERT INTO MatchHeroes(MatchID, PlayerID, HeroID) VALUES (269910097, 7, 68);


-- Testing Trigger 3: 'TRIG_HeroUpdateInsertAction'

/* 	First, we attempt to insert a new Player to the 'Player' table.
	This insert should be successful and the trigger should fire after with its 'INSERT' behaviour */
INSERT INTO Player(PlayerHandle, PlayerName, TeamID, CountryID) VALUES ('Wretch', 'Aidan Knowles', 2, 1);

/* 	Next, we attempt to update Player Puppey (pID 1, Team Navi) to be part of a new Team (Team Liquid)
	This update should be successful and the trigger should fire after with its 'UPDATE' behaviour */
UPDATE Player SET TeamID = 10 WHERE PlayerID = 1;



--------------------------------------------------------------------------------------------------------------


-- End of File (EOF).
