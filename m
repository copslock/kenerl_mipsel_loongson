Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Oct 2018 02:04:27 +0200 (CEST)
Received: from mga17.intel.com ([192.55.52.151]:11975 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993973AbeJMAETFHqbH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 13 Oct 2018 02:04:19 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2018 17:04:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,374,1534834800"; 
   d="scan'208";a="98998257"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga001.jf.intel.com with ESMTP; 12 Oct 2018 17:04:15 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 12 Oct 2018 17:04:15 -0700
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.23]) by
 ORSMSX151.amr.corp.intel.com ([169.254.7.31]) with mapi id 14.03.0319.002;
 Fri, 12 Oct 2018 17:04:14 -0700
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "jannh@google.com" <jannh@google.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
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
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] modules: Create rlimit for module space
Thread-Topic: [PATCH v2 1/7] modules: Create rlimit for module space
Thread-Index: AQHUYbu9YVGPZz5pJkS2xS0Q9I41w6UbONMAgAEU74CAAASBAIAAcLMA
Date:   Sat, 13 Oct 2018 00:04:14 +0000
Message-ID: <657e6d0ada18e8ca0350bc6b3a80c49b3c0b341c.camel@intel.com>
References: <20181011233117.7883-1-rick.p.edgecombe@intel.com>
         <20181011233117.7883-2-rick.p.edgecombe@intel.com>
         <CAG48ez2fWg64nGxDXUQS3695KpVNrakAbarXJnYPd6xv5wOD+A@mail.gmail.com>
         <7b0714e26c7c2216721641d7df16a49687927e37.camel@intel.com>
         <CAG48ez0XfGFAWDYa75COMPCsKqqGfBFOtcNuGD4_dubGf2YeAQ@mail.gmail.com>
In-Reply-To: <CAG48ez0XfGFAWDYa75COMPCsKqqGfBFOtcNuGD4_dubGf2YeAQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.168]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6FE45CE01A01A4E863307362D74EA2F@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <rick.p.edgecombe@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66801
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

T24gRnJpLCAyMDE4LTEwLTEyIGF0IDE5OjIyICswMjAwLCBKYW5uIEhvcm4gd3JvdGU6DQo+IE9u
IEZyaSwgT2N0IDEyLCAyMDE4IGF0IDc6MDQgUE0gRWRnZWNvbWJlLCBSaWNrIFANCj4gPHJpY2su
cC5lZGdlY29tYmVAaW50ZWwuY29tPiB3cm90ZToNCj4gPiBPbiBGcmksIDIwMTgtMTAtMTIgYXQg
MDI6MzUgKzAyMDAsIEphbm4gSG9ybiB3cm90ZToNCj4gPiA+IFdoeSBhbGwgdGhlIHJidHJlZSBz
dHVmZiBpbnN0ZWFkIG9mIHN0YXNoaW5nIGEgcG9pbnRlciBpbiBzdHJ1Y3QNCj4gPiA+IHZtYXBf
YXJlYSwgb3Igc29tZXRoaW5nIGxpa2UgdGhhdD8NCj4gPiANCj4gPiBTaW5jZSB0aGUgdHJhY2tp
bmcgd2FzIG5vdCBmb3IgYWxsIHZtYWxsb2MgdXNhZ2UsIHRoZSBpbnRlbnRpb24gd2FzIHRvIG5v
dA0KPiA+IGJsb2F0DQo+ID4gdGhlIHN0cnVjdHVyZSBmb3Igb3RoZXIgdXNhZ2VzIGxpa2VzIHN0
YWNrcy4gSSB0aG91Z2h0IHVzdWFsbHkgdGhlcmUNCj4gPiB3b3VsZG4ndCBiZQ0KPiA+IG5lYXJs
eSBhcyBtdWNoIG1vZHVsZSBzcGFjZSBhbGxvY2F0aW9ucyBhcyB0aGVyZSB3b3VsZCBiZSBrZXJu
ZWwgc3RhY2tzLCBidXQNCj4gPiBJDQo+ID4gZGlkbid0IGRvIGFueSBhY3R1YWwgbWVhc3VyZW1l
bnRzIG9uIHRoZSB0cmFkZW9mZnMuDQo+IA0KPiBJIGltYWdpbmUgdGhhdCBvbmUgZXh0cmEgcG9p
bnRlciBpbiB0aGVyZSAtIHBvaW50aW5nIHRvIHlvdXIgc3RydWN0DQo+IG1vZF9hbGxvY191c2Vy
IC0gd291bGQgcHJvYmFibHkgbm90IGJlIHRlcnJpYmxlLiA4IGJ5dGVzIG1vcmUgcGVyDQo+IGtl
cm5lbCBzdGFjayBzaG91bGRuJ3QgYmUgc28gYmFkPw0KDQpJIGxvb2tlZCBpbnRvIHRoaXMgYW5k
IGl0IHN0YXJ0cyB0byBsb29rIGEgbGl0dGxlIG1lc3N5LiBUaGUgbm9tbXUuYyB2ZXJzaW9uIG9m
DQp2bWFsbG9jIGRvZXNuJ3QgdXNlIG9yIGV4cG9zZSBhY2Nlc3MgdG8gdm1hcF9hcmVhIG9yIHZt
X3N0cnVjdC4gU28gaXQgc3RhcnRzIHRvDQpsb29rIGxpa2UgYSBidW5jaCBvZiBJRkRFRnMgdG8g
cmVtb3ZlIHRoZSBybGltaXQgaW4gdGhlIG5vbW11IGNhc2Ugb3IgbWFraW5nIGENCnN0YW5kIGlu
IHRoYXQgbWFpbnRhaW5zIHByZXRlbmQgdm0gc3RydWN0J3MgaW4gbm9tbXUuYy4gSSBoYWQgYWN0
dWFsbHkNCnByZXZpb3VzbHkgdHJpZWQgdG8gYXQgbGVhc3QgcHVsbCB0aGUgYWxsb2NhdGlvbnMg
c2l6ZSBmcm9tIHZtYWxsb2Mgc3RydWN0cywgYnV0IGl0IGJyb2tlIG9uIG5vbW11Lg0KDQpUaG91
Z2h0IEkgd291bGQgY2hlY2sgYmFjayBhbmQgc2VlLiBIb3cgaW1wb3J0YW50IGRvIHlvdSB0aGlu
ayB0aGlzIGlzPw0KDQoNCg==
