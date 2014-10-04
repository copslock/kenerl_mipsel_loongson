Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Oct 2014 17:33:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28499 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010069AbaJDPdrH-L3f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Oct 2014 17:33:47 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3DE3B46B6249F;
        Sat,  4 Oct 2014 16:33:37 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Sat, 4 Oct
 2014 16:33:39 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by klmail02.kl.imgtec.org
 (10.40.60.222) with Microsoft SMTP Server (TLS) id 14.3.195.1; Sat, 4 Oct
 2014 16:33:39 +0100
Received: from BADAG02.ba.imgtec.org ([fe80::612d:e977:c603:32d6]) by
 bamail02.ba.imgtec.org ([::1]) with mapi id 14.03.0174.001; Sat, 4 Oct 2014
 08:33:37 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Zubair Kakakhel <Zubair.Kakakhel@imgtec.com>,
        "david.daney@cavium.com" <david.daney@cavium.com>,
        "paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>,
        "davidlohr@hp.com" <davidlohr@hp.com>,
        "macro@linux-mips.org" <macro@linux-mips.org>,
        "chenhc@lemote.com" <chenhc@lemote.com>,
        "zajec5@gmail.com" <zajec5@gmail.com>,
        James Hogan <James.Hogan@imgtec.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "alex@alex-smith.me.uk" <alex@alex-smith.me.uk>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "blogic@openwrt.org" <blogic@openwrt.org>,
        "jchandra@broadcom.com" <jchandra@broadcom.com>,
        Paul Burton <Paul.Burton@imgtec.com>,
        Qais Yousef <Qais.Yousef@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        "manuel.lauss@gmail.com" <manuel.lauss@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "lars.persson@axis.com" <lars.persson@axis.com>
Subject: Re: [PATCH 0/3] MIPS executable stack protection
Thread-Topic: [PATCH 0/3] MIPS executable stack protection
Thread-Index: Ac/f6JBasxw0os/VaEewjedDoGfZbg==
Date:   Sat, 4 Oct 2014 15:33:36 +0000
Message-ID: <tg3ek4qtursbob5wootj8r09.1412436788097@email.android.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC282DA7E8B50048996C8C67EAC32EE2@imgtec.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

UGV0ZXIgWmlqbHN0cmEgd3JvdGU6Cgo+PiBJdCBzZXRzIHVwIGEgcGVyLXRocmVhZCAnVkRTTycg
cGFnZSBhbmQgYXBwcm9wcmlhdGUgVExCIHN1cHBvcnQuCgo+IFNvIHRyYWRpdGlvbmFsbHkgd2Un
dmUgYWx3YXlzIGF2b2lkZWQgcGVyLXRocmVhZCBwYWdlcyBsaWtlIHRoYXQuCj4gV2hhdCBtYWtl
cyBpdCB3b3J0aCBpdCBvbiBNSVBTPwoKTUlQUyBoYXMgYnJhbmNoIGRlbGF5IHNsb3RzIC0gaXQg
aXMgYW4gaW5zdHJ1Y3Rpb24gYWZ0ZXIgYnJhbmNoIHdoaWNoIGlzIGV4ZWN1dGVkCmJlZm9yZSBi
cmFuY2ggaXMgdGFrZW4uIElmIGJyYW5jaCBmYWlscyBkdWUgdG8gRlBVIHVuYXZhaWxhYmlsaXR5
IHRoZW4gdGhhdAppbnN0cnVjdGlvbiBzaG91bGQgYmUgZW11bGF0ZWQgYXMgd2VsbCBhcyBicmFu
Y2ggaXRzZWxmLgpIb3dldmVyLCBNSVBTIGFsbG93cyB0byBoYXZlIGEgY3VzdG9taXNhYmxlIGNv
cHJvY2Vzc29yIDIgaW5zdHJ1Y3Rpb25zCmFuZCBpdCBpcyBpbXByYWN0aWNhbCB0byBlbXVsYXRl
IGl0IGFuZCBiaWcgYW1vdW50IG9mIG90aGVyIHRyYWRpdGlvbmFsIE1JUFMKaW5zdHJ1Y3Rpb25z
IGluc2lkZSBvZiBrZXJuZWwuCgpTbywgc29tZSBwZXIgdGhyZWFkIHNwYWNlIGlzIG5lZWRlZCB0
byBwdXQgaW5zdHJ1Y3Rpb24gaW50byBpdCwgZW5jbG9zZSBpdCB3aXRoCmEgcmV0dXJuIGtlcm5l
bCBjYWxsIGFuZCBzd2l0Y2ggdGVtcG9yYXJ5IGV4ZWN1dGlvbiBpbnRvIGl0LgoKQ3VycmVudGx5
LCB0aGlzIHNwYWNlIGlzIHNwYWNlIGF0IFNQIHJlZ2lzdGVyICh1c2VyIHN0YWNrKSBidXQgaXQg
cHJldmVudHMKc3dpdGNoaW5nIHN0YWNrIGFzIG5vbi1leGVjdXRhYmxlLgoKSGFuZGxlIGFub3Ro
ZXIgc3RhY2sgc2V0IChvbmUgc3RhY2sgcGVyIHRocmVhZCkgaW4gY29tbW9uIHVzZXIgbWFwIGlz
CmltcHJhY3RpY2FsIGJlY2F1c2Ugb2YgbWFuYWdlbWVudCwgc2NhbGFiaWxpdHkgYW5kIHBlcmZv
cm1hbmNlIGRpZmZpY3VsdGllcy4K
