Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Nov 2015 07:40:40 +0100 (CET)
Received: from mxout51.expurgate.net ([194.37.255.51]:50201 "EHLO
        mxout51.expurgate.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006153AbbKZGkdwBj6G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Nov 2015 07:40:33 +0100
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.80.1)
        (envelope-from <mschiller@tdt.de>)
        id 1a1qEB-0007Yz-32; Thu, 26 Nov 2015 07:40:23 +0100
Received: from [195.243.126.94] (helo=ms.tdt.de)
        by relay.expurgate.net with esmtp (Exim 4.80.1)
        (envelope-from <mschiller@tdt.de>)
        id 1a1qE8-0004lp-Ry; Thu, 26 Nov 2015 07:40:20 +0100
Received: from TDT-MS.TDTNET.local (10.1.10.2) by TDT-MS.TDTNET.local
 (10.1.10.2) with Microsoft SMTP Server (TLS) id 15.0.1104.5; Thu, 26 Nov 2015
 07:40:19 +0100
Received: from TDT-MS.TDTNET.local ([::1]) by TDT-MS.TDTNET.local ([::1]) with
 mapi id 15.00.1104.000; Thu, 26 Nov 2015 07:40:19 +0100
From:   Martin Schiller <mschiller@tdt.de>
To:     Jonas Gorski <jogo@openwrt.org>
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
        John Crispin <blogic@openwrt.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        "daniel.schwierzeck@gmail.com" <daniel.schwierzeck@gmail.com>
Subject: RE: [PATCH v2 4/4] pinctrl/lantiq: fix up pinmux
Thread-Topic: [PATCH v2 4/4] pinctrl/lantiq: fix up pinmux
Thread-Index: AQHRJ2rLV1mMH1HbuUOtEeZrXd2lQp6se8MAgAFc9cA=
Date:   Thu, 26 Nov 2015 06:40:18 +0000
Message-ID: <c9edbc5eafed4639983f8bcefe8e872e@TDT-MS.TDTNET.local>
References: <1448446739-5541-1-git-send-email-mschiller@tdt.de>
 <1448446739-5541-4-git-send-email-mschiller@tdt.de>
 <CAOiHx=moeuw-qWdq0YVzVD3dv0Zq+3rxb2tAKV1Hiz35y4+7DQ@mail.gmail.com>
In-Reply-To: <CAOiHx=moeuw-qWdq0YVzVD3dv0Zq+3rxb2tAKV1Hiz35y4+7DQ@mail.gmail.com>
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
X-purgate-sourceid: 1a1qE8-0004lp-Ry
X-purgate-Ad: Checked for spam and viruses by eXpurgate(R), see www.eleven.de for details.
X-purgate-ID: 151534::1448520021-000066B0-1E7A6044/0/0
X-purgate: clean
X-purgate-type: clean
X-purgate-relay-bid: relay-2ebacf
Return-Path: <mschiller@tdt.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50130
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

T24gMTEvMjUvMjAxNSBhdCAxMTo0MCBBTSwgSm9uYXMgR29yc2tpIHdyb3RlOg0KPiBIaQ0KPg0K
PiBPbiBXZWQsIE5vdiAyNSwgMjAxNSBhdCAxMToxOCBBTSwgTWFydGluIFNjaGlsbGVyIDxtc2No
aWxsZXJAdGR0LmRlPg0KPiB3cm90ZToNCj4gPiBGcm9tOiBKb2huIENyaXNwaW4gPGJsb2dpY0Bv
cGVud3J0Lm9yZz4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggaXMgaW5jbHVkZWQgaW4gdGhlIG9wZW53
cnQgcGF0Y2hzZXQgZm9yIHNldmVyYWwgeWVhcnMgbm93DQo+IGFuZCBuZWVkcw0KPiA+IHRvIGdv
IHVwc3RyZWFtIGFzIHdlbGwuIEl0IGluY2x1ZGVzIHRoZSBmb2xsb3dpbmcgY2hhbmdlczoNCj4g
PiAxLiBGaXggdXAgaW5saW5lIGZ1bmN0aW9uIGNhbGwgdG8geHdheV9tdXhfYXBwbHkNCj4NCj4g
VGhpcyByZWFsbHkgbmVlZHMgYW4gZXhwbGFuYXRpb24gd2hhdCBpcyBiZWluZyBmaXhlZCBoZXJl
Lg0KDQpJIGhvcGUgSm9obiAtIGFzIHRoZSBvcmlnaW5hbCBhdXRob3Igb2YgdGhpcyBwYXRjaCAt
IGNhbiBleHBsYWluDQp3aHkgdGhpcyBjaGFuZ2UgaXMgbmVjZXNzYXJ5Lg0KDQo+DQo+ID4gMi4g
Rml4IEdQSU8gU2V0dXAgb2YgR1BJTyBQb3J0Mw0KPg0KPiBUaGlzIGNoYW5nZSBsb29rcyBmaW5l
Lg0KPg0KPiA+IDMuIEltcGxlbWVudCBncGlvX2NoaXAudG9faXJxDQo+DQo+IFRoZXNlIGFyZSB0
aHJlZSBkaWZmZXJlbnQgY2hhbmdlcyAodHdvIGZpeGVzLCBvbmUgbmV3IGZlYXR1cmUpIGFuZA0K
PiB0aGVyZWZvcmUgc2hvdWxkIGJlIHNwbGl0IHVwIGludG8gdGhyZWUgcGF0Y2hlcy4NCg0KQXMg
SSdtIG5vdCB0aGUgYXV0aG9yIG9mIHRoaXMgcGF0Y2gsIEkgZGVjaWRlZCB0byBsZWF2ZSBpdCBh
cyBpdCBpcy4NCkJ1dCBwZXIgc2UgeW91IGFyZSByaWdodCwgaXQgd291bGQgYmUgYmV0dGVyIHRv
IHNwbGl0IGl0IHVwLg0KDQo+DQo+ID4gU2lnbmVkLW9mZi1ieTogSm9obiBDcmlzcGluIDxibG9n
aWNAb3BlbndydC5vcmc+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWFydGluIFNjaGlsbGVyIDxtc2No
aWxsZXJAdGR0LmRlPg0KPiA+IC0tLQ0KPg0KPiBBbHNvIHBsZWFzZSBwcm92aWRlIGEgY2hhbmdl
bG9nIGZvciB5b3VyIHBhdGNoZXMgaGVyZS4NCg0KT0suDQoNCj4NCj4gPiAgZHJpdmVycy9waW5j
dHJsL3BpbmN0cmwteHdheS5jIHwgMjggKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0K
Pg0KPg0KPiBKb25hcw0KDQpNYXJ0aW4NCg0KDQo=
