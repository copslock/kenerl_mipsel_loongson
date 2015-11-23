Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2015 12:00:20 +0100 (CET)
Received: from mxout51.expurgate.net ([91.198.224.51]:43562 "EHLO
        mxout51.expurgate.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012235AbbKWLAS0Wy32 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Nov 2015 12:00:18 +0100
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.80.1)
        (envelope-from <mschiller@tdt.de>)
        id 1a0oqw-0004wY-Ga; Mon, 23 Nov 2015 12:00:10 +0100
Received: from [195.243.126.94] (helo=ms.tdt.de)
        by relay.expurgate.net with esmtp (Exim 4.80.1)
        (envelope-from <mschiller@tdt.de>)
        id 1a0oqu-0001d6-Dt; Mon, 23 Nov 2015 12:00:08 +0100
Received: from TDT-MS.TDTNET.local (10.1.10.2) by TDT-MS.TDTNET.local
 (10.1.10.2) with Microsoft SMTP Server (TLS) id 15.0.1104.5; Mon, 23 Nov 2015
 12:00:05 +0100
Received: from TDT-MS.TDTNET.local ([::1]) by TDT-MS.TDTNET.local ([::1]) with
 mapi id 15.00.1104.000; Mon, 23 Nov 2015 12:00:05 +0100
From:   Martin Schiller <mschiller@tdt.de>
To:     Hauke Mehrtens <hauke@hauke-m.de>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "pawel.moll@arm.com" <pawel.moll@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
        "galak@codeaurora.org" <galak@codeaurora.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "blogic@openwrt.org" <blogic@openwrt.org>,
        "jogo@openwrt.org" <jogo@openwrt.org>
Subject: RE: [PATCH 2/4] pinctrl/lantiq: introduce new dedicated devicetree
 bindings
Thread-Topic: [PATCH 2/4] pinctrl/lantiq: introduce new dedicated devicetree
 bindings
Thread-Index: AQHRI09fgDWMTvrRxUuZ49I7iZs8vp6mgPAAgALw9qA=
Date:   Mon, 23 Nov 2015 11:00:04 +0000
Message-ID: <b42ea50ff4c548d2b447f0dd55e59578@TDT-MS.TDTNET.local>
References: <1447995151-3857-1-git-send-email-mschiller@tdt.de>
 <1447995151-3857-2-git-send-email-mschiller@tdt.de>
 <5650850A.5050000@hauke-m.de>
In-Reply-To: <5650850A.5050000@hauke-m.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.1.3.19]
x-esetresult: clean, is OK
x-esetid: 37303A29F17133606D716A
x-c2processedorg: 0a9847a8-efc2-4cb2-92f2-0898183e658d
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-purgate-relay-fid: relay-b62ce8
X-purgate-sourceid: 1a0oqu-0001d6-Dt
X-purgate-Ad: Checked for spam and viruses by eXpurgate(R), see www.eleven.de for details.
X-purgate-ID: 151534::1448276409-0000470C-D7C5F9A4/0/0
X-purgate: clean
X-purgate-type: clean
X-purgate-relay-bid: relay-146d57
Return-Path: <mschiller@tdt.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50060
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

T24gMTEvMjEvMjAxNSBhdCAzOjUxIFBNLCBIYXVrZSBNZWhydGVucyB3cm90ZToNCj4gT24gMTEv
MjAvMjAxNSAwNTo1MiBBTSwgTWFydGluIFNjaGlsbGVyIHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2gg
aW50cm9kdWNlcyBuZXcgZGVkaWNhdGVkICJsYW50aXEscGluY3RybC08Y2hpcD4iDQo+IGRldmlj
ZXRyZWUNCj4gPiBiaW5kaW5ncywgd2hlcmUgPGNoaXA+IGlzIG9uZSBvZiAiYXNlIiwgImRhbnVi
ZSIsICJ4cngxMDAiLCAieHJ4MjAwIg0KPiBvcg0KPiA+ICJ4cngzMDAiIGFuZCBtYXJrcyB0aGUg
ImxhbnRpcSxwaW5jdHJsLXh3YXkiIGFuZCAibGFudGlxLHBpbmN0cmwteHI5Ig0KPiBiaW5kaW5n
cyBhcw0KPiA+IERFUFJFQ0FURUQuDQoNCihzbmlwKQ0KDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvcGluY3RybC9waW5jdHJsLWxhbnRpcS5oDQo+IGIvZHJpdmVycy9waW5jdHJsL3BpbmN0cmwt
bGFudGlxLmgNCj4gPiBpbmRleCBlYjg5YmEwLi5lMTM3ZDEzIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvcGluY3RybC9waW5jdHJsLWxhbnRpcS5oDQo+ID4gKysrIGIvZHJpdmVycy9waW5jdHJs
L3BpbmN0cmwtbGFudGlxLmgNCj4gPiBAQCAtMTYyLDYgKzE2MiwxNCBAQCBlbnVtIGx0cV9waW4g
ew0KPiA+ICBHUElPNTMsDQo+ID4gIEdQSU81NCwNCj4gPiAgR1BJTzU1LA0KPiA+ICtHUElPNTYs
DQo+ID4gK0dQSU81NywNCj4gPiArR1BJTzU4LA0KPiA+ICtHUElPNTksDQo+ID4gK0dQSU82MCwg
LyogNjAgKi8NCj4gPiArR1BJTzYxLA0KPiA+ICtHUElPNjIsDQo+ID4gK0dQSU82MywNCj4gPg0K
PiA+ICBHUElPNjQsDQo+ID4gIEdQSU82NSwNCj4NCj4gV2hhdCBpcyB0aGUgYWR2YW50YWdlIG9m
IHVzaW5nIHRoaXMgZW51bSBjb21wYXJlZCB0byBqdXN0IHVzZSBpbnRlZ2Vycw0KPiBkaXJlY3Rs
eT8gV2FzIGl0IGludGVudGlvbmFsbHkgdGhhdCBHUElPNjQgaGFzIHRoZSBudW1iZXIgNTYgYmVm
b3JlPw0KDQpNYXliZSB0aGlzIEdQSU81NiAtIEdQSU82MyBnYXAgaGFzIHNvbWUgcmVsYXRpb24g
dG8gdGhlIHhSWDEwMCAoYWthIGFyOSkgU29DLA0Kd2hpY2ggaGFzIDMgMS8yIEdQSU8gUG9ydHMg
b2YgMTZiaXRzIChHUElPMCAtIEdQSU81NSkuDQoNCg0KPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3BpbmN0cmwvcGluY3RybC14d2F5LmMNCj4gYi9kcml2ZXJzL3BpbmN0cmwvcGluY3RybC14
d2F5LmMNCj4gPiBpbmRleCBhZTcyNGJkLi4yMzRkM2Y0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvcGluY3RybC9waW5jdHJsLXh3YXkuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGluY3RybC9waW5j
dHJsLXh3YXkuYw0KPiA+IEBAIC03LDYgKzcsNyBAQA0KPiA+ICAgKiAgcHVibGlzaGhlZCBieSB0
aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLg0KPiA+ICAgKg0KPiA+ICAgKiAgQ29weXJpZ2h0
IChDKSAyMDEyIEpvaG4gQ3Jpc3BpbiA8YmxvZ2ljQG9wZW53cnQub3JnPg0KPiA+ICsgKiAgQ29w
eXJpZ2h0IChDKSAyMDE1IE1hcnRpbiBTY2hpbGxlciA8bXNjaGlsbGVyQHRkdC5kZT4NCj4gPiAg
ICovDQo+ID4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2Vyci5oPg0KPiA+IEBAIC0yNCw3ICsyNSw3
IEBADQo+ID4NCj4gPiAgI2luY2x1ZGUgPGxhbnRpcV9zb2MuaD4NCj4gPg0KPiA+IC0vKiB3ZSBo
YXZlIDMgMS8yIGJhbmtzIG9mIDE2IGJpdCBlYWNoICovDQo+ID4gKy8qIHdlIGhhdmUgdXAgdG8g
NCBiYW5rcyBvZiAxNiBiaXQgZWFjaCAqLw0KPiA+ICAjZGVmaW5lIFBJTlMxNg0KPiA+ICAjZGVm
aW5lIFBPUlQzMw0KPiA+ICAjZGVmaW5lIFBPUlQoeCkoeCAvIFBJTlMpDQo+ID4gQEAgLTM1LDcg
KzM2LDcgQEANCj4gPiAgI2RlZmluZSBNVVhfQUxUMTB4Mg0KPiA+DQo+ID4gIC8qDQo+ID4gLSAq
IGVhY2ggYmFuayBoYXMgdGhpcyBvZmZzZXQgYXBhcnQgZnJvbSB0aGUgMS8yIGJhbmsgdGhhdCBp
cyBtaXhlZA0KPiBpbnRvIHRoZQ0KPiA+ICsgKiBlYWNoIGJhbmsgaGFzIHRoaXMgb2Zmc2V0IGFw
YXJ0IGZyb20gdGhlIDR0aCBiYW5rIHRoYXQgaXMgbWl4ZWQNCj4gaW50byB0aGUNCj4gPiAgICog
b3RoZXIgMyByYW5nZXMNCj4gPiAgICovDQo+ID4gICNkZWZpbmUgUkVHX09GRjB4MzANCj4gPiBA
QCAtNTEsNyArNTIsNyBAQA0KPiA+ICAjZGVmaW5lIEdQSU9fUFVEU0VMKHApKEdQSU9fQkFTRShw
KSArIDB4MWMpDQo+ID4gICNkZWZpbmUgR1BJT19QVURFTihwKShHUElPX0JBU0UocCkgKyAweDIw
KQ0KPiA+DQo+ID4gLS8qIHRoZSAxLzIgcG9ydCBuZWVkcyBzcGVjaWFsIG9mZnNldHMgZm9yIHNv
bWUgcmVnaXN0ZXJzICovDQo+ID4gKy8qIHRoZSA0dGggcG9ydCBuZWVkcyBzcGVjaWFsIG9mZnNl
dHMgZm9yIHNvbWUgcmVnaXN0ZXJzICovDQo+ID4gICNkZWZpbmUgR1BJTzNfT0QoR1BJT19CQVNF
KDApICsgMHgyNCkNCj4gPiAgI2RlZmluZSBHUElPM19QVURTRUwoR1BJT19CQVNFKDApICsgMHgy
OCkNCj4gPiAgI2RlZmluZSBHUElPM19QVURFTihHUElPX0JBU0UoMCkgKyAweDJDKQ0KPiA+IEBA
IC04MCwxNyArODEsMTggQEANCj4gPiAgI2RlZmluZSBGVU5DX01VWChmLCBtKVwNCj4gPiAgeyAu
ZnVuYyA9IGYsIC5tdXggPSBYV0FZX01VWF8jI20sIH0NCj4gPg0KDQooc25pcCkNCg0KPiA+ICAv
KiAtLS0tLS0tLS0gIHBpbmNvbmYgcmVsYXRlZCBjb2RlIC0tLS0tLS0tLSAqLw0KPiA+ICBzdGF0
aWMgaW50IHh3YXlfcGluY29uZl9nZXQoc3RydWN0IHBpbmN0cmxfZGV2ICpwY3RsZGV2LA0KPiA+
ICB1bnNpZ25lZCBwaW4sDQo+ID4gQEAgLTY5NSw5ICsxNTkzLDYgQEAgc3RhdGljIHN0cnVjdCBn
cGlvX2NoaXAgeHdheV9jaGlwID0gew0KPiA+DQo+ID4NCj4gPiAgLyogLS0tLS0tLS0tIHJlZ2lz
dGVyIHRoZSBwaW5jdHJsIGxheWVyIC0tLS0tLS0tLSAqLw0KPiA+IC1zdGF0aWMgY29uc3QgdW5z
aWduZWQgeHdheV9leGluX3Bpbl9tYXBbXSA9IHtHUElPMCwgR1BJTzEsIEdQSU8yLA0KPiBHUElP
MzksIEdQSU80NiwgR1BJTzl9Ow0KPiA+IC1zdGF0aWMgY29uc3QgdW5zaWduZWQgYXNlX2V4aW5f
cGluc19tYXBbXSA9IHtHUElPNiwgR1BJTzI5LCBHUElPMH07DQo+ID4gLQ0KPiA+ICBzdGF0aWMg
c3RydWN0IHBpbmN0cmxfeHdheV9zb2Mgew0KPiA+ICBpbnQgcGluX2NvdW50Ow0KPiA+ICBjb25z
dCBzdHJ1Y3QgbHRxX21mcF9waW4gKm1mcDsNCj4gPiBAQCAtNzA4LDIxICsxNjAzLDQxIEBAIHN0
YXRpYyBzdHJ1Y3QgcGluY3RybF94d2F5X3NvYyB7DQo+ID4gIGNvbnN0IHVuc2lnbmVkICpleGlu
Ow0KPiA+ICB1bnNpZ25lZCBpbnQgbnVtX2V4aW47DQo+ID4gIH0gc29jX2NmZ1tdID0gew0KPiA+
IC0vKiBsZWdhY3kgeHdheSAqLw0KPiA+ICsvKiBsZWdhY3kgeHdheSAoREVQUkVDQVRFRDogVXNl
IFhXQVkgREFOVUJFIEZhbWlseSkgKi8NCj4gPiAge1hXQVlfTUFYX1BJTiwgeHdheV9tZnAsDQo+
ID4gIHh3YXlfZ3JwcywgQVJSQVlfU0laRSh4d2F5X2dycHMpLA0KPiA+IC1kYW51YmVfZnVuY3Ms
IEFSUkFZX1NJWkUoZGFudWJlX2Z1bmNzKSwNCj4gPiArbGVnYWN5X2RhbnViZV9mdW5jcywgQVJS
QVlfU0laRShsZWdhY3lfZGFudWJlX2Z1bmNzKSwNCj4gPiAgeHdheV9leGluX3Bpbl9tYXAsIDN9
LA0KPg0KPiBXaGF0IGlzIHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gdGhpcyBlbnRyeSBhbmQgdGhl
IG5ldyBkYW51YmUgZW50cnk/IElzDQo+IHRoaXMgbGVnYXkgZW50cnkgbmVlZGVkIGhlcmUgb3Vy
IGNhbiB3ZSBtYXAgdGhhdCB0byB0aGUgZGFudWJlIGVudHJ5Pw0KPiBJZg0KPiBpdCBpcyBub3Qg
bmVlZGVkIHlvdSBzaG91bGQgcHJvYmFibHkgY2hhbmdlIGl0IGRpcmVjdGx5IGluIHRoZQ0KPiB4
d2F5X21hdGNoIHRhYmxlLg0KDQpZZXMsIHlvdSBhcmUgcmlnaHQuIFdlIGNvdWxkIHNpbXBseSBt
YXRjaCB0aGUgb2xkICJsYW50aXEscGluY3RybC14d2F5Ig0KY29tcGF0aWJsZSBzdHJpbmcgdG8g
dGhlIG5ldyBkYW51YmUgZW50cnksIHdoZW4gd2UgYWxzbyBhZGQgdGhlIG9sZCAic3BpIg0KbXV4
IGdyb3VwIChERVBSRUNBVEVEIGluIHRoZSBhc2UgY29kZSkgaGVyZSB0b28uDQoNCj4NCj4gPiAt
LyogeHdheSB4cjkgc2VyaWVzICovDQo+ID4gKy8qIHh3YXkgeHI5IHNlcmllcyAoREVQUkVDQVRF
RDogVXNlIFhXQVkgeFJYMTAwL3hSWDIwMCBGYW1pbHkpICovDQo+ID4gIHtYUjlfTUFYX1BJTiwg
eHdheV9tZnAsDQo+ID4gIHh3YXlfZ3JwcywgQVJSQVlfU0laRSh4d2F5X2dycHMpLA0KPiA+ICB4
cnhfZnVuY3MsIEFSUkFZX1NJWkUoeHJ4X2Z1bmNzKSwNCj4gPiAgeHdheV9leGluX3Bpbl9tYXAs
IDZ9LA0KPiA+IC0vKiB4d2F5IGFzZSBzZXJpZXMgKi8NCj4gPiAte1hXQVlfTUFYX1BJTiwgYXNl
X21mcCwNCj4gPiArLyogWFdBWSBBTUFaT04gRmFtaWx5ICovDQo+ID4gK3tBU0VfTUFYX1BJTiwg
YXNlX21mcCwNCj4gPiAgYXNlX2dycHMsIEFSUkFZX1NJWkUoYXNlX2dycHMpLA0KPiA+ICBhc2Vf
ZnVuY3MsIEFSUkFZX1NJWkUoYXNlX2Z1bmNzKSwNCj4gPiAtYXNlX2V4aW5fcGluc19tYXAsIDN9
LA0KPiA+ICthc2VfZXhpbl9waW5fbWFwLCAzfSwNCj4gPiArLyogWFdBWSBEQU5VQkUgRmFtaWx5
ICovDQo+ID4gK3tEQU5VQkVfTUFYX1BJTiwgZGFudWJlX21mcCwNCj4gPiArZGFudWJlX2dycHMs
IEFSUkFZX1NJWkUoZGFudWJlX2dycHMpLA0KPiA+ICtkYW51YmVfZnVuY3MsIEFSUkFZX1NJWkUo
ZGFudWJlX2Z1bmNzKSwNCj4gPiArZGFudWJlX2V4aW5fcGluX21hcCwgM30sDQo+ID4gKy8qIFhX
QVkgeFJYMTAwIEZhbWlseSAqLw0KPiA+ICt7WFJYMTAwX01BWF9QSU4sIHhyeDEwMF9tZnAsDQo+
ID4gK3hyeDEwMF9ncnBzLCBBUlJBWV9TSVpFKHhyeDEwMF9ncnBzKSwNCj4gPiAreHJ4MTAwX2Z1
bmNzLCBBUlJBWV9TSVpFKHhyeDEwMF9mdW5jcyksDQo+ID4gK3hyeDEwMF9leGluX3Bpbl9tYXAs
IDZ9LA0KPiA+ICsvKiBYV0FZIHhSWDIwMCBGYW1pbHkgKi8NCj4gPiAre1hSWDIwMF9NQVhfUElO
LCB4cngyMDBfbWZwLA0KPiA+ICt4cngyMDBfZ3JwcywgQVJSQVlfU0laRSh4cngyMDBfZ3Jwcyks
DQo+ID4gK3hyeDIwMF9mdW5jcywgQVJSQVlfU0laRSh4cngyMDBfZnVuY3MpLA0KPiA+ICt4cngy
MDBfZXhpbl9waW5fbWFwLCA2fSwNCj4gPiArLyogWFdBWSB4UlgzMDAgRmFtaWx5ICovDQo+ID4g
K3tYUlgzMDBfTUFYX1BJTiwgeHJ4MzAwX21mcCwNCj4gPiAreHJ4MzAwX2dycHMsIEFSUkFZX1NJ
WkUoeHJ4MzAwX2dycHMpLA0KPiA+ICt4cngzMDBfZnVuY3MsIEFSUkFZX1NJWkUoeHJ4MzAwX2Z1
bmNzKSwNCj4gPiAreHJ4MzAwX2V4aW5fcGluX21hcCwgNX0sDQo+ID4gIH07DQo+ID4NCj4gPiAg
c3RhdGljIHN0cnVjdCBwaW5jdHJsX2dwaW9fcmFuZ2UgeHdheV9ncGlvX3JhbmdlID0gew0KPiA+
IEBAIC03MzQsNiArMTY0OSwxMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCB4
d2F5X21hdGNoW10gPQ0KPiB7DQo+ID4gIHsgLmNvbXBhdGlibGUgPSAibGFudGlxLHBpbmN0cmwt
eHdheSIsIC5kYXRhID0gJnNvY19jZmdbMF19LA0KPiA+ICB7IC5jb21wYXRpYmxlID0gImxhbnRp
cSxwaW5jdHJsLXhyOSIsIC5kYXRhID0gJnNvY19jZmdbMV19LA0KPiA+ICB7IC5jb21wYXRpYmxl
ID0gImxhbnRpcSxwaW5jdHJsLWFzZSIsIC5kYXRhID0gJnNvY19jZmdbMl19LA0KPiA+ICt7IC5j
b21wYXRpYmxlID0gImxhbnRpcSxwaW5jdHJsLWRhbnViZSIsIC5kYXRhID0gJnNvY19jZmdbM119
LA0KPiA+ICt7IC5jb21wYXRpYmxlID0gImxhbnRpcSxwaW5jdHJsLXhyeDEwMCIsIC5kYXRhID0g
JnNvY19jZmdbNF19LA0KPiA+ICt7IC5jb21wYXRpYmxlID0gImxhbnRpcSxwaW5jdHJsLXhyeDIw
MCIsIC5kYXRhID0gJnNvY19jZmdbNV19LA0KPiA+ICt7IC5jb21wYXRpYmxlID0gImxhbnRpcSxw
aW5jdHJsLXhyeDMwMCIsIC5kYXRhID0gJnNvY19jZmdbNl19LA0KPg0KPiBVc2luZyBwb2ludGVy
cyB0byBhbiBhcnJheSBlbGVtbnQgaGVyZSBsb29rcyBlcnJvciBwcm9uZSB0byBtZS4gV2h5IG5v
dA0KPiB1c2Ugb25lIHN0YXRpYyBlbnRyeSBmb3IgZWFjaCBTb0MgYW5kIHJlZmVyZW5jZSBpdCBk
aXJlY3RseS4NCj4NCj4gU29tZXRoaW5nIGxpa2UgdGhpczoNCj4NCj4gc3RhdGljIHN0cnVjdCBw
aW5jdHJsX3h3YXlfc29jIHBpbmN0cmxfeHJ4MzAwID0gew0KPiBYUlgzMDBfTUFYX1BJTiwgeHJ4
MzAwX21mcCwNCj4geHJ4MzAwX2dycHMsIEFSUkFZX1NJWkUoeHJ4MzAwX2dycHMpLA0KPiB4cngz
MDBfZnVuY3MsIEFSUkFZX1NJWkUoeHJ4MzAwX2Z1bmNzKSwNCj4geHJ4MzAwX2V4aW5fcGluX21h
cCwgNQ0KPiB9Ow0KPg0KPiBUaGVuIHlvdSBjYW4ganVzdCBkbyB0aGlzOg0KPiB7IC5jb21wYXRp
YmxlID0gImxhbnRpcSxwaW5jdHJsLXhyeDMwMCIsIC5kYXRhID0gJnBpbmN0cmxfeHJ4MzAwfSwN
Cj4NCg0KR29vZCBwb2ludCwgSSB3aWxsIGNoYW5nZSB0aGF0Lg0KDQpNYXJ0aW4NCg==
