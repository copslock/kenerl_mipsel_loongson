Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2017 16:24:02 +0200 (CEST)
Received: from smtp-out4.electric.net ([192.162.216.185]:59158 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992078AbdIZOXyrzAUy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Sep 2017 16:23:54 +0200
Received: from 1dwqlv-0002Y1-VT by out4a.electric.net with emc1-ok (Exim 4.87)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1dwqm0-0002oj-TP; Tue, 26 Sep 2017 07:23:44 -0700
Received: by emcmailer; Tue, 26 Sep 2017 07:23:44 -0700
Received: from [156.67.243.126] (helo=AcuExch.aculab.com)
        by out4a.electric.net with esmtps (TLSv1:AES128-SHA:128)
        (Exim 4.87)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1dwqlv-0002Y1-VT; Tue, 26 Sep 2017 07:23:39 -0700
Received: from ACUEXCH.Aculab.com ([::1]) by AcuExch.aculab.com ([::1]) with
 mapi id 14.03.0123.003; Tue, 26 Sep 2017 15:23:41 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Matt Redfearn' <matt.redfearn@imgtec.com>,
        David Miller <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "peppe.cavallaro@st.com" <peppe.cavallaro@st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        "James Hogan" <james.hogan@imgtec.com>
Subject: RE: [PATCH] net: stmmac: Meet alignment requirements for DMA
Thread-Topic: [PATCH] net: stmmac: Meet alignment requirements for DMA
Thread-Index: AQHTNs9za6qdFbduzEmZHg5agQgOi6LHNvIw
Date:   Tue, 26 Sep 2017 14:23:40 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD0081391@AcuExch.aculab.com>
References: <1506078833-14002-1-git-send-email-matt.redfearn@imgtec.com>
 <20170922.182639.272534775457081015.davem@davemloft.net>
 <587dc9a8-b974-e222-95b4-93c2a8f2aba2@imgtec.com>
In-Reply-To: <587dc9a8-b974-e222-95b4-93c2a8f2aba2@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.99.200]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuExch.aculab.com
X-TLS:  TLSv1:AES128-SHA:128
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (s)
Return-Path: <David.Laight@ACULAB.COM>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60160
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

RnJvbTogTWF0dCBSZWRmZWFybg0KPiBTZW50OiAyNiBTZXB0ZW1iZXIgMjAxNyAxNDo1OA0KLi4u
DQo+ID4gQXMgbG9uZyBhcyB5b3UgdXNlIHRoZSBkbWFfe21hcCx1bmFtcH1fc2luZ2xlKCkgYW5k
IHN5bmMgdG8vZnJvbQ0KPiA+IGRlaXZjZSBpbnRlcmZhY2VzIHByb3Blcmx5LCB0aGUgY2FjaGVs
aW5lIGlzc3VlcyB3aWxsIGJlIGhhbmRsZWQgcHJvcGVybHkNCj4gPiBhbmQgdGhlIGNwdSBhbmQg
dGhlIGRldmljZSB3aWxsIHNlZSBwcm9wZXIgdXB0b2RhdGUgbWVtb3J5IGNvbnRlbnRzLg0KPiAN
Cj4gSSBpbnRlcnByZXQgdGhlIERNQSBBUEkgZG9jdW1lbnQgKGFuZCB0aGUgTUlQUyBhcmNoIGRt
YSBjb2RlIG9wZXJhdGVzDQo+IHRoaXMgd2F5KSBhcyBzdGF0aW5nIHRoYXQgdGhlIGRyaXZlciBt
dXN0IGVuc3VyZSB0aGF0IGJ1ZmZlcnMgcGFzc2VkIHRvDQo+IGl0IGFyZSBjYWNoZWxpbmUgYWxp
Z25lZCwgYW5kIGNhY2hlbGluZSBzaXplZCwgdG8gcHJldmVudCBjYWNoZQ0KPiBtYW5hZ2VtZW50
IHRocm93aW5nIGF3YXkgYWRqYWNlbnQgZGF0YSBpbiB0aGUgc2FtZSBjYWNoZWxpbmUuDQoNClRo
ZSBpbXBvcnRhbnQgdGhpbmcgaXMgdGhhdCB0aGUgZHJpdmVyIG11c3Qgbm90IGRpcnR5IGFueSBj
YWNoZSBsaW5lcw0KdGhhdCBhcmUgbWFwcGVkIGZvciBETUEgKGZyb20gdGhlIGRldmljZSkuDQoN
ClR5cGljYWxseSB0aGlzIGlzIG5vdCBhIHByb2JsZW0gYmVjYXVzZSB0aGUgZHJpdmVyIGRvZXNu
J3QgbG9vaw0KYXQgc2tiIChldGMpIHRoYXQgY29udGFpbiByZWNlaXZlIGJ1ZmZlcnMgb25jZSB0
aGUgZG1hIGlzIHNldHVwLg0KDQoJRGF2aWQNCg0KDQo=
