Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 May 2013 10:00:55 +0200 (CEST)
Received: from mailout2.samsung.com ([203.254.224.25]:36676 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822679Ab3EBIAvVEmQy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 May 2013 10:00:51 +0200
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MM500JO9VL8XEO0@mailout2.samsung.com> for
 linux-mips@linux-mips.org; Thu, 02 May 2013 17:00:44 +0900 (KST)
Received: from epcpsbgx4.samsung.com ( [203.254.230.43])
        by epcpsbgr4.samsung.com (EPCPMTA) with SMTP id 2D.0A.04074.C2D12815; Thu,
 02 May 2013 17:00:44 +0900 (KST)
X-AuditID: cbfee690-b7f136d000000fea-c9-51821d2c11e5
Received: from epextmailer01 ( [203.254.219.151])
        by epcpsbgx4.samsung.com (EPCPMTA) with SMTP id 19.4C.30241.32D12815; Thu,
 02 May 2013 17:00:35 +0900 (KST)
Date:   Thu, 02 May 2013 08:00:35 +0000 (GMT)
From:   EUNBONG SONG <eunb.song@samsung.com>
Subject: [PATCH] MIPS: Fix build error crash_dump.c file.
To:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-to: eunb.song@samsung.com
MIME-version: 1.0
X-MTR:  20130502075832647@eunb.song
Msgkey: 20130502075832647@eunb.song
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
X-ParentMTR: 
X-ArchiveUser: 
X-CPGSPASS: N
Content-transfer-encoding: base64
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <21270808.191281367481634509.JavaMail.weblogic@epv6ml12>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42I5/e+Ztq6ObFOgwd1NzBYTpk5id2D0OLpy
        LVMAYxSXTUpqTmZZapG+XQJXxuxpexgL5rFVHHpyjqmBsYWti5GTQ0hARaLl/3dGEFtCwERi
        5dZTbBC2mMSFe+uBbC6gmmWMEpfurYcr+tTTyQSRmM8oMf3wBfYuRg4OFqBJM34ngNSwCWhL
        vP3ygBXEFhawlFjVOxXMFhHIkti7ZREziM0s4Cjx6PIdZogj5CUmn77MDmLzCghKnJz5hAVk
        pISAksTSxXUgJq+AssSdiTwQF0hIzJp+gRXC5pWY0f6UBcKWk5j2dQ0zhC0tcX7WBkaYVxZ/
        fwwV55c4dnsHE8R0Xokn94Nhxuze/AXqcwGJqWcOQrWqSxyZ+QdqPJ/EmoVvWWDG7Dq1nBmm
        9/6WuUwQTylKTOl+yA5ha0l8+bGPDdVT7EC2i0RrzQRG5VlIErOQNM9C0oysZgEjyypG0dSC
        5ILipPQiE73ixNzi0rx0veT83E2MkIQwYQfjvQPWhxiTgbExkVlKNDkfmFDySuINjc2MLExN
        TI2NzC3NSBNWEudVb7EOFBJITyxJzU5NLUgtii8qzUktPsTIxMEp1cA4UeeMQvx9/3lM35Q6
        k6X3LAi98PbrfQE96cWL+RfdWMHzQ29HReXP7cX77jU6fHvOzTxz2cOZ14/ltqyT3DqvoLSo
        cbfGi5LNGRO2ix/m+a1x2fjmrsV/v0810rKYlx1+dLflngvb7hWtlXkr277rQJ/0097Al8Ln
        38yb6HpG66J9c0Yw58HoHiWW4oxEQy3mouJEAB9kWGYeAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsVy+t/t6brKsk2BBj8/c1pMmDqJ3YHR4+jK
        tUwBjFEZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlA
        U5UUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkrRRgbGekamJnpGxgZ6JgaxVoYGBkamQFUJ
        GRmzp+1hLJjHVnHoyTmmBsYWti5GTg4hARWJlv/fGUFsCQETiU89nUwQtpjEhXvrgWq4gGrm
        M0pMP3yBvYuRg4MFqGHG7wSQGjYBbYm3Xx6wgtjCApYSq3qngtkiAlkSe7csYgaxmQUcJR5d
        vsMMsUteYvLpy+wgNq+AoMTJmU9YQEZKCChJLF1cB2LyCihL3JnIA3GBhMSs6RdYIWxeiRnt
        T1kgbDmJaV/XMEPY0hLnZ21ghLl48ffHUHF+iWO3dzBBTOeVeHI/GGbM7s1f2CBsAYmpZw5C
        tapLHJn5B2o8n8SahW9ZYMbsOrWcGab3/pa5TBBPKUpM6X7IDmFrSXz5sY8N1VPsQLaLRGvN
        BEa5WUgSs5A0z0LSjKxmASPLKkbR1ILkguKk9AoTveLE3OLSvHS95PzcTYzg1PRsyQ7GhgvW
        hxgFOBiVeHg/6DYGCrEmlhVX5h5ilOBgVhLhXfAaKMSbklhZlVqUH19UmpNafIgxGRh3E5ml
        RJPzgWkzryTe0NjA2NDQ0tzA1NDIgjRhJXHeZ63WgUIC6YklqdmpqQWpRTBbmDg4pRoYJb5s
        +FCh8paDWyi83bnAbEr1usNKXM/qXJ+kvDD69SI8stjgxg6f3oIluvGR4hELoxdFxVT3yPa4
        +sw5fOr/4zuXnq7QM2FUOzi1917nlDCZpl1z2F7Je9vMs7HLV+7afz0g4SuTSOJX/bo18beV
        y3k91rEtXp09538Bg8ISuX2Mdvdqb1UpsRRnJBpqMRcVJwIAUbtVkpEDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Return-Path: <eunb.song@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36305
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

DQpUaGlzIHBhdGNoIGZpeGVzIGNyYXNoX2R1bXAuYyBidWlsZCBlcnJvci4NCg0KU2lnbmVkLW9m
Zi1ieTogRXVuYm9uZyBTb25nIDxldW5iLnNvbmdAc2Ftc3VuZy5jb20+DQotLS0NCiBhcmNoL21p
cHMva2VybmVsL2NyYXNoX2R1bXAuYyB8ICAgIDEgKw0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNl
cnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9taXBzL2tlcm5l
bC9jcmFzaF9kdW1wLmMgYi9hcmNoL21pcHMva2VybmVsL2NyYXNoX2R1bXAuYw0KaW5kZXggMzVi
ZWQwZC4uM2JlOWU3YiAxMDA2NDQNCi0tLSBhL2FyY2gvbWlwcy9rZXJuZWwvY3Jhc2hfZHVtcC5j
DQorKysgYi9hcmNoL21pcHMva2VybmVsL2NyYXNoX2R1bXAuYw0KQEAgLTIsNiArMiw3IEBADQog
I2luY2x1ZGUgPGxpbnV4L2Jvb3RtZW0uaD4NCiAjaW5jbHVkZSA8bGludXgvY3Jhc2hfZHVtcC5o
Pg0KICNpbmNsdWRlIDxhc20vdWFjY2Vzcy5oPg0KKyNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQog
DQogc3RhdGljIGludCBfX2luaXQgcGFyc2Vfc2F2ZW1heG1lbShjaGFyICpwKQ0KIHsNCi0tIA0K
MS43LjAuNA0K
