Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 May 2013 08:31:12 +0200 (CEST)
Received: from mailout3.samsung.com ([203.254.224.33]:9813 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816022Ab3EGGbDnpHXs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 May 2013 08:31:03 +0200
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMF00DP70QM5VA0@mailout3.samsung.com> for
 linux-mips@linux-mips.org; Tue, 07 May 2013 15:30:54 +0900 (KST)
Received: from epcpsbgx1.samsung.com ( [203.254.230.45])
        by epcpsbgr4.samsung.com (EPCPMTA) with SMTP id DB.3D.04074.E9F98815; Tue,
 07 May 2013 15:30:54 +0900 (KST)
X-AuditID: cbfee690-b7f136d000000fea-35-51889f9e9536
Received: from epextmailer02 ( [203.254.219.152])
        by epcpsbgx1.samsung.com (EPCPMTA) with SMTP id EC.11.25608.E9F98815; Tue,
 07 May 2013 15:30:54 +0900 (KST)
Date:   Tue, 07 May 2013 06:30:54 +0000 (GMT)
From:   EUNBONG SONG <eunb.song@samsung.com>
Subject: MIPS: Test reault for  enable interrupts before WAIT instruction patch
To:     "david.daney@cavium.com" <david.daney@cavium.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "jogo@openwrt.org" <jogo@openwrt.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>, manuel.lauss@gmail.com
Reply-to: eunb.song@samsung.com
MIME-version: 1.0
X-MTR:  20130507061510134@eunb.song
Msgkey: 20130507061510134@eunb.song
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-EPTrCode: 
X-EPTrName: 
X-MLAttribute: 
X-RootMTR: 20130507061510134@eunb.song
X-ParentMTR: 
X-ArchiveUser: 
X-CPGSPASS: N
Content-transfer-encoding: base64
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <15709790.301941367908253064.JavaMail.weblogic@epml12>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsVy+t8zXd158zsCDY7+NbaYMHUSuwOjx9GV
        a5kCGKO4bFJSczLLUov07RK4Mv61rGMsOKBf0bblHXMD4wK9LkZODiEBFYmW/98ZQWwJAROJ
        Kzv6mSBsMYkL99azdTFyAdUsY5To+beaGaboQdtMRojEfEaJDfP2sYMkWIAmbfp+mBXEZhPQ
        lnj75QGYLSzgLzF/cxcLSIOIwFUmiSuXFrBDrJaXmHz6MpjNKyAocXLmExaIDUoSt24dBFrN
        ARRXlrh63QoiLCExa/oFVgibV2JG+1OocjmJaV/XQB0nLXF+1gZGmA8Wf38MFeeXOHZ7BxPI
        SJDeJ/eDYcbs3vyFDcIWkJh65iBUq7rEgT9roWw+iTUL37LAjNl1ajkzTO/9LXPBgcUsoCgx
        pfshO4StJfHlxz42dF/xCjhJnP3TBzVzKofErSm6ExiVZiEpm4Vk1Cwko5DVLGBkWcUomlqQ
        XFCclF5kolecmFtcmpeul5yfu4kRkhom7GC8d8D6EGMyMEomMkuJJucDU0teSbyhsZmRhamJ
        qbGRuaUZacJK4rzqLdaBQgLpiSWp2ampBalF8UWlOanFhxiZODilGhjTL2b725od1tjSqnp4
        QdA+waN5X+Ukhe9YbFD/4Wgh0uO3n8VAIk5rRtmMz6cCty7hn1Gw1ir5bMS6G3P5X8/sOHal
        f1vXUke7b5peS3V5FOwvS3akhPy3tBT8eTFvly2Pr8mOeYriEtvCNtxbLxvDsJ1r7cV97XbX
        4qumbO/nFrFfekT2Wq8SS3FGoqEWc1FxIgAFsvpCIwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsVy+t/tGbrz5ncEGqy4YmAxYeokdgdGj6Mr
        1zIFMEZl2GSkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA
        TVVSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CpFGxkY6xmZmugZGRvomRjEWhkaGBiZAlUl
        ZGT8a1nHWHBAv6JtyzvmBsYFel2MnBxCAioSLf+/M4LYEgImEg/aZkLZYhIX7q1n62LkAqqZ
        zyixYd4+dpAEC1DDpu+HWUFsNgFtibdfHoDZwgL+EvM3d7GANIgIXGWSuHJpATvEBnmJyacv
        g9m8AoISJ2c+YYHYoCRx69ZBoA0cQHFliavXrSDCEhKzpl9ghbB5JWa0P4Uql5OY9nUNM4Qt
        LXF+1ga4Qxd/fwwV55c4dnsHE8hIkN4n94Nhxuze/IUNwhaQmHrmIFSrusSBP2uhbD6JNQvf
        ssCM2XVqOTNM7/0tc5lAbGYBRYkp3Q/ZIWwtiS8/9rGh+4pXwEni7J8+xgmMsrOQpGYhaZ+F
        pB1ZzQJGllWMoqkFyQXFSekVhnrFibnFpXnpesn5uZsYwcno2cIdjF/OWx9iFOBgVOLhVTjV
        HijEmlhWXJl7iFGCg1lJhFdauyNQiDclsbIqtSg/vqg0J7X4EGMyMNImMkuJJucDE2VeSbyh
        sYGxoaGluYGpoZEFacJK4rxPW60DhQTSE0tSs1NTC1KLYLYwcXBKNTAa3maYuPX7o7bDV7f4
        z/xW+lJe/nUpd9u5RQ5RRrMP3nzrc1jfscR4n3HHTadYaU8DtzfsLG80mriW30t/16BisXTO
        HofdK6783a4U1MjL/+CE5aR3qwKmff2pPIGl5e+tO7bMB+p+l/NwrTh9Y/H9lcknfCfOm7v5
        V9+2QzXuB2M3Ofdvlt58VomlOCPRUIu5qDgRAE6Z2MaKAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Return-Path: <eunb.song@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36334
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

DQpIZWxsby4gSSAgdGVzdGVkIHdpdGggdHdvIHBhdGNoZXMuDQpUaGUgZmlyc3Qgb25lIGlzIHRo
b21hcyBnbGVpeG5lcidzIHBhdGNoLiBUaGUgcGF0Y2ggaXMgYXMgZm9sbG93Lg0KVGhpcyBwYXRj
aCB3b3JrcyB3ZWxsIHdpdGhvdXQgYW55IHByb2JsZW0uDQoNCkluZGV4OiBsaW51eC0yLjYvYXJj
aC9taXBzL2tlcm5lbC9wcm9jZXNzLmMNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCi0tLSBsaW51eC0yLjYub3JpZy9h
cmNoL21pcHMva2VybmVsL3Byb2Nlc3MuYw0KKysrIGxpbnV4LTIuNi9hcmNoL21pcHMva2VybmVs
L3Byb2Nlc3MuYw0KQEAgLTUwLDEzICs1MCwxOCBAQCB2b2lkIGFyY2hfY3B1X2lkbGVfZGVhZCh2
b2lkKQ0KIH0NCiAjZW5kaWYNCg0KLXZvaWQgYXJjaF9jcHVfaWRsZSh2b2lkKQ0KK3N0YXRpYyB2
b2lkIHNtdGNfaWRsZV9ob29rKHZvaWQpDQogew0KICNpZmRlZiBDT05GSUdfTUlQU19NVF9TTVRD
DQogICAgICAgIGV4dGVybiB2b2lkIHNtdGNfaWRsZV9sb29wX2hvb2sodm9pZCk7DQotDQogICAg
ICAgIHNtdGNfaWRsZV9sb29wX2hvb2soKTsNCiAjZW5kaWYNCit9DQorDQordm9pZCBhcmNoX2Nw
dV9pZGxlKHZvaWQpDQorew0KKyAgICAgICBsb2NhbF9pcnFfZW5hYmxlKCk7DQorICAgICAgIHNt
dGNfaWRsZV9ob29rKCk7DQogICAgICAgIGlmIChjcHVfd2FpdCkNCiAgICAgICAgICAgICAgICAo
KmNwdV93YWl0KSgpOw0KICAgICAgICBlbHNlDQotLQ0KDQpUaGUgc2Vjb25kIG9uZSBpcyBkYXZp
ZCBkYW5leSdzIHBhdGNoLiAgVGhlIHBhdGNoIGlzIGFzIGZvbGxvdy4gDQphcmNoL21pcHMva2Vy
bmVsL2dlbmV4LlMgfCA3ICsrKystLS0NCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9taXBzL2tlcm5lbC9nZW5leC5T
IGIvYXJjaC9taXBzL2tlcm5lbC9nZW5leC5TDQppbmRleCBlY2IzNDdjLi41N2NkYTlhIDEwMDY0
NA0KLS0tIGEvYXJjaC9taXBzL2tlcm5lbC9nZW5leC5TDQorKysgYi9hcmNoL21pcHMva2VybmVs
L2dlbmV4LlMNCkBAIC0xMzIsMTIgKzEzMiwxMyBAQCBMRUFGKHI0a193YWl0KQ0KICAgICAgICAu
c2V0ICAgIG5vcmVvcmRlcg0KICAgICAgICAvKiBzdGFydCBvZiByb2xsYmFjayByZWdpb24gKi8N
CiAgICAgICAgTE9OR19MICB0MCwgVElfRkxBR1MoJDI4KQ0KLSAgICAgICBub3ANCiAgICAgICAg
YW5kaSAgICB0MCwgX1RJRl9ORUVEX1JFU0NIRUQNCiAgICAgICAgYm5leiAgICB0MCwgMWYNCiAg
ICAgICAgIG5vcA0KLSAgICAgICBub3ANCi0gICAgICAgbm9wDQorICAgICAgIC8qIEVuYWJsZSBp
bnRlcnJ1cHRzIHNvIFdBSVQgd2lsbCBjb21wbGV0ZSAqLw0KKyAgICAgICBtZmMwICAgIHQwLCBD
UDBfU1RBVFVTDQorICAgICAgIG9yaSAgICAgdDAsIFNUMF9JRQ0KKyAgICAgICBtdGMwICAgIHQw
LCBDUDBfU1RBVFVTDQogICAgICAgIC5zZXQgICAgbWlwczMNCiAgICAgICAgd2FpdA0KICAgICAg
ICAvKiBlbmQgb2Ygcm9sbGJhY2sgcmVnaW9uICh0aGUgcmVnaW9uIHNpemUgbXVzdCBiZSBwb3dl
ciBvZiB0d28pICovDQoNCkFmdGVyIGFwcGx5IHRoaXMgcGF0Y2guIEkgZ290IHR3byBlcnJvciBt
ZXNzYWdlLiANClRoZSBmaXJzdCBvbmUgaXMgYXMgZm9sbG93DQpbICAxMjQuNjYxMjExXSBDaGVj
a2luZyBmb3IgdGhlIGRhZGRpIGJ1Zy4uLiBuby4NClsgIDEyNC42NjU3MzddIC0tLS0tLS0tLS0t
LVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KWyAgMTI0LjY3MDE4N10gV0FSTklORzogYXQga2Vy
bmVsL2NwdS9pZGxlLmM6OTYgY3B1X3N0YXJ0dXBfZW50cnkrMHgxNTAvMHgxNzgoKQ0KWyAgMTI0
LjY3NzIwOV0gTW9kdWxlcyBsaW5rZWQgaW46DQpbICAxMjQuNjgwMjUxXSBDUFU6IDAgUElEOiAw
IENvbW06IHN3YXBwZXIvMCBOb3QgdGFpbnRlZCAzLjkuMCsgIzQwDQpbICAxMjQuNjg2MjM3XSBT
dGFjayA6IDAwMDAwMDAwMDAwMDAwMDQgMDAwMDAwMDAwMDAwMDAzNCBmZmZmZmZmZjgwZmEwMDAw
IGZmZmZmZmZmODAyOTI1NTgNCiAgICAgICAgICAwMDAwMDAwMDAwMDAwMDAwIGZmZmZmZmZmODBm
YTAwMDAgMDAwMDAwMDAwMDAwMDAwMSBmZmZmZmZmZjgwMjkzODEwDQogICAgICAgICAgMDAwMDAw
MDAwMDAwMDAwMCAwMDAwMDAwMDAwMDAwMDAwIGZmZmZmZmZmODEwODAwMDAgZmZmZmZmZmY4MTA4
MDAwMA0KICAgICAgICAgIGZmZmZmZmZmODBlMmFjZjAgZmZmZmZmZmY4MGY4Zjk3NyBmZmZmZmZm
ZjgwZjhmYTgwIGZmZmZmZmZmODBlMzE3MzANCiAgICAgICAgICAwMDAwMDAwMDAwMDAwMDAxIDAw
MDAwMDAwMDAwMDAwMDQgZmZmZmZmZmYwMDAwMDAwMCAwMDAwMDAwMDAwMDAwMDA0DQogICAgICAg
ICAgZmZmZmZmZmZjMDU2MzNmMCBmZmZmZmZmZjgwNmVmNzI4IGZmZmZmZmZmODBmNTdkMDggZmZm
ZmZmZmY4MDI5MGE3NA0KICAgICAgICAgIGZmZmZmZmZmYzA1NjMzZjAgZmZmZmZmZmY4MDI5M2M0
MCAwMDAwMDAwMDAwMDAwMDNlIGZmZmZmZmZmODBlMmFjZjANCiAgICAgICAgICAwMDAwMDAwMDAw
MDAwMDAwIGZmZmZmZmZmODBmNTdjMzAgMDBmZmZmZmY4MGY4ZmRjMCBmZmZmZmZmZjgwMjkwOGMw
DQogICAgICAgICAgMDAwMDAwMDAwMDAwMDAwMCAwMDAwMDAwMDAwMDAwMDAwIDAwMDAwMDAwMDAw
MDAwMDAgMDAwMDAwMDAwMDAwMDAwMA0KICAgICAgICAgIDAwMDAwMDAwMDAwMDAwMDAgZmZmZmZm
ZmY4MDI3MjQ5OCAwMDAwMDAwMDAwMDAwMDAwIDAwMDAwMDAwMDAwMDAwMDANCiAgICAgICAgICAu
Li4NClsgIDEyNC43NTExNjNdIENhbGwgVHJhY2U6DQpbICAxMjQuNzUzNTk5XSBbPGZmZmZmZmZm
ODAyNzI0OTg+XSBzaG93X3N0YWNrKzB4NjgvMHg4MA0KWyAgMTI0Ljc1ODYzNF0gWzxmZmZmZmZm
ZjgwMjkwOGMwPl0gd2Fybl9zbG93cGF0aF9jb21tb24rMHg3OC8weGE4DQpbICAxMjQuNzY0NTMz
XSBbPGZmZmZmZmZmODAyZDQ0NDg+XSBjcHVfc3RhcnR1cF9lbnRyeSsweDE1MC8weDE3OA0KWyAg
MTI0Ljc3MDM1MV0gWzxmZmZmZmZmZjgwZmQ2YjA0Pl0gc3RhcnRfa2VybmVsKzB4NDQwLzB4NDVj
DQpbICAxMjQuNzc1NzI4XQ0KWyAgMTI0Ljc3NzIxOV0gLS0tWyBlbmQgdHJhY2UgOTE3OWU2NTRl
NTY5M2U3MiBdLS0tDQoNCkFmdGVyIGJvb3QgcHJvY2VzcyBpcyBkb25lIHRoZSBmb2xsb3cgZXJy
b3IgbWVzc2FnZSBpcyBwcmludGVkIHBlcmlvZGljYWxseS4NCg0KWyAgMjg0Ljc1MTAwN10gSU5G
TzogcmN1X3ByZWVtcHQgZGV0ZWN0ZWQgc3RhbGxzIG9uIENQVXMvdGFza3M6IHsgNn0gKGRldGVj
dGVkIGJ5IDEsIHQ9MTQ3MTIgamlmZmllcywgZz0xODQ0Njc0NDA3MzcwOTU1MTM0NCwgYz0xODQ0
Njc0NDA3MzcwOTU1MTM0MywgcT0yNDM3KQ0KWyAgMjg0Ljc2NDg3OF0gVGFzayBkdW1wIGZvciBD
UFUgNjoNClsgIDI4NC43NjgxMDVdIHN3YXBwZXIvNiAgICAgICBSICBydW5uaW5nIHRhc2sgICAg
ICAgIDAgICAgIDAgICAgICAxIDB4MDAxMDAwMDANClsgIDI4NC43NzUxNzRdIFN0YWNrIDogMDAw
MDAwNTMxMTExMjAwMCBmZmZmZmZmZjgwZjYwMDAwIGZmZmZmZmZmODBmNjAwMDAgYTgwMDAwMDAw
MWQyZDk1MA0KICAgICAgICAgIDAwMDAwMDAwMDAwMDAwMTggZmZmZmZmZmY4MTA4MDAwMCBmZmZm
ZmZmZjgxMDgwMDAwIDAwMDAwMDAwMDAwMDAwMDANCiAgICAgICAgICBmZmZmZmZmZjgxMDEwMDAw
IGZmZmZmZmZmODAzMDg5M2MgNDI1NmU1NzE1ZGE2MDgzZCA4MDAwMDAwNDBmODAwMDAwDQogICAg
ICAgICAgMDAwMDAwMDAwMDAwMDAxOCBmZmZmZmZmZjgxMDgwMDAwIGZmZmZmZmZmODEwODAwMDAg
ZmZmZmZmZmY4MDI2NGYzYw0KICAgICAgICAgIGZmZmZmZmZmODBlMzE3MzAgMDAwMDAwMDAwMDAw
MDAwMCBmZmZmZmZmZjgwZTMxNzMwIGZmZmZmZmZmODBmOTAwMDANCiAgICAgICAgICBmZmZmZmZm
ZjgwZmQwMDAwIGZmZmZmZmZmODAyNmM3NjAgMDAwMDAwMDAwMDAwMDAwMCAwMDAwMDAwMDEwMDA4
Y2UxDQogICAgICAgICAgMDAwMDAwMDAwMDEwMDAwMCBhODAwMDAwMDQxNGU0MDEwIGZmZmZmZmZm
ODBmOGJiMTggMDAwMDAwMDAwMDAwMDAwMA0KICAgICAgICAgIDAwMDAwMDUzMTExMTIwMDAgMDAw
MDAwMDAwMDAwMDAwMSAwMDAwMDAwMDAwMDAwMDAxIDAwMDAwMDAwMDAwMDAwMDANCiAgICAgICAg
ICBmZmZmZmZmZjgwZjhiYzU4IGE4MDAwMDAwMDFkMzJjNjAgYTgwMDAwMDA0MTRlN2ZlMCAwMDAw
MDAwMDAwMDA4YzAwDQogICAgICAgICAgYTgwMDAwMDAzZjdkODAwMCAwMDAwMDAwMDAwMDAwMDAw
IGZmZmZmZmZmODBmZDAwMDAgZmZmZmZmZmY4MGUzMTczMA0KICAgICAgICAgIC4uLg0KWyAgMjg0
Ljg0MDcwNF0gQ2FsbCBUcmFjZToNClsgIDI4NC44NDMxNTNdIFs8ZmZmZmZmZmY4MDZmMWE0OD5d
IF9fc2NoZWR1bGUrMHgzYjAvMHg5MzgNClsgIDI4NC44NDgzNzddDQoNCg0KVGhhbmtz
