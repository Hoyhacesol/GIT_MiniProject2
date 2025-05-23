drop table community;
drop table webzine;
drop table sitemember;

commit;

CREATE TABLE Sitemember (    -- 사이트 회원 테이블 생성 
    uno        NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,     -- 사이트 회원 식별번호(기본키,자동생성)
    email      VARCHAR(100) NOT NULL UNIQUE,       -- 이메일(유니크)
    pw         VARCHAR(20) NOT NULL,            -- 비밀번호
    nickname   VARCHAR(40) NOT NULL UNIQUE,      -- 닉네임(유니크)
    name       VARCHAR(20) NOT NULL,               -- 이름
    joindate   DATE DEFAULT CURRENT_DATE,         -- 가입날짜(기본값:현재날짜)
    usertype   NUMBER DEFAULT 1                       -- 유저분류(기본값:1, 기자:2, 운영자:3)
);

-- Webzine 테이블 (웹진 게시글)
CREATE TABLE Webzine (   -- 웹진 테이블 생성
    wno          NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,   -- 웹진 고유번호(기본키,자동생성)
    wtitle       VARCHAR(200) NOT NULL,         -- 기사 제목
    wtext        VARCHAR(4000) NOT NULL,        -- 기사 내용
    wwdate       DATE DEFAULT CURRENT_DATE,         -- 기사 작성일
    wviewcount   NUMBER DEFAULT 0,                   -- 조회수
   wofile  VARCHAR(500),               -- 첨부 원본파일명
    wsfile  VARCHAR(500),               -- 첨부 실제 저장파일명
    uno     NUMBER,                               -- 작성자 회원 식별번호(sitemember의 uno을 참조하는 외래 키)
    FOREIGN KEY (uno) REFERENCES Sitemember(uno) ON DELETE SET NULL
);

-- Community 테이블 (커뮤니티 게시글)
CREATE TABLE Community (   -- 게시판 테이블 생성   
    cno         NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,    -- 게시글 고유번호(기본키,자동생성)
    ctitle      VARCHAR(200) NOT NULL,        -- 게시글 제목
    ctext       VARCHAR(4000) NOT NULL,         -- 게시글 내용
    cwdate      DATE DEFAULT CURRENT_DATE,      -- 게시글 작성일
    cviewcount  NUMBER DEFAULT 0,               -- 게시글 조회수
    cwuser      VARCHAR(45) NOT NULL,           -- 게시글 작성자(작성시 설정,닉네임 아닌것에 주의)
    cpw         VARCHAR(50) NOT NULL,         --  게시글 비밀번호
    cofile  VARCHAR(500),                        --게시글 첨부 원본파일명
    csfile  VARCHAR(500),                        --게시글 첨부 실제저장파일명
	ctype  number default 1 						--게시글 유형(기본값1, 공지사항5)
);

CREATE TABLE Comments (   -- 댓글 테이블 생성 
    rno      NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,    -- 댓글 고유번호(기본키,자동생성)
    rwuser   VARCHAR(45) NOT NULL,        -- 댓글 작성자
    rpw      VARCHAR(50) NOT NULL,         -- 댓글 비밀번호
    rtext    VARCHAR(4000) NOT NULL,      -- 댓글 내용
    rwdate   DATE DEFAULT CURRENT_DATE,               -- 댓글 작성일
    cno     NUMBER,                               -- 댓글이 달린 게시글 번호 
    FOREIGN KEY (cno) REFERENCES Community(cno) ON DELETE SET NULL  
);



//더미 기사
INSERT INTO WEBZINE (WTITLE,WTEXT,WWDATE,WVIEWCOUNT,WOFILE,WSFILE,UNO)
VALUES('제주도에서 즐기는 다섯가지 특별한 섬 이야기',
'<img src="/Weekend/Uploads/testimg01.jpg" alt="image alt text" contenteditable="false">제주도에 가면 맛있는 먹거리와 시원한 해안도로를 달려보거나 둘레길을 걷는 즐거움을 가질 수 있다.'
,TO_DATE('2025-01-01', 'YYYY-MM-DD'),402,'jeju','testimg01.jpg',11);

INSERT INTO WEBZINE (WTITLE,WTEXT,WWDATE,WVIEWCOUNT,WOFILE,WSFILE,UNO)
VALUES('[정동현 셰프의 음식을 쓰다] 이탈리아 여행 대신, 서울 이탈리안 레스토랑 BEST3',
'<p>이탈리아에서 처음 먹은 파스타는 볼로네제 파스타였다. 세계에서 가장 오래된 볼로냐 대학이 있는 그 볼로냐에서 유래한 볼로네제 파스타는 흔히 ‘미트소스’라고도 불린다. 만드는 방법을 요약하면 고기와 양파, 당근 등을 볶고 토마토를 넣어 푹 우려낸다고 보면 된다.</p>
<p>볼로네제 파스타는 몇백만에 달했던 미국 이탈리아 이민자들을 통해 전 세계로 퍼졌다. 토마토, 치즈, 고기의 조합은 감칠맛을 폭발적으로 끌어냈다. 여기에 파스타를 버무리면 동양이든 서양이든 어디서나 친숙한 ‘면 요리’가 된다. 미국에 널리 퍼진 볼로네제 파스타는 해방과 6.25를 거친 한국에도 미군 부대를 통해 상륙했다. 풍요로운 미국에서 소스와 고기는 흥건해졌고 한국에 와서는 파스타를 국수처럼 푹 익혀냈다.
이탈리아에서 먹은 볼로네제 파스타는 약간 실망스러웠다. 소스에 감칠맛이 엄청나게 나지도 않았고, 고기의 질도 좋지 않았다. 허브도 살짝, 소스도 살짝, 파스타를 비빌 정도로만 나왔다. 다른 파스타들도 마찬가지였다. 인당 한 접시씩 먹는 파스타의 양은 밥 세 공기 정도 되는데 소스는 간장 종지 정도 되는 분량이었다. 파스타 면은 뻑뻑하고 간은 강하며 양도 많아 도저히 완식할 수 없을 때도 잦았다.</p>'
,TO_DATE('2025-01-02', 'YYYY-MM-DD'),601,'p01','testimg02.png',12);

INSERT INTO WEBZINE (WTITLE,WTEXT,WWDATE,WVIEWCOUNT,WOFILE,WSFILE,UNO)
VALUES('비수기 사라진 도쿄…배짱 영업에 랜드사 고충만 커져',
'<p><img src="/Weekend/Uploads/testimg03.jpg" alt="image alt text" contenteditable="false">일본여행 수요가 지속되면서 현지 업체들의&nbsp;막무가내식 요금 인상 등으로 랜드사의 고충이 커지고 있다.&nbsp;특히 도쿄에서 두드러진다는 하소연이다.</p><p><br></p><p><br></p><p>관련 업계에 따르면 올해 일본 벚꽃 시즌 후 비수기가 사라졌다. 일본 홋카이도를 제외한 혼슈, 시코쿠, 규슈 지역의 벚꽃 개화시기는 3월20일 전후로, 벚꽃 시즌 성수기는 4월 첫 주까지 형성되는 게 일반적이다. 이후 일본 학교의 봄방학도 끝나 골든 위크(4월 말) 전까지 약 3주간 비수기로 접어드는 게 전통적인 흐름이었다. 하지만&nbsp;올해는 골든 위크와 더불어 한국의 5월 황금연휴 때까지 성수기 요금이 적용돼&nbsp;어려움을 토로하는 현지 랜드사들이 부쩍 늘었다.</p><p><br></p><p>A 일본 전문 랜드사 관계자는 “현지 호텔들은 B2B 공급가를 매년 공시해 왔으나 지난해부터는 가동률에 따라 요금을 적용하기 시작했다”라며 “벚꽃 시즌에는 가격이 오르는 게 맞지만, 4월 중순에도 가격이 떨어지지 않아 난처한 상황"이라고 전했다. 또 "오사카는 엑스포 특수 여파라고 보더라도, 도쿄의 경우 시내 비즈니스호텔 요금이 전년대비 2배에 달하는 건 도저히 이해할 수 없다”라고 꼬집었다. “호텔 직통전화가 사라지고 메일로 문의·응대하다 보니 이유를 깊게 물어볼 수도 없고, 송출 여행사의 견적요청에 즉각적으로 답변하기도&nbsp;어려워졌다”고 여러&nbsp;어려움도 토로했다.</p>'
,TO_DATE('2025-01-05', 'YYYY-MM-DD'),312,'p02','testimg03.jpg',13);

INSERT INTO WEBZINE (WTITLE,WTEXT,WWDATE,WVIEWCOUNT,WOFILE,WSFILE,UNO)
VALUES('푸른 보리잎이 봄을 알리는 가파도에서 청보리 향을 느껴보세요',
'<p><img src="/Weekend/Uploads/testimg04.png" alt="image alt text" contenteditable="false"><br></p><p>가파도 청보리의 품종향맥은 타 지역보다 2배이상 자라는 제주의 향토 품종으로 전국에서 가장 먼저 높고 푸르게 자라나 해마다 봄이되면 18만여평의 청보리 밭 위로 푸른 물결이 굽이치는 장관을 이룬다. 청보리가 절정을 이루는 4월에 가파도청보리축제에서 청보리 밭 올레길 걷기, 소라 보물찾기, 소망 연날리기, 가파도만의 특산물을 체험해볼 수 있다.</p><p><br></p>'
,TO_DATE('2025-01-07', 'YYYY-MM-DD'),602,'p03','testimg04.jpg',3);

INSERT INTO WEBZINE (WTITLE,WTEXT,WWDATE,WVIEWCOUNT,WOFILE,WSFILE,UNO)
VALUES('서울 4대궁 야간 개장 기간 및 예약 방법',
'<p><img src="/Weekend/Uploads/testimg05.jpg" alt="image alt text" contenteditable="false"><br></p><p>서울의 밤을 아름답게 수놓는 잊지 못할 순간!</p><p>4대궁 야간개장이 돌아왔습니다🌙</p><p><br></p><p>달빛 아래 펼쳐지는 특별한 궁투어를 소개합니다.</p><p>덕수궁은 고종이 황제로 즉위한 뒤</p><p>대한제국의 황궁으로 사용된 궁궐이에요.</p><p><br></p><p>​황궁에 걸맞은 위엄과 격식을 갖추기 위해</p><p>궁궐 안에는 서양식 건물이 들어서기 시작했고</p><p>그 결과 전통 한옥과 서양식 건축이 조화를 이루는</p><p>독특한 모습을 간직한 궁궐이 되었답니다.</p><p><br></p><p>4월 8일(화)부터 5월 25일(일)까지는</p><p>덕수궁 밤의 석조전이 진행될 예정입니다💡</p><p><br></p><p>​해설과 함께 석조전 내부를 둘러보고</p><p>2층 테라스에서 야경과 가배를 즐길 수 있는 시간이</p><p>마련되어 있으니 꼭 참여해 보세요!</p>'
,TO_DATE('2025-01-09', 'YYYY-MM-DD'),1013,'p04','testimg05.jpg',4);

INSERT INTO WEBZINE (WTITLE,WTEXT,WWDATE,WVIEWCOUNT,WOFILE,WSFILE,UNO)
VALUES('제주 유채꽃 명소, 봄나들이 가볼 만한 곳 3',
'<p><img src="/Weekend/Uploads/testimg06.jpg" alt="image alt text" contenteditable="false"><br></p><p>따뜻한 기온 덕분에</p><p>제주도는 다른 지역보다 이르게 봄을 맞이합니다.</p><p>특히, 만개한 유채꽃은 섬을 노랗게 물들여</p><p>아름다운 풍경을 만들어내는데요.</p><p>제주도에서 향기로운 감동을 선사하는</p><p>유채꽃 명소 3곳을 소개합니다.</p><p><br></p><p>1.가파도</p><p>가파도는 국토 최남단 마라도와 제주도 사이 위치한 섬으로</p><p>유채꽃과 청보리를 함께 감상할 수 있습니다.</p><p><br></p><p>2.서우봉</p><p>서우봉은 제주도 북쪽에 위치한 기생화산입니다.</p><p>이곳은 바다 조망과 함께 즐길 수 있는</p><p>유채꽃을 보기 위해 많은 여행객들이 찾는 곳인데요.</p><p>에메랄드 빛깔의 함덕해수욕장과</p><p>나란히 보이는 유채꽃은 더욱 아름답습니다.</p><p><br></p><p>3.성산유채꽃재배단지</p><p>성산유채꽃재배단지는</p><p>광치기 해변을 따라 조성되어 있습니다.</p><p>이곳은 다른 지역보다 일찍 꽃이 피어</p><p>이른 봄의 정취를 만끽하기 좋은 명소인데요.</p><p>바람에 일렁이는 노란 물결을</p><p>바라보고 있는 것만으로 힐링이 된답니다.</p>'
,TO_DATE('2025-01-11', 'YYYY-MM-DD'),712,'p05','testimg06.jpg',5);

commit;




