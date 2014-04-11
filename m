Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Apr 2014 10:33:16 +0200 (CEST)
Received: from mailout1.samsung.com ([203.254.224.24]:16099 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6832653AbaDKIdGBk6YB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Apr 2014 10:33:06 +0200
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N3U00MFSYEWYBA0@mailout1.samsung.com> for
 linux-mips@linux-mips.org; Fri, 11 Apr 2014 17:32:56 +0900 (KST)
Received: from epcpsbgx2.samsung.com ( [203.254.230.46])
        by epcpsbgr1.samsung.com (EPCPMTA) with SMTP id 1B.C6.12635.6B8A7435; Fri,
 11 Apr 2014 17:32:54 +0900 (KST)
X-AuditID: cbfee68d-b7fcd6d00000315b-9c-5347a8b6e313
Received: from epextmailer03 ( [203.254.219.153])
        by epcpsbgx2.samsung.com (EPCPMTA) with SMTP id 55.C6.09100.6B8A7435; Fri,
 11 Apr 2014 17:32:54 +0900 (KST)
Date:   Fri, 11 Apr 2014 08:32:54 +0000 (GMT)
From:   Eunbong Song <eunb.song@samsung.com>
Subject: [PATCH] MIPS: Octeon: Add PCIe2 support in arch_setup_msi_irq()
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Reply-to: eunb.song@samsung.com
MIME-version: 1.0
X-MTR:  20140411082738059@eunb.song
Msgkey: 20140411082738059@eunb.song
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-EPTrCode: 
X-EPTrName: 
X-MLAttribute: 
X-RootMTR: 20140411082738059@eunb.song
X-ParentMTR: 
X-ArchiveUser: EV
X-CPGSPASS: N
Content-transfer-encoding: base64
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <17481866.160581397205174247.JavaMail.weblogic@epv6ml10>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCJsWRmVeSWpSXmKPExsVy+t8zPd1tK9yDDQ4dsLaYMHUSuwOjx9GV
        a5kCGKMaGG0Si5IzMstSFVLzkvNTMvPSbZVCQ9x0LZQUMvKLS2yVoo0MjPWMTE30jEzM9SwN
        Yq2MTJUU8hJzU22VKnShepUUipILgGpzK4uBBuSk6kHF9YpT81IcsvJLQU7RK07MLS7NS9dL
        zs9VUihLzCkFGqGknzCVMeN4xwnmgl+8FVubT7I2MJ7g7WLk5BASUJFo+f+dEcSWEDCRuPHh
        KzOELSZx4d56ti5GLqCaZYwSf5duZYcp2tY+iRUiMZ9RYuHePqAEBweLgKrEmVcFIDVsAtoS
        Pw5cBRskLOAhcezUZbBeEQEZiaWfroAtYxZwl3j76TgzxBHyEpNPQ9TwCghKnJz5hAVil5LE
        vxPLGCHiyhIXL3xngohLSMyafoEVwuaVmNH+FKpeTmLa1zVQD0hLnJ+1gRHmmcXfH0PF+SWO
        3d7BBHIySO+T+8EwY3Zv/sIGYQtITD1zEKpVXaJn03Go1/kk1ix8C7VKUOL0tW5mmN77W+Yy
        QbylKDGl+yE7hK0l8eXHPjZ0b/EKuEhMevKTdQKj8iwkqVlI2mchaUdWs4CRZRWjaGpBckFx
        UnqRIXJkb2KEJMLeHYy3D1gfYtzPCIySicxSosn5wFSaVxJvaGxmZGFqYmpsZG5pRqGwiamF
        hYkRVYSVxHmTHiYFCQmkJ5akZqemFqQWxReV5qQWH2Jk4uCUamBk/8jYrxR8fzb/l4Zf8o3P
        L+xfIFH1l4c9y2DdV86mNw2hExmnKHVPmLFju+eiFXcn6t/b0Rq8eJGK5X5ZEe1N24zPMfRI
        /m/1K/200iXdiu/HJ9WyDL7ClFqPmT8tfN5e9kj7x+3kzWJm8/97m4e08p3b6xgmafNGZp1J
        XvBSqtp7/RbHVQuVWIozEg21mIuKEwHqN/aL9wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42I5/e/2TN1tK9yDDbbst7CYMHUSuwOjx9GV
        a5kCGKMybDJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA
        pioplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJWijQyM9YxMTfSMjA30TAxirQwNDIxMgaoS
        MjKOd5xgLvjFW7G1+SRrA+MJ3i5GTg4hARWJlv/fGUFsCQETiW3tk1ghbDGJC/fWs3UxcgHV
        zGeUWLi3j72LkYODRUBV4syrApAaNgFtiR8HrjKD2MICHhLHTl1mB7FFBGQkln66AjaTWcBd
        4u2n48wQu+QlJp+GqOEVEJQ4OfMJC8QuJYl/J5YxQsSVJS5e+M4EEZeQmDX9AtQ9vBIz2p9C
        1ctJTPu6hhnClpY4P2sDI8zNi78/horzSxy7vYMJ5GSQ3if3g2HG7N78hQ3CFpCYeuYgVKu6
        RM+m4+wQNp/EmoVvoVYJSpy+1s0M03t/y1wmiLcUJaZ0P2SHsLUkvvzYx4buLV4BF4lJT36y
        TmCUm4UkNQtJ+ywk7chqFjCyrGIUTS1ILihOSq8w0itOzC0uzUvXS87P3cQITlHPFu1g/Hfe
        +hCjAAejEg/vgUtuwUKsiWXFlbmHGCU4mJVEeJ8tcw8W4k1JrKxKLcqPLyrNSS0+xJgMjL+J
        zFKiyfnA9JlXEm9obGBsaGhpbmBqaGRBmrCSOK/8raQgIYH0xJLU7NTUgtQimC1MHJxSDYz3
        93JfXnLJN4hhcvjrGYdC7y8/ufvQp9rZzcnyK2IuPauv2C1xZr5i3Y7y5Y802pT6a1y4F29p
        64vdFnRZeI2j1uuZ94/kzXO4zf/w7A5mk+AV6z4XRXo693v9SnTbZf3cwXqSdtqLHSfb+ads
        WMYR/HfjvKlnUnkzrNfsDv/Ocenks48/xT8/UmIpzkg01GIuKk4EAD195bmVAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Return-Path: <eunb.song@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39774
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

DQpJbiBhcmNoX3NldHVwX21zaV9pcnEoKSwgdGhlcmUgaXMgbm8gY2FzZSBmb3IgUENJZTIuIFNv
IGJvYXJkIHdoaWNoIGhhdmUgUENJZTIgZnVuY3Rpb25hbGl0eQ0KZmFpbHMgdG8gYm9vdCB3aXRo
ICJLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzogYXJjaF9zZXR1cF9tc2lfaXJxOiBJbnZhbGlk
IG9jdGVvbl9kbWFfYmFyX3R5cGUiDQptZXNzYWdlLiBUaGlzIHBhdGNoIHNvbHZlIHRoaXMgcHJv
YmxlbS4NCg0KU2lnbmVkLW9mZi1ieTogRXVuYm9uZyBTb25nIDxldW5iLnNvbmdAc2Ftc3VuZy5j
b20+DQotLS0NCiBhcmNoL21pcHMvcGNpL21zaS1vY3Rlb24uYyB8ICAgIDYgKysrKysrDQogMSBm
aWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1n
aXQgYS9hcmNoL21pcHMvcGNpL21zaS1vY3Rlb24uYyBiL2FyY2gvbWlwcy9wY2kvbXNpLW9jdGVv
bi5jDQppbmRleCAyYjkxYjBlLi5hYjBjNWQxIDEwMDY0NA0KLS0tIGEvYXJjaC9taXBzL3BjaS9t
c2ktb2N0ZW9uLmMNCisrKyBiL2FyY2gvbWlwcy9wY2kvbXNpLW9jdGVvbi5jDQpAQCAtMTUsNiAr
MTUsNyBAQA0KICNpbmNsdWRlIDxhc20vb2N0ZW9uL2N2bXgtbnBpLWRlZnMuaD4NCiAjaW5jbHVk
ZSA8YXNtL29jdGVvbi9jdm14LXBjaS1kZWZzLmg+DQogI2luY2x1ZGUgPGFzbS9vY3Rlb24vY3Zt
eC1ucGVpLWRlZnMuaD4NCisjaW5jbHVkZSA8YXNtL29jdGVvbi9jdm14LXNsaS1kZWZzLmg+DQog
I2luY2x1ZGUgPGFzbS9vY3Rlb24vY3ZteC1wZXhwLWRlZnMuaD4NCiAjaW5jbHVkZSA8YXNtL29j
dGVvbi9wY2ktb2N0ZW9uLmg+DQogDQpAQCAtMTYyLDYgKzE2MywxMSBAQCBtc2lfaXJxX2FsbG9j
YXRlZDoNCiAJCW1zZy5hZGRyZXNzX2xvID0gKDAgKyBDVk1YX05QRUlfUENJRV9NU0lfUkNWKSAm
IDB4ZmZmZmZmZmY7DQogCQltc2cuYWRkcmVzc19oaSA9ICgwICsgQ1ZNWF9OUEVJX1BDSUVfTVNJ
X1JDVikgPj4gMzI7DQogCQlicmVhazsNCisJY2FzZSBPQ1RFT05fRE1BX0JBUl9UWVBFX1BDSUUy
Og0KKwkJLyogV2hlbiB1c2luZyBQQ0llMiwgQmFyIDAgaXMgYmFzZWQgYXQgMCAqLw0KKwkJbXNn
LmFkZHJlc3NfbG8gPSAoMCArIENWTVhfU0xJX1BDSUVfTVNJX1JDVikgJiAweGZmZmZmZmZmOw0K
KwkJbXNnLmFkZHJlc3NfaGkgPSAoMCArIENWTVhfU0xJX1BDSUVfTVNJX1JDVikgPj4gMzI7DQor
CQlicmVhazsNCiAJZGVmYXVsdDoNCiAJCXBhbmljKCJhcmNoX3NldHVwX21zaV9pcnE6IEludmFs
aWQgb2N0ZW9uX2RtYV9iYXJfdHlwZSIpOw0KIAl9DQotLSANCjEuNy4wLjENCg==
