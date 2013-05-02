Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 May 2013 12:59:48 +0200 (CEST)
Received: from mailout2.samsung.com ([203.254.224.25]:9282 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6835031Ab3EBK7rEzAeD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 May 2013 12:59:47 +0200
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MM600JG03V6S0W0@mailout2.samsung.com> for
 linux-mips@linux-mips.org; Thu, 02 May 2013 19:59:37 +0900 (KST)
Received: from epcpsbgx2.samsung.com ( [203.254.230.43])
        by epcpsbgr1.samsung.com (EPCPMTA) with SMTP id D8.4E.31024.91742815; Thu,
 02 May 2013 19:59:37 +0900 (KST)
X-AuditID: cbfee68d-b7f016d000007930-d7-5182471923b5
Received: from epextmailer03 ( [203.254.219.153])
        by epcpsbgx2.samsung.com (EPCPMTA) with SMTP id BF.AF.15503.91742815; Thu,
 02 May 2013 19:59:37 +0900 (KST)
Date:   Thu, 02 May 2013 10:59:37 +0000 (GMT)
From:   EUNBONG SONG <eunb.song@samsung.com>
Subject: Re: Re: mips; boot fail after merge 3.9+
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jonas Gorski <jogo@openwrt.org>
Cc:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-to: eunb.song@samsung.com
MIME-version: 1.0
X-MTR:  20130502105641445@eunb.song
Msgkey: 20130502105641445@eunb.song
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-EPTrCode: 
X-EPTrName: 
X-MLAttribute: 
X-RootMTR: 20130502105641445@eunb.song
X-ParentMTR: 
X-ArchiveUser: 
X-CPGSPASS: N
Content-transfer-encoding: base64
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <8122455.200971367492376044.JavaMail.weblogic@epml20>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsVy+t8zbV1J96ZAg2t3tC0mTJ3E7sDocXTl
        WqYAxigum5TUnMyy1CJ9uwSujH0d3xgLZrFVbN66jamBsYGti5GTQ0hARaLl/3dGEFtCwERi
        XstNZghbTOLCvfVANVxANcsYJS4vesEMU7Rg6Wp2iMR8Rom/75exgyRYgCb9O7QGzGYT0JZ4
        ++UBK4gtLGAosfnTHyYQW0TAX+Jm0y6wZmaB1YwSbzb3sUKcIS8x+fRlsGZeAUGJkzOfsEBs
        U5LoX3aPESKuLHH13A4miLiExKzpF1ghbF6JGe1PoerlJKZ9XQN1qbTE+VkbGGHeWfz9MVSc
        X+LYbZA5HGC9T+4Hw4zZvfkLG4QtIDH1zEFGiBJ1idkPqiDCfBJrFr5lgZmy69RyZpjW+1vm
        gl3GLKAoMaX7ITuErSXx5cc+NnRf8Qo4Suzpfsc2gVF5FpLULCTts5C0I6tZwMiyilE0tSC5
        oDgpvchQrzgxt7g0L10vOT93EyMkNfTuYLx9wPoQYzIwSiYyS4km5wNTS15JvKGxmZGFqYmp
        sZG5pRlpwkrivGot1oFCAumJJanZqakFqUXxRaU5qcWHGJk4OKUaGE22T3Br22o7Oa7kx8r0
        7P3FH29PLBby+HGf9xifikXSg70XlWqyrCe61zWdeOi+dTrj1ecWnmqTvgueDPoX/PHxt6Xi
        LTznPbc8rl7zceuyTRbX7A6zfvX9uWdjb9Se7RfmhNrbmfTzzfW5tt1IRLDkfUzqjhxPxR8G
        phv37W9Tlq5zPnB4e60SS3FGoqEWc1FxIgDLr1mRIwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42I5/e/2TF1J96ZAg3m9mhYTpk5id2D0OLpy
        LVMAY1SGTUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7Q
        VCWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVK0kYGxnpGpiZ6RsYGeiUGslaGBgZEpUFVC
        Rsa+jm+MBbPYKjZv3cbUwNjA1sXIySEkoCLR8v87I4gtIWAisWDpanYIW0ziwr31QDVcQDXz
        GSX+vl8GlmABavh3aA2YzSagLfH2ywNWEFtYwFBi86c/TCC2iIC/xM2mXewgzcwCqxkl3mzu
        Y4XYJi8x+fRlsGZeAUGJkzOfsEBsU5LoX3aPESKuLHH13A4miLiExKzpF1ghbF6JGe1Poerl
        JKZ9XcMMYUtLnJ+1gRHm6sXfH0PF+SWO3QaZwwHW++R+MMyY3Zu/sEHYAhJTzxxkhChRl5j9
        oAoizCexZuFbFpgpu04tZ4Zpvb9lLthlzAKKElO6H7JD2FoSX37sY0P3Fa+Ao8Se7ndsExjl
        ZiFJzULSPgtJO7KaBYwsqxhFUwuSC4qT0iuM9IoTc4tL89L1kvNzNzGCk9SzRTsY/523PsQo
        wMGoxMP7QbcxUIg1say4MvcQowQHs5II70uzpkAh3pTEyqrUovz4otKc1OJDjMnACJzILCWa
        nA9MoHkl8YbGBsaGhpbmBqaGRhakCSuJ8z5rtQ4UEkhPLEnNTk0tSC2C2cLEwSnVwBjEpVIi
        uukSS9dB6VKuma0PnJMe6ygbfLMNWLw7YGc1x+6d7DN2OHjNmPz72ZRZ26YW6Ii09p4/kiE8
        3XyhRbLA5w11H159+/lf9UHlveWbpqr8k/qje0R9aer2eu+E4Pu/z698s8HpVnb+x9qPNz/e
        Ufoc1iiRWm9VbK9x+hirjZWGUmHMayclluKMREMt5qLiRADGNWAIlgMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Return-Path: <eunb.song@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36313
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

DQo+IERvZXMgdGhlIHBhdGNoIGJlbG93IGZpeCB5b3VyIGlzc3VlID8NCg0KSSBhcHBsaWVkIHlv
dXIgcGF0Y2gsIGJ1dCBpdCBzdGlsbCBmYWlscyB0byBib290LiB0aGUgYm9vdCBsb2dzIGFyZSBz
YW1lLiANCg0KVGhhbmtzDQoNCj4gVGhhbmtzLA0KDQo+IHRnbHgNCg0KPiBkaWZmIC0tZ2l0IGEv
a2VybmVsL2NwdS9pZGxlLmMgYi9rZXJuZWwvY3B1L2lkbGUuYw0KPiBpbmRleCA4Yjg2YzBjLi5h
ODk3MmZlIDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvY3B1L2lkbGUuYw0KPiArKysgYi9rZXJuZWwv
Y3B1L2lkbGUuYw0KPiBAQCAtNzAsOCArNzAsMTAgQEAgc3RhdGljIHZvaWQgY3B1X2lkbGVfbG9v
cCh2b2lkKQ0KPiBjaGVja19wZ3RfY2FjaGUoKTsNCj4gcm1iKCk7DQoNCj4gLSBpZiAoY3B1X2lz
X29mZmxpbmUoc21wX3Byb2Nlc3Nvcl9pZCgpKSkNCj4gKyBpZiAoY3B1X2lzX29mZmxpbmUoc21w
X3Byb2Nlc3Nvcl9pZCgpKSkgew0KPiBhcmNoX2NwdV9pZGxlX2RlYWQoKTsNCj4gKyBjb250aW51
ZTsNCj4gKyB9DQoNCj4gbG9jYWxfaXJxX2Rpc2FibGUoKTsNCj4gYXJjaF9jcHVfaWRsZV9lbnRl
cigpOw==
