Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2010 18:03:40 +0100 (CET)
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:17574
        "EHLO VA3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492069Ab0KXRDf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Nov 2010 18:03:35 +0100
Received: from mail160-va3-R.bigfish.com (10.7.14.250) by
 VA3EHSOBE005.bigfish.com (10.7.40.25) with Microsoft SMTP Server id
 14.1.225.8; Wed, 24 Nov 2010 17:03:28 +0000
Received: from mail160-va3 (localhost.localdomain [127.0.0.1])  by
 mail160-va3-R.bigfish.com (Postfix) with ESMTP id 451B916F02A4;        Wed, 24 Nov
 2010 17:03:28 +0000 (UTC)
X-SpamScore: -27
X-BigFish: VPS-27(zz542N1432N14ffO9371Pzz1202hzz8275dhz2dh95h691h668h67dh685h61h)
X-Forefront-Antispam-Report: KIP:(null);UIP:(null);IPVD:NLI;H:xsj-gw1;RD:unknown-60-83.xilinx.com;EFVD:NLI
Received: from mail160-va3 (localhost.localdomain [127.0.0.1]) by mail160-va3
 (MessageSwitch) id 12906182089873_26086; Wed, 24 Nov 2010 17:03:28 +0000
 (UTC)
Received: from VA3EHSMHS019.bigfish.com (unknown [10.7.14.239]) by
 mail160-va3.bigfish.com (Postfix) with ESMTP id DC15C3A8050;   Wed, 24 Nov 2010
 17:03:27 +0000 (UTC)
Received: from xsj-gw1 (149.199.60.83) by VA3EHSMHS019.bigfish.com
 (10.7.99.29) with Microsoft SMTP Server id 14.1.225.8; Wed, 24 Nov 2010
 17:03:23 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]
 helo=xsj-smtp1.xilinx.com)     by xsj-gw1 with esmtp (Exim 4.63)       (envelope-from
 <stephen.neuendorffer@xilinx.com>)     id 1PLIkd-0000wR-2n; Wed, 24 Nov 2010
 09:03:23 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: Mega rename of device tree routines from of_*() to dt_*()
Date:   Wed, 24 Nov 2010 09:02:18 -0800
In-Reply-To: <1290607413.12457.44.camel@concordia>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Mega rename of device tree routines from of_*() to dt_*()
Thread-Index: AcuL4IxPnEXiFsmISpat6zMuVNPGJgAGC53g
References: <1290607413.12457.44.camel@concordia>
From:   Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To:     <michael@ellerman.id.au>, LKML <linux-kernel@vger.kernel.org>
CC:     linux-mips <linux-mips@linux-mips.org>,
        <microblaze-uclinux@itee.uq.edu.au>,
        <devicetree-discuss@lists.ozlabs.org>,
        linuxppc-dev list <linuxppc-dev@ozlabs.org>,
        <sparclinux@vger.kernel.org>
X-OriginalArrivalTime: 24 Nov 2010 17:03:22.0310 (UTC) FILETIME=[80233660:01CB8BF9]
X-RCIS-Action: ALLOW
Message-ID: <fa44e045-9600-4c46-939a-af246afab4f6@VA3EHSMHS019.ehs.local>
X-OriginatorOrg: xilinx.com
Return-Path: <stephen.neuendorffer@xilinx.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stephen.neuendorffer@xilinx.com
Precedence: bulk
X-list: linux-mips

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXhwcGMtZGV2LWJv
dW5jZXMrc3RlcGhlbj1uZXVlbmRvcmZmZXIubmFtZUBsaXN0cy5vemxhYnMub3JnIFttYWlsdG86
bGludXhwcGMtZGV2LQ0KPiBib3VuY2VzK3N0ZXBoZW49bmV1ZW5kb3JmZmVyLm5hbWVAbGlzdHMu
b3psYWJzLm9yZ10gT24gQmVoYWxmIE9mIE1pY2hhZWwgRWxsZXJtYW4NCj4gU2VudDogV2VkbmVz
ZGF5LCBOb3ZlbWJlciAyNCwgMjAxMCA2OjA0IEFNDQo+IFRvOiBMS01MDQo+IENjOiBsaW51eC1t
aXBzOyBtaWNyb2JsYXplLXVjbGludXhAaXRlZS51cS5lZHUuYXU7IGRldmljZXRyZWUtZGlzY3Vz
c0BsaXN0cy5vemxhYnMub3JnOyBsaW51eHBwYy1kZXYNCj4gbGlzdDsgc3BhcmNsaW51eEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUkZDOiBNZWdhIHJlbmFtZSBvZiBkZXZpY2UgdHJlZSBy
b3V0aW5lcyBmcm9tIG9mXyooKSB0byBkdF8qKCkNCj4gDQo+IEhpIGFsbCwNCj4gDQo+IFRoZXJl
IHdlcmUgc29tZSBtdXJtdXJpbmdzIG9uIElSQyBsYXN0IHdlZWsgYWJvdXQgcmVuYW1pbmcgdGhl
IG9mXyooKQ0KPiByb3V0aW5lcy4gSSB3YXMgcHJvY3Jhc3RpbmF0aW5nIGF0IHRoZSB0aW1lIGFu
ZCBzYWlkIEknZCBoYXZlIGEgbG9vayBhdA0KPiBpdCwgc28gaGVyZSBJIGFtLg0KPiANCj4gVGhl
IHRoaW5raW5nIGlzIHRoYXQgb24gbWFueSBwbGF0Zm9ybXMgdGhhdCB1c2UgdGhlIG9mXygpIHJv
dXRpbmVzDQo+IE9wZW5GaXJtd2FyZSBpcyBub3QgaW52b2x2ZWQgYXQgYWxsLCB0aGlzIGlzIHRy
dWUgZXZlbiBvbiBtYW55IHBvd2VycGMNCj4gcGxhdGZvcm1zLiBBbHNvIGZvciBmb2xrcyB3aG8g
ZG9uJ3Qga25vdyB0aGUgT3BlbkZpcm13YXJlIGNvbm5lY3Rpb24gaXQNCj4gcmVhZHMgYXMgIm9m
IiwgYXMgaW4gImEgY2FuIG9mIHdvcm1zIi4NCj4gDQo+IFBlcnNvbmFsbHkgSSdtIGEgYml0IGFt
Yml2YWxlbnQgYWJvdXQgaXQsIHRoZSBPRiBuYW1lIGlzIGEgYml0IHdyb25nIHNvDQo+IGl0IHdv
dWxkIGJlIG5pY2UgdG8gZ2V0IHJpZCBvZiwgYnV0IGl0J3MgYSBsb3Qgb2YgY2h1cm4uDQo+IA0K
PiBTbyBJJ20gaG9waW5nIHBlb3BsZSB3aXRoIGVpdGhlciBzYXkgIllFUyB0aGlzIGlzIGEgZ3Jl
YXQgaWRlYSIsIG9yICJOTw0KPiB0aGlzIGlzIHN0dXBpZCIuDQoNClBlcnNvbmFsbHksIEkgdGhp
bmsgaXQncyBhIGdyZWF0IGlkZWEsIGlmIG9ubHkgYmVjYXVzZSBJIHN0YXJlZCBsb25nIGFuZCBo
YXJkDQphdCB0aGUgY29kZSBvbmNlIHVwb24gYSB0aW1lIHRyeWluZyB0byBmaWd1cmUgb3V0IHdo
YXQgaXMgcmVhbGx5IE9GLXJlbGF0ZWQNCmFuZCB3aGF0IGlzbid0LiAgSXQncyBzb21ld2hhdCBj
bGVhcmVyIG5vdyB0aGF0IGRyaXZlcnMvb2YgaGFzIGJlZW4gZmFjdG9yZWQNCm91dCAoYWx0aG91
Z2gsIHNob3VsZG4ndCBpdCBiZSBkcml2ZXJzL2R0Pz8/KQ0KDQpUaGF0IHNhaWQsIGl0ICppcyog
YWxvdCBvZiBjb2RlIGNodXJuLiAgSWYgaXQncyBnb2luZyB0byBiZSBkb25lLCBJIHRoaW5rIGl0
IHNob3VsZCBiZQ0KZG9uZSBpbiBjb25jZXJ0IHdpdGggZml4aW5nIGEgYnVuY2ggb2YgdGhlIGZ1
bmN0aW9uIG5hbWVzIHdoaWNoIGRvbid0IHJlYWxseSBmb2xsb3cgYW55DQpzYW5lIG5hbWluZyBj
b252ZW50aW9uLCBzbyB0aGF0IHRoZSBiYWNrcG9ydGluZyBkaXNjb250aW51aXR5IG9ubHkgaGFw
cGVucyBvbmNlLg0KDQpTdGV2ZQ0KClRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBhcmUg
aW50ZW5kZWQgZm9yIHRoZSBzb2xlIHVzZSBvZiB0aGUgbmFtZWQgcmVjaXBpZW50KHMpIGFuZCBj
b250YWluKHMpIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiB0aGF0IG1heSBiZSBwcm9wcmlldGFy
eSwgcHJpdmlsZWdlZCBvciBjb3B5cmlnaHRlZCB1bmRlciBhcHBsaWNhYmxlIGxhdy4gSWYgeW91
IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgZG8gbm90IHJlYWQsIGNvcHksIG9yIGZv
cndhcmQgdGhpcyBlbWFpbCBtZXNzYWdlIG9yIGFueSBhdHRhY2htZW50cy4gRGVsZXRlIHRoaXMg
ZW1haWwgbWVzc2FnZSBhbmQgYW55IGF0dGFjaG1lbnRzIGltbWVkaWF0ZWx5Lgo=
