Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 May 2013 03:17:09 +0200 (CEST)
Received: from mailout2.samsung.com ([203.254.224.25]:59676 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825735Ab3EMBRFFmUuT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 May 2013 03:17:05 +0200
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMP006CEQ7GWA90@mailout2.samsung.com> for
 linux-mips@linux-mips.org; Mon, 13 May 2013 10:16:55 +0900 (KST)
Received: from epcpsbgx4.samsung.com ( [203.254.230.45])
        by epcpsbgr1.samsung.com (EPCPMTA) with SMTP id A5.BE.17404.70F30915; Mon,
 13 May 2013 10:16:55 +0900 (KST)
X-AuditID: cbfee68d-b7f096d0000043fc-85-51903f0778e1
Received: from epextmailer01 ( [203.254.219.151])
        by epcpsbgx4.samsung.com (EPCPMTA) with SMTP id 81.9F.30241.70F30915; Mon,
 13 May 2013 10:16:55 +0900 (KST)
Date:   Mon, 13 May 2013 01:16:55 +0000 (GMT)
From:   EUNBONG SONG <eunb.song@samsung.com>
Subject: [PATCH] mips: fix build error for crash_dump.c in 3.10-rc1
To:     "ralf@linux-mips.org" <ralf@linux-mips.org>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-to: eunb.song@samsung.com
MIME-version: 1.0
X-MTR:  20130513011509329@eunb.song
Msgkey: 20130513011509329@eunb.song
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-EPTrCode: 
X-EPTrName: 
X-MLAttribute: 
X-RootMTR: 20130513011509329@eunb.song
X-ParentMTR: 
X-ArchiveUser: 
X-CPGSPASS: N
Content-transfer-encoding: base64
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <175967.10981368407814645.JavaMail.weblogic@epml07>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42I5/e+Zri67/YRAg79bhC0mTJ3E7sDocXTl
        WqYAxigum5TUnMyy1CJ9uwSujGkTZAoWcFY0/+FqYPzD0cXIySEkoCLR8v87I4gtIWAicXPx
        bSYIW0ziwr31bF2MXEA1yxgl/v3tYoIpmnl2KxtE83xGifVHqkBsFgFVia6zJ1lAbDYBbYm3
        Xx6wgtjCAs4SvQ/OgfWKCOhL/D/3lh3EZhaokej+u5gRYo68xOTTl8HivAKCEidnPmGB2KUk
        cX3/AxaIuLLE0vXtzBBxCYlZ0y+wQti8EjPan0LVy0lM+7oGqkZa4vysDYwwzyz+/hgqzi9x
        7PYOoHs4wHqf3A+GGbN78xc2CFtAYuqZg1Ct6hLtNyZC2XwSaxa+ZYEZs+vUcmaY3vtb5jJB
        vKUoMaX7IdSLWhJffuxjQ/UWB5BtL/FmVcwERuVZSDKzkHTPQtKNrGYBI8sqRtHUguSC4qT0
        IkO94sTc4tK8dL3k/NxNjJCU0LuD8fYB60OMycAYmcgsJZqcD0wpeSXxhsZmRhamJqbGRuaW
        ZqQJK4nzqrVYBwoJpCeWpGanphakFsUXleakFh9iZOLglGpgjGrpezujpI0jdvWp6T3BjdZ8
        oiw1aZ8Z5CaW/j21aPLe/dWqIQeUb75/l9rxSExpnYMp1/5Twlu7H2+qnftbR7jz61bnTTnT
        V4dHWCmfDv+ZsnF9U9qx+6Uuu4KyvI9qPF+47hB7icNd2/mu8z4ns2oJXtqtLreOfTbDrWRz
        FqXCWxvebn7HpMRSnJFoqMVcVJwIAAcuoC8fAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsVy+t/t6brs9hMCDY79FLCYMHUSuwOjx9GV
        a5kCGKMybDJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA
        pioplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJWijQyM9YxMTfSMjA30TAxirQwNDIxMgaoS
        MjKmTZApWMBZ0fyHq4HxD0cXIyeHkICKRMv/74wgtoSAicTMs1vZIGwxiQv31rNB1MxnlFh/
        pArEZhFQleg6e5IFxGYT0JZ4++UBK4gtLOAs0fvgHBOILSKgL/H/3Ft2EJtZoEai++9iRog5
        8hKTT18Gi/MKCEqcnPmEBWKXksT1/Q9YIOLKEkvXtzNDxCUkZk2/wAph80rMaH8KVS8nMe3r
        GqgaaYnzszYwwty8+PtjqDi/xLHbO4Du4QDrfXI/GGbM7s1foF4UkJh65iBUq7pE+42JUDaf
        xJqFb1lgxuw6tZwZpvf+lrlMEG8pSkzpfgj1opbElx/72FC9xQFk20u8WRUzgVFuFpLMLCTd
        s5B0I6tZwMiyilE0tSC5oDgpvcJErzgxt7g0L10vOT93EyM4OT1bsoOx4YL1IUYBDkYlHt4F
        yhMChVgTy4orcw8xSnAwK4nwujEAhXhTEiurUovy44tKc1KLDzEmA+NvIrOUaHI+MHHmlcQb
        GhsYGxpamhuYGhpZkCasJM77rNU6UEggPbEkNTs1tSC1CGYLEwenVAOj9Yczj56KOkuu/jf1
        neOSaSJLu/7NC1RP5+aqEWz21W079uDucTaulJd2TZfdrddPPN7omqy90E/vkkCQePqL90mv
        noj2G3Xtv3r1YcPbbSvEF1mYbVb4sERvQqWDvUTvq7XnLl30OtJkb3oj2VLLz3hP7T3tLieR
        O3kvD1hrL9E1ZkxcLq2oxFKckWioxVxUnAgA4VM6OpIDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Return-Path: <eunb.song@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36389
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

DQpUaGlzIHBhdGNoIGZpeGVzIGNyYXNoX2R1bXAuYyBidWlsZCBlcnJvci4gQnVpbGQgZXJyb3Ig
bG9ncyBhcmUgYXMgZm9sbG93Lg0KDQphcmNoL21pcHMva2VybmVsL2NyYXNoX2R1bXAuYzogSW4g
ZnVuY3Rpb24gJ2tkdW1wX2J1Zl9wYWdlX2luaXQnOg0KYXJjaC9taXBzL2tlcm5lbC9jcmFzaF9k
dW1wLmM6Njc6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAna21hbGxv
YycNCmFyY2gvbWlwcy9rZXJuZWwvY3Jhc2hfZHVtcC5jOjY3OiBlcnJvcjogYXNzaWdubWVudCBt
YWtlcyBwb2ludGVyIGZyb20gaW50ZWdlciB3aXRob3V0IGEgY2FzdA0KDQpTaWduZWQtb2ZmLWJ5
OiBFdW5Cb25nIFNvbmcgPGV1bmIuc29uZ0BzYW1zdW5nLmNvbT4NCi0tLQ0KIGFyY2gvbWlwcy9r
ZXJuZWwvY3Jhc2hfZHVtcC5jIHwgICAgMSArDQogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlv
bnMoKyksIDAgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL21pcHMva2VybmVsL2Ny
YXNoX2R1bXAuYyBiL2FyY2gvbWlwcy9rZXJuZWwvY3Jhc2hfZHVtcC5jDQppbmRleCAzNWJlZDBk
Li4zYmU5ZTdiIDEwMDY0NA0KLS0tIGEvYXJjaC9taXBzL2tlcm5lbC9jcmFzaF9kdW1wLmMNCisr
KyBiL2FyY2gvbWlwcy9rZXJuZWwvY3Jhc2hfZHVtcC5jDQpAQCAtMiw2ICsyLDcgQEANCiAjaW5j
bHVkZSA8bGludXgvYm9vdG1lbS5oPg0KICNpbmNsdWRlIDxsaW51eC9jcmFzaF9kdW1wLmg+DQog
I2luY2x1ZGUgPGFzbS91YWNjZXNzLmg+DQorI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCiANCiBz
dGF0aWMgaW50IF9faW5pdCBwYXJzZV9zYXZlbWF4bWVtKGNoYXIgKnApDQogew0KLS0gDQoxLjcu
MC40DQo=
