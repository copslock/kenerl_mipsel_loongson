Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Dec 2013 12:43:44 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:21863 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6819780Ab3LKLnk5OJXu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Dec 2013 12:43:40 +0100
From:   Qais Yousef <Qais.Yousef@imgtec.com>
To:     Vivek Goyal <vgoyal@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] crash_dump: fix compilation error (on MIPS at least)
Thread-Topic: [PATCH] crash_dump: fix compilation error (on MIPS at least)
Thread-Index: AQHO8QnExmvHISq+vkaNQVlz0RPH3ppFohqAgAlF3UA=
Date:   Wed, 11 Dec 2013 11:43:32 +0000
Message-ID: <392C4BDEFF12D14FA57A3F30B283D7D13C7764@LEMAIL01.le.imgtec.org>
References: <1386172702-31266-1-git-send-email-qais.yousef@imgtec.com>
 <20131205135835.GA1600@redhat.com>
In-Reply-To: <20131205135835.GA1600@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.154.35]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEF-Processed: 7_3_0_01192__2013_12_11_11_43_34
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38693
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
OnZnb3lhbEByZWRoYXQuY29tXQ0KPiBTZW50OiAwNSBEZWNlbWJlciAyMDEzIDEzOjU5DQo+IFRv
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
ZmluaXRpb24NCj4gPg0KPiA+IENjOiBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRp
b24ub3JnPg0KPiA+IENjOiBNaWNoYWVsIEhvbHpoZXUgPGhvbHpoZXVAbGludXgudm5ldC5pYm0u
Y29tPg0KPiA+IENjOiBWaXZlayBHb3lhbCA8dmdveWFsQHJlZGhhdC5jb20+DQo+ID4gQ2M6IDxs
aW51eC1taXBzQGxpbnV4LW1pcHMub3JnPg0KPiA+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9y
Zz4gIyAzLjEyDQo+ID4gUmV2aWV3ZWQtYnk6IEphbWVzIEhvZ2FuIDxqYW1lcy5ob2dhbkBpbWd0
ZWMuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFFhaXMgWW91c2VmIDxxYWlzLnlvdXNlZkBpbWd0
ZWMuY29tPg0KPiA+IC0tLQ0KPiANCj4gTG9va3MgZ29vZCB0byBtZS4NCj4gDQo+IEFja2VkLWJ5
OiBWaXZlayBHb3lhbCA8dmdveWFsQHJlZGhhdC5jb20+DQo+IA0KPiBWaXZlaw0KDQpIaSwNCg0K
SSBmYWlsZWQgdG8gc2VlIHRoaXMgcGlja2VkIHVwIGJ5IGFueW9uZS4gSSdtIG5vdCBzdXJlIHdo
aWNoIHRyZWUgaXQgc2hvdWxkIGdvIHRvIHRvIGJlIGhvbmVzdC4gRG8gSSBuZWVkIHRvIGFkZCBt
b3JlIHBlb3BsZSB0byB0aGUgQ2M/IE9yIGFtIEkganVzdCBiZWluZyBpbXBhdGllbnQ/IDopDQoN
ClRoYW5rcywNClFhaXMNCg0KPiANCj4gPiBJIGhhdmVuJ3QgdHJpZWQgYW55IG90aGVyIGFyY2hp
dGVjdHVyZSBleGNlcHQgbWlwcy4NCj4gPiBJZiBPSyB0aGlzIHNob3VsZCBiZSBjb25zaWRlcmVk
IGZvciBzdGFibGUgMy4xMiAoQ0NlZCkuDQo+ID4NCj4gPiAgaW5jbHVkZS9saW51eC9jcmFzaF9k
dW1wLmggfCAgICAyICsrDQo+ID4gIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAw
IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvY3Jhc2hf
ZHVtcC5oIGIvaW5jbHVkZS9saW51eC9jcmFzaF9kdW1wLmgNCj4gPiBpbmRleCBmZTY4YTVhLi43
MDMyNTE4IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvY3Jhc2hfZHVtcC5oDQo+ID4g
KysrIGIvaW5jbHVkZS9saW51eC9jcmFzaF9kdW1wLmgNCj4gPiBAQCAtNiw2ICs2LDggQEANCj4g
PiAgI2luY2x1ZGUgPGxpbnV4L3Byb2NfZnMuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2VsZi5o
Pg0KPiA+DQo+ID4gKyNpbmNsdWRlIDxhc20vcGd0YWJsZS5oPiAvKiBmb3IgcGdwcm90X3QgKi8N
Cj4gPiArDQo+ID4gICNkZWZpbmUgRUxGQ09SRV9BRERSX01BWAkoLTFVTEwpDQo+ID4gICNkZWZp
bmUgRUxGQ09SRV9BRERSX0VSUgkoLTJVTEwpDQo+ID4NCj4gPiAtLQ0KPiA+IDEuNy4xDQo+ID4N
Cg==
