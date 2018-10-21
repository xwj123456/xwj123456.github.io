/*
Navicat MySQL Data Transfer

Source Server         : my_local
Source Server Version : 50723
Source Host           : localhost:3306
Source Database       : my_blog2

Target Server Type    : MYSQL
Target Server Version : 50723
File Encoding         : 65001

Date: 2018-10-05 23:41:22
*/

SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id`           int(11)      NOT NULL AUTO_INCREMENT,
  `title`        varchar(255) NOT NULL,
  `publisher_id` int(11)      NOT NULL,
  `description`  varchar(255) NOT NULL,
  `content`      text         NOT NULL,
  `cover_img`    varchar(255) NOT NULL,
  `look_num`     int(11)      NOT NULL DEFAULT '0',
  `create_time`  timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time`  timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 2
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES ('1', '前世缘，今生劫', '666', '随便什么啦',
                              '<div><div><p>第九章&nbsp; &nbsp; 联姻 </p><p>&nbsp; &nbsp; &nbsp;  东华帝君白衣金冠，一手撑着坐席上，一手搭在支起的膝上，正执着酒盏把玩。 </p><p>&nbsp; &nbsp; &nbsp; &nbsp; 垂目，不知所思。羽帝环视一遍，默了个大概，把视线投向东华帝君和天君。 </p><p>&nbsp; &nbsp; &nbsp; &nbsp; “凤儿，接下来是第一次考验。你看着我做。”羽帝向凤主传言。 </p><p>&nbsp; &nbsp; &nbsp; &nbsp; “天君，本帝这次是为了缔结两界之谊而来，为了睦邻和谐。”羽帝将酒杯放下，正色道，”我希望可以与天族联姻。” </p><p>&nbsp; &nbsp; &nbsp; &nbsp; “哦？”天君抚了抚胡须，“不知羽帝打算如何联姻，” </p><p>&nbsp; &nbsp;  “我族双帝之一，舍妹凤主凤羽灼华。” </p><p>&nbsp; &nbsp;  “凤主，凤主身份尊贵……”天君思虑， </p><p>“这身份过于尊贵，谁堪匹配？” </p><p>&nbsp; &nbsp; &nbsp; “实不相瞒，舍妹对一人情根深种，我族专一，认定了绝无转移，我对这个妹妹也是极其珍视，既然已经动了心，必要圆了她的心愿。” </p><p>&nbsp; &nbsp; &nbsp; &nbsp; “羽帝既然如此说，难道竟我天族中人？” </p><p>&nbsp; &nbsp; &nbsp; &nbsp;  “不错。” </p><p>&nbsp; &nbsp; &nbsp; &nbsp;  “ 不知是何人？” </p><p>&nbsp; &nbsp; &nbsp; &nbsp;  “正是这位。”羽帝抬袖一指。 </p><p>&nbsp; &nbsp; &nbsp; &nbsp;  天君顺势看去……静了。天君震惊…… </p><p>&nbsp; &nbsp; &nbsp; &nbsp;  狐帝白止从鼻子哼笑出声…… </p><p>&nbsp; &nbsp; &nbsp; &nbsp;  墨渊上神执杯的手顿了顿…… </p><p>&nbsp; &nbsp; &nbsp; &nbsp;  白浅觉得这个羽帝真是个妙人…… </p><p>&nbsp; &nbsp; &nbsp; &nbsp;  折颜连宋之流双眸放光…… </p><p>&nbsp; &nbsp; &nbsp; &nbsp;  其他众仙哑然…… </p><p>&nbsp; &nbsp; &nbsp; &nbsp;  羽帝所指之处，正是白衣金冠，东华帝君。东华帝君挑眉。 </p><p>&nbsp; &nbsp; &nbsp; &nbsp; “羽帝是在玩笑？” </p><p>&nbsp; &nbsp; &nbsp; &nbsp; “绝无虚言。” </p><p>&nbsp; &nbsp; &nbsp; &nbsp; “那本天君不知，我们两族以前从未见过面，既然这位凤主已经动情，不知她是何时喜欢上的东华帝君？”天君的这个问题让在场的所有人都一惊。 </p><p>&nbsp; &nbsp; &nbsp; &nbsp;  “就是在这八万年之间，五万年前的遇见。”凤主的这个回答，让所有人一惊。 </p><p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  白家人议论：莫非，这位凤主是小九。 </p><p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  “羽帝和凤主初来乍到，本帝君可以谅解，天下皆知，本君远离红尘，不涉俗世，此生注定不会有姻缘。不必浪费时间在本帝君身上。”东华放下酒杯，淡然道。 </p><p>&nbsp; &nbsp; &nbsp; &nbsp; “本帝也听说过，帝君当年为天下苍生自毁姻缘于三生石上。本帝，也知道，东华帝君在这几万年之间，也对一个人动了情。帝君现在的不娶，莫不是在等佳人。” </p><p>&nbsp; &nbsp; &nbsp; &nbsp; 东华皱眉，“羽帝知道的倒是清楚。” </p><p>&nbsp; &nbsp; &nbsp; &nbsp; “无妨，舍妹不是此天地中人，不受三生石的束缚。” </p><p>&nbsp; &nbsp; &nbsp; &nbsp; “本帝君无意于此。还请羽帝替令妹另择佳偶。”东华眼中已有不耐。 </p><p>&nbsp; &nbsp; &nbsp; &nbsp; “帝君可要思虑清楚，本帝当众提亲，诚意十足。而且，本帝对于凤主，高于一切，为了凤主，本帝可以不惜一切。包括两界之谊，甚而边界之战。“ </p><p>&nbsp; &nbsp; &nbsp; &nbsp; 不娶就战？……满大殿里，无人能言。 </p><p>&nbsp; &nbsp; &nbsp; &nbsp; 羽帝直视东华冷下来的双眼。“帝君说远离红尘日久，可本帝还听说，帝君曾经辜负了一位佳人，现如今伊人已渺，本帝也深觉惋惜。” </p><p>&nbsp; &nbsp; &nbsp; &nbsp; 帝君站起，“若佳人能够回来呢！” </p><p>&nbsp; &nbsp; &nbsp; &nbsp; 大殿之上猛然威压大盛，天帝墨渊等都变了眼神，帝君动了真怒！ </p><p>&nbsp; &nbsp; &nbsp; &nbsp; 不止帝君，青丘诸人和折颜也变了颜色，这个羽帝是在挑衅！敢拿小九的情缘来挑衅！ </p><p>&nbsp; &nbsp; &nbsp;  显然羽帝犯了众怒！ </p><p>&nbsp; &nbsp; &nbsp;  羽帝对这番变化看在眼里，却毫不在意。东华逼视羽帝双眼。羽帝亦不闪不避直接迎上。大殿上一片寂静。 </p><p>&nbsp; &nbsp; &nbsp;  就在折颜以为这两人打算对视到地老天荒时，东华帝君率先垂眸，背对天君道， </p><p>“本帝君忽觉不适，先行一步了。”语毕，缓步离开。 </p><p>&nbsp; &nbsp; &nbsp; &nbsp; 凤九看着帝君的背影挑唇。东华，这次，你选苍生？还是选我？就让我看看你的真心！让我看看我五万年有没有爱错人！让我看看一次次的考验你是否还经得住！ </p><p>&nbsp; &nbsp; &nbsp; &nbsp; 天君很头痛，帝君一走，羽帝是不是会对他发难，此事，他是真做不得主。 </p><p>&nbsp; &nbsp; &nbsp; &nbsp; “既然帝君不适，这联姻之事……”羽帝果然回首望向天君。 </p><p>&nbsp; &nbsp; &nbsp; &nbsp; “此事事关两界之谊，兹事体大，还请羽帝容我与帝君慎重商讨。” </p><p>&nbsp; &nbsp; &nbsp; &nbsp; “也好，自当慎重！本帝不急。走吧，凤儿，我们回去休息。”羽帝抬杯，一口饮下，痛快！牵着凤主就走了。 </p><p>&nbsp; &nbsp; &nbsp; &nbsp; 折颜看向羽帝想：看来羽帝之前说与帝君有仇怨不假。可是既然从未谋面，这仇怨从何而来？ </p><p>&nbsp; &nbsp; &nbsp; &nbsp; 羽帝微笑，席间对他不假辞色，眼带厌恶的，就是这世凤九的亲人，青丘白家了吧。 </p><p>&nbsp; &nbsp; &nbsp;  羽帝很欣慰。凤儿在这边也有人宠爱。一时宾主尽欢。宴后，羽帝一行人被请入住赤藻宫。一宿相安。</p></div><br><br>作者：笙笙不息白笙<br>链接：https://www.jianshu.com/p/04d49bde0da9<br>來源：简书<br>简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。</div>',
                              '8aa7e1e0-5aed-4268-bd2a-a62a318e7b7e.jpg', '259', '2018-10-04 14:53:18',
                              '2018-10-04 14:53:18');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id`            int(11)      NOT NULL AUTO_INCREMENT,
  `article_id`    int(11)      NOT NULL,
  `user_face`     varchar(255)          DEFAULT NULL,
  `user_nickname` varchar(255)          DEFAULT NULL,
  `user_id`       int(11)      NOT NULL,
  `content`       varchar(255) NOT NULL,
  `star_num`      int(11)      NOT NULL DEFAULT '0',
  `create_time`   timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time`   timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 11
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES ('1', '1', '图片1', '游客1', '666', '真开心呀', '0', '2018-10-04 17:18:37', '2018-10-05 18:59:17');
INSERT INTO `comment`
VALUES ('2', '1', '图片2', '游客2', '333', '我也觉得真开心呢', '0', '2018-10-04 17:19:23', '2018-10-05 18:59:22');
INSERT INTO `comment`
VALUES ('3', '1', '图片2', '游客2', '333', '你真这么觉得啊', '0', '2018-10-04 20:21:10', '2018-10-05 18:59:21');
INSERT INTO `comment` VALUES ('4', '1', '图片1', '游客1', '666', '没毛病', '0', '2018-10-04 20:21:37', '2018-10-05 18:59:19');
INSERT INTO `comment`
VALUES ('5', '1', '图片1', '游客1', '666', '我自己写的当然棒了', '0', '2018-10-04 23:50:17', '2018-10-05 18:59:18');
INSERT INTO `comment`
VALUES ('7', '1', '图片1', '游客1', '666', '<p>漂亮</p>', '0', '2018-10-05 15:38:13', '2018-10-05 18:59:18');
INSERT INTO `comment`
VALUES ('8', '1', '图片1', '游客1', '666', '<p>巴斯卡</p>', '0', '2018-10-05 16:04:12', '2018-10-05 18:59:17');
INSERT INTO `comment`
VALUES ('9', '1', '图片1', '游客1', '666', '<p>气死你个鬼祟</p>', '0', '2018-10-05 20:44:04', '2018-10-05 20:44:04');
INSERT INTO `comment`
VALUES ('10', '1', '图片1', '游客1', '666', '<p>我是来得最晚的</p>', '0', '2018-10-05 23:39:33', '2018-10-05 23:39:33');

-- ----------------------------
-- Table structure for reply
-- ----------------------------
DROP TABLE IF EXISTS `reply`;
CREATE TABLE `reply` (
  `id`            int(11)      NOT NULL AUTO_INCREMENT,
  `comment_id`    int(11)      NOT NULL,
  `reply_id`      int(11)      NOT NULL,
  `reply_type`    int(11)      NOT NULL
  COMMENT '0为回复主贴，1为回复人',
  `content`       varchar(255) NOT NULL,
  `from_uid`      int(11)      NOT NULL,
  `from_nickname` varchar(255) NOT NULL,
  `from_face`     varchar(255) NOT NULL,
  `to_uid`        int(11)               DEFAULT NULL,
  `to_face`       varchar(255)          DEFAULT NULL,
  `to_nickname`   varchar(255)          DEFAULT NULL,
  `star_num`      int(11)      NOT NULL DEFAULT '0',
  `create_time`   timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time`   timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 13
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of reply
-- ----------------------------
INSERT INTO `reply` VALUES
  ('1', '1', '1', '0', '哇层主好帅呢', '333', '游客2', '图片2', '666', '图片1', '游客1', '0', '2018-10-05 16:42:13',
   '2018-10-05 17:33:15');
INSERT INTO `reply` VALUES
  ('2', '1', '1', '1', '谢你啊', '666', '游客1', '图片1', '333', '图片2', '游客2', '0', '2018-10-05 16:43:07',
   '2018-10-05 17:33:24');
INSERT INTO `reply` VALUES
  ('3', '7', '7', '0', '秀儿', '666', '游客1', '图片1', null, null, null, '0', '2018-10-05 23:08:54', '2018-10-05 23:08:54');
INSERT INTO `reply` VALUES
  ('4', '7', '3', '1', '究极无敌螺旋棒棒', '666', '游客1', '图片1', '666', '图片1', '游客1', '0', '2018-10-05 23:13:02',
   '2018-10-05 23:13:02');
INSERT INTO `reply` VALUES
  ('5', '7', '4', '1', '说别人没说你是吧', '666', '游客1', '图片1', '666', '图片1', '游客1', '0', '2018-10-05 23:13:13',
   '2018-10-05 23:13:13');
INSERT INTO `reply` VALUES
  ('6', '7', '4', '1', '你怎么说', '666', '游客1', '图片1', '666', '图片1', '游客1', '0', '2018-10-05 23:13:26',
   '2018-10-05 23:13:26');
INSERT INTO `reply` VALUES
  ('7', '7', '3', '1', '勿扰！', '666', '游客1', '图片1', '666', '图片1', '游客1', '0', '2018-10-05 23:13:40',
   '2018-10-05 23:13:40');
INSERT INTO `reply` VALUES
  ('8', '7', '7', '0', '证明我', '666', '游客1', '图片1', null, null, null, '0', '2018-10-05 23:16:12', '2018-10-05 23:16:12');
INSERT INTO `reply` VALUES
  ('9', '7', '7', '1', '', '666', '游客1', '图片1', '666', '图片1', '游客1', '0', '2018-10-05 23:36:29', '2018-10-05 23:36:29');
INSERT INTO `reply` VALUES
  ('10', '10', '10', '0', '膜拜楼主！', '666', '游客1', '图片1', null, null, null, '0', '2018-10-05 23:39:42',
   '2018-10-05 23:39:42');
INSERT INTO `reply` VALUES
  ('11', '10', '10', '1', '参拜层主！', '666', '游客1', '图片1', '666', '图片1', '游客1', '0', '2018-10-05 23:39:51',
   '2018-10-05 23:39:51');
INSERT INTO `reply` VALUES
  ('12', '10', '11', '1', '你也很喜', '666', '游客1', '图片1', '666', '图片1', '游客1', '0', '2018-10-05 23:40:00',
   '2018-10-05 23:40:00');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id`          int(11)      NOT NULL AUTO_INCREMENT,
  `username`    varchar(255) NOT NULL,
  `password`    varchar(255) NOT NULL,
  `nickname`    varchar(255) NOT NULL,
  `face_img`    varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `birthday`    date         NOT NULL,
  `create_time` timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 667
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user`
VALUES ('333', 'zhang456', 'asda', '游客2', '图片2', '巴拉拉', '2018-10-02', '2018-10-04 14:35:46', '2018-10-04 15:11:17');
INSERT INTO `user`
VALUES ('666', 'wang123', '123123', '游客1', '图片1', 'as', '2018-10-04', '2018-10-04 14:34:58', '2018-10-04 15:11:13');
