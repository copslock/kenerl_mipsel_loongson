Return-Path: <SRS0=MCbt=SR=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7659C10F0E
	for <linux-mips@archiver.kernel.org>; Mon, 15 Apr 2019 17:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB2120656
	for <linux-mips@archiver.kernel.org>; Mon, 15 Apr 2019 17:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="aicqghm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfDOR2e (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:28:34 -0400
Received: from mail-eopbgr750115.outbound.protection.outlook.com ([40.107.75.115]:48965
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726980AbfDOR2d (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 15 Apr 2019 13:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11hpBDG5lmAUSm1azL/9rmzRcBH6muBA8JjSI3YDYK8=;
 b=aicqghm7sF6MuIbr5reM+5mJ848xlTOQwAdQMa8QL7XgLZX1kzjzZIgpMeRIn07AotK54QKrYZKExe/cT9Daa1QPfEWUo9u2PWimbvyHNN7EcksbrqK709+jigRL8Vmv2LDLg+e0A9LITAsUyICyo1hZwbxJ6fbJdDxDQ4hMKHU=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1581.namprd22.prod.outlook.com (10.174.167.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.18; Mon, 15 Apr 2019 17:28:29 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%7]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 17:28:29 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     =?utf-8?B?UGV0ciDFoHRldGlhcg==?= <ynezz@true.cz>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        John Crispin <john@phrozen.org>
Subject: Re: [PATCH v2] MIPS: perf: ath79: Fix perfcount IRQ assignment
Thread-Topic: [PATCH v2] MIPS: perf: ath79: Fix perfcount IRQ assignment
Thread-Index: AQHU8XPq46qITC5HyUGq8suZ70CawKY9flcA
Date:   Mon, 15 Apr 2019 17:28:29 +0000
Message-ID: <20190415172822.33cgvdhk7mtswzmx@pburton-laptop>
References: <1555006009-5764-1-git-send-email-ynezz@true.cz>
 <1555103312-28232-1-git-send-email-ynezz@true.cz>
In-Reply-To: <1555103312-28232-1-git-send-email-ynezz@true.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0059.namprd02.prod.outlook.com
 (2603:10b6:a03:54::36) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55e1ee09-30af-49e9-4888-08d6c1c7c626
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR2201MB1581;
x-ms-traffictypediagnostic: MWHPR2201MB1581:
x-microsoft-antispam-prvs: <MWHPR2201MB158130C29F4C3051150FF2B2C12B0@MWHPR2201MB1581.namprd22.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(136003)(39840400004)(346002)(366004)(396003)(199004)(189003)(386003)(1076003)(6512007)(76176011)(44832011)(53936002)(33716001)(14454004)(71190400001)(81156014)(81166006)(97736004)(2906002)(9686003)(8936002)(6506007)(8676002)(229853002)(71200400001)(6116002)(42882007)(3846002)(478600001)(66066001)(25786009)(486006)(6486002)(26005)(11346002)(186003)(316002)(54906003)(58126008)(476003)(446003)(6436002)(52116002)(4326008)(5660300002)(6916009)(105586002)(68736007)(102836004)(7736002)(256004)(6246003)(106356001)(99286004)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1581;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KyTUGoDvxvcJu3qf8Wunsp239ofSl9zt+/BpDArafNqYuB/JZxsVkgNZXt7GDseN8gIu2h1Ef0PFqlL1k6S6AaKVyyMKaaym/PCmaFhy9nZq1ICmaabZR0DQeE8ITjoW46B4/m37iX0tZT22rqA1ZF2jtEvybHCN81Axsmv5l5Dt7csBirm2lYJ1Ae/meKdSKI8s0QGe+JVXsgalsNklmGR0I+fs2dz0W1IEj29INdOuo0xTaMowvnbHsrQrEnm20iufz6wzOTmHpjlV4qbB3r8rlHF2SzXICRi78hqHBL0pyiQQZ7tnbp+AldcLZWxlxGwagQaU7GUQK+Kilaqfscsugu2qykgdm350pAQrmupNeqo0Wwn+WAbZbqb8I6BR0IgoW0sccPrcvPcgfZRpMCXYQgMAcI3oJYoCo3Al8/Y=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DEDA6EE1678044E8A206C8F02CF29EA@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e1ee09-30af-49e9-4888-08d6c1c7c626
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 17:28:29.3540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1581
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

SGVsbG8sDQoNCk9uIEZyaSwgQXByIDEyLCAyMDE5IGF0IDExOjA4OjMyUE0gKzAyMDAsIFBldHIg
xaB0ZXRpYXIgd3JvdGU6DQo+IEN1cnJlbnRseSBpdCdzIG5vdCBwb3NzaWJsZSB0byB1c2UgcGVy
ZiBvbiBhdGg3OSBkdWUgdG8gZ2VuaXJxIGZsYWdzDQo+IG1pc21hdGNoIGhhcHBlbmluZyBvbiBz
dGF0aWMgdmlydHVhbCBJUlEgMTMgd2hpY2ggaXMgdXNlZCBmb3INCj4gcGVyZm9ybWFuY2UgY291
bnRlcnMgaGFyZHdhcmUgSVJRIDUuDQo+IA0KPiBPbiBUUC1MaW5rIEFyY2hlciBDN3Y1Og0KPiAN
Cj4gICAgICAgICAgICBDUFUwDQo+ICAgMjogICAgICAgICAgMCAgICAgIE1JUFMgICAyICBhdGg5
aw0KPiAgIDQ6ICAgICAgICAzMTggICAgICBNSVBTICAgNCAgMTkwMDAwMDAuZXRoDQo+ICAgNzog
ICAgICA1NTAzNCAgICAgIE1JUFMgICA3ICB0aW1lcg0KPiAgIDg6ICAgICAgIDEyMzYgICAgICBN
SVNDICAgMyAgdHR5UzANCj4gIDEyOiAgICAgICAgICAwICAgICAgSU5UQyAgIDEgIGVoY2lfaGNk
OnVzYjENCj4gIDEzOiAgICAgICAgICAwICBncGlvLWF0aDc5ICAgMiAga2V5cw0KPiAgMTQ6ICAg
ICAgICAgIDAgIGdwaW8tYXRoNzkgICA1ICBrZXlzDQo+ICAxNTogICAgICAgICAzMSAgQVI3MjRY
IFBDSSAgICAxICBhdGgxMGtfcGNpDQo+IA0KPiAgJCBwZXJmIHRvcA0KPiAgZ2VuaXJxOiBGbGFn
cyBtaXNtYXRjaCBpcnEgMTMuIDAwMDE0YzgzIChtaXBzX3BlcmZfcG11KSB2cy4gMDAwMDIwMDMg
KGtleXMpDQo+IA0KPiBPbiBUUC1MaW5rIEFyY2hlciBDN3Y0Og0KPiANCj4gICAgICAgICAgQ1BV
MA0KPiAgIDQ6ICAgICAgICAgIDAgICAgICBNSVBTICAgNCAgMTkwMDAwMDAuZXRoDQo+ICAgNTog
ICAgICAgNzEzNSAgICAgIE1JUFMgICA1ICAxYTAwMDAwMC5ldGgNCj4gICA3OiAgICAgIDk4Mzc5
ICAgICAgTUlQUyAgIDcgIHRpbWVyDQo+ICAgODogICAgICAgICAzMCAgICAgIE1JU0MgICAzICB0
dHlTMA0KPiAgMTI6ICAgICAgOTAwMjggICAgICBJTlRDICAgMCAgYXRoOWsNCj4gIDEzOiAgICAg
ICA1NTIwICAgICAgSU5UQyAgIDEgIGVoY2lfaGNkOnVzYjENCj4gIDE0OiAgICAgICA0NjIzICAg
ICAgSU5UQyAgIDIgIGVoY2lfaGNkOnVzYjINCj4gIDE1OiAgICAgIDMyODQ0ICBBUjcyNFggUENJ
ICAgIDEgIGF0aDEwa19wY2kNCj4gIDE2OiAgICAgICAgICAwICBncGlvLWF0aDc5ICAxNiAga2V5
cw0KPiAgMjM6ICAgICAgICAgIDAgIGdwaW8tYXRoNzkgIDIzICBrZXlzDQo+IA0KPiAgJCBwZXJm
IHRvcA0KPiAgZ2VuaXJxOiBGbGFncyBtaXNtYXRjaCBpcnEgMTMuIDAwMDE0YzgwIChtaXBzX3Bl
cmZfcG11KSB2cy4gMDAwMDAwODAgKGVoY2lfaGNkOnVzYjEpDQo+IA0KPiBUaGlzIHByb2JsZW0g
aXMgaGFwcGVuaW5nLCBiZWNhdXNlIGN1cnJlbnRseSBzdGF0aWNhbGx5IGFzc2lnbmVkIHZpcnR1
YWwNCj4gSVJRIDEzIGZvciBwZXJmb3JtYW5jZSBjb3VudGVycyBpcyBub3QgY2xhaW1lZCBkdXJp
bmcgdGhlIGluaXRpYWxpemF0aW9uDQo+IG9mIE1JUFMgUE1VIGR1cmluZyB0aGUgYm9vdHVwLCBz
byB0aGUgSVJRIHN1YnN5c3RlbSBkb2Vzbid0IGtub3csIHRoYXQNCj4gdGhpcyBpbnRlcnJ1cHQg
aXNuJ3QgYXZhaWxhYmxlIGZvciBmdXJ0aGVyIHVzZS4NCj4gDQo+IFNvIHRoaXMgcGF0Y2ggZml4
ZXMgdGhlIGlzc3VlIGJ5IHNpbXBseSBib29raW5nIGhhcmR3YXJlIElSUSA1IGZvciBNSVBTIFBN
VS4NCj4gDQo+IFRlc3RlZC1ieTogS2V2aW4gJ2xkaXInIERhcmJ5c2hpcmUtQnJ5YW50IDxsZGly
QGRhcmJ5c2hpcmUtYnJ5YW50Lm1lLnVrPg0KPiBTaWduZWQtb2ZmLWJ5OiBQZXRyIMWgdGV0aWFy
IDx5bmV6ekB0cnVlLmN6Pg0KPiAtLS0NCj4gDQo+IENoYW5nZXMgc2luY2UgdjE6DQo+IA0KPiAg
SSd2ZSBpbmNvcnBvcmF0ZWQgdHdvIGNvbW1lbnRzIHdoaWNoIEkndmUgcmVjZWl2ZWQgb24gSVJD
IGZyb20gYmxvZ2ljIGFuZA0KPiAgSSd2ZSBhbHNvIHJld29yZGVkIHRoZSBjb21taXQgbWVzc2Fn
ZSB0byBtYXRjaCB0aGUgY2hhbmdlcyBpbiB2MiBvZiB0aGlzDQo+ICBwYXRjaC4NCj4gDQo+ICAg
KiB1c2UgYWN0dWFsIGhhcmR3YXJlIHBlcmZjb3VudCBJUlEgNSBpbnN0ZWFkIG9mIHRoZSB2aXJ0
dWFsIElSUSAxMw0KPiAgICogZHJvcHBlZCB0aGUgQ09ORklHX1BFUkZfRVZFTlRTIGlmZGVmIGFy
b3VuZCBpcnFfY3JlYXRlX21hcHBpbmcNCj4gDQo+ICBhcmNoL21pcHMvYXRoNzkvc2V0dXAuYyAg
ICAgICAgICB8ICA2IC0tLS0tLQ0KPiAgZHJpdmVycy9pcnFjaGlwL2lycS1hdGg3OS1taXNjLmMg
fCAxMSArKysrKysrKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA2
IGRlbGV0aW9ucygtKQ0KDQpUaGlzIGNoYW5nZSBsb29rcyByZWFzb25hYmxlIHRvIG1lIC0gSSdk
IGJlIGhhcHB5IHRvIHRha2UgaXQgdGhyb3VnaA0KbWlwcy1maXhlcyB3aXRoIGFuIGFjayBmcm9t
IGFuIGlycWNoaXAgZHJpdmVyIG1haW50YWluZXIsIG9yIEknbSBoYXBweQ0KZm9yIG9uZSBvZiB0
aGVtIHRvIHRha2UgaXQgaWYgdGhleSBwcmVmZXIgaW4gd2hpY2ggY2FzZToNCg0KICAgIEFja2Vk
LWJ5OiBQYXVsIEJ1cnRvbiA8cGF1bC5idXJ0b25AbWlwcy5jb20+DQoNClRoYW5rcywNCiAgICBQ
YXVsDQoNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL21pcHMvYXRoNzkvc2V0dXAuYyBiL2FyY2gv
bWlwcy9hdGg3OS9zZXR1cC5jDQo+IGluZGV4IDRhNzBjNWQuLjI1YTU3ODkgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gvbWlwcy9hdGg3OS9zZXR1cC5jDQo+ICsrKyBiL2FyY2gvbWlwcy9hdGg3OS9zZXR1
cC5jDQo+IEBAIC0yMTAsMTIgKzIxMCw2IEBAIGNvbnN0IGNoYXIgKmdldF9zeXN0ZW1fdHlwZSh2
b2lkKQ0KPiAgCXJldHVybiBhdGg3OV9zeXNfdHlwZTsNCj4gIH0NCj4gIA0KPiAtaW50IGdldF9j
MF9wZXJmY291bnRfaW50KHZvaWQpDQo+IC17DQo+IC0JcmV0dXJuIEFUSDc5X01JU0NfSVJRKDUp
Ow0KPiAtfQ0KPiAtRVhQT1JUX1NZTUJPTF9HUEwoZ2V0X2MwX3BlcmZjb3VudF9pbnQpOw0KPiAt
DQo+ICB1bnNpZ25lZCBpbnQgZ2V0X2MwX2NvbXBhcmVfaW50KHZvaWQpDQo+ICB7DQo+ICAJcmV0
dXJuIENQMF9MRUdBQ1lfQ09NUEFSRV9JUlE7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lycWNo
aXAvaXJxLWF0aDc5LW1pc2MuYyBiL2RyaXZlcnMvaXJxY2hpcC9pcnEtYXRoNzktbWlzYy5jDQo+
IGluZGV4IGFhNzI5MDcuLjAzOTA2MDMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaXJxY2hpcC9p
cnEtYXRoNzktbWlzYy5jDQo+ICsrKyBiL2RyaXZlcnMvaXJxY2hpcC9pcnEtYXRoNzktbWlzYy5j
DQo+IEBAIC0yMiw2ICsyMiwxNSBAQA0KPiAgI2RlZmluZSBBUjcxWFhfUkVTRVRfUkVHX01JU0Nf
SU5UX0VOQUJMRQk0DQo+ICANCj4gICNkZWZpbmUgQVRINzlfTUlTQ19JUlFfQ09VTlQJCQkzMg0K
PiArI2RlZmluZSBBVEg3OV9NSVNDX1BFUkZfSVJRCQkJNQ0KPiArDQo+ICtzdGF0aWMgaW50IGF0
aDc5X3BlcmZjb3VudF9pcnE7DQo+ICsNCj4gK2ludCBnZXRfYzBfcGVyZmNvdW50X2ludCh2b2lk
KQ0KPiArew0KPiArCXJldHVybiBhdGg3OV9wZXJmY291bnRfaXJxOw0KPiArfQ0KPiArRVhQT1JU
X1NZTUJPTF9HUEwoZ2V0X2MwX3BlcmZjb3VudF9pbnQpOw0KPiAgDQo+ICBzdGF0aWMgdm9pZCBh
dGg3OV9taXNjX2lycV9oYW5kbGVyKHN0cnVjdCBpcnFfZGVzYyAqZGVzYykNCj4gIHsNCj4gQEAg
LTExMyw2ICsxMjIsOCBAQCBzdGF0aWMgdm9pZCBfX2luaXQgYXRoNzlfbWlzY19pbnRjX2RvbWFp
bl9pbml0KA0KPiAgew0KPiAgCXZvaWQgX19pb21lbSAqYmFzZSA9IGRvbWFpbi0+aG9zdF9kYXRh
Ow0KPiAgDQo+ICsJYXRoNzlfcGVyZmNvdW50X2lycSA9IGlycV9jcmVhdGVfbWFwcGluZyhkb21h
aW4sIEFUSDc5X01JU0NfUEVSRl9JUlEpOw0KPiArDQo+ICAJLyogRGlzYWJsZSBhbmQgY2xlYXIg
YWxsIGludGVycnVwdHMgKi8NCj4gIAlfX3Jhd193cml0ZWwoMCwgYmFzZSArIEFSNzFYWF9SRVNF
VF9SRUdfTUlTQ19JTlRfRU5BQkxFKTsNCj4gIAlfX3Jhd193cml0ZWwoMCwgYmFzZSArIEFSNzFY
WF9SRVNFVF9SRUdfTUlTQ19JTlRfU1RBVFVTKTsNCj4gLS0gDQo+IDEuOS4xDQo+IA0K
