Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2014 02:06:31 +0200 (CEST)
Received: from mailout1.samsung.com ([203.254.224.24]:27270 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6843091AbaFLAG220MkL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Jun 2014 02:06:28 +0200
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N7100JN74AK6GA0@mailout1.samsung.com> for
 linux-mips@linux-mips.org; Thu, 12 Jun 2014 09:06:20 +0900 (KST)
Received: from epcpsbgx3.samsung.com ( [203.254.230.46])
        by epcpsbgr3.samsung.com (EPCPMTA) with SMTP id BE.A9.14704.CFEE8935; Thu,
 12 Jun 2014 09:06:20 +0900 (KST)
X-AuditID: cbfee68f-b7fef6d000003970-1e-5398eefce189
Received: from epmailer02 ( [203.254.219.142])
        by epcpsbgx3.samsung.com (EPCPMTA) with SMTP id A5.53.13458.CFEE8935; Thu,
 12 Jun 2014 09:06:20 +0900 (KST)
Date:   Thu, 12 Jun 2014 00:06:20 +0000 (GMT)
From:   Eunbong Song <eunb.song@samsung.com>
Subject: Re: Re: mips: math-emu: Fix compilation error ieee754.c
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Reply-to: eunb.song@samsung.com
MIME-version: 1.0
X-MTR:  20140612000533665@eunb.song
Msgkey: 20140612000533665@eunb.song
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-EPTrCode: 
X-EPTrName: 
X-MLAttribute: 
X-RootMTR: 20140612000533665@eunb.song
X-ParentMTR: 
X-ArchiveUser: EV
X-CPGSPASS: N
Content-transfer-encoding: base64
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <10240088.548381402531578961.JavaMail.weblogic@epml02>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIJsWRmVeSWpSXmKPExsVy+t8zPd0/72YEG/zeY2kxYeokdgdGj6Mr
        1zIFMEY1MNokFiVnZJalKqTmJeenZOal2yqFhrjpWigpZOQXl9gqRRsZGOsZmZroGZmY61ka
        xFoZmSop5CXmptoqVehC9SopFCUXANXmVhYDDchJ1YOK6xWn5qU4ZOWXgpyiV5yYW1yal66X
        nJ+rpFCWmFMKNEJJP2EqY8brYzsZCyoqZn+ZxdbAWNDFyMkhJKAi0fL/OyOILSFgIrHv5BxW
        CFtM4sK99WxdjFxANcsYJaben8IKU3Tx+XsWiMQcRok/y06CJVgEVCX2XNgINolNQFvix4Gr
        zCC2sICDxOW7h8FqRAQ0JDbc3cYOYjML1Eh8u7qPFeIKeYnJpy+DxXkFBCVOznzCArFMSaK5
        6QgjRFxZYsV1iBoJAQmJWdMvQB3EKzGj/SlUvZzEtK9rmCFsaYnzszYwwnyz+PtjqDi/xLHb
        O5i6GDnAep/cD4YZs3vzFzYIW0Bi6pmDjBAl6hK7GnMgwnwSaxa+hdokKHH6WjczTOv9LXOZ
        IL5SlJjS/RDqQy2JLz/2saH6igPIdpLY+8RsAqPyLCSZWUi6ZyHpRlazgJFlFaNoakFyQXFS
        epExckxvYoSkwP4djHcPWB9i3M8IjJGJzFKiyfnAJJpXEm9obGZkYWpiamxkbmlGobCJqYWF
        iRFVhJXEee8/TAoSEkhPLEnNTk0tSC2KLyrNSS0+xMjEwSnVwLgjW8N0Yfgj+/Tbh2eX35+R
        tUnJdct1fcEvXRsvzn34vjRq44T7c80fz0/nuD/Rrkvxyd774swvnVwnNC9TsP32XUguJuHz
        dqPaz5l7Cz9dsRTvzD7+7ejHzVul726x2X+uIWtjRHpVi/rXa3YyH93WeEjf9n3H80J4IdvU
        KetXPT3PUbNxtx2jEktxRqKhFnNRcSIAs5OT2/QDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsVy+t/tPt0/72YEG3SuE7eYMHUSuwOjx9GV
        a5kCGKMybDJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA
        pioplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJWijQyM9YxMTfSMjA30TAxirQwNDIxMgaoS
        MjJeH9vJWFBRMfvLLLYGxoIuRk4OIQEViZb/3xlBbAkBE4mLz9+zQNhiEhfurWfrYuQCqpnD
        KPFn2UlWkASLgKrEngsbwRrYBLQlfhy4ygxiCws4SFy+exisRkRAQ2LD3W3sIDazQI3Et6v7
        WCGWyUtMPn0ZLM4rIChxcuYTqGVKEs1NRxgh4soSK65D1EgISEjMmn6BFcLmlZjR/hSqXk5i
        2tc1zBC2tMT5WRsYYY5e/P0xVJxf4tjtHUxdjBxgvU/uB8OM2b35CxuELSAx9cxBRogSdYld
        jTkQYT6JNQvfQm0SlDh9rZsZpvX+lrlMEF8pSkzpfgj1oZbElx/72FB9xQFkO0nsfWI2gVFu
        FpLMLCTds5B0I6tZwMiyilE0tSC5oDgpvcJYrzgxt7g0L10vOT93EyM4OT1bvIPx/3nrQ4wC
        HIxKPLwMtTOChVgTy4orcw8xSnAwK4nwOp4HCvGmJFZWpRblxxeV5qQWH2JMBkbfRGYp0eR8
        YOLMK4k3NDYwNjS0NDcwNTSyIE1YSZw3/lZSkJBAemJJanZqakFqEcwWJg5OqQbGtH1+ay87
        JkrrzCp5fXqW93R13h+Oog/i5t+Lyv9s2KxzXoP1X25wbYKcdtURh2Vv4qZq/JORXv/rWers
        I6/urpKcYaTw4oW77IV416/LvxsvZNf6sftg5seIqHfblrIWvXkUmfL96I4JHiVJqrb3XD9N
        45dM/uD2mfkD65vw2uYTrbEH3seVK7EUZyQaajEXFScCAItgxPCSAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Return-Path: <eunb.song@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40503
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

DQoNCj4gV2hhdCBnY2MgdmVyc2lvbiBhcmUgeW91IHVzaW5nPw0KDQo+ICBSYWxmDQoNCkkgYW0g
dXNpbmcgZ2NjIDQuNC4xLiANClRoYW5rcy4=
