Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Apr 2013 00:51:10 +0200 (CEST)
Received: from mailout2.samsung.com ([203.254.224.25]:36448 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827494Ab3DRWvCC78lO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Apr 2013 00:51:02 +0200
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MLH00MS93GSWJA0@mailout2.samsung.com> for
 linux-mips@linux-mips.org; Fri, 19 Apr 2013 07:50:52 +0900 (KST)
Received: from epcpsbgx1.samsung.com ( [203.254.230.44])
        by epcpsbgr3.samsung.com (EPCPMTA) with SMTP id 72.72.05174.CC870715; Fri,
 19 Apr 2013 07:50:52 +0900 (KST)
X-AuditID: cbfee68f-b7f4a6d000001436-55-517078cc9b8e
Received: from epextmailer03 ( [203.254.219.153])
        by epcpsbgx1.samsung.com (EPCPMTA) with SMTP id 1F.62.14546.CC870715; Fri,
 19 Apr 2013 07:50:52 +0900 (KST)
Date:   Thu, 18 Apr 2013 22:50:52 +0000 (GMT)
From:   EUNBONG SONG <eunb.song@samsung.com>
Subject: [PATCH] mips: Fix invalid interrupt name in cavium-octeon
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Reply-to: eunb.song@samsung.com
MIME-version: 1.0
X-MTR:  20130418224829249@eunb.song
Msgkey: 20130418224829249@eunb.song
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-EPTrCode: 
X-EPTrName: 
X-MLAttribute: 
X-RootMTR: 20130418224829249@eunb.song
X-ParentMTR: 
X-ArchiveUser: 
X-CPGSPASS: N
Content-transfer-encoding: base64
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <2202498.1401366325451851.JavaMail.weblogic@epv6ml11>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42I5/e+Zju6ZioJAgwN/FSwmTJ3E7sDocXTl
        WqYAxigum5TUnMyy1CJ9uwSujBtHX7MUrBGuWNX8kbWB8YVQFyMnh5CAikTL/++MILaEgInE
        jn+/mCBsMYkL99azdTFyAdUsY5S4/XwrO0zRzu0HmSAS8xklXr/YwtzFyMHBIqAqcaM9CKSG
        TUBb4u2XB6wgYWEBJ4neGYUgYREBGYmln66A7WIWcJd4++k4M8QN8hKTT18GG88rIChxcuYT
        FohVShIND/exQMSVJQ5Nus0GEZeQmDX9AiuEzSsxo/0pVL2cxLSva5ghbGmJ87M2MML8svj7
        Y6g4v8Sx2zuYQE4D6X1yPxhmzO7NX6DGC0hMPXMQqlVdYt6c01BxPok1C9+ywIzZdWo5M0zv
        /S1zmSDeUpSY0v2QHcLWkvjyYx8burd4BRwlNuy7zjSBUXkWktQsJO2zkLQjq1nAyLKKUTS1
        ILmgOCm9yFivODG3uDQvXS85P3cTIyQt9O9gvHvA+hBjMjBCJjJLiSbnA9NKXkm8obGZkYWp
        iamxkbmlGWnCSuK8ai3WgUIC6YklqdmpqQWpRfFFpTmpxYcYmTg4pRoYuX37dTUNXGfdmNgi
        PC242LHvd3Vr2IubHs9n7b32uCr9Xfq28tmHZ31eITfxurl6mbadvO8aLvfJH1etXvf8zvHz
        VQxMKw8m3C+bEvp2jrqR42eTH4uZN/rN0PFIZHBJ9X07zbL8vOelc8aLLsexsUy6qPVExrJw
        yoylK+9t4Xkl8u6ThxVPrRJLcUaioRZzUXEiABB0x1AhAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42I5/e/2TN0zFQWBBtevyFhMmDqJ3YHR4+jK
        tUwBjFEZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlA
        U5UUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkrRRgbGekamJnpGxgZ6JgaxVoYGBkamQFUJ
        GRk3jr5mKVgjXLGq+SNrA+MLoS5GTg4hARWJlv/fGUFsCQETiZ3bDzJB2GISF+6tZ+ti5AKq
        mc8o8frFFuYuRg4OFgFViRvtQSA1bALaEm+/PGAFCQsLOEn0zigECYsIyEgs/XQFbCSzgLvE
        20/HmSFWyUtMPn2ZHcTmFRCUODnzCQvEKiWJhof7WCDiyhKHJt1mg4hLSMyafoEVwuaVmNH+
        FKpeTmLa1zXMELa0xPlZGxhhTl78/TFUnF/i2O0dTCCngfQ+uR8MM2b35i9Q4wUkpp45CNWq
        LjFvzmmoOJ/EmoVvWWDG7Dq1nBmm9/6WuUwQbylKTOl+yA5ha0l8+bGPDd1bvAKOEhv2XWea
        wCg3C0lqFpL2WUjakdUsYGRZxSiaWpBcUJyUXmGoV5yYW1yal66XnJ+7iRGcoJ4t3MH45bz1
        IUYBDkYlHt4bUgWBQqyJZcWVuYcYJTiYlUR4pycBhXhTEiurUovy44tKc1KLDzEmA6NvIrOU
        aHI+MHnmlcQbGhsYGxpamhuYGhpZkCasJM77tNU6UEggPbEkNTs1tSC1CGYLEwenVAPjkTev
        d2ZGPpbUrP97au/FbcdnpZ3r6b7gvDvgyM0puQs+91xc3Oof075g2Z4L6csnbOOMXfK108Vk
        g4lbRL6/6poboeXB7wUqZKO/GoesZd68/06b9LS+r4J+FdwMS9TqKsz2vvUSM20T870ks06F
        S6dmkv9Ehv7pUnMnH2WS3twbPff5b5FOJZbijERDLeai4kQA/qR40JQDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Return-Path: <eunb.song@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36270
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

DQpDaGFuZ2UgaW50ZXJydXB0IG5hbWUgZnJvbSAiUk1ML1JTTCIgdG8gIlJNTFJTTCIuDQpUaGlz
IGZpeGVzIGZvbGxvd2luZyB3YXJuaW5nIG1lc3NhZ2UuDQoNClsgICAyNC45Mzg3OTNdIFdBUk5J
Tkc6IGF0IGZzL3Byb2MvZ2VuZXJpYy5jOjMwNyBfX3hsYXRlX3Byb2NfbmFtZSsweDEyNC8weDE2
MCgpDQpbICAgMjQuOTQ1OTI2XSBuYW1lICdSTUwvUlNMJw0KWyAgIDI0Ljk0ODY0Ml0gTW9kdWxl
cyBsaW5rZWQgaW46DQpbICAgMjQuOTUxNzA3XSBDYWxsIFRyYWNlOg0KWyAgIDI0Ljk1NDE1N10g
WzxmZmZmZmZmZjgwNjlmZTE4Pl0gZHVtcF9zdGFjaysweDgvMHgzNA0KWyAgIDI0Ljk1OTEzNl0g
WzxmZmZmZmZmZjgwMjkwZDkwPl0gd2Fybl9zbG93cGF0aF9jb21tb24rMHg3OC8weGE4DQpbICAg
MjQuOTY1MDU2XSBbPGZmZmZmZmZmODAyOTBlNjA+XSB3YXJuX3Nsb3dwYXRoX2ZtdCsweDM4LzB4
NDgNClsgICAyNC45NzA3MjNdIFs8ZmZmZmZmZmY4MDNjYmM4Yz5dIF9feGxhdGVfcHJvY19uYW1l
KzB4MTI0LzB4MTYwDQpbICAgMjQuOTc2NTU2XSBbPGZmZmZmZmZmODAzY2JlNzg+XSBfX3Byb2Nf
Y3JlYXRlKzB4NzgvMHgxMjgNClsgICAyNC45ODE5NjNdIFs8ZmZmZmZmZmY4MDNjZDA0ND5dIHBy
b2NfbWtkaXJfbW9kZSsweDJjLzB4NzANClsgICAyNC45ODc0NTFdIFs8ZmZmZmZmZmY4MDMwMjQx
OD5dIHJlZ2lzdGVyX2hhbmRsZXJfcHJvYysweDEwOC8weDEzMA0KWyAgIDI0Ljk5MzY0Ml0gWzxm
ZmZmZmZmZjgwMmZkMDc4Pl0gX19zZXR1cF9pcnErMHgyMTAvMHg1NDANClsgICAyNC45OTg5NjNd
IFs8ZmZmZmZmZmY4MDJmZDY3Yz5dIHJlcXVlc3RfdGhyZWFkZWRfaXJxKzB4MTE0LzB4MWEwDQpb
ICAgMjUuMDA1MDYwXSBbPGZmZmZmZmZmODAyNjJlMGM+XSBwcm9tX2ZyZWVfcHJvbV9tZW1vcnkr
MHhkNC8weDU4OA0KWyAgIDI1LjAxMTE2NF0gWzxmZmZmZmZmZjgwNjkxODIwPl0gZnJlZV9pbml0
bWVtKzB4MTAvMHhjMA0KWyAgIDI1LjAxNjM5MF0gWzxmZmZmZmZmZjgwNjkxNzIwPl0ga2VybmVs
X2luaXQrMHgyMC8weDEwMA0KWyAgIDI1LjAyMTYyNF0gWzxmZmZmZmZmZjgwMjZjN2UwPl0gcmV0
X2Zyb21fa2VybmVsX3RocmVhZCsweDEwLzB4MTgNCg0KU2lnbmVkLW9mZi1ieTogRXVuYm9uZyBT
b25nIDxldW5iLnNvbmdAc2Ftc3VuZy5jb20+DQotLS0NCiBhcmNoL21pcHMvY2F2aXVtLW9jdGVv
bi9zZXR1cC5jIHwgICAgMiArLQ0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9taXBzL2Nhdml1bS1vY3Rlb24vc2V0
dXAuYyBiL2FyY2gvbWlwcy9jYXZpdW0tb2N0ZW9uL3NldHVwLmMNCmluZGV4IGIwYmFhMjkuLjky
YzMxNTAgMTAwNjQ0DQotLS0gYS9hcmNoL21pcHMvY2F2aXVtLW9jdGVvbi9zZXR1cC5jDQorKysg
Yi9hcmNoL21pcHMvY2F2aXVtLW9jdGVvbi9zZXR1cC5jDQpAQCAtMTA2Niw3ICsxMDY2LDcgQEAg
dm9pZCBwcm9tX2ZyZWVfcHJvbV9tZW1vcnkodm9pZCkNCiANCiAJLyogQWRkIGFuIGludGVycnVw
dCBoYW5kbGVyIGZvciBnZW5lcmFsIGZhaWx1cmVzLiAqLw0KIAlpZiAocmVxdWVzdF9pcnEoT0NU
RU9OX0lSUV9STUwsIG9jdGVvbl9ybG1faW50ZXJydXB0LCBJUlFGX1NIQVJFRCwNCi0JCQkiUk1M
L1JTTCIsIG9jdGVvbl9ybG1faW50ZXJydXB0KSkgew0KKwkJCSJSTUxSU0wiLCBvY3Rlb25fcmxt
X2ludGVycnVwdCkpIHsNCiAJCXBhbmljKCJVbmFibGUgdG8gcmVxdWVzdF9pcnEoT0NURU9OX0lS
UV9STUwpIik7DQogCX0NCiAjZW5kaWYNCi0tIA0KMS43LjAuNA0K
