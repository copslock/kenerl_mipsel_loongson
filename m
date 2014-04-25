Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2014 12:07:28 +0200 (CEST)
Received: from mailout3.samsung.com ([203.254.224.33]:61071 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822099AbaDYKHX7MO7H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Apr 2014 12:07:23 +0200
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N4L009FQ0432GD0@mailout3.samsung.com> for
 linux-mips@linux-mips.org; Fri, 25 Apr 2014 19:07:15 +0900 (KST)
Received: from epcpsbgx2.samsung.com ( [203.254.230.43])
        by epcpsbgr4.samsung.com (EPCPMTA) with SMTP id 13.3F.09952.3D33A535; Fri,
 25 Apr 2014 19:07:15 +0900 (KST)
X-AuditID: cbfee690-b7fcd6d0000026e0-1b-535a33d360a3
Received: from epmailer03 ( [203.254.219.143])
        by epcpsbgx2.samsung.com (EPCPMTA) with SMTP id EA.0A.20075.3D33A535; Fri,
 25 Apr 2014 19:07:15 +0900 (KST)
Date:   Fri, 25 Apr 2014 10:07:15 +0000 (GMT)
From:   Eunbong Song <eunb.song@samsung.com>
Subject: [PATCH] mips: Fix compile warnings of perf "tests/attr.c" on mips64.
To:     ralf@linux-mips.org
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-to: eunb.song@samsung.com
MIME-version: 1.0
X-MTR:  20140425100342151@eunb.song
Msgkey: 20140425100342151@eunb.song
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-EPTrCode: 
X-EPTrName: 
X-MLAttribute: 
X-RootMTR: 20140425100342151@eunb.song
X-ParentMTR: 
X-ArchiveUser: EV
X-CPGSPASS: N
Content-transfer-encoding: base64
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <33175867.61781398420434600.JavaMail.weblogic@epml03>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEJsWRmVeSWpSXmKPExsVy+t8zbd3LxlHBBnduClpMmDqJ3YHR4+jK
        tUwBjFENjDaJRckZmWWpCql5yfkpmXnptkqhIW66FkoKGfnFJbZK0UYGxnpGpiZ6RibmepYG
        sVZGpkoKeYm5qbZKFbpQvUoKRckFQLW5lcVAA3JS9aDiesWpeSkOWfmlIKfoFSfmFpfmpesl
        5+cqKZQl5pQCjVDST5jKmHH9V3XBHM6KPeuusDQw/uDoYuTkEBJQkWj5/50RxJYQMJH419vN
        AmGLSVy4t56ti5ELqGYZo8TDVe/giuZdm8gG0TyHUeLUvggQm0VAVWJpw0mwGjYBbYkfB64y
        g9jCAr4Say4fZAKxRQRkJJZ+ugJWwyxQI9H9dzEjxBx5icmnL7OD2LwCghInZz6BOkJJ4vWs
        TawQcWWJaV+WsULEJSRmTb8AZfNKzGh/ClUvJzHt6xpmCFta4vysDYwwzyz+/hgqzi9x7PYO
        oHs4wHqf3A+GGbN78xc2CFtAYuqZg1Ct6hKbn16Csvkk1ix8C7VKUOL0tW5mmN77W+YyQbyl
        KDGl+yE7hK0l8eXHPjZUb3EA2Y4S5w46TWBUnoUkMwtJ9ywk3chqFjCyrGIUTS1ILihOSi8y
        QY7qTYyQJDhhB+O9A9aHGPczAqNkIrOUaHI+MI3mlcQbGpsZWZiamBobmVuaUShsYmphYWJE
        FWElcV61R0lBQgLpiSWp2ampBalF8UWlOanFhxiZODilGhhnnUlfnMv2RJTDw+akjvHuvneM
        qXWrb9RNfSr+yqD1VblSUGDty4WH57JqajlG5jBbeKtpHzkp8DS9eT+bcPxGuciOX4aX+HP/
        qHmFa2+t8XGvjRfV6wyqeR236OcPp4o1GU/mXxdOr76w0GON3Hn57Q061qE2n/X5Yw7GcJ7Y
        2lhs+sHRR4mlOCPRUIu5qDgRAIyNSFL1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42I5/e92v+5l46hgg8vr+CwmTJ3E7sDocXTl
        WqYAxqgMm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zByg
        qUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6VoIwNjPSNTEz0jYwM9E4NYK0MDAyNToKqE
        jIzrv6oL5nBW7Fl3haWB8QdHFyMnh5CAikTL/++MILaEgInEvGsT2SBsMYkL99azQdTMYZQ4
        tS8CxGYRUJVY2nASrJ5NQFvix4GrzCC2sICvxJrLB5lAbBEBGYmln66A1TAL1Eh0/13MCDFH
        XmLy6cvsIDavgKDEyZlPWCB2KUm8nrWJFSKuLDHtyzJWiLiExKzpF6BsXokZ7U+h6uUkpn1d
        wwxhS0ucn7WBEebmxd8fQ8X5JY7d3gF0DwdY75P7wTBjdm/+AvWigMTUMwehWtUlNj+9BGXz
        SaxZ+BZqlaDE6WvdzDC997fMZYJ4S1FiSvdDdghbS+LLj31sqN7iALIdJc4ddJrAKDcLSWYW
        ku5ZSLqR1SxgZFnFKJpakFxQnJReYaRXnJhbXJqXrpecn7uJEZyeni3awfjvvPUhRgEORiUe
        3gmykcFCrIllxZW5hxglOJiVRHj/6kYFC/GmJFZWpRblxxeV5qQWH2JMBsbfRGYp0eR8YOrM
        K4k3NDYwNjS0NDcwNTSyIE1YSZxX/lZSkJBAemJJanZqakFqEcwWJg5OqQZG67zDjmrTN17g
        W/K9NSk94Kfx9PQ/V1U5LTMe9f4O9m9LlXAN01ZQjTk9J/qZz/kz7RynfLcaiswojRddZD75
        75wLvqYOaR27550yS3r8g69/4mpds2eMp9bXnFIqbt4SJtlr1FfTVHHErzKAe8opy7fr9bSe
        8wb6JjydUGY7a50RH8eSd+pKLMUZiYZazEXFiQB+x4P5kwMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Return-Path: <eunb.song@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39923
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

DQpPbiBtaXBzNjQsIHdlIGJ5IGRlZmF1bHQgaW5jbHVkZSAnPGFzbS1nZW5lcmljL2ludC1sNjQu
aD4gd2hpY2ggcmVzdWx0cyBpbiBfX3U2NCBiZWluZyBhbg0KdW5zaWduZWQgbG9uZy4gVGhpcyBj
YXVzZXMgY29tcGlsZSB3YXJuaW5ncyB3aGljaCBhcmUgdHJlYXRlZCBhcyBlcnJvcnMgZHVlIHRv
ICctV2Vycm9yJy4NClRoaXMgcGF0Y2ggcmVmZXJlbmNlcyBjb21taXQgZTM1NDFlYzcuDQoNClNp
Z25lZC1vZmYtYnk6IEV1bmJvbmcgU29uZyA8ZXVuYi5zb25nQHNhbXN1bmcuY29tPg0KLS0tDQog
YXJjaC9taXBzL2luY2x1ZGUvdWFwaS9hc20vdHlwZXMuaCB8ICAgIDIgKy0NCiAxIGZpbGVzIGNo
YW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Fy
Y2gvbWlwcy9pbmNsdWRlL3VhcGkvYXNtL3R5cGVzLmggYi9hcmNoL21pcHMvaW5jbHVkZS91YXBp
L2FzbS90eXBlcy5oDQppbmRleCA3YWM5ZDBiLi44ZDk1OWEwIDEwMDY0NA0KLS0tIGEvYXJjaC9t
aXBzL2luY2x1ZGUvdWFwaS9hc20vdHlwZXMuaA0KKysrIGIvYXJjaC9taXBzL2luY2x1ZGUvdWFw
aS9hc20vdHlwZXMuaA0KQEAgLTE2LDcgKzE2LDcgQEANCiAgKiB1c2Vyc3BhY2UgdG8gYXZvaWQg
Y29kZSBjaGFuZ2VzLg0KICAqLw0KICNpZm5kZWYgX19LRVJORUxfXw0KLSMgaWYgX01JUFNfU1pM
T05HID09IDY0DQorIyBpZiAhZGVmaW5lZChfX1NBTkVfVVNFUlNQQUNFX1RZUEVTX18pICYmIF9N
SVBTX1NaTE9ORyA9PSA2NA0KICMgIGluY2x1ZGUgPGFzbS1nZW5lcmljL2ludC1sNjQuaD4NCiAj
IGVsc2UNCiAjICBpbmNsdWRlIDxhc20tZ2VuZXJpYy9pbnQtbGw2NC5oPg0KLS0gDQoxLjcuMC4x
DQo=
