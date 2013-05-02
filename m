Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 May 2013 09:39:28 +0200 (CEST)
Received: from mailout2.samsung.com ([203.254.224.25]:31990 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825653Ab3EBHjYIUE90 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 May 2013 09:39:24 +0200
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MM500JMZUL6S0M0@mailout2.samsung.com> for
 linux-mips@linux-mips.org; Thu, 02 May 2013 16:39:14 +0900 (KST)
Received: from epcpsbgx4.samsung.com ( [203.254.230.46])
        by epcpsbgr5.samsung.com (EPCPMTA) with SMTP id E5.02.19350.12812815; Thu,
 02 May 2013 16:39:13 +0900 (KST)
X-AuditID: cbfee691-b7fe56d000004b96-c1-51821821fc77
Received: from epextmailer03 ( [203.254.219.153])
        by epcpsbgx4.samsung.com (EPCPMTA) with SMTP id 38.09.30241.12812815; Thu,
 02 May 2013 16:39:13 +0900 (KST)
Date:   Thu, 02 May 2013 07:39:13 +0000 (GMT)
From:   EUNBONG SONG <eunb.song@samsung.com>
Subject: [PATCH] MIPS: remove USB_EHCI_BIG_ENDIAN_{DESC,MMIO} depends on
 architecture symbol
To:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Cc:     florian@openwrt.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-to: eunb.song@samsung.com
MIME-version: 1.0
X-MTR:  20130502073528604@eunb.song
Msgkey: 20130502073528604@eunb.song
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-EPTrCode: 
X-EPTrName: 
X-MLAttribute: 
X-RootMTR: 20130502073528604@eunb.song
X-ParentMTR: 
X-ArchiveUser: 
X-CPGSPASS: N
Content-transfer-encoding: base64
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <26714880.190151367480353110.JavaMail.weblogic@epv6ml12>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsVy+t8zPV1FiaZAg96jJhYTpk5id2D0OLpy
        LVMAYxSXTUpqTmZZapG+XQJXxquPM9kLNvBXdB55x97A+IOvi5GTQ0hARaLl/3dGEFtCwERi
        xdxFbBC2mMSFe+uBbC6gmmWMEsve7mSHKfr4dC4jRGI+o8Th27+YQRIsQJMOv/oM1s0moC3x
        9ssDVhBbWCBG4uyiHrBmEYEsib1bFoHVMwvEShz93MEEcYW8xOTTl8FqeAUEJU7OfMICsUxJ
        4veVoywQcWWJ1g0/oI6QkJg1/QIrhM0rMaP9KVS9nMS0r2uYIWxpifOzNjDCfLP4+2OoOL/E
        sds7gPZygPU+uR8MM2b35i9QzwtITD1zEKpVXeLT3IdQNp/EmoVvWWDG7Dq1nBmm9/6WuUwQ
        bylKTOl+yA5ha0l8+bGPDd1bvAIuEs2n1rNOYFSehSQ1C0n7LCTtyGoWMLKsYhRNLUguKE5K
        LzLVK07MLS7NS9dLzs/dxAhJDRN3MN4/YH2IMRkYJROZpUST84GpJa8k3tDYzMjC1MTU2Mjc
        0ow0YSVxXvUW60AhgfTEktTs1NSC1KL4otKc1OJDjEwcnFINjDmvl6zcy1kjmf6zffs6dkv9
        SfYT5iRrrdtzg+1J1895HqdmpSQkbux2entU4cqWdZ4Wcgf0XhxJULrH/ax/0+WkI8pbdgTx
        znbfPjNUXWrjnu2Schf3LFzHUGKS6PPBcHp7hWty54obt350RjjOuWV3aomOofR94dLTfxyK
        2W+Es/Mu2NS66YsSS3FGoqEWc1FxIgAPXUkBIwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42I5/e/2TF1FiaZAg7V9RhYTpk5id2D0OLpy
        LVMAY1SGTUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7Q
        VCWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVK0kYGxnpGpiZ6RsYGeiUGslaGBgZEpUFVC
        RsarjzPZCzbwV3QeecfewPiDr4uRk0NIQEWi5f93RhBbQsBE4uPTuVC2mMSFe+vZuhi5gGrm
        M0ocvv2LGSTBAtRw+NVnNhCbTUBb4u2XB6wgtrBAjMTZRT3sILaIQJbE3i2LwOqZBWIljn7u
        YIJYJi8x+fRlsBpeAUGJkzOfsEAsU5L4feUoC0RcWaJ1ww92iLiExKzpF1ghbF6JGe1Poerl
        JKZ9XcMMYUtLnJ+1Ae7oxd8fQ8X5JY7d3gG0lwOs98n9YJgxuzd/YYOwBSSmnjkI1aou8Wnu
        QyibT2LNwrcsMGN2nVrODNN7f8tcJoi3FCWmdD9kh7C1JL782MeG7i1eAReJ5lPrWScwys1C
        kpqFpH0WknZkNQsYWVYxiqYWJBcUJ6VXmOgVJ+YWl+al6yXn525iBCepZ0t2MDZcsD7EKMDB
        qMTD+0G3MVCINbGsuDL3EKMEB7OSCO+C10Ah3pTEyqrUovz4otKc1OJDjMnACJzILCWanA9M
        oHkl8YbGBsaGhpbmBqaGRhakCSuJ8z5rtQ4UEkhPLEnNTk0tSC2C2cLEwSnVwLigLHnmI77Z
        ErosHVc/Ps3e4Gy80PBe2j6xoPUnfs141FirKHKS4VBM6eQ7rx+vLpL/sGvO1Wesmznddonf
        70i+J+zAlFGcf72X8bTR3aA2ixbN43mZmgkcSSL5BfOTjRR0L9+4udiNZ6bM86vn7lvsWn2u
        OUrXWetGTUTba9U/v0sOcR4+e1SJpTgj0VCLuag4EQCz1VIClgMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Return-Path: <eunb.song@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36304
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

DQpUaGlzIHBhdGNoIHJlbW92ZXMgdGhlIGFyY2hpdGVjdHVyZSBzcGVjaWZpYyBzeW1ib2xzIHdo
aWNoIHByZXZlbnQgdGhlc2UNCmNvbmZpZ3VyYXRpb24gc3ltYm9scyBmcm9tIGJlaW5nIHNlbGVj
dGVkIGJ5IHBsYXRmb3Jtcy9hcmNoaXRlY3R1cmVzIHJlcXVpcmluZyBpdC4NCkkgcmVmZXJlbmNl
IGNvbW1pdCA5Mjk2ZDk0ZDgzNjQ5ZTFjMmYyNWM4N2RjNGVhZDljMmFiMDczMzA1Lg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBFdW5ib25nIFNvbmcgPGV1bmIuc29uZ0BzYW1zdW5nLmNvbT4NCi0tLQ0KIGFy
Y2gvbWlwcy9LY29uZmlnIHwgICAgNSAtLS0tLQ0KIDEgZmlsZXMgY2hhbmdlZCwgMCBpbnNlcnRp
b25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9taXBzL0tjb25maWcg
Yi9hcmNoL21pcHMvS2NvbmZpZw0KaW5kZXggZTVmMzc5NC4uN2RkM2I2NSAxMDA2NDQNCi0tLSBh
L2FyY2gvbWlwcy9LY29uZmlnDQorKysgYi9hcmNoL21pcHMvS2NvbmZpZw0KQEAgLTM1NSw4ICsz
NTUsNiBAQCBjb25maWcgTUlQU19TRUFEMw0KIAlzZWxlY3QgU1lTX1NVUFBPUlRTX0xJVFRMRV9F
TkRJQU4NCiAJc2VsZWN0IFNZU19TVVBQT1JUU19TTUFSVE1JUFMNCiAJc2VsZWN0IFVTQl9BUkNI
X0hBU19FSENJDQotCXNlbGVjdCBVU0JfRUhDSV9CSUdfRU5ESUFOX0RFU0MNCi0Jc2VsZWN0IFVT
Ql9FSENJX0JJR19FTkRJQU5fTU1JTw0KIAlzZWxlY3QgVVNFX09GDQogCWhlbHANCiAJICBUaGlz
IGVuYWJsZXMgc3VwcG9ydCBmb3IgdGhlIE1JUFMgVGVjaG5vbG9naWVzIFNFQUQzIGV2YWx1YXRp
b24NCkBAIC00MDQsOCArNDAyLDYgQEAgY29uZmlnIFBNQ19NU1ANCiAJc2VsZWN0IElSUV9DUFUN
CiAJc2VsZWN0IFNFUklBTF84MjUwDQogCXNlbGVjdCBTRVJJQUxfODI1MF9DT05TT0xFDQotCXNl
bGVjdCBVU0JfRUhDSV9CSUdfRU5ESUFOX01NSU8NCi0Jc2VsZWN0IFVTQl9FSENJX0JJR19FTkRJ
QU5fREVTQw0KIAloZWxwDQogCSAgVGhpcyBhZGRzIHN1cHBvcnQgZm9yIHRoZSBQTUMtU2llcnJh
IGZhbWlseSBvZiBNdWx0aS1TZXJ2aWNlDQogCSAgUHJvY2Vzc29yIFN5c3RlbS1Pbi1BLUNoaXBz
LiAgVGhlc2UgcGFydHMgaW5jbHVkZSBhIG51bWJlcg0KQEAgLTE0MzUsNyArMTQzMSw2IEBAIGNv
bmZpZyBDUFVfQ0FWSVVNX09DVEVPTg0KIAlzZWxlY3QgQ1BVX1NVUFBPUlRTX0hVR0VQQUdFUw0K
IAlzZWxlY3QgTElCRkRUDQogCXNlbGVjdCBVU0VfT0YNCi0Jc2VsZWN0IFVTQl9FSENJX0JJR19F
TkRJQU5fTU1JTw0KIAloZWxwDQogCSAgVGhlIENhdml1bSBPY3Rlb24gcHJvY2Vzc29yIGlzIGEg
aGlnaGx5IGludGVncmF0ZWQgY2hpcCBjb250YWluaW5nDQogCSAgbWFueSBldGhlcm5ldCBoYXJk
d2FyZSB3aWRnZXRzIGZvciBuZXR3b3JraW5nIHRhc2tzLiBUaGUgcHJvY2Vzc29yDQotLSANCjEu
Ny4wLjQNCg==
