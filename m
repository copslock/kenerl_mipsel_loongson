Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2014 08:16:29 +0200 (CEST)
Received: from mailout1.samsung.com ([203.254.224.24]:40814 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822097AbaDVGQYcMV4l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Apr 2014 08:16:24 +0200
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N4F00BU35F346C0@mailout1.samsung.com> for
 linux-mips@linux-mips.org; Tue, 22 Apr 2014 15:16:15 +0900 (KST)
Received: from epcpsbgx2.samsung.com ( [203.254.230.46])
        by epcpsbgr3.samsung.com (EPCPMTA) with SMTP id 24.9E.11120.F2906535; Tue,
 22 Apr 2014 15:16:15 +0900 (KST)
X-AuditID: cbfee68f-b7eff6d000002b70-60-5356092f4f4d
Received: from epextmailer03 ( [203.254.219.153])
        by epcpsbgx2.samsung.com (EPCPMTA) with SMTP id 9B.05.20075.F2906535; Tue,
 22 Apr 2014 15:16:15 +0900 (KST)
Date:   Tue, 22 Apr 2014 06:16:15 +0000 (GMT)
From:   Eunbong Song <eunb.song@samsung.com>
Subject: [PATCH] MIPS: Octeon: Add twsi interrupt initialization for OCTEON
 3XXX, 5XXX, 63XX
To:     "ralf@linux-mips.org" <ralf@linux-mips.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Reply-to: eunb.song@samsung.com
MIME-version: 1.0
X-MTR:  20140422060825853@eunb.song
Msgkey: 20140422060825853@eunb.song
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-EPTrCode: 
X-EPTrName: 
X-MLAttribute: 
X-RootMTR: 20140422060825853@eunb.song
X-ParentMTR: 
X-ArchiveUser: EV
X-CPGSPASS: N
Content-transfer-encoding: base64
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <10122213.56741398147374487.JavaMail.weblogic@epml15>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCJsWRmVeSWpSXmKPExsVy+t8zPV19zrBgg5UvtCwmTJ3E7sDocXTl
        WqYAxqgGRpvEouSMzLJUhdS85PyUzLx0W6XQEDddCyWFjPziElulaCMDYz0jUxM9IxNzPUuD
        WCsjUyWFvMTcVFulCl2oXiWFouQCoNrcymKgATmpelBxveLUvBSHrPxSkFP0ihNzi0vz0vWS
        83OVFMoSc0qBRijpJ0xlzHiy5hBjwRKhihuNoQ2MTwS7GDk5hARUJFr+f2cEsSUETCSOzV7C
        DmGLSVy4t56ti5ELqGYZo8TOCyvZYYqeXL3ADJGYzyjxrHEnE0iCRUBV4sLsV2wgNpuAtsSP
        A1eZQWxhgRiJx7+ugNWICOhL/D/3FmwQs0CNxLer+1ghrpCXmHz6MlicV0BQ4uTMJywQy5Qk
        ju9tYYOIK0t8mHKYFSIuITFr+gUom1diRvtTqHo5iWlf1zBD2NIS52dtYIT5ZvH3x1Bxfolj
        t3cA3cMB1vvkfjDMmN2bv7BB2AISU88chGpVl1h17BfU73wSaxa+hVolKHH6WjczTO/9LXOZ
        IN5SlJjS/RDqRS2JLz/2saF7i1fAUaL3y2+WCYzKs5CkZiFpn4WkHVnNAkaWVYyiqQXJBcVJ
        6UXGyJG9iRGSCPt3MN49YH2IcT8jME4mMkuJJucDU2leSbyhsZmRhamJqbGRuaUZhcImphYW
        JkZUEVYS573/MClISCA9sSQ1OzW1ILUovqg0J7X4ECMTB6dUA6OSAsfywBmrRJ2Ot33+38Ql
        9M/qWJ2V9Fo3oR92+1c75Ykuqdyx4pv0kqnpZYuXMn9/sfKq4tSPCVPFEpLVOsM/xV6+mbFg
        o+4TJR71E+7yXcutNA5/Pcu6oWrGGxt3V/m8OTqcPLzMF9mvLJI5dK7qXK5E9MKlf91rA6U2
        u++s2m4hG/N4sZISS3FGoqEWc1FxIgBU7L6E9wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42I5/e/2TF19zrBgg7P31C0mTJ3E7sDocXTl
        WqYAxqgMm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zByg
        qUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6VoIwNjPSNTEz0jYwM9E4NYK0MDAyNToKqE
        jIwnaw4xFiwRqrjRGNrA+ESwi5GTQ0hARaLl/3dGEFtCwETiydULzBC2mMSFe+vZuhi5gGrm
        M0o8a9zJBJJgEVCVuDD7FRuIzSagLfHjwFWwBmGBGInHv66A1YgI6Ev8P/eWHcRmFqiR+HZ1
        HyvEMnmJyacvg8V5BQQlTs58wgKxTEni+N4WNoi4ssSHKYdZIeISErOmX4CyeSVmtD+FqpeT
        mPZ1DdSh0hLnZ21ghDl68ffHUHF+iWO3dwDdwwHW++R+MMyY3Zu/sEHYAhJTzxyEalWXWHXs
        FzuEzSexZuFbqFWCEqevdTPD9N7fMpcJ4i1FiSndD6Fe1JL48mMfG7q3eAUcJXq//GaZwCg3
        C0lqFpL2WUjakdUsYGRZxSiaWpBcUJyUXmGkV5yYW1yal66XnJ+7iRGcop4t2sH477z1IUYB
        DkYlHl4Jg9BgIdbEsuLK3EOMEhzMSiK86X+AQrwpiZVVqUX58UWlOanFhxiTgRE4kVlKNDkf
        mD7zSuINjQ2MDQ0tzQ1MDY0sSBNWEueVv5UUJCSQnliSmp2aWpBaBLOFiYNTqoHx+LHH7Uml
        z/f8euFpbf9lbXeDelHkq8YD7ht9W9vX3z/wovddcei035YGC+5sjzTpTbr1O/RfRK3aFm4b
        oSj9zcve1tn9+yU9e/dP/x+aL65bu237s+265ByByt8P8g+WXpW3WnphL6tMlPTz4p3nxd9X
        y83yPr6I6eGWZwZTFFNmijU/nMqSo8RSnJFoqMVcVJwIANE4zveVAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Return-Path: <eunb.song@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39883
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

DQpJbiBvY3Rlb25fM3h4eC5kdHMgZmlsZSwgdGhlcmUgaXMgYSBkZWZpbml0b24gZm9yIHR3c2kv
dHdzaTIgaW50ZXJydXB0cy4NCkJ1dCB0aGVyZSBpcyBubyBjb2RlIGZvciBpbml0aWFsaXphdGlv
biBvZiB0aGlzIGludGVycnVwdHMuIFRoaXMgcGF0Y2ggYWRkcw0KY29kZSBmb3IgaW5pdGlhbGl6
YXRpb24gb2YgdHdzaSBpbnRlcnJ1cHRzLg0KDQpTaWduZWQtb2ZmLWJ5OiBFdW5ib25nIFNvbmcg
PGV1bmIuc29uZ0BzYW1zdW5nLmNvbT4NCi0tLQ0KIGFyY2gvbWlwcy9jYXZpdW0tb2N0ZW9uL29j
dGVvbi1pcnEuYyAgICAgICAgICAgfCAgICAyICsrDQogYXJjaC9taXBzL2luY2x1ZGUvYXNtL21h
Y2gtY2F2aXVtLW9jdGVvbi9pcnEuaCB8ICAgIDIgKysNCiAyIGZpbGVzIGNoYW5nZWQsIDQgaW5z
ZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gvbWlwcy9jYXZp
dW0tb2N0ZW9uL29jdGVvbi1pcnEuYyBiL2FyY2gvbWlwcy9jYXZpdW0tb2N0ZW9uL29jdGVvbi1p
cnEuYw0KaW5kZXggYzJiYjRmOC4uMTViZmNmOSAxMDA2NDQNCi0tLSBhL2FyY2gvbWlwcy9jYXZp
dW0tb2N0ZW9uL29jdGVvbi1pcnEuYw0KKysrIGIvYXJjaC9taXBzL2Nhdml1bS1vY3Rlb24vb2N0
ZW9uLWlycS5jDQpAQCAtMTI2MCwxMSArMTI2MCwxMyBAQCBzdGF0aWMgdm9pZCBfX2luaXQgb2N0
ZW9uX2lycV9pbml0X2NpdSh2b2lkKQ0KIAlmb3IgKGkgPSAwOyBpIDwgNDsgaSsrKQ0KIAkJb2N0
ZW9uX2lycV9mb3JjZV9jaXVfbWFwcGluZyhjaXVfZG9tYWluLCBpICsgT0NURU9OX0lSUV9QQ0lf
TVNJMCwgMCwgaSArIDQwKTsNCiANCisJb2N0ZW9uX2lycV9mb3JjZV9jaXVfbWFwcGluZyhjaXVf
ZG9tYWluLCBPQ1RFT05fSVJRX1RXU0ksIDAsIDQ1KTsNCiAJb2N0ZW9uX2lycV9mb3JjZV9jaXVf
bWFwcGluZyhjaXVfZG9tYWluLCBPQ1RFT05fSVJRX1JNTCwgMCwgNDYpOw0KIAlmb3IgKGkgPSAw
OyBpIDwgNDsgaSsrKQ0KIAkJb2N0ZW9uX2lycV9mb3JjZV9jaXVfbWFwcGluZyhjaXVfZG9tYWlu
LCBpICsgT0NURU9OX0lSUV9USU1FUjAsIDAsIGkgKyA1Mik7DQogDQogCW9jdGVvbl9pcnFfZm9y
Y2VfY2l1X21hcHBpbmcoY2l1X2RvbWFpbiwgT0NURU9OX0lSUV9VU0IwLCAwLCA1Nik7DQorCW9j
dGVvbl9pcnFfZm9yY2VfY2l1X21hcHBpbmcoY2l1X2RvbWFpbiwgT0NURU9OX0lSUV9UV1NJMiwg
MCwgNTkpOw0KIA0KIAkvKiBDSVVfMSAqLw0KIAlmb3IgKGkgPSAwOyBpIDwgMTY7IGkrKykNCmRp
ZmYgLS1naXQgYS9hcmNoL21pcHMvaW5jbHVkZS9hc20vbWFjaC1jYXZpdW0tb2N0ZW9uL2lycS5o
IGIvYXJjaC9taXBzL2luY2x1ZGUvYXNtL21hY2gtY2F2aXVtLW9jdGVvbi9pcnEuaA0KaW5kZXgg
NjBmYzRjMy4uY2NlYWUzMiAxMDA2NDQNCi0tLSBhL2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9tYWNo
LWNhdml1bS1vY3Rlb24vaXJxLmgNCisrKyBiL2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9tYWNoLWNh
dml1bS1vY3Rlb24vaXJxLmgNCkBAIC0zNSw2ICszNSw4IEBAIGVudW0gb2N0ZW9uX2lycSB7DQog
CU9DVEVPTl9JUlFfUENJX01TSTIsDQogCU9DVEVPTl9JUlFfUENJX01TSTMsDQogDQorCU9DVEVP
Tl9JUlFfVFdTSSwNCisJT0NURU9OX0lSUV9UV1NJMiwNCiAJT0NURU9OX0lSUV9STUwsDQogCU9D
VEVPTl9JUlFfVElNRVIwLA0KIAlPQ1RFT05fSVJRX1RJTUVSMSwNCi0tIA0KMS43LjAuMQ0K
