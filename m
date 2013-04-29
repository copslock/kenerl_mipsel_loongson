Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Apr 2013 10:45:52 +0200 (CEST)
Received: from blu0-omc4-s28.blu0.hotmail.com ([65.55.111.167]:7120 "EHLO
        blu0-omc4-s28.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821703Ab3D2IpudRe10 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 29 Apr 2013 10:45:50 +0200
Received: from BLU176-W15 ([65.55.111.136]) by blu0-omc4-s28.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 29 Apr 2013 01:45:45 -0700
X-EIP:  [eoL/k0M2aTHsWDBMH0ctmIgYxLfD9qlb]
X-Originating-Email: [programassem@hotmail.com]
Message-ID: <BLU176-W15FDDC553391B906C42E1AD2B20@phx.gbl>
From:   shawn Bai <programassem@hotmail.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     "baixy_009@163.com" <baixy_009@163.com>,
        "programassem@gmail.com" <programassem@gmail.com>
Subject: Confused on cache_op(op,addr) definition in r4kcache.h in linux
 source code v3.3.5
Date:   Mon, 29 Apr 2013 08:45:44 +0000
Importance: Normal
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginalArrivalTime: 29 Apr 2013 08:45:45.0083 (UTC) FILETIME=[F0402CB0:01CE44B5]
Return-Path: <programassem@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: programassem@hotmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hello, everyone,

    I'm very glag to have chance to communicate with you in this maling list.

    I'm involved in a SOC project making use of MIPS24K core.
    While learning the CACHE aspects in Linux kernel source code v3.3.5,  I found the macro definition for cache operations.

     It goes as:

#define cache_op(op,addr)                        \
    __asm__ __volatile__(                        \
    "    .set    push                    \n"    \
    "    .set    noreorder                \n"    \
    "    .set    mips3\n\t                \n"    \
    "    cache    %0, %1                    \n"    \
    "    .set    pop                    \n"    \
    :                                \
    : "i" (op), "R" (*(unsigned char *)(addr)))


  "i" (op)   as argument 0 in CACHE instruction,
  "R" (*(unsigned char *)(addr))   as argument 1 in CACHE instruction


  Further, on the other hand, the CACHE instruction in MIPS ISA is like this:

Format:      CACHE op, offset(base)

Purpose: Perform Cache Operation

To perform the cache operation specified by op.

  And as know,  depending on the  op field,   the offset(base) coud be understood accordingly for different meanings.

Well, after the context, here below is what makes me confused.

In the cache_op inline assembly,   
why "R" (*(unsigned char *)(addr))   is used as the argument 1 of CACHE instruction, instead of   "R" ((unsigned char *)(addr)) ?

the argument 1 numbered from 0  in CACHE instruction in MIPS ISA  should be a address with a offset,  but from the code,  it seems that the value in that address  is passed to CACHE instruction.

Could someone give some help on this?  
I really appreciate that.
Thanks in advance.




Best regards,
Shawn Bai 		 	   		  
From eunb.song@samsung.com Wed May  1 06:57:09 2013
Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 May 2013 06:57:15 +0200 (CEST)
Received: from mailout3.samsung.com ([203.254.224.33]:27598 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823043Ab3EAE5J2qPHG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 May 2013 06:57:09 +0200
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MM3005JISERTKA0@mailout3.samsung.com> for
 linux-mips@linux-mips.org; Wed, 01 May 2013 13:57:00 +0900 (KST)
Received: from epcpsbgx3.samsung.com ( [203.254.230.43])
        by epcpsbgr2.samsung.com (EPCPMTA) with SMTP id 3C.FA.19730.C90A0815; Wed,
 01 May 2013 13:57:00 +0900 (KST)
X-AuditID: cbfee68e-b7efa6d000004d12-5e-5180a09cbba1
Received: from epextmailer03 ( [203.254.219.153])
        by epcpsbgx3.samsung.com (EPCPMTA) with SMTP id 97.88.30122.C90A0815; Wed,
 01 May 2013 13:57:00 +0900 (KST)
Date:   Wed, 01 May 2013 04:57:00 +0000 (GMT)
From:   EUNBONG SONG <eunb.song@samsung.com>
Subject: mips; boot fail after merge 3.9+
To:     "ralf@linux-mips.org" <ralf@linux-mips.org>, tglx@linutronix.de,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-to: eunb.song@samsung.com
MIME-version: 1.0
X-MTR:  20130501041444208@eunb.song
Msgkey: 20130501041444208@eunb.song
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-EPTrCode: 
X-EPTrName: 
X-MLAttribute: 
X-RootMTR: 20130501041444208@eunb.song
X-ParentMTR: 
X-ArchiveUser: 
X-CPGSPASS: N
Content-transfer-encoding: base64
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <20522420.158691367384219315.JavaMail.weblogic@epml17>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42I5/e+Ztu6cBQ2BBjM+ylpMmDqJ3YHR4+jK
        tUwBjFFcNimpOZllqUX6dglcGSsu7GEueGJWMXnmZdYGxjWmXYycHEICKhIt/78zgtgSAiYS
        je1H2SFsMYkL99azQdQsY5RobDWHqVk8/TRQnAsoPp9RouPEE7BmFqBBK3t6wWw2AW2Jt18e
        sILYwgKaEnceHWIGaRARaGWUWH3mBlgRs4CjxKPLd5ghNshLTD59GWwzr4CgxMmZT1ggtilJ
        vNi9kBUirizx49NpJoi4hMSs6RdYIWxeiRntT6Hq5SSmfV3DDGFLS5yftYER5pvF3x9Dxfkl
        jt3eATSHA6z3yf1gmDG7N39hg7AFJKaeOQjVqi7RsmE6lM0nsWbhWxaYMbtOLWeG6b2/ZS4T
        xFuKElO6H7JD2FoSX37sY0P1FgeQ7STxY7nOBEblWUgys5B0z0LSjaxmASPLKkbR1ILkguKk
        9CIjveLE3OLSvHS95PzcTYyQxNC3g/HmAetDjMnAKJnILCWanA9MLHkl8YbGZkYWpiamxkbm
        lmakCSuJ86q1WAcKCaQnlqRmp6YWpBbFF5XmpBYfYmTi4JRqYLQKSm82F3g890Ldqb2N8pOn
        CH541rrmSVlYQ992m2297aHdxrrBaq8SN0xyijUrzDmqyqY5R1Aiwv+n8sylagv+vzdQM5/G
        ceuS9kGh7JU3VazVF4vIH2Bt1LT7aPCsYFfctvt67X5F+u85JDTVwxXtlR+Z5Zab+c1mUm1c
        727mcXQLazyXEktxRqKhFnNRcSIAccQFkSIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42I5/e/2TN05CxoCDS6ek7KYMHUSuwOjx9GV
        a5kCGKMybDJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA
        pioplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJWijQyM9YxMTfSMjA30TAxirQwNDIxMgaoS
        MjJWXNjDXPDErGLyzMusDYxrTLsYOTmEBFQkWv5/ZwSxJQRMJBZPP80GYYtJXLi3HsjmAqqZ
        zyjRceIJWBELUMPKnl4wm01AW+LtlwesILawgKbEnUeHmEEaRARaGSVWn7kBVsQs4Cjx6PId
        Zoht8hKTT19mB7F5BQQlTs58wgKxTUnixe6FrBBxZYkfn04zQcQlJGZNv8AKYfNKzGh/ClUv
        JzHt6xpmCFta4vysDYwwVy/+/hgqzi9x7PYOoDkcYL1P7gfDjNm9+QvUkwISU88chGpVl2jZ
        MB3K5pNYs/AtC8yYXaeWM8P03t8ylwniLUWJKd0P2SFsLYkvP/axoXqLA8h2kvixXGcCo9ws
        JJlZSLpnIelGVrOAkWUVo2hqQXJBcVJ6hbFecWJucWleul5yfu4mRnCSerZ4B+P/89aHGAU4
        GJV4eHdcqA8UYk0sK67MPcQowcGsJMLLMaUhUIg3JbGyKrUoP76oNCe1+BBjMjACJzJLiSbn
        AxNoXkm8obGBsaGhpbmBqaGRBWnCSuK8z1qtA4UE0hNLUrNTUwtSi2C2MHFwSjUwFmsdWWkx
        u+tMUuHmmrzDPdOePHycn/h7K4dZuIqt67qjGx0drhwvtL0prlxqceo8G9+So1vi7BkYTr7h
        PRz8QMbJOFTrstHES3ZWrU8Z3NtmBNTk2LKXJoVwfi7/f3ZD3FqnammXPZ5VQcfC9rF27Hxb
        u8ZnYft/hyzDhsYHc0JPi20qNHJWYinOSDTUYi4qTgQAwjjfcJYDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Return-Path: <eunb.song@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eunb.song@samsung.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

DQpIZWxsby4gDQpBZnRlciBtZXJnZSBjYXZpdW0gYm9hcmQgYm9vdHMgZmFpbCwgYm9vdCBsb2cg
bWVzc2FnZXMgYXJlIGFzIGZvbGxvd3MuDQpJIGVuYWJsZWQgaW5pdGNhbGxfZGVidWcgZm9yIGRl
YnVnZ2luZy4gDQoNClsgICAgMC4wMDAwMDBdIEluaXRpYWxpemluZyBjZ3JvdXAgc3Vic3lzIGNw
dXNldA0KWyAgICAwLjAwMDAwMF0gSW5pdGlhbGl6aW5nIGNncm91cCBzdWJzeXMgY3B1YWNjdA0K
WyAgICAwLjAwMDAwMF0gTGludXggdmVyc2lvbiAzLjkuMCsgKGVic29uZ0B1YmkpIChnY2MgdmVy
c2lvbiA0LjQuMSAoTW9udGFWaXN0YSBMaW51eCBHKysgNC40LTEzMDIwMTIxMzgpICkgIzIzIFNN
UCBQUkVFTVBUIFdlZCBNYXkgMSAxMzo0NzoyNSBLU1QgMjAxMw0KWyAgICAwLjAwMDAwMF0gb2N0
ZW9uX2Jvb3RpbmZvLT5kcmFtX3NpemU6IDQwMDANClsgICAgMC4wMDAwMDBdIEVuYWJsaW5nIHRh
ZDEgZXJyb3IgaW50ZXJydXB0DQpbICAgIDAuMDAwMDAwXSBFbmFibGluZyB0YWQyIGVycm9yIGlu
dGVycnVwdA0KWyAgICAwLjAwMDAwMF0gRW5hYmxpbmcgdGFkMyBlcnJvciBpbnRlcnJ1cHQNClsg
ICAgMC4wMDAwMDBdIENWTVNFRyBzaXplOiAyIGNhY2hlIGxpbmVzICgyNTYgYnl0ZXMpDQpbICAg
IDAuMDAwMDAwXSBDYXZpdW0gTmV0d29ya3MgU0RLLTIuMS4wLXA3IGJ1aWxkIDQ0Mg0KWyAgICAw
LjAwMDAwMF0gYm9vdGNvbnNvbGUgW2Vhcmx5MF0gZW5hYmxlZA0KWyAgICAwLjAwMDAwMF0gQ1BV
IHJldmlzaW9uIGlzOiAwMDBkOTEwMSAoQ2F2aXVtIE9jdGVvbiBJSSkNClsgICAgMC4wMDAwMDBd
IENoZWNraW5nIGZvciB0aGUgbXVsdGlwbHkvc2hpZnQgYnVnLi4uIG5vLg0KWyAgICAwLjAwMDAw
MF0gQ2hlY2tpbmcgZm9yIHRoZSBkYWRkaXUgYnVnLi4uIG5vLg0KWyAgICAwLjAwMDAwMF0gRGV0
ZXJtaW5lZCBwaHlzaWNhbCBSQU0gbWFwOg0KWyAgICAwLjAwMDAwMF0gIG1lbW9yeTogMDAwMDAw
MDAwNmMwMDAwMCBAIDAwMDAwMDAwMDExMDAwMDAgKHVzYWJsZSkNClsgICAgMC4wMDAwMDBdICBt
ZW1vcnk6IDAwMDAwMDAwMDdjMDAwMDAgQCAwMDAwMDAwMDA4MjAwMDAwICh1c2FibGUpDQpbICAg
IDAuMDAwMDAwXSAgbWVtb3J5OiAwMDAwMDAwMDExODAwMDAwIEAgMDAwMDAwMDAzMDAwMDAwMCAo
dXNhYmxlKQ0KWyAgICAwLjAwMDAwMF0gIG1lbW9yeTogMDAwMDAwMDAwMGY4NTc0MCBAIDAwMDAw
MDAwMDAxMDAwMDAgKHVzYWJsZSkNClsgICAgMC4wMDAwMDBdIFdhc3RpbmcgMTQzMzYgYnl0ZXMg
Zm9yIHRyYWNraW5nIDI1NiB1bnVzZWQgcGFnZXMNClsgICAgMC4wMDAwMDBdIEluaXRyZCBub3Qg
Zm91bmQgb3IgZW1wdHkgLSBkaXNhYmxpbmcgaW5pdHJkDQpbICAgIDAuMDAwMDAwXSBzb2Z0d2Fy
ZSBJTyBUTEIgW21lbSAweDAxYjhhMDAwLTB4MDFiY2EwMDBdICgwTUIpIG1hcHBlZCBhdCBbYTgw
MDAwMDAwMWI4YTAwMC1hODAwMDAwMDAxYmM5ZmZmXQ0KWyAgICAwLjAwMDAwMF0gWm9uZSByYW5n
ZXM6DQpbICAgIDAuMDAwMDAwXSAgIERNQTMyICAgIFttZW0gMHgwMDEwMDAwMC0weGVmZmZmZmZm
XQ0KWyAgICAwLjAwMDAwMF0gICBOb3JtYWwgICBlbXB0eQ0KWyAgICAwLjAwMDAwMF0gTW92YWJs
ZSB6b25lIHN0YXJ0IGZvciBlYWNoIG5vZGUNClsgICAgMC4wMDAwMDBdIEVhcmx5IG1lbW9yeSBu
b2RlIHJhbmdlcw0KWyAgICAwLjAwMDAwMF0gICBub2RlICAgMDogW21lbSAweDAwMTAwMDAwLTB4
MDEwODRmZmZdDQpbICAgIDAuMDAwMDAwXSAgIG5vZGUgICAwOiBbbWVtIDB4MDExMDAwMDAtMHgw
N2NmZmZmZl0NClsgICAgMC4wMDAwMDBdICAgbm9kZSAgIDA6IFttZW0gMHgwODIwMDAwMC0weDBm
ZGZmZmZmXQ0KWyAgICAwLjAwMDAwMF0gICBub2RlICAgMDogW21lbSAweDMwMDAwMDAwLTB4NDE3
ZmZmZmZdDQpbICAgIDAuMDAwMDAwXSBDYXZpdW0gSG90cGx1ZzogQXZhaWxhYmxlIGNvcmVtYXNr
IDB4ZmZmZmZmMDANClsgICAgMC4wMDAwMDBdIFByaW1hcnkgaW5zdHJ1Y3Rpb24gY2FjaGUgMzdr
QiwgdmlydHVhbGx5IHRhZ2dlZCwgMzcgd2F5LCA4IHNldHMsIGxpbmVzaXplIDEyOCBieXRlcy4N
ClsgICAgMC4wMDAwMDBdIFByaW1hcnkgZGF0YSBjYWNoZSAzMmtCLCAzMi13YXksIDggc2V0cywg
bGluZXNpemUgMTI4IGJ5dGVzLg0KWyAgICAwLjAwMDAwMF0gUEVSQ1BVOiBFbWJlZGRlZCAxMSBw
YWdlcy9jcHUgQGE4MDAwMDAwMDFiZWIwMDAgczEyODAwIHI4MTkyIGQyNDA2NCB1NDUwNTYNClsg
ICAgMC4wMDAwMDBdIEJ1aWx0IDEgem9uZWxpc3RzIGluIFpvbmUgb3JkZXIsIG1vYmlsaXR5IGdy
b3VwaW5nIG9uLiAgVG90YWwgcGFnZXM6IDEzMzE5OA0KWyAgICAwLjAwMDAwMF0gS2VybmVsIGNv
bW1hbmQgbGluZTogIHJvb3Q9L2Rldi9uZnMgcncgbmZzcm9vdD0xNjUuMjEzLjE3Ni4xNDU6L2hv
bWUvZWJzb25nL3Byb2plY3QvcHJlc21iL2FwYy9Qa2cvbmZzcm9vdC93ZWM4NTAwIGlwPTE2NS4y
MTMuMTc2LjEwODoxNjUuMjEzLjE3Ni4xNDU6MTY1LjIxMy4xNzYuMToyNTUuMjU1LjI1NS4wOjpt
Z210MCBjb25zb2xlPXR0eVMwLDExNTIwMA0KWyAgICAwLjAwMDAwMF0gUElEIGhhc2ggdGFibGUg
ZW50cmllczogNDA5NiAob3JkZXI6IDMsIDMyNzY4IGJ5dGVzKQ0KWyAgICAwLjAwMDAwMF0gRGVu
dHJ5IGNhY2hlIGhhc2ggdGFibGUgZW50cmllczogMTMxMDcyIChvcmRlcjogOCwgMTA0ODU3NiBi
eXRlcykNClsgICAgMC4wMDAwMDBdIElub2RlLWNhY2hlIGhhc2ggdGFibGUgZW50cmllczogNjU1
MzYgKG9yZGVyOiA3LCA1MjQyODggYnl0ZXMpDQpbICAgIDAuMDAwMDAwXSBNZW1vcnk6IDUxMDE2
MGsvNTQwMTgwayBhdmFpbGFibGUgKDU4MTFrIGtlcm5lbCBjb2RlLCAzMDAyMGsgcmVzZXJ2ZWQs
IDg5MzNrIGRhdGEsIDI5MmsgaW5pdCwgMGsgaGlnaG1lbSkNClsgICAgMC4wMDAwMDBdIFByZWVt
cHRpYmxlIGhpZXJhcmNoaWNhbCBSQ1UgaW1wbGVtZW50YXRpb24uDQpbICAgIDAuMDAwMDAwXSBO
Ul9JUlFTOjQ1Mw0KWyAgICAwLjAwMDAwMF0gQ29uc29sZTogY29sb3VyIGR1bW15IGRldmljZSA4
MHgyNQ0KWyAgIDI2LjcwMTE2N10gQ2FsaWJyYXRpbmcgZGVsYXkgbG9vcCAoc2tpcHBlZCkgcHJl
c2V0IHZhbHVlLi4gMjQwMC4wMCBCb2dvTUlQUyAobHBqPTEyMDAwMDAwKQ0KWyAgIDI2LjcwOTUw
N10gcGlkX21heDogZGVmYXVsdDogMzI3NjggbWluaW11bTogMzAxDQpbICAgMjYuNzE0MTYyXSBT
ZWN1cml0eSBGcmFtZXdvcmsgaW5pdGlhbGl6ZWQNClsgICAyNi43MTgyMThdIE1vdW50LWNhY2hl
IGhhc2ggdGFibGUgZW50cmllczogMjU2DQpbICAgMjYuNzIzMzk4XSBJbml0aWFsaXppbmcgY2dy
b3VwIHN1YnN5cyBkZXZpY2VzDQpbICAgMjYuNzI3NjY5XSBJbml0aWFsaXppbmcgY2dyb3VwIHN1
YnN5cyBmcmVlemVyDQpbICAgMjYuNzMyMTMxXSBDaGVja2luZyBmb3IgdGhlIGRhZGRpIGJ1Zy4u
LiBuby4NClsgICAyNi43MzY2MDddIGNhbGxpbmcgIGNubWlwc19jdTJfc2V0dXArMHgwLzB4YyBA
IDENClsgICAyNi43NDExMzldIGluaXRjYWxsIGNubWlwc19jdTJfc2V0dXArMHgwLzB4YyByZXR1
cm5lZCAwIGFmdGVyIDAgdXNlY3MNClsgICAyNi43NDc2NTldIGNhbGxpbmcgIHNwYXduX2tzb2Z0
aXJxZCsweDAvMHgzNCBAIDENCg0KSSBmb3VuZCB0aGlzIGlzc3VlIGFmdGVyIGNkYmVkYzYxYzhk
MDEyMmFkNjgyODE1OTM2ZjBkMTFkZjFmZTVmNTcuIA0KQW5kIGkgZm91bmQgc29tZXRoaW5nIHN0
cmFuZ2UuIEkgcmFuIHRoZSBnaXQgc2hvdyBmb3IgdGhpcyBjb21taXQuDQpBcyBiZWxvdyAic2Vs
ZWN0IEdFTkVSSUNfSURMRV9MT09QIiBpcyBhZGRlZCBmb3IgQ09ORklHX01JUFMuIA0KYnV0IHRo
ZSBsYXRlc3QgYXJjaC9taXBzL0tjb25maWcgZmlsZSBoYXMgbm90IHRoaXMgb25lLiBJIGhhdmUg
dHJpZWQgdG8gZmluZCB3aGVuIHRoaXMgaXMgZ29uZS4gYnV0IGkgY2FuJ3QgZmluZC4NCklzIHRo
ZXJlIGFueSBwcm9ibGVtIHdpdGggdGhpcz8gDQoNCg0KY29tbWl0IGNkYmVkYzYxYzhkMDEyMmFk
NjgyODE1OTM2ZjBkMTFkZjFmZTVmNTcNCkF1dGhvcjogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxp
bnV0cm9uaXguZGU+DQpEYXRlOiAgIFRodSBNYXIgMjEgMjI6NDk6NTIgMjAxMyArMDEwMA0KDQog
ICAgbWlwczogVXNlIGdlbmVyaWMgaWRsZSBsb29wDQoNCiAgICBTaWduZWQtb2ZmLWJ5OiBUaG9t
YXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCiAgICBDYzogTGludXMgVG9ydmFsZHMg
PHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KICAgIENjOiBSdXN0eSBSdXNzZWxsIDxy
dXN0eUBydXN0Y29ycC5jb20uYXU+DQogICAgQ2M6IFBhdWwgTWNLZW5uZXkgPHBhdWxtY2tAbGlu
dXgudm5ldC5pYm0uY29tPg0KICAgIENjOiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVh
ZC5vcmc+DQogICAgUmV2aWV3ZWQtYnk6IENjOiBTcml2YXRzYSBTLiBCaGF0IDxzcml2YXRzYS5i
aGF0QGxpbnV4LnZuZXQuaWJtLmNvbT4NCiAgICBDYzogTWFnbnVzIERhbW0gPG1hZ251cy5kYW1t
QGdtYWlsLmNvbT4NCiAgICBDYzogUmFsZiBCYWVjaGxlIDxyYWxmQGxpbnV4LW1pcHMub3JnPg0K
ICAgIExpbms6IGh0dHA6Ly9sa21sLmtlcm5lbC5vcmcvci8yMDEzMDMyMTIxNTIzNC43NTQ5NTQ4
NzFAbGludXRyb25peC5kZQ0KICAgIFNpZ25lZC1vZmYtYnk6IFRob21hcyBHbGVpeG5lciA8dGds
eEBsaW51dHJvbml4LmRlPg0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9taXBzL0tjb25maWcgYi9hcmNo
L21pcHMvS2NvbmZpZw0KaW5kZXggNTEyNDRiZi4uZTFhM2QwMiAxMDA2NDQNCi0tLSBhL2FyY2gv
bWlwcy9LY29uZmlnDQorKysgYi9hcmNoL21pcHMvS2NvbmZpZw0KQEAgLTM0LDYgKzM0LDcgQEAg
Y29uZmlnIE1JUFMNCiAgICAgICAgc2VsZWN0IEhBVkVfTUVNQkxPQ0tfTk9ERV9NQVANCiAgICAg
ICAgc2VsZWN0IEFSQ0hfRElTQ0FSRF9NRU1CTE9DSw0KICAgICAgICBzZWxlY3QgR0VORVJJQ19T
TVBfSURMRV9USFJFQUQNCisgICAgICAgc2VsZWN0IEdFTkVSSUNfSURMRV9MT09QDQogICAgICAg
IHNlbGVjdCBCVUlMRFRJTUVfRVhUQUJMRV9TT1JUDQogICAgICAgIHNlbGVjdCBHRU5FUklDX0NM
T0NLRVZFTlRTDQogICAgICAgIHNlbGVjdCBHRU5FUklDX0NNT1NfVVBEQVRFDQo=
