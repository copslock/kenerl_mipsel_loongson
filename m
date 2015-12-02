Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2015 17:22:19 +0100 (CET)
Received: from smtp-out6.electric.net ([192.162.217.183]:58386 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012198AbbLBQWRk8yse (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Dec 2015 17:22:17 +0100
Received: from 1a4AAR-00056I-VU by out6c.electric.net with emc1-ok (Exim 4.85)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1a4AAT-0005In-Vy; Wed, 02 Dec 2015 08:22:09 -0800
Received: by emcmailer; Wed, 02 Dec 2015 08:22:09 -0800
Received: from [213.249.233.130] (helo=AcuExch.aculab.com)
        by out6c.electric.net with esmtps (TLSv1:AES128-SHA:128)
        (Exim 4.85)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1a4AAR-00056I-VU; Wed, 02 Dec 2015 08:22:07 -0800
Received: from ACUEXCH.Aculab.com ([::1]) by AcuExch.aculab.com ([::1]) with
 mapi id 14.03.0123.003; Wed, 2 Dec 2015 16:20:42 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'yalin wang' <yalin.wang2010@gmail.com>,
        Petr Mladek <pmladek@suse.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>,
        "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 5/5] printk/nmi: Increase the size of the temporary
 buffer
Thread-Topic: [PATCH v2 5/5] printk/nmi: Increase the size of the temporary
 buffer
Thread-Index: AQHRLMHRY5g5WKb0eUmhIi5CGO67i563383w
Date:   Wed, 2 Dec 2015 16:20:41 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CBE1231@AcuExch.aculab.com>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-6-git-send-email-pmladek@suse.com>
 <81211733-2484-40A9-9D4A-644AA27FBC73@gmail.com>
In-Reply-To: <81211733-2484-40A9-9D4A-644AA27FBC73@gmail.com>
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
X-archive-position: 50291
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

RnJvbTogeWFsaW4gd2FuZw0KPiBTZW50OiAzMCBOb3ZlbWJlciAyMDE1IDE2OjQyDQo+ID4gT24g
Tm92IDI3LCAyMDE1LCBhdCAxOTowOSwgUGV0ciBNbGFkZWsgPHBtbGFkZWtAc3VzZS5jb20+IHdy
b3RlOg0KPiA+DQo+ID4gVGVzdGluZyBoYXMgc2hvd24gdGhhdCB0aGUgYmFja3RyYWNlIHNvbWV0
aW1lcyBkb2VzIG5vdCBmaXQNCj4gPiBpbnRvIHRoZSA0a0IgdGVtcG9yYXJ5IGJ1ZmZlciB0aGF0
IGlzIHVzZWQgaW4gTk1JIGNvbnRleHQuDQo+ID4NCj4gPiBUaGUgd2FybmluZ3MgYXJlIGdvbmUg
d2hlbiBJIGRvdWJsZSB0aGUgdGVtcG9yYXJ5IGJ1ZmZlciBzaXplLg0KDQpZb3UgYXJlIHdhc3Rp
bmcgYSBsb3Qgb2YgbWVtb3J5IGZvciBzb21ldGhpbmcgdGhhdCBpcyBpbmZyZXF1ZW50bHkgdXNl
ZC4NClRoZXJlIG91Z2h0IHRvIGJlIHNvbWUgd2F5IG9mIGNvcHlpbmcgcGFydGlhbCB0cmFjZWJh
Y2tzIGludG8gdGhlDQptYWluIGJ1ZmZlci4NCg0KCURhdmlkDQoNCg==
