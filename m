Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jul 2008 01:12:43 +0100 (BST)
Received: from mms2.broadcom.com ([216.31.210.18]:62724 "EHLO
	mms2.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S32723985AbYGBAMd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 2 Jul 2008 01:12:33 +0100
Received: from [10.11.16.99] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Tue, 01 Jul 2008 17:12:20 -0700
X-Server-Uuid: D3C04415-6FA8-4F2C-93C1-920E106A2031
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 9A20E2B1; Tue, 1 Jul 2008 17:12:20 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.11.18.52]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 86C912B0 for
 <linux-mips@linux-mips.org>; Tue, 1 Jul 2008 17:12:20 -0700 (PDT)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id GZD36507; Tue, 1 Jul 2008 17:12:20 -0700 (PDT)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 1A7F920501 for <linux-mips@linux-mips.org>; Tue, 1 Jul 2008 17:12:20
 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: Bug in atomic_sub_if_positive
Date:	Tue, 1 Jul 2008 17:12:19 -0700
Message-ID: <ADD7831BD377A74E9A1621D1EAAED18F0450AC61@NT-SJCA-0750.brcm.ad.broadcom.com>
Thread-Topic: RE: Bug in atomic_sub_if_positive
Thread-Index: Acjb16gnajlQWCmATQa1bV7F7m0yoAAABL1g
From:	"Morten Larsen" <mlarsen@broadcom.com>
To:	linux-mips@linux-mips.org
X-WSS-ID: 6474186E3D075132792-01-01
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: base64
Return-Path: <mlarsen@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlarsen@broadcom.com
Precedence: bulk
X-list: linux-mips

DQo+IEFzIGZhciBhcyBJIGNhbiB0ZWxsIHRoZSBicmFuY2ggb3B0aW1pemF0aW9uIGZpeGVzIGlu
IDIuNi4yMSBpbnRyb2R1Y2VkDQo+IGEgYnVnIGluIGF0b21pY19zdWJfaWZfcG9zaXRpdmUgdGhh
dCBjYXVzZXMgaXQgdG8gcmV0dXJuIGV2ZW4gd2hlbiB0aGUNCj4gc2MgaW5zdHJ1Y3Rpb24gZmFp
bHMuIFRoZSByZXN1bHQgaXMgdGhhdCBlLmcuIGRvd25fdHJ5bG9jayBiZWNvbWVzDQo+IHVucmVs
aWFibGUgYXMgdGhlIHNlbWFwaG9yZSBjb3VudGVyIGlzIG5vdCBhbHdheXMgZGVjcmVtZW50ZWQu
DQoNClByZXZpb3VzIHBhdGNoIHdhcyBnYXJibGVkIGJ5IE91dGxvb2sgLSB0aGlzIG9uZSBzaG91
bGQgYmUgY2xlYW46DQoNCi0tLSBhL2luY2x1ZGUvYXNtLW1pcHMvYXRvbWljLmgJMjAwOC0wNi0y
NSAyMjozODo0My4xNTk3MzkwMDAgLTA3MDANCisrKyBiL2luY2x1ZGUvYXNtLW1pcHMvYXRvbWlj
LmgJMjAwOC0wNi0yNSAyMjozOTowNy41NTIwNjUwMDAgLTA3MDANCkBAIC0yOTIsMTAgKzI5Miwx
MCBAQCBzdGF0aWMgX19pbmxpbmVfXyBpbnQgYXRvbWljX3N1Yl9pZl9wb3NpDQogCQkiCWJlcXoJ
JTAsIDJmCQkJCQlcbiINCiAJCSIJIHN1YnUJJTAsICUxLCAlMwkJCQlcbiINCiAJCSIJLnNldAly
ZW9yZGVyCQkJCQlcbiINCi0JCSIxOgkJCQkJCQlcbiINCiAJCSIJLnN1YnNlY3Rpb24gMgkJCQkJ
XG4iDQogCQkiMjoJYgkxYgkJCQkJXG4iDQogCQkiCS5wcmV2aW91cwkJCQkJXG4iDQorCQkiMToJ
CQkJCQkJXG4iDQogCQkiCS5zZXQJbWlwczAJCQkJCVxuIg0KIAkJOiAiPSZyIiAocmVzdWx0KSwg
Ij0mciIgKHRlbXApLCAiPW0iICh2LT5jb3VudGVyKQ0KIAkJOiAiSXIiIChpKSwgIm0iICh2LT5j
b3VudGVyKQ0KQEAgLTY4MiwxMCArNjgyLDEwIEBAIHN0YXRpYyBfX2lubGluZV9fIGxvbmcgYXRv
bWljNjRfc3ViX2lmX3ANCiAJCSIJYmVxegklMCwgMmYJCQkJCVxuIg0KIAkJIgkgZHN1YnUJJTAs
ICUxLCAlMwkJCQlcbiINCiAJCSIJLnNldAlyZW9yZGVyCQkJCQlcbiINCi0JCSIxOgkJCQkJCQlc
biINCiAJCSIJLnN1YnNlY3Rpb24gMgkJCQkJXG4iDQogCQkiMjoJYgkxYgkJCQkJXG4iDQogCQki
CS5wcmV2aW91cwkJCQkJXG4iDQorCQkiMToJCQkJCQkJXG4iDQogCQkiCS5zZXQJbWlwczAJCQkJ
CVxuIg0KIAkJOiAiPSZyIiAocmVzdWx0KSwgIj0mciIgKHRlbXApLCAiPW0iICh2LT5jb3VudGVy
KQ0KIAkJOiAiSXIiIChpKSwgIm0iICh2LT5jb3VudGVyKQ0K
