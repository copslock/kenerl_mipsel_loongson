Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2018 03:01:55 +0200 (CEST)
Received: from mga02.intel.com ([134.134.136.20]:30216 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994641AbeJYBBwBB6mo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Oct 2018 03:01:52 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 18:01:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,422,1534834800"; 
   d="scan'208";a="274223090"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga005.fm.intel.com with ESMTP; 24 Oct 2018 18:01:48 -0700
Received: from orsmsx115.amr.corp.intel.com (10.22.240.11) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 24 Oct 2018 18:01:48 -0700
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.23]) by
 ORSMSX115.amr.corp.intel.com ([169.254.4.116]) with mapi id 14.03.0319.002;
 Wed, 24 Oct 2018 18:01:47 -0700
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
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
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH RFC v3 0/3] Rlimit for module space
Thread-Topic: [PATCH RFC v3 0/3] Rlimit for module space
Thread-Index: AQHUZ+1spfnb1SbseUKeGPVLPr4WMaUo18SAgAOF3YCAANZLAIAByAYAgAAQFICAAJacAA==
Date:   Thu, 25 Oct 2018 01:01:44 +0000
Message-ID: <d1fec827d028168047eafbac56e8e47d37cf7fb5.camel@intel.com>
References: <20181019204723.3903-1-rick.p.edgecombe@intel.com>
         <CAKv+Gu_AgPv2o4=U0-7pnpgtSufEobnta8oKhhGfCdCxM82B5Q@mail.gmail.com>
         <6b1017c450d163539d2b974657baaaf697f0a138.camel@intel.com>
         <CAKv+Gu-Rk-SQVOQ63L3DkF3=EVik3pHXzpNp5r5TrgDajTM_iQ@mail.gmail.com>
         <20181024150706.jewcclhhh756tupn@linux-8ccs>
         <d7cb6a8c-b7d6-5c82-6721-2b5387da673f@iogearbox.net>
In-Reply-To: <d7cb6a8c-b7d6-5c82-6721-2b5387da673f@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.168]
Content-Type: text/plain; charset="utf-8"
Content-ID: <70B26219A7338841A85E2DAD99697A14@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <rick.p.edgecombe@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66930
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

T24gV2VkLCAyMDE4LTEwLTI0IGF0IDE4OjA0ICswMjAwLCBEYW5pZWwgQm9ya21hbm4gd3JvdGU6
DQo+IFsgK0FsZXhlaSwgbmV0ZGV2IF0NCj4gDQo+IE9uIDEwLzI0LzIwMTggMDU6MDcgUE0sIEpl
c3NpY2EgWXUgd3JvdGU6DQo+ID4gKysrIEFyZCBCaWVzaGV1dmVsIFsyMy8xMC8xOCAwODo1NCAt
MDMwMF06DQo+ID4gPiBPbiAyMiBPY3RvYmVyIDIwMTggYXQgMjA6MDYsIEVkZ2Vjb21iZSwgUmlj
ayBQDQo+ID4gPiA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gWy4u
Ll0NCj4gPiA+IEkgdGhpbmsgaXQgaXMgd3JvbmcgdG8gY29uZmxhdGUgdGhlIHR3byB0aGluZ3Mu
IExpbWl0aW5nIHRoZSBudW1iZXIgb2YNCj4gPiA+IEJQRiBhbGxvY2F0aW9ucyBhbmQgdGhlIGxp
bWl0aW5nIG51bWJlciBvZiBtb2R1bGUgYWxsb2NhdGlvbnMgYXJlIHR3bw0KPiA+ID4gc2VwYXJh
dGUgdGhpbmdzLCBhbmQgdGhlIGZhY3QgdGhhdCBCUEYgcmV1c2VzIG1vZHVsZV9hbGxvYygpIG91
dCBvZg0KPiA+ID4gY29udmVuaWVuY2UgZG9lcyBub3QgbWVhbiBhIHNpbmdsZSBybGltaXQgZm9y
IGJvdGggaXMgYXBwcm9wcmlhdGUuDQo+ID4gDQo+ID4gSG0sIEkgdGhpbmsgQXJkIGhhcyBhIGdv
b2QgcG9pbnQuIEFGQUlLLCBhbmQgY29ycmVjdCBtZSBpZiBJJ20gd3JvbmcsDQo+ID4gdXNlcnMg
b2YgbW9kdWxlX2FsbG9jKCkgaS5lLiBrcHJvYmVzLCBmdHJhY2UsIGJwZiwgc2VlbSB0byB1c2Ug
aXQNCj4gPiBiZWNhdXNlIGl0IGlzIGFuIGVhc3kgd2F5IHRvIG9idGFpbiBleGVjdXRhYmxlIGtl
cm5lbCBtZW1vcnkgKGFuZA0KPiA+IGRlcGVuZGluZyBvbiB0aGUgbmVlZHMgb2YgdGhlIGFyY2hp
dGVjdHVyZSwgYmVpbmcgYWRkaXRpb25hbGx5DQo+ID4gcmVhY2hhYmxlIHZpYSByZWxhdGl2ZSBi
cmFuY2hlcykgZHVyaW5nIHJ1bnRpbWUuIFRoZSBzaWRlIGVmZmVjdCBpcw0KPiA+IHRoYXQgYWxs
IHRoZXNlIHVzZXJzIHNoYXJlIHRoZSAibW9kdWxlIiBtZW1vcnkgc3BhY2UsIGV2ZW4gdGhvdWdo
IHRoaXMNCj4gPiBtZW1vcnkgcmVnaW9uIGlzIG5vdCBleGNsdXNpdmVseSB1c2VkIGJ5IG1vZHVs
ZXMgKHdlbGwsIHBlcnNvbmFsbHkgSQ0KPiA+IHRoaW5rIGl0IHRlY2huaWNhbGx5IHNob3VsZCBi
ZSwgYmVjYXVzZSBzZWVpbmcgbW9kdWxlX2FsbG9jKCkgdXNhZ2UNCj4gPiBvdXRzaWRlIG9mIHRo
ZSBtb2R1bGUgbG9hZGVyIGlzIGtpbmQgb2YgYSBtaXN1c2Ugb2YgdGhlIG1vZHVsZSBBUEkgYW5k
DQo+ID4gaXQncyBjb25mdXNpbmcgZm9yIHBlb3BsZSB3aG8gZG9uJ3Qga25vdyB0aGUgcmVhc29u
IGJlaGluZCBpdHMgdXNhZ2UNCj4gPiBvdXRzaWRlIG9mIHRoZSBtb2R1bGUgbG9hZGVyKS4NCj4g
PiANCj4gPiBSaWdodCBub3cgSSdtIG5vdCBzdXJlIGlmIGl0IG1ha2VzIHNlbnNlIHRvIGltcG9z
ZSBhIGJsYW5rZXQgbGltaXQgb24NCj4gPiBhbGwgbW9kdWxlX2FsbG9jKCkgYWxsb2NhdGlvbnMg
d2hlbiB0aGUgcmVhbCBtb3RpdmF0aW9uIGJlaGluZCB0aGUNCj4gPiBybGltaXQgaXMgcmVsYXRl
ZCB0byBCUEYsIGkuZS4sIHRvIHN0b3AgdW5wcml2aWxlZ2VkIHVzZXJzIGZyb20NCj4gPiBob2dn
aW5nIHVwIGFsbCB0aGUgdm1hbGxvYyBzcGFjZSBmb3IgbW9kdWxlcyB3aXRoIEpJVGVkIEJQRiBm
aWx0ZXJzLg0KPiA+IFNvIHRoZSBybGltaXQgaGFzIG1vcmUgdG8gZG8gd2l0aCBsaW1pdGluZyB0
aGUgbWVtb3J5IHVzYWdlIG9mIEJQRg0KPiA+IGZpbHRlcnMgdGhhbiBpdCBoYXMgdG8gZG8gd2l0
aCBtb2R1bGVzIHRoZW1zZWx2ZXMuDQo+ID4gDQo+ID4gSSB0aGluayBBcmQncyBzdWdnZXN0aW9u
IG9mIGhhdmluZyBhIHNlcGFyYXRlIGJwZl9hbGxvYy9mcmVlIEFQSSBtYWtlcw0KPiA+IGEgbG90
IG9mIHNlbnNlIGlmIHdlIHdhbnQgdG8ga2VlcCB0cmFjayBvZiBicGYtcmVsYXRlZCBhbGxvY2F0
aW9ucw0KPiA+IChhbmQgdGhlbiB0aGUgcmxpbWl0IHdvdWxkIGJlIGVuZm9yY2VkIGZvciB0aG9z
ZSkuIE1heWJlIHBhcnQgb2YgdGhlDQo+ID4gbW9kdWxlIG1hcHBpbmcgc3BhY2UgY291bGQgYmUg
Y2FydmVkIG91dCBmb3IgYnBmIGZpbHRlcnMgKGUuZy4gaGF2ZQ0KPiA+IEJQRl9WQUREUiwgQlBG
X1ZTSVpFLCBldGMgbGlrZSBob3cgd2UgaGF2ZSBpdCBmb3IgbW9kdWxlcyksIG9yDQo+ID4gY29u
dGludWUgc2hhcmluZyB0aGUgcmVnaW9uIGJ1dCBleHBsaWNpdGx5IGRlZmluZSBhIHNlcGFyYXRl
IGJwZl9hbGxvYw0KPiA+IEFQSSwgZGVwZW5kaW5nIG9uIGFuIGFyY2hpdGVjdHVyZSdzIG5lZWRz
LiBXaGF0IGRvIHBlb3BsZSB0aGluaz8NCj4gDQo+IEhtbSwgSSB0aGluayBoZXJlIGFyZSBzZXZl
cmFsIGlzc3VlcyBtaXhlZCB1cCBhdCB0aGUgc2FtZSB0aW1lIHdoaWNoIGlzIGp1c3QNCj4gdmVy
eSBjb25mdXNpbmcsIGltaG86DQo+IA0KPiAxKSBUaGUgZmFjdCB0aGF0IHRoZXJlIGFyZSBzZXZl
cmFsIG5vbi1tb2R1bGUgdXNlcnMgb2YgbW9kdWxlX2FsbG9jKCkNCj4gYXMgSmVzc2ljYSBub3Rl
cyBzdWNoIGFzIGtwcm9iZXMsIGZ0cmFjZSwgYnBmLCBmb3IgZXhhbXBsZS4gV2hpbGUgYWxsIG9m
DQo+IHRoZW0gYXJlIG5vdCBiZWluZyBtb2R1bGVzLCB0aGV5IGFsbCBuZWVkIHRvIGFsbG9jIHNv
bWUgcGllY2Ugb2YgZXhlY3V0YWJsZQ0KPiBtZW1vcnkuIEl0J3Mgbm90aGluZyBuZXcsIHRoaXMg
ZXhpc3RzIGZvciA3IHllYXJzIG5vdyBzaW5jZSAwYTE0ODQyZjVhM2MNCj4gKCJuZXQ6IGZpbHRl
cjogSnVzdCBJbiBUaW1lIGNvbXBpbGVyIGZvciB4ODYtNjQiKSBmcm9tIEJQRiBzaWRlOyBlZmZl
Y3RpdmVseQ0KPiB0aGF0IGlzIGV2ZW4gL2JlZm9yZS8gZUJQRiBleGlzdGVkLiBIYXZpbmcgc29t
ZSBkaWZmZXJlbnQgQVBJIHBlcmhhcHMgZm9yIGFsbA0KPiB0aGVzZSB1c2VycyBzZWVtcyB0byBt
YWtlIHNlbnNlIGlmIHRoZSBnb2FsIGlzIG5vdCB0byBpbnRlcmZlcmUgd2l0aCBtb2R1bGVzDQo+
IHRoZW1zZWx2ZXMuIEl0IG1pZ2h0IGFsc28gaGVscCBhcyBhIGJlbmVmaXQgdG8gcG90ZW50aWFs
bHkgaW5jcmVhc2UgdGhhdA0KPiBtZW1vcnkgcG9vbCBpZiB3ZSdyZSBoaXR0aW5nIGxpbWl0cyBh
dCBzY2FsZSB3aGljaCB3b3VsZCBub3QgYmUgYSBjb25jZXJuDQo+IGZvciBub3JtYWwga2VybmVs
IG1vZHVsZXMgc2luY2UgdGhlcmUncyB1c3VhbGx5IGp1c3QgYSB2ZXJ5IGZldyBvZiB0aGVtDQo+
IG5lZWRlZCAodW5saWtlIGR5bmFtaWNhbGx5IHRyYWNpbmcgdmFyaW91cyBrZXJuZWwgcGFydHMg
MjQvNyB3LyBvciB3L28gQlBGLA0KPiBydW5uaW5nIEJQRi1zZWNjb21wIHBvbGljaWVzLCBuZXR3
b3JraW5nIEJQRiBwb2xpY2llcywgZXRjIHdoaWNoIG5lZWQgdG8NCj4gc2NhbGUgdy8gYXBwbGlj
YXRpb24gb3IgY29udGFpbmVyIGRlcGxveW1lbnQ7IHNvIHRoaXMgaXMgb2YgbXVjaCBtb3JlDQo+
IGR5bmFtaWMgYW5kIHVucHJlZGljdGFibGUgbmF0dXJlKS4NCj4gDQo+IDIpIFRoZW4gdGhlcmUg
aXMgcmxpbWl0IHdoaWNoIGlzIHByb3Bvc2luZyB0byBoYXZlIGEgImZhaXJlciIgc2hhcmUgYW1v
bmcNCj4gdW5wcml2aWxlZ2VkIHVzZXJzLiBJJ20gbm90IGZ1bGx5IHN1cmUgeWV0IHdoZXRoZXIg
cmxpbWl0IGlzIGFjdHVhbGx5IGENCj4gbmljZSB1c2FibGUgaW50ZXJmYWNlIGZvciBhbGwgdGhp
cy4gSSdkIGFncmVlIHRoYXQgc29tZXRoaW5nIGlzIG5lZWRlZA0KPiBvbiB0aGF0IHJlZ2FyZCwg
YnV0IEkgYWxzbyB0ZW5kIHRvIGxpa2UgTWljaGFsIEhvY2tvJ3MgY2dyb3VwIHByb3Bvc2FsLA0K
PiBpb3csIHRvIGhhdmUgc3VjaCByZXNvdXJjZSBjb250cm9sIGFzIHBhcnQgb2YgbWVtb3J5IGNn
cm91cCBjb3VsZCBiZQ0KPiBzb21ldGhpbmcgdG8gY29uc2lkZXIgX2VzcGVjaWFsbHlfIHNpbmNl
IGl0IGFscmVhZHkgX2V4aXN0c18gZm9yIHZtYWxsb2MoKQ0KPiBiYWNrZWQgbWVtb3J5IHNvIHRo
aXMgc2hvdWxkIGJlIG5vdCBtdWNoIGRpZmZlcmVudCB0aGFuIHRoYXQuIEl0IHNvdW5kcw0KPiBs
aWtlIDIpIGNvbWVzIG9uIHRvcCBvZiAxKS4NCkZXSVcsIGNncm91cHMgc2VlbXMgbGlrZSBhIGJl
dHRlciBzb2x1dGlvbiB0aGFuIHJsaW1pdCB0byBtZSB0b28uIE1heWJlIHlvdSBhbGwNCmFscmVh
ZHkga25vdywgYnV0IGl0IGxvb2tzIGxpa2UgdGhlIGNncm91cHMgdm1hbGxvYyBjaGFyZ2UgaXMg
ZG9uZSBpbiB0aGUgbWFpbg0KcGFnZSBhbGxvY2F0b3IgYW5kIGNvdW50cyBhZ2FpbnN0IHRoZSB3
aG9sZSBrZXJuZWwgbWVtb3J5IGxpbWl0LiBBIHVzZXIgbWF5IHdhbnQNCnRvIGhhdmUgYSBoaWdo
ZXIga2VybmVsIGxpbWl0IHRoYW4gdGhlIG1vZHVsZSBzcGFjZSBzaXplLCBzbyBpdCBzZWVtcyBp
dCBpc24ndA0KZW5vdWdoIGJ5IGl0c2VsZiBhbmQgc29tZSBuZXcgbGltaXQgd291bGQgbmVlZCB0
byBiZSBhZGRlZC4NCg0KQXMgZm9yIHdoYXQgdGhlIGxpbWl0IHNob3VsZCBiZSwgSSB3b25kZXIg
aWYgc29tZSBvZiB0aGUgZGlzYWdyZWVtZW50IGlzIGp1c3QNCmZyb20gdGhlIG5hbWUgIm1vZHVs
ZSBzcGFjZSIuDQoNClRoZXJlIGlzIGEgbGltaXRlZCByZXNvdXJjZSBvZiBwaHlzaWNhbCBtZW1v
cnksIHNvIHdlIGhhdmUgbGltaXRzIGZvciBpdC4gVGhlcmUNCmlzIGEgbGltaXRlZCByZXNvdXJj
ZSBvZiBDUFUgdGltZSwgc28gd2UgaGF2ZSBsaW1pdHMgZm9yIGl0LiBJZiB0aGVyZSBpcyBhDQps
aW1pdGVkIHJlc291cmNlIGZvciBwcmVmZXJyZWQgYWRkcmVzcyBzcGFjZSBmb3IgZXhlY3V0YWJs
ZSBjb2RlLCB3aHkgbm90IGp1c3QNCmNvbnRpbnVlIHRoYXQgdHJlbmQ/IElmIG90aGVyIGZvcm1z
IG9mIHVucHJpdmlsZWdlZCBKSVQgY29tZSBhbG9uZywgd291bGQgaXQgYmUNCmJldHRlciB0byBo
YXZlIE4gbGltaXRzIGZvciBlYWNoIHR5cGU/IFJlcXVlc3RfbW9kdWxlIHByb2JhYmx5IGNhbid0
IGZpbGwgdGhlDQpzcGFjZSwgYnV0IHRlY2huaWNhbGx5IHRoZXJlIGFyZSBhbHJlYWR5IDIgdW5w
cml2aWxlZ2VkIHVzZXJzLiBTbyBJTUhPLCBpdHMgYQ0KbW9yZSBmb3J3YXJkIGxvb2tpbmcgc29s
dXRpb24uDQoNCklmIHRoZXJlIGFyZSBzb21lIHVzYWdlL2FyY2hpdGVjdHVyZSBjb21ib3MgdGhh
dCBkb24ndCBuZWVkIHRoZSBwcmVmZXJyZWQgc3BhY2UNCnRoZXkgY2FuIGFsbG9jYXRlIGluIHZt
YWxsb2MgYW5kIGhhdmUgaXQgbm90IGNvdW50IGFnYWluc3QgdGhlIHByZWZlcnJlZCBzcGFjZQ0K
bGltaXQgYnV0IHN0aWxsIGNvdW50IGFnYWluc3QgdGhlIGNncm91cHMga2VybmVsIG1lbW9yeSBs
aW1pdC4NCg0KQW5vdGhlciBiZW5lZml0IG9mIGNlbnRyYWxpemluZyB0aGUgYWxsb2NhdGlvbiBv
ZiB0aGUgImV4ZWN1dGFibGUgbWVtb3J5DQpwcmVmZXJyZWQgc3BhY2UiIGlzIEtBU0xSLiBSaWdo
dCBub3cgdGhhdCBpcyBvbmx5IGRvbmUgaW4gbW9kdWxlX2FsbG9jIGFuZCBzbw0KYWxsIHVzZXJz
IG9mIGl0IGdldCByYW5kb21pemVkLiBJZiB0aGV5IGFsbCBjYWxsIHZtYWxsb2MgYnkgdGhlbXNl
bHZlcyB0aGV5IHdpbGwNCmp1c3QgdXNlIHRoZSBub3JtYWwgYWxsb2NhdG9yLg0KDQpBbnl3YXks
IGl0IHNlZW1zIGxpa2UgZWl0aGVyIHR5cGUgb2YgbGltaXQgKEJQRiBKSVQgb3IgYWxsIG1vZHVs
ZSBzcGFjZSkgd2lsbA0Kc29sdmUgdGhlIHByb2JsZW0gZXF1YWxseSB3ZWxsIHRvZGF5Lg0KDQo+
IDMpIExhc3QgYnV0IG5vdCBsZWFzdCwgdGhlcmUncyBhIHNob3J0IHRlcm0gZml4IHdoaWNoIGlz
IG5lZWRlZCBpbmRlcGVuZGVudGx5DQo+IG9mIDEpIGFuZCAyKSBhbmQgc2hvdWxkIGJlIGRvbmUg
aW1tZWRpYXRlbHkgd2hpY2ggaXMgdG8gYWNjb3VudCBmb3INCj4gdW5wcml2aWxlZ2VkIHVzZXJz
IGFuZCByZXN0cmljdCB0aGVtIGJhc2VkIG9uIGEgZ2xvYmFsIGNvbmZpZ3VyYWJsZQ0KPiBsaW1p
dCBzdWNoIHRoYXQgcHJpdmlsZWdlZCB1c2Uga2VlcHMgZnVuY3Rpb25pbmcsIGFuZCAyKSBjb3Vs
ZCBlbmZvcmNlDQo+IGJhc2VkIG9uIHRoZSBnbG9iYWwgdXBwZXIgbGltaXQsIGZvciBleGFtcGxl
LiBQZW5kaW5nIGZpeCBpcyB1bmRlcg0KPiBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Bh
dGNoLzk4Nzk3MS8gd2hpY2ggd2UgaW50ZW5kIHRvIHNoaXAgdG8NCj4gTGludXMgYXMgc29vbiBh
cyBwb3NzaWJsZSBhcyBzaG9ydCB0ZXJtIGZpeC4gVGhlbiBzb21ldGhpbmcgbGlrZSBtZW1jZw0K
PiBjYW4gYmUgY29uc2lkZXJlZCBvbiB0b3Agc2luY2UgaXQgc2VlbXMgdGhpcyBtYWtlcyBtb3N0
IHNlbnNlIGZyb20gYQ0KPiB1c2FiaWxpdHkgcG9pbnQuDQo+IA0KPiBUaGFua3MgYSBsb3QsDQo+
IERhbmllbA0K
