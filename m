Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2015 16:00:05 +0100 (CET)
Received: from smtpbgbr1.qq.com ([54.207.19.206]:37934 "EHLO smtpbgbr1.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010483AbbAVPACPq2tt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Jan 2015 16:00:02 +0100
X-QQ-GoodBg: 0
X-QQ-SSF: 00100000000000F0
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 121.238.27.109
X-QQ-STYLE: 
X-QQ-mid: bizmail38t1421938764t9052118
From:   "=?utf-8?B?6ZmI5Y2O5omN?=" <chenhc@lemote.com>
To:     "=?utf-8?B?SHVhY2FpIENoZW4=?=" <chenhc@lemote.com>,
        "=?utf-8?B?UmFsZiBCYWVjaGxl?=" <ralf@linux-mips.org>
Cc:     "=?utf-8?B?Sm9obiBDcmlzcGlu?=" <john@phrozen.org>,
        "=?utf-8?B?U3RldmVuIEouIEhpbGw=?=" <Steven.Hill@imgtec.com>,
        "=?utf-8?B?bGludXgtbWlwcw==?=" <linux-mips@linux-mips.org>,
        "=?utf-8?B?RnV4aW4gWmhhbmc=?=" <zhangfx@lemote.com>,
        "=?utf-8?B?d3V6aGFuZ2ppbg==?=" <wuzhangjin@gmail.com>,
        "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: Re:[PATCH 1/2] MIPS: Hibernate: flush TLB entries earlier
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Thu, 22 Jan 2015 22:59:24 +0800
X-Priority: 3
Message-ID: <tencent_61CBDDE16BEF4EA42D44A313@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <1419215439-27900-1-git-send-email-chenhc@lemote.com>
In-Reply-To: <1419215439-27900-1-git-send-email-chenhc@lemote.com>
X-QQ-ReplyHash: 3295271689
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45433
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

SGksIFJhbGYsDQogDQpDYW4gdGhlc2UgdHdvIHBhdGNoZXMgYmUgbWVyZ2VkIGluIDMuMTk/
DQoNCkh1YWNhaQ0KIA0KLS0tLS0tLS0tLS0tLS0tLS0tIE9yaWdpbmFsIC0tLS0tLS0tLS0t
LS0tLS0tLQ0KRnJvbTogICJIdWFjYWkgQ2hlbiI8Y2hlbmhjQGxlbW90ZS5jb20+Ow0KRGF0
ZTogIE1vbiwgRGVjIDIyLCAyMDE0IDEwOjMwIEFNDQpUbzogICJSYWxmIEJhZWNobGUiPHJh
bGZAbGludXgtbWlwcy5vcmc+Ow0KQ2M6ICAiSm9obiBDcmlzcGluIjxqb2huQHBocm96ZW4u
b3JnPjsgIlN0ZXZlbiBKLiBIaWxsIjxTdGV2ZW4uSGlsbEBpbWd0ZWMuY29tPjsgImxpbnV4
LW1pcHMiPGxpbnV4LW1pcHNAbGludXgtbWlwcy5vcmc+OyAiRnV4aW4gWmhhbmciPHpoYW5n
ZnhAbGVtb3RlLmNvbT47ICJ3dXpoYW5namluIjx3dXpoYW5namluQGdtYWlsLmNvbT47ICJI
dWFjYWkgQ2hlbiI8Y2hlbmhjQGxlbW90ZS5jb20+OyAic3RhYmxlIjxzdGFibGVAdmdlci5r
ZXJuZWwub3JnPjsNClN1YmplY3Q6ICBbUEFUQ0ggMS8yXSBNSVBTOiBIaWJlcm5hdGU6IGZs
dXNoIFRMQiBlbnRyaWVzIGVhcmxpZXINCiANCldlIGZvdW5kIHRoYXQgVExCIG1pc21hdGNo
IG5vdCBvbmx5IGhhcHBlbnMgYWZ0ZXIga2VybmVsIHJlc3VtZSwgYnV0DQphbHNvIGhhcHBl
bnMgZHVyaW5nIHNuYXBzaG90IHJlc3RvcmUuIFNvIG1vdmUgaXQgdG8gdGhlIGJlZ2lubmlu
ZyBvZg0Kc3dzdXNwX2FyY2hfc3VzcGVuZCgpLg0KDQpDYzogPHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBIdWFjYWkgQ2hlbiA8Y2hlbmhjQGxlbW90ZS5jb20+
DQotLS0NCiBhcmNoL21pcHMvcG93ZXIvaGliZXJuYXRlLlMgfCAgICAzICsrLQ0KIDEgZmls
ZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0t
Z2l0IGEvYXJjaC9taXBzL3Bvd2VyL2hpYmVybmF0ZS5TIGIvYXJjaC9taXBzL3Bvd2VyL2hp
YmVybmF0ZS5TDQppbmRleCAzMmE3YzgyLi5lNzU2N2M4IDEwMDY0NA0KLS0tIGEvYXJjaC9t
aXBzL3Bvd2VyL2hpYmVybmF0ZS5TDQorKysgYi9hcmNoL21pcHMvcG93ZXIvaGliZXJuYXRl
LlMNCkBAIC0zMCw2ICszMCw4IEBAIExFQUYoc3dzdXNwX2FyY2hfc3VzcGVuZCkNCiBFTkQo
c3dzdXNwX2FyY2hfc3VzcGVuZCkNCiANCiBMRUFGKHN3c3VzcF9hcmNoX3Jlc3VtZSkNCisJ
LyogQXZvaWQgVExCIG1pc21hdGNoIGR1cmluZyBhbmQgYWZ0ZXIga2VybmVsIHJlc3VtZSAq
Lw0KKwlqYWwgbG9jYWxfZmx1c2hfdGxiX2FsbA0KIAlQVFJfTCB0MCwgcmVzdG9yZV9wYmxp
c3QNCiAwOg0KIAlQVFJfTCB0MSwgUEJFX0FERFJFU1ModDApICAgLyogc291cmNlICovDQpA
QCAtNDMsNyArNDUsNiBAQCBMRUFGKHN3c3VzcF9hcmNoX3Jlc3VtZSkNCiAJYm5lIHQxLCB0
MywgMWINCiAJUFRSX0wgdDAsIFBCRV9ORVhUKHQwKQ0KIAlibmV6IHQwLCAwYg0KLQlqYWwg
bG9jYWxfZmx1c2hfdGxiX2FsbCAvKiBBdm9pZCBUTEIgbWlzbWF0Y2ggYWZ0ZXIga2VybmVs
IHJlc3VtZSAqLw0KIAlQVFJfTEEgdDAsIHNhdmVkX3JlZ3MNCiAJUFRSX0wgcmEsIFBUX1Iz
MSh0MCkNCiAJUFRSX0wgc3AsIFBUX1IyOSh0MCkNCi0tIA0KMS43LjcuMw==
