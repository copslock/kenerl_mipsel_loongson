Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 May 2013 11:27:27 +0200 (CEST)
Received: from mailout3.samsung.com ([203.254.224.33]:35037 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6835017Ab3EBJ10Fbe-l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 May 2013 11:27:26 +0200
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MM5009BVZLE2PR0@mailout3.samsung.com> for
 linux-mips@linux-mips.org; Thu, 02 May 2013 18:27:16 +0900 (KST)
Received: from epcpsbgx4.samsung.com ( [203.254.230.41])
        by epcpsbgr2.samsung.com (EPCPMTA) with SMTP id AB.F1.19730.47132815; Thu,
 02 May 2013 18:27:16 +0900 (KST)
X-AuditID: cbfee68e-b7efa6d000004d12-67-518231741e79
Received: from epextmailer01 ( [203.254.219.151])
        by epcpsbgx4.samsung.com (EPCPMTA) with SMTP id AB.D7.30241.17132815; Thu,
 02 May 2013 18:27:14 +0900 (KST)
Date:   Thu, 02 May 2013 09:27:13 +0000 (GMT)
From:   EUNBONG SONG <eunb.song@samsung.com>
Subject: Re: Re: [PATCH] MIPS: remove USB_EHCI_BIG_ENDIAN_{DESC,MMIO} depends
 on architecture symbol
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "florian@openwrt.org" <florian@openwrt.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-to: eunb.song@samsung.com
MIME-version: 1.0
X-MTR:  20130502092239095@eunb.song
Msgkey: 20130502092239095@eunb.song
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-EPTrCode: 
X-EPTrName: 
X-MLAttribute: 
X-RootMTR: 20130502092239095@eunb.song
X-ParentMTR: 
X-ArchiveUser: 
X-CPGSPASS: N
Content-transfer-encoding: base64
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <6623143.198271367486832742.JavaMail.weblogic@epml20>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsVy+t8zTd0Sw6ZAg1tHpC0mTJ3E7sDocXTl
        WqYAxigum5TUnMyy1CJ9uwSujC2Lm5gK7nFUbO44y9zAuIeji5GTQ0hARaLl/3dGEFtCwERi
        ydx7LBC2mMSFe+vZuhi5gGqWMUocm7aXGaZo7oOjUIn5jBI7Tj5iAkmwAE3qn74PbBKbgLbE
        2y8PWEFsYYEUiVWfV4PViAioSnzasYoJpJlZ4BajxIsNB5ghzpCXmHz6MjuIzSsgKHFy5hOo
        M5Qkrl//zgYRV5bY/KmNDSIuITFr+gVWCJtXYkb7U6h6OYlpX9dAXSotcX7WBkaYdxZ/fwwV
        55c4dnsH0BEcYL1P7gfDjNm9+QvUeAGJqWcOQrWqS/QuOgs1nk9izcK3LDBjdp1azgzTe3/L
        XLAfmQUUJaZ0P2SHsLUkvvzYx4buLV4BR4n2/atYJjAqz0KSmoWkfRaSdmQ1CxhZVjGKphYk
        FxQnpRcZ6RUn5haX5qXrJefnbmKEJIe+HYw3D1gfYkwGxslEZinR5HxgcskriTc0NjOyMDUx
        NTYytzQjTVhJnFetxTpQSCA9sSQ1OzW1ILUovqg0J7X4ECMTB6dUA6Pf3y3vPxw9IJJ89fCi
        /rBpMRz+wS9avOVr/mcmiMWsDYjmnLJR7PSWDWe2/Vm3V0gvmlvdQMbgLUtRPWPcIeOXrjuu
        67DF9Dqp3jrovET9UN2NDb51d2ZWvXUpnHXSpuXaKb+3vy9MPbpn78k9Z+0F32cszSvhvP1I
        b2flIf097+6r+HKo2W9VYinOSDTUYi4qTgQAAo1rryQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42I5/e/2dN0Sw6ZAgzMPhSwmTJ3E7sDocXTl
        WqYAxqgMm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zByg
        qUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6VoIwNjPSNTEz0jYwM9E4NYK0MDAyNToKqE
        jIwti5uYCu5xVGzuOMvcwLiHo4uRk0NIQEWi5f93RhBbQsBEYu6Do2wQtpjEhXvrgWwuoJr5
        jBI7Tj5iAkmwADX0T98H1sAmoC3x9ssDVhBbWCBFYtXn1WA1IgKqEp92rGICaWYWuMUo8WLD
        AWaIbfISk09fZgexeQUEJU7OfMICsU1J4vr172wQcWWJzZ/aoK6QkJg1/QIrhM0rMaP9KVS9
        nMS0r2uYIWxpifOzNjDCXL34+2OoOL/Esds7gI7gAOt9cj8YZszuzV+gxgtITD1zEKpVXaJ3
        0Vmo8XwSaxa+ZYEZs+vUcmaY3vtb5oL9yCygKDGl+yE7hK0l8eXHPjZ0b/EKOEq071/FMoFR
        bhaS1Cwk7bOQtCOrWcDIsopRNLUguaA4Kb3CRK84Mbe4NC9dLzk/dxMjOE09W7KDseGC9SFG
        AQ5GJR7eD7qNgUKsiWXFlbmHGCU4mJVEeJPkmwKFeFMSK6tSi/Lji0pzUosPMSYDY3Ais5Ro
        cj4wheaVxBsaGxgbGlqaG5gaGlmQJqwkzvus1TpQSCA9sSQ1OzW1ILUIZgsTB6dUA2O9xax/
        XF0br2Vkm9+apb99od2XWZzfHlkVr+W3sX7q8vRKiOPkCwY/X/+ZIvS55G7PoaRnl4xUw5fY
        vzz207jgwOKJS487Cc+eVC6jNbHmgYtNTf5fu1N/n1Xnutr2TZm/4OlmG/X6Ja7/3JP+9wjU
        hBZWTg7UzEm2PGrI9ovfU/pEHp94QYwSS3FGoqEWc1FxIgAU7VV8lwMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Return-Path: <eunb.song@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36310
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

DQo+VGhlc2UgYXJlIHNlbGVjdHMgYW5kIGRvbid0IHByZXZlbnQgYW55b25lIGVsc2UgZnJvbSBh
bHNvIHNlbGVjdGluZw0KPiB0aGVtLiBJZiB5b3UgbG9vayBhdCB5b3VyIHJlZmVyZW5jZWQgY29t
bWl0LCB5b3Ugc2VlIGl0IHJlbW92ZWQgdGhlDQo+L2RlcGVuZHMvLCBub3QgdGhlIHNlbGVjdHMu
IEl0IGFjdHVhbGx5IGFkZGVkIHNlbGVjdHMgdG8gc2V2ZXJhbA0KPiBwbGF0Zm9ybXMuIFBsYXRm
b3JtcyBhcmUgc3VwcG9zZWQgdG8gc2VsZWN0IHRoZW0gaWYgdGhleSBuZWVkIHRoZW0uDQoNCkhl
bGxvLiANCkV2ZXJ5IHRpbWUgaSBjb25maWcgd2l0aCBhcmNoL21pcHMvY29uZmlncy9jYXZpdW1f
b2N0ZW9uX2RlZmNvbmZpZywgdGhlIGZvbGxvd2luZyB3YXJuaW5nIG1lc3NhZ2VzIA0KYXJlIHNo
b3dlZC4NCndhcm5pbmc6IChNSVBTX1NFQUQzICYmIFBNQ19NU1AgJiYgQ1BVX0NBVklVTV9PQ1RF
T04pIHNlbGVjdHMgVVNCX0VIQ0lfQklHX0VORElBTl9NTUlPIHdoaWNoIGhhcyB1bm1ldCBkaXJl
Y3QgZGVwZW5kZW5jaWVzIChVU0JfU1VQUE9SVCAmJiBVU0IgJiYgVVNCX0VIQ0lfSENEKQ0Kd2Fy
bmluZzogKE1JUFNfU0VBRDMgJiYgUE1DX01TUCAmJiBDUFVfQ0FWSVVNX09DVEVPTikgc2VsZWN0
cyBVU0JfRUhDSV9CSUdfRU5ESUFOX01NSU8gd2hpY2ggaGFzIHVubWV0IGRpcmVjdCBkZXBlbmRl
bmNpZXMgKFVTQl9TVVBQT1JUICYmIFVTQiAmJiBVU0JfRUhDSV9IQ0QpDQoNCkFuZCBhZnRlciBh
cHBseWluZyB0aGlzIHBhdGNoLCB0aGUgd2FybmluZyBtZXNzYWdlcyB3ZXJlIGRpc2FwcGVhcmVk
LiANCg0KDQo+IEpvbmFz
