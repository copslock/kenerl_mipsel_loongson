Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2014 02:48:43 +0200 (CEST)
Received: from mailout2.samsung.com ([203.254.224.25]:45281 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009878AbaJXAslSr9o7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Oct 2014 02:48:41 +0200
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NDX000I2BKX4L10@mailout2.samsung.com> for
 linux-mips@linux-mips.org; Fri, 24 Oct 2014 09:48:33 +0900 (KST)
Received: from epcpsbgx3.samsung.com ( [203.254.230.41])
        by epcpsbgr2.samsung.com (EPCPMTA) with SMTP id E4.15.11124.1E1A9445; Fri,
 24 Oct 2014 09:48:33 +0900 (KST)
X-AuditID: cbfee68e-f79b46d000002b74-75-5449a1e1a439
Received: from epmailer02 ( [203.254.219.142])
        by epcpsbgx3.samsung.com (EPCPMTA) with SMTP id 07.6E.14702.1E1A9445; Fri,
 24 Oct 2014 09:48:33 +0900 (KST)
Date:   Fri, 24 Oct 2014 00:48:33 +0000 (GMT)
From:   Eunbong Song <eunb.song@samsung.com>
Subject: [PATCH resend] mips: add arch_trigger_all_cpu_backtrace() function
To:     "ralf@linux-mips.org" <ralf@linux-mips.org>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-to: eunb.song@samsung.com
MIME-version: 1.0
X-MTR:  20141024004653417@eunb.song
Msgkey: 20141024004653417@eunb.song
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-MLAttribute: 
X-RootMTR: 20141024004653417@eunb.song
X-ParentMTR: 
X-ArchiveUser: EV
X-CPGSPASS: N
X-ConfirmMail: N,general
Content-transfer-encoding: base64
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <1096029731.11011414111712740.JavaMail.weblogic@epmlwas01c>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsVy+t8zTd2HCz1DDB7ME7eYMHUSuwOjx9GV
        a5kCGKMaGG0Si5IzMstSFVLzkvNTMvPSbZVCQ9x0LZQUMvKLS2yVoo0MjPWMTE30jEzM9SwN
        Yq2MTJUU8hJzU22VKnShepUUipILgGpzK4uBBuSk6kHF9YpT81IcsvJLQU7RK07MLS7NS9dL
        zs9VUihLzCkFGqGknzCVMWNa3wS2gjuiFa9utrE1ME4Q7WLk5BASUJFo+f+dEcSWEDCRuHdj
        NzuELSZx4d56ti5GLqCaZYwSe5+tYIYp6nuwmBEiMYdR4tLWd0wgCRYBVYlXGyeygthsAtoS
        Pw5cBWsQFvCR2L1sEliNiIC+xP9zb8E2MAvUSHT/XcwIcYW8xOTTl8HivAKCEidnPmHpYuQA
        WqYk8XCvD0RYWWLTxU8sEDdISMyafoEVwuaVmNH+FCouJzHt6xqoO6Ulzs/awAjzzOLvj6Hi
        /BLHbu9ggrAFJKaeOcgIsUpd4tkvR4gwn8SahW+hRgpKnL7WzQyz6v6WuUwwJ2xtecIK8Ymi
        xJTuh1BfaUl8+bGPDdUnILa7xIX/e1lBwSYhMJVD4ty5E+wTGJVmIambhWTWLCSzkNUsYGRZ
        xSiaWpBcUJyUXmSEHNubGCGpsG8H480D1ocYBTgYlXh4b8zwDBFiTSwrrsw9xJgMjKWJzFKi
        yfnAhJtXEm9obGZkYWpiamxkbmmGIWxiamFhYoRDWEmcN0HqZ7CQQHpiSWp2ampBalF8UWlO
        avEhRiYOTqkGRj/B5wEsMfcqAiY/cbfz88n+XhZf9Xh56f/gx/1a+19vavg9py83If2UqZLL
        1HunJh/5pDH36f0nxy7+W8r3bMLz2EWvZRZM3JWrfuy1ouSBjBTW8pfTw0VcZWcvP1EqcbTN
        4Oi9ktj3cWnV64vnXQsyZLHbrr2P/8/VL4yqU7j4f+8zk1773UGJpTgj0VCLuag4EQCcT70d
        rgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsVy+t/tPt2HCz1DDM72i1hMmDqJ3YHR4+jK
        tUwBjFEZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlA
        U5UUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkrRRgbGekamJnpGxgZ6JgaxVoYGBkamQFUJ
        GRnT+iawFdwRrXh1s42tgXGCaBcjJ4eQgIpEy//vjCC2hICJRN+DxVC2mMSFe+vZuhi5gGrm
        MEpc2vqOCSTBIqAq8WrjRFYQm01AW+LHgavMILawgI/E7mWTwGpEBPQl/p97yw5iMwvUSHT/
        hRgqJCAvMfn0ZbA4r4CgxMmZT1i6GDmAlilJPNzrAxFWlth08RMLxA0SErOmX2CFsHklZrQ/
        hYrLSUz7uoYZwpaWOD9rA9zNi78/horzSxy7vYMJwhaQmHrmICPEKnWJZ78cIcJ8EmsWvoUa
        KShx+lo3M8yq+1vmMsGcsLXlCSvEJ4oSU7ofQn2lJfHlxz42VJ+A2O4SF/7vZZ3AKDsLSWoW
        kvZZSNqR1SxgZFnFKJpakFxQnJReYaxXnJhbXJqXrpecn7uJEZyKni3ewfj/vPUhRgEORiUe
        3hszPEOEWBPLiitzDzFKcDArifAe7wQK8aYkVlalFuXHF5XmpBYfYjQFxtlEZinR5Hxgmswr
        iTc0NjA2NLQ0NzA1NLJQEueNv5UUJCSQnliSmp2aWpBaBNPHxMEp1cAYXcCWyrzu9uQ3C7/Y
        s83hN2HtPe1UvW3jvRnT8z7HMJzRsjr3s+/H/cW9yg+aJL+LTGWbdv/7+pLHXxseGMmtfecp
        k3u2y+rKqzRvHeU7ss9aavLdKoWCL8cES24uuWxoc7rCwsHOg0873+Tt24f349J0mXf4sH9S
        KDlpN32Pf0PgyQXtSz4psRRnJBpqMRcVJwIAj33/+1sDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Return-Path: <eunb.song@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43548
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

CkN1cnJlbnRseSwgYXJjaF90cmlnZ2VyX2FsbF9jcHVfYmFja3RyYWNlKCkgaXMgZGVmaW5lZCBp
biBvbmx5IHg4NiBhbmQgc3BhcmMgd2hpY2ggaGFzIG5taSBpbnRlcnJ1cHQuCkJ1dCBpbiBjYXNl
IG9mIHNvZnRsb2NrdXAgbm90IGEgaGFkcmxvY2t1cCwgaXQgY291bGQgYmUgcG9zc2libGUgdG8g
ZHVtcCBiYWNrdHJhY2Ugb2YgYWxsIGNwdXMuCkFuZCB0aGlzIGNvdWxkIGJlIGhlbHBmdWwgZm9y
IGRlYnVnZ2luZy4KCmZvciBleGFtcGxlLCBpZiBzeXN0ZW0gaGFzIDIgY3B1cy4KCglDUFUgMAkJ
CQlDUFUgMQogYWNxdWlyZSByZWFkX2xvY2soKQoKCQkJCXRyeSB0byBkbyB3cml0ZV9sb2NrKCkK
CiAsLCwKIG1pc3NpbmcgcmVhZF91bmxvY2soKQoKSW4gdGhpcyBjYXNlLCBkdW1wX3N0YWNrKCkg
cHJpbnQgb25seSBiYWNrdHJhY2UgZm9yICJDUFUgMCIuCklmIENQVTEncyBjYWxsdHJhY2UgaXMg
cHJpbnRlZCBpdCdzIHZlcnkgaGVscGZ1bC4KClRoaXMgcGF0Y2ggYWRkcyBhcmNoX3RyaWdnZXJf
YWxsX2NwdV9iYWNrdHJhY2UoKSBmb3IgbWlwcyBhcmNoaXRlY3R1cmUuCkFuZCB0aGlzIGVuYWJs
ZXMgd2hlbiBzb2Z0bG9ja3VwX2FsbF9jcHVfYmFja3RyYWNlIGlzIGVxdWFsdCB0byAxIGFuZApz
b2Z0bG9jayBpcyBvY2N1cnJlZCB0byBkdW1wIGFsbCBjcHUncyBiYWNrdHJhY2UuCgpTaWduZWQt
b2ZmLWJ5OiBFdW5ib25nIFNvbmcgPGV1bmIuc29uZ0BzYW1zdW5nLmNvbT4KLS0tCiBhcmNoL21p
cHMvaW5jbHVkZS9hc20vaXJxLmggfCAgICAzICsrKwogYXJjaC9taXBzL2tlcm5lbC9wcm9jZXNz
LmMgIHwgICAxOCArKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0
aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL21pcHMvaW5jbHVkZS9h
c20vaXJxLmggYi9hcmNoL21pcHMvaW5jbHVkZS9hc20vaXJxLmgKaW5kZXggMzlmMDdhZS4uNWE0
ZTFiYiAxMDA2NDQKLS0tIGEvYXJjaC9taXBzL2luY2x1ZGUvYXNtL2lycS5oCisrKyBiL2FyY2gv
bWlwcy9pbmNsdWRlL2FzbS9pcnEuaApAQCAtNDgsNCArNDgsNyBAQCBleHRlcm4gaW50IGNwMF9j
b21wYXJlX2lycTsKIGV4dGVybiBpbnQgY3AwX2NvbXBhcmVfaXJxX3NoaWZ0OwogZXh0ZXJuIGlu
dCBjcDBfcGVyZmNvdW50X2lycTsKIAordm9pZCBhcmNoX3RyaWdnZXJfYWxsX2NwdV9iYWNrdHJh
Y2UoYm9vbCk7CisjZGVmaW5lIGFyY2hfdHJpZ2dlcl9hbGxfY3B1X2JhY2t0cmFjZSBhcmNoX3Ry
aWdnZXJfYWxsX2NwdV9iYWNrdHJhY2UKKwogI2VuZGlmIC8qIF9BU01fSVJRX0ggKi8KZGlmZiAt
LWdpdCBhL2FyY2gvbWlwcy9rZXJuZWwvcHJvY2Vzcy5jIGIvYXJjaC9taXBzL2tlcm5lbC9wcm9j
ZXNzLmMKaW5kZXggNjM2YjA3NC4uNTgwMWYyMSAxMDA2NDQKLS0tIGEvYXJjaC9taXBzL2tlcm5l
bC9wcm9jZXNzLmMKKysrIGIvYXJjaC9taXBzL2tlcm5lbC9wcm9jZXNzLmMKQEAgLTQyLDYgKzQy
LDcgQEAKICNpbmNsdWRlIDxhc20vaXNhZGVwLmg+CiAjaW5jbHVkZSA8YXNtL2luc3QuaD4KICNp
bmNsdWRlIDxhc20vc3RhY2t0cmFjZS5oPgorI2luY2x1ZGUgPGFzbS9pcnFfcmVncy5oPgogCiAj
aWZkZWYgQ09ORklHX0hPVFBMVUdfQ1BVCiB2b2lkIGFyY2hfY3B1X2lkbGVfZGVhZCh2b2lkKQpA
QCAtNTMyLDMgKzUzMywyMCBAQCB1bnNpZ25lZCBsb25nIGFyY2hfYWxpZ25fc3RhY2sodW5zaWdu
ZWQgbG9uZyBzcCkKIAogCXJldHVybiBzcCAmIEFMTUFTSzsKIH0KKworc3RhdGljIHZvaWQgYXJj
aF9kdW1wX3N0YWNrKHZvaWQgKmluZm8pCit7CisJc3RydWN0IHB0X3JlZ3MgKnJlZ3M7ICAKKwkK
KwlyZWdzID0gZ2V0X2lycV9yZWdzKCk7CisKKwlpZiAocmVncykKKwkJc2hvd19yZWdzKHJlZ3Mp
OworCisJZHVtcF9zdGFjaygpOworfQorCit2b2lkIGFyY2hfdHJpZ2dlcl9hbGxfY3B1X2JhY2t0
cmFjZShib29sIGluY2x1ZGVfc2VsZikKK3sKKwlzbXBfY2FsbF9mdW5jdGlvbihhcmNoX2R1bXBf
c3RhY2ssIE5VTEwsIDEpOworfQotLSAKMS43LjAuMQoK
