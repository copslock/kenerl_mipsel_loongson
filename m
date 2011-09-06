Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Sep 2011 05:26:09 +0200 (CEST)
Received: from mga09.intel.com ([134.134.136.24]:11191 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491067Ab1IFD0A (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Sep 2011 05:26:00 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP; 05 Sep 2011 20:25:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; 
   d="scan'208";a="45518266"
Received: from orsmsx602.amr.corp.intel.com ([10.22.226.211])
  by orsmga001.jf.intel.com with ESMTP; 05 Sep 2011 20:25:51 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.226.213) by
 orsmsx602.amr.corp.intel.com (10.22.226.211) with Microsoft SMTP Server (TLS)
 id 8.2.255.0; Mon, 5 Sep 2011 20:25:51 -0700
Received: from orsmsx509.amr.corp.intel.com ([10.22.226.43]) by
 orsmsx601.amr.corp.intel.com ([10.22.226.213]) with mapi; Mon, 5 Sep 2011
 20:25:51 -0700
From:   "Zou, Yi" <yi.zou@intel.com>
To:     Ben Hutchings <bhutchings@solarflare.com>,
        Jiri Pirko <jpirko@redhat.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "fubar@us.ibm.com" <fubar@us.ibm.com>,
        "andy@greyhouse.net" <andy@greyhouse.net>,
        "kaber@trash.net" <kaber@trash.net>,
        "bprakash@broadcom.com" <bprakash@broadcom.com>,
        "JBottomley@parallels.com" <JBottomley@parallels.com>,
        "Love, Robert W" <robert.w.love@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "shemminger@linux-foundation.org" <shemminger@linux-foundation.org>,
        "decot@google.com" <decot@google.com>,
        "mirq-linux@rere.qmqm.pl" <mirq-linux@rere.qmqm.pl>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        "amit.salecha@qlogic.com" <amit.salecha@qlogic.com>,
        "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>,
        "therbert@google.com" <therbert@google.com>,
        "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>,
        "laijs@cn.fujitsu.com" <laijs@cn.fujitsu.com>,
        "xiaosuo@gmail.com" <xiaosuo@gmail.com>,
        "greearb@candelatech.com" <greearb@candelatech.com>,
        "loke.chetan@gmail.com" <loke.chetan@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "devel@open-fcoe.org" <devel@open-fcoe.org>,
        "bridge@lists.linux-foundation.org" 
        <bridge@lists.linux-foundation.org>
Date:   Mon, 5 Sep 2011 20:25:39 -0700
Subject: RE: [patch net-next-2.6 v3] net: consolidate and fix
 ethtool_ops->get_settings calling
Thread-Topic: [patch net-next-2.6 v3] net: consolidate and fix
 ethtool_ops->get_settings calling
Thread-Index: AcxqP/jbBlcrHR8fSM6B1+PO8DGrZQB31Uyw
Message-ID: <5A9BD224CEA58D4CB62235967D650C160A1B7D1C@orsmsx509.amr.corp.intel.com>
References: <1314905304-16485-1-git-send-email-jpirko@redhat.com>
         <20110902122630.GC1991@minipsycho> <1314989161.3419.5.camel@bwh-desktop>
         <20110903133428.GA2821@minipsycho> <1315057614.3092.160.camel@deadeye>
In-Reply-To: <1315057614.3092.160.camel@deadeye>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-archive-position: 31044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yi.zou@intel.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 2834

PiANCj4gT24gU2F0LCAyMDExLTA5LTAzIGF0IDE1OjM0ICswMjAwLCBKaXJpIFBpcmtvIHdyb3Rl
Og0KPiA+IFRoaXMgcGF0Y2ggZG9lcyBzZXZlcmFsIHRoaW5nczoNCj4gPiAtIGludHJvZHVjZXMg
X19ldGh0b29sX2dldF9zZXR0aW5ncyB3aGljaCBpcyBjYWxsZWQgZnJvbSBldGh0b29sIGNvZGUN
Cj4gYW5kDQo+ID4gICBmcm9tIGRyaXZlcnMgYXMgd2VsbC4gUHV0IEFTU0VSVF9SVE5MIHRoZXJl
Lg0KPiA+IC0gZGV2X2V0aHRvb2xfZ2V0X3NldHRpbmdzKCkgaXMgcmVwbGFjZWQgYnkgX19ldGh0
b29sX2dldF9zZXR0aW5ncygpDQo+ID4gLSBjaGFuZ2VzIGNhbGxpbmcgaW4gZHJpdmVycyBzbyBy
dG5sIGxvY2tpbmcgaXMgcmVzcGVjdGVkLiBJbg0KPiA+ICAgaWJvZV9nZXRfcmF0ZSB3YXMgcHJl
dmlvdXNseSAtPmdldF9zZXR0aW5ncygpIGNhbGxlZCB1bmxvY2tlZC4gVGhpcw0KPiA+ICAgZml4
ZXMgaXQuIEFsc28gcHJiX2NhbGNfcmV0aXJlX2Jsa190bW8oKSBpbiBhZl9wYWNrZXQuYyBoYWQg
dGhlIHNhbWUNCj4gPiAgIHByb2JsZW0uIEFsc28gZml4ZWQgYnkgY2FsbGluZyBfX2Rldl9nZXRf
YnlfaW5kZXgoKSBpbnN0ZWFkIG9mDQo+ID4gICBkZXZfZ2V0X2J5X2luZGV4KCkgYW5kIGhvbGRp
bmcgcnRubF9sb2NrIGZvciBib3RoIGNhbGxzLg0KPiA+IC0gaW50cm9kdWNlcyBydG5sX2xvY2sg
aW4gYm54MmZjX3Zwb3J0X2NyZWF0ZSgpIGFuZCBmY29lX3Zwb3J0X2NyZWF0ZSgpDQo+ID4gICBz
byBibngyZmNfaWZfY3JlYXRlKCkgYW5kIGZjb2VfaWZfY3JlYXRlKCkgYXJlIGNhbGxlZCBsb2Nr
ZWQgYXMgdGhleQ0KPiA+ICAgYXJlIGZyb20gb3RoZXIgcGxhY2VzLg0KPiA+IC0gdXNlIF9fZXRo
dG9vbF9nZXRfc2V0dGluZ3MoKSBpbiBib25kaW5nIGNvZGUNCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEppcmkgUGlya28gPGpwaXJrb0ByZWRoYXQuY29tPg0KPiBSZXZpZXdlZC1ieTogQmVuIEh1
dGNoaW5ncyA8Ymh1dGNoaW5nc0Bzb2xhcmZsYXJlLmNvbT4gW2V4Y2VwdCBGQ29FIGJpdHNdDQo+
IA0KPiBCZW4uDQpGQ29FIGJpdHMgbG9vayBvayB0byBtZS4gVGhhbmtzLA0KDQpSZXZpZXdlZC1i
eTogWWkgWm91IDx5aS56b3VAaW50ZWwuY29tPg0KDQo+IA0KPiAtLQ0KPiBCZW4gSHV0Y2hpbmdz
LCBTdGFmZiBFbmdpbmVlciwgU29sYXJmbGFyZQ0KPiBOb3Qgc3BlYWtpbmcgZm9yIG15IGVtcGxv
eWVyOyB0aGF0J3MgdGhlIG1hcmtldGluZyBkZXBhcnRtZW50J3Mgam9iLg0KPiBUaGV5IGFza2Vk
IHVzIHRvIG5vdGUgdGhhdCBTb2xhcmZsYXJlIHByb2R1Y3QgbmFtZXMgYXJlIHRyYWRlbWFya2Vk
Lg0KPiANCj4gLS0NCj4gVG8gdW5zdWJzY3JpYmUgZnJvbSB0aGlzIGxpc3Q6IHNlbmQgdGhlIGxp
bmUgInVuc3Vic2NyaWJlIGxpbnV4LXNjc2kiIGluDQo+IHRoZSBib2R5IG9mIGEgbWVzc2FnZSB0
byBtYWpvcmRvbW9Admdlci5rZXJuZWwub3JnDQo+IE1vcmUgbWFqb3Jkb21vIGluZm8gYXQgIGh0
dHA6Ly92Z2VyLmtlcm5lbC5vcmcvbWFqb3Jkb21vLWluZm8uaHRtbA0K
