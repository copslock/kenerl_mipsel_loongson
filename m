Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Nov 2014 15:26:41 +0100 (CET)
Received: from smtpbg62.qq.com ([103.7.29.139]:35452 "EHLO smtpbg64.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27014010AbaKSO0iHMglR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Nov 2014 15:26:38 +0100
X-QQ-GoodBg: 0
X-QQ-SSF: 00100000000000F0
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 221.225.169.142
X-QQ-STYLE: 
X-QQ-mid: bizmail38t1416407159t7956962
From:   "=?utf-8?B?6ZmI5Y2O5omN?=" <chenhc@lemote.com>
To:     "=?utf-8?B?UmFsZiBCYWVjaGxl?=" <ralf@linux-mips.org>,
        "=?utf-8?B?QWxleGFuZHJlIENvdXJib3Q=?=" <gnurou@gmail.com>
Cc:     "=?utf-8?B?Sm9obiBDcmlzcGlu?=" <john@phrozen.org>,
        "=?utf-8?B?U3RldmVuIEouIEhpbGw=?=" <Steven.Hill@imgtec.com>,
        "=?utf-8?B?bGludXgtbWlwcw==?=" <linux-mips@linux-mips.org>,
        "=?utf-8?B?RnV4aW4gWmhhbmc=?=" <zhangfx@lemote.com>,
        "=?utf-8?B?d3V6aGFuZ2ppbg==?=" <wuzhangjin@gmail.com>,
        "=?utf-8?B?bGludXgtZ3Bpb0B2Z2VyLmtlcm5lbC5vcmc=?=" 
        <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH V4 2/6] MIPS: Move Loongson GPIO driver to drivers/gpio
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Wed, 19 Nov 2014 22:25:59 +0800
X-Priority: 3
Message-ID: <tencent_15D766A360D879F4553C1872@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <1415891560-8915-1-git-send-email-chenhc@lemote.com>
        <CAAVeFuKYgXhV_372FBQnArEFT4xEVB73P+yurJ9mF0CkKCx7eQ@mail.gmail.com>
        <CAAVeFuJoo3X9aNYdrn5TJ-PjTzvFuEm5QTPmKYMy9NyWFy1_WA@mail.gmail.com>
        <20141119101157.GB7213@linux-mips.org>
In-Reply-To: <20141119101157.GB7213@linux-mips.org>
X-QQ-ReplyHash: 1638269495
X-QQ-SENDSIZE: 520
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

SGksIFJhbGYgYW5kIEFsZXhhbmRyZSwNCg0KU28sIEkgbmVlZCB0aHJlZSBwYXRjaGVzOiBj
bGVhbiB1cCwgbW92ZSB0byBkcml2ZXJzL2dwaW8sIGFuZCBpbXByb3ZlIGl0IHRvIHN1cHBv
cnQgTG9vbnNvbi0zQS8zQj8NCg0KSHVhY2FpDQogDQogDQotLS0tLS0tLS0tLS0tLS0tLS0g
T3JpZ2luYWwgLS0tLS0tLS0tLS0tLS0tLS0tDQpGcm9tOiAgIlJhbGYgQmFlY2hsZSI8cmFs
ZkBsaW51eC1taXBzLm9yZz47DQpEYXRlOiAgV2VkLCBOb3YgMTksIDIwMTQgMDY6MTEgUE0N
ClRvOiAgIkFsZXhhbmRyZSBDb3VyYm90IjxnbnVyb3VAZ21haWwuY29tPjsNCkNjOiAgIkh1
YWNhaSBDaGVuIjxjaGVuaGNAbGVtb3RlLmNvbT47ICJKb2huIENyaXNwaW4iPGpvaG5AcGhy
b3plbi5vcmc+OyAiU3RldmVuIEouIEhpbGwiPFN0ZXZlbi5IaWxsQGltZ3RlYy5jb20+OyAi
bGludXgtbWlwcyI8bGludXgtbWlwc0BsaW51eC1taXBzLm9yZz47ICJGdXhpbiBaaGFuZyI8
emhhbmdmeEBsZW1vdGUuY29tPjsgInd1emhhbmdqaW4iPHd1emhhbmdqaW5AZ21haWwuY29t
PjsgImxpbnV4LWdwaW9Admdlci5rZXJuZWwub3JnIjxsaW51eC1ncGlvQHZnZXIua2VybmVs
Lm9yZz47DQpTdWJqZWN0OiAgUmU6IFtQQVRDSCBWNCAyLzZdIE1JUFM6IE1vdmUgTG9vbmdz
b24gR1BJTyBkcml2ZXIgdG8gZHJpdmVycy9ncGlvDQogDQpPbiBXZWQsIE5vdiAxOSwgMjAx
NCBhdCAwNToyMTo1NlBNICswOTAwLCBBbGV4YW5kcmUgQ291cmJvdCB3cm90ZToNCg0KPiA+
IE9uIEZyaSwgTm92IDE0LCAyMDE0IGF0IDEyOjEyIEFNLCBIdWFjYWkgQ2hlbiA8Y2hlbmhj
QGxlbW90ZS5jb20+IHdyb3RlOg0KPiA+PiBNb3ZlIExvb25nc29uLTIncyBHUElPIGRyaXZl
ciB0byBkcml2ZXJzL2dwaW8gYW5kIGFkZCBLY29uZmlnIG9wdGlvbnMuDQo+ID4NCj4gPiBB
Y2tlZC1ieTogQWxleGFuZHJlIENvdXJib3QgPGFjb3VyYm90QG52aWRpYS5jb20+DQo+ID4N
Cj4gPiBHdWVzcyB0aGlzIHNob3VsZCBnbyB0aHJvdWdoIHRoZSBHUElPIHRyZWUgb25jZSB0
aGUgcGxhdGZvcm0NCj4gPiBtYWludGFpbmVycyBoYXZlIGFja2VkIHRoaXM/DQo+IA0KPiBP
dWNoLiBBZnRlciBsb29raW5nIGF0IHRoaXMgZHJpdmVyJ3MgaW1wbGVtZW50YXRpb24gSSB0
aGluayBJIGhhdmUgdG8NCj4gdGFrZSBteSBBY2sgYmFjay4gVGhpcyBkcml2ZXIgY29tZXMg
d2l0aCBjdXN0b20gZGVmaW5pdGlvbnMgb2YNCj4gZ3Bpb19nZXRfdmFsdWUoKSBhbmQgb3Ro
ZXIgZnVuY3Rpb25zLCB3aGljaCB3ZSB3aWxsIHdhbnQgdG8gZ2V0IHJpZCBvZg0KPiBiZWZv
cmUgbW92aW5nIHRoaXMgaW50byBkcml2ZXJzL2dwaW8uIENhbiB5b3UgcG9ydCB0aGlzIHRv
IGEgcHJvcGVyDQo+IGdwaW9saWIgZHJpdmVyIGJlZm9yZSBkb2luZyB0aGUgbW92ZT8NCg0K
QXMgdGhlIGFyY2ggbWFpbnRhaW5lciBJJ20gaGFwcHkgdG8gc2F5IGZhcmV3ZWxsIHRvIGRy
aXZlciBjb2RlIGluIGFyY2gvbWlwcy4NCg0KQWxzbywgY2FuIHdlIHNwbGl0IHRoZSB3aG9s
ZSBwcm9jZWR1cmUgaW50byB0d28gcGF0Y2hlcywgb25lIGZvciB0aGUgY2xlYW51cA0KYW5k
IG9uZSBmb3IgdGhlIG1vdmU/ICBJIGRvbid0IGNhcmUgaW4gd2hpY2ggb3JkZXIuDQoNCiAg
UmFsZg==
