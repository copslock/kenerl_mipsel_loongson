Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Nov 2015 08:16:02 +0100 (CET)
Received: from mxout51.expurgate.net ([194.37.255.51]:33193 "EHLO
        mxout51.expurgate.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006508AbbKZHQABAPeG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Nov 2015 08:16:00 +0100
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.80.1)
        (envelope-from <mschiller@tdt.de>)
        id 1a1qmT-0006Vm-Nm; Thu, 26 Nov 2015 08:15:49 +0100
Received: from [195.243.126.94] (helo=ms.tdt.de)
        by relay.expurgate.net with esmtp (Exim 4.80.1)
        (envelope-from <mschiller@tdt.de>)
        id 1a1qmR-0008Qn-Pu; Thu, 26 Nov 2015 08:15:47 +0100
Received: from TDT-MS.TDTNET.local (10.1.10.2) by TDT-MS.TDTNET.local
 (10.1.10.2) with Microsoft SMTP Server (TLS) id 15.0.1104.5; Thu, 26 Nov 2015
 08:15:45 +0100
Received: from TDT-MS.TDTNET.local ([::1]) by TDT-MS.TDTNET.local ([::1]) with
 mapi id 15.00.1104.000; Thu, 26 Nov 2015 08:15:45 +0100
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
Thread-Index: AQHRJ2rLV1mMH1HbuUOtEeZrXd2lQp6se8MAgAFc9cD///kWgIAAElJw
Date:   Thu, 26 Nov 2015 07:15:45 +0000
Message-ID: <39cc8cd2e53f492f88c45dd256a46b22@TDT-MS.TDTNET.local>
References: <1448446739-5541-1-git-send-email-mschiller@tdt.de>
 <1448446739-5541-4-git-send-email-mschiller@tdt.de>
 <CAOiHx=moeuw-qWdq0YVzVD3dv0Zq+3rxb2tAKV1Hiz35y4+7DQ@mail.gmail.com>
 <c9edbc5eafed4639983f8bcefe8e872e@TDT-MS.TDTNET.local>
 <5656AF01.3050700@openwrt.org>
In-Reply-To: <5656AF01.3050700@openwrt.org>
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
X-purgate-relay-fid: relay-1fca43
X-purgate-sourceid: 1a1qmR-0008Qn-Pu
X-purgate-Ad: Checked for spam and viruses by eXpurgate(R), see www.eleven.de for details.
X-purgate-ID: 151534::1448522148-00006013-2B47E8F2/0/0
X-purgate: clean
X-purgate-type: clean
X-purgate-relay-bid: relay-938205
Return-Path: <mschiller@tdt.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50132
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

T24gMTEvMjYvMjAxNSBhdCA4OjA0IEFNLCBKb2huIENyaXNwaW4gd3JvdGU6DQo+DQo+DQo+IE9u
IDI2LzExLzIwMTUgMDc6NDAsIE1hcnRpbiBTY2hpbGxlciB3cm90ZToNCj4gPiBPbiAxMS8yNS8y
MDE1IGF0IDExOjQwIEFNLCBKb25hcyBHb3Jza2kgd3JvdGU6DQo+ID4+IEhpDQo+ID4+DQo+ID4+
IE9uIFdlZCwgTm92IDI1LCAyMDE1IGF0IDExOjE4IEFNLCBNYXJ0aW4gU2NoaWxsZXIgPG1zY2hp
bGxlckB0ZHQuZGU+DQo+ID4+IHdyb3RlOg0KPiA+Pj4gRnJvbTogSm9obiBDcmlzcGluIDxibG9n
aWNAb3BlbndydC5vcmc+DQo+ID4+Pg0KPiA+Pj4gVGhpcyBwYXRjaCBpcyBpbmNsdWRlZCBpbiB0
aGUgb3BlbndydCBwYXRjaHNldCBmb3Igc2V2ZXJhbCB5ZWFycw0KPiBub3cNCj4gPj4gYW5kIG5l
ZWRzDQo+ID4+PiB0byBnbyB1cHN0cmVhbSBhcyB3ZWxsLiBJdCBpbmNsdWRlcyB0aGUgZm9sbG93
aW5nIGNoYW5nZXM6DQo+ID4+PiAxLiBGaXggdXAgaW5saW5lIGZ1bmN0aW9uIGNhbGwgdG8geHdh
eV9tdXhfYXBwbHkNCj4gPj4NCj4gPj4gVGhpcyByZWFsbHkgbmVlZHMgYW4gZXhwbGFuYXRpb24g
d2hhdCBpcyBiZWluZyBmaXhlZCBoZXJlLg0KPiA+DQo+ID4gSSBob3BlIEpvaG4gLSBhcyB0aGUg
b3JpZ2luYWwgYXV0aG9yIG9mIHRoaXMgcGF0Y2ggLSBjYW4gZXhwbGFpbg0KPiA+IHdoeSB0aGlz
IGNoYW5nZSBpcyBuZWNlc3NhcnkuDQo+DQo+IHdoYXQgY2hhbmdlPyB3aHkgYW0gSSBpbiBDYzog
YW5kIG5vdCBUbzogaWYgYW4gYWN0aW9uIGlzIHJlcXVpcmVkID8NCj4NCj4gSm9obg0KDQpUaGF0
IGNoYW5nZSBpcyBtZWFudDoNCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9waW5jdHJsL3BpbmN0cmwteHdheS5jIGIvZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtDQo+IHh3
YXkuYw0KPiBpbmRleCBhMDY0OTYyLi5mMGIxYjQ4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Bp
bmN0cmwvcGluY3RybC14d2F5LmMNCj4gKysrIGIvZHJpdmVycy9waW5jdHJsL3BpbmN0cmwteHdh
eS5jDQo+IEBAIC0xNDk2LDEwICsxNDk2LDkgQEAgc3RhdGljIHN0cnVjdCBwaW5jdHJsX2Rlc2Mg
eHdheV9wY3RybF9kZXNjID0gew0KPiAgLmNvbmZvcHM9ICZ4d2F5X3BpbmNvbmZfb3BzLA0KPiAg
fTsNCj4NCj4gLXN0YXRpYyBpbmxpbmUgaW50IHh3YXlfbXV4X2FwcGx5KHN0cnVjdCBwaW5jdHJs
X2RldiAqcGN0cmxkZXYsDQo+ICtzdGF0aWMgaW50IG11eF9hcHBseShzdHJ1Y3QgbHRxX3Bpbm11
eF9pbmZvICppbmZvLA0KPiAgaW50IHBpbiwgaW50IG11eCkNCj4gIHsNCj4gLXN0cnVjdCBsdHFf
cGlubXV4X2luZm8gKmluZm8gPSBwaW5jdHJsX2Rldl9nZXRfZHJ2ZGF0YShwY3RybGRldik7DQo+
ICBpbnQgcG9ydCA9IFBPUlQocGluKTsNCj4gIHUzMiBhbHQxX3JlZyA9IEdQSU9fQUxUMShwaW4p
Ow0KPg0KPiBAQCAtMTUxOSw2ICsxNTE4LDE0IEBAIHN0YXRpYyBpbmxpbmUgaW50IHh3YXlfbXV4
X2FwcGx5KHN0cnVjdA0KPiBwaW5jdHJsX2RldiAqcGN0cmxkZXYsDQo+ICByZXR1cm4gMDsNCj4g
IH0NCj4NCj4gK3N0YXRpYyBpbmxpbmUgaW50IHh3YXlfbXV4X2FwcGx5KHN0cnVjdCBwaW5jdHJs
X2RldiAqcGN0cmxkZXYsDQo+ICtpbnQgcGluLCBpbnQgbXV4KQ0KPiArew0KPiArc3RydWN0IGx0
cV9waW5tdXhfaW5mbyAqaW5mbyA9IHBpbmN0cmxfZGV2X2dldF9kcnZkYXRhKHBjdHJsZGV2KTsN
Cj4gKw0KPiArcmV0dXJuIG11eF9hcHBseShpbmZvLCBwaW4sIG11eCk7DQo+ICt9DQo+ICsNCj4g
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgbHRxX2NmZ19wYXJhbSB4d2F5X2NmZ19wYXJhbXNbXSA9IHsN
Cj4gIHsibGFudGlxLHB1bGwiLExUUV9QSU5DT05GX1BBUkFNX1BVTEx9LA0KPiAgeyJsYW50aXEs
b3Blbi1kcmFpbiIsTFRRX1BJTkNPTkZfUEFSQU1fT1BFTl9EUkFJTn0sDQojIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
Iw0KDQo+DQo+ID4NCj4gPj4NCj4gPj4+IDIuIEZpeCBHUElPIFNldHVwIG9mIEdQSU8gUG9ydDMN
Cj4gPj4NCj4gPj4gVGhpcyBjaGFuZ2UgbG9va3MgZmluZS4NCj4gPj4NCj4gPj4+IDMuIEltcGxl
bWVudCBncGlvX2NoaXAudG9faXJxDQo+ID4+DQo+ID4+IFRoZXNlIGFyZSB0aHJlZSBkaWZmZXJl
bnQgY2hhbmdlcyAodHdvIGZpeGVzLCBvbmUgbmV3IGZlYXR1cmUpIGFuZA0KPiA+PiB0aGVyZWZv
cmUgc2hvdWxkIGJlIHNwbGl0IHVwIGludG8gdGhyZWUgcGF0Y2hlcy4NCj4gPg0KPiA+IEFzIEkn
bSBub3QgdGhlIGF1dGhvciBvZiB0aGlzIHBhdGNoLCBJIGRlY2lkZWQgdG8gbGVhdmUgaXQgYXMg
aXQgaXMuDQo+ID4gQnV0IHBlciBzZSB5b3UgYXJlIHJpZ2h0LCBpdCB3b3VsZCBiZSBiZXR0ZXIg
dG8gc3BsaXQgaXQgdXAuDQo+ID4NCj4gPj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IEpvaG4gQ3Jp
c3BpbiA8YmxvZ2ljQG9wZW53cnQub3JnPg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogTWFydGluIFNj
aGlsbGVyIDxtc2NoaWxsZXJAdGR0LmRlPg0KPiA+Pj4gLS0tDQo+ID4+DQo+ID4+IEFsc28gcGxl
YXNlIHByb3ZpZGUgYSBjaGFuZ2Vsb2cgZm9yIHlvdXIgcGF0Y2hlcyBoZXJlLg0KPiA+DQo+ID4g
T0suDQo+ID4NCj4gPj4NCj4gPj4+ICBkcml2ZXJzL3BpbmN0cmwvcGluY3RybC14d2F5LmMgfCAy
OCArKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+ID4+PiAgMSBmaWxlIGNoYW5nZWQsIDI2
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4+Pg0KPiA+Pg0KPiA+Pg0KPiA+PiBK
b25hcw0KPiA+DQo+ID4gTWFydGluDQo+ID4NCj4gPg0KDQoNCg==
