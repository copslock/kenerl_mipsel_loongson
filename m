Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 May 2013 01:27:35 +0200 (CEST)
Received: from mailout4.samsung.com ([203.254.224.34]:25612 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823763Ab3EHX1asHG9R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 May 2013 01:27:30 +0200
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMI00MNV6HENI40@mailout4.samsung.com> for
 linux-mips@linux-mips.org; Thu, 09 May 2013 08:27:15 +0900 (KST)
Received: from epcpsbgx4.samsung.com ( [203.254.230.46])
        by epcpsbgr3.samsung.com (EPCPMTA) with SMTP id 55.EE.13955.35FDA815; Thu,
 09 May 2013 08:27:15 +0900 (KST)
X-AuditID: cbfee68f-b7f066d000003683-29-518adf5392f4
Received: from epextmailer03 ( [203.254.219.153])
        by epcpsbgx4.samsung.com (EPCPMTA) with SMTP id 4D.34.30241.35FDA815; Thu,
 09 May 2013 08:27:15 +0900 (KST)
Date:   Wed, 08 May 2013 23:27:15 +0000 (GMT)
From:   EUNBONG SONG <eunb.song@samsung.com>
Subject: Fwd: [PATCH v2] MIPS: Make virt_to_phys() work for all unmapped
 addresses.
To:     David Daney <ddaney.cavm@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Cc:     Jiang Liu <liuj97@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Reply-to: eunb.song@samsung.com
MIME-version: 1.0
X-MTR:  20130508232513655@eunb.song
Msgkey: 20130508232513655@eunb.song
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-EPTrCode: 
X-EPTrName: 
X-MLAttribute: 
X-RootMTR: 20130508232513655@eunb.song
X-ParentMTR: 
X-ArchiveUser: 
X-CPGSPASS: N
Content-transfer-encoding: base64
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <20691271.332801368055634504.JavaMail.weblogic@epml11>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42I5/e+Znm7w/a5Ag5c/+CwmTJ3E7sDocXTl
        WqYAxigum5TUnMyy1CJ9uwSujA9d8gVNzBVfrx1gb2D8wtTFyMkhJKAi0fL/OyOILSFgIvHk
        zStmCFtM4sK99WxdjFxANcsYJWZ9ec4KU9TS9YIFIjGfUeJ492KwbhagSV93/WcHsdkEtCXe
        fnkA1iAsECzRfW0CI0iDiMBkRom3l1+CJZgFehklnt+3gDhDXmLy6ctgzbwCghInZz5hgdim
        JHHx/lNmiLiyxJbff6FOlZCYNf0C1EW8EjPan0LVy0lM+7oG6gVpifOzNjDCvLP4+2OoOL/E
        sds7gN7nAOt9cj8YZszuzV/YIGwBialnDkK1qkv0/fvABGHzSaxZ+JYFZsyuU8uZYXrvb5nL
        BPGWosSU7ofsELaWxJcf+9hQvcUBZDtJvH4YM4FReRaSzCwk3bOQdCOrWcDIsopRNLUguaA4
        Kb3IWK84Mbe4NC9dLzk/dxMjJDH072C8e8D6EGMyMEomMkuJJucDE0teSbyhsZmRhamJqbGR
        uaUZacJK4rxqLdaBQgLpiSWp2ampBalF8UWlOanFhxiZODilGhiT/B9dWtmxhGWZD9fRy6pf
        llyvsr0gMdOKr4nZNW5qbuWfn1dTPv1Pb0qYyWb3xCB/St42I7fmv6lvCv6tuTdhta30gdjt
        x7Wli3PXCfyYdIzdcO6edazrz118n1u3reNaqHP3Up+Kw4o+7PPyRdsTDiUc4hG4I/hu8wvH
        MKXCwhu6G4UVs/cosRRnJBpqMRcVJwIAE8XPOCIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42I5/e/2TN3g+12BBkd381hMmDqJ3YHR4+jK
        tUwBjFEZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlA
        U5UUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkrRRgbGekamJnpGxgZ6JgaxVoYGBkamQFUJ
        GRkfuuQLmpgrvl47wN7A+IWpi5GTQ0hARaLl/3dGEFtCwESipesFC4QtJnHh3nq2LkYuoJr5
        jBLHuxeDFbEANXzd9Z8dxGYT0JZ4++UBK4gtLBAs0X1tAiNIg4jAZEaJt5dfgiWYBXoZJZ7f
        t4DYJi8x+fRlsGZeAUGJkzOfQG1Tkrh4/ykzRFxZYsvvv1AXSUjMmn6BFcLmlZjR/hSqXk5i
        2tc1zBC2tMT5WRsYYa5e/P0xVJxf4tjtHUBfcoD1PrkfDDNm9+YvbBC2gMTUMwehWtUl+v59
        YIKw+STWLHzLAjNm16nlzDC997fMZYJ4S1FiSvdDdghbS+LLj31sqN7iALKdJF4/jJnAKDcL
        SWYWku5ZSLqR1SxgZFnFKJpakFxQnJReYaJXnJhbXJqXrpecn7uJEZyini3ZwdhwwfoQowAH
        oxIPb0ZiV6AQa2JZcWXuIUYJDmYlEd67rUAh3pTEyqrUovz4otKc1OJDjMnACJzILCWanA9M
        n3kl8YbGBsaGhpbmBqaGRhakCSuJ8z5rtQ4UEkhPLEnNTk0tSC2C2cLEwSnVwOi6MuVbasEf
        lmlOS3h57qzO9X88N6rKNi/aWcBtk/Qyq8DTuRNvLy/n/3o4W90vJ3u60fVsA/frOu82OW37
        bDaXXzo6+/9BI7dE6Y3mJZGn2Tqtg65NTRA1krG1y7Wy3vH/tsvzqod353icvj9V91S+tnWS
        qNSJkDR/T/65Ig/F9CfJWK2tU2Ipzkg01GIuKk4EADemSyiVAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Return-Path: <eunb.song@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36361
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

PiBGcm9tOiBEYXZpZCBEYW5leSANCg0KPiBUaGlzIG9uZSBhcHBlYXJzIHRvIGJ1aWxkIGFnYWlu
c3QgTGludXMnIHRyZWUuDQoNCj4gVGhpcyBjb3VsZCBhbHNvIGZpeCBwcm9ibGVtcyBub3RlZCBi
eSBFdW5ib25nIFNvbmcgd2l0aCB0aGUNCj4gZnJlZV9pbml0bWVtX2RlZmF1bHQoKSBjYWxsLg0K
DQpJIHRlc3RlZCB5b3VyIHBhdGNoLCBBbmQgaSBjb25maXJtZWQgeW91ciBwYXRjaCBmaXhlcyBw
YW5pYyBhdCBmcmVlX2luaXRtZW1fZGVmYXVsdCgpIHByb2JsZW0uDQpUaGFua3MuIA==
