Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 May 2013 10:26:03 +0200 (CEST)
Received: from mailout4.samsung.com ([203.254.224.34]:23501 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6834816Ab3EBI0CCYVg- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 May 2013 10:26:02 +0200
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MM500II4WN21KR0@mailout4.samsung.com> for
 linux-mips@linux-mips.org; Thu, 02 May 2013 17:25:53 +0900 (KST)
Received: from epcpsbgx2.samsung.com ( [203.254.230.46])
        by epcpsbgr2.samsung.com (EPCPMTA) with SMTP id C9.A7.19730.11322815; Thu,
 02 May 2013 17:25:53 +0900 (KST)
X-AuditID: cbfee68e-b7efa6d000004d12-03-51822311ce9c
Received: from epextmailer01 ( [203.254.219.151])
        by epcpsbgx2.samsung.com (EPCPMTA) with SMTP id D0.BF.15503.11322815; Thu,
 02 May 2013 17:25:53 +0900 (KST)
Date:   Thu, 02 May 2013 08:25:53 +0000 (GMT)
From:   EUNBONG SONG <eunb.song@samsung.com>
Subject: [PATCH ] MIPS:  Fix build error crash_dump.c file.
To:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lars@metafoo.de
Reply-to: eunb.song@samsung.com
MIME-version: 1.0
X-MTR:  20130502081709416@eunb.song
Msgkey: 20130502081709416@eunb.song
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-EPTrCode: 
X-EPTrName: 
X-MLAttribute: 
X-RootMTR: 20130502075832647@eunb.song
X-ParentMTR: 20130502075832647@eunb.song
X-ArchiveUser: 
X-CPGSPASS: N
Content-transfer-encoding: base64
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <417838.192431367483152638.JavaMail.weblogic@epv6ml12>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42I5/e+Znq6gclOgwZPPghYTpk5id2D0OLpy
        LVMAYxSXTUpqTmZZapG+XQJXxv2zLxgLengr7kytaWC8w9PFyMkhJKAi0fL/OyOILSFgItF9
        4RcbhC0mceHeeiCbC6hmGaPE25V/4IpaT7SyQiTmM0rM7X4JlmABmnT1fgtYN5uAtsTbLw9Y
        QWxhAWuJJ7tnMoPYIgJZEnu3LAKzmQUiJRr7X7NDXCEvMfn0ZTCbV0BQ4uTMJywQy5Qkrp9e
        ywoRV5boW/8MKi4hMWv6BVYIm1diRvtTqLicxLSva5ghbGmJ87M2MMJ8s/j7Y6g4v8Sx2zuY
        uhg5wHqf3A+GGbN78xeo5wUkpp45CNWqLnFk5h+o8ZoSvxunMMKM2XVqOTNM7/0tc5kg3lKU
        mNL9kB3C1pL48mMfG7q3eAWcJK6v+sE6gVF5FpLULCTts5C0I6tZwMiyilE0tSC5oDgpvchI
        rzgxt7g0L10vOT93EyMkMfTtYLx5wPoQYzIwSiYyS4km5wMTS15JvKGxmZGFqYmpsZG5pRlp
        wkrivGot1oFCAumJJanZqakFqUXxRaU5qcWHGJk4OKUaGNk+HJzE2bcy0+jluT2pD26vFOmb
        s3np4+jAk6L1eu9n+aif2TSp/k3jhKUmX0Tqjk98aaHTf3VjrLB06DM/PoeDSTF/5TPeLpHc
        uK7qvu3jn15SGzrCF7zouyR4TW5O/bLUfWm+PypEN2ncn7+Ha1kx60mub0skuBd45syzepf4
        87OVY03JcQ4lluKMREMt5qLiRACu4icKIgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42I5/e/2dF1B5aZAg2WL+S0mTJ3E7sDocXTl
        WqYAxqgMm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zByg
        qUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6VoIwNjPSNTEz0jYwM9E4NYK0MDAyNToKqE
        jIz7Z18wFvTwVtyZWtPAeIeni5GTQ0hARaLl/3dGEFtCwESi9UQrK4QtJnHh3nq2LkYuoJr5
        jBJzu1+CFbEANVy938IGYrMJaEu8/fIArEFYwFriye6ZzCC2iECWxN4ti8BsZoFIicb+1+wQ
        y+QlJp++DGbzCghKnJz5hAVimZLE9dNrWSHiyhJ9659BxSUkZk2/AHUQr8SM9qdQcTmJaV/X
        MEPY0hLnZ21ghDl68ffHUHF+iWO3dzB1MXKA9T65HwwzZvfmL2wQtoDE1DMHoVrVJY7M/AM1
        XlPid+MURpgxu04tZ4bpvb9lLhPEW4oSU7ofskPYWhJffuxjQ/cWr4CTxPVVP1gnMMrNQpKa
        haR9FpJ2ZDULGFlWMYqmFiQXFCelVxjpFSfmFpfmpesl5+duYgSnqGeLdjD+O299iFGAg1GJ
        h/eDbmOgEGtiWXFl7iFGCQ5mJRHeJPmmQCHelMTKqtSi/Pii0pzU4kOMycAInMgsJZqcD0yf
        eSXxhsYGxoaGluYGpoZGFqQJK4nzPmu1DhQSSE8sSc1OTS1ILYLZwsTBKdXAWHUm41KG2hNL
        tU/1zW1GEpdvfjnC/eep+0kFoVndqnsmvLov5fXoCvO50qtXb66bMOumFd//UKubVvxpH7ht
        IyL+L2JN03LIb5tYpbrr/80ptwwqZy8IWbgnxWf21Y0/T6o3XbrT45LzIHHfJP4pz12Ov3x0
        +NC3zxE5V5tV9S7HrHssPiWxMkGJpTgj0VCLuag4EQCoGCiblQMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Return-Path: <eunb.song@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36308
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

DQpUaGlzIHBhdGNoIGZpeGVzIGNyYXNoX2R1bXAuYyBidWlsZCBlcnJvci4gQnVpbGQgZXJyb3Ig
bG9ncyBhcmUgYXMgZm9sbG93Lg0KDQphcmNoL21pcHMva2VybmVsL2NyYXNoX2R1bXAuYzogSW4g
ZnVuY3Rpb24gJ2tkdW1wX2J1Zl9wYWdlX2luaXQnOg0KYXJjaC9taXBzL2tlcm5lbC9jcmFzaF9k
dW1wLmM6Njc6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAna21hbGxv
YycNCmNjMTogd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMNCmFyY2gvbWlwcy9rZXJu
ZWwvY3Jhc2hfZHVtcC5jOjY3OiBlcnJvcjogYXNzaWdubWVudCBtYWtlcyBwb2ludGVyIGZyb20g
aW50ZWdlciB3aXRob3V0IGEgY2FzdA0KbWFrZVszXTogKioqIFthcmNoL21pcHMva2VybmVsL2Ny
YXNoX2R1bXAub10gRXJyb3IgMQ0KbWFrZVsyXTogKioqIFthcmNoL21pcHMva2VybmVsXSBFcnJv
ciAyDQptYWtlWzFdOiAqKiogW2FyY2gvbWlwc10gRXJyb3IgMg0KbWFrZVsxXTogKioqIFdhaXRp
bmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4NCiAgQ0MgICAgICBrZXJuZWwvc3lzLm8NCiAgQ0Mg
ICAgICBrZXJuZWwvbW9kdWxlLm8NCiAgR1pJUCAgICBrZXJuZWwvY29uZmlnX2RhdGEuZ3oNCiAg
Q0hLICAgICBrZXJuZWwvY29uZmlnX2RhdGEuaA0KICBMRCAgICAgIGtlcm5lbC9idWlsdC1pbi5v
DQoNCg0KU2lnbmVkLW9mZi1ieTogRXVuYm9uZyBTb25nIDxldW5iLnNvbmdAc2Ftc3VuZy5jb20+
DQotLS0NCiBhcmNoL21pcHMva2VybmVsL2NyYXNoX2R1bXAuYyB8ICAgIDEgKw0KIDEgZmlsZXMg
Y2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
YXJjaC9taXBzL2tlcm5lbC9jcmFzaF9kdW1wLmMgYi9hcmNoL21pcHMva2VybmVsL2NyYXNoX2R1
bXAuYw0KaW5kZXggMzViZWQwZC4uM2JlOWU3YiAxMDA2NDQNCi0tLSBhL2FyY2gvbWlwcy9rZXJu
ZWwvY3Jhc2hfZHVtcC5jDQorKysgYi9hcmNoL21pcHMva2VybmVsL2NyYXNoX2R1bXAuYw0KQEAg
LTIsNiArMiw3IEBADQogI2luY2x1ZGUgPGxpbnV4L2Jvb3RtZW0uaD4NCiAjaW5jbHVkZSA8bGlu
dXgvY3Jhc2hfZHVtcC5oPg0KICNpbmNsdWRlIDxhc20vdWFjY2Vzcy5oPg0KKyNpbmNsdWRlIDxs
aW51eC9zbGFiLmg+DQogDQogc3RhdGljIGludCBfX2luaXQgcGFyc2Vfc2F2ZW1heG1lbShjaGFy
ICpwKQ0KIHsNCi0tIA0KMS43LjAuNA0K
