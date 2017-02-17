drop procedure if exists curtest;
DELIMITER //
CREATE PROCEDURE curtest()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE a CHAR(16);
  declare i int;

  DECLARE cur1 CURSOR FOR SELECT distinct cid FROM zozo where cid between 4000 and 5000;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur1;

  read_loop: LOOP
    FETCH cur1 INTO a;
    IF done THEN
      LEAVE read_loop;
    END IF;

     set i = 1;
     while i < 26 do
       insert into zozo
       SELECT a,i,0,null FROM dual
       WHERE NOT EXISTS(
        SELECT 'X' FROM zozo WHERE category1 = i and cid=a
       );
       set i = i + 1;
     end while;
     commit;
  END LOOP;
  CLOSE cur1;
END
//
DELIMITER ;
call curtest();
