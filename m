Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2010 19:33:39 +0100 (CET)
Received: from sg2ehsobe001.messaging.microsoft.com ([207.46.51.75]:28981 "EHLO
        SG2EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491050Ab0KXSdf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Nov 2010 19:33:35 +0100
Received: from mail204-sin-R.bigfish.com (10.210.100.249) by
 SG2EHSOBE001.bigfish.com (10.210.112.21) with Microsoft SMTP Server id
 14.1.225.8; Wed, 24 Nov 2010 18:33:18 +0000
Received: from mail204-sin (localhost.localdomain [127.0.0.1])  by
 mail204-sin-R.bigfish.com (Postfix) with ESMTP id 0D624A7005B; Wed, 24 Nov
 2010 18:33:18 +0000 (UTC)
X-SpamScore: -36
X-BigFish: VPS-36(zzbb2dK542N1432N98dN14ffO9371Pzz1202hzz8275dhz2dh95h691h668h67dh685h61h)
X-Forefront-Antispam-Report: KIP:(null);UIP:(null);IPVD:NLI;H:xsj-gw1;RD:unknown-60-83.xilinx.com;EFVD:NLI
Received: from mail204-sin (localhost.localdomain [127.0.0.1]) by mail204-sin
 (MessageSwitch) id 1290623597550139_25476; Wed, 24 Nov 2010 18:33:17 +0000
 (UTC)
Received: from SG2EHSMHS007.bigfish.com (unknown [10.210.100.250])      by
 mail204-sin.bigfish.com (Postfix) with ESMTP id 3CF6077804E;   Wed, 24 Nov 2010
 18:33:17 +0000 (UTC)
Received: from xsj-gw1 (149.199.60.83) by SG2EHSMHS007.bigfish.com
 (10.210.125.17) with Microsoft SMTP Server id 14.1.225.8; Wed, 24 Nov 2010
 18:33:16 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]
 helo=xsj-smtp1.xilinx.com)     by xsj-gw1 with esmtp (Exim 4.63)       (envelope-from
 <stephen.neuendorffer@xilinx.com>)     id 1PLK9b-0006NZ-S9; Wed, 24 Nov 2010
 10:33:15 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: Mega rename of device tree routines from of_*() to dt_*()
Date:   Wed, 24 Nov 2010 10:32:11 -0800
In-Reply-To: <4CED48CE.5060300@caviumnetworks.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Mega rename of device tree routines from of_*() to dt_*()
Thread-Index: AcuL+5MExKaPVux0RsiMeMP0dz+DbQACj7rQ
References: <1290607413.12457.44.camel@concordia> <fa44e045-9600-4c46-939a-af246afab4f6@VA3EHSMHS019.ehs.local> <4CED48CE.5060300@caviumnetworks.com>
From:   Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To:     David Daney <ddaney@caviumnetworks.com>
CC:     <michael@ellerman.id.au>, LKML <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        <microblaze-uclinux@itee.uq.edu.au>,
        <devicetree-discuss@lists.ozlabs.org>,
        linuxppc-dev list <linuxppc-dev@ozlabs.org>,
        <sparclinux@vger.kernel.org>
X-OriginalArrivalTime: 24 Nov 2010 18:33:14.0966 (UTC) FILETIME=[0E693760:01CB8C06]
X-RCIS-Action: ALLOW
Message-ID: <ee487d0b-ec9d-42a9-9c8e-39f83858cffc@SG2EHSMHS007.ehs.local>
X-OriginatorOrg: xilinx.com
Return-Path: <stephen.neuendorffer@xilinx.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stephen.neuendorffer@xilinx.com
Precedence: bulk
X-list: linux-mips

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgRGFuZXkgW21h
aWx0bzpkZGFuZXlAY2F2aXVtbmV0d29ya3MuY29tXQ0KPiBTZW50OiBXZWRuZXNkYXksIE5vdmVt
YmVyIDI0LCAyMDEwIDk6MTggQU0NCj4gVG86IFN0ZXBoZW4gTmV1ZW5kb3JmZmVyDQo+IENjOiBt
aWNoYWVsQGVsbGVybWFuLmlkLmF1OyBMS01MOyBsaW51eC1taXBzOyBtaWNyb2JsYXplLXVjbGlu
dXhAaXRlZS51cS5lZHUuYXU7IGRldmljZXRyZWUtDQo+IGRpc2N1c3NAbGlzdHMub3psYWJzLm9y
ZzsgbGludXhwcGMtZGV2IGxpc3Q7IHNwYXJjbGludXhAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBNZWdhIHJlbmFtZSBvZiBkZXZpY2UgdHJlZSByb3V0aW5lcyBmcm9tIG9mXyooKSB0
byBkdF8qKCkNCj4gDQo+IE9uIDExLzI0LzIwMTAgMDk6MDIgQU0sIFN0ZXBoZW4gTmV1ZW5kb3Jm
ZmVyIHdyb3RlOg0KPiA+DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
Pj4gRnJvbTogbGludXhwcGMtZGV2LWJvdW5jZXMrc3RlcGhlbj1uZXVlbmRvcmZmZXIubmFtZUBs
aXN0cy5vemxhYnMub3JnIFttYWlsdG86bGludXhwcGMtZGV2LQ0KPiA+PiBib3VuY2VzK3N0ZXBo
ZW49bmV1ZW5kb3JmZmVyLm5hbWVAbGlzdHMub3psYWJzLm9yZ10gT24gQmVoYWxmIE9mIE1pY2hh
ZWwgRWxsZXJtYW4NCj4gPj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAyNCwgMjAxMCA2OjA0
IEFNDQo+ID4+IFRvOiBMS01MDQo+ID4+IENjOiBsaW51eC1taXBzOyBtaWNyb2JsYXplLXVjbGlu
dXhAaXRlZS51cS5lZHUuYXU7IGRldmljZXRyZWUtZGlzY3Vzc0BsaXN0cy5vemxhYnMub3JnOyBs
aW51eHBwYy0NCj4gZGV2DQo+ID4+IGxpc3Q7IHNwYXJjbGludXhAdmdlci5rZXJuZWwub3JnDQo+
ID4+IFN1YmplY3Q6IFJGQzogTWVnYSByZW5hbWUgb2YgZGV2aWNlIHRyZWUgcm91dGluZXMgZnJv
bSBvZl8qKCkgdG8gZHRfKigpDQo+ID4+DQo+ID4+IEhpIGFsbCwNCj4gPj4NCj4gPj4gVGhlcmUg
d2VyZSBzb21lIG11cm11cmluZ3Mgb24gSVJDIGxhc3Qgd2VlayBhYm91dCByZW5hbWluZyB0aGUg
b2ZfKigpDQo+ID4+IHJvdXRpbmVzLiBJIHdhcyBwcm9jcmFzdGluYXRpbmcgYXQgdGhlIHRpbWUg
YW5kIHNhaWQgSSdkIGhhdmUgYSBsb29rIGF0DQo+ID4+IGl0LCBzbyBoZXJlIEkgYW0uDQo+ID4+
DQo+ID4+IFRoZSB0aGlua2luZyBpcyB0aGF0IG9uIG1hbnkgcGxhdGZvcm1zIHRoYXQgdXNlIHRo
ZSBvZl8oKSByb3V0aW5lcw0KPiA+PiBPcGVuRmlybXdhcmUgaXMgbm90IGludm9sdmVkIGF0IGFs
bCwgdGhpcyBpcyB0cnVlIGV2ZW4gb24gbWFueSBwb3dlcnBjDQo+ID4+IHBsYXRmb3Jtcy4gQWxz
byBmb3IgZm9sa3Mgd2hvIGRvbid0IGtub3cgdGhlIE9wZW5GaXJtd2FyZSBjb25uZWN0aW9uIGl0
DQo+ID4+IHJlYWRzIGFzICJvZiIsIGFzIGluICJhIGNhbiBvZiB3b3JtcyIuDQo+ID4+DQo+ID4+
IFBlcnNvbmFsbHkgSSdtIGEgYml0IGFtYml2YWxlbnQgYWJvdXQgaXQsIHRoZSBPRiBuYW1lIGlz
IGEgYml0IHdyb25nIHNvDQo+ID4+IGl0IHdvdWxkIGJlIG5pY2UgdG8gZ2V0IHJpZCBvZiwgYnV0
IGl0J3MgYSBsb3Qgb2YgY2h1cm4uDQo+ID4+DQo+ID4+IFNvIEknbSBob3BpbmcgcGVvcGxlIHdp
dGggZWl0aGVyIHNheSAiWUVTIHRoaXMgaXMgYSBncmVhdCBpZGVhIiwgb3IgIk5PDQo+ID4+IHRo
aXMgaXMgc3R1cGlkIi4NCj4gPg0KPiA+IFBlcnNvbmFsbHksIEkgdGhpbmsgaXQncyBhIGdyZWF0
IGlkZWEsIGlmIG9ubHkgYmVjYXVzZSBJIHN0YXJlZCBsb25nIGFuZCBoYXJkDQo+ID4gYXQgdGhl
IGNvZGUgb25jZSB1cG9uIGEgdGltZSB0cnlpbmcgdG8gZmlndXJlIG91dCB3aGF0IGlzIHJlYWxs
eSBPRi1yZWxhdGVkDQo+ID4gYW5kIHdoYXQgaXNuJ3QuICBJdCdzIHNvbWV3aGF0IGNsZWFyZXIg
bm93IHRoYXQgZHJpdmVycy9vZiBoYXMgYmVlbiBmYWN0b3JlZA0KPiA+IG91dCAoYWx0aG91Z2gs
IHNob3VsZG4ndCBpdCBiZSBkcml2ZXJzL2R0Pz8/KQ0KPiA+DQo+ID4gVGhhdCBzYWlkLCBpdCAq
aXMqIGFsb3Qgb2YgY29kZSBjaHVybi4gIElmIGl0J3MgZ29pbmcgdG8gYmUgZG9uZSwgSSB0aGlu
ayBpdCBzaG91bGQgYmUNCj4gPiBkb25lIGluIGNvbmNlcnQgd2l0aCBmaXhpbmcgYSBidW5jaCBv
ZiB0aGUgZnVuY3Rpb24gbmFtZXMgd2hpY2ggZG9uJ3QgcmVhbGx5IGZvbGxvdyBhbnkNCj4gPiBz
YW5lIG5hbWluZyBjb252ZW50aW9uLCBzbyB0aGF0IHRoZSBiYWNrcG9ydGluZyBkaXNjb250aW51
aXR5IG9ubHkgaGFwcGVucyBvbmNlLg0KPiA+DQo+IA0KPiBPaCwgeW91IG1lYW4gdGhpbmdzIGxp
a2U6DQo+IA0KPiBvZl97LHVufXJlZ2lzdGVyX3BsYXRmb3JtX2RyaXZlciB2cy4gcGxhdGZvcm1f
ZHJpdmVyX3ssdW59cmVnaXN0ZXINCj4gDQo+IFRoYXQgb25lIGlzIHBhcnRpY3VsYXJseSBhbm5v
eWluZyB0byBtZS4NCj4gDQo+IERhdmlkIERhbmV5DQoNCkFjdHVhbGx5LCBJIHdhcyBwYXJ0aWN1
bGFybHkgdGhpbmtpbmcgb2YgZHJpdmVycy9vZi9mZHQuYywgd2hpY2ggSSB3YXMgcmVjZW50bHkg
aGFja2luZyBhcm91bmQgd2l0aCwNCmJ1dCBJJ20gc3VyZSB0aGVyZSBhcmUgb3RoZXJzLi4uIDop
DQoNClN0ZXZlDQoKVGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIGFyZSBpbnRlbmRlZCBm
b3IgdGhlIHNvbGUgdXNlIG9mIHRoZSBuYW1lZCByZWNpcGllbnQocykgYW5kIGNvbnRhaW4ocykg
Y29uZmlkZW50aWFsIGluZm9ybWF0aW9uIHRoYXQgbWF5IGJlIHByb3ByaWV0YXJ5LCBwcml2aWxl
Z2VkIG9yIGNvcHlyaWdodGVkIHVuZGVyIGFwcGxpY2FibGUgbGF3LiBJZiB5b3UgYXJlIG5vdCB0
aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBkbyBub3QgcmVhZCwgY29weSwgb3IgZm9yd2FyZCB0aGlz
IGVtYWlsIG1lc3NhZ2Ugb3IgYW55IGF0dGFjaG1lbnRzLiBEZWxldGUgdGhpcyBlbWFpbCBtZXNz
YWdlIGFuZCBhbnkgYXR0YWNobWVudHMgaW1tZWRpYXRlbHkuCg==
