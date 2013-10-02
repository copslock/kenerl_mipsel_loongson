Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2013 22:51:17 +0200 (CEST)
Received: from mga03.intel.com ([143.182.124.21]:31780 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6868559Ab3JBUvNriywb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Oct 2013 22:51:13 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 02 Oct 2013 13:50:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,1021,1371106800"; 
   d="scan'208";a="368946992"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by azsmga001.ch.intel.com with ESMTP; 02 Oct 2013 13:50:54 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.123.3; Wed, 2 Oct 2013 13:50:53 -0700
Received: from orsmsx104.amr.corp.intel.com ([169.254.3.105]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.219]) with mapi id 14.03.0123.003;
 Wed, 2 Oct 2013 13:50:52 -0700
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     Alexander Gordeev <agordeev@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Michael Ellerman" <michael@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Andy King <acking@vmware.com>,
        "Mason, Jon" <jon.mason@intel.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux390@de.ibm.com" <linux390@de.ibm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "iss_storagedev@hp.com" <iss_storagedev@hp.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "e1000-devel@lists.sourceforge.net" 
        <e1000-devel@lists.sourceforge.net>,
        "linux-driver@qlogic.com" <linux-driver@qlogic.com>,
        "Solarflare linux maintainers" <linux-net-drivers@solarflare.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH RFC 40/77] ixgbevf: Update MSI/MSI-X interrupts
 enablement code
Thread-Topic: [PATCH RFC 40/77] ixgbevf: Update MSI/MSI-X interrupts
 enablement code
Thread-Index: AQHOv5DJzxc+2V04zE2Th/Wpeuij1ZniWF+A
Date:   Wed, 2 Oct 2013 20:50:51 +0000
Message-ID: <1380747051.32715.7.camel@jekeller-desk1.amr.corp.intel.com>
References: <cover.1380703262.git.agordeev@redhat.com>
         <338c9012577acf694eb23622902185584987bd8f.1380703263.git.agordeev@redhat.com>
In-Reply-To: <338c9012577acf694eb23622902185584987bd8f.1380703263.git.agordeev@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D88EDE535096B47AA1524CA4B47209A@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <jacob.e.keller@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jacob.e.keller@intel.com
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

T24gV2VkLCAyMDEzLTEwLTAyIGF0IDEyOjQ4ICswMjAwLCBBbGV4YW5kZXIgR29yZGVldiB3cm90
ZToNCj4gQXMgcmVzdWx0IG9mIHJlY2VudCByZS1kZXNpZ24gb2YgdGhlIE1TSS9NU0ktWCBpbnRl
cnJ1cHRzIGVuYWJsaW5nDQo+IHBhdHRlcm4gdGhpcyBkcml2ZXIgaGFzIHRvIGJlIHVwZGF0ZWQg
dG8gdXNlIHRoZSBuZXcgdGVjaG5pcXVlIHRvDQo+IG9idGFpbiBhIG9wdGltYWwgbnVtYmVyIG9m
IE1TSS9NU0ktWCBpbnRlcnJ1cHRzIHJlcXVpcmVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxl
eGFuZGVyIEdvcmRlZXYgPGFnb3JkZWV2QHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9u
ZXQvZXRoZXJuZXQvaW50ZWwvaXhnYmV2Zi9peGdiZXZmX21haW4uYyB8ICAgMTggKysrKysrKy0t
LS0tLS0tLS0tDQo+ICAxIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaXhn
YmV2Zi9peGdiZXZmX21haW4uYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2l4Z2JldmYv
aXhnYmV2Zl9tYWluLmMNCj4gaW5kZXggZmEwNTM3YS4uZDUwNmEwMSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaXhnYmV2Zi9peGdiZXZmX21haW4uYw0KPiArKysg
Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9peGdiZXZmL2l4Z2JldmZfbWFpbi5jDQo+IEBA
IC0xNzQ5LDggKzE3NDksNyBAQCB2b2lkIGl4Z2JldmZfcmVzZXQoc3RydWN0IGl4Z2JldmZfYWRh
cHRlciAqYWRhcHRlcikNCj4gIHN0YXRpYyBpbnQgaXhnYmV2Zl9hY3F1aXJlX21zaXhfdmVjdG9y
cyhzdHJ1Y3QgaXhnYmV2Zl9hZGFwdGVyICphZGFwdGVyLA0KPiAgCQkJCQlpbnQgdmVjdG9ycykN
Cj4gIHsNCj4gLQlpbnQgZXJyID0gMDsNCj4gLQlpbnQgdmVjdG9yX3RocmVzaG9sZDsNCj4gKwlp
bnQgZXJyLCB2ZWN0b3JfdGhyZXNob2xkOw0KPiAgDQo+ICAJLyogV2UnbGwgd2FudCBhdCBsZWFz
dCAyICh2ZWN0b3JfdGhyZXNob2xkKToNCj4gIAkgKiAxKSBUeFFbMF0gKyBSeFFbMF0gaGFuZGxl
cg0KPiBAQCAtMTc2MywxOCArMTc2MiwxNSBAQCBzdGF0aWMgaW50IGl4Z2JldmZfYWNxdWlyZV9t
c2l4X3ZlY3RvcnMoc3RydWN0IGl4Z2JldmZfYWRhcHRlciAqYWRhcHRlciwNCj4gIAkgKiBSaWdo
dCBub3csIHdlIHNpbXBseSBjYXJlIGFib3V0IGhvdyBtYW55IHdlJ2xsIGdldDsgd2UnbGwNCj4g
IAkgKiBzZXQgdGhlbSB1cCBsYXRlciB3aGlsZSByZXF1ZXN0aW5nIGlycSdzLg0KPiAgCSAqLw0K
PiAtCXdoaWxlICh2ZWN0b3JzID49IHZlY3Rvcl90aHJlc2hvbGQpIHsNCj4gLQkJZXJyID0gcGNp
X2VuYWJsZV9tc2l4KGFkYXB0ZXItPnBkZXYsIGFkYXB0ZXItPm1zaXhfZW50cmllcywNCj4gLQkJ
CQkgICAgICB2ZWN0b3JzKTsNCj4gLQkJaWYgKCFlcnIgfHwgZXJyIDwgMCkgLyogU3VjY2VzcyBv
ciBhIG5hc3R5IGZhaWx1cmUuICovDQo+IC0JCQlicmVhazsNCj4gLQkJZWxzZSAvKiBlcnIgPT0g
bnVtYmVyIG9mIHZlY3RvcnMgd2Ugc2hvdWxkIHRyeSBhZ2FpbiB3aXRoICovDQo+IC0JCQl2ZWN0
b3JzID0gZXJyOw0KPiAtCX0NCj4gKwllcnIgPSBwY2lfbXNpeF90YWJsZV9zaXplKGFkYXB0ZXIt
PnBkZXYpOw0KSSB3b3VsZCBwcmVmZXIgdG8gdXNlIHNvbWV0aGluZyBvdGhlciB0aGFuICJlcnIi
IGhlcmUgc2luY2UgdGhlIHZhbHVlDQppc24ndCByZWFsbHkgYW4gZXJyb3IgaWYgaXQncyBncmVh
dGVyIHRoYW4gMC4gSG93ZXZlciwgaXQncyBub3QgcmVhbGx5IGENCmJpZyBpc3N1ZSwgc2luY2Ug
eW91IGltbWVkaWF0ZWx5IGNvbnZlciB0byB1c2luZyB2ZWN0b3JzIG9uIHRoZSBuZXh0DQpsaW5l
IG9mIGNvZGUuLiBJIHRoaW5rIGl0cyBhbHJpZ2h0IG92ZXJhbGwuDQoNClJlZ2FyZHMsDQpKYWtl
DQoNCj4gKwlpZiAoZXJyIDwgMCkNCj4gKwkJcmV0dXJuIGVycjsNCj4gIA0KPiArCXZlY3RvcnMg
PSBtaW4odmVjdG9ycywgZXJyKTsNCj4gIAlpZiAodmVjdG9ycyA8IHZlY3Rvcl90aHJlc2hvbGQp
DQo+IC0JCWVyciA9IC1FTk9TUEM7DQo+ICsJCXJldHVybiAtRU5PU1BDOw0KPiAgDQo+ICsJZXJy
ID0gcGNpX2VuYWJsZV9tc2l4KGFkYXB0ZXItPnBkZXYsIGFkYXB0ZXItPm1zaXhfZW50cmllcywg
dmVjdG9ycyk7DQo+ICAJaWYgKGVycikgew0KPiAgCQlkZXZfZXJyKCZhZGFwdGVyLT5wZGV2LT5k
ZXYsDQo+ICAJCQkiVW5hYmxlIHRvIGFsbG9jYXRlIE1TSS1YIGludGVycnVwdHNcbiIpOw0KDQoN
Cg==
