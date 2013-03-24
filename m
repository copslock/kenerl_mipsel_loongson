Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Mar 2013 00:18:47 +0100 (CET)
Received: from mailout2.samsung.com ([203.254.224.25]:18543 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827543Ab3CXXSp2UHBi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Mar 2013 00:18:45 +0100
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MK6004BWU2TO310@mailout2.samsung.com> for
 linux-mips@linux-mips.org; Mon, 25 Mar 2013 08:18:35 +0900 (KST)
Received: from epcpsbgx3.samsung.com ( [203.254.230.43])
        by epcpsbgr1.samsung.com (EPCPMTA) with SMTP id EB.37.20872.BC98F415; Mon,
 25 Mar 2013 08:18:35 +0900 (KST)
X-AuditID: cbfee68d-b7f786d000005188-3c-514f89cbe6ab
Received: from epextmailer01 ( [203.254.219.151])
        by epcpsbgx3.samsung.com (EPCPMTA) with SMTP id 99.3C.05358.BC98F415; Mon,
 25 Mar 2013 08:18:35 +0900 (KST)
Date:   Sun, 24 Mar 2013 23:18:35 +0000 (GMT)
From:   =?euc-kr?B?vNvAurrA?= <eunb.song@samsung.com>
Subject: [PATCH] mips: Fix build error cavium-octeon without CONFIG_SMP
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-to: eunb.song@samsung.com
MIME-version: 1.0
X-MTR:  20130324231407936@eunb.song
Msgkey: 20130324231407936@eunb.song
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-EPTrCode: 
X-EPTrName: 
X-MLAttribute: 
X-RootMTR: 20130324231407936@eunb.song
X-ParentMTR: 
X-ArchiveUser: 
X-CPGSPASS: N
Content-transfer-encoding: base64
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <26870919.16191364167114826.JavaMail.weblogic@epml15>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42I5/e+Ztu7pTv9Ag08HVSwmTJ3E7sDocXTl
        WqYAxigum5TUnMyy1CJ9uwSujEtX37IVXGKvaLnSx9TAuIW9i5GTQ0hARaLl/3dGEFtCwETi
        /Y9jbBC2mMSFe+uBbC6gmmWMEr0vXzDBFL3c/Y8FIjGfUWJW+zPmLkYODhYBVYkTXZ4gNWxA
        NRt+TABbICzgLjHh0nMWEFtEQEZi6acrYMuYBZIlDv09wQpxhLzE5NOXwep5BQQlTs58wgKx
        S0ni74mdbBBxZYmm6+3sEHEJiVnTL7BC2LwSM9qfQtXLSUz7uoYZwpaWOD9rAyPMM4u/P4aK
        80scu72DCeRkkN4n94Nhxuze/AXqdwGJqWcOQrWqS2ze0Qi1lk9izcK3LDBjdp1azgzTe3/L
        XCaItxQlpnQ/ZIewtSS+/NjHhu4tXgFHiWnH97JPYFSehSQ1C0n7LCTtyGoWMLKsYhRNLUgu
        KE5KLzLUK07MLS7NS9dLzs/dxAhJDL07GG8fsD7EmAyMkYnMUqLJ+cDEklcSb2hsZmRhamJq
        bGRuaUaasJI4r1qLdaCQQHpiSWp2ampBalF8UWlOavEhRiYOTqkGxh2hVuvnbZpp+idgY/SF
        LANO0fo32ZfaLom8eRP1gHlF4dIV7Ps3BNkwLLAVVQk8fVLuHdOq2p8Lt9rXneU3f2nzoGrV
        Y7EfViy9d1+Hip+V8pnqmf+d7aDhpa+/7bemLBAJ39fFcSXQjk3ZPNrxmWR8d8Mdof83r828
        uCJtb+DLdu+tYbY2DEosxRmJhlrMRcWJAJKcgIUiAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42I5/e/2dN3Tnf6BBm8WKlhMmDqJ3YHR4+jK
        tUwBjFEZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlA
        U5UUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkrRRgbGekamJnpGxgZ6JgaxVoYGBkamQFUJ
        GRmXrr5lK7jEXtFypY+pgXELexcjJ4eQgIpEy//vjCC2hICJxMvd/1ggbDGJC/fWs3UxcgHV
        zGeUmNX+jLmLkYODRUBV4kSXJ0gNG1D9hh8TwOYIC7hLTLj0HKxXREBGYumnK2AzmQWSJQ79
        PcEKsUteYvLpy2D1vAKCEidnPoHapSTx98RONoi4skTT9XZ2iLiExKzpF1ghbF6JGe1Poerl
        JKZ9XcMMYUtLnJ+1gRHm5sXfH0PF+SWO3d7BBHIySO+T+8EwY3Zv/sIGYQtITD1zEKpVXWLz
        jkaotXwSaxa+ZYEZs+vUcmaY3vtb5jJBvKUoMaX7ITuErSXx5cc+NnRv8Qo4Skw7vpd9AqPc
        LCSpWUjaZyFpR1azgJFlFaNoakFyQXFSeoWxXnFibnFpXrpecn7uJkZwinq2eAfj//PWhxgF
        OBiVeHgFavwDhVgTy4orcw8xSnAwK4nwLvMDCvGmJFZWpRblxxeV5qQWH2JMBsbfRGYp0eR8
        YPrMK4k3NDYwNjS0NDcwNTSyIE1YSZz3Wat1oJBAemJJanZqakFqEcwWJg5OqQbGspzuCUfc
        LVhL6tf9fObJouuZd+PbJZvgSWL8X5ic5J7xP9CY9M7l5LX3u8UDjiiuvZF9V7y9Pmf5eZaQ
        SRtWl2jbrlSrCth/e9UmnZrIxzdE+NWTXrpfvcG2biW3jPnD/zs7uhSVjsRqVYan3mnt8+p8
        qGV100twUuK2azlqbqHVuUa/TzYpsRRnJBpqMRcVJwIAyziy+ZUDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-archive-position: 35970
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
Return-Path: <linux-mips-bounce@linux-mips.org>

DQpUaGlzIHBhdGNoIGZpeGVzIGJ1aWxkIGVycm9yIGNhdml1bS1vY3Rlb24gd2l0aG91dCBDT05G
SUdfU01QDQoNClNpbmdlZC1vZmYtYnk6IEV1bkJvbmcgU29uZzxldW5iLnNvbmdAc2Ftc3VuZy5j
b20+DQoNCi0tLQ0KIGFyY2gvbWlwcy9jYXZpdW0tb2N0ZW9uL3NldHVwLmMgfCAgICA1ICsrKyst
DQogMSBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pDQoNCmRp
ZmYgLS1naXQgYS9hcmNoL21pcHMvY2F2aXVtLW9jdGVvbi9zZXR1cC5jIGIvYXJjaC9taXBzL2Nh
dml1bS1vY3Rlb24vc2V0dXAuYw0KaW5kZXggYzU5NGEzZC4uYjBiYWEyOSAxMDA2NDQNCi0tLSBh
L2FyY2gvbWlwcy9jYXZpdW0tb2N0ZW9uL3NldHVwLmMNCisrKyBiL2FyY2gvbWlwcy9jYXZpdW0t
b2N0ZW9uL3NldHVwLmMNCkBAIC0xNzQsNyArMTc0LDEwIEBAIHN0YXRpYyBpbnQgb2N0ZW9uX2tl
eGVjX3ByZXBhcmUoc3RydWN0IGtpbWFnZSAqaW1hZ2UpDQogDQogc3RhdGljIHZvaWQgb2N0ZW9u
X2dlbmVyaWNfc2h1dGRvd24odm9pZCkNCiB7DQotCWludCBjcHUsIGk7DQorCWludCBpOw0KKyNp
ZmRlZiBDT05GSUdfU01QDQorCWludCBjcHU7DQorI2VuZGlmDQogCXN0cnVjdCBjdm14X2Jvb3Rt
ZW1fZGVzYyAqYm9vdG1lbV9kZXNjOw0KIAl2b2lkICpuYW1lZF9ibG9ja19hcnJheV9wdHI7DQog
DQotLSANCjEuNy4wLjENCg0KVGhhbmtzLg==
