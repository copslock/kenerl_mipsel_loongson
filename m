Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2017 17:01:40 +0100 (CET)
Received: from mga03.intel.com ([134.134.136.65]:41082 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993890AbdAZQBeV6NKJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Jan 2017 17:01:34 +0100
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP; 26 Jan 2017 08:01:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,290,1477983600"; 
   d="scan'208";a="57536201"
Received: from irsmsx110.ger.corp.intel.com ([163.33.3.25])
  by orsmga005.jf.intel.com with ESMTP; 26 Jan 2017 08:01:05 -0800
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.112]) by
 irsmsx110.ger.corp.intel.com ([169.254.15.101]) with mapi id 14.03.0248.002;
 Thu, 26 Jan 2017 16:01:04 +0000
From:   "Langer, Thomas" <thomas.langer@intel.com>
To:     Seb <sebtx452@gmail.com>
CC:     Hauke Mehrtens <hauke@hauke-m.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH] mtd: maps: lantiq-flash: Check if the EBU endianness
 swap is enabled
Thread-Topic: [PATCH] mtd: maps: lantiq-flash: Check if the EBU endianness
 swap is enabled
Thread-Index: AQHScwBrHfwN+0YKQEuSGTTzK941nKFILNyAgADBPoCAAAnf4IABqUYAgAAGvpA=
Date:   Thu, 26 Jan 2017 16:01:04 +0000
Message-ID: <0DAF21CFE1B20740AE23D6AF6E54843F1E6F9DE6@IRSMSX101.ger.corp.intel.com>
References: <1484904834-14980-1-git-send-email-sebtx452@gmail.com>
 <3304d64f-38aa-1a3c-0b5d-edb493abd61a@hauke-m.de>
 <CA+hF=GdKLEN2ue=Q7KpBp+W+bTnj5O_OAoPjuDOScga2efnjPA@mail.gmail.com>
 <0DAF21CFE1B20740AE23D6AF6E54843F1E6F607C@IRSMSX101.ger.corp.intel.com>
 <CA+hF=GcW2W6T08BZYXoZQcpe=+QuPp0H7kT2ci+6Td-ZZL+ouQ@mail.gmail.com>
In-Reply-To: <CA+hF=GcW2W6T08BZYXoZQcpe=+QuPp0H7kT2ci+6Td-ZZL+ouQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.239.180]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <thomas.langer@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56519
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

SGkgU2ViYXN0aWFuLA0KDQo+IA0KPiA+IFdlIHNob3VsZCBpbnRyb2R1Y2Ugc3BlY2lmaWMgY29t
cGF0aWJsZSBzdHJpbmdzIGZvciB0aGlzIGRyaXZlciwgd2hpY2gNCj4gdHJpZ2dlciB0aGlzLA0K
PiA+IGUuZy4gImxhbnRpcSxub3ItdnI5IiBvciAibGFudGlxLG5vci1hcjEwIiAob3IgYmV0dGVy
IHVzaW5nIGZhbWlseSBuYW1lcw0KPiAieHJ4MjAwIiBhbmQgInhyeDMwMCIpDQo+IA0KPiBZb3Ug
bWVhbiB3ZSBjYW4gdXNlIHRoZSBzYW1lIHdheSBhcyBvdGhlciBkcml2ZXJzLCBmb3IgZXhhbXBs
ZSBpbiB0aGUNCj4gcGh5c21hcF9vZl92ZXJzYXRpbGUuYyBmaWxlIDoNCj4gDQo+IHN0YXRpYyBj
b25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHN5c2Nvbl9tYXRjaFtdID0gew0KPiAgICAgICAgIHsN
Cj4gICAgICAgICAgICAgICAgIC5jb21wYXRpYmxlID0gImFybSxpbnRlZ3JhdG9yLWFwLXN5c2Nv
biIsDQo+ICAgICAgICAgICAgICAgICAuZGF0YSA9ICh2b2lkICopSU5URUdSQVRPUl9BUF9GTEFT
SFBST1QsDQo+ICAgICAgICAgfSwNCj4gICAgICAgICB7DQo+ICAgICAgICAgICAgICAgICAuY29t
cGF0aWJsZSA9ICJhcm0saW50ZWdyYXRvci1jcC1zeXNjb24iLA0KPiAgICAgICAgICAgICAgICAg
LmRhdGEgPSAodm9pZCAqKUlOVEVHUkFUT1JfQ1BfRkxBU0hQUk9ULA0KPiAgICAgICAgIH0sDQo+
IA0KPiBldGMuLi4NCj4gDQo+IA0KPiBXZSBjYW4ndCBmaWx0ZXIgb24geHJ4MjAwIG9yIHZyOSwg
YnV0IHdlIGhhdmUgdG8ga25vdyB0aGUgVlI5IHZlcnNpb24NCj4gKGFzIHRoZSBWUjkgPCAxLjIg
aXMgbm90IGNvbXBhdGlibGUgd2l0aCB0aGlzIHBhdGNoKS4NCg0KVGhlbiBleHRlbmQgdGhlIGNv
bXBhdGlibGUgc3RyaW5ncyB3aXRoIHZlcnNpb25zICh3aGVyZSBuZWNlc3NhcnkpLg0KVGhpcyBy
ZXF1aXJlcyB0byBrbm93IHRoZSBTb0MgdmVyc2lvbiBmb3IgZWFjaCBib2FyZCwgYnV0IGl0IHNo
b3VsZCBiZSANCm9rYXkgYW5kIGlzIGRvbmUgZm9yIG90aGVyIHN5c3RlbSBhbHJlYWR5IHRoaXMg
d2F5Lg0KDQo+IA0KPiBSZWdhcmRzLA0KPiANCj4gU2ViYXN0aWVuDQoNClJlZ2FyZHMsDQpUaG9t
YXMNCg==
