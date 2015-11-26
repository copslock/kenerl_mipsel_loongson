Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Nov 2015 08:47:38 +0100 (CET)
Received: from mxout51.expurgate.net ([194.37.255.51]:52205 "EHLO
        mxout51.expurgate.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006508AbbKZHrgehrxG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Nov 2015 08:47:36 +0100
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.80.1)
        (envelope-from <mschiller@tdt.de>)
        id 1a1rH4-0005rw-37; Thu, 26 Nov 2015 08:47:26 +0100
Received: from [195.243.126.94] (helo=ms.tdt.de)
        by relay.expurgate.net with esmtp (Exim 4.80.1)
        (envelope-from <mschiller@tdt.de>)
        id 1a1rH1-0006oO-UD; Thu, 26 Nov 2015 08:47:24 +0100
Received: from TDT-MS.TDTNET.local (10.1.10.2) by TDT-MS.TDTNET.local
 (10.1.10.2) with Microsoft SMTP Server (TLS) id 15.0.1104.5; Thu, 26 Nov 2015
 08:47:22 +0100
Received: from TDT-MS.TDTNET.local ([::1]) by TDT-MS.TDTNET.local ([::1]) with
 mapi id 15.00.1104.000; Thu, 26 Nov 2015 08:47:22 +0100
From:   Martin Schiller <mschiller@tdt.de>
To:     John Crispin <blogic@openwrt.org>, Jonas Gorski <jogo@openwrt.org>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        "Kumar Gala" <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Hauke Mehrtens" <hauke@hauke-m.de>,
        "daniel.schwierzeck@gmail.com" <daniel.schwierzeck@gmail.com>
Subject: RE: [PATCH v2 4/4] pinctrl/lantiq: fix up pinmux
Thread-Topic: [PATCH v2 4/4] pinctrl/lantiq: fix up pinmux
Thread-Index: AQHRJ2rLV1mMH1HbuUOtEeZrXd2lQp6se8MAgAFc9cD///kWgIAAElJw///yJQCAABMGcA==
Date:   Thu, 26 Nov 2015 07:47:22 +0000
Message-ID: <c22e3b466e2a44cb82a66a4edac8e805@TDT-MS.TDTNET.local>
References: <1448446739-5541-1-git-send-email-mschiller@tdt.de>
 <1448446739-5541-4-git-send-email-mschiller@tdt.de>
 <CAOiHx=moeuw-qWdq0YVzVD3dv0Zq+3rxb2tAKV1Hiz35y4+7DQ@mail.gmail.com>
 <c9edbc5eafed4639983f8bcefe8e872e@TDT-MS.TDTNET.local>
 <5656AF01.3050700@openwrt.org>
 <39cc8cd2e53f492f88c45dd256a46b22@TDT-MS.TDTNET.local>
 <5656B2C0.6010701@openwrt.org>
In-Reply-To: <5656B2C0.6010701@openwrt.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.1.3.19]
x-esetresult: clean, is OK
x-esetid: 37303A29F17133606C7561
x-c2processedorg: 0a9847a8-efc2-4cb2-92f2-0898183e658d
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-purgate-relay-fid: relay-230693
X-purgate-sourceid: 1a1rH1-0006oO-UD
X-purgate-Ad: Checked for spam and viruses by eXpurgate(R), see www.eleven.de for details.
X-purgate-ID: 151534::1448524044-00006C3A-EF402E79/0/0
X-purgate: clean
X-purgate-type: clean
X-purgate-relay-bid: relay-5a1957
Return-Path: <mschiller@tdt.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mschiller@tdt.de
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

T24gMTEvMjYvMjAxNSBhdCA4OjIwIEFNLCBKb2huIENyaXNwaW4gd3JvdGU6DQo+DQo+DQo+IE9u
IDI2LzExLzIwMTUgMDg6MTUsIE1hcnRpbiBTY2hpbGxlciB3cm90ZToNCj4gPiBPbiAxMS8yNi8y
MDE1IGF0IDg6MDQgQU0sIEpvaG4gQ3Jpc3BpbiB3cm90ZToNCj4gPj4NCj4gPj4NCj4gPj4gT24g
MjYvMTEvMjAxNSAwNzo0MCwgTWFydGluIFNjaGlsbGVyIHdyb3RlOg0KPiA+Pj4gT24gMTEvMjUv
MjAxNSBhdCAxMTo0MCBBTSwgSm9uYXMgR29yc2tpIHdyb3RlOg0KPiA+Pj4+IEhpDQo+ID4+Pj4N
Cj4gPj4+PiBPbiBXZWQsIE5vdiAyNSwgMjAxNSBhdCAxMToxOCBBTSwgTWFydGluIFNjaGlsbGVy
DQo+IDxtc2NoaWxsZXJAdGR0LmRlPg0KPiA+Pj4+IHdyb3RlOg0KPiA+Pj4+PiBGcm9tOiBKb2hu
IENyaXNwaW4gPGJsb2dpY0BvcGVud3J0Lm9yZz4NCj4gPj4+Pj4NCj4gPj4+Pj4gVGhpcyBwYXRj
aCBpcyBpbmNsdWRlZCBpbiB0aGUgb3BlbndydCBwYXRjaHNldCBmb3Igc2V2ZXJhbCB5ZWFycw0K
PiA+PiBub3cNCj4gPj4+PiBhbmQgbmVlZHMNCj4gPj4+Pj4gdG8gZ28gdXBzdHJlYW0gYXMgd2Vs
bC4gSXQgaW5jbHVkZXMgdGhlIGZvbGxvd2luZyBjaGFuZ2VzOg0KPiA+Pj4+PiAxLiBGaXggdXAg
aW5saW5lIGZ1bmN0aW9uIGNhbGwgdG8geHdheV9tdXhfYXBwbHkNCj4gPj4+Pg0KPiA+Pj4+IFRo
aXMgcmVhbGx5IG5lZWRzIGFuIGV4cGxhbmF0aW9uIHdoYXQgaXMgYmVpbmcgZml4ZWQgaGVyZS4N
Cj4gPj4+DQo+ID4+PiBJIGhvcGUgSm9obiAtIGFzIHRoZSBvcmlnaW5hbCBhdXRob3Igb2YgdGhp
cyBwYXRjaCAtIGNhbiBleHBsYWluDQo+ID4+PiB3aHkgdGhpcyBjaGFuZ2UgaXMgbmVjZXNzYXJ5
Lg0KPiA+Pg0KPiA+PiB3aGF0IGNoYW5nZT8gd2h5IGFtIEkgaW4gQ2M6IGFuZCBub3QgVG86IGlm
IGFuIGFjdGlvbiBpcyByZXF1aXJlZCA/DQo+ID4+DQo+ID4+IEpvaG4NCj4gPg0KPiA+IFRoYXQg
Y2hhbmdlIGlzIG1lYW50Og0KPiA+DQo+ICMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjDQo+ICMNCj4gPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcGluY3RybC9waW5jdHJsLXh3YXkuYw0KPiBiL2RyaXZlcnMvcGluY3Ry
bC9waW5jdHJsLQ0KPiA+PiB4d2F5LmMNCj4gPj4gaW5kZXggYTA2NDk2Mi4uZjBiMWI0OCAxMDA2
NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9waW5jdHJsL3BpbmN0cmwteHdheS5jDQo+ID4+ICsrKyBi
L2RyaXZlcnMvcGluY3RybC9waW5jdHJsLXh3YXkuYw0KPiA+PiBAQCAtMTQ5NiwxMCArMTQ5Niw5
IEBAIHN0YXRpYyBzdHJ1Y3QgcGluY3RybF9kZXNjIHh3YXlfcGN0cmxfZGVzYyA9DQo+IHsNCj4g
Pj4gIC5jb25mb3BzPSAmeHdheV9waW5jb25mX29wcywNCj4gPj4gIH07DQo+ID4+DQo+ID4+IC1z
dGF0aWMgaW5saW5lIGludCB4d2F5X211eF9hcHBseShzdHJ1Y3QgcGluY3RybF9kZXYgKnBjdHJs
ZGV2LA0KPiA+PiArc3RhdGljIGludCBtdXhfYXBwbHkoc3RydWN0IGx0cV9waW5tdXhfaW5mbyAq
aW5mbywNCj4gPj4gIGludCBwaW4sIGludCBtdXgpDQo+ID4+ICB7DQo+ID4+IC1zdHJ1Y3QgbHRx
X3Bpbm11eF9pbmZvICppbmZvID0gcGluY3RybF9kZXZfZ2V0X2RydmRhdGEocGN0cmxkZXYpOw0K
PiA+PiAgaW50IHBvcnQgPSBQT1JUKHBpbik7DQo+ID4+ICB1MzIgYWx0MV9yZWcgPSBHUElPX0FM
VDEocGluKTsNCj4gPj4NCj4gPj4gQEAgLTE1MTksNiArMTUxOCwxNCBAQCBzdGF0aWMgaW5saW5l
IGludCB4d2F5X211eF9hcHBseShzdHJ1Y3QNCj4gPj4gcGluY3RybF9kZXYgKnBjdHJsZGV2LA0K
PiA+PiAgcmV0dXJuIDA7DQo+ID4+ICB9DQo+ID4+DQo+ID4+ICtzdGF0aWMgaW5saW5lIGludCB4
d2F5X211eF9hcHBseShzdHJ1Y3QgcGluY3RybF9kZXYgKnBjdHJsZGV2LA0KPiA+PiAraW50IHBp
biwgaW50IG11eCkNCj4gPj4gK3sNCj4gPj4gK3N0cnVjdCBsdHFfcGlubXV4X2luZm8gKmluZm8g
PSBwaW5jdHJsX2Rldl9nZXRfZHJ2ZGF0YShwY3RybGRldik7DQo+ID4+ICsNCj4gPj4gK3JldHVy
biBtdXhfYXBwbHkoaW5mbywgcGluLCBtdXgpOw0KPiA+PiArfQ0KPiA+PiArDQo+ID4+ICBzdGF0
aWMgY29uc3Qgc3RydWN0IGx0cV9jZmdfcGFyYW0geHdheV9jZmdfcGFyYW1zW10gPSB7DQo+ID4+
ICB7ImxhbnRpcSxwdWxsIixMVFFfUElOQ09ORl9QQVJBTV9QVUxMfSwNCj4gPj4gIHsibGFudGlx
LG9wZW4tZHJhaW4iLExUUV9QSU5DT05GX1BBUkFNX09QRU5fRFJBSU59LA0KPiA+DQo+ICMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjDQo+ID4NCj4NCj4gb2sgc28geW91IHBpY2tlZCB1cCBhIHBhdGNoIGFuZCBzZW50
IGl0IHVwc3RyZWFtIHdpdGhvdXQgbG9va2luZyBhdA0KPiB3aGF0DQo+IGl0IHJlYWxseSBkb2Vz
LiB0aGUgcGF0Y2ggaXMgc2ltcGx5IG5vdCByZWFkeSBmb3IgdXBzdHJlYW0uIHRoZSBwcm9ibGVt
DQo+IGhlcmUgaXMgY29weSAmIHBhc3RlIGluY29uc2lzdGVuY3kuDQoNCk9mIGNvdXJzZSBJIGFu
YWx5emVkIHRoZSB3aG9sZSBwYXRjaCBhbmQgLSBhcyB5b3UgbWF5IGhhdmUgbm90aWNlZCAtIGFk
ZGVkDQphIGRlc2NyaXB0aW9uIGZvciB0aGUgMyBjaGFuZ2VzIHdoaWNoIHdlcmUgbWFkZSBpbiB0
aGlzIHBhdGNoLg0KDQpJIGFsc28ga25vdyB0aGF0IHRoaXMgZmlyc3QgcGFydCBvZiB0aGUgcGF0
Y2ggY2hhbmdlcyB0aGUgc2NvcGUgb2YgdGhlIGlubGluZQ0KY29kZSwgYnV0IEkgZGlkIG5vdCBr
bm93IHdoeSB0aGlzIGNoYW5nZSB3YXMgZG9uZS4NCg0KPg0KPiBob3dldmVyIGlmIHdlIHdhbnQg
dG8gcmVzb2x2ZSB0aGlzIHdlIHNob3VsZCBlaXRoZXIga2VlcCB0aGUgaW5saW5lcw0KPiBhbmQN
Cj4ganVzdCBzdGljayB0byB0aGUgY3VycmVudCBjb2RlIHBhdHRlcm4gdXNlZCBvciB3ZSBjb3Vs
ZCBqdXN0IGFzc3VtZQ0KPiB0aGF0DQo+IHRoZSBjb21waWxlciB3aWxsIGJlIHNtYXJ0IGVub3Vn
aCB0byB0byBrbm93IHdoZW4gdG8gaW5saW5lIGFuZCByZW1vdmUNCj4gYWxsIG9mIHRoZW0uDQo+
DQo+IGknbGwgbGVhdmUgaXQgdXAgdG8geW91IHRvIGRlY2lkZSBhbmQgcHJvcG9zZSB5b3VyIHNv
bHV0aW9uIGFzIGEgcGF0Y2gNCj4gd2l0aCBhbiBleHBsYW5hdGlvbi4NCj4NCj4gSm9obg0KDQpT
byBJIHRoaW5rIGl0IHdvdWxkIGJlIHRoZSBiZXN0IGZvciBub3cgdG8gbGVhdmUgdGhpcyBjb2Rl
IGFzIGl0IGlzIGFuZCBtYWtlDQp0d28gc2VwYXJhdGUgcGF0Y2hlcyBmcm9tIHRoZSByZW1haW5p
bmcgdHdvIGNoYW5nZXM6DQoNCi0gRml4IEdQSU8gU2V0dXAgb2YgR1BJTyBQb3J0Mw0KLSBJbXBs
ZW1lbnQgZ3Bpb19jaGlwLnRvX2lycQ0KDQpNYXJ0aW4NCg0KPg0KPg0KPiA+Pg0KPiA+Pj4NCj4g
Pj4+Pg0KPiA+Pj4+PiAyLiBGaXggR1BJTyBTZXR1cCBvZiBHUElPIFBvcnQzDQo+ID4+Pj4NCj4g
Pj4+PiBUaGlzIGNoYW5nZSBsb29rcyBmaW5lLg0KPiA+Pj4+DQo+ID4+Pj4+IDMuIEltcGxlbWVu
dCBncGlvX2NoaXAudG9faXJxDQo+ID4+Pj4NCj4gPj4+PiBUaGVzZSBhcmUgdGhyZWUgZGlmZmVy
ZW50IGNoYW5nZXMgKHR3byBmaXhlcywgb25lIG5ldyBmZWF0dXJlKSBhbmQNCj4gPj4+PiB0aGVy
ZWZvcmUgc2hvdWxkIGJlIHNwbGl0IHVwIGludG8gdGhyZWUgcGF0Y2hlcy4NCj4gPj4+DQo+ID4+
PiBBcyBJJ20gbm90IHRoZSBhdXRob3Igb2YgdGhpcyBwYXRjaCwgSSBkZWNpZGVkIHRvIGxlYXZl
IGl0IGFzIGl0DQo+IGlzLg0KPiA+Pj4gQnV0IHBlciBzZSB5b3UgYXJlIHJpZ2h0LCBpdCB3b3Vs
ZCBiZSBiZXR0ZXIgdG8gc3BsaXQgaXQgdXAuDQo+ID4+Pg0KPiA+Pj4+DQo+ID4+Pj4+IFNpZ25l
ZC1vZmYtYnk6IEpvaG4gQ3Jpc3BpbiA8YmxvZ2ljQG9wZW53cnQub3JnPg0KPiA+Pj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBNYXJ0aW4gU2NoaWxsZXIgPG1zY2hpbGxlckB0ZHQuZGU+DQo+ID4+Pj4+IC0t
LQ0KPiA+Pj4+DQo+ID4+Pj4gQWxzbyBwbGVhc2UgcHJvdmlkZSBhIGNoYW5nZWxvZyBmb3IgeW91
ciBwYXRjaGVzIGhlcmUuDQo+ID4+Pg0KPiA+Pj4gT0suDQo+ID4+Pg0KPiA+Pj4+DQo+ID4+Pj4+
ICBkcml2ZXJzL3BpbmN0cmwvcGluY3RybC14d2F5LmMgfCAyOCArKysrKysrKysrKysrKysrKysr
KysrKysrKy0tDQo+ID4+Pj4+ICAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gPj4+Pj4NCj4gPj4+Pg0KPiA+Pj4+DQo+ID4+Pj4gSm9uYXMNCj4gPj4+
DQo+ID4+PiBNYXJ0aW4NCj4gPj4+DQo+ID4+Pg0KPiA+DQo+ID4NCg0KDQo=
