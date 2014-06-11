Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2014 11:25:05 +0200 (CEST)
Received: from mailout3.samsung.com ([203.254.224.33]:13775 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817327AbaFKJZCg6HOL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jun 2014 11:25:02 +0200
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N6Z0078SZHIFX50@mailout3.samsung.com> for
 linux-mips@linux-mips.org; Wed, 11 Jun 2014 18:24:54 +0900 (KST)
Received: from epcpsbgx4.samsung.com ( [203.254.230.46])
        by epcpsbgr3.samsung.com (EPCPMTA) with SMTP id F0.22.14704.46028935; Wed,
 11 Jun 2014 18:24:52 +0900 (KST)
X-AuditID: cbfee68f-b7fef6d000003970-66-53982064be94
Received: from epmailer01 ( [203.254.219.141])
        by epcpsbgx4.samsung.com (EPCPMTA) with SMTP id D0.74.26169.46028935; Wed,
 11 Jun 2014 18:24:52 +0900 (KST)
Date:   Wed, 11 Jun 2014 09:24:52 +0000 (GMT)
From:   Eunbong Song <eunb.song@samsung.com>
Subject: mips: math-emu: Fix compilation error ieee754.c
To:     ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Reply-to: eunb.song@samsung.com
MIME-version: 1.0
X-MTR:  20140611092245298@eunb.song
Msgkey: 20140611092245298@eunb.song
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-EPTrCode: 
X-EPTrName: 
X-MLAttribute: 
X-RootMTR: 20140611092245298@eunb.song
X-ParentMTR: 
X-ArchiveUser: EV
X-CPGSPASS: N
Content-transfer-encoding: base64
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <2463243.264261402478691777.JavaMail.weblogic@epml26>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCJsWRmVeSWpSXmKPExsVy+t8zPd0UhRnBBrf2WVlMmDqJ3YHR4+jK
        tUwBjFENjDaJRckZmWWpCql5yfkpmXnptkqhIW66FkoKGfnFJbZK0UYGxnpGpiZ6RibmepYG
        sVZGpkoKeYm5qbZKFbpQvUoKRckFQLW5lcVAA3JS9aDiesWpeSkOWfmlIKfoFSfmFpfmpesl
        5+cqKZQl5pQCjVDST5jKmNE5fyVbwQeeiiNfzrE1MB7g6WLk5BASUJFo+f+dEcSWEDCRWL2z
        nwnCFpO4cG89WxcjF1DNMkaJv58Os3cxcoAV7TorDxGfwyjx9eYdFpAGFgFViftLf4MNYhPQ
        lvhx4CoziC0sYCHxftJLNhBbREBGYumnK2A1zALuEucX7GCBOEJeYvLpy+wgNq+AoMTJmU9Y
        II5Qkjjb/4gNIq4scbH1HytEXEJi1vQLUDavxIz2p1D1chLTvq5hhrClJc7P2sAI88zi74+h
        4vwSx27vYIL4hVfiyf1gmDG7N39hg7AFJKaeOQjVqi7x994uqDifxJqFb6FWCUqcvtbNDNN7
        f8tcJoi3FCWmdD9kh7C1JL782MeG7i1eAUeJhhm3GScwKs9CkpqFpH0WknZkNQsYWVYxiqYW
        JBcUJ6UXGSNH9iZGSCLs38F494D1Icb9jMA4mcgsJZqcD0yleSXxhsZmRhamJqbGRuaWZhQK
        m5haWJgYUUVYSZz3/sOkICGB9MSS1OzU1ILUovii0pzU4kOMTBycUg2MJrr8RxdfZ9z5g1Pl
        VNhpv5C/256bPZY7eNA4oVQ45PWPt/y+weu4Cu9ck7v3OPyes2vDW4ZwRksv5V21XPf2SWW9
        C7s/r9axMcx1LueGxBWZm4yb+iImnukQypBq2GYlrJLG+/nwlVNxp51WSe35IJ51a33jafnM
        effWB3oudbpztqbmrmGMEktxRqKhFnNRcSIAnnIx3/cDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42I5/e92r26KwoxggwkbzC0mTJ3E7sDocXTl
        WqYAxqgMm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zByg
        qUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6VoIwNjPSNTEz0jYwM9E4NYK0MDAyNToKqE
        jIzO+SvZCj7wVBz5co6tgfEATxcjJ4eQgIpEy//vjF2MHBwSAiYSu87Kg4QlBMQkLtxbz9bF
        yAVUModR4uvNOywgCRYBVYn7S38zgthsAtoSPw5cZQaxhQUsJN5PeskGYosIyEgs/XQFrIZZ
        wF3i/IIdLBC75CUmn77MDmLzCghKnJz5hAVimZLE2f5HbBBxZYmLrf9YIeISErOmX4CyeSVm
        tD+FqpeTmPZ1DTOELS1xftYGRpijF39/DBXnlzh2ewcTxF+8Ek/uB8OM2b35CxuELSAx9cxB
        qFZ1ib/3dkHF+STWLHwLtUpQ4vS1bmaY3vtb5jJBvKUoMaX7ITuErSXx5cc+NnRv8Qo4SjTM
        uM04gVFuFpLULCTts5C0I6tZwMiyilE0tSC5oDgpvcJErzgxt7g0L10vOT93EyM4RT1bsoOx
        4YL1IUYBDkYlHt4DEtODhVgTy4orcw8xSnAwK4nw7hSeESzEm5JYWZValB9fVJqTWnyIMRkY
        gROZpUST84HpM68k3tDYwNjQ0NLcwNTQyII0YSVx3gW3koKEBNITS1KzU1MLUotgtjBxcEo1
        MArqceX0pMzSsFSMPuj12/XXF5/OJ+mntRLuf1lk5ybnIKvOovcofX1wp3S843PXCSHrbP/6
        nP2uk/ZUS0ox9EH06+3lfMtV1W94RTNf+OnkO+9uw7JtVU+un94rF97itemnEGP1E8co+UM8
        57Ys2Sey6eb7NdLsJRWufdKTLHYoFCVvffftjhJLcUaioRZzUXEiAEcNQbqVAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Return-Path: <eunb.song@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40485
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

DQppZWVlNzU0ZHAgaGFzIGJpdGZpZWxkIG1lbWJlciBpbiBzdHJ1Y3Qgd2l0aG91dCBuYW1lLiBB
bmQgdGhpcw0KY2F1c2UgY29tcGlsYXRpb24gZXJyb3IuIFRoaXMgcGF0Y2ggcmVtb3ZlcyBzdHJ1
Y3QgaW4gaWVlZTc1NGRwDQpkZWNsYXJhdGlvbi4gU28gY29tcGlsYXRpb24gZXJyb3IgaXMgZml4
ZWQuDQpTaWduZWQtb2ZmLWJ5OiBFdW5ib25nIFNvbmcgPGV1bmIuc29uZ0BzYW1zdW5nLmNvbT4N
Ci0tLQ0KIGFyY2gvbWlwcy9tYXRoLWVtdS9pZWVlNzU0LmggfCAgIDIwICsrKysrKysrLS0tLS0t
LS0tLS0tDQogMSBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygt
KQ0KZGlmZiAtLWdpdCBhL2FyY2gvbWlwcy9tYXRoLWVtdS9pZWVlNzU0LmggYi9hcmNoL21pcHMv
bWF0aC1lbXUvaWVlZTc1NC5oDQppbmRleCA0M2M0ZmI1Li5jNmUyOGI4IDEwMDY0NA0KLS0tIGEv
YXJjaC9taXBzL21hdGgtZW11L2llZWU3NTQuaA0KKysrIGIvYXJjaC9taXBzL21hdGgtZW11L2ll
ZWU3NTQuaA0KQEAgLTMyLDIyICszMiwxOCBAQA0KICNpbmNsdWRlIDxhc20vYml0ZmllbGQuaD4N
CiANCiB1bmlvbiBpZWVlNzU0ZHAgew0KLSBzdHJ1Y3Qgew0KLSAgX19CSVRGSUVMRF9GSUVMRCh1
bnNpZ25lZCBpbnQgc2lnbjoxLA0KLSAgX19CSVRGSUVMRF9GSUVMRCh1bnNpZ25lZCBpbnQgYmV4
cDoxMSwNCi0gIF9fQklURklFTERfRklFTEQodTY0IG1hbnQ6NTIsDQotICA7KSkpDQotIH07DQor
IF9fQklURklFTERfRklFTEQodW5zaWduZWQgaW50IHNpZ246MSwNCisgX19CSVRGSUVMRF9GSUVM
RCh1bnNpZ25lZCBpbnQgYmV4cDoxMSwNCisgX19CSVRGSUVMRF9GSUVMRCh1NjQgbWFudDo1MiwN
CisgOykpKQ0KICB1NjQgYml0czsNCiB9Ow0KIA0KIHVuaW9uIGllZWU3NTRzcCB7DQotIHN0cnVj
dCB7DQotICBfX0JJVEZJRUxEX0ZJRUxEKHVuc2lnbmVkIHNpZ246MSwNCi0gIF9fQklURklFTERf
RklFTEQodW5zaWduZWQgYmV4cDo4LA0KLSAgX19CSVRGSUVMRF9GSUVMRCh1bnNpZ25lZCBtYW50
OjIzLA0KLSAgOykpKQ0KLSB9Ow0KKyBfX0JJVEZJRUxEX0ZJRUxEKHVuc2lnbmVkIHNpZ246MSwN
CisgX19CSVRGSUVMRF9GSUVMRCh1bnNpZ25lZCBiZXhwOjgsDQorIF9fQklURklFTERfRklFTEQo
dW5zaWduZWQgbWFudDoyMywNCisgOykpKQ0KICB1MzIgYml0czsNCiB9Ow0KIA0KLS0gDQoxLjcu
MC4x
