Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2015 16:50:22 +0100 (CET)
Received: from smtp-out6.electric.net ([192.162.217.187]:51948 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011740AbbLGPuVTCEs4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Dec 2015 16:50:21 +0100
Received: from 1a5y3N-00068e-TG by out6a.electric.net with emc1-ok (Exim 4.85)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1a5y3O-0006D0-VM; Mon, 07 Dec 2015 07:50:18 -0800
Received: by emcmailer; Mon, 07 Dec 2015 07:50:18 -0800
Received: from [213.249.233.130] (helo=AcuExch.aculab.com)
        by out6a.electric.net with esmtps (TLSv1:AES128-SHA:128)
        (Exim 4.85)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1a5y3N-00068e-TG; Mon, 07 Dec 2015 07:50:17 -0800
Received: from ACUEXCH.Aculab.com ([::1]) by AcuExch.aculab.com ([::1]) with
 mapi id 14.03.0123.003; Mon, 7 Dec 2015 15:48:34 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Russell King - ARM Linux' <linux@arm.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>,
        "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 3/5] printk/nmi: Try hard to print Oops message in
 NMI context
Thread-Topic: [PATCH v2 3/5] printk/nmi: Try hard to print Oops message in
 NMI context
Thread-Index: AQHRLqgubPKrTfv+iUmzuwEnAJAPAp67ELeAgASapLA=
Date:   Mon, 7 Dec 2015 15:48:33 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CBE68C7@AcuExch.aculab.com>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-4-git-send-email-pmladek@suse.com>
 <20151201234437.GA8644@n2100.arm.linux.org.uk>
 <20151204152709.GA20935@pathway.suse.cz>
 <20151204171255.GZ8644@n2100.arm.linux.org.uk>
In-Reply-To: <20151204171255.GZ8644@n2100.arm.linux.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.99.200]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Outbound-IP: 213.249.233.130
X-Env-From: David.Laight@ACULAB.COM
X-PolicySMART: 3396946, 3397078
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (s)
Return-Path: <David.Laight@ACULAB.COM>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: David.Laight@ACULAB.COM
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

RnJvbTogUnVzc2VsbCBLaW5nIC0gQVJNIExpbnV4DQo+IFNlbnQ6IDA0IERlY2VtYmVyIDIwMTUg
MTc6MTMNCi4uLg0KPiBJIGhhdmUgYSBzbGlnaHRseSBkaWZmZXJlbnQgdmlldy4uLg0KPiANCj4g
PiA+IEkgZG9uJ3Qgc2VlIGJ1c3Rfc3BpbmxvY2tzKCkgZGVhbGluZyB3aXRoIGFueSBvZiB0aGVz
ZSBsb2Nrcywgc28gSU1ITw0KPiA+ID4gdHJ5aW5nIHRvIG1ha2UgdGhpcyB3b3JrIGluIE5NSSBj
b250ZXh0IHN0cmlrZXMgbWUgYXMgbWFraW5nIHRoZQ0KPiA+ID4gZXhpc3Rpbmcgc29sdXRpb24g
bW9yZSB1bnJlbGlhYmxlIG9uIEFSTSBzeXN0ZW1zLg0KPiA+DQo+ID4gYnVzdF9zcGlubG9ja3Mo
KSBjYWxscyBwcmludGtfbm1pX2ZsdXNoKCkgdGhhdCB3b3VsZCBjYWxsIHByaW50aygpDQo+ID4g
dGhhdCB3b3VsZCB6YXAgImxvY2tidWZfbG9jayIgYW5kICJjb25zb2xlX3NlbSIgd2hlbiBpbiBP
b3BzIGFuZCBOTUkuDQo+ID4gWWVzLCB0aGVyZSBtaWdodCBiZSBtb3JlIGxvY2tzIGJsb2NrZWQg
YnV0IHdlIHRyeSB0byBicmVhayBhdCBsZWFzdA0KPiA+IHRoZSBmaXJzdCB0d28gd2FsbHMuIEFs
c28gemFwcGluZyBpcyBhbGxvd2VkIG9ubHkgb25jZSBwZXIgMzAgc2Vjb25kcywNCj4gPiBzZWUg
emFwX2xvY2tzKCkuIFdoeSBkbyB5b3UgdGhpbmsgdGhhdCBpdCBtaWdodCBtYWtlIHRoaW5ncyBt
b3JlDQo+ID4gdW5yZWxpYWJsZSwgcGxlYXNlPw0KPiANCj4gVGFrZSB0aGUgc2NlbmFyaW8gd2hl
cmUgQ1BVMSBpcyBpbiB0aGUgbWlkZGxlIG9mIGEgcHJpbnRrKCksIGFuZCBpcw0KPiBob2xkaW5n
IGl0cyBsb2NrLg0KPiANCj4gQ1BVMCBjb21lcyBhbG9uZyBhbmQgZGVjaWRlcyB0byB0cmlnZ2Vy
IGEgTk1JIGJhY2t0cmFjZS4gIFRoaXMgc2VuZHMNCj4gYSBOTUkgdG8gQ1BVMSwgd2hpY2ggdGFr
ZXMgaXQgaW4gdGhlIG1pZGRsZSBvZiB0aGUgc2VyaWFsIGNvbnNvbGUNCj4gb3V0cHV0Lg0KPiAN
Cj4gV2l0aCB0aGUgZXhpc3Rpbmcgc29sdXRpb24sIHRoZSBOTUkgb3V0cHV0IHdpbGwgYmUgd3Jp
dHRlbiB0byB0aGUNCj4gdGVtcG9yYXJ5IGJ1ZmZlciwgYW5kIENQVTEgaGFzIGZpbmlzaGVkIGhh
bmRsaW5nIHRoZSBOTUkgaXQgcmVzdW1lcw0KPiB0aGUgc2VyaWFsIGNvbnNvbGUgb3V0cHV0LCBl
dmVudHVhbGx5IGRyb3BwaW5nIHRoZSBsb2NrLiAgVGhhdCB0aGVuDQo+IGFsbG93cyBDUFUwIHRv
IHByaW50IHRoZSBjb250ZW50cyBvZiBhbGwgYnVmZmVycywgYW5kIHdlIGdldCBOTUkNCj4gcHJp
bnRrIG91dHB1dC4NCg0KSXMgdGhlIHRyYWNlYmFjayBmcm9tIGluc2lkZSBwcmludGsoKSBvciBz
ZXJpYWwgY29uc29sZSBjb2RlDQpsaWtlbHkgdG8gYmUgdXNlZnVsPw0KSWYgbm90IHRoZW4gd2h5
IG5vdCBnZXQgdGhlIHN0YWNrdHJhY2UgZ2VuZXJhdGVkIHdoZW4gdGhlIHJlbGV2YW50DQpsb2Nr
IGlzIHJlbGVhc2VkPw0KVGhhdCBzaG91bGQgc2F2ZSBhbnkgZmFmZmluZyB3aXRoIGEgc3BlY2lh
bCBidWZmZXIuDQoNCglEYXZpZA0KDQo=
