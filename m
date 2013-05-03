Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 May 2013 09:47:40 +0200 (CEST)
Received: from mailout1.samsung.com ([203.254.224.24]:19211 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822345Ab3ECHrhvvhTK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 May 2013 09:47:37 +0200
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MM7006S2PMPUZ50@mailout1.samsung.com> for
 linux-mips@linux-mips.org; Fri, 03 May 2013 16:47:16 +0900 (KST)
Received: from epcpsbgx2.samsung.com ( [203.254.230.41])
        by epcpsbgr1.samsung.com (EPCPMTA) with SMTP id EC.BE.31024.48B63815; Fri,
 03 May 2013 16:47:16 +0900 (KST)
X-AuditID: cbfee68d-b7f016d000007930-da-51836b84c31e
Received: from epextmailer03 ( [203.254.219.153])
        by epcpsbgx2.samsung.com (EPCPMTA) with SMTP id 1B.2A.15503.48B63815; Fri,
 03 May 2013 16:47:16 +0900 (KST)
Date:   Fri, 03 May 2013 07:47:16 +0000 (GMT)
From:   EUNBONG SONG <eunb.song@samsung.com>
Subject: MIPS : die at free_initmem() function 3.9+
To:     liuj97@gmail.com, "ralf@linux-mips.org" <ralf@linux-mips.org>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        jogo@openwrt.org, david.daney@cavium.com
Reply-to: eunb.song@samsung.com
MIME-version: 1.0
X-MTR:  20130503070831657@eunb.song
Msgkey: 20130503070831657@eunb.song
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-EPTrCode: 
X-EPTrName: 
X-MLAttribute: 
X-RootMTR: 20130503070831657@eunb.song
X-ParentMTR: 
X-ArchiveUser: 
X-CPGSPASS: N
Content-transfer-encoding: base64
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <31174990.226951367567235155.JavaMail.weblogic@epml13>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsVy+t8zTd2W7OZAg1PTxS0mTJ3E7sDocXTl
        WqYAxigum5TUnMyy1CJ9uwSujL7Z21kLWlQqrjw7xtTA2KHcxcjJISSgItHy/zsjiC0hYCLx
        p3MdlC0mceHeerYuRi6gmmWMEs/bHzHBFDX+/cQCkZjPKPGkey9QBwcHC9Ck2x+yQWrYBLQl
        3n55wApiCwsYS6y7vR7MFhHwkPj57QczSC+zwBZGiR3Ll7JBXCEvMfn0ZXYQm1dAUOLkzCcs
        EMuUJB48amaGiCtLTHq+jg0iLiExa/oFVgibV2JG+1OoejmJaV/XMEPY0hLnZ22A+2bx98dQ
        cX6JY7d3MIHcDNL75H4wzJjdm79AjReQmHrmIFSrusSZzTehfueTWLPwLQvMmF2nljPD9N7f
        MheshllAUWJK90N2CFtL4suPfWzo3uIVcJK43vaedQKj8iwkqVlI2mchaUdWs4CRZRWjaGpB
        ckFxUnqRoV5xYm5xaV66XnJ+7iZGSGro3cF4+4D1IcZkYJRMZJYSTc4Hppa8knhDYzMjC1MT
        U2Mjc0sz0oSVxHnVWqwDhQTSE0tSs1NTC1KL4otKc1KLDzEycXBKNTDyGAXuL39V8d5z1j7X
        f+p2q9mazz+eVJAT+DToxJz1Yq75V+8+YJok/aTIqyloS9fnXN1fvy94tMye+zow+5f+hKfP
        lO35C8TvvJ3z0ueLZvhpK+PtCYJHJn3nZNtkMiPqdHVT4O4lbWn2Bz9tfX+ofpei9yPJba8m
        nn267WhA2OHVnYlih34XKbEUZyQaajEXFScCAIxC3NUjAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42I5/e/2TN2W7OZAg8XvhS0mTJ3E7sDocXTl
        WqYAxqgMm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zByg
        qUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6VoIwNjPSNTEz0jYwM9E4NYK0MDAyNToKqE
        jIy+2dtZC1pUKq48O8bUwNih3MXIySEkoCLR8v87I4gtIWAi0fj3EwuELSZx4d56ti5GLqCa
        +YwST7r3AhVxcLAANdz+kA1SwyagLfH2ywNWEFtYwFhi3e31YLaIgIfEz28/mEF6mQW2MErs
        WL6UDWKZvMTk05fZQWxeAUGJkzOfQC1TknjwqJkZIq4sMen5OjaIuITErOkXWCFsXokZ7U+h
        6uUkpn1dwwxhS0ucn7WBEeboxd8fQ8X5JY7d3sEEcjNI75P7wTBjdm/+AjVeQGLqmYNQreoS
        ZzbfZIKw+STWLHzLAjNm16nlzDC997fMBathFlCUmNL9kB3C1pL48mMfG7q3eAWcJK63vWed
        wCg3C0lqFpL2WUjakdUsYGRZxSiaWpBcUJyUXmGkV5yYW1yal66XnJ+7iRGcpJ4t2sH477z1
        IUYBDkYlHl6FlqZAIdbEsuLK3EOMEhzMSiK8bj+AQrwpiZVVqUX58UWlOanFhxiTgRE4kVlK
        NDkfmEDzSuINjQ2MDQ0tzQ1MDY0sSBNWEud91modKCSQnliSmp2aWpBaBLOFiYNTqoExwfvU
        kw2dWucSPvUI3pz65aGE7C8ne9u2Tk0W0YnuHy4/mLJxytGphxeXuDjxiUiq7Duw5FX9Mtmu
        l6qz5E5cXtP4o9ojVt5t44UPu5QqL3mvOlfCrK4fWtdTL/Ih+PVlrl6BidHh/WwnD+4N+JAf
        M921XTLsx6oLxx5sXRX5RmDThNMXXJKslViKMxINtZiLihMBIR4fm5YDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Return-Path: <eunb.song@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36320
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

DQpIZWxsby4gSSB0cnkgdG8gYm9vdCBteSBjYXZpdW0gYm9hcmQgd2l0aCBkYXZpZCdzIHBhdGNo
LiANCkl0J3MgaXMgbm90IGFwcGxpZWQgeWV0IGluIGxpbnV4IHRyZWUsIGkgZ290IHRoZSBwYXRj
aCBmcm9tIG1haWxpbmcgbGlzdC4NCkFuZCB0aGUgcGF0Y2ggaXMgYXMgZm9sbG93Lg0KDQoNClRo
aXMgaXMgb25seSB2ZXJ5IGxpZ2h0bHkgdGVzdGVkLCB3ZSBuZWVkIG1vcmUgdGVzdGluZyBiZWZv
cmUNCmRlY2xhcmluZyBpdCB0aGUgZGVmaW5pdGl2ZSBmaXguDQoNCiBhcmNoL21pcHMva2VybmVs
L2dlbmV4LlMgfCA3ICsrKystLS0NCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9taXBzL2tlcm5lbC9nZW5leC5TIGIv
YXJjaC9taXBzL2tlcm5lbC9nZW5leC5TDQppbmRleCBlY2IzNDdjLi41N2NkYTlhIDEwMDY0NA0K
LS0tIGEvYXJjaC9taXBzL2tlcm5lbC9nZW5leC5TDQorKysgYi9hcmNoL21pcHMva2VybmVsL2dl
bmV4LlMNCkBAIC0xMzIsMTIgKzEzMiwxMyBAQCBMRUFGKHI0a193YWl0KQ0KICAgICAgICAuc2V0
ICAgIG5vcmVvcmRlcg0KICAgICAgICAvKiBzdGFydCBvZiByb2xsYmFjayByZWdpb24gKi8NCiAg
ICAgICAgTE9OR19MICB0MCwgVElfRkxBR1MoJDI4KQ0KLSAgICAgICBub3ANCiAgICAgICAgYW5k
aSAgICB0MCwgX1RJRl9ORUVEX1JFU0NIRUQNCiAgICAgICAgYm5leiAgICB0MCwgMWYNCiAgICAg
ICAgIG5vcA0KLSAgICAgICBub3ANCi0gICAgICAgbm9wDQorICAgICAgIC8qIEVuYWJsZSBpbnRl
cnJ1cHRzIHNvIFdBSVQgd2lsbCBjb21wbGV0ZSAqLw0KKyAgICAgICBtZmMwICAgIHQwLCBDUDBf
U1RBVFVTDQorICAgICAgIG9yaSAgICAgdDAsIFNUMF9JRQ0KKyAgICAgICBtdGMwICAgIHQwLCBD
UDBfU1RBVFVTDQogICAgICAgIC5zZXQgICAgbWlwczMNCiAgICAgICAgd2FpdA0KICAgICAgICAv
KiBlbmQgb2Ygcm9sbGJhY2sgcmVnaW9uICh0aGUgcmVnaW9uIHNpemUgbXVzdCBiZSBwb3dlciBv
ZiB0d28pICovDQoNCkkgdGhpbmssIGl0IHdvcmtzIHdlbGwuIEJ1dCBpIGVuY291bnRlciBhbm90
aGVyIHByb2JsZW0gYXQgZnJlZV9pbml0bWVtKCkuIA0KVGhlIGxvZyBtZXNzYWdlcyBhcmUgYXMg
Zm9sbG93Lg0KDQpbICAxMzIuMTM0NzE5XSBDUFU6IDAgUElEOiAxIENvbW06IHN3YXBwZXIvMCBU
YWludGVkOiBHICAgICAgICBXICAgIDMuOS4wKyAjMjkNClsgIDEzMi4xNDE2NzhdIFN0YWNrIDog
MDAwMDAwMDAwMDAwMDAwNCAwMDAwMDAwMDAwMDAwMDNmIGZmZmZmZmZmODBmYTAwMDAgZmZmZmZm
ZmY4MDI5MjRhOA0KICAgICAgICAgIDAwMDAwMDAwMDAwMDAwMDAgZmZmZmZmZmY4MGZhMDAwMCAw
MDAwMDAwMDAwMDAwMGZmIGZmZmZmZmZmODAyOTM3NjANCiAgICAgICAgICAwMDAwMDAwMDAwMDAw
MDAwIDAwMDAwMDAwMDAwMDAwMDAgZmZmZmZmZmY4MTA4MDAwMCBmZmZmZmZmZjgxMDgwMDAwDQog
ICAgICAgICAgZmZmZmZmZmY4MGUyYmFmMCBmZmZmZmZmZjgwZjkzOTc3IGE4MDAwMDAwNDE0NmNi
YjggMDAwMDAwMDAwMDAwMDAyMA0KICAgICAgICAgIDAwMDAwMDAwMDAwMDAwMDMgMDAwMDAwMDAw
MDAwMDAyMCBhODAwMDAwMDQxNDczZGE4IGZmZmZmZmZmODEwZjAwMDANCiAgICAgICAgICBhODAw
MDAwMDQxNDczYTEwIGZmZmZmZmZmODA2ZWY5MTAgYTgwMDAwMDA0MTQ3MzgyOCBmZmZmZmZmZjgw
MjkwOTIwDQogICAgICAgICAgMDAwMDAwMDAwMDAwMDAwMCBmZmZmZmZmZjgwMjkzYjkwIDAwMDAw
MDAwMDAwMDAwMGEgZmZmZmZmZmY4MGUyYmFmMA0KICAgICAgICAgIDAwMDAwMDAwMDAwMDAwMDAg
YTgwMDAwMDA0MTQ3Mzc1MCAwMDAwMDAwMDQxNDZjZWY4IGZmZmZmZmZmODA1ZTc3OTQNCiAgICAg
ICAgICAwMDAwMDAwMDAwMDAwMDAwIDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAwMDAwMDAwMDAwMCAw
MDAwMDAwMDAwMDAwMDAwDQogICAgICAgICAgMDAwMDAwMDAwMDAwMDAwMCBmZmZmZmZmZjgwMjcy
NDk4IDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAwMDAwMDAwMDAwMA0KICAgICAgICAgIC4uLg0KWyAg
MTMyLjIwNzIwMV0gQ2FsbCBUcmFjZToNClsgIDEzMi4yMDk2NTVdIFs8ZmZmZmZmZmY4MDI3MjQ5
OD5dIHNob3dfc3RhY2srMHg2OC8weDgwDQpbICAxMzIuMjI1OTQzXSBbPGZmZmZmZmZmODAyYmQ0
YWM+XSBub3RpZmllcl9jYWxsX2NoYWluKzB4NWMvMHhhOA0KWyAgMTMyLjIzMTc3Nl0gWzxmZmZm
ZmZmZjgwMmJkYjg0Pl0gX19hdG9taWNfbm90aWZpZXJfY2FsbF9jaGFpbisweDNjLzB4NTgNClsg
IDEzMi4yMzgzOTFdIFs8ZmZmZmZmZmY4MDJiZGJlOD5dIG5vdGlmeV9kaWUrMHgzOC8weDQ4DQpb
ICAxMzIuMjQzNDQyXSBbPGZmZmZmZmZmODAyNzE2Y2M+XSBkaWUrMHg0Yy8weDE0OA0KWyAgMTMy
LjI0Nzk3NF0gWzxmZmZmZmZmZjgwMjdmOTk4Pl0gZG9fcGFnZV9mYXVsdCsweDRiOC8weDUwMA0K
WyAgMTMyLjI1MzQ2MV0gWzxmZmZmZmZmZjgwMjZjNzY0Pl0gcmVzdW1lX3VzZXJzcGFjZV9jaGVj
aysweDAvMHgxMA0KWyAgMTMyLjI1OTQ2OV0gWzxmZmZmZmZmZjgwMzI0YTU0Pl0gZnJlZV9yZXNl
cnZlZF9hcmVhKzB4OGMvMHgxNzgNClsgIDEzMi4yNjUzMDRdIFs8ZmZmZmZmZmY4MDZlMGRjOD5d
IGtlcm5lbF9pbml0KzB4MjAvMHgxMDANClsgIDEzMi4yNzA1MjldIFs8ZmZmZmZmZmY4MDI2Yzdl
MD5dIHJldF9mcm9tX2tlcm5lbF90aHJlYWQrMHgxMC8weDE4DQoNCkFuZCBpIGp1c3QgY2hhbmdl
ZCBmcmVlX2luaXRtZW0oKSBmdW5jdGlvbnMgYXMgZm9sbG93DQoNCmRpZmYgLS1naXQgYS9hcmNo
L21pcHMvbW0vaW5pdC5jIGIvYXJjaC9taXBzL21tL2luaXQuYw0KaW5kZXggOWI5NzNlMC4uZTI0
NmU5YiAxMDA2NDQNCi0tLSBhL2FyY2gvbWlwcy9tbS9pbml0LmMNCisrKyBiL2FyY2gvbWlwcy9t
bS9pbml0LmMNCkBAIC00NDcsNyArNDQ3LDEwIEBAIHZvaWQgZnJlZV9pbml0cmRfbWVtKHVuc2ln
bmVkIGxvbmcgc3RhcnQsIHVuc2lnbmVkIGxvbmcgZW5kKQ0KIHZvaWQgX19pbml0X3JlZm9rIGZy
ZWVfaW5pdG1lbSh2b2lkKQ0KIHsNCiAgICAgICAgcHJvbV9mcmVlX3Byb21fbWVtb3J5KCk7DQot
ICAgICAgIGZyZWVfaW5pdG1lbV9kZWZhdWx0KFBPSVNPTl9GUkVFX0lOSVRNRU0pOw0KKw0KKyAg
ICAgICBmcmVlX2luaXRfcGFnZXMoInVudXNlZCBrZXJuZWwgbWVtb3J5IiwNCisgICAgICAgICAg
ICAgICAgICAgICAgIF9fcGFfc3ltYm9sKCZfX2luaXRfYmVnaW4pLA0KKyAgICAgICAgICAgICAg
ICAgICAgICAgX19wYV9zeW1ib2woJl9faW5pdF9lbmQpKTsNCiB9DQoNCkFmdGVyIHRoYXQgaXQg
d29ya3Mgd2VsbC4gYnV0IGkgZG9uJ3Qga25vdyB3aHkgaXQgd29ya3Mgd2VsbC4NCg0KVGhhbmtz
LiA=
