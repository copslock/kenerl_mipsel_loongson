Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Aug 2016 12:31:13 +0200 (CEST)
Received: from mail7.hitachi.co.jp ([133.145.228.42]:39533 "EHLO
        mail7.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992970AbcHPKbGmbY-a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Aug 2016 12:31:06 +0200
Received: from mlsw3.hitachi.co.jp (unknown [133.144.234.166])
        by mail7.hitachi.co.jp (Postfix) with ESMTP id 29DF4B1D384;
        Tue, 16 Aug 2016 19:31:03 +0900 (JST)
Received: from mfilter5.hitachi.co.jp by mlsw3.hitachi.co.jp (8.13.8/8.13.8) id u7GAV3D2021477; Tue, 16 Aug 2016 19:31:03 +0900
Received: from vshuts01.hitachi.co.jp (vshuts01.hitachi.co.jp [10.201.6.83])
        by mfilter5.hitachi.co.jp (Switch-3.3.4/Switch-3.3.4) with ESMTP id u7GAV1rM011972;
        Tue, 16 Aug 2016 19:31:02 +0900
Received: from GSJPTKYDCEHCS07.service.hitachi.net (unknown [158.212.188.155])
        by vshuts01.hitachi.co.jp (Postfix) with ESMTP id 2C36EF2039;
        Tue, 16 Aug 2016 19:31:01 +0900 (JST)
Received: from GSJPTKYDCEMBX31.service.hitachi.net ([169.254.4.162]) by
 GSJPTKYDCEHCS07.service.hitachi.net ([158.212.188.155]) with mapi id
 14.03.0224.002; Tue, 16 Aug 2016 19:31:00 +0900
From:   =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?= 
        <hidehiro.kawai.ez@hitachi.com>
To:     "'Corey Minyard'" <cminyard@mvista.com>,
        Dave Young <dyoung@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Baoquan He <bhe@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "x86@kernel.org" <x86@kernel.org>,
        David Daney <david.daney@cavium.com>,
        Xunlei Pang <xpang@redhat.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven J. Hill" <steven.hill@cavium.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "Daniel Walker" <dwalker@fifo99.com>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: RE: [V4 PATCH 2/2] mips/panic: Replace smp_send_stop() with kdump
 friendly version in panic path
Thread-Topic: [V4 PATCH 2/2] mips/panic: Replace smp_send_stop() with kdump
 friendly version in panic path
Thread-Index: AQHR9xdtXooY9pkaKUW/+B93XDgWJKBJuQ0AgAGiycA=
Date:   Tue, 16 Aug 2016 10:29:54 +0000
Deferred-Delivery: Tue, 16 Aug 2016 10:31:00 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A84454CC234F@GSjpTKYDCembx31.service.hitachi.net>
References: <20160810080946.11028.97686.stgit@sysi4-13.yrl.intra.hitachi.co.jp>
 <20160810080950.11028.28000.stgit@sysi4-13.yrl.intra.hitachi.co.jp>
 <20160812031755.GB2983@dhcp-128-65.nay.redhat.com>
 <57ADD55D.1050003@mvista.com>
 <04EAB7311EE43145B2D3536183D1A84454CBBB00@GSjpTKYDCembx31.service.hitachi.net>
 <a618ef9b-25d5-da8b-6829-ce124b76033e@mvista.com>
 <95d06858-6874-d795-dca5-ec33bf33d5da@mvista.com>
In-Reply-To: <95d06858-6874-d795-dca5-ec33bf33d5da@mvista.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.198.219.50]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Return-Path: <hidehiro.kawai.ez@hitachi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hidehiro.kawai.ez@hitachi.com
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

PiBGcm9tOiBDb3JleSBNaW55YXJkIFttYWlsdG86Y21pbnlhcmRAbXZpc3RhLmNvbV0NCj4gU2Vu
dDogVHVlc2RheSwgQXVndXN0IDE2LCAyMDE2IDM6MDIgQU0NCj4gT24gMDgvMTUvMjAxNiAxMjow
NiBQTSwgQ29yZXkgTWlueWFyZCB3cm90ZToNCj4gPiBPbiAwOC8xNS8yMDE2IDA2OjM1IEFNLCDm
srPlkIjoi7Hlro8gLyBLQVdBSe+8jEhJREVISVJPIHdyb3RlOg0KPiA+PiBIaSBDb3JleSwNCj4g
Pj4NCj4gPj4+IEZyb206IENvcmV5IE1pbnlhcmQgW21haWx0bzpjbWlueWFyZEBtdmlzdGEuY29t
XQ0KPiA+Pj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMTIsIDIwMTYgMTA6NTYgUE0NCj4gPj4+IEkn
bGwgdHJ5IHRvIHRlc3QgdGhpcywgYnV0IEkgaGF2ZSBvbmUgY29tbWVudCBpbmxpbmUuLi4NCj4g
Pj4gVGhhbmsgeW91IHZlcnkgbXVjaCENCj4gPj4NCj4gPj4+IE9uIDA4LzExLzIwMTYgMTA6MTcg
UE0sIERhdmUgWW91bmcgd3JvdGU6DQo+ID4+Pj4gT24gMDgvMTAvMTYgYXQgMDU6MDlwbSwgSGlk
ZWhpcm8gS2F3YWkgd3JvdGU6DQo+ID4+IFtzbmlwXQ0KPiA+Pj4+PiBkaWZmIC0tZ2l0IGEvYXJj
aC9taXBzL2tlcm5lbC9jcmFzaC5jIGIvYXJjaC9taXBzL2tlcm5lbC9jcmFzaC5jDQo+ID4+Pj4+
IGluZGV4IDYxMGYwZjMuLjE3MjNiMTcgMTAwNjQ0DQo+ID4+Pj4+IC0tLSBhL2FyY2gvbWlwcy9r
ZXJuZWwvY3Jhc2guYw0KPiA+Pj4+PiArKysgYi9hcmNoL21pcHMva2VybmVsL2NyYXNoLmMNCj4g
Pj4+Pj4gQEAgLTQ3LDkgKzQ3LDE0IEBAIHN0YXRpYyB2b2lkIGNyYXNoX3NodXRkb3duX3NlY29u
ZGFyeSh2b2lkDQo+ID4+Pj4+ICpwYXNzZWRfcmVncykNCj4gPj4+Pj4NCj4gPj4+Pj4gICAgc3Rh
dGljIHZvaWQgY3Jhc2hfa2V4ZWNfcHJlcGFyZV9jcHVzKHZvaWQpDQo+ID4+Pj4+ICAgIHsNCj4g
Pj4+Pj4gKyAgICBzdGF0aWMgaW50IGNwdXNfc3RvcHBlZDsNCj4gPj4+Pj4gICAgICAgIHVuc2ln
bmVkIGludCBtc2VjczsNCj4gPj4+Pj4gKyAgICB1bnNpZ25lZCBpbnQgbmNwdXM7DQo+ID4+Pj4+
DQo+ID4+Pj4+IC0gICAgdW5zaWduZWQgaW50IG5jcHVzID0gbnVtX29ubGluZV9jcHVzKCkgLSAx
Oy8qIEV4Y2x1ZGluZyB0aGUNCj4gPj4+Pj4gcGFuaWMgY3B1ICovDQo+ID4+Pj4+ICsgICAgaWYg
KGNwdXNfc3RvcHBlZCkNCj4gPj4+Pj4gKyAgICAgICAgcmV0dXJuOw0KPiA+Pj4gV291bGRuJ3Qg
eW91IHdhbnQgYW4gYXRvbWljIG9wZXJhdGlvbiBhbmQgc29tZSBzcGVjaWFsIGhhbmRsaW5nIGhl
cmUgdG8NCj4gPj4+IGVuc3VyZSB0aGF0IG9ubHkgb25lIENQVSBkb2VzIHRoaXM/ICBTbyBpZiBh
IENQVSBjb21lcyBpbiBoZXJlIGFuZA0KPiA+Pj4gYW5vdGhlciBDUFUgaXMgYWxyZWFkeSBpbiB0
aGUgcHJvY2VzcyBzdG9wcGluZyB0aGUgQ1BVcyBpdCB3b24ndA0KPiA+Pj4gcmVzdWx0IGluIGEN
Cj4gPj4+IGRlYWRsb2NrLg0KPiA+PiBCZWNhdXNlIHRoaXMgZnVuY3Rpb24gY2FuIGJlIGNhbGxl
ZCBvbmx5IG9uZSBwYW5pY2tpbmcgQ1BVLA0KPiA+PiB0aGVyZSBpcyBubyBwcm9ibGVtLg0KPiA+
Pg0KPiA+PiBUaGVyZSBhcmUgdHdvIHBhdGhzIHdoaWNoIGNyYXNoX2tleGVjX3ByZXBhcmVfY3B1
cyBpcyBjYWxsZWQuDQo+ID4+DQo+ID4+IFBhdGggMSAocGFuaWMgcGF0aCk6DQo+ID4+IHBhbmlj
KCkNCj4gPj4gICAgY3Jhc2hfc21wX3NlbmRfc3RvcCgpDQo+ID4+ICAgICAgY3Jhc2hfa2V4ZWNf
cHJlcGFyZV9jcHVzKCkNCj4gPj4NCj4gPj4gUGF0aCAyIChvb3BzIHBhdGgpOg0KPiA+PiBjcmFz
aF9rZXhlYygpDQo+ID4+ICAgIF9fY3Jhc2hfa2V4ZWMoKQ0KPiA+PiAgICAgIG1hY2hpbmVfY3Jh
c2hfc2h1dGRvd24oKQ0KPiA+PiAgICAgICAgZGVmYXVsdF9tYWNoaW5lX2NyYXNoX3NodXRkb3du
KCkgLy8gZm9yIE1JUFMNCj4gPj4gICAgICAgICAgY3Jhc2hfa2V4ZWNfcHJlcGFyZV9jcHVzKCkN
Cj4gPj4NCj4gPj4gSGVyZSwgcGFuaWMoKSBhbmQgY3Jhc2hfa2V4ZWMoKSBydW4gZXhjbHVzaXZl
bHkgdmlhDQo+ID4+IHBhbmljX2NwdSBhdG9taWMgdmFyaWFibGUuICBTbyB3ZSBjYW4gdXNlIGNw
dXNfc3RvcHBlZCBhcw0KPiA+PiBub3JtYWwgdmFyaWFibGUuDQo+ID4NCj4gPiBPaywgaWYgdGhl
IGNvZGUgY2FuIG9ubHkgYmUgZW50ZXJlZCBvbmNlLCB3aGF0J3MgdGhlIHB1cnBvc2Ugb2YNCj4g
PiBjcHVzX3N0b3BwZWQ/DQo+ID4gSSBndWVzcyB0aGF0J3Mgd2hhdCBjb25mdXNlZCBtZS4gIFlv
dSBhcmUgcmlnaHQsIHRoZSBwYW5pY19jcHUgYXRvbWljDQo+ID4gc2hvdWxkDQo+ID4ga2VlcCB0
aGlzIG9uIGEgc2luZ2xlIENQVS4NCj4gDQo+IE5ldmVyIG1pbmQsIEkgc2VlIHRoZSBwYXRoIHRo
cm91Z2ggcGFuaWMoKSB3aGVyZSB0aGF0IGlzIHJlcXVpcmVkLiBNeQ0KPiBxdWVzdGlvbg0KPiBi
ZWxvdyBzdGlsbCByZW1haW5zLCB0aG91Z2guDQo+IA0KPiA+IEFsc28sIHBhbmljKCkgd2lsbCBj
YWxsIHBhbmljX3NtcF9zZWxmX3N0b3AoKSBpZiBpdCBmaW5kcyBhbm90aGVyIENQVQ0KPiA+IGhh
cyBhbHJlYWR5DQo+ID4gY2FsbGVkIHBhbmljLCB3aGljaCB3aWxsIGp1c3Qgc3BpbiB3aXRoIGlu
dGVycnVwdHMgb2ZmIGJ5IGRlZmF1bHQuIEkNCj4gPiBkaWRuJ3Qgc2VlIGENCj4gPiBkZWZpbml0
aW9uIGZvciBpdCBpbiBNSVBTLCB3b3VsZG4ndCBpdCBuZWVkIHRvIGJlIG92ZXJyaWRkZW4gdG8g
YXZvaWQNCj4gPiBhIGRlYWRsb2NrPw0KDQpObyBkZWFkbG9jayBzaG91bGQgaGFwcGVuLiBQYW5p
Y2tpbmcgQ1BVIGNhbGxzIGNyYXNoX2tleGVjX3ByZXBhcmVfY3B1cygpLA0KYW5kIGl0IGlzc3Vl
cyBhbiBJUEkgYW5kIHdhaXQgZm9yIG90aGVyIENQVXMgaGFuZGxlIGl0LiAgSWYgc29tZSBvZiB0
aGVtDQphcmUgbG9vcGluZyBpbiBwYW5pY19zbXBfc2VsZl9zdG9wKCkgd2l0aCBpbnRlcnJ1cHQg
ZGlzYWJsZWQsIHRoZXkgY2FuJ3QNCmhhbmRsZSB0aGUgSVBJLiAgQnV0IGl0J3Mgbm90IGEgc2V2
ZXJlIHByb2JsZW0uICBjcmFzaF9rZXhlY19wcmVwYXJlX2NwdXMoKQ0KaGFzIGEgdGltZW91dCBt
ZWNoYW5pc20sIGFuZCBpdCB3aWxsIGdvIG91dCBmcm9tIHRoZSB3YWl0IGxvb3Agd2hlbiBpdA0K
aGFwcGVucy4NCg0KSW4gdGhhdCBjYXNlLCBvZiBjb3Vyc2UsIHRoZWlyIHJlZ2lzdGVycyBhcmUg
bm90IHNhdmVkLiAgVGhpcyBjb3VsZCBiZQ0KaW1wcm92ZWQsIGJ1dCBJJ2QgbGlrZSB0byBlbnRy
dXN0IE1JUFMgZXhwZXJ0cyB3aXRoIHRoZSBpbXByb3ZlbWVudC4NClRoaXMgaXMgYW5vdGhlciBp
c3N1ZS4NCg0KQmVzdCByZWdhcmRzLA0KDQpIaWRlaGlybyBLYXdhaQ0KDQo=
