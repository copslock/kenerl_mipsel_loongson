Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Aug 2015 13:41:23 +0200 (CEST)
Received: from mail7.hitachi.co.jp ([133.145.228.42]:57401 "EHLO
        mail7.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012355AbbHDLlVHvvQJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Aug 2015 13:41:21 +0200
Received: from mlsv5.hitachi.co.jp (unknown [133.144.234.166])
        by mail7.hitachi.co.jp (Postfix) with ESMTP id 44C14B1D383;
        Tue,  4 Aug 2015 20:41:17 +0900 (JST)
Received: from mfilter04.hitachi.co.jp by mlsv5.hitachi.co.jp (8.13.1/8.13.1) id t74BfHdS013191; Tue, 4 Aug 2015 20:41:17 +0900
Received: from vshuts02.hitachi.co.jp (vshuts02.hitachi.co.jp [10.201.6.84])
        by mfilter04.hitachi.co.jp (Switch-3.3.4/Switch-3.3.4) with ESMTP id t74BfFfD029050;
        Tue, 4 Aug 2015 20:41:16 +0900
Received: from GSjpTKYDCehcs31.service.hitachi.net (unknown [158.212.188.195])
        by vshuts02.hitachi.co.jp (Postfix) with ESMTP id 7A399490059;
        Tue,  4 Aug 2015 20:41:15 +0900 (JST)
Received: from GSJPTKYDCEMBX31.service.hitachi.net ([169.254.4.60]) by
 GSjpTKYDCehcs31.service.hitachi.net ([158.212.188.195]) with mapi id
 14.03.0224.002; Tue, 4 Aug 2015 20:41:15 +0900
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
Thread-Index: AQHQzgsGDND7njYftUe3fB3L5gctF537r/GQ
Date:   Tue, 4 Aug 2015 11:41:14 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A84454926993@GSjpTKYDCembx31.service.hitachi.net>
References: <20150724011615.6834.79628.stgit@softrs>
        <55BF4B1F.9000602@hitachi.com> <877fpcfi2j.fsf@x220.int.ebiederm.org>
In-Reply-To: <877fpcfi2j.fsf@x220.int.ebiederm.org>
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
X-archive-position: 48566
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

SGVsbG8sDQoNClRoYW5rcyBmb3IgdGhlIHJlcGx5Lg0KDQo+IEZyb206IEVyaWMgVy4gQmllZGVy
bWFuIFttYWlsdG86ZWJpZWRlcm1AeG1pc3Npb24uY29tXQ0KWy4uLl0NCj4gQSBzcGVjaWZpYyBo
b29rIGZvciBhIHZlcnkgc3BlY2lmaWMgcHVycG9zZSB3aGVuIHRoZXJlIGlzIG5vIG90aGVyIHdh
eQ0KPiB3ZSBjYW4gY29uc2lkZXIuDQoNClNvLCBpcyBrbXNnX2R1bXAgbGlrZSBmZWF0dXJlIGFk
bWlzc2libGU/DQoNCj4gSWYgeW91IGRvbid0IGhhdmUgc29tZXRoaW5nIHRoYXQgZ2VuZXJhbGlz
ZXMgd2VsbCBpbnRvIGEgZ2VuZXJhbCBwdXJwb3NlDQo+IG9wZXJhdGlvbiB0aGF0IGl0IG1ha2Vz
IHNlbnNlIGZvciBldmVyeW9uZSB0byBjYWxsIHlvdSBjYW4gYWx3YXlzIHVzZQ0KPiB0aGUgd29y
bGQncyBsYXJnZXN0IGFrYSB5b3UgY2FuIHJ1biBjb2RlIGJlZm9yZSB0aGUgbmV3IGtlcm5lbCBz
dGFydHMNCj4gdGhhdCBpcyBsb2FkZWQgd2l0aCBrZXhlY19sb2FkLg0KDQpPbmUgb2Ygb3VyIHB1
cnBvc2VzLCBub3RpZnlpbmcgIkknbSBkeWluZyIsIHdvdWxkIGJlIGFjaGlldmVkIGJ5IHB1cmdh
dG9yeQ0KY29kZSBwcm92aWRlZCBieSBrZXhlYyBjb21tYW5kIGFzIEkgc3RhdGVkIGJlZm9yZS4g
IFNpbmNlIHRoZSB3YXkgb2YgdGhlDQpub3RpZmljYXRpb24gd2lsbCBkaWZmZXIgZnJvbSBlYWNo
IHZlbmRvciwgSSB0aGluayB3ZSBuZWVkIHRvIG1vZGlmeQ0KdGhlIHB1cmdhdG9yeSBjb2RlcyBw
bHVnZ2FibGUuICBBbHNvLCBJIHRoaW5rIHdlIG5lZWQgc29tZSBwYXJhbWV0ZXINCnBhc3Npbmcg
bWVjaGFuaXNtIHRvIHRoZSBwdXJnYXRvcnkgY29kZS4gIEZvciBleGFtcGxlLCBwYXNzaW5nIHRo
ZSBwYW5pYw0KbWVzc2FnZSB2aWEgYm9vdCBwYXJhbWV0ZXIgdG8gc2F2ZSBpdCB0byBTRUwuICBB
bHRob3VnaCBJJ20gbm90IHN1cmUNCndlIGNhbiBkbyB0aGF0IChJJ3ZlIG5vdCBpbnZlc3RpZ2F0
ZWQgd2VsbCB5ZXQpLiAgSXMgdGhhdCBhY2NlcHRhYmxlPw0KDQpSZWdhcmRzLA0KS2F3YWkNCg0K
