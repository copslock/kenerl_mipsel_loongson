Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2018 01:06:12 +0200 (CEST)
Received: from mga18.intel.com ([134.134.136.126]:48574 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994617AbeJVXGJPBpmU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Oct 2018 01:06:09 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2018 16:06:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,413,1534834800"; 
   d="scan'208";a="80092642"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga007.fm.intel.com with ESMTP; 22 Oct 2018 16:06:02 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 22 Oct 2018 16:06:02 -0700
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.23]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.138]) with mapi id 14.03.0319.002;
 Mon, 22 Oct 2018 16:06:01 -0700
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Subject: Re: [PATCH RFC v3 0/3] Rlimit for module space
Thread-Topic: [PATCH RFC v3 0/3] Rlimit for module space
Thread-Index: AQHUZ+1spfnb1SbseUKeGPVLPr4WMaUo18SAgAOF3YA=
Date:   Mon, 22 Oct 2018 23:06:00 +0000
Message-ID: <6b1017c450d163539d2b974657baaaf697f0a138.camel@intel.com>
References: <20181019204723.3903-1-rick.p.edgecombe@intel.com>
         <CAKv+Gu_AgPv2o4=U0-7pnpgtSufEobnta8oKhhGfCdCxM82B5Q@mail.gmail.com>
In-Reply-To: <CAKv+Gu_AgPv2o4=U0-7pnpgtSufEobnta8oKhhGfCdCxM82B5Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.168]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1AB12749F9958F4E89403DA7611AC278@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <rick.p.edgecombe@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rick.p.edgecombe@intel.com
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

T24gU2F0LCAyMDE4LTEwLTIwIGF0IDE5OjIwICswMjAwLCBBcmQgQmllc2hldXZlbCB3cm90ZToN
Cj4gSGkgUmljaywNCj4gDQo+IE9uIDE5IE9jdG9iZXIgMjAxOCBhdCAyMjo0NywgUmljayBFZGdl
Y29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KPiB3cm90ZToNCj4gPiBJZiBCUEYg
SklUIGlzIG9uLCB0aGVyZSBpcyBubyBlZmZlY3RpdmUgbGltaXQgdG8gcHJldmVudCBmaWxsaW5n
IHRoZSBlbnRpcmUNCj4gPiBtb2R1bGUgc3BhY2Ugd2l0aCBKSVRlZCBlL0JQRiBmaWx0ZXJzLg0K
PiANCj4gV2h5IGRvIEJQRiBmaWx0ZXJzIHVzZSB0aGUgbW9kdWxlIHNwYWNlLCBhbmQgZG9lcyB0
aGlzIHJlYXNvbiBhcHBseSB0bw0KPiBhbGwgYXJjaGl0ZWN0dXJlcz8NCj4gDQo+IE9uIGFybTY0
LCB3ZSBhbHJlYWR5IHN1cHBvcnQgbG9hZGluZyBwbGFpbiBtb2R1bGVzIGZhciBhd2F5IGZyb20g
dGhlDQo+IGNvcmUga2VybmVsIChpLmUuIG91dCBvZiByYW5nZSBmb3Igb3JkaW5hcnkgcmVsYXRp
dmUganVtcC9jYWxsbA0KPiBpbnN0cnVjdGlvbnMpLCBhbmQgc28gSSdkIGV4cGVjdCBCUEYgdG8g
YmUgYWJsZSB0byBkZWFsIHdpdGggdGhpcw0KPiBhbHJlYWR5IGFzIHdlbGwuIFNvIGZvciBhcm02
NCwgSSB3b25kZXIgd2h5IGFuIG9yZGluYXJ5IHZtYWxsb2NfZXhlYygpDQo+IHdvdWxkbid0IGJl
IG1vcmUgYXBwcm9wcmlhdGUuDQpBRkFJSywgaXQncyBsaWtlIHlvdSBzYWlkIGFib3V0IHJlbGF0
aXZlIGluc3RydWN0aW9uIGxpbWl0cywgYnV0IGFsc28gYmVjYXVzZQ0Kc29tZSBwcmVkaWN0b3Jz
IGRvbid0IHByZWRpY3QgcGFzdCBhIGNlcnRhaW4gZGlzdGFuY2UuIFNvIHBlcmZvcm1hbmNlIGFz
IHdlbGwuDQpOb3Qgc3VyZSB0aGUgcmVhc29ucyBmb3IgZWFjaCBhcmNoLCBvciBpZiB0aGV5IGFs
bCBhcHBseSBmb3IgQlBGIEpJVC4gVGhlcmUgc2VlbQ0KdG8gYmUgOCBieSBteSBjb3VudCwgdGhh
dCBoYXZlIGEgZGVkaWNhdGVkIG1vZHVsZSBzcGFjZSBmb3Igc29tZSByZWFzb24uDQoNCj4gU28g
YmVmb3JlIHJlZmFjdG9yaW5nIHRoZSBtb2R1bGUgYWxsb2MvZnJlZSByb3V0aW5lcyB0byBhY2Nv
bW1vZGF0ZQ0KPiBCUEYsIEknZCBsaWtlIHRvIHRha2Ugb25lIHN0ZXAgYmFjayBhbmQgYXNzZXNz
IHdoZXRoZXIgaXQgd291bGRuJ3QgYmUNCj4gbW9yZSBhcHByb3ByaWF0ZSB0byBoYXZlIGEgc2Vw
YXJhdGUgYnBmX2FsbG9jL2ZyZWUgQVBJLCB3aGljaCBjb3VsZCBiZQ0KPiB0b3RhbGx5IHNlcGFy
YXRlIGZyb20gbW9kdWxlIGFsbG9jL2ZyZWUgaWYgdGhlIGFyY2ggcGVybWl0cyBpdC4NCj4gDQpJ
IGFtIG5vdCBhIEJQRiBKSVQgZXhwZXJ0IHVuZm9ydHVuYXRlbHksIGhvcGVmdWxseSBzb21lb25l
IG1vcmUgYXV0aG9yaXRhdGl2ZQ0Kd2lsbCBjaGltZSBpbi4gSSBvbmx5IHJhbiBpbnRvIHRoaXMg
YmVjYXVzZSBJIHdhcyB0cnlpbmcgdG8gaW5jcmVhc2UNCnJhbmRvbWl6YXRpb24gZm9yIHRoZSBt
b2R1bGUgc3BhY2UgYW5kIHdhbnRlZCB0byBmaW5kIG91dCBob3cgbWFueSBhbGxvY2F0aW9ucw0K
bmVlZGVkIHRvIGJlIHN1cHBvcnRlZC4NCg0KSSdkIGd1ZXNzIHRob3VnaCwgdGhhdCBCUEYgSklU
IGlzIGp1c3QgYXNzdW1pbmcgdGhhdCB0aGVyZSB3aWxsIGJlIHNvbWUgYXJjaA0Kc3BlY2lmaWMg
Y29uc3RyYWludHMgYWJvdXQgd2hlcmUgdGV4dCBjYW4gYmUgcGxhY2VkIG9wdGltYWxseSBhbmQg
dGhleSB3b3VsZA0KYWxyZWFkeSBiZSB0YWtlbiBpbnRvIGFjY291bnQgaW4gdGhlIG1vZHVsZSBz
cGFjZSBhbGxvY2F0b3IuDQoNCklmIHRoZXJlIGFyZSBubyBjb25zdHJhaW50cyBmb3Igc29tZSBh
cmNoLCBJJ2Qgd29uZGVyIHdoeSBub3QganVzdCB1cGRhdGUgaXRzDQptb2R1bGVfYWxsb2MgdG8g
dXNlIHRoZSB3aG9sZSBzcGFjZSBhdmFpbGFibGUuIFdoYXQgZXhhY3RseSBhcmUgdGhlIGNvbnN0
cmFpbnRzDQpmb3IgYXJtNjQgZm9yIG5vcm1hbCBtb2R1bGVzPw0KDQpJdCBzZWVtcyBmaW5lIHRv
IG1lIGZvciBhcmNoaXRlY3R1cmVzIHRvIGhhdmUgdGhlIG9wdGlvbiBvZiBzb2x2aW5nIHRoaXMg
YQ0KZGlmZmVyZW50IHdheS4gSWYgcG90ZW50aWFsbHkgdGhlIHJsaW1pdCBlbmRzIHVwIGJlaW5n
IHRoZSBiZXN0IHNvbHV0aW9uIGZvcg0Kc29tZSBhcmNoaXRlY3R1cmVzIHRob3VnaCwgZG8geW91
IHRoaW5rIHRoaXMgcmVmYWN0b3IgKHByZXR0eSBjbG9zZSB0byBqdXN0IGENCm5hbWUgY2hhbmdl
KSBpcyB0aGF0IGludHJ1c2l2ZT8NCg0KSSBndWVzcyBpdCBjb3VsZCBiZSBqdXN0IGEgQlBGIEpJ
VCBwZXIgdXNlciBsaW1pdCBhbmQgbm90IHRvdWNoIG1vZHVsZSBzcGFjZSwNCmJ1dCBJIHRob3Vn
aHQgdGhlIG1vZHVsZSBzcGFjZSBsaW1pdCB3YXMgYSBtb3JlIGdlbmVyYWwgc29sdXRpb24gYXMg
dGhhdCBpcyB0aGUNCmFjdHVhbCBsaW1pdGVkIHJlc291cmNlLg0KDQo+ID4gRm9yIGNsYXNzaWMg
QlBGIGZpbHRlcnMgYXR0YWNoZWQgd2l0aA0KPiA+IHNldHNvY2tvcHQgU09fQVRUQUNIX0ZJTFRF
UiwgdGhlcmUgaXMgbm8gbWVtbG9jayBybGltaXQgY2hlY2sgdG8gbGltaXQgdGhlDQo+ID4gbnVt
YmVyIG9mIGluc2VydGlvbnMgbGlrZSB0aGVyZSBpcyBmb3IgdGhlIGJwZiBzeXNjYWxsLg0KPiA+
IA0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBhIHBlciB1c2VyIHJsaW1pdCBmb3IgbW9kdWxlIHNwYWNl
LCBhcyB3ZWxsIGFzIGEgc3lzdGVtIHdpZGUNCj4gPiBsaW1pdCBmb3IgQlBGIEpJVC4gSW4gYSBw
cmV2aW91c2x5IHJldmlld2VkIHBhdGNoc2V0LCBKYW5uIEhvcm4gcG9pbnRlZCBvdXQNCj4gPiB0
aGUNCj4gPiBwcm9ibGVtIHRoYXQgaW4gc29tZSBjYXNlcyBhIHVzZXIgY2FuIGdldCBhY2Nlc3Mg
dG8gNjU1MzYgVUlEcywgc28gdGhlDQo+ID4gZWZmZWN0aXZlDQo+ID4gbGltaXQgY2Fubm90IGJl
IHNldCBsb3cgZW5vdWdoIHRvIHN0b3AgYW4gYXR0YWNrZXIgYW5kIGJlIHVzZWZ1bCBmb3IgdGhl
DQo+ID4gZ2VuZXJhbA0KPiA+IGNhc2UuIEEgZGlzY3Vzc2VkIGFsdGVybmF0aXZlIHNvbHV0aW9u
IHdhcyBhIHN5c3RlbSB3aWRlIGxpbWl0IGZvciBCUEYgSklUDQo+ID4gZmlsdGVycy4gVGhpcyBt
dWNoIG1vcmUgc2ltcGx5IHJlc29sdmVzIHRoZSBwcm9ibGVtIG9mIGV4aGF1c3Rpb24gYW5kDQo+
ID4gZGUtcmFuZG9taXppbmcgaW4gdGhlIGNhc2Ugb2Ygbm9uLUNPTkZJR19CUEZfSklUX0FMV0FZ
U19PTi4gSWYNCj4gPiBDT05GSUdfQlBGX0pJVF9BTFdBWVNfT04gaXMgb24gaG93ZXZlciwgQlBG
IGluc2VydGlvbnMgd2lsbCBmYWlsIGlmIGFub3RoZXINCj4gPiB1c2VyDQo+ID4gZXhoYXVzdHMg
dGhlIEJQRiBKSVQgbGltaXQuIEluIHRoaXMgY2FzZSBhIHBlciB1c2VyIGxpbWl0IGlzIHN0aWxs
IG5lZWRlZC4NCj4gPiBJZg0KPiA+IHRoZSBzdWJ1aWQgZmFjaWxpdHkgaXMgZGlzYWJsZWQgZm9y
IG5vcm1hbCB1c2VycywgdGhpcyBzaG91bGQgc3RpbGwgYmUgb2sNCj4gPiBiZWNhdXNlIHRoZSBo
aWdoZXIgbGltaXQgd2lsbCBub3QgYmUgYWJsZSB0byBiZSB3b3JrZWQgYXJvVGhleSBtaWdodCB1
bmQNCj4gPiB0aGF0IHdheS4NCj4gPiANCj4gPiBUaGUgbmV3IEJQRiBKSVQgbGltaXQgY2FuIGJl
IHNldCBsaWtlIHRoaXM6DQo+ID4gZWNobyA1MDAwMDAwID4gL3Byb2Mvc3lzL25ldC9jb3JlL2Jw
Zl9qaXRfbGltaXQNCj4gPiANCj4gPiBTbyBJICp0aGluayogdGhpcyBwYXRjaHNldCBzaG91bGQg
cmVzb2x2ZSB0aGF0IGlzc3VlIGV4Y2VwdCBmb3IgdGhlDQo+ID4gY29uZmlndXJhdGlvbiBvZiBD
T05GSUdfQlBGX0pJVF9BTFdBWVNfT04gYW5kIHN1YnVpZCBhbGxvd2VkIGZvciBub3JtYWwNCj4g
PiB1c2Vycy4NCj4gPiBCZXR0ZXIgbW9kdWxlIHNwYWNlIEtBU0xSIGlzIGFub3RoZXIgd2F5IHRv
IHJlc29sdmUgdGhlIGRlLXJhbmRvbWl6aW5nDQo+ID4gaXNzdWUsDQo+ID4gYW5kIHNvIHRoZW4g
eW91IHdvdWxkIGp1c3QgYmUgbGVmdCB3aXRoIHRoZSBCUEYgRE9TIGluIHRoYXQgY29uZmlndXJh
dGlvbi4NCj4gPiANCj4gPiBKYW5uIGFsc28gcG9pbnRlZCBvdXQgaG93LCB3aXRoIHB1cnBvc2Vs
eSBmcmFnbWVudGluZyB0aGUgbW9kdWxlIHNwYWNlLCB5b3UNCj4gPiBjb3VsZCBtYWtlIHRoZSBl
ZmZlY3RpdmUgbW9kdWxlIHNwYWNlIGJsb2NrYWdlIGFyZWEgbXVjaCBsYXJnZXIuIFRoaXMgaXMN
Cj4gPiBhbHNvDQo+ID4gc29tZXdoYXQgdW4tcmVzb2x2ZWQuIFRoZSBpbXBhY3Qgd291bGQgZGVw
ZW5kIG9uIGhvdyBiaWcgb2YgYSBzcGFjZSB5b3UgYXJlDQo+ID4gdHJ5aW5nIHRvIGFsbG9jYXRl
LiBUaGUgbGltaXQgaGFzIGJlZW4gbG93ZXJlZCBvbiB4ODZfNjQgc28gdGhhdCBhdCBsZWFzdA0K
PiA+IHR5cGljYWwgc2l6ZWQgQlBGIGZpbHRlcnMgY2Fubm90IGJlIGJsb2NrZWQuDQo+ID4gDQo+
ID4gSWYgYW55b25lIHdpdGggbW9yZSBleHBlcmllbmNlIHdpdGggc3VidWlkL3VzZXIgbmFtZXNw
YWNlcyBoYXMgYW55DQo+ID4gc3VnZ2VzdGlvbnMNCj4gPiBJJ2QgYmUgZ2xhZCB0byBoZWFyLiBP
biBhbiBVYnVudHUgbWFjaGluZSBpdCBkaWRuJ3Qgc2VlbSBsaWtlIGEgdW4tDQo+ID4gcHJpdmls
ZWdlZA0KPiA+IHVzZXIgY291bGQgZG8gdGhpcy4gSSBhbSBnb2luZyB0byBrZWVwIHdvcmtpbmcg
b24gdGhpcyBhbmQgc2VlIGlmIEkgY2FuIGZpbmQNCj4gPiBhDQo+ID4gYmV0dGVyIHNvbHV0aW9u
Lg0KPiA+IA0KPiA+IENoYW5nZXMgc2luY2UgdjI6DQo+ID4gIC0gU3lzdGVtIHdpZGUgQlBGIEpJ
VCBsaW1pdCAoZGlzY3Vzc2lvbiB3aXRoIEphbm4gSG9ybikNCj4gPiAgLSBIb2xkaW5nIHJlZmVy
ZW5jZSB0byB1c2VyIGNvcnJlY3RseSAoSmFubikNCj4gPiAgLSBIYXZpbmcgYXJjaCB2ZXJzaW9u
cyBvZiBtb2R1bGRlX2FsbG9jIChEYXZlIEhhbnNlbiwgSmVzc2ljYSBZdSkNCj4gPiAgLSBTaHJp
bmtpbmcgb2YgZGVmYXVsdCBsaW1pdHMsIHRvIGhlbHAgcHJldmVudCB0aGUgbGltaXQgYmVpbmcg
d29ya2VkDQo+ID4gYXJvdW5kDQo+ID4gICAgd2l0aCBmcmFnbWVudGF0aW9uIChKYW5uKQ0KPiA+
IA0KPiA+IENoYW5nZXMgc2luY2UgdjE6DQo+ID4gIC0gUGx1ZyBpbiBmb3Igbm9uLXg4Ng0KPiA+
ICAtIEFyY2ggc3BlY2lmaWMgZGVmYXVsdCB2YWx1ZXMNCj4gPiANCj4gPiANCj4gPiBSaWNrIEVk
Z2Vjb21iZSAoMyk6DQo+ID4gICBtb2R1bGVzOiBDcmVhdGUgYXJjaCB2ZXJzaW9ucyBvZiBtb2R1
bGUgYWxsb2MvZnJlZQ0KPiA+ICAgbW9kdWxlczogQ3JlYXRlIHJsaW1pdCBmb3IgbW9kdWxlIHNw
YWNlDQo+ID4gICBicGY6IEFkZCBzeXN0ZW0gd2lkZSBCUEYgSklUIGxpbWl0DQo+ID4gDQo+ID4g
IGFyY2gvYXJtL2tlcm5lbC9tb2R1bGUuYyAgICAgICAgICAgICAgICB8ICAgMiArLQ0KPiA+ICBh
cmNoL2FybTY0L2tlcm5lbC9tb2R1bGUuYyAgICAgICAgICAgICAgfCAgIDIgKy0NCj4gPiAgYXJj
aC9taXBzL2tlcm5lbC9tb2R1bGUuYyAgICAgICAgICAgICAgIHwgICAyICstDQo+ID4gIGFyY2gv
bmRzMzIva2VybmVsL21vZHVsZS5jICAgICAgICAgICAgICB8ICAgMiArLQ0KPiA+ICBhcmNoL25p
b3MyL2tlcm5lbC9tb2R1bGUuYyAgICAgICAgICAgICAgfCAgIDQgKy0NCj4gPiAgYXJjaC9wYXJp
c2Mva2VybmVsL21vZHVsZS5jICAgICAgICAgICAgIHwgICAyICstDQo+ID4gIGFyY2gvczM5MC9r
ZXJuZWwvbW9kdWxlLmMgICAgICAgICAgICAgICB8ICAgMiArLQ0KPiA+ICBhcmNoL3NwYXJjL2tl
cm5lbC9tb2R1bGUuYyAgICAgICAgICAgICAgfCAgIDIgKy0NCj4gPiAgYXJjaC91bmljb3JlMzIv
a2VybmVsL21vZHVsZS5jICAgICAgICAgIHwgICAyICstDQo+ID4gIGFyY2gveDg2L2luY2x1ZGUv
YXNtL3BndGFibGVfMzJfdHlwZXMuaCB8ICAgMyArDQo+ID4gIGFyY2gveDg2L2luY2x1ZGUvYXNt
L3BndGFibGVfNjRfdHlwZXMuaCB8ICAgMiArDQo+ID4gIGFyY2gveDg2L2tlcm5lbC9tb2R1bGUu
YyAgICAgICAgICAgICAgICB8ICAgMiArLQ0KPiA+ICBmcy9wcm9jL2Jhc2UuYyAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgIDEgKw0KPiA+ICBpbmNsdWRlL2FzbS1nZW5lcmljL3Jlc291cmNl
LmggICAgICAgICAgfCAgIDggKysNCj4gPiAgaW5jbHVkZS9saW51eC9icGYuaCAgICAgICAgICAg
ICAgICAgICAgIHwgICA3ICsrDQo+ID4gIGluY2x1ZGUvbGludXgvZmlsdGVyLmggICAgICAgICAg
ICAgICAgICB8ICAgMSArDQo+ID4gIGluY2x1ZGUvbGludXgvc2NoZWQvdXNlci5oICAgICAgICAg
ICAgICB8ICAgNCArDQo+ID4gIGluY2x1ZGUvdWFwaS9hc20tZ2VuZXJpYy9yZXNvdXJjZS5oICAg
ICB8ICAgMyArLQ0KPiA+ICBrZXJuZWwvYnBmL2NvcmUuYyAgICAgICAgICAgICAgICAgICAgICAg
fCAgMjIgKysrLQ0KPiA+ICBrZXJuZWwvYnBmL2lub2RlLmMgICAgICAgICAgICAgICAgICAgICAg
fCAgMTYgKysrDQo+ID4gIGtlcm5lbC9tb2R1bGUuYyAgICAgICAgICAgICAgICAgICAgICAgICB8
IDE1MiArKysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiAgbmV0L2NvcmUvc3lzY3RsX25ldF9j
b3JlLmMgICAgICAgICAgICAgIHwgICA3ICsrDQo+ID4gIDIyIGZpbGVzIGNoYW5nZWQsIDIzMyBp
bnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiAtLQ0KPiA+IDIuMTcuMQ0K
PiA+IA0KYnJhbmNoaW5nIHByZWRpY3RvcnMgbWF5IG5vdCBiZSBhYmxlIHRvIHByZWRpY3QgcGFz
dCBhIGNlcnRhaW4gZGlzdGFuY2UuIFNvDQpwZXJmb3JtYW5jZSBhcyB3ZWxsLg0K
