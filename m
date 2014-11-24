Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 18:37:23 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17410 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006884AbaKXRhT1T8PN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 18:37:19 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 344BE149B9148;
        Mon, 24 Nov 2014 17:37:10 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 24 Nov
 2014 17:37:13 +0000
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 24 Nov 2014 17:37:12 +0000
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0210.002; Mon, 24 Nov 2014 17:37:12 +0000
From:   James Cowgill <James.Cowgill@imgtec.com>
To:     David Daney <ddaney.cavm@gmail.com>
CC:     Markos Chandras <Markos.Chandras@imgtec.com>,
        "Herrmann, Andreas" <Andreas.Herrmann@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Aaro Koskinen" <aaro.koskinen@iki.fi>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] MIPS: octeon: Add support for the UBNT E200 board
Thread-Topic: [PATCH] MIPS: octeon: Add support for the UBNT E200 board
Thread-Index: AQHQCA1He57L2Ddo9EKZ5SWrfw/pzA==
Date:   Mon, 24 Nov 2014 17:37:12 +0000
Message-ID: <104ADEDC18AE5E45870C06CF0304E344A50BF0@LEMAIL01.le.imgtec.org>
References: <1416837096-52243-1-git-send-email-James.Cowgill@imgtec.com>
 <54736A06.9070206@gmail.com>
In-Reply-To: <54736A06.9070206@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.154.64]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <James.Cowgill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Cowgill@imgtec.com
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

T24gTW9uLCAyMDE0LTExLTI0IGF0IDA5OjI1IC0wODAwLCBEYXZpZCBEYW5leSB3cm90ZToKPiBP
biAxMS8yNC8yMDE0IDA1OjUxIEFNLCBKYW1lcyBDb3dnaWxsIHdyb3RlOgo+ID4gRnJvbTogTWFy
a29zIENoYW5kcmFzIDxtYXJrb3MuY2hhbmRyYXNAaW1ndGVjLmNvbT4KPiA+Cj4gPiBBZGQgc3Vw
cG9ydCBmb3IgdGhlIFVCTlQgRTIwMCBib2FyZCAoRWRnZVJvdXRlci9FZGdlUm91dGVyIFBybyA4
IHBvcnQpLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmtvcyBDaGFuZHJhcyA8bWFya29zLmNo
YW5kcmFzQGltZ3RlYy5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1lcyBDb3dnaWxsIDxKYW1l
cy5Db3dnaWxsQGltZ3RlYy5jb20+Cj4gCj4gTkFDSy4KPiAKPiBBcyBmYXIgYXMgSSBrbm93LCB0
aGVzZSBib2FyZHMgaGF2ZSBhIGJvb3QgbG9hZGVyIHRoYXQgc3VwcGxpZXMgYSAKPiBjb3JyZWN0
IGRldmljZSB0cmVlLCB0aGVyZSBzaG91bGQgYmUgbm8gbmVlZCB0byBoYWNrIHVwIHRoZSBrZXJu
ZWwgbGlrZSAKPiB0aGlzLgoKWW91IG1pZ2h0IGJlIHJpZ2h0IChJIGtpbmQgb2YgZm9yZ290IGFi
b3V0IGRvaW5nIGFueXRoaW5nIGxpa2UgdGhpcykgLQpJJ2xsIHRyeSBhbmQgcHJvZCB0aGUgYm9v
dGxvYWRlciBhIGJpdCBvbiBvbmUgb2YgdGhlIGJvYXJkcyB3ZSBoYXZlCnRvbW9ycm93IG1vcm5p
bmcuCgpKYW1lcwoKPiBBcyBmYXIgYXMgSSBrbm93LCBBbmRyZWFzIGlzIHJ1bm5pbmcgYSBrZXJu
ZWwub3JnIGtlcm5lbCBvbiB0aGVzZSBib2FyZHMgCj4gd2l0aG91dCBhbnl0aGluZyBsaWtlIHRo
aXMuCj4gCj4gQW5kcmVhcywgY2FuIHlvdSBjb25maXJtIHRoaXM/Cj4gCj4gVGhhbmtzLAo+IERh
dmlkIERhbmV5Cj4gCj4gPiAtLS0KPiA+ICAgYXJjaC9taXBzL2Nhdml1bS1vY3Rlb24vZXhlY3V0
aXZlL2N2bXgtaGVscGVyLWJvYXJkLmMgfCAzICsrKwo+ID4gICBhcmNoL21pcHMvaW5jbHVkZS9h
c20vb2N0ZW9uL2N2bXgtYm9vdGluZm8uaCAgICAgICAgICB8IDIgKysKPiA+ICAgMiBmaWxlcyBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKykKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9taXBzL2Nh
dml1bS1vY3Rlb24vZXhlY3V0aXZlL2N2bXgtaGVscGVyLWJvYXJkLmMgYi9hcmNoL21pcHMvY2F2
aXVtLW9jdGVvbi9leGVjdXRpdmUvY3ZteC1oZWxwZXItYm9hcmQuYwo+ID4gaW5kZXggNWRmZWY4
NC4uNjliYTZmYiAxMDA2NDQKPiA+IC0tLSBhL2FyY2gvbWlwcy9jYXZpdW0tb2N0ZW9uL2V4ZWN1
dGl2ZS9jdm14LWhlbHBlci1ib2FyZC5jCj4gPiArKysgYi9hcmNoL21pcHMvY2F2aXVtLW9jdGVv
bi9leGVjdXRpdmUvY3ZteC1oZWxwZXItYm9hcmQuYwo+ID4gQEAgLTE4Niw2ICsxODYsOCBAQCBp
bnQgY3ZteF9oZWxwZXJfYm9hcmRfZ2V0X21paV9hZGRyZXNzKGludCBpcGRfcG9ydCkKPiA+ICAg
CQkJcmV0dXJuIDcgLSBpcGRfcG9ydDsKPiA+ICAgCQllbHNlCj4gPiAgIAkJCXJldHVybiAtMTsK
PiA+ICsJY2FzZSBDVk1YX0JPQVJEX1RZUEVfVUJOVF9FMjAwOgo+ID4gKwkJcmV0dXJuIC0xOwo+
ID4gICAJY2FzZSBDVk1YX0JPQVJEX1RZUEVfQ1VTVF9EU1IxMDAwTjoKPiA+ICAgCQkvKgo+ID4g
ICAJCSAqIFBvcnQgMiBjb25uZWN0cyB0byBCcm9hZGNvbSBQSFkgKEI1MDgxKS4gT3RoZXIgcG9y
dHMgKDAtMSkKPiA+IEBAIC03NTksNiArNzYxLDcgQEAgZW51bSBjdm14X2hlbHBlcl9ib2FyZF91
c2JfY2xvY2tfdHlwZXMgX19jdm14X2hlbHBlcl9ib2FyZF91c2JfZ2V0X2Nsb2NrX3R5cGUodm8K
PiA+ICAgCWNhc2UgQ1ZNWF9CT0FSRF9UWVBFX0xBTkFJMl9HOgo+ID4gICAJY2FzZSBDVk1YX0JP
QVJEX1RZUEVfTklDMTBFXzY2Ogo+ID4gICAJY2FzZSBDVk1YX0JPQVJEX1RZUEVfVUJOVF9FMTAw
Ogo+ID4gKwljYXNlIENWTVhfQk9BUkRfVFlQRV9VQk5UX0UyMDA6Cj4gPiAgIAljYXNlIENWTVhf
Qk9BUkRfVFlQRV9DVVNUX0RTUjEwMDBOOgo+ID4gICAJCXJldHVybiBVU0JfQ0xPQ0tfVFlQRV9D
UllTVEFMXzEyOwo+ID4gICAJY2FzZSBDVk1YX0JPQVJEX1RZUEVfTklDMTBFOgo+ID4gZGlmZiAt
LWdpdCBhL2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9vY3Rlb24vY3ZteC1ib290aW5mby5oIGIvYXJj
aC9taXBzL2luY2x1ZGUvYXNtL29jdGVvbi9jdm14LWJvb3RpbmZvLmgKPiA+IGluZGV4IDIyOTgx
OTkuLjA1Njc4NDcgMTAwNjQ0Cj4gPiAtLS0gYS9hcmNoL21pcHMvaW5jbHVkZS9hc20vb2N0ZW9u
L2N2bXgtYm9vdGluZm8uaAo+ID4gKysrIGIvYXJjaC9taXBzL2luY2x1ZGUvYXNtL29jdGVvbi9j
dm14LWJvb3RpbmZvLmgKPiA+IEBAIC0yMjgsNiArMjI4LDcgQEAgZW51bSBjdm14X2JvYXJkX3R5
cGVzX2VudW0gewo+ID4gICAJICovCj4gPiAgIAlDVk1YX0JPQVJEX1RZUEVfQ1VTVF9QUklWQVRF
X01JTiA9IDIwMDAxLAo+ID4gICAJQ1ZNWF9CT0FSRF9UWVBFX1VCTlRfRTEwMCA9IDIwMDAyLAo+
ID4gKwlDVk1YX0JPQVJEX1RZUEVfVUJOVF9FMjAwID0gMjAwMDMsCj4gPiAgIAlDVk1YX0JPQVJE
X1RZUEVfQ1VTVF9EU1IxMDAwTiA9IDIwMDA2LAo+ID4gICAJQ1ZNWF9CT0FSRF9UWVBFX0NVU1Rf
UFJJVkFURV9NQVggPSAzMDAwMCwKPiA+Cj4gPiBAQCAtMzI4LDYgKzMyOSw3IEBAIHN0YXRpYyBp
bmxpbmUgY29uc3QgY2hhciAqY3ZteF9ib2FyZF90eXBlX3RvX3N0cmluZyhlbnVtCj4gPiAgIAkJ
ICAgIC8qIEN1c3RvbWVyIHByaXZhdGUgcmFuZ2UgKi8KPiA+ICAgCQlFTlVNX0JSRF9UWVBFX0NB
U0UoQ1ZNWF9CT0FSRF9UWVBFX0NVU1RfUFJJVkFURV9NSU4pCj4gPiAgIAkJRU5VTV9CUkRfVFlQ
RV9DQVNFKENWTVhfQk9BUkRfVFlQRV9VQk5UX0UxMDApCj4gPiArCQlFTlVNX0JSRF9UWVBFX0NB
U0UoQ1ZNWF9CT0FSRF9UWVBFX1VCTlRfRTIwMCkKPiA+ICAgCQlFTlVNX0JSRF9UWVBFX0NBU0Uo
Q1ZNWF9CT0FSRF9UWVBFX0NVU1RfRFNSMTAwME4pCj4gPiAgIAkJRU5VTV9CUkRfVFlQRV9DQVNF
KENWTVhfQk9BUkRfVFlQRV9DVVNUX1BSSVZBVEVfTUFYKQo+ID4gICAJfQo+ID4KPiAKCg==
