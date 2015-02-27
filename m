Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Feb 2015 21:46:05 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1049 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007655AbbB0UqEKv8hm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Feb 2015 21:46:04 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1C3339C8B1BF3;
        Fri, 27 Feb 2015 20:45:55 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 27 Feb 2015 20:45:58 +0000
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0210.002; Fri, 27 Feb 2015 20:45:57 +0000
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Andrew Bresticker <abrestic@chromium.org>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
CC:     Paul Burton <Paul.Burton@imgtec.com>,
        "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
        Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>,
        "James Hartley" <James.Hartley@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        John Crispin <blogic@openwrt.org>,
        Jonas Gorski <jogo@openwrt.org>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "cernekee@chromium.org" <cernekee@chromium.org>
Subject: RE: [U-Boot] MIPS UHI spec
Thread-Topic: [U-Boot] MIPS UHI spec
Thread-Index: AdBMQI537hxWUscaS6q93yLVEXyfqwFbORGAAATiDwAADBgEgAAiQtOAAA4b5AAABoZ34A==
Date:   Fri, 27 Feb 2015 20:45:56 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B0235320FE3C49@LEMAIL01.le.imgtec.org>
References: <6D39441BF12EF246A7ABCE6654B0235320FDC2AC@LEMAIL01.le.imgtec.org>
        <20150226101739.GY17695@NP-P-BURTON>
        <CACUy__Ux6v9O0RmSiUr6vDDJ8JSDPCsCTqm=KOiNM0M=x3hoQQ@mail.gmail.com>
        <CAL1qeaGT9DGnVN4Lg0McCESxuwphLFuoo1m96H5nauRcyF24xg@mail.gmail.com>
        <CACUy__UdCSMW4cLDKMvu3CLBeaKpSbJ19zCMP29hwT+T_y7q4g@mail.gmail.com>
 <CAL1qeaGsNZE0arPSpQykDoxDiwFpSuLQopvqts4MsQ6BT3VeEw@mail.gmail.com>
In-Reply-To: <CAL1qeaGsNZE0arPSpQykDoxDiwFpSuLQopvqts4MsQ6BT3VeEw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.159.95]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <Matthew.Fortune@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Matthew.Fortune@imgtec.com
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

QW5kcmV3IEJyZXN0aWNrZXIgPGFicmVzdGljQGNocm9taXVtLm9yZz4gd3JpdGVzOg0KPiBPbiBG
cmksIEZlYiAyNywgMjAxNSBhdCAyOjQ0IEFNLCBEYW5pZWwgU2Nod2llcnplY2sNCj4gPGRhbmll
bC5zY2h3aWVyemVja0BnbWFpbC5jb20+IHdyb3RlOg0KPiA+IDIwMTUtMDItMjYgMTk6MjMgR01U
KzAxOjAwIEFuZHJldyBCcmVzdGlja2VyIDxhYnJlc3RpY0BjaHJvbWl1bS5vcmc+Og0KPiA+PiBI
aSwNCj4gPj4NCj4gPj4gT24gVGh1LCBGZWIgMjYsIDIwMTUgYXQgNDozNyBBTSwgRGFuaWVsIFNj
aHdpZXJ6ZWNrDQo+ID4+IDxkYW5pZWwuc2Nod2llcnplY2tAZ21haWwuY29tPiB3cm90ZToNCj4g
Pj4+IDIwMTUtMDItMjYgMTE6MTcgR01UKzAxOjAwIFBhdWwgQnVydG9uIDxwYXVsLmJ1cnRvbkBp
bWd0ZWMuY29tPjoNCj4gPj4+PiBPbiBUaHUsIEZlYiAxOSwgMjAxNSBhdCAwMTo1MDoyM1BNICsw
MDAwLCBNYXR0aGV3IEZvcnR1bmUgd3JvdGU6DQo+ID4+Pj4+IEhpIERhbmllbCwNCj4gPj4+Pj4N
Cj4gPj4+Pj4gVGhlIHNwZWMgZm9yIE1JUFMgVW5pZmllZCBIb3N0aW5nIEludGVyZmFjZSBpcyBh
dmFpbGFibGUgaGVyZToNCj4gPj4+Pj4NCj4gPj4+Pj4gaHR0cDovL3BycGxmb3VuZGF0aW9uLm9y
Zy93aWtpL01JUFNfZG9jdW1lbnRhdGlvbg0KPiA+Pj4+Pg0KPiA+Pj4+PiBBcyB3ZSBoYXZlIHBy
ZXZpb3VzbHkgZGlzY3Vzc2VkLCB0aGlzIGlzIGFuIGlkZWFsIHBsYWNlIHRvIGRlZmluZQ0KPiA+
Pj4+PiB0aGUgaGFuZG92ZXIgb2YgZGV2aWNlIHRyZWUgZGF0YSBmcm9tIGJvb3Rsb2FkZXIgdG8g
a2VybmVsLiBVc2luZw0KPiA+Pj4+PiBhMCA9PSAtMiBhbmQgZGVmaW5pbmcgd2hpY2ggcmVnaXN0
ZXIocykgeW91IG5lZWQgZm9yIHRoZSBhY3R1YWwNCj4gPj4+Pj4gZGF0YSB3aWxsIGZpdCBuaWNl
bHkuIEknbGwgaGFwcGlseSBpbmNsdWRlIHdoYXRldmVyIGlzIGRlY2lkZWQNCj4gPj4+Pj4gaW50
byB0aGUgbmV4dCB2ZXJzaW9uIG9mIHRoZSBzcGVjLg0KPiA+Pj4NCj4gPj4+IHRoaXMgb3JpZ2lu
YXRlcyBmcm9tIGFuIG9mZi1saXN0IGRpc2N1c3Npb24gc29tZSBtb250aHMgYWdvIHN0YXJ0ZWQN
Cj4gPj4+IGJ5IEpvaG4gQ3Jpc3Bpbi4NCj4gPj4+DQo+ID4+PiAoQ0MgK0pvaG4sIFJhbGYsIEpv
bmFzLCBsaW51eC1taXBzKQ0KPiA+Pj4NCj4gPj4+Pg0KPiA+Pj4+IChDQyArQW5kcmV3LCBFemVx
dWllbCwgSmFtZXMsIEphbWVzKQ0KPiA+Pj4+DQo+ID4+Pj4gT24gdGhlIHRhbGsgb2YgRFQgaGFu
ZG92ZXIsIHRoaXMgcmVjZW50IHBhdGNoc2V0IGFkZGluZyBzdXBwb3J0IGZvcg0KPiA+Pj4+IGEg
c3lzdGVtIGRvaW5nIHNvIHRvIExpbnV4IGlzIHJlbGV2YW50Og0KPiA+Pj4+DQo+ID4+Pj4NCj4g
Pj4+PiBodHRwOi8vd3d3LmxpbnV4LW1pcHMub3JnL2FyY2hpdmVzL2xpbnV4LW1pcHMvMjAxNS0w
Mi9tc2cwMDMxMi5odG1sDQo+ID4+Pj4NCj4gPj4+PiBJJ20gYWxzbyB3b3JraW5nIG9uIGEgc3lz
dGVtIGZvciB3aGljaCBJJ2xsIG5lZWQgdG8gaW1wbGVtZW50IERUDQo+ID4+Pj4gaGFuZG92ZXIg
dmVyeSBzb29uLiBJdCB3b3VsZCBiZSB2ZXJ5IG5pY2UgaWYgd2UgY291bGQgYWdyZWUgb24gc29t
ZQ0KPiA+Pj4+IHN0YW5kYXJkIHdheSBvZiBkb2luZyBzbyAoYW5kIGV2ZW50dWFsbHkgaWYgdGhl
IGNvZGUgb24gdGhlIExpbnV4DQo+ID4+Pj4gc2lkZSBjYW4gYmUgZ2VuZXJpYyBlbm91Z2ggdG8g
YWxsb3cgYSBtdWx0aXBsYXRmb3JtIGtlcm5lbCkuDQo+ID4+DQo+ID4+ICsxLiAgSSB3b3VsZCBs
aWtlIHRvIHNlZSB0aGlzIGhhcHBlbiBhcyB3ZWxsLg0KPiA+Pg0KPiA+Pj4gdG8gYmUgY29uZm9y
bWFudCB3aXRoIFVISSBJIHByb3Bvc2UgJGEwID09IC0yIGFuZCAkYTEgPT0gYWRkcmVzcyBvZg0K
PiA+Pj4gRFQgYmxvYi4gSXQgaXMgYSBzaW1wbGUgZXh0ZW5zaW9uIGFuZCBzaG91bGQgbm90IGlu
dGVyZmVyZSB3aXRoIHRoZQ0KPiA+Pj4gdmFyaW91cyBsZWdhY3kgYm9vdCBpbnRlcmZhY2VzLg0K
PiA+Pj4NCj4gPj4+IFUtQm9vdCBtYWlubGluZSBjb2RlIGlzIGFsbW9zdCByZWFkeSBmb3IgRFQg
aGFuZG92ZXIuIEkgaGF2ZQ0KPiA+Pj4gcHJlcGFyZWQgYSBwYXRjaCBbMV0gd2hpY2ggY29tcGxl
dGVzIGl0IGJ5IGltcGxlbWVudGluZyBteSBwcm9wb3NhbC4NCj4gPj4NCj4gPj4gSG1tLi4uIHdl
IGRlY2lkZWQgdG8gZm9sbG93IHRoZSBBUk0gY29udmVudGlvbiBoZXJlICgkYTAgPSAwLCAkYTEg
PQ0KPiA+PiAtMSwgJGEyID0gcGh5c2ljYWwgYWRkcmVzcyBvZiBEVEIpLCB3aGljaCBpcyBhbHNv
IHdoYXQgdGhlIEJNSVBTDQo+ID4+IHBsYXRmb3JtIChzdWJtaXR0ZWQgYnkgS2V2aW4pIGlzIHVz
aW5nIGZvciBEVCBoYW5kb3Zlci4gIElzIHRoZXJlDQo+ID4+IGFscmVhZHkgYSBwbGF0Zm9ybSB1
c2luZyB0aGUgcHJvdG9jb2wgeW91IGRlc2NyaWJlZD8NCj4gPg0KPiA+IG5vLCBidXQgd2l0aCBp
dHMgcHVibGljYXRpb24gdGhlIE1JUFMgVUhJIHNwZWMgaXMga2luZCBvZiBvZmZpY2lhbC4NCj4g
PiBBRkFJSyBwYXRjaGVzIHRvIHN1cHBvcnQgVUhJIGluIGdjYywgZ2RiLCBVLUJvb3QgZXRjLiBh
cmUgYWxyZWFkeQ0KPiA+IHN1Ym1pdHRlZCBvciBwcmVwYXJlZC4gTWF0dGhldyBzdWdnZXN0ZWQg
dGhhdCBuZXcgYm9vdCBwcm90b2NvbHMNCj4gPiBzaG91bGQgYmUgY29tcGxpYW50IHdpdGggVUhJ
LiBJIHRoaW5rIHRoZSBBUk0gY29udmVudGlvbiBkb2VzIG5vdCBmaXQNCj4gPiB0byBVSEkuDQo+
IA0KPiBPaywgSSB0aGluayB3ZSBjYW4gY2hhbmdlIHRoZSBib290IHByb3RvY29sIG9uIFBpc3Rh
Y2hpbyB0byBtYXRjaCBVSEkNCj4gdGhlbi4NCg0KSWYgdGhhdCBpcyBwb3NzaWJsZSB0aGVuIGl0
IHdvdWxkIGJlIGdvb2QuIFRoZSBVSEkgc3BlYyBpcyBpbnRlbmRlZCB0bw0KaW52b2x2ZSB0aGUg
dmFyaW91cyBjb21tdW5pdGllcyBpbiBmdXJ0aGVyIGNoYW5nZXMgYnV0IHRoZSBpbml0aWFsIHZl
cnNpb24NCmhhZCB0byBtYWtlIHNvbWUgdHJhZGVvZmZzIGFuZCBkZWZpbmUgc29tZSBydWxlcy4N
Cg0KRldJVyBJIHdhcyB0cnlpbmcgdG8ga2VlcCB0aGUgb3ZlcmFsbCBjb250cm9sIG9mIHRoZSBo
YW5kb3ZlciBwcm90b2NvbA0KdWx0cmEgc2ltcGxlIGJ5IGhhdmluZyBhMCBkaWN0YXRlIHRoZSBt
ZWFuaW5nIG9mIGFsbCBvdGhlciByZWdpc3RlcnMuDQpUaGUgQVJNIHByb3RvY29sIGhhcyBlbmRl
ZCB1cCB3aXRoIHR3byByZWdpc3RlcnMgdG8gaW5kaWNhdGUgRFRCIGhhbmRvdmVyDQptYWtpbmcg
dGhlIGEwPT0wIGNhc2UgaGF2ZSBzdWItY2F0ZWdvcmllcy4NCg0KTGV0IG1lIGtub3cgaWYgdGhp
cyBkb2Vzbid0IGVuZCB1cCBwb3NzaWJsZSBhbmQgd2UgY2FuIGZpZ3VyZSBvdXQgaG93IHRvDQpj
b3BlIHdpdGggdGhhdCBpbiB0aGUgc3BlYy4NCg0KdGhhbmtzLA0KTWF0dGhldw0K
