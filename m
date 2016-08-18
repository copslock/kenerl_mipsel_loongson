Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2016 13:46:42 +0200 (CEST)
Received: from omzsmtpe03.verizonbusiness.com ([199.249.25.208]:5602 "EHLO
        omzsmtpe03.verizonbusiness.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993200AbcHRLq0vi8yp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2016 13:46:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1471520786; x=1503056786;
  h=from:to:cc:date:subject:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a5vRTqweAZJ5bRXMq08iD5Ay1u9OgO2Ry2vhf6fxPVM=;
  b=VlFVbbDYPb0kd22eSypRIY8lm/7Usabf/oKhbN3oxBhUerqBdYLTg2gK
   P10z9Xssqld844skKMeL+0eP8aWcYQoEYzb8TDnNsJNGKSaql/fPg04Oa
   auxqtGjypbfsgfmMPMJHlztVSOYDfIfzwTT1HROSk9xa5LruyqOXphpId
   g=;
X-IronPort-Anti-Spam-Filtered: false
Received: from unknown (HELO fldsmtpi02.verizon.com) ([166.68.71.144])
  by omzsmtpe03.verizonbusiness.com with ESMTP; 18 Aug 2016 11:46:20 +0000
From:   "Levin, Alexander" <alexander.levin@verizon.com>
X-IronPort-AV: E=Sophos;i="5.28,539,1464652800"; 
   d="scan'208";a="1257673313"
Received: from fhdp1lumxc7hb01.verizon.com (HELO FHDP1LUMXC7HB01.us.one.verizon.com) ([166.68.59.188])
  by fldsmtpi02.verizon.com with ESMTP; 18 Aug 2016 11:45:32 +0000
Received: from FHDP1LUMXC7V93.us.one.verizon.com ([166.68.240.160]) by
 FHDP1LUMXC7HB01.us.one.verizon.com ([166.68.59.188]) with mapi; Thu, 18 Aug
 2016 07:45:31 -0400
To:     James Hogan <james.hogan@imgtec.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Date:   Thu, 18 Aug 2016 07:45:33 -0400
Subject: Re: [PATCH BACKPORT 3.17-4.4 2/4] MIPS: KVM: Add missing gfn range
 check
Thread-Topic: [PATCH BACKPORT 3.17-4.4 2/4] MIPS: KVM: Add missing gfn range
 check
Thread-Index: AdH5RgXPr9Bx14BBTvaelgkiAUYlOg==
Message-ID: <8ae95d49-3491-02cd-9ce6-fd876df1fe4d@verizon.com>
References: <cover.6970eb00e72f05828fc82d97b7283d20eac8951e.1471018436.git-series.james.hogan@imgtec.com>
 <5ae3371dc11534460b722864ea8c6ef27e8506d1.1471018436.git-series.james.hogan@imgtec.com>
In-Reply-To: <5ae3371dc11534460b722864ea8c6ef27e8506d1.1471018436.git-series.james.hogan@imgtec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
acceptlanguage: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <alexander.levin@verizon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.levin@verizon.com
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

T24gMDgvMTgvMjAxNiAwNTowNSBBTSwgSmFtZXMgSG9nYW4gd3JvdGU6DQo+IGNvbW1pdCA4OTg1
ZDUwMzgyMzU5ZTViZjExOGZkYmVmYzg1OWQwZGJmNmNlYmM3IHVwc3RyZWFtLg0KPiANCj4ga3Zt
X21pcHNfaGFuZGxlX21hcHBlZF9zZWdfdGxiX2ZhdWx0KCkgY2FsY3VsYXRlcyB0aGUgZ3Vlc3Qg
ZnJhbWUgbnVtYmVyDQo+IGJhc2VkIG9uIHRoZSBndWVzdCBUTEIgRW50cnlMbyB2YWx1ZXMsIGhv
d2V2ZXIgaXQgaXMgbm90IHJhbmdlIGNoZWNrZWQNCj4gdG8gZW5zdXJlIGl0IGxpZXMgd2l0aGlu
IHRoZSBndWVzdF9wbWFwLiBJZiB0aGUgcGh5c2ljYWwgbWVtb3J5IHRoZQ0KPiBndWVzdCByZWZl
cnMgdG8gaXMgb3V0IG9mIHJhbmdlIHRoZW4gZHVtcCB0aGUgZ3Vlc3QgVExCIGFuZCBlbWl0IGFu
DQo+IGludGVybmFsIGVycm9yLg0KPiANCj4gRml4ZXM6IDg1OGRkNWQ0NTczMyAoIktWTS9NSVBT
MzI6IE1NVS9UTEIgb3BlcmF0aW9ucyBmb3IgdGhlIEd1ZXN0LiIpDQo+IFNpZ25lZC1vZmYtYnk6
IEphbWVzIEhvZ2FuIDxqYW1lcy5ob2dhbkBpbWd0ZWMuY29tPg0KPiBDYzogUGFvbG8gQm9uemlu
aSA8cGJvbnppbmlAcmVkaGF0LmNvbT4NCj4gQ2M6ICJSYWRpbSBLcsSNbcOhxZkiIDxya3JjbWFy
QHJlZGhhdC5jb20+DQo+IENjOiBSYWxmIEJhZWNobGUgPHJhbGZAbGludXgtbWlwcy5vcmc+DQo+
IENjOiBsaW51eC1taXBzQGxpbnV4LW1pcHMub3JnDQo+IENjOiBrdm1Admdlci5rZXJuZWwub3Jn
DQo+IFNpZ25lZC1vZmYtYnk6IFJhZGltIEtyxI1tw6HFmSA8cmtyY21hckByZWRoYXQuY29tPg0K
PiBbamFtZXMuaG9nYW5AaW1ndGVjLmNvbTogQmFja3BvcnQgdG8gdjMuMTcueSAtIHY0LjQueV0N
Cj4gU2lnbmVkLW9mZi1ieTogSmFtZXMgSG9nYW4gPGphbWVzLmhvZ2FuQGltZ3RlYy5jb20+DQoN
CkhleSBKYW1lcywNCg0KVGhhbmtzIGZvciB0aGUgYmFja3BvcnQhDQoNCkFwcGx5aW5nIHRoaXMg
b25lIHNlZW1zIHRvIGZhaWwgd2l0aDoNCg0KJCBnaXQgYXBwbHkgLS1yZWplY3QgW1BBVENIIEJB
Q0tQT1JUIDMuMTctNC40IDFfNF0gTUlQUzogS1ZNOiBGaXggbWFwcGVkDQpmYXVsdCBicm9rZW4g
Y29tbXBhZ2UgaGFuZGxpbmcgLSBKYW1lcyBIb2dhbiA8amFtZXMuaG9nYW5AaW1ndGVjLmNvbT4g
LQ0KMjAxNi0wOC0xOCAwNTA1LmVtbA0KQ2hlY2tpbmcgcGF0Y2ggYXJjaC9taXBzL2t2bS90bGIu
Yy4uLg0KZXJyb3I6IHdoaWxlIHNlYXJjaGluZyBmb3I6DQoJdW5zaWduZWQgbG9uZyBlbnRyeWhp
ID0gMCwgZW50cnlsbzAgPSAwLCBlbnRyeWxvMSA9IDA7DQoJc3RydWN0IGt2bSAqa3ZtID0gdmNw
dS0+a3ZtOw0KCXBmbl90IHBmbjAsIHBmbjE7DQoJbG9uZyB0bGJfbG9bMl07DQoNCgl0bGJfbG9b
MF0gPSB0bGItPnRsYl9sbzA7DQoNCmVycm9yOiBwYXRjaCBmYWlsZWQ6IGFyY2gvbWlwcy9rdm0v
dGxiLmM6MzYxDQplcnJvcjogd2hpbGUgc2VhcmNoaW5nIGZvcjoNCgkJCVZQTjJfTUFTSyAmIChQ
QUdFX01BU0sgPDwgMSkpKQ0KCQl0bGJfbG9bKEtWTV9HVUVTVF9DT01NUEFHRV9BRERSID4+IFBB
R0VfU0hJRlQpICYgMV0gPSAwOw0KDQoJaWYgKGt2bV9taXBzX21hcF9wYWdlKGt2bSwgbWlwczNf
dGxicGZuX3RvX3BhZGRyKHRsYl9sb1swXSkNCgkJCQkgICA+PiBQQUdFX1NISUZUKSA8IDApDQoJ
CXJldHVybiAtMTsNCg0KCWlmIChrdm1fbWlwc19tYXBfcGFnZShrdm0sIG1pcHMzX3RsYnBmbl90
b19wYWRkcih0bGJfbG9bMV0pDQoJCQkJICAgPj4gUEFHRV9TSElGVCkgPCAwKQ0KCQlyZXR1cm4g
LTE7DQoNCglwZm4wID0ga3ZtLT5hcmNoLmd1ZXN0X3BtYXBbbWlwczNfdGxicGZuX3RvX3BhZGRy
KHRsYl9sb1swXSkNCgkJCQkgICAgPj4gUEFHRV9TSElGVF07DQoJcGZuMSA9IGt2bS0+YXJjaC5n
dWVzdF9wbWFwW21pcHMzX3RsYnBmbl90b19wYWRkcih0bGJfbG9bMV0pDQoJCQkJICAgID4+IFBB
R0VfU0hJRlRdOw0KDQoJaWYgKGhwYTApDQoJCSpocGEwID0gcGZuMCA8PCBQQUdFX1NISUZUOw0K
DQplcnJvcjogcGF0Y2ggZmFpbGVkOiBhcmNoL21pcHMva3ZtL3RsYi5jOjM3NA0KQXBwbHlpbmcg
cGF0Y2ggYXJjaC9taXBzL2t2bS90bGIuYyB3aXRoIDIgcmVqZWN0cy4uLg0KUmVqZWN0ZWQgaHVu
ayAjMS4NClJlamVjdGVkIGh1bmsgIzIuDQoNCg0KVGhhbmtzLA0KU2FzaGE=
