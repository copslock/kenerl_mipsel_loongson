Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Apr 2018 17:40:25 +0200 (CEST)
Received: from smtp-out4.electric.net ([192.162.216.184]:52007 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992105AbeDMPkRdP8c2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Apr 2018 17:40:17 +0200
Received: from 1f70nu-0008C0-U1 by out4a.electric.net with emc1-ok (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1f70o4-0000iJ-UG; Fri, 13 Apr 2018 08:40:08 -0700
Received: by emcmailer; Fri, 13 Apr 2018 08:40:08 -0700
Received: from [156.67.243.126] (helo=AcuMS.aculab.com)
        by out4a.electric.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1f70nu-0008C0-U1; Fri, 13 Apr 2018 08:39:58 -0700
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 13 Apr 2018 16:41:00 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 13 Apr 2018 16:41:00 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'James Hogan' <jhogan@kernel.org>,
        Sinan Kaya <okaya@codeaurora.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "timur@codeaurora.org" <timur@codeaurora.org>,
        "sulrich@codeaurora.org" <sulrich@codeaurora.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] MIPS: io: add a barrier after register read in
 readX()
Thread-Topic: [PATCH v3 2/2] MIPS: io: add a barrier after register read in
 readX()
Thread-Index: AQHT0qikXjJOjqk/vUybR+JVW4DLMKP+1Ukw
Date:   Fri, 13 Apr 2018 15:41:00 +0000
Message-ID: <e38a329dfb9c461ab3e91de7b96db3dc@AcuMS.aculab.com>
References: <1522760109-16497-1-git-send-email-okaya@codeaurora.org>
 <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
 <20180412215149.GA27802@saruman>
In-Reply-To: <20180412215149.GA27802@saruman>
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
X-archive-position: 63523
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

RnJvbTogSmFtZXMgSG9nYW4NCj4gU2VudDogMTIgQXByaWwgMjAxOCAyMjo1Mg0KPiBPbiBUdWUs
IEFwciAwMywgMjAxOCBhdCAwODo1NTowNEFNIC0wNDAwLCBTaW5hbiBLYXlhIHdyb3RlOg0KPiA+
IFdoaWxlIGEgYmFycmllciBpcyBwcmVzZW50IGluIHdyaXRlWCgpIGZ1bmN0aW9uIGJlZm9yZSB0
aGUgcmVnaXN0ZXIgd3JpdGUsDQo+ID4gYSBzaW1pbGFyIGJhcnJpZXIgaXMgbWlzc2luZyBpbiB0
aGUgcmVhZFgoKSBmdW5jdGlvbiBhZnRlciB0aGUgcmVnaXN0ZXINCj4gPiByZWFkLiBUaGlzIGNv
dWxkIGFsbG93IG1lbW9yeSBhY2Nlc3NlcyBmb2xsb3dpbmcgcmVhZFgoKSB0byBvYnNlcnZlDQo+
ID4gc3RhbGUgZGF0YS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNpbmFuIEtheWEgPG9rYXlh
QGNvZGVhdXJvcmEub3JnPg0KPiA+IFJlcG9ydGVkLWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFy
bmRiLmRlPg0KPiANCj4gQm90aCBwYXRjaGVzIGxvb2sgbGlrZSBvYnZpb3VzIGltcHJvdmVtZW50
cyB0byBtZSwgc28gSSdtIGhhcHB5IHRvIGFwcGx5DQo+IHRvIG15IGZpeGVzIGJyYW5jaC4NCg0K
RG9uJ3QgeW91IGFsc28gbmVlZCBhdCBsZWFzdCBiYXJyaWVyKCkgYmV0d2VlbiB0aGUgcmVnaXN0
ZXIgd3JpdGUgaW4gd3JpdGVYKCkNCmFuZCB0aGUgcmVnaXN0ZXIgcmVhZCBpbiByZWFkWCgpPw0K
T24gcHBjIHlvdSBwcm9iYWJseSBuZWVkIGVpZWlvLg0KT3IgYXJlIGRyaXZlcnMgZXhwZWN0ZWQg
dG8gaW5zZXJ0IHRoYXQgb25lPw0KSWYgdGhleSBuZWVkIHRvIGluc2VydCB0aGF0IG9uZSB0aGVu
IHdoeSBub3QgYWxsIHRoZSBvdGhlcnM/Pw0KDQoJRGF2aWQNCg0K
