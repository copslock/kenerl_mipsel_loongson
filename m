Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 May 2015 11:00:29 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6900 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012150AbbELJA2Qf9I1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 May 2015 11:00:28 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7E24317DDAB07;
        Tue, 12 May 2015 10:00:22 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 12 May 2015 10:00:24 +0100
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0210.002; Tue, 12 May 2015 10:00:24 +0100
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: RE: IP28: "Inconsistent ISA" messages during kernel build
Thread-Topic: IP28: "Inconsistent ISA" messages during kernel build
Thread-Index: AQHQjIz4GFG4R8fuXkevVUNLZB5Wy514B4nA
Date:   Tue, 12 May 2015 09:00:23 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B0235321052BB1@LEMAIL01.le.imgtec.org>
References: <55516EF3.7010706@gentoo.org> <5551B894.9000204@imgtec.com>
In-Reply-To: <5551B894.9000204@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.152.113]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <Matthew.Fortune@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Matthew.Fortune@imgtec.com
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

TWFya29zIENoYW5kcmFzIDxNYXJrb3MuQ2hhbmRyYXNAaW1ndGVjLmNvbT4gd3JpdGVzOg0KPiBP
biAwNS8xMi8yMDE1IDA0OjA5IEFNLCBKb3NodWEgS2luYXJkIHdyb3RlOg0KPiA+DQo+ID4gSGFz
IGFueW9uZSB0cmllZCB0byBidWlsZCBhbiBJUDI4IGtlcm5lbCBsYXRlbHk/ICBJJ3ZlIGJlZW4g
Z2V0dGluZw0KPiA+IHF1aXRlIGEgZmV3IHdhcm5pbmdzIG91dCBvZiB0aGUgbGlua2VyIHJlZ2Fy
ZGluZyBlX2ZsYWdzIGFuZCB0aGUgbmV3DQo+IC5NSVBTLmFiaWZsYWdzIHN0dWZmLg0KPiA+ICBO
b3Qgc2VlbiBpdCBvbiB0aGUgb3RoZXIgU0dJIHBsYXRmb3Jtcywgc28gSSBhbSBhc3N1bWluZyB0
aGlzIGhhcw0KPiA+IHNvbWV0aGluZyB0byBkbyB3aXRoIHdoYXQgZmxhZ3MgYXJlIHBhc3NlZCB0
byB0aGUgY29tcGlsZXIvbGlua2VyLg0KPiA+DQo+ID4gbWlwczY0LXVua25vd24tbGludXgtZ251
LWxkOiBmcy9leHQ0L3N5bWxpbmsubzogd2FybmluZzogSW5jb25zaXN0ZW50DQo+ID4gSVNBIGJl
dHdlZW4gZV9mbGFncyBhbmQgLk1JUFMuYWJpZmxhZ3MNCj4gPiBtaXBzNjQtdW5rbm93bi1saW51
eC1nbnUtbGQ6IGZzL2V4dDQvc3ltbGluay5vOiB3YXJuaW5nOiBJbmNvbnNpc3RlbnQNCj4gPiBJ
U0EgZXh0ZW5zaW9ucyBiZXR3ZWVuIGVfZmxhZ3MgYW5kIC5NSVBTLmFiaWZsYWdzDQo+ID4NCj4g
PiBTZWVpbmcgdGhpcyBvbiBhIGJ1aWxkIG9mIDQuMC4yIGJhc2VkIG9mZiBvZiBhIDIwMTUwNDE4
IGNoZWNrb3V0IGZyb20NCj4gZ2l0Lg0KPiA+DQo+ID4gLS1KDQo+ID4NCj4gSGksDQo+IA0KPiBJ
IHByZXN1bWUgeW91IGFyZSB1c2luZyBiaW51dGlscyA+PSAyLjI1PyBJIGhhdmUgc2VlbiB0aGlz
IHByb2JsZW0gaW4gbXkNCj4gbG9jYWwgYnVpbGQgdGVzdHMgYXMgd2VsbCBhbmQgSSBkaXNjdXNz
ZWQgdGhpcyB3aXRoIE1hdHRoZXcgKG5vdyBvbiBDQykuDQo+IEl0IHNlZW1zIGl0J3MgYW4gJ2lu
bm9jZW50JyB3YXJuaW5nIGFkZGVkIHRvIGJpbnV0aWxzIDIuMjUgYnV0IEkgYW0gbm90DQo+IHN1
cmUgaWYgdGhpcyBpcyBub3cgZml4ZWQgb3Igbm90LiBNYXR0aGV3IG1pZ2h0IGJlIGFibGUgdG8g
cHJvdmlkZSBtb3JlDQo+IGluZm9ybWF0aW9uLg0KDQpJIGRvbid0IHJlYWxseSBrbm93IHdoYXQg
YW4gSVAyOCBrZXJuZWwgaXMuIFdoYXQgaXMgdGhlIC1tYXJjaCBmb3IgdGhpcz8NClRoZXJlIGlz
IGFuIGlzc3VlIHdpdGggLW1hcmNoPXhscCBhcyB0aGUgWExQIGlzIG1hcmtlZCBhcyBhbiBYTFIg
aW4gdGhlDQplX2ZsYWdzIHdoaWNoIGlzIGEgbWlwczY0IGJ1dCB0aGUgeGxwIGlzIGEgbWlwczY0
cjIgd2hpY2ggaXMgY29ycmVjdGx5DQphbm5vdGF0ZWQgYXMgc3VjaCBpbiB0aGUgLk1JUFMuYWJp
ZmxhZ3MuIEkgaGF2ZW4ndCBxdWl0ZSBmaWd1cmVkIG91dCB3aGF0DQp0byBkbyBhYm91dCB0aGlz
IHlldC4NCg0KVGhhbmtzLA0KTWF0dGhldw0K
