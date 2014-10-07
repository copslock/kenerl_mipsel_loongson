Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 21:40:36 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45996 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010752AbaJGTkf2exOn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 21:40:35 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id BCBA8825345B8;
        Tue,  7 Oct 2014 20:40:24 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 7 Oct 2014 20:40:28 +0100
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0195.001; Tue, 7 Oct 2014 20:40:27 +0100
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Andy Lutomirski <luto@amacapital.net>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     David Daney <david.s.daney@gmail.com>,
        Rich Felker <dalias@libc.org>,
        David Daney <ddaney@caviumnetworks.com>,
        David Daney <ddaney.cavm@gmail.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Subject: RE: [PATCH resend] MIPS: Allow FPU emulator to use non-stack area.
Thread-Topic: [PATCH resend] MIPS: Allow FPU emulator to use non-stack area.
Thread-Index: AQHP4aN00Rru6iu58k+v+yCGGiYzx5wje4qAgAAGhYCAAAOMgIAABAuAgAADj4CAABvzgIAAAvcAgAAEkwCAAAfXAIAABHWAgABDfICAAFdDkIAAjnQAgAADP4CAAB08wA==
Date:   Tue, 7 Oct 2014 19:40:27 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B0235320F1EBEE@LEMAIL01.le.imgtec.org>
References: <1412627010-4311-1-git-send-email-ddaney.cavm@gmail.com>
 <20141006205459.GZ23797@brightrain.aerifal.cx>
 <5433071B.4050606@caviumnetworks.com>
 <20141006213101.GA23797@brightrain.aerifal.cx>
 <54330D79.80102@caviumnetworks.com>
 <20141006215813.GB23797@brightrain.aerifal.cx>
 <543327E7.4020608@amacapital.net> <54332A64.5020605@caviumnetworks.com>
 <20141007000514.GD23797@brightrain.aerifal.cx>
 <543334CE.8060305@caviumnetworks.com>
 <20141007004915.GF23797@brightrain.aerifal.cx> <54337127.40806@gmail.com>
 <6D39441BF12EF246A7ABCE6654B0235320F1E173@LEMAIL01.le.imgtec.org>
 <543431DA.4090809@imgtec.com>
 <CALCETrUQEbb=DotSzsneN7Hano_eC-EoTMko6uKcyZXvEcktkw@mail.gmail.com>
In-Reply-To: <CALCETrUQEbb=DotSzsneN7Hano_eC-EoTMko6uKcyZXvEcktkw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.159.206]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <Matthew.Fortune@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43093
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

PiA+DQo+ID4gNCkgIFRoZSB2b2ljZSBmb3IgZG9pbmcgYW55IGluc3RydWN0aW9uIGVtdWxhdGlv
biBpbiBrZXJuZWwgLSBpdCBpcyBub3QgYQ0KPiA+IE1JUFMgYnVzaW5lc3MgbW9kZWwgdG8gZm9y
Y2UgY3VzdG9tZXIgdG8gcHV0IGRldGFpbHMgb2YgYWxsIENvcHJvY2Vzc29yIDINCj4gPiBpbnN0
cnVjdGlvbnMgcHVibGljLiBXZSBwcm92aWRlIGFuIGludGVyZmFjZSBhbmQgdGhlIHJlc3QgaXMg
YSBjdXN0b21lcg0KPiA+IGJ1c2luZXNzLiBCZXNpZGVzIHRoYXQgaXQgaXMgcmVhbGx5IHBhaW5m
dWwgdG8gbWFrZSBhIGRpZmZlcmVudGlhdGlvbg0KPiA+IGJldHdlZW4gQ2F2aXVtIE9jdGVvbiBh
bmQgc29tZSBhbm90aGVyIENQVSBpbnN0cnVjdGlvbnMgd2l0aCB0aGUgc2FtZQ0KPiA+IG9wY29k
ZS4gT24gb3RoZXIgc2lkZSwgbGVhdmluZyBlbXVsYXRpb24gb2YgdGhlaXIgaW5zdHJ1Y3Rpb25z
IHRvIHRoZW0gaXMNCj4gPiBub3QgYSB3aXNlIGFmdGVyIGhhdmluZyBzb21lIGdvb2Qgd2F5IGRv
aW5nIHRoYXQgbXVsdGlwbGUgeWVhcnMuDQo+IA0KPiBJTU8gdGhpcyBpcyBhbGwgYmFja3dhcmRz
LiAgSWYgTUlQUyBjdXN0b21lcnMgcHV0IHByb3ByaWV0YXJ5DQo+IGluc3RydWN0aW9ucyBpbnRv
IHRoZWlyIElTQSwgdGhleSBsZWF2ZSBvdXQgdGhlIEZQVSwgYW5kIHRoZXkgcHV0IGENCj4gcHJv
cHJpZXRhcnkgaW5zbiBpbiBhIGJyYW5jaCBkZWxheSBzbG90LCB0aGVuIEkgdGhpbmsgdGhhdCB0
aGV5DQo+IGRlc2VydmUgYSBmYXRhbCBzaWduYWwuDQo+IA0KPiBUaGVyZSdzIGEgcmVhbGx5IGVh
c3kgc29sdXRpb24gZm9yIG5ldyBzeXN0ZW1zOiBmaXggdGhlIHRvb2xjaGFpbi4NCj4gVGVhY2gg
dGhlIGFzc2VtYmxlciB0byBkaXNhbGxvdyBhbnkgcHJvcHJpZXRhcnkgaW5zdHJ1Y3Rpb25zIGlu
IGFuIEZQDQo+IGJyYW5jaCBkZWxheSBzbG90Lg0KDQpJIHRoaW5rIEknZCBiZSBtb3N0bHkgaW4g
ZmF2b3VyIG9mIHRoaXMgZnJvbSBhIHRvb2xjaGFpbiBwZXJzcGVjdGl2ZSBidXQNCm9ubHkgZnJv
bSB0aGUgcGVyc3BlY3RpdmUgb2YgRlAgYnJhbmNoIGluc3RydWN0aW9ucy4gVGhpcyBzdGlsbCBs
ZWF2ZXMgYQ0KcHJvYmxlbSBmb3Igbm9ybWFsIGJyYW5jaGVzIHNob3VsZCBhbnkgb2YgdGhlbSBn
ZXQgcmVtb3ZlZCBhbmQgbmVlZCBlbXVsYXRpbmcuDQpUaGUgZ2VuZXJhbCBmb3JtIG9mIGJsdHph
bCBhbmQgYmdlemFsIHdvdWxkIGJlIHRoZSBleGFtcGxlIGhlcmUgb2YgYnJhbmNoZXMNCndoaWNo
IGFyZSByZW1vdmVkIGluIFI2IChUaGUgc3BlY2lhbCBjYXNlIG9mIHVzaW5nICQwIHJlbWFpbnMp
LiBUaGlzIGlzDQpyZWFsbHkgbmljaGUgYnV0IG15IHBvaW50IGlzIG1vcmUgYWJvdXQgaG93IHdl
IHdvdWxkIGRlYWwgd2l0aCBzdWNoIGEgdGhpbmcNCmlmIGl0IGhhcHBlbmVkLiBUaGUgYW5zd2Vy
IG1heSBiZSBqdXN0IHRvIHNjcmVhbSBhbmQgc2hvdXQgYW5kIGRpc2NvdXJhZ2UgdGhlDQpyZW1v
dmFsIG9mIHN1Y2ggaW5zdHJ1Y3Rpb25zIGZyb20gdGhlIGFyY2hpdGVjdHVyZS4NCg0KTWF0dGhl
dw0KDQo=
