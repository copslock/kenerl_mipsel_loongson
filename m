Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Mar 2015 02:26:57 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44917 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007628AbbCCB04YKa5n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Mar 2015 02:26:56 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 5DB92E50C1B65;
        Tue,  3 Mar 2015 01:26:49 +0000 (GMT)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 3 Mar
 2015 01:26:50 +0000
Received: from hhmail02.hh.imgtec.org ([::1]) by hhmail02.hh.imgtec.org
 ([::1]) with mapi id 14.03.0224.002; Tue, 3 Mar 2015 01:26:49 +0000
From:   James Hartley <James.Hartley@imgtec.com>
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
CC:     Paul Burton <Paul.Burton@imgtec.com>,
        "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
        Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>,
        "James Hogan" <James.Hogan@imgtec.com>,
        John Crispin <blogic@openwrt.org>,
        "Jonas Gorski" <jogo@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "cernekee@chromium.org" <cernekee@chromium.org>
Subject: RE: [U-Boot] MIPS UHI spec
Thread-Topic: [U-Boot] MIPS UHI spec
Thread-Index: AQHQUa119ysqxxJyD06mCHQ+M9FcFZ0C3psAgABgwICAARIWgIAAcN8AgAA3GQCABQHiwA==
Date:   Tue, 3 Mar 2015 01:26:49 +0000
Message-ID: <72BC0C8BD7BB6F45988A99382E5FBAE544458723@hhmail02.hh.imgtec.org>
References: <6D39441BF12EF246A7ABCE6654B0235320FDC2AC@LEMAIL01.le.imgtec.org>
        <20150226101739.GY17695@NP-P-BURTON>
        <CACUy__Ux6v9O0RmSiUr6vDDJ8JSDPCsCTqm=KOiNM0M=x3hoQQ@mail.gmail.com>
        <CAL1qeaGT9DGnVN4Lg0McCESxuwphLFuoo1m96H5nauRcyF24xg@mail.gmail.com>
        <CACUy__UdCSMW4cLDKMvu3CLBeaKpSbJ19zCMP29hwT+T_y7q4g@mail.gmail.com>
 <CAL1qeaGsNZE0arPSpQykDoxDiwFpSuLQopvqts4MsQ6BT3VeEw@mail.gmail.com>
 <6D39441BF12EF246A7ABCE6654B0235320FE3C49@LEMAIL01.le.imgtec.org>
In-Reply-To: <6D39441BF12EF246A7ABCE6654B0235320FE3C49@LEMAIL01.le.imgtec.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.167.65]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <James.Hartley@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46088
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Hartley@imgtec.com
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

SGkgTWF0dGhldywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXR0
aGV3IEZvcnR1bmUNCj4gU2VudDogMjcgRmVicnVhcnkgMjAxNSAyMDo0Ng0KPiBUbzogQW5kcmV3
IEJyZXN0aWNrZXI7IERhbmllbCBTY2h3aWVyemVjaw0KPiBDYzogUGF1bCBCdXJ0b247IHUtYm9v
dEBsaXN0cy5kZW54LmRlOyBFemVxdWllbCBHYXJjaWE7IEphbWVzIEhhcnRsZXk7DQo+IEphbWVz
IEhvZ2FuOyBKb2huIENyaXNwaW47IEpvbmFzIEdvcnNraTsgUmFsZiBCYWVjaGxlOyBMaW51eC1N
SVBTOw0KPiBjZXJuZWtlZUBjaHJvbWl1bS5vcmcNCj4gU3ViamVjdDogUkU6IFtVLUJvb3RdIE1J
UFMgVUhJIHNwZWMNCj4gDQo+IEFuZHJldyBCcmVzdGlja2VyIDxhYnJlc3RpY0BjaHJvbWl1bS5v
cmc+IHdyaXRlczoNCj4gPiBPbiBGcmksIEZlYiAyNywgMjAxNSBhdCAyOjQ0IEFNLCBEYW5pZWwg
U2Nod2llcnplY2sNCj4gPiA8ZGFuaWVsLnNjaHdpZXJ6ZWNrQGdtYWlsLmNvbT4gd3JvdGU6DQo+
ID4gPiAyMDE1LTAyLTI2IDE5OjIzIEdNVCswMTowMCBBbmRyZXcgQnJlc3RpY2tlcg0KPiA8YWJy
ZXN0aWNAY2hyb21pdW0ub3JnPjoNCj4gPiA+PiBIaSwNCj4gPiA+Pg0KPiA+ID4+IE9uIFRodSwg
RmViIDI2LCAyMDE1IGF0IDQ6MzcgQU0sIERhbmllbCBTY2h3aWVyemVjaw0KPiA+ID4+IDxkYW5p
ZWwuc2Nod2llcnplY2tAZ21haWwuY29tPiB3cm90ZToNCj4gPiA+Pj4gMjAxNS0wMi0yNiAxMTox
NyBHTVQrMDE6MDAgUGF1bCBCdXJ0b24gPHBhdWwuYnVydG9uQGltZ3RlYy5jb20+Og0KPiA+ID4+
Pj4gT24gVGh1LCBGZWIgMTksIDIwMTUgYXQgMDE6NTA6MjNQTSArMDAwMCwgTWF0dGhldyBGb3J0
dW5lIHdyb3RlOg0KPiA+ID4+Pj4+IEhpIERhbmllbCwNCj4gPiA+Pj4+Pg0KPiA+ID4+Pj4+IFRo
ZSBzcGVjIGZvciBNSVBTIFVuaWZpZWQgSG9zdGluZyBJbnRlcmZhY2UgaXMgYXZhaWxhYmxlIGhl
cmU6DQo+ID4gPj4+Pj4NCj4gPiA+Pj4+PiBodHRwOi8vcHJwbGZvdW5kYXRpb24ub3JnL3dpa2kv
TUlQU19kb2N1bWVudGF0aW9uDQo+ID4gPj4+Pj4NCj4gPiA+Pj4+PiBBcyB3ZSBoYXZlIHByZXZp
b3VzbHkgZGlzY3Vzc2VkLCB0aGlzIGlzIGFuIGlkZWFsIHBsYWNlIHRvDQo+ID4gPj4+Pj4gZGVm
aW5lIHRoZSBoYW5kb3ZlciBvZiBkZXZpY2UgdHJlZSBkYXRhIGZyb20gYm9vdGxvYWRlciB0bw0K
PiA+ID4+Pj4+IGtlcm5lbC4gVXNpbmcNCj4gPiA+Pj4+PiBhMCA9PSAtMiBhbmQgZGVmaW5pbmcg
d2hpY2ggcmVnaXN0ZXIocykgeW91IG5lZWQgZm9yIHRoZSBhY3R1YWwNCj4gPiA+Pj4+PiBkYXRh
IHdpbGwgZml0IG5pY2VseS4gSSdsbCBoYXBwaWx5IGluY2x1ZGUgd2hhdGV2ZXIgaXMgZGVjaWRl
ZA0KPiA+ID4+Pj4+IGludG8gdGhlIG5leHQgdmVyc2lvbiBvZiB0aGUgc3BlYy4NCj4gPiA+Pj4N
Cj4gPiA+Pj4gdGhpcyBvcmlnaW5hdGVzIGZyb20gYW4gb2ZmLWxpc3QgZGlzY3Vzc2lvbiBzb21l
IG1vbnRocyBhZ28NCj4gPiA+Pj4gc3RhcnRlZCBieSBKb2huIENyaXNwaW4uDQo+ID4gPj4+DQo+
ID4gPj4+IChDQyArSm9obiwgUmFsZiwgSm9uYXMsIGxpbnV4LW1pcHMpDQo+ID4gPj4+DQo+ID4g
Pj4+Pg0KPiA+ID4+Pj4gKENDICtBbmRyZXcsIEV6ZXF1aWVsLCBKYW1lcywgSmFtZXMpDQo+ID4g
Pj4+Pg0KPiA+ID4+Pj4gT24gdGhlIHRhbGsgb2YgRFQgaGFuZG92ZXIsIHRoaXMgcmVjZW50IHBh
dGNoc2V0IGFkZGluZyBzdXBwb3J0DQo+ID4gPj4+PiBmb3IgYSBzeXN0ZW0gZG9pbmcgc28gdG8g
TGludXggaXMgcmVsZXZhbnQ6DQo+ID4gPj4+Pg0KPiA+ID4+Pj4NCj4gPiA+Pj4+IGh0dHA6Ly93
d3cubGludXgtbWlwcy5vcmcvYXJjaGl2ZXMvbGludXgtbWlwcy8yMDE1LQ0KPiAwMi9tc2cwMDMx
Mi5odA0KPiA+ID4+Pj4gbWwNCj4gPiA+Pj4+DQo+ID4gPj4+PiBJJ20gYWxzbyB3b3JraW5nIG9u
IGEgc3lzdGVtIGZvciB3aGljaCBJJ2xsIG5lZWQgdG8gaW1wbGVtZW50IERUDQo+ID4gPj4+PiBo
YW5kb3ZlciB2ZXJ5IHNvb24uIEl0IHdvdWxkIGJlIHZlcnkgbmljZSBpZiB3ZSBjb3VsZCBhZ3Jl
ZSBvbg0KPiA+ID4+Pj4gc29tZSBzdGFuZGFyZCB3YXkgb2YgZG9pbmcgc28gKGFuZCBldmVudHVh
bGx5IGlmIHRoZSBjb2RlIG9uIHRoZQ0KPiA+ID4+Pj4gTGludXggc2lkZSBjYW4gYmUgZ2VuZXJp
YyBlbm91Z2ggdG8gYWxsb3cgYSBtdWx0aXBsYXRmb3JtIGtlcm5lbCkuDQo+ID4gPj4NCj4gPiA+
PiArMS4gIEkgd291bGQgbGlrZSB0byBzZWUgdGhpcyBoYXBwZW4gYXMgd2VsbC4NCj4gPiA+Pg0K
PiA+ID4+PiB0byBiZSBjb25mb3JtYW50IHdpdGggVUhJIEkgcHJvcG9zZSAkYTAgPT0gLTIgYW5k
ICRhMSA9PSBhZGRyZXNzDQo+ID4gPj4+IG9mIERUIGJsb2IuIEl0IGlzIGEgc2ltcGxlIGV4dGVu
c2lvbiBhbmQgc2hvdWxkIG5vdCBpbnRlcmZlcmUgd2l0aA0KPiA+ID4+PiB0aGUgdmFyaW91cyBs
ZWdhY3kgYm9vdCBpbnRlcmZhY2VzLg0KPiA+ID4+Pg0KPiA+ID4+PiBVLUJvb3QgbWFpbmxpbmUg
Y29kZSBpcyBhbG1vc3QgcmVhZHkgZm9yIERUIGhhbmRvdmVyLiBJIGhhdmUNCj4gPiA+Pj4gcHJl
cGFyZWQgYSBwYXRjaCBbMV0gd2hpY2ggY29tcGxldGVzIGl0IGJ5IGltcGxlbWVudGluZyBteSBw
cm9wb3NhbC4NCj4gPiA+Pg0KPiA+ID4+IEhtbS4uLiB3ZSBkZWNpZGVkIHRvIGZvbGxvdyB0aGUg
QVJNIGNvbnZlbnRpb24gaGVyZSAoJGEwID0gMCwgJGExID0NCj4gPiA+PiAtMSwgJGEyID0gcGh5
c2ljYWwgYWRkcmVzcyBvZiBEVEIpLCB3aGljaCBpcyBhbHNvIHdoYXQgdGhlIEJNSVBTDQo+ID4g
Pj4gcGxhdGZvcm0gKHN1Ym1pdHRlZCBieSBLZXZpbikgaXMgdXNpbmcgZm9yIERUIGhhbmRvdmVy
LiAgSXMgdGhlcmUNCj4gPiA+PiBhbHJlYWR5IGEgcGxhdGZvcm0gdXNpbmcgdGhlIHByb3RvY29s
IHlvdSBkZXNjcmliZWQ/DQo+ID4gPg0KPiA+ID4gbm8sIGJ1dCB3aXRoIGl0cyBwdWJsaWNhdGlv
biB0aGUgTUlQUyBVSEkgc3BlYyBpcyBraW5kIG9mIG9mZmljaWFsLg0KPiA+ID4gQUZBSUsgcGF0
Y2hlcyB0byBzdXBwb3J0IFVISSBpbiBnY2MsIGdkYiwgVS1Cb290IGV0Yy4gYXJlIGFscmVhZHkN
Cj4gPiA+IHN1Ym1pdHRlZCBvciBwcmVwYXJlZC4gTWF0dGhldyBzdWdnZXN0ZWQgdGhhdCBuZXcg
Ym9vdCBwcm90b2NvbHMNCj4gPiA+IHNob3VsZCBiZSBjb21wbGlhbnQgd2l0aCBVSEkuIEkgdGhp
bmsgdGhlIEFSTSBjb252ZW50aW9uIGRvZXMgbm90DQo+ID4gPiBmaXQgdG8gVUhJLg0KPiA+DQo+
ID4gT2ssIEkgdGhpbmsgd2UgY2FuIGNoYW5nZSB0aGUgYm9vdCBwcm90b2NvbCBvbiBQaXN0YWNo
aW8gdG8gbWF0Y2ggVUhJDQo+ID4gdGhlbi4NCj4gDQo+IElmIHRoYXQgaXMgcG9zc2libGUgdGhl
biBpdCB3b3VsZCBiZSBnb29kLiBUaGUgVUhJIHNwZWMgaXMgaW50ZW5kZWQgdG8gaW52b2x2ZQ0K
PiB0aGUgdmFyaW91cyBjb21tdW5pdGllcyBpbiBmdXJ0aGVyIGNoYW5nZXMgYnV0IHRoZSBpbml0
aWFsIHZlcnNpb24gaGFkIHRvDQo+IG1ha2Ugc29tZSB0cmFkZW9mZnMgYW5kIGRlZmluZSBzb21l
IHJ1bGVzLg0KPiANCj4gRldJVyBJIHdhcyB0cnlpbmcgdG8ga2VlcCB0aGUgb3ZlcmFsbCBjb250
cm9sIG9mIHRoZSBoYW5kb3ZlciBwcm90b2NvbCB1bHRyYQ0KPiBzaW1wbGUgYnkgaGF2aW5nIGEw
IGRpY3RhdGUgdGhlIG1lYW5pbmcgb2YgYWxsIG90aGVyIHJlZ2lzdGVycy4NCj4gVGhlIEFSTSBw
cm90b2NvbCBoYXMgZW5kZWQgdXAgd2l0aCB0d28gcmVnaXN0ZXJzIHRvIGluZGljYXRlIERUQiBo
YW5kb3Zlcg0KPiBtYWtpbmcgdGhlIGEwPT0wIGNhc2UgaGF2ZSBzdWItY2F0ZWdvcmllcy4NCj4g
DQo+IExldCBtZSBrbm93IGlmIHRoaXMgZG9lc24ndCBlbmQgdXAgcG9zc2libGUgYW5kIHdlIGNh
biBmaWd1cmUgb3V0IGhvdyB0bw0KPiBjb3BlIHdpdGggdGhhdCBpbiB0aGUgc3BlYy4NCg0KRllJ
OiBXZSd2ZSB1cGRhdGVkIFBpc3RhY2hpbyB0byB1c2U6ICRhMCA9PSAtMiBhbmQgJGExID09IGFk
ZHJlc3Mgb2YgRFQgYmxvYi4NClRoaXMgd2lsbCBmaWx0ZXIgdXAgaW50byBhIFYyIG9mIHRoZSBw
YXRjaGVzIHN1Ym1pdHRlZCB1cHN0cmVhbS4NCg0KVGhhbmtzLA0KSmFtZXMuDQoNCg==
