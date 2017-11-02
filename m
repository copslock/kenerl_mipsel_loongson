Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 09:49:10 +0100 (CET)
Received: from mx.socionext.com ([202.248.49.38]:53046 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993306AbdKBIs4ThAuA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 09:48:56 +0100
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 02 Nov 2017 17:48:47 +0900
Received: from mail.mfilter.local (unknown [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 2FD8961128;
        Thu,  2 Nov 2017 17:48:47 +0900 (JST)
Received: from 10.213.24.1 (10.213.24.1) by m-FILTER with ESMTP; Thu, 2 Nov 2017 17:48:47 +0900
Received: from SOC-EX01V.e01.socionext.com (10.213.24.21) by
 SOC-EX03V.e01.socionext.com (10.213.24.23) with Microsoft SMTP Server (TLS)
 id 15.0.995.29; Thu, 2 Nov 2017 17:48:46 +0900
Received: from SOC-EX01V.e01.socionext.com ([10.213.24.21]) by
 SOC-EX01V.e01.socionext.com ([10.213.24.21]) with mapi id 15.00.0995.028;
 Thu, 2 Nov 2017 17:48:46 +0900
From:   <yamada.masahiro@socionext.com>
To:     <arnd@arndb.de>
CC:     <devicetree@vger.kernel.org>, <robh@kernel.org>,
        <linux-arch@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-kbuild@vger.kernel.org>, <linux@armlinux.org.uk>,
        <ralf@linux-mips.org>, <pantelis.antoniou@gmail.com>,
        <mark.rutland@arm.com>, <frowand.list@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2] kbuild: clean up *.dtb and *.dtb.S patterns from
 top-level Makefile
Thread-Topic: [PATCH v2] kbuild: clean up *.dtb and *.dtb.S patterns from
 top-level Makefile
Thread-Index: AQHTU4WwdVd5sA1N90uYr4RyvgWK6KMALfOAgACXsKA=
Date:   Thu, 2 Nov 2017 08:48:46 +0000
Message-ID: <bb7c1a637afa47e8943ce494798f957c@SOC-EX01V.e01.socionext.com>
References: <1509591085-23940-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK8P3a3FoRJeO=TQGMRf6t4-bP8nP6KUEhkCrHP6L8XaF1Ee7g@mail.gmail.com>
In-Reply-To: <CAK8P3a3FoRJeO=TQGMRf6t4-bP8nP6KUEhkCrHP6L8XaF1Ee7g@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: POLICY170302
x-originating-ip: [10.213.24.1]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60658
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yamada.masahiro@socionext.com
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

SGkgQXJuZCwNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFybmRi
ZXJnbWFubkBnbWFpbC5jb20gW21haWx0bzphcm5kYmVyZ21hbm5AZ21haWwuY29tXSBPbiBCZWhh
bGYgT2YNCj4gQXJuZCBCZXJnbWFubg0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMDIsIDIw
MTcgNTozOCBQTQ0KPiBUbzogWWFtYWRhLCBNYXNhaGlyby/lsbHnlLAg55yf5byYIDx5YW1hZGEu
bWFzYWhpcm9Ac29jaW9uZXh0LmNvbT4NCj4gQ2M6IERUTUwgPGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47DQo+IGxpbnV4LWFyY2ggPGxp
bnV4LWFyY2hAdmdlci5rZXJuZWwub3JnPjsgb3BlbiBsaXN0OlJBTElOSyBNSVBTDQo+IEFSQ0hJ
VEVDVFVSRSA8bGludXgtbWlwc0BsaW51eC1taXBzLm9yZz47IExpbnV4IEtidWlsZCBtYWlsaW5n
IGxpc3QNCj4gPGxpbnV4LWtidWlsZEB2Z2VyLmtlcm5lbC5vcmc+OyBSdXNzZWxsIEtpbmcgPGxp
bnV4QGFybWxpbnV4Lm9yZy51az47DQo+IFJhbGYgQmFlY2hsZSA8cmFsZkBsaW51eC1taXBzLm9y
Zz47IFBhbnRlbGlzIEFudG9uaW91DQo+IDxwYW50ZWxpcy5hbnRvbmlvdUBnbWFpbC5jb20+OyBN
YXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPjsNCj4gRnJhbmsgUm93YW5kIDxmcm93
YW5kLmxpc3RAZ21haWwuY29tPjsgTGludXggQVJNDQo+IDxsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIGtidWlsZDogY2xlYW4g
dXAgKi5kdGIgYW5kICouZHRiLlMgcGF0dGVybnMgZnJvbQ0KPiB0b3AtbGV2ZWwgTWFrZWZpbGUN
Cj4gDQo+IE9uIFRodSwgTm92IDIsIDIwMTcgYXQgMzo1MSBBTSwgTWFzYWhpcm8gWWFtYWRhDQo+
IDx5YW1hZGEubWFzYWhpcm9Ac29jaW9uZXh0LmNvbT4gd3JvdGU6DQo+ID4gV2UgbmVlZCB0byBh
ZGQgImNsZWFuLWZpbGVzIiBpbiBNYWtmaWxlcyB0byBjbGVhbiB1cCBEVCBibG9icywgYnV0IHdl
DQo+ID4gb2Z0ZW4gbWlzcyB0byBkbyBzby4NCj4gPg0KPiA+IFNpbmNlIHRoZXJlIGFyZSBubyBz
b3VyY2UgZmlsZXMgdGhhdCBlbmQgd2l0aCAuZHRiIG9yIC5kdGIuUywgc28gd2UNCj4gPiBjYW4g
Y2xlYW4tdXAgdGhvc2UgZmlsZXMgZnJvbSB0aGUgdG9wLWxldmVsIE1ha2VmaWxlLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogTWFzYWhpcm8gWWFtYWRhIDx5YW1hZGEubWFzYWhpcm9Ac29jaW9u
ZXh0LmNvbT4NCj4gDQo+IEFja2VkLWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0K
PiANCj4gDQo+IE9uIGEgKGJhcmVseSkgcmVsYXRlZCBub3RlLCBJJ20gc3RydWdnbGluZyB3aXRo
IGFub3RoZXIgcHJvYmxlbSBpbiB0aGUNCj4gd2F5IHdlIGhhbmRsZQ0KPiB0aGUgLmR0YiBmaWxl
cyBpbiBhcm02NCB3aGVuIENPTkZJR19PRl9BTExfRFRCUyBpcyBlbmFibGVkOiB3aGVuIGJ1aWxk
aW5nDQo+IG9uIGEgbG90IG9mIENQVXMsIHdlIHRyeSB0byBidWlsZCB0aGUgc2FtZSBmaWxlcyBm
cm9tIGJvdGgNCj4gYXJjaC9hcm02NC9ib290L2R0cy9NYWtlZmlsZQ0KPiBhbmQgYXJjaC9hcm02
NC9ib290L2R0cy8qL01ha2VmaWxlLCB3aGljaCB0aGVuIHJlc3VsdHMgaW4gYSBmYWlsZWQNCj4g
YnVpbGQgd2hlbiB3cml0aW5nDQo+IHRoZSB0ZW1wb3JhcnkgZmlsZXMuDQo+IA0KPiBJIGhhdmUg
Y29tZSB1cCB3aXRoIGEgd29ya2Fyb3VuZCB0aGF0IEkgdXNlIGxvY2FsbHksIGJ1dCBpdCBzZWVt
ZWQgdG9vIHVnbHkNCj4gdG8NCj4gc3VibWl0IHRoYXQgZm9yIGluY2x1c2lvbi4gTWF5YmUgeW91
IGNhbiBjb21lIHVwIHdpdGggYSBuaWNlciBhIHNvbHV0aW9uDQo+IGZvcg0KPiB0aGlzIGFzIHdl
bGw/DQo+IA0KPiAgICAgICBBcm5kDQoNClllYWgsIEkgaGFkIGFsc28gbm90aWNlZCB0aGlzIHJh
Y2UgcHJvYmxlbSBvbiBwYXJhbGxlbCBidWlsZGluZw0Kd2l0aCBDT05GSUdfT0ZfQUxMX0RUQlMu
DQoNCkkgd2FzIHBsYW5uaW5nIHRvIGRvIGl0DQp3aGVuIEkgY29tZSB1cCB3aXRoIGEgY2xlYW4g
aW1wbGVtZW50YXRpb24uDQoNCk9uZSBpZGVhIGlzIHRvIGhhbmRsZSBkdGIteSBhbmQgQ09ORklH
X09GX0FMTF9EVEJTDQpuYXRpdmVseSBpbiBzY3JpcHRzL01ha2VmaWxlLmJ1aWxkIG9yIHNvbWV3
aGVyZQ0KYXMgc2NyaXB0cy9NYWtlZmlsZS5kdGJpbnN0IGFscmVhZHkgcmVjb2duaXplcyBkdGIt
eSBhcyBhIHNwZWNpYWwgdmFyaWFibGUuDQoNCg==
