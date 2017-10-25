Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Oct 2017 11:36:33 +0200 (CEST)
Received: from smtp-out6.electric.net ([192.162.217.184]:62027 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990417AbdJYJg0LNQox (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Oct 2017 11:36:26 +0200
Received: from 1e7I6l-00045W-Ud by out6b.electric.net with emc1-ok (Exim 4.87)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1e7I6p-0004cI-TT; Wed, 25 Oct 2017 02:36:23 -0700
Received: by emcmailer; Wed, 25 Oct 2017 02:36:23 -0700
Received: from [156.67.243.126] (helo=AcuExch.aculab.com)
        by out6b.electric.net with esmtps (TLSv1:AES128-SHA:128)
        (Exim 4.87)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1e7I6l-00045W-Ud; Wed, 25 Oct 2017 02:36:19 -0700
Received: from ACUEXCH.Aculab.com ([::1]) by AcuExch.aculab.com ([::1]) with
 mapi id 14.03.0123.003; Wed, 25 Oct 2017 10:36:38 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jim Quinlan' <jim2101024@gmail.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
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
Thread-Index: AQHTSbf9TBl9DXAo7kWMSYcuxab+MqLxJ8nggAIaHwCAARHcIA==
Date:   Wed, 25 Oct 2017 09:36:37 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD00A24FC@AcuExch.aculab.com>
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
 <063D6719AE5E284EB5DD2968C1650D6DD009F05A@AcuExch.aculab.com>
 <CANCKTBu6H6thuK9F_6HBGhStaXSto7fwWv4V5oH8EdWQD0-1kQ@mail.gmail.com>
In-Reply-To: <CANCKTBu6H6thuK9F_6HBGhStaXSto7fwWv4V5oH8EdWQD0-1kQ@mail.gmail.com>
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
X-archive-position: 60549
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

RnJvbTogSmltIFF1aW5sYQ0KPiBTZW50OiAyNCBPY3RvYmVyIDIwMTcgMTk6MDgNCi4uLg0KPiBI
aSBEYXZpZCwgIENocmlzdG9waCB3YXMgYWxzbyBjb25jZXJuZWQgYWJvdXQgdGhpczoNCj4gDQo+
ICJGb3IgdGhlIGJsb2NrIHdvcmxkIHRha2UgYSBsb29rIGF0IF9fYmxrX3NlZ21lbnRfbWFwX3Nn
IHdoaWNoIGRvZXMgdGhlIG1lcmdpbmcNCj4gb2YgY29udGlndW91cyBwYWdlcyBpbnRvIGEgc2lu
Z2xlIFNHIHNlZ21lbnQuICBZb3UnZCBoYXZlIHRvIG92ZXJyaWRlDQo+IEJJT1ZFQ19QSFlTX01F
UkdFQUJMRSB0byBwcmV2ZW50IHRoaXMgZnJvbSBoYXBwZW5pbmcgaW4geW91ciBzdXBwb3J0ZWQN
Cj4gYXJjaGl0ZWN0dXJlcyBmb3IgdGhlIGJsb2NrIGxheWVyLiINCj4gDQo+IERvIHlvdSBjb25z
aWRlciB0aGlzIGEgbm9uLWlzc3VlIGFzIHdlbGwgb3IgY2FuIHRoaXMgaGFwcGVuIGFuZCBzcGFu
DQo+IG1lbW9yeSByZWdpb25zPw0KDQpQcm9iYWJseSBlYXNpZXN0IHRvIGhhdmUgYW4gYXJjaGl0
ZWN0dXJlIGxpbWl0IG9uIHRoZSBhZGRyZXNzZXMgdGhhdA0KY2FuIGJlIG1lcmdlZC4NCg0KTXkg
Z3Vlc3MgaXMgdGhhdCB0aGlzIGNvZGUgb25seSByZWFsbHkgZXZlciBtZXJnZXMgcGFnZXMgdGhh
dCB3ZXJlDQphbGxvY2F0ZWQgY29udGlndW91c2x5LCBidXQgaGF2ZSBnb3QgY29udmVydGVkIHRv
IGEgbGlzdCBvZiBWQS4NClNvIHN0b3BwaW5nIG1lcmdpbmcgb3ZlciBldmVuIDFNQiBib3VuZGFy
aWVzIHdvdWxkIGhhdmUgbWluaW1hbCBlZmZlY3QNCihldmVuIGlmIGRvbmUgdW5jb25kaXRpb25h
bGx5KS4NCg0KSSBldmVuIHdvbmRlciBpZiB0aGUgbWVyZ2luZyBpcyBhY3R1YWxseSB3b3J0aHdo
aWxlIGF0IGFsbD8NCk1heWJlIGlmIGFueSBjb2RlIGhhcyBsaW1pdHMgb24gdGhlIFNHIGxpc3Qg
bGVuZ3RoLg0KKG9yIHJlZHVjaW5nIHRoZSBudW1iZXIgb2YgY2FjaGUgbGluZXMgdGhlIGdldCBk
aXJ0aWVkLi4uKQ0KDQoJRGF2aWQNCg0KDQoNCg==
