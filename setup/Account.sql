-- 계정 인증 정보 테이블(account) 생성
DROP TABLE IF EXISTS `account`;

CREATE TABLE `account`
(
    `account_id`         VARCHAR(50)                         NOT NULL PRIMARY KEY COMMENT '계정 ID',
    `pw_hash`            VARCHAR(255)                        NOT NULL COMMENT '해쉬된 비밀번호',
    `pw_salt`            VARCHAR(255)                        NOT NULL COMMENT '비밀번호 솔트 값',
    `last_pw_changed_on` TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '마지막 비밀번호 변경 일시'
) COMMENT = '계정 인증 정보';

-- 회원 정보 테이블(customer) 생성
DROP TABLE IF EXISTS `customer`;

CREATE TABLE `customer`
(
    `user_code`     INT          NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '사용자 식별자',
    `name`          VARCHAR(100) NOT NULL COMMENT '실명',
    `date_of_birth` DATE         NOT NULL COMMENT '생년월일',
    `email`         VARCHAR(255) NOT NULL COMMENT '이메일',
    `phone`         VARCHAR(15)  NOT NULL COMMENT '휴대전화번호',
    `address`       VARCHAR(255) NOT NULL COMMENT '주소',
    `account_id`    VARCHAR(50)  NOT NULL COMMENT '계정 ID',
    --  계정 ID 외래키 설정: account 테이블의 account_id 컬럼을 참조
    -- 참조 무결성 제약조건 설정: account_id가 변경되거나 삭제될 때 같이 변경되거나 삭제

    -- 튜플 추가 시 account_id가 없을 경우 추가될 수 없음
    CONSTRAINT `fk_account`
        FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`)
            ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT = '회원 정보';


-- 계정 작업 유형 테이블(account_task_type) 생성
DROP TABLE IF EXISTS `account_task_type`;

CREATE TABLE `account_task_type` (
                                     `type_code` INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '작업유형 식별자',
                                     `desc` VARCHAR(255) NOT NULL COMMENT '작업유형 설명'
) COMMENT = '계정 작업 유형';

-- 계정 작업 이력 테이블(account_task_log) 생성
DROP TABLE IF EXISTS `account_task_log`;

CREATE TABLE `account_task_log` (
                                    `log_code` INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '계정작업 이력 코드',
                                    `executed_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '계정작업 수행일시',
                                    `account_id` VARCHAR(50) NOT NULL COMMENT '대상 계정 ID',
                                    `task_code` INT NOT NULL COMMENT '작업유형 식별자',
                                    CONSTRAINT `fk_account_log`
                                        FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`)
                                            ON DELETE CASCADE ON UPDATE CASCADE,
                                    CONSTRAINT `fk_task_log`
                                        FOREIGN KEY (`task_code`) REFERENCES `account_task_type` (`type_code`)
                                            ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT = '계정 작업 이력';


