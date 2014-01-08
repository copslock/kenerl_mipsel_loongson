Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jan 2014 17:22:13 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:52296 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825360AbaAHQWJnVJRj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Jan 2014 17:22:09 +0100
From:   Qais Yousef <Qais.Yousef@imgtec.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Holzheu" <holzheu@linux.vnet.ibm.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Vivek Goyal (vgoyal@redhat.com)" <vgoyal@redhat.com>
Subject: RE: [PATCH] crash_dump: fix compilation error (on MIPS at least)
Thread-Topic: [PATCH] crash_dump: fix compilation error (on MIPS at least)
Thread-Index: AQHO8QnExmvHISq+vkaNQVlz0RPH3ppFohqAgAlF3UCAAcaXgIAqiqDA
Date:   Wed, 8 Jan 2014 16:22:02 +0000
Message-ID: <392C4BDEFF12D14FA57A3F30B283D7D13F8E75@LEMAIL01.le.imgtec.org>
References: <1386172702-31266-1-git-send-email-qais.yousef@imgtec.com>
 <20131205135835.GA1600@redhat.com>
 <392C4BDEFF12D14FA57A3F30B283D7D13C7764@LEMAIL01.le.imgtec.org>
 <20131212144201.GA31540@redhat.com>
In-Reply-To: <20131212144201.GA31540@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.154.95]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEF-Processed: 7_3_0_01192__2014_01_08_16_22_03
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38904
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

UGluZy4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWaXZlayBHb3lh
bCBbbWFpbHRvOnZnb3lhbEByZWRoYXQuY29tXQ0KPiBTZW50OiAxMiBEZWNlbWJlciAyMDEzIDE0
OjQyDQo+IFRvOiBRYWlzIFlvdXNlZjsgQW5kcmV3IE1vcnRvbg0KPiBDYzogbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgTWljaGFlbCBIb2x6aGV1OyBsaW51eC1taXBzQGxpbnV4LW1pcHMu
b3JnOw0KPiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGNy
YXNoX2R1bXA6IGZpeCBjb21waWxhdGlvbiBlcnJvciAob24gTUlQUyBhdCBsZWFzdCkNCj4gDQo+
IEdlbmVyYWxseSBha3BtIHBpY2tzIHRoZSBrZXhlYy9rZHVtcCBhcmNoIGluZGVwZW5kZW50IGNo
YW5nZXMuDQo+IA0KPiBBbmRyZXcsIGNhbiB5b3UgcGxlYXNlIGNvbnNpZGVyIHRoaXMgcGF0Y2gg
Zm9yIGluY2x1c2lvbi4NCj4gDQo+IFRoYW5rcw0KPiBWaXZlaw0KPiANCj4gT24gV2VkLCBEZWMg
MTEsIDIwMTMgYXQgMTE6NDM6MzJBTSArMDAwMCwgUWFpcyBZb3VzZWYgd3JvdGU6DQo+ID4gPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogVml2ZWsgR295YWwgW21haWx0
bzp2Z295YWxAcmVkaGF0LmNvbV0NCj4gPiA+IFNlbnQ6IDA1IERlY2VtYmVyIDIwMTMgMTM6NTkN
Cj4gPiA+IFRvOiBRYWlzIFlvdXNlZg0KPiA+ID4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IEFuZHJldyBNb3J0b247IE1pY2hhZWwgSG9semhldTsNCj4gPiA+IGxpbnV4LSBtaXBz
QGxpbnV4LW1pcHMub3JnOyBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBTdWJqZWN0OiBS
ZTogW1BBVENIXSBjcmFzaF9kdW1wOiBmaXggY29tcGlsYXRpb24gZXJyb3IgKG9uIE1JUFMgYXQN
Cj4gPiA+IGxlYXN0KQ0KPiA+ID4NCj4gPiA+IE9uIFdlZCwgRGVjIDA0LCAyMDEzIGF0IDAzOjU4
OjIyUE0gKzAwMDAsIFFhaXMgWW91c2VmIHdyb3RlOg0KPiA+ID4gPiAgIEluIGZpbGUgaW5jbHVk
ZWQgZnJvbSBrZXJuZWwvY3Jhc2hfZHVtcC5jOjI6MDoNCj4gPiA+ID4gICBpbmNsdWRlL2xpbnV4
L2NyYXNoX2R1bXAuaDoyMjoyNzogZXJyb3I6IHVua25vd24gdHlwZSBuYW1lIOKAmHBncHJvdF90
4oCZDQo+ID4gPiA+DQo+ID4gPiA+IHdoZW4gQ09ORklHX0NSQVNIX0RVTVA9eQ0KPiA+ID4gPg0K
PiA+ID4gPiBUaGUgZXJyb3Igd2FzIHRyYWNlZCBiYWNrIHRvIHRoaXMgY29tbWl0Og0KPiA+ID4g
Pg0KPiA+ID4gPiAgIDljYjIxODEzMWRlMSB2bWNvcmU6IGludHJvZHVjZSByZW1hcF9vbGRtZW1f
cGZuX3JhbmdlKCkNCj4gPiA+ID4NCj4gPiA+ID4gaW5jbHVkZSA8YXNtL3BndGFibGUuaD4gdG8g
Z2V0IHRoZSBtaXNzaW5nIGRlZmluaXRpb24NCj4gPiA+ID4NCj4gPiA+ID4gQ2M6IEFuZHJldyBN
b3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+DQo+ID4gPiA+IENjOiBNaWNoYWVsIEhv
bHpoZXUgPGhvbHpoZXVAbGludXgudm5ldC5pYm0uY29tPg0KPiA+ID4gPiBDYzogVml2ZWsgR295
YWwgPHZnb3lhbEByZWRoYXQuY29tPg0KPiA+ID4gPiBDYzogPGxpbnV4LW1pcHNAbGludXgtbWlw
cy5vcmc+DQo+ID4gPiA+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gIyAzLjEyDQo+ID4g
PiA+IFJldmlld2VkLWJ5OiBKYW1lcyBIb2dhbiA8amFtZXMuaG9nYW5AaW1ndGVjLmNvbT4NCj4g
PiA+ID4gU2lnbmVkLW9mZi1ieTogUWFpcyBZb3VzZWYgPHFhaXMueW91c2VmQGltZ3RlYy5jb20+
DQo+ID4gPiA+IC0tLQ0KPiA+ID4NCj4gPiA+IExvb2tzIGdvb2QgdG8gbWUuDQo+ID4gPg0KPiA+
ID4gQWNrZWQtYnk6IFZpdmVrIEdveWFsIDx2Z295YWxAcmVkaGF0LmNvbT4NCj4gPiA+DQo+ID4g
PiBWaXZlaw0KPiA+DQo+ID4gSGksDQo+ID4NCj4gPiBJIGZhaWxlZCB0byBzZWUgdGhpcyBwaWNr
ZWQgdXAgYnkgYW55b25lLiBJJ20gbm90IHN1cmUgd2hpY2ggdHJlZSBpdA0KPiA+IHNob3VsZCBn
byB0byB0byBiZSBob25lc3QuIERvIEkgbmVlZCB0byBhZGQgbW9yZSBwZW9wbGUgdG8gdGhlIENj
PyBPcg0KPiA+IGFtIEkganVzdCBiZWluZyBpbXBhdGllbnQ/IDopDQo+ID4NCj4gPiBUaGFua3Ms
DQo+ID4gUWFpcw0KPiA+DQo+ID4gPg0KPiA+ID4gPiBJIGhhdmVuJ3QgdHJpZWQgYW55IG90aGVy
IGFyY2hpdGVjdHVyZSBleGNlcHQgbWlwcy4NCj4gPiA+ID4gSWYgT0sgdGhpcyBzaG91bGQgYmUg
Y29uc2lkZXJlZCBmb3Igc3RhYmxlIDMuMTIgKENDZWQpLg0KPiA+ID4gPg0KPiA+ID4gPiAgaW5j
bHVkZS9saW51eC9jcmFzaF9kdW1wLmggfCAgICAyICsrDQo+ID4gPiA+ICAxIGZpbGVzIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvY3Jhc2hfZHVtcC5oDQo+ID4gPiA+IGIvaW5jbHVkZS9s
aW51eC9jcmFzaF9kdW1wLmggaW5kZXggZmU2OGE1YS4uNzAzMjUxOCAxMDA2NDQNCj4gPiA+ID4g
LS0tIGEvaW5jbHVkZS9saW51eC9jcmFzaF9kdW1wLmgNCj4gPiA+ID4gKysrIGIvaW5jbHVkZS9s
aW51eC9jcmFzaF9kdW1wLmgNCj4gPiA+ID4gQEAgLTYsNiArNiw4IEBADQo+ID4gPiA+ICAjaW5j
bHVkZSA8bGludXgvcHJvY19mcy5oPg0KPiA+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L2VsZi5oPg0K
PiA+ID4gPg0KPiA+ID4gPiArI2luY2x1ZGUgPGFzbS9wZ3RhYmxlLmg+IC8qIGZvciBwZ3Byb3Rf
dCAqLw0KPiA+ID4gPiArDQo+ID4gPiA+ICAjZGVmaW5lIEVMRkNPUkVfQUREUl9NQVgJKC0xVUxM
KQ0KPiA+ID4gPiAgI2RlZmluZSBFTEZDT1JFX0FERFJfRVJSCSgtMlVMTCkNCj4gPiA+ID4NCj4g
PiA+ID4gLS0NCj4gPiA+ID4gMS43LjENCj4gPiA+ID4NCg==
