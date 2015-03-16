Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Mar 2015 12:53:34 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:19615 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008866AbbCPLxbaJ5er (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Mar 2015 12:53:31 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 975E348DF2E58;
        Mon, 16 Mar 2015 11:53:23 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 16 Mar 2015 11:53:26 +0000
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0210.002; Mon, 16 Mar 2015 11:53:25 +0000
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     James Hogan <James.Hogan@imgtec.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Paul Burton <Paul.Burton@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>
CC:     "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
        Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>,
        James Hartley <James.Hartley@imgtec.com>,
        John Crispin <blogic@openwrt.org>,
        Jonas Gorski <jogo@openwrt.org>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [U-Boot] MIPS UHI spec
Thread-Topic: [U-Boot] MIPS UHI spec
Thread-Index: AdBMQI537hxWUscaS6q93yLVEXyfqwFbORGAAATiDwADhMy2AAAAGKKw
Date:   Mon, 16 Mar 2015 11:53:24 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B023532100679F@LEMAIL01.le.imgtec.org>
References: <6D39441BF12EF246A7ABCE6654B0235320FDC2AC@LEMAIL01.le.imgtec.org>
        <20150226101739.GY17695@NP-P-BURTON>
 <CACUy__Ux6v9O0RmSiUr6vDDJ8JSDPCsCTqm=KOiNM0M=x3hoQQ@mail.gmail.com>
 <5506B0B2.3020606@imgtec.com>
In-Reply-To: <5506B0B2.3020606@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.152.113]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <Matthew.Fortune@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46395
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

SmFtZXMgSG9nYW4gPEphbWVzLkhvZ2FuQGltZ3RlYy5jb20+IHdyaXRlczoNCj4gT24gMjYvMDIv
MTUgMTI6MzcsIERhbmllbCBTY2h3aWVyemVjayB3cm90ZToNCj4gPiAyMDE1LTAyLTI2IDExOjE3
IEdNVCswMTowMCBQYXVsIEJ1cnRvbiA8cGF1bC5idXJ0b25AaW1ndGVjLmNvbT46DQo+ID4+IE9u
IFRodSwgRmViIDE5LCAyMDE1IGF0IDAxOjUwOjIzUE0gKzAwMDAsIE1hdHRoZXcgRm9ydHVuZSB3
cm90ZToNCj4gPj4+IEhpIERhbmllbCwNCj4gPj4+DQo+ID4+PiBUaGUgc3BlYyBmb3IgTUlQUyBV
bmlmaWVkIEhvc3RpbmcgSW50ZXJmYWNlIGlzIGF2YWlsYWJsZSBoZXJlOg0KPiA+Pj4NCj4gPj4+
IGh0dHA6Ly9wcnBsZm91bmRhdGlvbi5vcmcvd2lraS9NSVBTX2RvY3VtZW50YXRpb24NCj4gPj4+
DQo+ID4+PiBBcyB3ZSBoYXZlIHByZXZpb3VzbHkgZGlzY3Vzc2VkLCB0aGlzIGlzIGFuIGlkZWFs
IHBsYWNlIHRvIGRlZmluZQ0KPiA+Pj4gdGhlIGhhbmRvdmVyIG9mIGRldmljZSB0cmVlIGRhdGEg
ZnJvbSBib290bG9hZGVyIHRvIGtlcm5lbC4gVXNpbmcgYTANCj4gPj4+ID09IC0yIGFuZCBkZWZp
bmluZyB3aGljaCByZWdpc3RlcihzKSB5b3UgbmVlZCBmb3IgdGhlIGFjdHVhbCBkYXRhDQo+ID4+
PiB3aWxsIGZpdCBuaWNlbHkuIEknbGwgaGFwcGlseSBpbmNsdWRlIHdoYXRldmVyIGlzIGRlY2lk
ZWQgaW50byB0aGUNCj4gPj4+IG5leHQgdmVyc2lvbiBvZiB0aGUgc3BlYy4NCj4gPg0KPiA+IHRo
aXMgb3JpZ2luYXRlcyBmcm9tIGFuIG9mZi1saXN0IGRpc2N1c3Npb24gc29tZSBtb250aHMgYWdv
IHN0YXJ0ZWQgYnkNCj4gPiBKb2huIENyaXNwaW4uDQo+ID4NCj4gPiAoQ0MgK0pvaG4sIFJhbGYs
IEpvbmFzLCBsaW51eC1taXBzKQ0KPiA+DQo+ID4+DQo+ID4+IChDQyArQW5kcmV3LCBFemVxdWll
bCwgSmFtZXMsIEphbWVzKQ0KPiA+Pg0KPiA+PiBPbiB0aGUgdGFsayBvZiBEVCBoYW5kb3Zlciwg
dGhpcyByZWNlbnQgcGF0Y2hzZXQgYWRkaW5nIHN1cHBvcnQgZm9yIGENCj4gPj4gc3lzdGVtIGRv
aW5nIHNvIHRvIExpbnV4IGlzIHJlbGV2YW50Og0KPiA+Pg0KPiA+Pg0KPiA+PiBodHRwOi8vd3d3
LmxpbnV4LW1pcHMub3JnL2FyY2hpdmVzL2xpbnV4LW1pcHMvMjAxNS0wMi9tc2cwMDMxMi5odG1s
DQo+ID4+DQo+ID4+IEknbSBhbHNvIHdvcmtpbmcgb24gYSBzeXN0ZW0gZm9yIHdoaWNoIEknbGwg
bmVlZCB0byBpbXBsZW1lbnQgRFQNCj4gPj4gaGFuZG92ZXIgdmVyeSBzb29uLiBJdCB3b3VsZCBi
ZSB2ZXJ5IG5pY2UgaWYgd2UgY291bGQgYWdyZWUgb24gc29tZQ0KPiA+PiBzdGFuZGFyZCB3YXkg
b2YgZG9pbmcgc28gKGFuZCBldmVudHVhbGx5IGlmIHRoZSBjb2RlIG9uIHRoZSBMaW51eA0KPiA+
PiBzaWRlIGNhbiBiZSBnZW5lcmljIGVub3VnaCB0byBhbGxvdyBhIG11bHRpcGxhdGZvcm0ga2Vy
bmVsKS4NCj4gPj4NCj4gPg0KPiA+IHRvIGJlIGNvbmZvcm1hbnQgd2l0aCBVSEkgSSBwcm9wb3Nl
ICRhMCA9PSAtMiBhbmQgJGExID09IGFkZHJlc3Mgb2YgRFQNCj4gPiBibG9iLiBJdCBpcyBhIHNp
bXBsZSBleHRlbnNpb24gYW5kIHNob3VsZCBub3QgaW50ZXJmZXJlIHdpdGggdGhlDQo+ID4gdmFy
aW91cyBsZWdhY3kgYm9vdCBpbnRlcmZhY2VzLg0KPiANCj4gSSB3YXMganVzdCBsb29raW5nIGF0
IEFuZHJldydzIHBhdGNoOg0KPiBodHRwOi8vcGF0Y2h3b3JrLmxpbnV4LW1pcHMub3JnL3BhdGNo
Lzk1NDkvDQo+IA0KPiBIb3cgd291bGQgdGhlIG90aGVyIHJlZ2lzdGVycyAoaS5lLiAkYTIgYW5k
ICRhMykgYmUgZGVmaW5lZCBmb3IgdGhpcw0KPiBib290IGludGVyZmFjZT8gSSdtIGd1ZXNzaW5n
IGFueSBmdXR1cmUgZXh0ZW5zaW9ucyBhcmUgZW52aXNpb25lZCB0byB1c2UNCj4gYSBkaWZmZXJl
bnQgbmVnYXRpdmUgdmFsdWUgb2YgJGEwLCBpbiB3aGljaCBjYXNlIHRyZWF0aW5nIHRoZW0gYXMN
Cj4gdW51c2VkL3VuZGVmaW5lZCBpcyBmaW5lLCBidXQgcGVyaGFwcyB0aGF0IHNob3VsZCBiZSBz
cGVsdCBvdXQgaW4gdGhlDQo+IFVISSBzcGVjPw0KDQpTb3VuZHMgc2Vuc2libGUuIE1ha2luZyBp
dCBleHBsaWNpdCBtYXkgaGVscCBwcmV2ZW50IGFueW9uZSBleHRlbmRpbmcgdGhpcw0KYW5kIHBy
ZXN1bWluZyB0aGF0IHRoZXkgY2FuIGdpdmUgbWVhbmluZyB0byBvbmUgb2YgdGhlIHVudXNlZCBy
ZWdpc3RlcnMuDQoNCkRpZCBhbnlvbmUgY29tZSB0byBhIGNvbmNsdXNpb24gb24gcGh5c2ljYWwg
dnMgdmlydHVhbCBhZGRyZXNzIGZvciB0aGUNCkRUQj8gSSBmb3Jnb3QgdG8gcmVwbHkgdG8gdGhl
IHRocmVhZCwgSSB3b3VsZCBoYXZlIHRob3VnaHQgdGhlIEtTRUcwDQphZGRyZXNzIHdvdWxkIGJl
IHRoZSBvYnZpb3VzIGNob2ljZSBzbyB0aGF0IGl0IGlzIGltbWVkaWF0ZWx5IHVzYWJsZSBmcm9t
DQpvcmRpbmFyeSBtZW1vcnkgYWNjZXNzZXMuIEhvd2V2ZXIsIHRoYXQgaXMgb25seSBiZWNhdXNl
IEkgZG9uJ3QgZm9sbG93IGhvdw0KdGhlIGtlcm5lbCB3b3VsZCBiZW5lZml0IGZyb20gYmVpbmcg
Z2l2ZW4gYSBwaHlzaWNhbCBhZGRyZXNzLiBJdCBjYW4ndCBiZQ0KcmVtYXBwZWQgZXhjZXB0IGZv
ciB0aGUgY2FzZSBvZiBzZWdtZW50YXRpb24gY29udHJvbCAoSSBiZWxpZXZlKSBzbyB0aGVyZQ0K
c2VlbXMgbGl0dGxlIHJpc2sgaW4gdXNpbmcgS1NFRzAuDQoNClRoYW5rcywNCk1hdHRoZXcNCg0K
