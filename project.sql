CREATE TABLE `user` (
    `id` varchar(10) PRIMARY KEY,
    `password` varchar(50) NOT NULL,
    `score_total` INT DEFAULT 0 ,
    `score_win` INT DEFAULT 0,
    `score_lost` INT DEFAULT 0 
);

create TABLE `board` (
    `uid` varchar(10) NOT NULL,
    `bid` INT PRIMARY KEY AUTO_INCREMENT,
    `title` varchar(50) NOT NULL,
    `body` varchar(200) NOT NULL,
    `date` DATETIME DEFAULT NOW()
);
// insert into board (uid, title, body) values ("testuser1", "test", "body");

//PROCEDURE
call ranking;
call search_ranking('testuser1');
call game_result('testuser1', 2, 0);
call personal_info('testuser1');

//랭킹 출력
DELIMITER $$
DROP PROCEDURE IF EXISTS ranking;
CREATE PROCEDURE `ranking`()
BEGIN
select id, score_win-score_lost as rating, score_win, score_lost, (SELECT COUNT(*)+1 FROM user WHERE score_win-score_lost > b.score_win-b.score_lost) as ranking from user as b order by rating desc LIMIT 20;
END $$
DELIMITER ;

// 랭킹 검색
DELIMITER $$
DROP PROCEDURE IF EXISTS search_ranking;
CREATE PROCEDURE search_ranking(IN uid VARCHAR(10))
BEGIN
select id, score_win, score_lost, score_win-score_lost as rating, (SELECT COUNT(*)+1 FROM user WHERE score_win-score_lost > b.score_win-b.score_lost) as ranking from user AS b where id=uid;
END $$
DELIMITER ;

// 게임 결과 등록
// INPUT (user id , win, lose)
DELIMITER $$
DROP PROCEDURE IF EXISTS game_result;
CREATE PROCEDURE game_result(IN uid VARCHAR(10), IN win INT, IN lose INT)
BEGIN
    UPDATE user
    SET score_total=score_total+1,
    score_win=score_win+win,
    score_lost=score_lost+lose
    WHERE id=uid;
END $$
DELIMITER ;


// 개인 승점
DELIMITER $$
DROP PROCEDURE IF EXISTS personal_info;
CREATE PROCEDURE personal_info(IN uid VARCHAR(10))
BEGIN
select id, score_win as win, score_lost as lose, score_total as total, score_win-score_lost as rating, (SELECT COUNT(*)+1 FROM user WHERE score_win-score_lost > b.score_win-b.score_lost) as ranking from user as b where id=uid;
END $$
DELIMITER ;
