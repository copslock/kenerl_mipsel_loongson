Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2015 11:15:28 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34509 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007575AbbJNJPYDRHNm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Oct 2015 11:15:24 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 538E83BAE851E;
        Wed, 14 Oct 2015 10:15:16 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 14 Oct 2015 10:15:18 +0100
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0210.002; Wed, 14 Oct 2015 10:15:17 +0100
From:   Harvey Hunt <Harvey.Hunt@imgtec.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "Alex Smith" <Alex.Smith@imgtec.com>,
        Zubair Kakakhel <Zubair.Kakakhel@imgtec.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Paul Burton <Paul.Burton@imgtec.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Alex Smith <alex@alex-smith.me.uk>
Subject: RE: [PATCH v7,3/3] MIPS: dts: jz4780/ci20: Add NEMC, BCH and NAND
 device tree nodes
Thread-Topic: [PATCH v7,3/3] MIPS: dts: jz4780/ci20: Add NEMC, BCH and NAND
 device tree nodes
Thread-Index: AQHRAg91/Ek0r9ywG0W1IeF0nGQAP55qvR4w
Date:   Wed, 14 Oct 2015 09:15:16 +0000
Message-ID: <FAF81613212CC5449F9A43554D3E454741A3936E@LEMAIL01.le.imgtec.org>
References: <1444148837-10770-1-git-send-email-harvey.hunt@imgtec.com>
        <1444148837-10770-4-git-send-email-harvey.hunt@imgtec.com>
 <CAAEAJfBtOtiEEJy500-Kg8ZHm+ZGF3vL7y7xJD3a0-3CJ0w33A@mail.gmail.com>
In-Reply-To: <CAAEAJfBtOtiEEJy500-Kg8ZHm+ZGF3vL7y7xJD3a0-3CJ0w33A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.154.54]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <Harvey.Hunt@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Harvey.Hunt@imgtec.com
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

T24gOCBPY3RvYmVyIDIwMTUgYXQgMjI6MjMsIEV6ZXF1aWVsIEdhcmNpYSA8IGV6ZXF1aWVsQHZh
bmd1YXJkaWFzdXIuY29tLmFyPiB3cm90ZToNCj5PbiA2IE9jdG9iZXIgMjAxNSBhdCAxMzoyNywg
SGFydmV5IEh1bnQgPGhhcnZleS5odW50QGltZ3RlYy5jb20+IHdyb3RlOg0KPj4gRnJvbTogQWxl
eCBTbWl0aCA8YWxleC5zbWl0aEBpbWd0ZWMuY29tPg0KPj4NCj4+IEFkZCBkZXZpY2UgdHJlZSBu
b2RlcyBmb3IgdGhlIE5FTUMgYW5kIEJDSCB0byB0aGUgSlo0NzgwIGRldmljZSB0cmVlLA0KPj4g
YW5kIG1ha2UgdXNlIG9mIHRoZW0gaW4gdGhlIENpMjAgZGV2aWNlIHRyZWUgdG8gYWRkIGEgbm9k
ZSBmb3IgdGhlDQo+PiBib2FyZCdzIE5BTkQuDQo+Pg0KPj4gTm90ZSB0aGF0IHNpbmNlIHRoZSBw
aW5jdHJsIGRyaXZlciBpcyBub3QgeWV0IHVwc3RyZWFtLCB0aGlzIGluY2x1ZGVzDQo+PiBuZWl0
aGVyIHBpbiBjb25maWd1cmF0aW9uIG5vciBidXN5L3dyaXRlLXByb3RlY3QgR1BJTyBwaW5zIGZv
ciB0aGUNCj4+IE5BTkQuIFVzZSBvZiB0aGUgTkFORCByZWxpZXMgb24gdGhlIGJvb3QgbG9hZGVy
IHRvIGhhdmUgbGVmdCB0aGUgcGlucw0KPj4gY29uZmlndXJlZCBpbiBhIHVzYWJsZSBzdGF0ZSwg
d2hpY2ggc2hvdWxkIGJlIHRoZSBjYXNlIHdoZW4gYm9vdGVkDQo+PiBmcm9tIHRoZSBOQU5ELg0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IEFsZXggU21pdGggPGFsZXguc21pdGhAaW1ndGVjLmNvbT4N
Cj4+IENjOiBadWJhaXIgTHV0ZnVsbGFoIEtha2FraGVsIDxadWJhaXIuS2FrYWtoZWxAaW1ndGVj
LmNvbT4NCj4+IENjOiBEYXZpZCBXb29kaG91c2UgPGR3bXcyQGluZnJhZGVhZC5vcmc+DQo+PiBD
YzogQnJpYW4gTm9ycmlzIDxjb21wdXRlcnNmb3JwZWFjZUBnbWFpbC5jb20+DQo+PiBDYzogUGF1
bCBCdXJ0b24gPHBhdWwuYnVydG9uQGltZ3RlYy5jb20+DQo+PiBDYzogbGludXgtbXRkQGxpc3Rz
LmluZnJhZGVhZC5vcmcNCj4+IENjOiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPj4gQ2M6
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4+IENjOiBsaW51eC1taXBzQGxpbnV4LW1p
cHMub3JnDQo+PiBDYzogQWxleCBTbWl0aCA8YWxleEBhbGV4LXNtaXRoLm1lLnVrPg0KPj4gU2ln
bmVkLW9mZi1ieTogSGFydmV5IEh1bnQgPGhhcnZleS5odW50QGltZ3RlYy5jb20+DQo+PiAtLS0N
Cj4+IHY2IC0+IHY3Og0KPj4gIC0gQWRkIG5hbmQtZWNjLW1vZGUgdG8gRFQuDQo+PiAgLSBBZGQg
bmFuZC1vbi1mbGFzaC1iYnQgdG8gRFQuDQo+Pg0KPj4gdjQgLT4gdjU6DQo+PiAgLSBOZXcgcGF0
Y2ggYWRkaW5nIERUIG5vZGVzIGZvciB0aGUgTkFORCBzbyB0aGF0IHRoZSBkcml2ZXIgY2FuIGJl
DQo+PiAgICB0ZXN0ZWQuDQo+Pg0KPj4gIGFyY2gvbWlwcy9ib290L2R0cy9pbmdlbmljL2NpMjAu
ZHRzICAgIHwgNTQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gIGFyY2gv
bWlwcy9ib290L2R0cy9pbmdlbmljL2p6NDc4MC5kdHNpIHwgMjYgKysrKysrKysrKysrKysrKw0K
Pj4gIDIgZmlsZXMgY2hhbmdlZCwgODAgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9hcmNoL21pcHMvYm9vdC9kdHMvaW5nZW5pYy9jaTIwLmR0cyBiL2FyY2gvbWlwcy9ib290L2R0
cy9pbmdlbmljL2NpMjAuZHRzDQo+PiBpbmRleCA5ZmNiOWU3Li40NTNmMWQzIDEwMDY0NA0KPj4g
LS0tIGEvYXJjaC9taXBzL2Jvb3QvZHRzL2luZ2VuaWMvY2kyMC5kdHMNCj4+ICsrKyBiL2FyY2gv
bWlwcy9ib290L2R0cy9pbmdlbmljL2NpMjAuZHRzDQo+PiBAQCAtNDIsMyArNDIsNTcgQEANCj4+
ICAmdWFydDQgew0KPj4gICAgICAgICBzdGF0dXMgPSAib2theSI7DQo+PiAgfTsNCj4+ICsNCj4+
ICsmbmVtYyB7DQo+PiArICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4+ICsNCj4+ICsgICAgICAg
bmFuZDogbmFuZEAxIHsNCj4+ICsgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImluZ2VuaWMs
ano0NzgwLW5hbmQiOw0KPj4gKyAgICAgICAgICAgICAgIHJlZyA9IDwxIDAgMHgxMDAwMDAwPjsN
Cj4+ICsNCj4NCj5XaHkgaXMgdGhpcyBpbiB0aGUgY2kyMC5kdHMgaW5zdGVhZCBvZiB0aGUgU29D
IGR0c2k/DQo+DQo+U2VlbXMgYXQgbGVhc3QgY29tcGF0aWJsZSBhbmQgcmVnIGlzIG5vdCBib2Fy
ZC1zcGVjaWZpYy4NCj4NCj5UaGFua3MsDQo+LS0gDQo+RXplcXVpZWwgR2FyY8OtYSwgVmFuZ3Vh
cmRpYVN1cg0KPnd3dy52YW5ndWFyZGlhc3VyLmNvbS5hcg0KDQpIaSBFemVxdWllbCwNCg0KVGhl
IG51bWJlciBvZiBOQU5EIG5vZGVzIHVuZGVyIHRoZSBORU1DIG5vZGUgaXMgYm9hcmQgc3BlY2lm
aWMgLSBzb21lIGRldmljZXMNCmNvdWxkIGhhdmUgMiBOQU5EIGJhbmtzIGFuZCBvdGhlcnMgY291
bGQgaGF2ZSBub25lLiBJbmNsdWRpbmcgdGhlIGNvbXBhdGlibGUNCnByb3BlcnR5IGluIGp6NDc4
MC5kdHNpIHdvdWxkIGltcGx5IHRoYXQgYWxsIEpaNDc4MCBib2FyZHMgaGF2ZSBhdCBsZWFzdCBv
bmUgTkFORCBiYW5rLg0KDQpUaGUgc2l6ZSBpbiB0aGUgcmVnIHByb3BlcnR5IHdvdWxkIGJlIHRo
ZSBzYW1lIGZvciBhbGwgTkFORCBkZXZpY2VzIChhcyBpdCByZWZlcnMgdG8gdGhlDQpOQU5EIHJl
Z2lzdGVycyksIGhvd2V2ZXIgdGhlIGJhbmsgbnVtYmVyIHdvdWxkIGJlIGRpZmZlcmVudCwgc28g
dGhhdCBjYW4gYWxzbyBiZSBzZWVuDQphcyBib2FyZCBzcGVjaWZpYy4NCg0KVGhhbmtzLA0KDQpI
YXJ2ZXkNCg==
