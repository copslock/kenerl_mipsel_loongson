Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Dec 2013 09:52:17 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:35911 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816822Ab3LEIwPPuXpL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Dec 2013 09:52:15 +0100
From:   Qais Yousef <Qais.Yousef@imgtec.com>
To:     Vivek Goyal <vgoyal@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] crash_dump: fix compilation error (on MIPS at least)
Thread-Topic: [PATCH] crash_dump: fix compilation error (on MIPS at least)
Thread-Index: AQHO8QnExmvHISq+vkaNQVlz0RPH3ppEjfmAgAC8NNA=
Date:   Thu, 5 Dec 2013 08:52:06 +0000
Message-ID: <392C4BDEFF12D14FA57A3F30B283D7D13C4C04@LEMAIL01.le.imgtec.org>
References: <1386172702-31266-1-git-send-email-qais.yousef@imgtec.com>
 <20131204213017.GJ19087@redhat.com>
In-Reply-To: <20131204213017.GJ19087@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.154.35]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEF-Processed: 7_3_0_01192__2013_12_05_08_52_09
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38659
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWaXZlayBHb3lhbCBbbWFpbHRv
OnZnb3lhbEByZWRoYXQuY29tXQ0KPiBTZW50OiAwNCBEZWNlbWJlciAyMDEzIDIxOjMwDQo+IFRv
OiBRYWlzIFlvdXNlZg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgQW5kcmV3
IE1vcnRvbjsgTWljaGFlbCBIb2x6aGV1OyBsaW51eC0NCj4gbWlwc0BsaW51eC1taXBzLm9yZzsg
c3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBjcmFzaF9kdW1w
OiBmaXggY29tcGlsYXRpb24gZXJyb3IgKG9uIE1JUFMgYXQgbGVhc3QpDQo+IA0KPiBPbiBXZWQs
IERlYyAwNCwgMjAxMyBhdCAwMzo1ODoyMlBNICswMDAwLCBRYWlzIFlvdXNlZiB3cm90ZToNCj4g
PiAgIEluIGZpbGUgaW5jbHVkZWQgZnJvbSBrZXJuZWwvY3Jhc2hfZHVtcC5jOjI6MDoNCj4gPiAg
IGluY2x1ZGUvbGludXgvY3Jhc2hfZHVtcC5oOjIyOjI3OiBlcnJvcjogdW5rbm93biB0eXBlIG5h
bWUg4oCYcGdwcm90X3TigJkNCj4gPg0KPiA+IHdoZW4gQ09ORklHX0NSQVNIX0RVTVA9eQ0KPiA+
DQo+ID4gVGhlIGVycm9yIHdhcyB0cmFjZWQgYmFjayB0byB0aGlzIGNvbW1pdDoNCj4gPg0KPiA+
ICAgOWNiMjE4MTMxZGUxIHZtY29yZTogaW50cm9kdWNlIHJlbWFwX29sZG1lbV9wZm5fcmFuZ2Uo
KQ0KPiA+DQo+ID4gaW5jbHVkZSA8YXNtL3BndGFibGUuaD4gdG8gZ2V0IHRoZSBtaXNzaW5nIGRl
ZmluaXRpb24NCj4gDQo+IHBncHJvdF90IGRlZmluaXRpb24gZm9yIG1pcHMgc2VlbXMgdG8gYmUg
aW4gYXNtL3BhZ2UuaC4gU28gd2h5IGFyZSB5b3UgaW5jbHVkaW5nDQo+IGFzbS9wZ3RhYmxlLmgg
YW5kIG5vdCBhc20vcGFnZS5oPyBGb3Igb3RoZXIgYXJjaGl0ZWN0dXJlcyBpdCBzZWVtcyB0byBi
ZSBpbg0KPiBvdGhlciBmaWxlcy4gVGhhdCBtZWFucyB0aG9zZSBhcmNoIHdpbGwgaGF2ZSBicm9r
ZW4gY29tcGlsYXRpb24gbm93Lg0KDQpJIGRpZG4ndCBpbmNsdWRlIGFzbS9wYWdlLmggYmVjYXVz
ZSBJIGRpZG4ndCB0aGluayBpdCdsbCBmaXggdGhlIHByb2JsZW0gZm9yIG90aGVyIGFyY2hlcy4N
Cg0KPiANCj4gU28gcXVlc3Rpb24gaXMsIGlzIHRoZXJlIGFueSBhcmNoIHNwZWNpZmljIGZpbGUg
d2hpY2ggb25lIGNhbiBpbmNsdWRlIGFuZCBiZSBjb3ZlcmVkDQo+IGZvciBwZ3Byb3RfdCBkZWZp
bml0aW9uIGZvciBhbGwgdGhlIGFyY2hlcy4NCg0KSSBhc2tlZCB0aGUgc2FtZSBxdWVzdGlvbiBh
bmQgYXNtL3BndGFibGUuaCB3YXMgdGhlIGFuc3dlci4NCg0KVGhhbmtzLA0KUWFpcw0KDQo+IA0K
PiBUaGFua3MNCj4gVml2ZWsNCj4gDQo+ID4NCj4gPiBDYzogQW5kcmV3IE1vcnRvbiA8YWtwbUBs
aW51eC1mb3VuZGF0aW9uLm9yZz4NCj4gPiBDYzogTWljaGFlbCBIb2x6aGV1IDxob2x6aGV1QGxp
bnV4LnZuZXQuaWJtLmNvbT4NCj4gPiBDYzogVml2ZWsgR295YWwgPHZnb3lhbEByZWRoYXQuY29t
Pg0KPiA+IENjOiA8bGludXgtbWlwc0BsaW51eC1taXBzLm9yZz4NCj4gPiBDYzogPHN0YWJsZUB2
Z2VyLmtlcm5lbC5vcmc+ICMgMy4xMg0KPiA+IFJldmlld2VkLWJ5OiBKYW1lcyBIb2dhbiA8amFt
ZXMuaG9nYW5AaW1ndGVjLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBRYWlzIFlvdXNlZiA8cWFp
cy55b3VzZWZAaW1ndGVjLmNvbT4NCj4gPiAtLS0NCj4gPiBJIGhhdmVuJ3QgdHJpZWQgYW55IG90
aGVyIGFyY2hpdGVjdHVyZSBleGNlcHQgbWlwcy4NCj4gPiBJZiBPSyB0aGlzIHNob3VsZCBiZSBj
b25zaWRlcmVkIGZvciBzdGFibGUgMy4xMiAoQ0NlZCkuDQo+ID4NCj4gPiAgaW5jbHVkZS9saW51
eC9jcmFzaF9kdW1wLmggfCAgICAyICsrDQo+ID4gIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAwIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvY3Jhc2hfZHVtcC5oIGIvaW5jbHVkZS9saW51eC9jcmFzaF9kdW1wLmgNCj4gPiBpbmRleCBm
ZTY4YTVhLi43MDMyNTE4IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvY3Jhc2hfZHVt
cC5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9jcmFzaF9kdW1wLmgNCj4gPiBAQCAtNiw2ICs2
LDggQEANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3Byb2NfZnMuaD4NCj4gPiAgI2luY2x1ZGUgPGxp
bnV4L2VsZi5oPg0KPiA+DQo+ID4gKyNpbmNsdWRlIDxhc20vcGd0YWJsZS5oPiAvKiBmb3IgcGdw
cm90X3QgKi8NCj4gPiArDQo+ID4gICNkZWZpbmUgRUxGQ09SRV9BRERSX01BWAkoLTFVTEwpDQo+
ID4gICNkZWZpbmUgRUxGQ09SRV9BRERSX0VSUgkoLTJVTEwpDQo+ID4NCj4gPiAtLQ0KPiA+IDEu
Ny4xDQo+ID4NCg==
