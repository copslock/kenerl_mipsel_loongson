Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Aug 2016 13:37:12 +0200 (CEST)
Received: from mail7.hitachi.co.jp ([133.145.228.42]:57792 "EHLO
        mail7.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992364AbcHOLhFhfpTq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Aug 2016 13:37:05 +0200
Received: from mlsw3.hitachi.co.jp (unknown [133.144.234.166])
        by mail7.hitachi.co.jp (Postfix) with ESMTP id EC33EB1D385;
        Mon, 15 Aug 2016 20:37:02 +0900 (JST)
Received: from mfilter5.hitachi.co.jp by mlsw3.hitachi.co.jp (8.13.8/8.13.8) id u7FBb2K3006060; Mon, 15 Aug 2016 20:37:02 +0900
Received: from vshuts04.hitachi.co.jp (vshuts04.hitachi.co.jp [10.201.6.86])
        by mfilter5.hitachi.co.jp (Switch-3.3.4/Switch-3.3.4) with ESMTP id u7FBb1FC017814;
        Mon, 15 Aug 2016 20:37:01 +0900
Received: from GSjpTKYDCehcs02.service.hitachi.net (unknown [158.212.188.46])
        by vshuts04.hitachi.co.jp (Postfix) with ESMTP id E8C0113E039;
        Mon, 15 Aug 2016 20:37:00 +0900 (JST)
Received: from GSJPTKYDCEMBX31.service.hitachi.net ([169.254.4.162]) by
 GSjpTKYDCehcs02.service.hitachi.net ([158.212.188.46]) with mapi id
 14.03.0224.002; Mon, 15 Aug 2016 20:37:00 +0900
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
Subject: RE: Re: [V4 PATCH 2/2] mips/panic: Replace smp_send_stop() with
 kdump friendly version in panic path
Thread-Topic: [!]Re: [V4 PATCH 2/2] mips/panic: Replace smp_send_stop() with
 kdump friendly version in panic path
Thread-Index: AQHR9EgmyHF47/dCPk6LxnHx9PU55aBEwvyAgAUjD8A=
Date:   Mon, 15 Aug 2016 11:35:59 +0000
Deferred-Delivery: Mon, 15 Aug 2016 11:37:00 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A84454CBBB00@GSjpTKYDCembx31.service.hitachi.net>
References: <20160810080946.11028.97686.stgit@sysi4-13.yrl.intra.hitachi.co.jp>
 <20160810080950.11028.28000.stgit@sysi4-13.yrl.intra.hitachi.co.jp>
 <20160812031755.GB2983@dhcp-128-65.nay.redhat.com>
 <57ADD55D.1050003@mvista.com>
In-Reply-To: <57ADD55D.1050003@mvista.com>
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
X-archive-position: 54535
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

SGkgQ29yZXksDQoNCj4gRnJvbTogQ29yZXkgTWlueWFyZCBbbWFpbHRvOmNtaW55YXJkQG12aXN0
YS5jb21dDQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDEyLCAyMDE2IDEwOjU2IFBNDQo+IEknbGwg
dHJ5IHRvIHRlc3QgdGhpcywgYnV0IEkgaGF2ZSBvbmUgY29tbWVudCBpbmxpbmUuLi4NCg0KVGhh
bmsgeW91IHZlcnkgbXVjaCENCg0KPiBPbiAwOC8xMS8yMDE2IDEwOjE3IFBNLCBEYXZlIFlvdW5n
IHdyb3RlOg0KPiA+IE9uIDA4LzEwLzE2IGF0IDA1OjA5cG0sIEhpZGVoaXJvIEthd2FpIHdyb3Rl
Og0KW3NuaXBdDQo+ID4+IGRpZmYgLS1naXQgYS9hcmNoL21pcHMva2VybmVsL2NyYXNoLmMgYi9h
cmNoL21pcHMva2VybmVsL2NyYXNoLmMNCj4gPj4gaW5kZXggNjEwZjBmMy4uMTcyM2IxNyAxMDA2
NDQNCj4gPj4gLS0tIGEvYXJjaC9taXBzL2tlcm5lbC9jcmFzaC5jDQo+ID4+ICsrKyBiL2FyY2gv
bWlwcy9rZXJuZWwvY3Jhc2guYw0KPiA+PiBAQCAtNDcsOSArNDcsMTQgQEAgc3RhdGljIHZvaWQg
Y3Jhc2hfc2h1dGRvd25fc2Vjb25kYXJ5KHZvaWQgKnBhc3NlZF9yZWdzKQ0KPiA+Pg0KPiA+PiAg
IHN0YXRpYyB2b2lkIGNyYXNoX2tleGVjX3ByZXBhcmVfY3B1cyh2b2lkKQ0KPiA+PiAgIHsNCj4g
Pj4gKwlzdGF0aWMgaW50IGNwdXNfc3RvcHBlZDsNCj4gPj4gICAJdW5zaWduZWQgaW50IG1zZWNz
Ow0KPiA+PiArCXVuc2lnbmVkIGludCBuY3B1czsNCj4gPj4NCj4gPj4gLQl1bnNpZ25lZCBpbnQg
bmNwdXMgPSBudW1fb25saW5lX2NwdXMoKSAtIDE7LyogRXhjbHVkaW5nIHRoZSBwYW5pYyBjcHUg
Ki8NCj4gPj4gKwlpZiAoY3B1c19zdG9wcGVkKQ0KPiA+PiArCQlyZXR1cm47DQo+IA0KPiBXb3Vs
ZG4ndCB5b3Ugd2FudCBhbiBhdG9taWMgb3BlcmF0aW9uIGFuZCBzb21lIHNwZWNpYWwgaGFuZGxp
bmcgaGVyZSB0bw0KPiBlbnN1cmUgdGhhdCBvbmx5IG9uZSBDUFUgZG9lcyB0aGlzPyAgU28gaWYg
YSBDUFUgY29tZXMgaW4gaGVyZSBhbmQNCj4gYW5vdGhlciBDUFUgaXMgYWxyZWFkeSBpbiB0aGUg
cHJvY2VzcyBzdG9wcGluZyB0aGUgQ1BVcyBpdCB3b24ndCByZXN1bHQgaW4gYQ0KPiBkZWFkbG9j
ay4NCg0KQmVjYXVzZSB0aGlzIGZ1bmN0aW9uIGNhbiBiZSBjYWxsZWQgb25seSBvbmUgcGFuaWNr
aW5nIENQVSwNCnRoZXJlIGlzIG5vIHByb2JsZW0uDQoNClRoZXJlIGFyZSB0d28gcGF0aHMgd2hp
Y2ggY3Jhc2hfa2V4ZWNfcHJlcGFyZV9jcHVzIGlzIGNhbGxlZC4NCg0KUGF0aCAxIChwYW5pYyBw
YXRoKToNCnBhbmljKCkNCiAgY3Jhc2hfc21wX3NlbmRfc3RvcCgpDQogICAgY3Jhc2hfa2V4ZWNf
cHJlcGFyZV9jcHVzKCkNCg0KUGF0aCAyIChvb3BzIHBhdGgpOg0KY3Jhc2hfa2V4ZWMoKQ0KICBf
X2NyYXNoX2tleGVjKCkNCiAgICBtYWNoaW5lX2NyYXNoX3NodXRkb3duKCkNCiAgICAgIGRlZmF1
bHRfbWFjaGluZV9jcmFzaF9zaHV0ZG93bigpIC8vIGZvciBNSVBTDQogICAgICAgIGNyYXNoX2tl
eGVjX3ByZXBhcmVfY3B1cygpDQoNCkhlcmUsIHBhbmljKCkgYW5kIGNyYXNoX2tleGVjKCkgcnVu
IGV4Y2x1c2l2ZWx5IHZpYQ0KcGFuaWNfY3B1IGF0b21pYyB2YXJpYWJsZS4gIFNvIHdlIGNhbiB1
c2UgY3B1c19zdG9wcGVkIGFzDQpub3JtYWwgdmFyaWFibGUuDQoNCkJlc3QgcmVnYXJkcywNCg0K
SGlkZWhpcm8gS2F3YWkNCg0K
