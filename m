Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 May 2013 00:39:55 +0200 (CEST)
Received: from mailout4.samsung.com ([203.254.224.34]:41527 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6824793Ab3EEWjxyVnvz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 May 2013 00:39:53 +0200
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMC00B5JKA7FCC0@mailout4.samsung.com> for
 linux-mips@linux-mips.org; Mon, 06 May 2013 07:39:44 +0900 (KST)
Received: from epcpsbgx1.samsung.com ( [203.254.230.45])
        by epcpsbgr5.samsung.com (EPCPMTA) with SMTP id 22.04.19350.0BFD6815; Mon,
 06 May 2013 07:39:44 +0900 (KST)
X-AuditID: cbfee691-b7fe56d000004b96-0b-5186dfb0298b
Received: from epextmailer02 ( [203.254.219.152])
        by epcpsbgx1.samsung.com (EPCPMTA) with SMTP id 49.AD.25608.FAFD6815; Mon,
 06 May 2013 07:39:43 +0900 (KST)
Date:   Sun, 05 May 2013 22:39:43 +0000 (GMT)
From:   EUNBONG SONG <eunb.song@samsung.com>
Subject: Re: Re: MIPS : die at free_initmem() function 3.9+
To:     Jiang Liu <liuj97@gmail.com>
Cc:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jogo@openwrt.org" <jogo@openwrt.org>,
        "david.daney@cavium.com" <david.daney@cavium.com>
Reply-to: eunb.song@samsung.com
MIME-version: 1.0
X-MTR:  20130505223519122@eunb.song
Msgkey: 20130505223519122@eunb.song
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-EPTrCode: 
X-EPTrName: 
X-MLAttribute: 
X-RootMTR: 20130505223519122@eunb.song
X-ParentMTR: 
X-ArchiveUser: 
X-CPGSPASS: N
Content-transfer-encoding: base64
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <21534601.395241367793582818.JavaMail.weblogic@epv6ml08>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42I5/e+Zru6G+22BBk9+M1pMmDqJ3YHR4+jK
        tUwBjFFcNimpOZllqUX6dglcGef/3mMpaGCvaN+7nKWB8QlbFyMnh5CAikTL/++MILaEgInE
        hSuT2SFsMYkL99YD1XAB1SxjlHhyvZ0Fpuhq0wpGiMR8RolnN44xgyRYgCb1THzNBGKzCWhL
        vP3ygBXEFhawlth4cwNYjYiAksSMe0eYQJqZBTqZJF6f+8AKcYa8xOTTl8FW8woISpyc+QRq
        m5LEo9d72CDiyhLzHrawQsQlJGZNvwBl80rMaH8KVS8nMe3rGmYIW1ri/KwNjDDvLP7+GCrO
        L3Hs9g6gIzjAep/cD4YZs3vzFzYIW0Bi6pmDjBAl6hLHvuVBhPkk1ix8ywIzZdep5cwwrfe3
        zAV7nVlAUWJK90N2CFtL4suPfWyovuIAsl0kpp5WmMCoPAtJZhaS7llIupHVLGBkWcUomlqQ
        XFCclF5kqlecmFtcmpeul5yfu4kRkhgm7mC8f8D6EGMyMEYmMkuJJucDE0teSbyhsZmRhamJ
        qbGRuaUZacJK4rzqLdaBQgLpiSWp2ampBalF8UWlOanFhxiZODilGhgvLFYJKnUzTPQx6rpx
        qWeZwDJP5omfFI3vnlo6+R3fX92dbOfs/DZWGDk3Cly6Ps/L+99UxhrJVaxs6lornSaHPtrf
        YsPLq/Jl2a1rU/ok9HK2LHnieyFozt3933eebNwlfjWTz3W+x6FEzZci95Mtdi7dxf70Z7cY
        93ypExfPBgQn/LjJs+uKEktxRqKhFnNRcSIAFqAsAyIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42I5/e/2DN3199sCDdbvsbGYMHUSuwOjx9GV
        a5kCGKMybDJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA
        pioplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJWijQyM9YxMTfSMjA30TAxirQwNDIxMgaoS
        MjLO/73HUtDAXtG+dzlLA+MTti5GTg4hARWJlv/fGUFsCQETiatNK6BsMYkL99YD1XAB1cxn
        lHh24xgzSIIFqKFn4msmEJtNQFvi7ZcHrCC2sIC1xMabG8BqRASUJGbcO8IE0sws0Mkk8frc
        B1aIbfISk09fZgexeQUEJU7OfMICsU1J4tHrPWwQcWWJeQ9bWCHiEhKzpl+AsnklZrQ/haqX
        k5j2dQ0zhC0tcX7WBrirF39/DBXnlzh2ewfQERxgvU/uB8OM2b35CxuELSAx9cxBRogSdYlj
        3/IgwnwSaxa+ZYGZsuvUcmaY1vtb5oK9ziygKDGl+yE7hK0l8eXHPjZUX3EA2S4SU08rTGCU
        m4UkMwtJ9ywk3chqFjCyrGIUTS1ILihOSq8w1CtOzC0uzUvXS87P3cQITlHPFu5g/HLe+hCj
        AAejEg/vjdrWQCHWxLLiytxDjBIczEoivD572wKFeFMSK6tSi/Lji0pzUosPMSYD428is5Ro
        cj4wfeaVxBsaGxgbGlqaG5gaGlmQJqwkzvu01TpQSCA9sSQ1OzW1ILUIZgsTB6dUA6PkLL2j
        BXXS+w1X7HI18JEPzbgyN4957d35u7Z0X9Ppsn2x2uHvzDnXE+5e2hZilqL0tlbtxedFk9Mn
        rNond01Ixfqq9R/BfJ/VRZsO7vwW88x35e/CY4/vvbdpPGlx9FuL6GHJ1hk78h6wZqzP3VJ6
        wOimyh9BvsXXpV8acTr/NXpr2F/y7YesEktxRqKhFnNRcSIAc58l1JUDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Return-Path: <eunb.song@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36325
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

DQo+U28gb24gNjRiaXRzIE1JUFMgcGxhdGZvcm1zLCBfX3ZhKF9fcGEoeCkpIG1heSBub3QgZXF1
YWwgdG8geCwgdGhhdCBtYXkgY2F1c2UNCj50cm91YmxlIHRvIGZyZWVfaW5pdG1lbV9kZWZhdWx0
KCkuIENvdWxkIHlvdSBwbGVhc2UgaGVscCB0byBkbyBhbm90aGVyIHRlc3QNCj5ieSBjaGFuZ2lu
Zw0KPmZyZWVfaW5pdG1lbV9kZWZhdWx0KFBPSVNPTl9GUkVFX0lOSVRNRU0pOw0KPnRvDQo+ZnJl
ZV9pbml0bWVtX2RlZmF1bHQoMCk7DQoNCj5UaGlzIHRlc3QgY291bGQgaGVscCB0byBpZGVudGlm
eSB3aGV0aGVyIHRoaXMgcGFuaWMgaXMgY2F1c2VkIGJ5DQo+bWVtc2V0KCh2b2lkICopcG9zLCBw
b2lzb24sIFBBR0VfU0laRSk7DQo+aW4gZnVuY3Rpb24gZnJlZV9yZXNlcnZlZF9hcmVhKCkuDQoN
CkhlbGxvLCBhcyB5b3Ugc2FpZCBpIGNoYW5nZWQgICJmcmVlX2luaXRtZW1fZGVmYXVsdChQT0lT
T05fRlJFRV9JTklUTUVNKTsiIHRvDQoiZnJlZV9pbml0bWVtX2RlZmF1bHQoMCk7Ii4gUGFuaWMg
c3RpbGwgb2NjdXJyZWQuIA0KQWN0dWFsbHksIGkgcHV0IHRoZSBzb21lIGRlYnVnIG1lc3NhZ2Vz
LiBhbmQgaSBjb25maXJtZWQgcGFuaWMgb2NjdXJzIGluIF9fZnJlZV9yZXNlcnZlZF9wYWdlKCkg
ZnVuY3Rpb24uDQpUaGFua3MhDQoNCg==
