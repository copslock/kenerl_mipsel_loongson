Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 08:54:35 +0200 (CEST)
Received: from mailout1.samsung.com ([203.254.224.24]:19202 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011234AbaJVGyeNI0bG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 08:54:34 +0200
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NDU0020Z36KBX40@mailout1.samsung.com> for
 linux-mips@linux-mips.org; Wed, 22 Oct 2014 15:54:20 +0900 (KST)
Received: from epcpsbgx1.samsung.com ( [203.254.230.46])
        by epcpsbgr1.samsung.com (EPCPMTA) with SMTP id 67.99.17016.B9457445; Wed,
 22 Oct 2014 15:54:19 +0900 (KST)
X-AuditID: cbfee68d-f79296d000004278-26-5447549bcc51
Received: from epmailer03 ( [203.254.219.143])
        by epcpsbgx1.samsung.com (EPCPMTA) with SMTP id 7F.A6.15273.B9457445; Wed,
 22 Oct 2014 15:54:19 +0900 (KST)
Date:   Wed, 22 Oct 2014 06:54:19 +0000 (GMT)
From:   Eunbong Song <eunb.song@samsung.com>
Subject: Re: Re: [PATCH] mips: add arch_trigger_all_cpu_backtrace() function
To:     John Crispin <blogic@openwrt.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-to: eunb.song@samsung.com
MIME-version: 1.0
X-MTR:  20141022064859326@eunb.song
Msgkey: 20141022064859326@eunb.song
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-MLAttribute: 
X-RootMTR: 20141022064859326@eunb.song
X-ParentMTR: 
X-ArchiveUser: EV
X-CPGSPASS: N
X-ConfirmMail: N,general
Content-transfer-encoding: base64
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <1061520101.169091413960858532.JavaMail.weblogic@epmlwas02b>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsVy+t8zPd3ZIe4hBv2dRhYTpk5id2D0OLpy
        LVMAY1QDo01iUXJGZlmqQmpecn5KZl66rVJoiJuuhZJCRn5xia1StJGBsZ6RqYmekYm5nqVB
        rJWRqZJCXmJuqq1ShS5Ur5JCUXIBUG1uZTHQgJxUPai4XnFqXopDVn4pyCl6xYm5xaV56XrJ
        +blKCmWJOaVAI5T0E6YyZjxZc56xoIOn4syHh+wNjHe4uxg5OYQEVCRa/n9nBLElBEwk9myc
        wgphi0lcuLeerYuRC6hmGaNE85kLLDBFp/5+Y4JonsMoceBBHYjNIqAqMX/Oa7BBbALaEj8O
        XGUGsYUFfCT2TP8IFhcRCJO4engFmM0sUCPR/XcxI8QceYnJpy+zg9i8AoISJ2c+gdqlJPHm
        zD8WiLiyxLrra5gg4hISs6ZfgDqUV2JG+1OoejmJaV/XMEPY0hLnZ21ghHlm8ffHUHF+iWO3
        d0DNEZCYeuYgVI26ROeU2VBz+CTWLHwLZQtKnL7WzQyz6/6WuXA3bG15wgrxi6LElO6H7BC2
        lsSXH/vY0P3CK+Ah0dx0nRkUoBICnRwSazuPsE5gVJqFpG4WklmzkMxCVrOAkWUVo2hqQXJB
        cVJ6kSFydG9ihCTD3h2Mtw9YH2IU4GBU4uF1YHMPEWJNLCuuzD3EmAyMp4nMUqLJ+cCUm1cS
        b2hsZmRhamJqbGRuaYYhbGJqYWFihENYSZxXUepnsJBAemJJanZqakFqUXxRaU5q8SFGJg5O
        qQbGVeH5P1bVt7+ay1Qb1XFtc11ncM4hfX9pzz1mVo92X/ObeSBx/Y0y7hU14c7zPTJ5g/50
        FEZ7nky4ra/85ev3+qvJCTMY9gv6vVjHqxt9Z17eM92rE6L4GeK6n30InLS9dd5E++1OswqE
        HunsC/3UNUdkEfcWr+S7bF8yDhq9XRKd7LvvqaesEktxRqKhFnNRcSIAC31Yyq8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsVy+t/tft3ZIe4hBjMvq1pMmDqJ3YHR4+jK
        tUwBjFEZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlA
        U5UUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkrRRgbGekamJnpGxgZ6JgaxVoYGBkamQFUJ
        GRlP1pxnLOjgqTjz4SF7A+Md7i5GTg4hARWJlv/fGUFsCQETiVN/vzFB2GISF+6tZ4OomcMo
        ceBBHYjNIqAqMX/Oa7B6NgFtiR8HrjKD2MICPhJ7pn8Ei4sIhElcPbwCzGYWqJHo/ruYEWKO
        vMTk05fZQWxeAUGJkzOfsEDsUpJ4c+YfC0RcWWLd9TVQN0hIzJp+gRXC5pWY0f4Uql5OYtrX
        NcwQtrTE+VkbGGFuXvz9MVScX+LY7R1QcwQkpp45CFWjLtE5ZTbUHD6JNQvfQtmCEqevdTPD
        7Lq/ZS7cDVtbnrBC/KIoMaX7ITuErSXx5cc+NnS/8Ap4SDQ3XWeewCg7C0lqFpL2WUjakdUs
        YGRZxSiaWpBcUJyUXmGoV5yYW1yal66XnJ+7iRGcjJ4t3MH45bz1IUYBDkYlHl4HNvcQIdbE
        suLK3EOMEhzMSiK8fRZAId6UxMqq1KL8+KLSnNTiQ4ymwFibyCwlmpwPTJR5JfGGxgbGhoaW
        5gamhkYWSuK8d28mBQkJpCeWpGanphakFsH0MXFwSjUwlhS9eHFNRHglp/YyLz696y2fsmO3
        RO5w2P9LS+b1M16hSo0Nbbu/al68teCJ2yKzZ3NCRN6H2sqz5j3P7bwXIr7zZaTLO2nJ7SLK
        hTd6JZaEsO5gklk3jTPbrJm7s4tloWH8xd7iHTy3g2es/dLsbLfexkhNZsZcJ/9btzwEQ0w/
        pdv36yQrsRRnJBpqMRcVJwIAN0Adx1wDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Return-Path: <eunb.song@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43468
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

DQo+IEhpIEV1Ym9uZywNCg0KPiBvbmUgc21hbGwgcXVlc3Rpb24gaW5saW5lIC4uLg0KDQo+PiAr
dm9pZCBhcmNoX3RyaWdnZXJfYWxsX2NwdV9iYWNrdHJhY2UoYm9vbCk7ICsjZGVmaW5lDQo+PiBh
cmNoX3RyaWdnZXJfYWxsX2NwdV9iYWNrdHJhY2UgYXJjaF90cmlnZ2VyX2FsbF9jcHVfYmFja3Ry
YWNlDQoNCj4gV2hhdCBpcyB0aGUgcHVycG9zZSBvZiB0aGlzIGRlZmluZSA/IGlzIHRoaXMgbWF5
YmUgYSBsZWZ0b3ZlciBmcm9tDQo+IHNvbWUgcmVnZXgvY2xlYW51cHMgPw0KDQpIaSBKb2huLg0K
QWN0dWFsbHksIEkganVzdCBmb2xsb3cgdGhlIHNhbWUgZnVuY3Rpb24gb2Ygc3BhcmMgYXJjaGl0
ZWN0dXJlLg0KWW91IGNhbiBmaW5kIHRoaXMgaW4gYXJjaC9zcGFyYy9pbmNsdWRlL2FzbS9pcnFf
NjQuaCBhcyBiZWxvdw0KDQp2b2lkIGFyY2hfdHJpZ2dlcl9hbGxfY3B1X2JhY2t0cmFjZShib29s
KTsNCiNkZWZpbmUgYXJjaF90cmlnZ2VyX2FsbF9jcHVfYmFja3RyYWNlIGFyY2hfdHJpZ2dlcl9h
bGxfY3B1X2JhY2t0cmFjZQ0KDQpJIGd1ZXNzIHRoaXMgaXMgdXNlZCBmb3IgY29uZGl0aW9uYWwg
Y29tcGlsZS4gDQpTZWUgYmVsb3cuDQppbmNsdWRlL2xpbnV4L25taS5oDQojaWZkZWYgYXJjaF90
cmlnZ2VyX2FsbF9jcHVfYmFja3RyYWNlDQpzdGF0aWMgaW5saW5lIGJvb2wgdHJpZ2dlcl9hbGxf
Y3B1X2JhY2t0cmFjZSh2b2lkKQ0Kew0KICAgICAgICBhcmNoX3RyaWdnZXJfYWxsX2NwdV9iYWNr
dHJhY2UodHJ1ZSk7DQoNCiAgICAgICAgcmV0dXJuIHRydWU7DQp9DQpzdGF0aWMgaW5saW5lIGJv
b2wgdHJpZ2dlcl9hbGxidXRzZWxmX2NwdV9iYWNrdHJhY2Uodm9pZCkNCnsNCiAgICAgICAgYXJj
aF90cmlnZ2VyX2FsbF9jcHVfYmFja3RyYWNlKGZhbHNlKTsNCiAgICAgICAgcmV0dXJuIHRydWU7
DQp9DQojZWxzZQ0Kc3RhdGljIGlubGluZSBib29sIHRyaWdnZXJfYWxsX2NwdV9iYWNrdHJhY2Uo
dm9pZCkNCnsNCiAgICAgICAgcmV0dXJuIGZhbHNlOw0KfQ0Kc3RhdGljIGlubGluZSBib29sIHRy
aWdnZXJfYWxsYnV0c2VsZl9jcHVfYmFja3RyYWNlKHZvaWQpDQp7DQogICAgICAgIHJldHVybiBm
YWxzZTsNCn0NCiNlbmRpZg0KDQpUaGFua3MuIA0KPiBKb2huDQoNCg==
