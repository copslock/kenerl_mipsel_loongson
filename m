Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2015 11:46:53 +0100 (CET)
Received: from mxout51.expurgate.net ([91.198.224.51]:54222 "EHLO
        mxout51.expurgate.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007423AbbKWKqvbTaI2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Nov 2015 11:46:51 +0100
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.80.1)
        (envelope-from <mschiller@tdt.de>)
        id 1a0odt-0002DX-Bn; Mon, 23 Nov 2015 11:46:41 +0100
Received: from [195.243.126.94] (helo=ms.tdt.de)
        by relay.expurgate.net with esmtp (Exim 4.80.1)
        (envelope-from <mschiller@tdt.de>)
        id 1a0odr-0004nL-C0; Mon, 23 Nov 2015 11:46:39 +0100
Received: from TDT-MS.TDTNET.local (10.1.10.2) by TDT-MS.TDTNET.local
 (10.1.10.2) with Microsoft SMTP Server (TLS) id 15.0.1104.5; Mon, 23 Nov 2015
 11:46:37 +0100
Received: from TDT-MS.TDTNET.local ([::1]) by TDT-MS.TDTNET.local ([::1]) with
 mapi id 15.00.1104.000; Mon, 23 Nov 2015 11:46:37 +0100
From:   Martin Schiller <mschiller@tdt.de>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "pawel.moll@arm.com" <pawel.moll@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
        "galak@codeaurora.org" <galak@codeaurora.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "blogic@openwrt.org" <blogic@openwrt.org>,
        "hauke@hauke-m.de" <hauke@hauke-m.de>,
        "jogo@openwrt.org" <jogo@openwrt.org>
Subject: RE: [PATCH 1/4] pinctrl/lantiq: update devicetree bindings
 Documentation
Thread-Topic: [PATCH 1/4] pinctrl/lantiq: update devicetree bindings
 Documentation
Thread-Index: AQHRI09brnaS0V6xl0OZ5f6mIHhclJ6k544AgASI5FA=
Date:   Mon, 23 Nov 2015 10:46:37 +0000
Message-ID: <6a6af36764c34428851b0cc8f513e89d@TDT-MS.TDTNET.local>
References: <1447995151-3857-1-git-send-email-mschiller@tdt.de>
 <20151120142640.GA3348@rob-hp-laptop>
In-Reply-To: <20151120142640.GA3348@rob-hp-laptop>
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
X-purgate-relay-fid: relay-9b77e0
X-purgate-sourceid: 1a0odr-0004nL-C0
X-purgate-Ad: Checked for spam and viruses by eXpurgate(R), see www.eleven.de for details.
X-purgate-ID: 151534::1448275600-00001D43-B746199B/0/0
X-purgate: clean
X-purgate-type: clean
X-purgate-relay-bid: relay-f3ed12
Return-Path: <mschiller@tdt.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50059
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

T24gMTEvMjAvMjAxNSBhdCAzOjI2IFBNLCBSb2IgSGVycmluZyB3cm90ZToNCj4gT24gRnJpLCBO
b3YgMjAsIDIwMTUgYXQgMDU6NTI6MjhBTSArMDEwMCwgTWFydGluIFNjaGlsbGVyIHdyb3RlOg0K
PiA+IFRoaXMgcGF0Y2ggYWRkcyB0aGUgbmV3IGRlZGljYXRlZCAibGFudGlxLHBpbmN0cmwtPGNo
aXA+IiBjb21wYXRpYmxlDQo+IHN0cmluZ3MNCj4gPiB0byB0aGUgZGV2aWNldHJlZSBiaW5kaW5n
cyBEb2N1bWVudGF0aW9uLCB3aGVyZSA8Y2hpcD4gaXMgb25lIG9mDQo+ICJhc2UiLA0KPiA+ICJk
YW51YmUiLCAieHJ4MTAwIiwgInhyeDIwMCIgb3IgInhyeDMwMCIgYW5kIG1hcmtzIHRoZQ0KPiAi
bGFudGlxLHBpbmN0cmwteHdheSINCj4gPiBhbmQgImxhbnRpcSxwaW5jdHJsLXhyOSIgY29tcGF0
aWJsZSBzdHJpbmdzIGFzIERFUFJFQ0FURUQuDQo+DQo+IFRoaXMgY291bGQgdXNlIGEgYmV0dGVy
IHN1YmplY3QuIEV2ZXJ5IGNoYW5nZSB0byBiaW5kaW5ncyBhcmUgInVwZGF0aW5nDQo+IGJpbmRp
bmcgZGVzY3JpcHRpb24uIg0KDQpPSywgc28gd291bGQgInBpbmN0cmwvbGFudGlxOiB1cGRhdGlu
ZyBkdCBiaW5kaW5nIGRlc2NyaXB0aW9uIiBiZSBiZXR0ZXI/DQoNCj4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IE1hcnRpbiBTY2hpbGxlciA8bXNjaGlsbGVyQHRkdC5kZT4NCj4gPiAtLS0NCj4g
PiAgLi4uL2JpbmRpbmdzL3BpbmN0cmwvbGFudGlxLHBpbmN0cmwteHdheS50eHQgICAgICAgfCAx
MDgNCj4gKysrKysrKysrKysrKysrKysrKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMDAgaW5z
ZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQNCj4gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGluY3RybC9sYW50aXEscGluY3RybC14d2F5
LnR4dA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waW5jdHJsL2xhbnRp
cSxwaW5jdHJsLXh3YXkudHh0DQo+ID4gaW5kZXggZTg5YjQ2Ny4uMTZkYWExMiAxMDA2NDQNCj4g
PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGluY3RybC9sYW50aXEs
cGluY3RybC0NCj4geHdheS50eHQNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcGluY3RybC9sYW50aXEscGluY3RybC0NCj4geHdheS50eHQNCj4gPiBAQCAtMSw3
ICsxLDE0IEBADQo+ID4gIExhbnRpcSBYV0FZIHBpbm11eCBjb250cm9sbGVyDQo+ID4NCj4gPiAg
UmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiAtLSBjb21wYXRpYmxlOiAibGFudGlxLHBpbmN0cmwt
eHdheSIgb3IgImxhbnRpcSxwaW5jdHJsLXhyOSINCj4gPiArLSBjb21wYXRpYmxlOiAibGFudGlx
LHBpbmN0cmwteHdheSIsIChERVBSRUNBVEVEOiBVc2UgWFdBWSBEQU5VQkUNCj4gRmFtaWx5KQ0K
PiA+ICsgICAgICAibGFudGlxLHBpbmN0cmwteHI5IiwgKERFUFJFQ0FURUQ6IFVzZSBYV0FZIHhS
WDEwMC94UlgyMDANCj4gRmFtaWx5KQ0KPiA+ICsgICAgICAibGFudGlxLHBpbmN0cmwtPGNoaXA+
Iiwgd2hlcmUgPGNoaXA+IGlzOg0KPg0KPiA8Y2hpcD4gZmlyc3QgaXMgcHJlZmVycmVkOiBsYW50
aXEsPGNoaXA+LXBpbmN0cmwNCj4NCj4gPiArImFzZSIgKFhXQVkgQU1BWk9OIEZhbWlseSkNCj4g
PiArImRhbnViZSIgKFhXQVkgREFOVUJFIEZhbWlseSkNCj4gPiArInhyeDEwMCIgKFhXQVkgeFJY
MTAwIEZhbWlseSkNCj4gPiArInhyeDIwMCIgKFhXQVkgeFJYMjAwIEZhbWlseSkNCj4gPiArInhy
eDMwMCIgKFhXQVkgeFJYMzAwIEZhbWlseSkNCg0KTm8gcHJvYmxlbSwgSSB3aWxsIGNoYW5nZSB0
aGlzIHRvICJsYW50aXEsPGNoaXA+LXBpbmN0cmwiIGZvciB0aGUgbmV3IGJpbmRpbmdzLg0KDQpN
YXJ0aW4NCg0K
