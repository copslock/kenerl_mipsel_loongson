Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Sep 2015 15:07:44 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13008 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008761AbbI1NHnFkT8Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Sep 2015 15:07:43 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3B0A72F505AAE;
        Mon, 28 Sep 2015 14:07:35 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 28 Sep 2015 14:07:37 +0100
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0210.002; Mon, 28 Sep 2015 14:07:36 +0100
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Alex Smith <alex@alex-smith.me.uk>,
        Markos Chandras <Markos.Chandras@imgtec.com>
CC:     linux-mips <linux-mips@linux-mips.org>,
        Alex Smith <Alex.Smith@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] MIPS: Initial implementation of a VDSO
Thread-Topic: [PATCH 1/3] MIPS: Initial implementation of a VDSO
Thread-Index: AQHQ+dXhKXZqE/aOPUW9WE2ADuYAwZ5Rs5cAgAA0gAA=
Date:   Mon, 28 Sep 2015 13:07:36 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B023532128FCAD@LEMAIL01.le.imgtec.org>
References: <1443434629-14325-1-git-send-email-markos.chandras@imgtec.com>
        <1443435011-17061-1-git-send-email-markos.chandras@imgtec.com>
 <CAOFt0_ANW6uHVU4+bTP8=oXJ8OjsEiuFPkz3GCcTZFLHs5xo4A@mail.gmail.com>
In-Reply-To: <CAOFt0_ANW6uHVU4+bTP8=oXJ8OjsEiuFPkz3GCcTZFLHs5xo4A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.150.80.3]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <Matthew.Fortune@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49387
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

QWxleCBTbWl0aCA8YWxleEBhbGV4LXNtaXRoLm1lLnVrPiB3cml0ZXM6DQo+ID4gKw0KPiA+ICsg
ICAgICAgLyogbGFwYyA8c3ltYm9sPiBpcyBhbiBhbGlhcyB0byBhZGRpdXBjIHJlZywgPHN5bWJv
bD4gLSAuDQo+ID4gKyAgICAgICAgKg0KPiA+ICsgICAgICAgICogV2UgY2FuJ3QgdXNlIGFkZGl1
cGMgYmVjYXVzZSB0aGVyZSBpcyBubyBsYWJlbC1sYWJlbA0KPiA+ICsgICAgICAgICogc3VwcG9y
dCBmb3IgdGhlIGFkZGl1cGMgcmVsb2MNCj4gPiArICAgICAgICAqLw0KPiA+ICsgICAgICAgX19h
c21fXygibGFwYyAgICUwLCBfc3RhcnQgICAgICAgICAgICAgICAgICAgICAgXG4iDQo+ID4gKyAg
ICAgICAgICAgICAgIDogIj1yIiAoYWRkcikgOiA6KTsNCj4gDQo+IEp1c3QgY3VyaW91cyAtIGlm
IGxhcGMgaXMganVzdCBhbiBhbGlhcyB0byBhZGRpdXBjLCB3aHkgZG9lcyB0aGF0IHdvcmsNCj4g
YnV0IG5vdCBhZGRpdXBjPyBJSVJDIEkgZGlkIHRyeSBhZGRpdXBjIHByZXZpb3VzbHkgYnV0IHJl
bW92ZWQgaXQNCj4gYmVjYXVzZSBpdCB3YXNuJ3Qgd29ya2luZywgZGlkbid0IGtub3cgYWJvdXQg
bGFwYyENCg0KVGhpcyBpcyBqdXN0IGFuIHVuZm9ydHVuYXRlIHF1aXJrIG9mIGhvdyB0aGUgaW1w
bGVtZW50YXRpb24gaXMgZG9uZSBpbg0KYmludXRpbHMuIFdlIGRvbid0IHJlY29nbmlzZSB0aGUg
c3BlY2lhbCBjYXNlIHRoYXQ6DQoNCmFkZGl1cGMgPHJlZz4sIDxzeW0+IC0gLg0KDQppcyB0aGUg
c2FtZSBhcw0KDQpsYXBjIDxyZWc+LCA8c3ltPg0KDQpBbmQgdGhlcmVmb3JlIGRvbid0IGtub3cg
dGhhdCB3ZSBjYW4ganVzdCB1c2UgdGhlIE1JUFNfUEMxOV9TMiByZWxvYw0KKG5hbWUgb2YgdGhh
dCByZWxvYyBtYXkgbm90IGJlIHBlcmZlY3RseSBjb3JyZWN0KS4gSXQgaXMgYSBzcGVjaWFsDQpj
YXNlIGFzIHRoZSBSSFMgb2YgdGhlIGV4cHJlc3Npb24gaW4gQURESVVQQyBhYm92ZSBjYW4gYmUg
dGhlb3JldGljYWxseQ0KYW55dGhpbmcgc28gd2Ugb25seSBzdXBwb3J0IGFzc2VtYmx5IHRpbWUg
Y29uc3RhbnRzIHdpdGggYWRkaXVwYy4NCg0KQXBhcnQgZnJvbSB0aGUgbmVlZCB0byBkb2N1bWVu
dCB0aGUgTEFQQyBhbGlhcyBzb21ld2hlcmUgSSdtIG5vdCBzdXJlDQp3ZSBuZWVkIGRvIGFueXRo
aW5nIHRvIGltcHJvdmUgYWRkaXVwYyBpdHNlbGYgcGFydGljdWxhcmx5Lg0KDQpUaGFua3MsDQpN
YXR0aGV3DQo=
