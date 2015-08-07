Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2015 03:38:57 +0200 (CEST)
Received: from mail4.hitachi.co.jp ([133.145.228.5]:38417 "EHLO
        mail4.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013016AbbHGBiyhDGwM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Aug 2015 03:38:54 +0200
Received: from mlsv2.hitachi.co.jp (unknown [133.144.234.166])
        by mail4.hitachi.co.jp (Postfix) with ESMTP id 0159E2CF4C4;
        Fri,  7 Aug 2015 10:38:51 +0900 (JST)
Received: from mfilter06.hitachi.co.jp by mlsv2.hitachi.co.jp (8.13.1/8.13.1) id t771co2s024471; Fri, 7 Aug 2015 10:38:50 +0900
Received: from vshuts04.hitachi.co.jp (vshuts04.hitachi.co.jp [10.201.6.86])
        by mfilter06.hitachi.co.jp (Switch-3.3.4/Switch-3.3.4) with ESMTP id t771cnJY008006;
        Fri, 7 Aug 2015 10:38:50 +0900
Received: from GSjpTKYDCehcs31.service.hitachi.net (unknown [158.212.188.195])
        by vshuts04.hitachi.co.jp (Postfix) with ESMTP id 3DAA2140054;
        Fri,  7 Aug 2015 10:38:49 +0900 (JST)
Received: from GSJPTKYDCEMBX31.service.hitachi.net ([169.254.4.60]) by
 GSjpTKYDCehcs31.service.hitachi.net ([158.212.188.195]) with mapi id
 14.03.0224.002; Fri, 7 Aug 2015 10:38:48 +0900
From:   =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?= 
        <hidehiro.kawai.ez@hitachi.com>
To:     "'Eric W. Biederman'" <ebiederm@xmission.com>
CC:     Vivek Goyal <vgoyal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Baoquan He <bhe@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "HATAYAMA Daisuke" <d.hatayama@jp.fujitsu.com>,
        =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= 
        <masami.hiramatsu.pt@hitachi.com>,
        Daniel Walker <dwalker@fifo99.com>,
        "Ingo Molnar" <mingo@kernel.org>
Subject: RE: [RFC V2 PATCH 0/1] kexec: crash_kexec_post_notifiers boot
 option related fixes
Thread-Topic: [RFC V2 PATCH 0/1] kexec: crash_kexec_post_notifiers boot
 option related fixes
Thread-Index: AQHQz6GTDND7njYftUe3fB3L5gctF53/t8oA
Date:   Fri, 7 Aug 2015 01:38:48 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A8445492BE70@GSjpTKYDCembx31.service.hitachi.net>
References: <20150724011615.6834.79628.stgit@softrs>
        <55BF4B1F.9000602@hitachi.com> <877fpcfi2j.fsf@x220.int.ebiederm.org>
        <04EAB7311EE43145B2D3536183D1A84454926993@GSjpTKYDCembx31.service.hitachi.net>
 <87io8tvez5.fsf@x220.int.ebiederm.org>
In-Reply-To: <87io8tvez5.fsf@x220.int.ebiederm.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.198.220.34]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <hidehiro.kawai.ez@hitachi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48699
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

PiBGcm9tOiBFcmljIFcuIEJpZWRlcm1hbiBbbWFpbHRvOmViaWVkZXJtQHhtaXNzaW9uLmNvbV0N
Cj4gPj4gRnJvbTogRXJpYyBXLiBCaWVkZXJtYW4gW21haWx0bzplYmllZGVybUB4bWlzc2lvbi5j
b21dDQo+ID4gWy4uLl0NCj4gPj4gQSBzcGVjaWZpYyBob29rIGZvciBhIHZlcnkgc3BlY2lmaWMg
cHVycG9zZSB3aGVuIHRoZXJlIGlzIG5vIG90aGVyIHdheQ0KPiA+PiB3ZSBjYW4gY29uc2lkZXIu
DQo+ID4NCj4gPiBTbywgaXMga21zZ19kdW1wIGxpa2UgZmVhdHVyZSBhZG1pc3NpYmxlPw0KPiA+
DQo+ID4+IElmIHlvdSBkb24ndCBoYXZlIHNvbWV0aGluZyB0aGF0IGdlbmVyYWxpc2VzIHdlbGwg
aW50byBhIGdlbmVyYWwgcHVycG9zZQ0KPiA+PiBvcGVyYXRpb24gdGhhdCBpdCBtYWtlcyBzZW5z
ZSBmb3IgZXZlcnlvbmUgdG8gY2FsbCB5b3UgY2FuIGFsd2F5cyB1c2UNCj4gPj4gdGhlIHdvcmxk
J3MgbGFyZ2VzdCBha2EgeW91IGNhbiBydW4gY29kZSBiZWZvcmUgdGhlIG5ldyBrZXJuZWwgc3Rh
cnRzDQo+ID4+IHRoYXQgaXMgbG9hZGVkIHdpdGgga2V4ZWNfbG9hZC4NCj4gPg0KPiA+IE9uZSBv
ZiBvdXIgcHVycG9zZXMsIG5vdGlmeWluZyAiSSdtIGR5aW5nIiwgd291bGQgYmUgYWNoaWV2ZWQg
YnkgcHVyZ2F0b3J5DQo+ID4gY29kZSBwcm92aWRlZCBieSBrZXhlYyBjb21tYW5kIGFzIEkgc3Rh
dGVkIGJlZm9yZS4gIFNpbmNlIHRoZSB3YXkgb2YgdGhlDQo+ID4gbm90aWZpY2F0aW9uIHdpbGwg
ZGlmZmVyIGZyb20gZWFjaCB2ZW5kb3IsIEkgdGhpbmsgd2UgbmVlZCB0byBtb2RpZnkNCj4gPiB0
aGUgcHVyZ2F0b3J5IGNvZGVzIHBsdWdnYWJsZS4gIEFsc28sIEkgdGhpbmsgd2UgbmVlZCBzb21l
IHBhcmFtZXRlcg0KPiA+IHBhc3NpbmcgbWVjaGFuaXNtIHRvIHRoZSBwdXJnYXRvcnkgY29kZS4g
IEZvciBleGFtcGxlLCBwYXNzaW5nIHRoZSBwYW5pYw0KPiA+IG1lc3NhZ2UgdmlhIGJvb3QgcGFy
YW1ldGVyIHRvIHNhdmUgaXQgdG8gU0VMLiAgQWx0aG91Z2ggSSdtIG5vdCBzdXJlDQo+ID4gd2Ug
Y2FuIGRvIHRoYXQgKEkndmUgbm90IGludmVzdGlnYXRlZCB3ZWxsIHlldCkuICBJcyB0aGF0IGFj
Y2VwdGFibGU/DQo+IA0KPiBJIHRoaW5rIHRoZSBhZGRyZXNzIG9mIHBhbmljIG1lc3NhZ2UgaXMg
YXZhaWxhYmxlIGluIGNyYXNoIG5vdGVzLiAgSWYNCj4gbm90IHRoYXQgaXMgdmVyeSByZWFzb25h
YmxlIHRvIGFkZC4NCg0KSSBiZWxpZXZlZCB0aGUgYm9vdCBwYXJhbWV0ZXIgaXMgcHJlcGFyZWQg
YnkgdGhlIDFzdCBrZXJuZWwsIGJ1dA0KaXQncyB3cm9uZy4gIFRoZSBib290IHBhcmFtZXRlciBp
cyBjb21wbGV0ZWx5IHByb3ZpZWRlZCBrZXhlYyBjb21tYW5kLg0KU28sIHBhc3NpbmcgdGhlIHBh
bmljIG1lc3NhZ2UgdGhyb3VnaCBib290IHBhcmFtZXRlciB3aWxsIG5vdA0KYmUgZmVhc2libGUu
ICBJJ20gbm90IHN1cmUgd2UgY2FuIGVhc2lseSBhY2Nlc3MgdG8gdGhlIGNyYXNoIG5vdGVzDQpm
cm9tIHB1cmdhdG9yeSwgYnV0IEkgdGhpbmsgaXQncyBhIHJlYXNvbmFibGUgd2F5IHRvIHBhc3Mg
cGFuaWMgbWVzc2FnZS4NCg0KPiBVcGRhdGluZyB0aGUgU0VMIGZyb20gcHVyZ2F0b3J5IGFmdGVy
IHB1cmdhdG9yeSBoYXMgdmFsaWRhdGVkIHRoZQ0KPiBjaGVja3N1bXMgb2YgdGhlIGNyYXNoIGhh
bmRsaW5nIGNvZGUgaXMgYWNjZXB0YWJsZS4NCj4gDQo+IEFsbCB0aGF0IGlzIGRlc2lyZWQgaXMg
dG8gcnVuIGFzIGxpdHRsZSBjb2RlIGFzIHBvc3NpYmxlIGluIGEga2VybmVsDQo+IHRoYXQgaXMg
a25vd24gYnJva2VuLiAgT25jZSB0aGUgY2hlY2tzdW1zIGhhdmUgdmVyaWZpZWQgdGhpbmdzIGlu
DQo+IHB1cmdhdG9yeSB5b3Ugc2hvdWxkIGJlIGluIGdvb2Qgc2hhcGUsIGFuZCB0aGVyZSBpcyBu
byBwb3NzaWJpbGl0eSBvZg0KPiByZWx5aW5nIG9uIGJyb2tlbiBpbmZyYXN0cnVjdHVyZSBiZWNh
dXNlIHRoYXQgY29kZSBzaW1wbHkgaXMgbm90IHByZXNlbnQNCj4gaW4gcHVyZ2F0b3J5Lg0KPiAN
Cj4gV2UgYWxyZWFkeSBoYXZlIGEgZmV3IGVhcmx5X3ByaW50ayBzdHlsZSBkcml2ZXJzIGluIHB1
cmdhdG9yeSBhbmQgSQ0KPiBkb24ndCB0aGUgY29kZSB0byB1cGRhdGUgdGhlIFNFTCB3b3VsZCBi
ZSBtdWNoIHdvcnNlLg0KDQpGb3IgZGV2ZWxvcGVycywgZWFybHlfcHJpbnRrIHN0eWxlIGZlYXR1
cmUgd2lsbCBiZSBiZXR0ZXIgc29sdXRpb24uDQpGb3IgZW5kIHVzZXJzLCBob3dldmVyLCBpdCB3
aWxsIG5vdCBiZSB0cnVlLiAgU29tZXRpbWVzIHRoZXkgY2Fubm90DQp1c2UgYSBzZXJpYWwgcG9y
dCBmb3IgZWFybHlfcHJpbnRrIGJlY2F1c2UgdGhlIHNlcmlhbCBwb3J0IGlzIHVzZWQNCmZvciBv
dGhlciBwdXJwb3NlLiAgU29tZXRpbWVzIHRoZXkgY2Fubm90IHBsYWNlIGFkZGl0aW9uYWwgbWFj
aGluZQ0Kd2hpY2ggcmVjZWl2ZXMgbWVzc2FnZXMgZnJvbSB0aGUgc2VyaWFsIHBvcnQuICBTbyB3
ZSBuZWVkIHNvbWUNCnBsdWdpbiBvciBlbmFibGUvZGlzYWJsZSBtZWNoYW5pc20gZm9yIHNwZWNp
ZmljIHB1cmdhdG9yeSBjb2RlLg0KDQo+IE9uIHRoZSBmbGlwIHNpZGUgdGhlcmUgYXJlIGVub3Vn
aCBmaXJtd2FyZSBidWdzIHRoYXQgSSBwZXJzb25hbGx5IHdvdWxkDQo+IG5vdCB3YW50IHRvIHJl
bHkgb24gZmlybXdhcmUgY29kZSBydW5uaW5nIHByb3Blcmx5IHdoZW4gdGhlIG1hY2hpbmUgaXMN
Cj4gaW4gYSBrbm93biBicm9rZW4gc3RhdGUsIHNvIEkgZG9uJ3Qgd2FudCB0aGUgU0VMIHVwZGF0
ZSB0byBiZQ0KPiB1bmNvbmRpdGlvbmFsLg0KDQpZZXMsIEkgZG9uJ3QgYWxzbyB0cnVzdCBCTUMg
ZmlybXdhcmUuICBUaGUgbW9zdCBzaW1wbGUgSS9GIHRvIEJNQw0KaXMgS0NTIChLZXlib2FyZCBD
b250cm9sbGVyIFN0eWxlKSBJL0Ygd2hpY2ggaXMgYWNjZXNzaWJsZSB2aWENCnR3byBJL08gcG9y
dHMuICBJZiBCTUMgYmVjb21lcyBpbnNhbmUsIHRoZSBzdGF0ZSBtYWNoaW5lIGZvciB0aGUgSS9G
DQpjYW4gZ28gaW50byBpbmZpbml0ZSBsb29wLiAgSG93ZXZlciwgd2UgY2FuIGF2b2lkIHRoaXMg
YnkgaW50cm9kdWNpbmcNCnByb3BlciB0aW1lb3V0LiAgT2YgY291cnNlLCBJIHRoaW5rIHdlIHNo
b3VsZCBhZGQgc29tZSBlbmFibGUvZGlzYWJsZQ0KbWVjaGFuaXNtLg0KDQoNClJlZ2FyZHMsDQpL
YXdhaQ0KDQo=
