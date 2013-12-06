Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Dec 2013 17:35:54 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:6579 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6820116Ab3LFQftAilXg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 6 Dec 2013 17:35:49 +0100
From:   Qais Yousef <Qais.Yousef@imgtec.com>
To:     David Daney <ddaney.cavm@gmail.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH] mips/include/asm/mipsregs.h: s/u16/unsigned short/
Thread-Topic: [PATCH] mips/include/asm/mipsregs.h: s/u16/unsigned short/
Thread-Index: AQHO8mR+/DsSvBx3hkan8k2STnHNF5pHXJ+AgAAAdkA=
Date:   Fri, 6 Dec 2013 16:35:41 +0000
Message-ID: <392C4BDEFF12D14FA57A3F30B283D7D13C5935@LEMAIL01.le.imgtec.org>
References: <1386321659-30073-1-git-send-email-qais.yousef@imgtec.com>
 <52A1FC07.8030902@gmail.com>
In-Reply-To: <52A1FC07.8030902@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.154.35]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEF-Processed: 7_3_0_01192__2013_12_06_16_35_43
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Qais.Yousef@imgtec.com
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBEYW5leSBbbWFpbHRv
OmRkYW5leS5jYXZtQGdtYWlsLmNvbV0NCj4gU2VudDogMDYgRGVjZW1iZXIgMjAxMyAxNjozMg0K
PiBUbzogUWFpcyBZb3VzZWYNCj4gQ2M6IGxpbnV4LW1pcHNAbGludXgtbWlwcy5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSF0gbWlwcy9pbmNsdWRlL2FzbS9taXBzcmVncy5oOiBzL3UxNi91bnNp
Z25lZCBzaG9ydC8NCj4gDQo+IE9uIDEyLzA2LzIwMTMgMDE6MjAgQU0sIFFhaXMgWW91c2VmIHdy
b3RlOg0KPiA+IEkgd2FzIGdldHRpbmcgdGhpcyBlcnJvciB3aGVuIGluY2x1ZGluZyB0aGlzIGhl
YWRlciBpbiBteSBkcml2ZXI6DQo+ID4NCj4gPiAgICBhcmNoL21pcHMvaW5jbHVkZS9hc20vbWlw
c3JlZ3MuaDo2NDQ6MzM6IGVycm9yOiB1bmtub3duIHR5cGUgbmFtZSDigJh1MTbigJkNCj4gPg0K
PiA+IHNpbmNlIHRoZSB1c2Ugb2YgdTE2IGlzIG5vdCByZWFsbHkgbmVjZXNzYXJ5LCBjb252ZXJ0
IGl0IHRvIHVuc2lnbmVkIHNob3J0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUWFpcyBZb3Vz
ZWYgPHFhaXMueW91c2VmQGltZ3RlYy5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IFN0ZXZlbiBKLiBI
aWxsIDxTdGV2ZW4uSGlsbEBpbWd0ZWMuY29tPg0KPiANCj4gTkFLLg0KPiANCj4gSnVzdCAjaW5j
bHVkZSA8bGludXgvdHlwZXMuaD4gYXQgdGhlIHRvcCBvZiBhc20vbWlwc3JlZ3MuaCBpbnN0ZWFk
Lg0KDQpGdW5uaWx5IHRoYXQgd2FzIG15IGZpcnN0IHNvbHV0aW9uIGJlZm9yZSBJIGNoYW5nZWQg
aXQgdG8gdGhpcyA6KQ0KDQpJJ2xsIHJlc2VuZCBidXQgY2FuIHlvdSBwbGVhc2UgZ2l2ZSBzb21l
IGV4cGxhbmF0aW9uIHdoeSBjaGFuZ2luZyB1MTYgdG8gdW5zaWduZWQgc2hvcnQgaXMgYmFkPw0K
DQpUaGFua3MsDQpRYWlzDQoNCj4gDQo+IERhdmlkIERhbmV5DQo+IA0KPiANCj4gPiAtLS0NCj4g
PiAgIGFyY2gvbWlwcy9pbmNsdWRlL2FzbS9taXBzcmVncy5oIHwgICAgNCArKy0tDQo+ID4gICAx
IGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9hcmNoL21pcHMvaW5jbHVkZS9hc20vbWlwc3JlZ3MuaA0KPiBiL2FyY2gv
bWlwcy9pbmNsdWRlL2FzbS9taXBzcmVncy5oDQo+ID4gaW5kZXggZTAzMzE0MS4uMGEyZDZlZiAx
MDA2NDQNCj4gPiAtLS0gYS9hcmNoL21pcHMvaW5jbHVkZS9hc20vbWlwc3JlZ3MuaA0KPiA+ICsr
KyBiL2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9taXBzcmVncy5oDQo+ID4gQEAgLTY0MSw5ICs2NDEs
OSBAQA0KPiA+ICAgICogbWljcm9NSVBTIGluc3RydWN0aW9ucyBjYW4gYmUgMTYtYml0IG9yIDMy
LWJpdCBpbiBsZW5ndGguIFRoaXMNCj4gPiAgICAqIHJldHVybnMgYSAxIGlmIHRoZSBpbnN0cnVj
dGlvbiBpcyAxNi1iaXQgYW5kIGEgMCBpZiAzMi1iaXQuDQo+ID4gICAgKi8NCj4gPiAtc3RhdGlj
IGlubGluZSBpbnQgbW1faW5zbl8xNmJpdCh1MTYgaW5zbikNCj4gPiArc3RhdGljIGlubGluZSBp
bnQgbW1faW5zbl8xNmJpdCh1bnNpZ25lZCBzaG9ydCBpbnNuKQ0KPiA+ICAgew0KPiA+IC0JdTE2
IG9wY29kZSA9IChpbnNuID4+IDEwKSAmIDB4NzsNCj4gPiArCXVuc2lnbmVkIHNob3J0IG9wY29k
ZSA9IChpbnNuID4+IDEwKSAmIDB4NzsNCj4gPg0KPiA+ICAgCXJldHVybiAob3Bjb2RlID49IDEg
JiYgb3Bjb2RlIDw9IDMpID8gMSA6IDA7DQo+ID4gICB9DQo+ID4NCg0K
