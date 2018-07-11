Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2018 13:44:59 +0200 (CEST)
Received: from smtp-out6.electric.net ([192.162.217.189]:61510 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993552AbeGKLotp6a80 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jul 2018 13:44:49 +0200
Received: from 1fdDY2-0009EC-TF by out6d.electric.net with emc1-ok (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fdDY6-0009qO-U6; Wed, 11 Jul 2018 04:44:46 -0700
Received: by emcmailer; Wed, 11 Jul 2018 04:44:46 -0700
Received: from [156.67.243.126] (helo=AcuMS.aculab.com)
        by out6d.electric.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fdDY2-0009EC-TF; Wed, 11 Jul 2018 04:44:42 -0700
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 11 Jul 2018 12:46:21 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 11 Jul 2018 12:46:21 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
CC:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James Hogan" <jhogan@kernel.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        wuzhangjin <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] MIPS: implement smp_cond_load_acquire() for Loongson-3
Thread-Topic: [PATCH V2] MIPS: implement smp_cond_load_acquire() for
 Loongson-3
Thread-Index: AQHUGQew6BeCJJ492kKUdytd7WH/WKSJ5EIQ
Date:   Wed, 11 Jul 2018 11:46:21 +0000
Message-ID: <d8a11208170d4fb09564413356ff940c@AcuMS.aculab.com>
References: <1531103198-16764-1-git-send-email-chenhc@lemote.com>
 <tencent_26F8B9E004D4512B2225FCE1@qq.com>
 <20180710121727.GK2476@hirez.programming.kicks-ass.net>
 <5471216.FKXZRxKFUI@flygoat-ry> <20180711102106.GG13963@arm.com>
 <20180711110952.GC2476@hirez.programming.kicks-ass.net>
In-Reply-To: <20180711110952.GC2476@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS:  TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (s)
Return-Path: <David.Laight@ACULAB.COM>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64787
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

RnJvbTogUGV0ZXIgWmlqbHN0cmENCj4gU2VudDogMTEgSnVseSAyMDE4IDEyOjEwDQouLg0KPiBB
ZGRpbmcgU1lOQyB0byBXUklURV9PTkNFKCkvYXRvbWljKiB3aWxsIGh1cnQgcGVyZm9ybWFuY2Ug
bG90cyBhbmQgd2lsbA0KPiB1bHRpbWF0ZWx5IG5vdCBndWFyYW50ZWUgYW55dGhpbmcgbW9yZTsg
YW5kIGFzIFdpbGwgc2FpZCwga2VlcCB5b3UNCj4gY2hhc2luZyBkcmFnb25zIHdoZXJlIHBlb3Bs
ZSBmb3Jnb3QgdG8gdXNlIFdSSVRFX09OQ0UoKSB3aGVyZSB0aGV5IG1heWJlDQo+IHNob3VsZCd2
ZS4NCg0KQWxzbyBXUklURV9PTkNFKCkgaXMgdGhlcmUgdG8gc29sdmUgYW4gZW50aXJlbHkgZGlm
ZmVyZW50IHByb2JsZW0uDQpJZiB5b3UgaGF2ZSBhIGZ1bmN0aW9uIHRoYXQgZG9lczoNCgk8bG90
cyBvZiBjb2RlIHdpdGhvdXQgYW55IGZ1bmN0aW9uIGNhbGxzPg0KCWZvby0+YmFyID0gMTsNCnRo
ZSBjb21waWxlciBpcyBhbGxvd2VkIHRvIHdyaXRlIG90aGVyICh1bnJlbGF0ZWQpIHZhbHVlcw0K
dG8gZm9vLT5iYXIgaW4gdGhlIGdlbmVyYXRlZCBjb2RlIGZvciA8bG90cyBvZiBjb2RlPi4NCg0K
QSBsb25nIHRpbWUgYWdvIEkgdXNlZCBhIGNvbXBpbGVyIHRoYXQgbWFuYWdlZCB0byBjb252ZXJ0
Og0KCWlmIChmb28tPmJhciA9PSAyKQ0KCQlmb28tPmJhciA9IDM7DQppbnRvOg0KCWlmIChmb28t
PmJhciA9PSAyKSB7DQoJCWZvby0+YmFyID0gMDsNCgkJZm9vLT5iYXIgPSAzOw0KCX0NCldoZW4g
YW4gaW50ZXJydXB0IHJlYWQgdGhlIHZhbHVlIDAgYSBsb3Qgb2YgbGlua2VkIGxpc3QgZ290IHNj
cmV3ZWQgdXAuDQpXUklURV9PTkNFKCkgaXMgdGhlcmUgdG8gZW5zdXJlIHRoYXQgZG9lc24ndCBo
YXBwZW4uDQooSW4gbXkgY2FzZSAnZm9vJyB3YXMgYSAyLWJpdCB3aWRlIGJpdGZpZWxkLCBhbmQg
SSBzdXNwZWN0IHlvdQ0KY2FuJ3QgdXNlIFdSSVRFX09OQ0UoKSBvbiBiaXRmaWVsZHMuKQ0KDQoJ
RGF2aWQNCg0K
