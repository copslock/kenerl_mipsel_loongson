Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Oct 2013 00:22:03 +0200 (CEST)
Received: from mga03.intel.com ([143.182.124.21]:19359 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817906Ab3JGWWAVh8ME (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Oct 2013 00:22:00 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 07 Oct 2013 15:21:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,1051,1371106800"; 
   d="scan'208";a="371098588"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by azsmga001.ch.intel.com with ESMTP; 07 Oct 2013 15:21:50 -0700
Received: from orsmsx109.amr.corp.intel.com ([169.254.2.189]) by
 ORSMSX105.amr.corp.intel.com ([169.254.4.17]) with mapi id 14.03.0123.003;
 Mon, 7 Oct 2013 15:21:50 -0700
From:   "Waskiewicz Jr, Peter P" <peter.p.waskiewicz.jr@intel.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC:     Tejun Heo <tj@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        King <acking@vmware.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Ben Hutchings" <bhutchings@solarflare.com>,
        Alexander Gordeev <agordeev@redhat.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        "iss_storagedev@hp.com" <iss_storagedev@hp.com>,
        Michael Ellerman <michael@ellerman.id.au>,
        "linux-driver@qlogic.com" <linux-driver@qlogic.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Mason, Jon" <jon.mason@intel.com>, Molnar <mingo@redhat.com>,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "e1000-devel@lists.sourceforge.net" 
        <e1000-devel@lists.sourceforge.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "linux390@de.ibm.com" <linux390@de.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [E1000-devel] [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts
 enablement pattern
Thread-Topic: [E1000-devel] [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts
 enablement pattern
Thread-Index: AQHOwIuZjLWjOrsKJ0GTI3oFcZBHxpnkq+YAgADZ6QCAARqngIAAfHoAgACKqgCAAATCAIAADi0AgAJIIYCAACRBAIAAJJAA
Date:   Mon, 7 Oct 2013 22:21:49 +0000
Message-ID: <1381184508.16853.20.camel@ppwaskie-mobl2>
References: <cover.1380703262.git.agordeev@redhat.com>
         <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com>
         <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>
         <1380922156.3214.49.camel@bwh-desktop.uk.level5networks.com>
         <20131005142054.GA11270@dhcp-26-207.brq.redhat.com>
         <1381009586.645.141.camel@pasglop>
         <20131006060243.GB28142@dhcp-26-207.brq.redhat.com>
         <1381040386.645.143.camel@pasglop>
         <20131006071027.GA29143@dhcp-26-207.brq.redhat.com>
         <20131007180111.GC2481@htj.dyndns.org> <1381176656.645.171.camel@pasglop>
In-Reply-To: <1381176656.645.171.camel@pasglop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.15.230]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5266EE94AAF93F43AF6E5E9594A7A470@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <peter.p.waskiewicz.jr@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peter.p.waskiewicz.jr@intel.com
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

T24gVHVlLCAyMDEzLTEwLTA4IGF0IDA3OjEwICsxMTAwLCBCZW5qYW1pbiBIZXJyZW5zY2htaWR0
IHdyb3RlOg0KPiBPbiBNb24sIDIwMTMtMTAtMDcgYXQgMTQ6MDEgLTA0MDAsIFRlanVuIEhlbyB3
cm90ZToNCj4gPiBJIGRvbid0IHRoaW5rIHRoZSBzYW1lIHJhY2UgY29uZGl0aW9uIHdvdWxkIGhh
cHBlbiB3aXRoIHRoZSBsb29wLiAgVGhlDQo+ID4gcHJvYmxlbSBjYXNlIGlzIHdoZXJlIG11bHRp
cGxlIG1zaSh4KSBhbGxvY2F0aW9uIGZhaWxzIGNvbXBsZXRlbHkNCj4gPiBiZWNhdXNlIHRoZSBn
bG9iYWwgbGltaXQgd2VudCBkb3duIGJlZm9yZSBpbnF1aXJ5IGFuZCBhbGxvY2F0aW9uLiAgSW4N
Cj4gPiB0aGUgbG9vcCBiYXNlZCBpbnRlcmZhY2UsIGl0J2QgcmV0cnkgd2l0aCB0aGUgbG93ZXIg
bnVtYmVyLg0KPiA+IA0KPiA+IEFzIGxvbmcgYXMgdGhlIG51bWJlciBvZiBkcml2ZXJzIHdoaWNo
IG5lZWQgdGhpcyBzb3J0IG9mIGFkYXB0aXZlDQo+ID4gYWxsb2NhdGlvbiBpc24ndCB0b28gaGln
aCBhbmQgdGhlIGNvbW1vbiBjYXNlcyBjYW4gYmUgbWFkZSBzaW1wbGUsIEkNCj4gPiBkb24ndCB0
aGluayB0aGUgImNvbXBsZXgiIHBhcnQgb2YgaW50ZXJmYWNlIGlzIGFsbCB0aGF0IGltcG9ydGFu
dC4NCj4gPiBNYXliZSB3ZSBjYW4gaGF2ZSByZXNlcnZlIC8gY2FuY2VsIHR5cGUgaW50ZXJmYWNl
IG9yIGp1c3Qga2VlcCB0aGUNCj4gPiBsb29wIHdpdGggbW9yZSBleHBsaWNpdCBmdW5jdGlvbiBu
YW1lcyAoaWUuIHRyeV9lbmFibGUgb3Igc29tZXRoaW5nDQo+ID4gbGlrZSB0aGF0KS4NCj4gDQo+
IFdlIHdhbnQgdG8gYmUgYWJsZSB0byByZXF1ZXN0IGFuIE1TSS1YIGF0IHJ1bnRpbWUgYW55d2F5
IC4uLiBpZiBJIHdhbnQNCj4gdG8gZHluYW1pY2FsbHkgYWRkIGEgcXVldWUgdG8gbXkgbmV0d29y
ayBpbnRlcmZhY2UsIEkgd2FudCBpdCB0byBiZSBhYmxlDQo+IHRvIHBvcCBhIG5ldyBhcmJpdHJh
cnkgTVNJLVguDQoNCklmIHlvdSB3YW50IHRvIGR5bmFtaWNhbGx5IGFsbG9jYXRlIGFub3RoZXIg
cXVldWUsIHlvdSdkIGVpdGhlciBuZWVkIHRvDQpoYXZlIHRoZW0gYWxsIHByZS1hbGxvY2F0ZWQg
YXQgYWxsb2NfZXRoZXJkZXZfbXFzKCksIG9yIGFkZCBhIG5ldyBBUEkgdG8NCm5ldGRldiB0aGF0
IGFsbG93cyBhZGRpbmcgbmV3IHF1ZXVlcyBvbiB0aGUgZmx5Lg0KDQpIb3cgdGhpbmdzIGFyZSBk
b25lIHRvZGF5LCB0aGUgVHggcXVldWVzIGFyZSBhbGwgdGFja2VkIG9udG8gdGhlIGVuZCBvZg0K
dGhlIG5ldGRldiBzdHJ1Y3QuICBUaGF0IHdvdWxkIGhhdmUgdG8gY2hhbmdlIHRvIHByb2JhYmx5
IGEgbGlua2VkIGxpc3QNCm9mIHF1ZXVlcyB0aGF0IGNvdWxkIGJlIGdyb3duIG9yIHNocnVuayBv
biB0aGUgZmx5Lg0KbmV0aWZfYWxsb2NfbmV0ZGV2X3F1ZXVlcygpIHdvdWxkIG5lZWQgdG8gY2hh
bmdlIHRoZSBremFsbG9jKCkgdG8gYSBsaXN0DQphbGxvY2F0aW9uLg0KDQpDaGVlcnMsDQotUEoN
Cg==
