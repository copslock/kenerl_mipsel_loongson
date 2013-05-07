Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 May 2013 01:12:38 +0200 (CEST)
Received: from mailout1.samsung.com ([203.254.224.24]:49412 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827412Ab3EGXMet0S0W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 May 2013 01:12:34 +0200
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMG001SZB4I0U20@mailout1.samsung.com> for
 linux-mips@linux-mips.org; Wed, 08 May 2013 08:12:26 +0900 (KST)
Received: from epcpsbgx2.samsung.com ( [203.254.230.45])
        by epcpsbgr5.samsung.com (EPCPMTA) with SMTP id AA.71.19350.95A89815; Wed,
 08 May 2013 08:12:25 +0900 (KST)
X-AuditID: cbfee691-b7fe56d000004b96-ec-51898a59d3a0
Received: from epextmailer01 ( [203.254.219.151])
        by epcpsbgx2.samsung.com (EPCPMTA) with SMTP id 3A.B2.15503.95A89815; Wed,
 08 May 2013 08:12:25 +0900 (KST)
Date:   Tue, 07 May 2013 23:12:25 +0000 (GMT)
From:   EUNBONG SONG <eunb.song@samsung.com>
Subject: Re: Re: MIPS: Test reault for  enable interrupts before WAIT
 instruction patch
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     "david.daney@cavium.com" <david.daney@cavium.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "jogo@openwrt.org" <jogo@openwrt.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "manuel.lauss@gmail.com" <manuel.lauss@gmail.com>
Reply-to: eunb.song@samsung.com
MIME-version: 1.0
X-MTR:  20130507230831915@eunb.song
Msgkey: 20130507230831915@eunb.song
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-EPTrCode: 
X-EPTrName: 
X-MLAttribute: 
X-RootMTR: 20130507230831915@eunb.song
X-ParentMTR: 
X-ArchiveUser: 
X-CPGSPASS: N
Content-transfer-encoding: base64
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <28076857.501501367968343732.JavaMail.weblogic@epv6ml01>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsVy+t8zXd3Irs5Ag6+nrC0mTJ3E7sDocXTl
        WqYAxigum5TUnMyy1CJ9uwSujEcTfAr6WCr+v7vF2sD4h7mLkZNDSEBFouX/d0YQW0LAROLr
        swYWCFtM4sK99WxdjFxANcsYJVY9e8IEU/Tmyk0miMR8Rokd7yezgSRYgCZtWdAONolNQFvi
        7ZcHrCC2sEC4xONFU8CaRQR0JVretzGCNDMLvGaSWN+ynQXiDHmJyacvs4PYvAKCEidnPoE6
        Q0ni4s4vbBBxZYmOhldQV0hIzJp+gRXC5pWY0f4Uql5OYtrXNcwQtrTE+VkbGGHeWfz9MVSc
        X+LY7R1AczjAep/cD4YZs3szxCoJAQGJqWcOQrWqS3x51cIOYfNJrFn4lgVmzK5Ty5lheu9v
        mQt2GrOAosSU7ofsELaWxJcf+9jQvcUr4CIx4WwHywRG5VlIUrOQtM9C0o6sZgEjyypG0dSC
        5ILipPQiU73ixNzi0rx0veT83E2MkNQwcQfj/QPWhxiTgXEykVlKNDkfmFrySuINjc2MLExN
        TI2NzC3NSBNWEudVb7EOFBJITyxJzU5NLUgtii8qzUktPsTIxMEp1cDYoN3GnDHn41F/Jdkj
        kk/5ihh6fkcUm8TcF4tyvzPF8lnA7vmMja0Ll/jLaf9mk2kLWSz2ZuthrqqQO505LE/mvbFd
        lTfv7jSJLYVX1tjodnLMKbVdt5nxVu1jG/fuDP7gu8esWELv35q0YpYB4/pCg4muev4VFSoa
        DW3uJ3M6pC5eNQg5vViJpTgj0VCLuag4EQCYrmwZIwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42I5/e/2dN3Irs5AgwcTLS0mTJ3E7sDocXTl
        WqYAxqgMm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zByg
        qUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6VoIwNjPSNTEz0jYwM9E4NYK0MDAyNToKqE
        jIxHE3wK+lgq/r+7xdrA+Ie5i5GTQ0hARaLl/3dGEFtCwETizZWbTBC2mMSFe+vZuhi5gGrm
        M0rseD+ZDSTBAtSwZUE7WAObgLbE2y8PWEFsYYFwiceLpoA1iwjoSrS8b2MEaWYWeM0ksb5l
        OwvENnmJyacvs4PYvAKCEidnPmGB2KYkcXHnFzaIuLJER8MrqCskJGZNv8AKYfNKzGh/ClUv
        JzHt6xpmCFta4vysDYwwVy/+/hgqzi9x7PYOoDkcYL1P7gfDjNm9GWKVhICAxNQzB6Fa1SW+
        vGphh7D5JNYsfMsCM2bXqeXMML33t8wFO41ZQFFiSvdDdghbS+LLj31s6N7iFXCRmHC2g2UC
        o9wsJKlZSNpnIWlHVrOAkWUVo2hqQXJBcVJ6hZFecWJucWleul5yfu4mRnCSerZoB+O/89aH
        GAU4GJV4eC24OwOFWBPLiitzDzFKcDArifCWFQCFeFMSK6tSi/Lji0pzUosPMSYDY3Ais5Ro
        cj4wgeaVxBsaGxgbGlqaG5gaGlmQJqwkzvus1TpQSCA9sSQ1OzW1ILUIZgsTB6dUA+OsC0ba
        FudY9n+4OjV3zgzOwqvfatbf/C7e8Chu+tSAqB3eRR+Kvgov8G/4PmX+b+H5hvfu7RS6tfWC
        /rJVZV/f3F7ewjVz/ud4FrGZl7REnZZ/yZk6p9/ruPXEuS7Pdsjk/eYtW6N9ntv+drzTq0XH
        2cXVzgav652e5yf+9sqzvm3NF6Ibk46LKbEUZyQaajEXFScCAGDtseSWAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Return-Path: <eunb.song@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36353
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

DQoNCj4+IA0KPj4gSGVsbG8uIEkgIHRlc3RlZCB3aXRoIHR3byBwYXRjaGVzLg0KPj4gVGhlIGZp
cnN0IG9uZSBpcyB0aG9tYXMgZ2xlaXhuZXIncyBwYXRjaC4gVGhlIHBhdGNoIGlzIGFzIGZvbGxv
dy4NCj4+IFRoaXMgcGF0Y2ggd29ya3Mgd2VsbCB3aXRob3V0IGFueSBwcm9ibGVtLg0KDQo+WW91
IGRvbid0IG5lZWQgdGhlbSBib3RoLiAgV2hlbiB3ZSBmaXggaXQsIGl0IHdpbGwgYmUgb25lIG9y
IHRoZSBvdGhlciwNCj5ub3QgYm90aC4NCg0KSGVsbG8uIERhdmlkLg0KTWF5YmUgaSBkaWRuJ3Qg
d3JpdGUgY2xlYXJseSBmb3IgdGVzdCByZXN1bHQuIEkgbWVhbnQgaSBhcHBsaWVkIG9ubHkgb25l
IHBhdGNoZSBmb3IgZWFjaCB0ZXN0Lg0KDQpUaGFua3MuIA0KDQo=
