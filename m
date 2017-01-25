Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2017 17:58:54 +0100 (CET)
Received: from mga05.intel.com ([192.55.52.43]:42660 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993874AbdAYQ6sIME4k (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Jan 2017 17:58:48 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP; 25 Jan 2017 08:58:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,284,1477983600"; 
   d="scan'208";a="1117728651"
Received: from irsmsx110.ger.corp.intel.com ([163.33.3.25])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jan 2017 08:58:45 -0800
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.112]) by
 irsmsx110.ger.corp.intel.com ([169.254.15.101]) with mapi id 14.03.0248.002;
 Wed, 25 Jan 2017 16:58:45 +0000
From:   "Langer, Thomas" <thomas.langer@intel.com>
To:     Seb <sebtx452@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH] mtd: maps: lantiq-flash: Check if the EBU endianness
 swap is enabled
Thread-Topic: [PATCH] mtd: maps: lantiq-flash: Check if the EBU endianness
 swap is enabled
Thread-Index: AQHScwBrHfwN+0YKQEuSGTTzK941nKFILNyAgADBPoCAAAnf4A==
Date:   Wed, 25 Jan 2017 16:58:44 +0000
Message-ID: <0DAF21CFE1B20740AE23D6AF6E54843F1E6F607C@IRSMSX101.ger.corp.intel.com>
References: <1484904834-14980-1-git-send-email-sebtx452@gmail.com>
 <3304d64f-38aa-1a3c-0b5d-edb493abd61a@hauke-m.de>
 <CA+hF=GdKLEN2ue=Q7KpBp+W+bTnj5O_OAoPjuDOScga2efnjPA@mail.gmail.com>
In-Reply-To: <CA+hF=GdKLEN2ue=Q7KpBp+W+bTnj5O_OAoPjuDOScga2efnjPA@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.239.181]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <thomas.langer@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.langer@intel.com
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

PiBIZWxsbywNCg0KSGkgU2ViYXN0aWFuDQoNCj4gDQo+IA0KPiA+IEkgd291bGQgcHJlZmVyIHRv
IHVzZSBhIGRldmljZSB0cmVlIG9wdGlvbiB0byBhY3RpdmF0ZSB0aGlzIGNoZWNrIGFuZA0KPiA+
IG9ubHkgYWNjZXNzIExUUV9FQlVfQlVTQ09OMCB3aGVuIHRoaXMgcHJvcGVydHkgaXMgc2V0Lg0K
PiANCj4gSWYgSSB1bmRlcnN0YW5kIGNvcnJlY3RseSwgSSBoYXZlIHRvIG1ha2Ugc29tZXRoaW5n
IGxpa2UgdGhpcyA6DQo+IA0KPiAtLS0NCj4gDQo+IGJvb2wgbXRkX2FkZHJfc3dhcD10cnVlOw0K
PiANCj4gICAgICAgICBpZiAoIW9mX21hY2hpbmVfaXNfY29tcGF0aWJsZSgibGFudGlxLGZhbGNv
biIpICYmDQo+ICAgICAgICAgICAgICAgICBvZl9maW5kX3Byb3BlcnR5KHBkZXYtPmRldi5vZl9u
b2RlLA0KPiAibGFudGlxLGVidV9zd2FwX2NoZWNrIiwgTlVMTCkpDQo+ICAgICAgICAgICAgICAg
ICBpZiAobHRxX2VidV9yMzIoTFRRX0VCVV9CVVNDT04wKSAmIEVCVV9GTEFTSF9FTkRJQU5fU1dB
UCkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgbXRkX2FkZHJfc3dhcCA9IGZhbHNlOw0KPiAN
Cg0KTm8sIHBsZWFzZSBhdm9pZCAib2ZfbWFjaGluZV9pc19jb21wYXRpYmxlIiBpbiBkcml2ZXJz
Lg0KDQo+IC0tLQ0KPiANCj4gQW5kIHRoZW4gc2V0IHRoaXMgcHJvcGVydHkgZGlyZWN0bHkgb24g
bXkgZGV2aWNlLXNwZWNpZmljIGR0cyBmaWxlID8NCg0KV2Ugc2hvdWxkIGludHJvZHVjZSBzcGVj
aWZpYyBjb21wYXRpYmxlIHN0cmluZ3MgZm9yIHRoaXMgZHJpdmVyLCB3aGljaCB0cmlnZ2VyIHRo
aXMsDQplLmcuICJsYW50aXEsbm9yLXZyOSIgb3IgImxhbnRpcSxub3ItYXIxMCIgKG9yIGJldHRl
ciB1c2luZyBmYW1pbHkgbmFtZXMgInhyeDIwMCIgYW5kICJ4cngzMDAiKQ0KDQpSZWdhcmRzLA0K
VGhvbWFzDQo=
