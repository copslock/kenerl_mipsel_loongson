Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Mar 2014 13:08:24 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.89.28.115]:52000 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823120AbaCNMIU5Hj2L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Mar 2014 13:08:20 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8365D4E9F5600;
        Fri, 14 Mar 2014 12:08:12 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Fri, 14 Mar 2014 12:08:14 +0000
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0174.001; Fri, 14 Mar 2014 12:08:14 +0000
From:   Qais Yousef <Qais.Yousef@imgtec.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Ralf Baechle (ralf@linux-mips.org)" <ralf@linux-mips.org>
Subject: RE: [PATCH v2] mips/include/asm/mipsregs.h: include linux/types.h
Thread-Topic: [PATCH v2] mips/include/asm/mipsregs.h: include linux/types.h
Thread-Index: AQHO9MQBVSoSkhh8OU6mAEq/bcnOUprhEOxA
Date:   Fri, 14 Mar 2014 12:08:13 +0000
Message-ID: <392C4BDEFF12D14FA57A3F30B283D7D14152C8@LEMAIL01.le.imgtec.org>
References: <1386582585-20867-1-git-send-email-qais.yousef@imgtec.com>
In-Reply-To: <1386582585-20867-1-git-send-email-qais.yousef@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.154.95]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Qais.Yousef@imgtec.com
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

Q2FuIHdlIGluY2x1ZGUgdGhpcyBwYXRjaCBpbiB0aGUgbmV4dCAzLjEwIGFuZCBmb3J3YXJkIHN0
YWJsZSByZWxlYXNlcyBwbGVhc2U/DQoNCkl0J3MgYWxyZWFkeSBpbiBMaW51cycgdHJlZSB1bmRl
ciBjb21taXQgaWQ6IDg3Yzk5MjAzZmVhODk3ZmJkZDg0YjY4MWFkOWZjZWQyNTE3ZGNmOTgNCg0K
VGhhbmtzLA0KUWFpcw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFFh
aXMgWW91c2VmDQo+IFNlbnQ6IDA5IERlY2VtYmVyIDIwMTMgMDk6NTANCj4gVG86IGxpbnV4LW1p
cHNAbGludXgtbWlwcy5vcmcNCj4gQ2M6IFFhaXMgWW91c2VmDQo+IFN1YmplY3Q6IFtQQVRDSCB2
Ml0gbWlwcy9pbmNsdWRlL2FzbS9taXBzcmVncy5oOiBpbmNsdWRlIGxpbnV4L3R5cGVzLmgNCj4g
DQo+IFRoZSBmaWxlIHVzZXMgdTE2IHR5cGUgYnV0IGRvZXNuJ3QgaW5jbHVkZSBpdHMgZGVmaW5p
dGlvbiBleHBsaWNpdGx5DQo+IA0KPiBJIHdhcyBnZXR0aW5nIHRoaXMgZXJyb3Igd2hlbiBpbmNs
dWRpbmcgdGhpcyBoZWFkZXIgaW4gbXkgZHJpdmVyOg0KPiANCj4gICBhcmNoL21pcHMvaW5jbHVk
ZS9hc20vbWlwc3JlZ3MuaDo2NDQ6MzM6IGVycm9yOiB1bmtub3duIHR5cGUgbmFtZSDigJh1MTbi
gJkNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFFhaXMgWW91c2VmIDxxYWlzLnlvdXNlZkBpbWd0ZWMu
Y29tPg0KPiBSZXZpZXdlZC1ieTogU3RldmVuIEouIEhpbGwgPFN0ZXZlbi5IaWxsQGltZ3RlYy5j
b20+DQo+IC0tLQ0KPiBjaGFuZ2VzIHNpbmNlIHYxOg0KPiAJLSBpbmNsdWRlIGxpbnV4L3R5cGVz
LmggaW5zdGVhZCBvZiBzL3UxNi91bnNpZ25lZCBzaG9ydC8NCj4gCS0gYW1lbmQgY29tbWl0IG1l
c3NhZ2UgYWNjb3JkaW5nbHkNCj4gDQo+ICBhcmNoL21pcHMvaW5jbHVkZS9hc20vbWlwc3JlZ3Mu
aCB8ICAgIDEgKw0KPiAgMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDAgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9taXBzL2luY2x1ZGUvYXNtL21pcHNyZWdz
LmgNCj4gYi9hcmNoL21pcHMvaW5jbHVkZS9hc20vbWlwc3JlZ3MuaA0KPiBpbmRleCBlMDMzMTQx
Li44NjQ3OWJiIDEwMDY0NA0KPiAtLS0gYS9hcmNoL21pcHMvaW5jbHVkZS9hc20vbWlwc3JlZ3Mu
aA0KPiArKysgYi9hcmNoL21pcHMvaW5jbHVkZS9hc20vbWlwc3JlZ3MuaA0KPiBAQCAtMTQsNiAr
MTQsNyBAQA0KPiAgI2RlZmluZSBfQVNNX01JUFNSRUdTX0gNCj4gDQo+ICAjaW5jbHVkZSA8bGlu
dXgvbGlua2FnZS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+DQo+ICAjaW5jbHVkZSA8
YXNtL2hhemFyZHMuaD4NCj4gICNpbmNsdWRlIDxhc20vd2FyLmg+DQo+IA0KPiAtLQ0KPiAxLjcu
MQ0KDQo=
