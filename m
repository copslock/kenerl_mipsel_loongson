Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 May 2015 07:16:29 +0200 (CEST)
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:44319 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010933AbbEEFQ10y406 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 May 2015 07:16:27 +0200
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 901DF806DD;
        Tue,  5 May 2015 17:16:24 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1430802984;
        bh=aeL7ZgvaH9bM6/GtByHN8d9QgJ2Nip62gf6SJhTfXqc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=btAZtbv1N0Ftfn26Nf1a1bkrDuXXuvVm87u6pPEKx3v9WHMIJPOl2tjShFXbh1dPC
         6aBWmX+P171qhI8J0m8NjXN/u66p0PJPzgnvcPEkGURoO0Q1PxJQ/jTKAiVwEEnZe9
         Jkz3p09nhY5gEXjM1tIU05oM/r/ibdFOk9Cebmjc=
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,3,0,7277)
        id <B554852250000>; Tue, 05 May 2015 17:16:21 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.913.22; Tue, 5 May 2015 17:16:20 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.0913.011; Tue, 5 May 2015 17:16:20 +1200
From:   Matt Bennett <Matt.Bennett@alliedtelesis.co.nz>
To:     "david.daney@cavium.com" <david.daney@cavium.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "aleksey.makarov@auriga.com" <aleksey.makarov@auriga.com>,
        "ryazanov.s.a@gmail.com" <ryazanov.s.a@gmail.com>,
        "pebolle@tiscali.nl" <pebolle@tiscali.nl>,
        "cchavva@caviumnetworks.com" <cchavva@caviumnetworks.com>
Subject: Re: [PATCH] MIPS: OCTEON: Stop .bss memory being allocated to the
 kernel
Thread-Topic: [PATCH] MIPS: OCTEON: Stop .bss memory being allocated to the
 kernel
Thread-Index: AQHQgtcvzSFh62sHX0O/Q9hpXnwHIZ1sFmOA
Date:   Tue, 5 May 2015 05:16:19 +0000
Message-ID: <1430802979.18012.13.camel@mattb-dl>
References: <1430351311-21056-1-git-send-email-matt.bennett@alliedtelesis.co.nz>
In-Reply-To: <1430351311-21056-1-git-send-email-matt.bennett@alliedtelesis.co.nz>
Accept-Language: en-US, en-NZ
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:df5:b000:14:204d:e53d:e8da:9802]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1833B70F7DBFF4595DA3233C6A60891@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <Matt.Bennett@alliedtelesis.co.nz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Matt.Bennett@alliedtelesis.co.nz
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

SSBtaXN0YWtlbmx5IG9ubHkgaW5jbHVkZWQgRGF2aWQgaW4gdGhlIG9yaWdpbmFsIHBhdGNoIGVt
YWlsIHNvIEkgaGF2ZQ0KYWRkZWQgdGhlIG90aGVyIHBlb3BsZSBmcm9tIGdldF9tYWludGFpbmVy
LnBsLiBJIGJlbGlldmUgdGhpcyBwYXRjaA0KY291bGQgYmUgZml4aW5nIGEgcmF0aGVyIHNpZ25p
ZmljYW50IHByb2JsZW0gKGEgcG90ZW50aWFsIGtlcm5lbCBwYW5pYykNCnNvIHNvbWUgZmVlZGJh
Y2sgd291bGQgYmUgYXBwcmVjaWF0ZWQuDQoNClRoYW5rcywNCk1hdHQgDQoNCk9uIFRodSwgMjAx
NS0wNC0zMCBhdCAxMTo0OCArMTIwMCwgTWF0dCBCZW5uZXR0IHdyb3RlOg0KPiBEdXJpbmcgZGV2
ZWxvcG1lbnQgd29yayBvbiBhIDMuMTYgYmFzZWQga2VybmVsIGl0IHdhcyBmb3VuZCB0aGF0IGEN
Cj4gbnVtYmVyIG9mIGJ1aWxkcyB3b3VsZCBwYW5pYyBkdXJpbmcgdGhlIGtlcm5lbCBpbml0IHBy
b2Nlc3MsIG1vcmUNCj4gc3BlY2lmaWNhbGx5IGluICdkZWxheWVkX2ZwdXQoKScuIFRoZSBwYW5p
YyBzaG93ZWQgdGhlIGtlcm5lbCB0cnlpbmcNCj4gdG8gYWNjZXNzIGEgbWVtb3J5IGFkZHJlc3Mg
b2YgJzB4YjdmZGMwMCcgd2hpbGUgdHJhdmVyc2luZyB0aGUNCj4gJ2RlbGF5ZWRfZnB1dF9saXN0
JyBzdHJ1Y3R1cmUuIENvbXBhcmluZyB0aGlzIG1lbW9yeSBhZGRyZXNzIHRvIHRoZQ0KPiB2YWx1
ZSBvZiB0aGUgcG9pbnRlciB1c2VkIG9uIGJ1aWxkcyB0aGF0IGRpZCBub3QgcGFuaWMgY29uZmly
bWVkDQo+IHRoYXQgdGhlIHBvaW50ZXIgb24gY3Jhc2hpbmcgYnVpbGRzIG11c3QgaGF2ZSBiZWVu
IGNvcnJ1cHRlZCBhdCBzb21lDQo+IHN0YWdlIGVhcmxpZXIgaW4gdGhlIGluaXQgcHJvY2Vzcy4N
Cj4gDQo+IEJ5IHRyYXZlcnNpbmcgdGhlIGxpc3QgZWFybGllciBhbmQgZWFybGllciBpbiB0aGUg
Y29kZSBpdCB3YXMgZm91bmQNCj4gdGhhdCAncGxhdF9tZW1fc2V0dXAoKScgd2FzIHJlc3BvbnNp
YmxlIGZvciBjb3JydXB0aW5nIHRoZSBsaXN0Lg0KPiBTcGVjaWZpY2FsbHkgdGhlIGxpbmU6DQo+
IA0KPiAgICAgbWVtb3J5ID0gY3ZteF9ib290bWVtX3BoeV9hbGxvYyhtZW1fYWxsb2Nfc2l6ZSwN
Cj4gCQkJX19wYV9zeW1ib2woJl9faW5pdF9lbmQpLCAtMSwNCj4gCQkJMHgxMDAwMDAsDQo+IAkJ
CUNWTVhfQk9PVE1FTV9GTEFHX05PX0xPQ0tJTkcpOw0KPiANCj4gV2hpY2ggd291bGQgZXZlbnR1
YWxseSBjYWxsOg0KPiANCj4gICAgIGN2bXhfYm9vdG1lbV9waHlfc2V0X3NpemUobmV3X2VudF9h
ZGRyLA0KPiAJCWN2bXhfYm9vdG1lbV9waHlfZ2V0X3NpemUNCj4gCQkoZW50X2FkZHIpIC0NCj4g
CQkoZGVzaXJlZF9taW5fYWRkciAtDQo+IAkJCWVudF9hZGRyKSk7DQo+IA0KPiBXaGVyZSAnbmV3
X2VudF9hZGRyJz0weDQ4MDAwMDAgKHRoZSBhZGRyZXNzIG9mICdkZWxheWVkX2ZwdXRfbGlzdCcp
DQo+IGFuZCB0aGUgc2Vjb25kIGFyZ3VtZW50IChzaXplKT0weGI3ZmRjMDAgKHRoZSBhZGRyZXNz
IGNhdXNpbmcgdGhlDQo+IGtlcm5lbCBwYW5pYykuIFRoZSBqb2Igb2YgdGhpcyBwYXJ0IG9mICdw
bGF0X21lbV9zZXR1cCgpJyBpcyB0bw0KPiBhbGxvY2F0ZSBjaHVua3Mgb2YgbWVtb3J5IGZvciB0
aGUga2VybmVsIHRvIHVzZS4gQXQgdGhlIHN0YXJ0IG9mDQo+IGVhY2ggY2h1bmsgb2YgbWVtb3J5
IHRoZSBzaXplIG9mIHRoZSBjaHVuayBpcyB3cml0dGVuLCBoZW5jZSB0aGUNCj4gdmFsdWUgMHhi
N2ZkYzAwIGlzIHdyaXR0ZW4gb250byBtZW1vcnkgYXQgMHg0ODAwMDAwLCB0aGVyZWZvcmUgdGhl
DQo+IGtlcm5lbCBwYW5pY3Mgd2hlbiBpdCBnb2VzIGJhY2sgdG8gYWNjZXNzICdkZWxheWVkX2Zw
dXRfbGlzdCcgbGF0ZXINCj4gb24gaW4gdGhlIGluaXRpYWxpc2F0aW9uIHByb2Nlc3MuDQo+IA0K
PiBPbiBidWlsZHMgdGhhdCB3ZXJlIG5vdCBjcmFzaGluZyBpdCB3YXMgZm91bmQgdGhhdCB0aGUg
Y29tcGlsZXIgaGFkDQo+IHBsYWNlZCAnZGVsYXllZF9mcHV0X2xpc3QnIGF0IDB4NDgwMDAwOCwg
bWVhbmluZyBpdCB3YXNuJ3QgY29ycnVwdGVkDQo+IChidXQgc29tZXRoaW5nIGVsc2UgaW4gbWVt
b3J5IHdhcyBvdmVyd3JpdHRlbikuDQo+IA0KPiBBcyBjYW4gYmUgc2VlbiBpbiB0aGUgZmlyc3Qg
ZnVuY3Rpb24gY2FsbCBhYm92ZSB0aGUgY29kZSBiZWdpbnMgdG8NCj4gYWxsb2NhdGUgY2h1bmtz
IG9mIG1lbW9yeSBiZWdpbm5pbmcgZnJvbSB0aGUgc3ltYm9sICdfX2luaXRfZW5kJy4NCj4gVGhl
IE1JUFMgbGlua2VyIHNjcmlwdCAodm1saW51eC5sZHMuUykgaG93ZXZlciBkZWZpbmVzIHRoZSAu
YnNzDQo+IHNlY3Rpb24gdG8gYmVnaW4gYWZ0ZXIgJ19faW5pdF9lbmQnLiBUaGVyZWZvcmUgbWVt
b3J5IHdpdGhpbiB0aGUNCj4gLmJzcyBzZWN0aW9uIGlzIGFsbG9jYXRlZCB0byB0aGUga2VybmVs
IHRvIHVzZSAoU3lzdGVtLm1hcCBzaG93cw0KPiAnZGVsYXllZF9mcHV0X2xpc3QnIGFuZCBvdGhl
ciBrZXJuZWwgc3RydWN0dXJlcyB0byBiZSBpbiAuYnNzKS4NCj4gDQo+IFRvIHN0b3AgdGhlIGtl
cm5lbCBwYW5pYyAoYW5kIHRoZSAuYnNzIHNlY3Rpb24gYmVpbmcgY29ycnVwdGVkKQ0KPiBtZW1v
cnkgc2hvdWxkIGJlZ2luIGJlaW5nIGFsbG9jYXRlZCBmcm9tIHRoZSBzeW1ib2wgJ19lbmQnLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogTWF0dCBCZW5uZXR0IDxtYXR0LmJlbm5ldHRAYWxsaWVkdGVs
ZXNpcy5jby5uej4NCj4gQ2M6IGxpbnV4LW1pcHNAbGludXgtbWlwcy5vcmcNCj4gQ2M6IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gLS0tDQo+ICBhcmNoL21pcHMvY2F2aXVtLW9jdGVv
bi9zZXR1cC5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9taXBzL2Nhdml1bS1vY3Rlb24vc2V0
dXAuYyBiL2FyY2gvbWlwcy9jYXZpdW0tb2N0ZW9uL3NldHVwLmMNCj4gaW5kZXggN2U0MzY3Yi4u
ZjYzMmYxNCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9taXBzL2Nhdml1bS1vY3Rlb24vc2V0dXAuYw0K
PiArKysgYi9hcmNoL21pcHMvY2F2aXVtLW9jdGVvbi9zZXR1cC5jDQo+IEBAIC0xMDA4LDcgKzEw
MDgsNyBAQCB2b2lkIF9faW5pdCBwbGF0X21lbV9zZXR1cCh2b2lkKQ0KPiAgCXdoaWxlICgoYm9v
dF9tZW1fbWFwLm5yX21hcCA8IEJPT1RfTUVNX01BUF9NQVgpDQo+ICAJCSYmICh0b3RhbCA8IE1B
WF9NRU1PUlkpKSB7DQo+ICAJCW1lbW9yeSA9IGN2bXhfYm9vdG1lbV9waHlfYWxsb2MobWVtX2Fs
bG9jX3NpemUsDQo+IC0JCQkJCQlfX3BhX3N5bWJvbCgmX19pbml0X2VuZCksIC0xLA0KPiArCQkJ
CQkJX19wYV9zeW1ib2woJl9lbmQpLCAtMSwNCj4gIAkJCQkJCTB4MTAwMDAwLA0KPiAgCQkJCQkJ
Q1ZNWF9CT09UTUVNX0ZMQUdfTk9fTE9DS0lORyk7DQo+ICAJCWlmIChtZW1vcnkgPj0gMCkgew0K
DQo=
