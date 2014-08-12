Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2014 15:42:13 +0200 (CEST)
Received: from ec2-54-194-5-104.eu-west-1.compute.amazonaws.com ([54.194.5.104]:53211
        "EHLO smtpbgie2.qq.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818317AbaHLNmGjTHF4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Aug 2014 15:42:06 +0200
X-QQ-GoodBg: 0
X-QQ-SSF: 0010000000B000F0
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 49.75.173.2
X-QQ-STYLE: 
X-QQ-mid: bizmail38t1407850866t4853563
From:   "=?utf-8?B?6ZmI5Y2O5omN?=" <chenhc@lemote.com>
To:     "=?utf-8?B?d2VpeWpfbGs=?=" <weiyj_lk@163.com>,
        "=?utf-8?B?UmFsZiBCYWVjaGxl?=" <ralf@linux-mips.org>
Cc:     "=?utf-8?B?V2VpIFlvbmdqdW4=?=" <yongjun_wei@trendmicro.com.cn>,
        "=?utf-8?B?bGludXgtbWlwcw==?=" <linux-mips@linux-mips.org>,
        "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: Re:[PATCH -next] MIPS: Remove duplicated include from numa.c
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Tue, 12 Aug 2014 21:41:06 +0800
X-Priority: 3
Message-ID: <tencent_21B4C02448BEE43D0A470063@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <1407846382-29951-1-git-send-email-weiyj_lk@163.com>
In-Reply-To: <1407846382-29951-1-git-send-email-weiyj_lk@163.com>
X-QQ-ReplyHash: 3719488126
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41986
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

UmV2aWV3ZWQtb2ZmLWJ5OiBIdWFjYWkgQ2hlbiA8Y2hlbmhjQGxlbW90ZS5jb20+DQogDQot
LS0tLS0tLS0tLS0tLS0tLS0gT3JpZ2luYWwgLS0tLS0tLS0tLS0tLS0tLS0tDQpGcm9tOiAg
IndlaXlqX2xrIjx3ZWl5al9sa0AxNjMuY29tPjsNCkRhdGU6ICBUdWUsIEF1ZyAxMiwgMjAx
NCAwODoyNiBQTQ0KVG86ICAiUmFsZiBCYWVjaGxlIjxyYWxmQGxpbnV4LW1pcHMub3JnPjsg
Ikh1YWNhaSBDaGVuIjxjaGVuaGNAbGVtb3RlLmNvbT47IA0KQ2M6ICAiV2VpIFlvbmdqdW4i
PHlvbmdqdW5fd2VpQHRyZW5kbWljcm8uY29tLmNuPjsgImxpbnV4LW1pcHMiPGxpbnV4LW1p
cHNAbGludXgtbWlwcy5vcmc+OyAibGludXgta2VybmVsIjxsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnPjsgDQpTdWJqZWN0OiAgW1BBVENIIC1uZXh0XSBNSVBTOiBSZW1vdmUgZHVw
bGljYXRlZCBpbmNsdWRlIGZyb20gbnVtYS5jDQoNCiANCkZyb206IFdlaSBZb25nanVuIDx5
b25nanVuX3dlaUB0cmVuZG1pY3JvLmNvbS5jbj4NCg0KUmVtb3ZlIGR1cGxpY2F0ZWQgaW5j
bHVkZS4NCg0KU2lnbmVkLW9mZi1ieTogV2VpIFlvbmdqdW4gPHlvbmdqdW5fd2VpQHRyZW5k
bWljcm8uY29tLmNuPg0KLS0tDQogYXJjaC9taXBzL2xvb25nc29uL2xvb25nc29uLTMvbnVt
YS5jIHwgMiAtLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0t
Z2l0IGEvYXJjaC9taXBzL2xvb25nc29uL2xvb25nc29uLTMvbnVtYS5jIGIvYXJjaC9taXBz
L2xvb25nc29uL2xvb25nc29uLTMvbnVtYS5jDQppbmRleCBjYTAyNWE2Li4zN2VkMTg0IDEw
MDY0NA0KLS0tIGEvYXJjaC9taXBzL2xvb25nc29uL2xvb25nc29uLTMvbnVtYS5jDQorKysg
Yi9hcmNoL21pcHMvbG9vbmdzb24vbG9vbmdzb24tMy9udW1hLmMNCkBAIC0yNCw4ICsyNCw2
IEBADQogI2luY2x1ZGUgPGFzbS9wYWdlLmg+DQogI2luY2x1ZGUgPGFzbS9wZ2FsbG9jLmg+
DQogI2luY2x1ZGUgPGFzbS9zZWN0aW9ucy5oPg0KLSNpbmNsdWRlIDxsaW51eC9ib290bWVt
Lmg+DQotI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4NCiAjaW5jbHVkZSA8bGludXgvaXJxLmg+
DQogI2luY2x1ZGUgPGFzbS9ib290aW5mby5oPg0KICNpbmNsdWRlIDxhc20vbWMxNDY4MTgt
dGltZS5oPg==


28c	
