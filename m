Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 02:09:12 +0100 (CET)
Received: from mailout3.samsung.com ([203.254.224.33]:64651 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012203AbaJ3BJIjFTKd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 02:09:08 +0100
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NE800JK0GJ1CY40@mailout3.samsung.com> for
 linux-mips@linux-mips.org; Thu, 30 Oct 2014 10:09:01 +0900 (KST)
Received: from epcpsbgx3.samsung.com ( [203.254.230.44])
        by epcpsbgr4.samsung.com (EPCPMTA) with SMTP id A7.77.18167.DAF81545; Thu,
 30 Oct 2014 10:09:01 +0900 (KST)
X-AuditID: cbfee690-f79ab6d0000046f7-28-54518fad73ca
Received: from epmailer02 ( [203.254.219.142])
        by epcpsbgx3.samsung.com (EPCPMTA) with SMTP id 11.44.14702.DAF81545; Thu,
 30 Oct 2014 10:09:01 +0900 (KST)
Date:   Thu, 30 Oct 2014 01:09:01 +0000 (GMT)
From:   Eunbong Song <eunb.song@samsung.com>
Subject: [PATCH] staging: octeon-ethernet: disable load balance for receiving
 packet when CONFIG_RPS is enabled.
To:     "ralf@linux-mips.org" <ralf@linux-mips.org>, david.daney@cavium.com
Cc:     gregkh@linuxfoundation.org, linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-to: eunb.song@samsung.com
MIME-version: 1.0
X-MTR:  20141030010643849@eunb.song
Msgkey: 20141030010643849@eunb.song
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-MLAttribute: 
X-RootMTR: 20141030010643849@eunb.song
X-ParentMTR: 
X-ArchiveUser: EV
X-CPGSPASS: N
X-ConfirmMail: N,general
Content-transfer-encoding: base64
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <141769840.281701414631339613.JavaMail.weblogic@epmlwas07d>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsVy+t8zHd21/YEhBvt/81lMmDqJ3YHR4+jK
        tUwBjFENjDaJRckZmWWpCql5yfkpmXnptkqhIW66FkoKGfnFJbZK0UYGxnpGpiZ6RibmepYG
        sVZGpkoKeYm5qbZKFbpQvUoKRckFQLW5lcVAA3JS9aDiesWpeSkOWfmlIKfoFSfmFpfmpesl
        5+cqKZQl5pQCjVDST5jKmPHsRhN7wQPuimPXetkaGLdwdzFycggJqEi0/P/OCGJLCJhI/H63
        EMoWk7hwbz1bFyMXUM0yRolDB06zwxTdPdfBDJGYwyix++RKVpAEi4CqxOvf09hAbDYBbYkf
        B64yg9jCAgUSK7t2gdkiAn4Sx27/ZwdpZhZoY5T4//Y9O8QZ8hKTT18Gs3kFBCVOznzCArFN
        SeLGoxaouLLEhbmHmCHiEhKzpl9ghbB5JWa0P4Wql5OY9nUNVI20xPlZG+DeWfz9MVScH+iI
        HUwQtoDE1DMHoWrUJbZtuc8GYfNJrFn4FmqmoMTpa93MMLvub5nLBHPD1pYnYDcwCyhKTOl+
        yA5ha0l8+bGPDd0vvALuEu1besFBKiEwkUPi7cte5gmMSrOQ1M1CMmsWklnIahYwsqxiFE0t
        SC4oTkovMkGO8E2MkIQ4YQfjvQPWhxgFOBiVeHgd0gJChFgTy4orcw8xJgMjaiKzlGhyPjDt
        5pXEGxqbGVmYmpgaG5lbmmEIm5haWJgY4RBWEud9LfUzWEggPbEkNTs1tSC1KL6oNCe1+BAj
        EwenVANjxtWL5Qxlp6y+/6u7kyWnOnVL4iOPi80+HOueL5g9WWXd2UObIoX6rr+crGhxvJQ5
        y2v9Y3PW9UozHs79ZPSTY8Yhlb1MOgvCFzZPCfZ1jEvad7rDzFGH0/tNjuirBoUWxjP6UUfa
        /p1kS7598MLeB2tP9U06seLR6Vc7fh2Y/49ljXBS+OFVdkosxRmJhlrMRcWJABPcNw6xAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsVy+t/tPt21/YEhBvPm8FhMmDqJ3YHR4+jK
        tUwBjFEZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlA
        U5UUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkrRRgbGekamJnpGxgZ6JgaxVoYGBkamQFUJ
        GRnPbjSxFzzgrjh2rZetgXELdxcjJ4eQgIpEy//vjCC2hICJxN1zHcwQtpjEhXvr2boYuYBq
        5jBK7D65khUkwSKgKvH69zQ2EJtNQFvix4GrYA3CAgUSK7t2gdkiAn4Sx27/ZwdpZhZoY5T4
        //Y9O8Q2eYnJpy+D2bwCghInZz5hgdimJHHjUQtUXFniwtxDUFdISMyafoEVwuaVmNH+FKpe
        TmLa1zVQNdIS52dtYIS5evH3x1BxfqAjdjBB2AISU88chKpRl9i25T4bhM0nsWbhW6iZghKn
        r3Uzw+y6v2UuE8wNW1uegN3ALKAoMaX7ITuErSXx5cc+NnS/8Aq4S7Rv6WWbwCg7C0lqFpL2
        WUjakdUsYGRZxSiaWpBcUJyUXmGsV5yYW1yal66XnJ+7iRGckJ4t3sH4/7z1IUYBDkYlHt4X
        yQEhQqyJZcWVuYcYJTiYlUR4RToCQ4R4UxIrq1KL8uOLSnNSiw8xmgKjbSKzlGhyPjBZ5pXE
        GxobGBsaWpobmBoaWSiJ88bfSgoSEkhPLEnNTk0tSC2C6WPi4JRqYDTbfNrw5o1mPtOkXUd7
        ++q2brKIMuR5z7ut8Ktd3Dr5TM77PUVWutZz1qoanMw/5J3VdP9Qmtt6zshHD3rjzVVmFe9v
        uqvdm7fBY6bFhulLH7iI9WqxHFka9vKibO+GTSxf961ZMbOM0/VC/8aP3LKnw5wDLdwMHle6
        TpG9tlmlfLFIWLudjRJLcUaioRZzUXEiANQcoFBeAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Return-Path: <eunb.song@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43737
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

Ckl0J3MgYmV0dGVyIGRpc2FibGUgbG9hZCBiYWxhbmNlIGZvciByZWNlaXZpbmcgcGFja2V0IHdo
ZW4gQ09ORklHX1JQUyBpcyBlbmFibGVkLgpJZiBub3QsIG9jdGVvbi1ldGhlcm5ldCBkcml2ZXIg
c2VsZWN0IENQVSBhbmQgdGhlbiB0aGUgcnBzIHNlbGVjdCBhZ2FpbiBDUFUuCkl0IGNhbiBiZSBp
cGkgaW50ZXJydXB0cyBvdmVyaGVhZCBhbmQgcGFja2V0IHJlb3JkZXJpbmcgY291bGQgYmUgcG9z
c2libGUuCgpTaWduZWQtb2ZmLWJ5OiBFdW5ib25nIFNvbmcgPGV1bmIuc29uZ0BzYW1zdW5nLmNv
bT4KLS0tCiBkcml2ZXJzL3N0YWdpbmcvb2N0ZW9uL2V0aGVybmV0LXJ4LmMgfCAgICAyICsrCiAx
IGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3N0YWdpbmcvb2N0ZW9uL2V0aGVybmV0LXJ4LmMgYi9kcml2ZXJzL3N0YWdp
bmcvb2N0ZW9uL2V0aGVybmV0LXJ4LmMKaW5kZXggYjJiNmMzYy4uNDRlMzcyZiAxMDA2NDQKLS0t
IGEvZHJpdmVycy9zdGFnaW5nL29jdGVvbi9ldGhlcm5ldC1yeC5jCisrKyBiL2RyaXZlcnMvc3Rh
Z2luZy9vY3Rlb24vZXRoZXJuZXQtcnguYwpAQCAtMjg2LDYgKzI4Niw3IEBAIHN0YXRpYyBpbnQg
Y3ZtX29jdF9uYXBpX3BvbGwoc3RydWN0IG5hcGlfc3RydWN0ICpuYXBpLCBpbnQgYnVkZ2V0KQog
CQkJZGlkX3dvcmtfcmVxdWVzdCA9IDE7CiAJCX0KIAorI2lmbmRlZiBDT05GSUdfUlBTCiAJCWlm
IChyeF9jb3VudCA9PSAwKSB7CiAJCQkvKgogCQkJICogRmlyc3QgdGltZSB0aHJvdWdoLCBzZWUg
aWYgdGhlcmUgaXMgZW5vdWdoCkBAIC0zMDAsNiArMzAxLDcgQEAgc3RhdGljIGludCBjdm1fb2N0
X25hcGlfcG9sbChzdHJ1Y3QgbmFwaV9zdHJ1Y3QgKm5hcGksIGludCBidWRnZXQpCiAJCQlpZiAo
YmFja2xvZyA+IGJ1ZGdldCAqIGNvcmVzX2luX3VzZSAmJiBuYXBpICE9IE5VTEwpCiAJCQkJY3Zt
X29jdF9lbmFibGVfb25lX2NwdSgpOwogCQl9CisjZW5kaWYKIAkJcnhfY291bnQrKzsKIAogCQlz
a2JfaW5faHcgPSBVU0VfU0tCVUZGU19JTl9IVyAmJiB3b3JrLT53b3JkMi5zLmJ1ZnMgPT0gMTsK
LS0gCjEuNy4wLjEK
