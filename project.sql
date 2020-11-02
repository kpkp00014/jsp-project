CREATE TABLE `jdbc_test` (
  `username` varchar(12) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `project` (
    `id` varchar(10) PRIMARY KEY,
   `password` varchar(50) NOT NULL
)