Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2015 08:13:05 +0200 (CEST)
Received: from smtpproxy19.qq.com ([184.105.206.84]:41421 "EHLO
        smtpproxy19.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010604AbbHGGNDSP6tG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Aug 2015 08:13:03 +0200
X-QQ-GoodBg: 0
X-QQ-SSF: 00100000000000F0
X-QQ-FEAT: 6hgywLD7RYVClGzMIVhdPZobUsjKRS2l0dvjyJ00CmFml8OfUgAnfxPZvVKNd
        19tNoYwVbTmqugPsAVHXkt4WeFxbfTRHYVxHZPSEz8iTkOvHU44q4wEb1BtkvSjoWw5uvhc
        M0ba597skaShHHuJVeHRvTx8uwCe8ONPLrvI7QPDAEZdY1DHQu3rH3x7gxZke8t3s5MJJMK
        UQYz5/UhAvg==
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 222.92.124.153
X-QQ-STYLE: 
X-QQ-mid: bizmail38t1438927961t5537449
From:   "=?utf-8?B?6ZmI5Y2O5omN?=" <chenhc@lemote.com>
To:     "=?utf-8?B?R3VlbnRlciBSb2Vjaw==?=" <linux@roeck-us.net>,
        "=?utf-8?B?UmFsZiBCYWVjaGxl?=" <ralf@linux-mips.org>
Cc:     "=?utf-8?B?bGludXgtbWlwcw==?=" <linux-mips@linux-mips.org>,
        "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>,
        "=?utf-8?B?R3VlbnRlciBSb2Vjaw==?=" <linux@roeck-us.net>
Subject: Re:[PATCH] mips: Fix console output for Fulong2e system
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Fri, 7 Aug 2015 14:12:41 +0800
X-Priority: 3
Message-ID: <tencent_37A9E5F5514586140D3774A8@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <1438927036-1435-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1438927036-1435-1-git-send-email-linux@roeck-us.net>
X-QQ-ReplyHash: 31781178
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48703
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

QWNrZWQtYnk6IEh1YWNhaSBDaGVuIDxjaGVuaGNAbGVtb3RlLmNvbT4NCiANCi0tLS0tLS0t
LS0tLS0tLS0tLSBPcmlnaW5hbCAtLS0tLS0tLS0tLS0tLS0tLS0NCkZyb206ICAiR3VlbnRl
ciBSb2VjayI8bGludXhAcm9lY2stdXMubmV0PjsNCkRhdGU6ICBGcmksIEF1ZyA3LCAyMDE1
IDAxOjU3IFBNDQpUbzogICJSYWxmIEJhZWNobGUiPHJhbGZAbGludXgtbWlwcy5vcmc+OyAN
CkNjOiAgIkh1YWNhaSBDaGVuIjxjaGVuaGNAbGVtb3RlLmNvbT47ICJsaW51eC1taXBzIjxs
aW51eC1taXBzQGxpbnV4LW1pcHMub3JnPjsgImxpbnV4LWtlcm5lbCI8bGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZz47ICJHdWVudGVyIFJvZWNrIjxsaW51eEByb2Vjay11cy5uZXQ+
OyANClN1YmplY3Q6ICBbUEFUQ0hdIG1pcHM6IEZpeCBjb25zb2xlIG91dHB1dCBmb3IgRnVs
b25nMmUgc3lzdGVtDQoNCiANCkNvbW1pdCAzYWRlYjI1NjZiOWIgKCJNSVBTOiBMb29uZ3Nv
bjogSW1wcm92ZSBMRUZJIGZpcm13YXJlIGludGVyZmFjZSIpDQptYWRlIHRoZSBudW1iZXIg
b2YgVUFSVHMgZHluYW1pYyBpZiBMRUZJX0ZJUk1XQVJFX0lOVEVSRkFDRSBpcyBjb25maWd1
cmVkLg0KVW5mb3J0dW5hdGVseSwgaXQgZGlkIG5vdCBpbml0aWFsaXplIHRoZSBudW1iZXIg
b2YgVUFSVHMgaWYNCkxFRklfRklSTVdBUkVfSU5URVJGQUNFIGlzIG5vdCBjb25maWd1cmVk
LiBBcyBhIHJlc3VsdCwgdGhlIEZ1bG9uZzJlDQpzeXN0ZW0gaGFzIG5vIGNvbnNvbGUuDQoN
CkZpeGVzOiAzYWRlYjI1NjZiOWIgKCJNSVBTOiBMb29uZ3NvbjogSW1wcm92ZSBMRUZJIGZp
cm13YXJlIGludGVyZmFjZSIpDQpDYzogSHVhY2FpIENoZW4gPGNoZW5oY0BsZW1vdGUuY29t
Pg0KU2lnbmVkLW9mZi1ieTogR3VlbnRlciBSb2VjayA8bGludXhAcm9lY2stdXMubmV0Pg0K
LS0tDQpOZXZlciBtaW5kIG15IGVhcmxpZXIgZS1tYWlsLCBJIGZpZ3VyZWQgaXQgb3V0Lg0K
U2hvdWxkIGJlIGEgY2FuZGlkYXRlIGZvciBzdGFibGUgKHYzLjE5KywgaWUgdjQuMSBpbiBw
cmFjdGljZSkuDQoNCiBhcmNoL21pcHMvbG9vbmdzb242NC9jb21tb24vZW52LmMgfCAzICsr
Kw0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2Fy
Y2gvbWlwcy9sb29uZ3NvbjY0L2NvbW1vbi9lbnYuYyBiL2FyY2gvbWlwcy9sb29uZ3NvbjY0
L2NvbW1vbi9lbnYuYw0KaW5kZXggZjZjNDRkZDMzMmUyLi5kNmQwN2FkNTYxODAgMTAwNjQ0
DQotLS0gYS9hcmNoL21pcHMvbG9vbmdzb242NC9jb21tb24vZW52LmMNCisrKyBiL2FyY2gv
bWlwcy9sb29uZ3NvbjY0L2NvbW1vbi9lbnYuYw0KQEAgLTY0LDYgKzY0LDkgQEAgdm9pZCBf
X2luaXQgcHJvbV9pbml0X2Vudih2b2lkKQ0KIAl9DQogCWlmIChtZW1zaXplID09IDApDQog
CQltZW1zaXplID0gMjU2Ow0KKw0KKwlsb29uZ3Nvbl9zeXNjb25mLm5yX3VhcnRzID0gMTsN
CisNCiAJcHJfaW5mbygibWVtc2l6ZT0ldSwgaGlnaG1lbXNpemU9JXVcbiIsIG1lbXNpemUs
IGhpZ2htZW1zaXplKTsNCiAjZWxzZQ0KIAlzdHJ1Y3QgYm9vdF9wYXJhbXMgKmJvb3RfcDsN
Ci0tIA0KMi4xLjQ=
