Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Oct 2017 11:05:57 +0200 (CEST)
Received: from smtp-out6.electric.net ([192.162.217.183]:59922 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990494AbdJWJFtOJAC5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Oct 2017 11:05:49 +0200
Received: from 1e6Yg4-000AFN-VF by out6c.electric.net with emc1-ok (Exim 4.87)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1e6Yg7-000Adt-Ux; Mon, 23 Oct 2017 02:05:47 -0700
Received: by emcmailer; Mon, 23 Oct 2017 02:05:47 -0700
Received: from [156.67.243.126] (helo=AcuExch.aculab.com)
        by out6c.electric.net with esmtps (TLSv1:AES128-SHA:128)
        (Exim 4.87)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1e6Yg4-000AFN-VF; Mon, 23 Oct 2017 02:05:44 -0700
Received: from ACUEXCH.Aculab.com ([::1]) by AcuExch.aculab.com ([::1]) with
 mapi id 14.03.0123.003; Mon, 23 Oct 2017 10:06:04 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jim Quinlan' <jim2101024@gmail.com>,
        Christoph Hellwig <hch@lst.de>
CC:     Robin Murphy <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "Kevin Cernekee" <cernekee@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        "Gregory Fong" <gregory.0xf0@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Brian Norris <computersforpeace@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH 5/9] PCI: host: brcmstb: add dma-ranges for inbound
 traffic
Thread-Topic: [PATCH 5/9] PCI: host: brcmstb: add dma-ranges for inbound
 traffic
Thread-Index: AQHTSbf9TBl9DXAo7kWMSYcuxab+MqLxJ8ng
Date:   Mon, 23 Oct 2017 09:06:03 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD009F05A@AcuExch.aculab.com>
References: <1507761269-7017-6-git-send-email-jim2101024@gmail.com>
 <589c04cb-061b-a453-3188-79324a02388e@arm.com>
 <20171017081422.GA19475@lst.de>
 <CANCKTBsCB+x2XgrND9AhRtxPkCXfps1nA+YymkZjKHOUZfjSHQ@mail.gmail.com>
 <20171018065316.GA11183@lst.de>
 <CANCKTBv+yiCNsrnx3m+W9wPqC4NdKPZ2p=zLtSa8fX6v1rPcYQ@mail.gmail.com>
 <20171019091644.GA14983@lst.de>
 <CANCKTBuaTD29My77QfOeUmtZfLAmmJXUYe6QvBW+uoH2Kb+tAQ@mail.gmail.com>
 <20171020073730.GA12937@lst.de>
 <CANCKTBsRRkwNMrxWjtgxbyZqT6NOxPX0NHDbnEO2BMjj8oVtpg@mail.gmail.com>
 <20171020145752.GA4694@lst.de>
 <CANCKTBtxp9gSdndKAZ7xGA+VozQsn2PX_-9P8A22_5Matbb7-w@mail.gmail.com>
In-Reply-To: <CANCKTBtxp9gSdndKAZ7xGA+VozQsn2PX_-9P8A22_5Matbb7-w@mail.gmail.com>
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
X-archive-position: 60525
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

RnJvbTogSmltIFF1aW5sYW4NCj4gU2VudDogMjAgT2N0b2JlciAyMDE3IDE2OjI4DQo+IE9uIEZy
aSwgT2N0IDIwLCAyMDE3IGF0IDEwOjU3IEFNLCBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5k
ZT4gd3JvdGU6DQo+ID4gT24gRnJpLCBPY3QgMjAsIDIwMTcgYXQgMTA6NDE6NTZBTSAtMDQwMCwg
SmltIFF1aW5sYW4gd3JvdGU6DQo+ID4+IEkgYW0gbm90IHN1cmUgSSB1bmRlcnN0YW5kIHlvdXIg
Y29tbWVudCAtLSB0aGUgc2l6ZSBvZiB0aGUgcmVxdWVzdA0KPiA+PiBzaG91bGRuJ3QgYmUgYSBm
YWN0b3IuICBMZXQncyBsb29rIGF0IHlvdXIgZXhhbXBsZSBvZiB0aGUgRE1BIHJlcXVlc3QNCj4g
Pj4gb2YgM2ZmZmZmMDAgdG8gNDAwMDAwMGYgKHBoeXNpY2FsIG1lbW9yeSkuICBMZXRzIHNheSBp
dCBpcyBmb3IgMTUNCj4gPj4gcGFnZXMuICBJZiB3ZSBibG9jayBvdXQgIHRoZSBsYXN0IHBhZ2Ug
WzB4M2ZmZmYwMDAuLjB4M2ZmZmZmZmZdIGZyb20NCj4gPj4gd2hhdCBpcyBhdmFpbGFibGUsIHRo
ZXJlIGlzIG5vIDE1IHBhZ2Ugc3BhbiB0aGF0IGNhbiBoYXBwZW4gYWNyb3NzIHRoZQ0KPiA+PiAw
eDQwMDAwMDAwIGJvdW5kYXJ5LiAgRm9yIFNHLCB0aGVyZSBjYW4gYmUgbm8gbWVyZ2UgdGhhdCBj
b25uZWN0cyBhDQo+ID4+IHBhZ2UgZnJvbSBvbmUgcmVnaW9uIHRvIGFub3RoZXIgcmVnaW9uLiAg
Q2FuIHlvdSBnaXZlIGFuIGV4YW1wbGUgb2YNCj4gPj4gdGhlIHNjZW5hcmlvIHlvdSBhcmUgdGhp
bmtpbmcgb2Y/DQo+ID4NCj4gPiBXaGF0IHByZXZlbnRzIGEgbWVyZ2UgZnJvbSBzYXkgdGhlIHJl
Z2lvbnMgb2YNCj4gPiAwLi4uLjNmZmZmZmZmIGFuZCA0MDAwMDAwMC4uLi43ZmZmZmZmZj8NCj4g
DQo+IEh1aD8gWzB4M2ZmZmYwMDAuLi54M2ZmZmZmZl0gaXMgbm90IGF2YWlsYWJsZSB0byBiZSB1
c2VkLiBEcmF3aW5nIGZyb20NCj4gdGhlIG9yaWdpbmFsIGV4YW1wbGUsIHdlIG5vdyBoYXZlIHRv
IHRlbGwgTGludXggdGhhdCB0aGVzZSBhcmUgbm93IG91cg0KPiBlZmZlY3RpdmUgbWVtb3J5IHJl
Z2lvbnM6DQo+IA0KPiAgICAgICBtZW1jMC1hQFsgICAgICAgIDAuLi4uM2ZmZmVmZmZdIDw9PiBw
Y2lAWyAgICAgICAgMC4uLi4zZmZmZWZmZl0NCj4gICAgICAgbWVtYzAtYkBbMTAwMDAwMDAwLi4u
MTNmZmZlZmZmXSA8PT4gcGNpQFsgNDAwMDAwMDAuLi4uN2ZmZmVmZmZdDQo+ICAgICAgIG1lbWMx
LWFAWyA0MDAwMDAwMC4uLi43ZmZmZWZmZl0gPD0+IHBjaUBbIDgwMDAwMDAwLi4uLmJmZmZlZmZm
XQ0KPiAgICAgICBtZW1jMS1iQFszMDAwMDAwMDAuLi4zM2ZmZmVmZmZdIDw9PiBwY2lAWyBjMDAw
MDAwMC4uLi5mZmZmZWZmZl0NCj4gICAgICAgbWVtYzItYUBbIDgwMDAwMDAwLi4uLmJmZmZlZmZm
XSA8PT4gcGNpQFsxMDAwMDAwMDAuLi4xM2ZmZmVmZmZdDQo+ICAgICAgIG1lbWMyLWJAW2MwMDAw
MDAwMC4uLmMzZmZmZmZmZl0gPD0+IHBjaUBbMTQwMDAwMDAwLi4uMTdmZmZmZmZmXQ0KPiANCj4g
VGhpcyBsZWF2ZXMgYSBvbmUtcGFnZSBnYXAgYmV0d2VlbiBwaHN5aWNhbCBtZW1vcnkgcmVnaW9u
cyB3aGljaCB3b3VsZA0KPiBub3JtYWxseSBiZSBjb250aWd1b3VzLiBPbmUgY2Fubm90IGhhdmUg
YSBkbWEgYWxsb2MgdGhhdCBzcGFucyBhbnkgdHdvDQo+IHJlZ2lvbnMuICBUaGlzIGlzIGEgZHJh
c3RpYyBzdGVwLCBidXQgSSBkb24ndCBzZWUgYW4gYWx0ZXJuYXRpdmUuDQo+IFBlcmhhcHMgIEkg
bWF5IGJlIG1pc3Npbmcgd2hhdCB5b3UgYXJlIHNheWluZy4uLg0KDQpJc24ndCB0aGlzIGFsbCB1
bm5lY2Vzc2FyeT8NCkJvdGgga21hbGxvYygpIGFuZCBkbWFfYWxsb2MoKSBhcmUgY29uc3RyYWlu
ZWQgdG8gYWxsb2NhdGUgbWVtb3J5DQp0aGF0IGRvZXNuJ3QgY3Jvc3MgYW4gYWRkcmVzcyBib3Vu
ZGFyeSB0aGF0IGlzIGxhcmdlciB0aGFuIHRoZSBzaXplLg0KU28gaWYgeW91IGFsbG9jYXRlIDE2
ayBpdCB3b24ndCBjcm9zcyBhIDE2ayBwaHlzaWNhbCBhZGRyZXNzIGJvdW5kYXJ5Lg0KDQoJRGF2
aWQNCg0K
