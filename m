Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 08:40:13 +0200 (CEST)
Received: from mailout2.samsung.com ([203.254.224.25]:59742 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011234AbaJVGkLhCAUd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 08:40:11 +0200
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NDU00MUK2IMXK00@mailout2.samsung.com> for
 linux-mips@linux-mips.org; Wed, 22 Oct 2014 15:39:58 +0900 (KST)
Received: from epcpsbgx1.samsung.com ( [203.254.230.41])
        by epcpsbgr3.samsung.com (EPCPMTA) with SMTP id AD.78.18484.C3157445; Wed,
 22 Oct 2014 15:39:56 +0900 (KST)
X-AuditID: cbfee68f-f791c6d000004834-0d-5447513cf34b
Received: from epmailer02 ( [203.254.219.142])
        by epcpsbgx1.samsung.com (EPCPMTA) with SMTP id F8.B4.15273.C3157445; Wed,
 22 Oct 2014 15:39:56 +0900 (KST)
Date:   Wed, 22 Oct 2014 06:39:56 +0000 (GMT)
From:   Eunbong Song <eunb.song@samsung.com>
Subject: [PATCH] mips: add arch_trigger_all_cpu_backtrace() function
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Reply-to: eunb.song@samsung.com
MIME-version: 1.0
X-MTR:  20141022063518502@eunb.song
Msgkey: 20141022063518502@eunb.song
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-MLAttribute: 
X-RootMTR: 20141022063518502@eunb.song
X-ParentMTR: 
X-ArchiveUser: EV
X-CPGSPASS: N
X-ConfirmMail: N,general
Content-transfer-encoding: base64
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <1669712409.167661413959996217.JavaMail.weblogic@epmlwas02b>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsVy+t8zTV2bQPcQgyNNphYTpk5id2D0OLpy
        LVMAY1QDo01iUXJGZlmqQmpecn5KZl66rVJoiJuuhZJCRn5xia1StJGBsZ6RqYmekYm5nqVB
        rJWRqZJCXmJuqq1ShS5Ur5JCUXIBUG1uZTHQgJxUPai4XnFqXopDVn4pyCl6xYm5xaV56XrJ
        +blKCmWJOaVAI5T0E6YyZjQ9OsNSsEq04uuffvYGxgciXYycHEICKhIt/78zdjFycEgImEj8
        WM4GEpYQEJO4cG89kM0FVLKMUeLL0hPsEAkTiTfnt7BAJOYwSnRNPcIEkmARUJXYN20qI4jN
        JqAt8ePAVWYQW1jAReJ1+26wGhEBGYmln66A1TALuEu8/XScGeIIeYnJpy+DLeAVEJQ4OfMJ
        C8RBShKzt7BChJUlFu/8wAhxg4TErOkXWCFsXokZ7U9ZIGw5iWlf1zBD2NIS52dtYIR5ZvH3
        x1Bxfoljt3cwQdgCElPPHISqUZe41PQWyuaTWLPwLdRMQYnT17qZYXbd3zKXCeaGrS1PWCFe
        UZSY0v2QHcLWkvjyYx8bqldAbA+J4+tmM4PCTUJgIofEpLk/WScwKs1CUjcLyaxZSGYhq1nA
        yLKKUTS1ILmgOCm9yBg5tjcxQlJh/w7GuwesDzEKcDAq8fA6sLmHCLEmlhVX5h5iTAZG00Rm
        KdHkfGDCzSuJNzQ2M7IwNTE1NjK3NMMQNjG1sDAxwiGsJM67UOpnsJBAemJJanZqakFqUXxR
        aU5q8SFGJg5OqQbG9Vb1zlllRfPm+LmePvP+Q/PEgzsnv2YszPCpv6Ll+7vdUXd6z6k5O+WU
        1lr7zzbSWtq5b8IX9Y2XbLj19FdJLGmP69lp3b5k6xOLkzs3/zGy3J3wubRieULC7zLrkPi8
        lhUTam0f/rm1Lfeo13eJ24KCvT/NDm8+4i0VWXm8mjtF+fC3coleJZbijERDLeai4kQAd4Mq
        9q4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsVy+t/tPl2bQPcQg8/nDC0mTJ3E7sDocXTl
        WqYAxqgMm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zByg
        qUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6VoIwNjPSNTEz0jYwM9E4NYK0MDAyNToKqE
        jIymR2dYClaJVnz908/ewPhApIuRk0NIQEWi5f93RhBbQsBE4s35LSwQtpjEhXvr2boYuYBq
        5jBKdE09wgSSYBFQldg3bSpYA5uAtsSPA1eZQWxhAReJ1+27wWpEBGQkln66AlbDLOAu8fbT
        cWaIZfISk09fZgexeQUEJU7OfAK0jANomZLE7C2sEGFlicU7P0DdIyExa/oFVgibV2JG+1Oo
        2+Qkpn1dwwxhS0ucn7WBEebmxd8fQ8X5JY7d3sEEYQtITD1zEKpGXeJS01som09izcK3UDMF
        JU5f62aG2XV/y1wmmBu2tjxhhXhFUWJK90N2CFtL4suPfWyoXgGxPSSOr5vNPIFRdhaS1Cwk
        7bOQtCOrWcDIsopRNLUguaA4Kb3CUK84Mbe4NC9dLzk/dxMjOBk9W7iD8ct560OMAhyMSjy8
        DmzuIUKsiWXFlbmHGCU4mJVEePssgEK8KYmVValF+fFFpTmpxYcYTYGRNpFZSjQ5H5go80ri
        DY0NjA0NLc0NTA2NLJTEee/eTAoSEkhPLEnNTk0tSC2C6WPi4JRqYAxt0z1zYuFE1rzH79dK
        /PL0aN1vwPY84skkZvHNP1Qnmbxiyeo7qa1ZkXrRulq447jWuX+PVezrtdq2zAoMKg7uVwir
        MP+SP02RcWXmgYa2bs5Z58ydiuJipM9OZmXMUkvY1f7l96eUtyoqDCWZzw0fls0JSVXVKr7n
        pV2z4vUXJt9D7nLblViKMxINtZiLihMBKrP+/1wDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Return-Path: <eunb.song@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43465
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
IG9mIHNvZnRsb2NrdXAgbm90IGEgaGFyZGxvY2t1cCwgaXQgY291bGQgYmUgcG9zc2libGUgdG8g
ZHVtcCBiYWNrdHJhY2Ugb2YgYWxsIGNwdXMuIGFuZCB0aGlzIGNvdWxkIGJlIGhlbHBmdWwgZm9y
IGRlYnVnZ2luZy4KCmZvciBleGFtcGxlLCBpZiBzeXN0ZW0gaGFzIDIgY3B1cy4KCglDUFUgMAkJ
CQlDUFUgMQogYWNxdWlyZSByZWFkX2xvY2soKQoKCQkJCXRyeSB0byBkbyB3cml0ZV9sb2NrKCkK
CiAsLCwKIG1pc3NpbmcgcmVhZF91bmxvY2soKQoKSW4gdGhpcyBjYXNlLCBzb2Z0bG9ja3VwIHdp
bGwgb2NjdXIgYmVjYXN1c2UgQ1BVIDAgZG9lcyBub3QgY2FsbCByZWFkX3VubG9jaygpLgpBbmQg
ZHVtcF9zdGFjaygpIHByaW50IG9ubHkgYmFja3RyYWNlIGZvciAiQ1BVIDAiLiBJZiBDUFUxJ3Mg
YmFja3RyYWNlIGlzIHByaW50ZWQgaXQncyB2ZXJ5IGhlbHBmdWwuCgpUaGlzIHBhdGNoIGFkZHMg
YXJjaF90cmlnZ2VyX2FsbF9jcHVfYmFja3RyYWNlKCkgZm9yIG1pcHMgYXJjaGl0ZWN0dXJlLgoK
TWF5YmUgc29tZW9uZSBtYWtlIGJldHRlciBwYXRjaCB0aGFuIHRoaXMuIEkganVzdCBzdWdnZXN0
IHRoZSBpZGVhLgotLS0KIGFyY2gvbWlwcy9pbmNsdWRlL2FzbS9pcnEuaCB8ICAgIDMgKysrCiBh
cmNoL21pcHMva2VybmVsL3Byb2Nlc3MuYyAgfCAgIDE4ICsrKysrKysrKysrKysrKysrKwogMiBm
aWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9pcnEuaCBiL2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9p
cnEuaAppbmRleCAzOWYwN2FlLi41YTRlMWJiIDEwMDY0NAotLS0gYS9hcmNoL21pcHMvaW5jbHVk
ZS9hc20vaXJxLmgKKysrIGIvYXJjaC9taXBzL2luY2x1ZGUvYXNtL2lycS5oCkBAIC00OCw0ICs0
OCw3IEBAIGV4dGVybiBpbnQgY3AwX2NvbXBhcmVfaXJxOwogZXh0ZXJuIGludCBjcDBfY29tcGFy
ZV9pcnFfc2hpZnQ7CiBleHRlcm4gaW50IGNwMF9wZXJmY291bnRfaXJxOwogCit2b2lkIGFyY2hf
dHJpZ2dlcl9hbGxfY3B1X2JhY2t0cmFjZShib29sKTsKKyNkZWZpbmUgYXJjaF90cmlnZ2VyX2Fs
bF9jcHVfYmFja3RyYWNlIGFyY2hfdHJpZ2dlcl9hbGxfY3B1X2JhY2t0cmFjZQorCiAjZW5kaWYg
LyogX0FTTV9JUlFfSCAqLwpkaWZmIC0tZ2l0IGEvYXJjaC9taXBzL2tlcm5lbC9wcm9jZXNzLmMg
Yi9hcmNoL21pcHMva2VybmVsL3Byb2Nlc3MuYwppbmRleCA2MzZiMDc0Li45ZjUxZDNkIDEwMDY0
NAotLS0gYS9hcmNoL21pcHMva2VybmVsL3Byb2Nlc3MuYworKysgYi9hcmNoL21pcHMva2VybmVs
L3Byb2Nlc3MuYwpAQCAtNDIsNiArNDIsNyBAQAogI2luY2x1ZGUgPGFzbS9pc2FkZXAuaD4KICNp
bmNsdWRlIDxhc20vaW5zdC5oPgogI2luY2x1ZGUgPGFzbS9zdGFja3RyYWNlLmg+CisjaW5jbHVk
ZSA8YXNtL2lycV9yZWdzLmg+CiAKICNpZmRlZiBDT05GSUdfSE9UUExVR19DUFUKIHZvaWQgYXJj
aF9jcHVfaWRsZV9kZWFkKHZvaWQpCkBAIC01MzIsMyArNTMzLDIwIEBAIHVuc2lnbmVkIGxvbmcg
YXJjaF9hbGlnbl9zdGFjayh1bnNpZ25lZCBsb25nIHNwKQogCiAJcmV0dXJuIHNwICYgQUxNQVNL
OwogfQorCitzdGF0aWMgdm9pZCBhcmNoX2R1bXBfc3RhY2sodm9pZCAqaW5mbykKK3sKKwlzdHJ1
Y3QgcHRfcmVncyAqcmVnczsgIAorCQorCXJlZ3MgPSBnZXRfaXJxX3JlZ3MoKTsKKworCWlmKHJl
Z3MpCisJCXNob3dfcmVncyhyZWdzKTsKKworCWR1bXBfc3RhY2soKTsKK30KKwordm9pZCBhcmNo
X3RyaWdnZXJfYWxsX2NwdV9iYWNrdHJhY2UoYm9vbCBpbmNsdWRlX3NlbGYpCit7CisJc21wX2Nh
bGxfZnVuY3Rpb24oYXJjaF9kdW1wX3N0YWNrLCBOVUxMLCAxKTsKK30KLS0gCjEuNy4wLjEK
