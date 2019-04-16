Return-Path: <SRS0=Z6Mo=SS=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDF5C10F13
	for <linux-mips@archiver.kernel.org>; Tue, 16 Apr 2019 22:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD1A20880
	for <linux-mips@archiver.kernel.org>; Tue, 16 Apr 2019 22:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="VE9WRHlR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfDPWKg (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 16 Apr 2019 18:10:36 -0400
Received: from mail-eopbgr760100.outbound.protection.outlook.com ([40.107.76.100]:18182
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726287AbfDPWKf (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 16 Apr 2019 18:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ag5BIczzLqC4PSeR3/KnyhPQYdcIQDMpYIrFF4nawro=;
 b=VE9WRHlR1v1X0MbscDb6QxPBw761VSKJiGPzjsTULrwInB9DnqQISApO5k3fnCRlyxrIbKuQ4zo7NGJd6fFYRfst+ixjhPefeS6hoSyCyYWa58+0TFORacejH/WyhmZeKfEQWOJNNiSDsL2g1m0jEzkMhZ7o+D1WTQkGBjrCNaQ=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1230.namprd22.prod.outlook.com (10.174.161.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Tue, 16 Apr 2019 22:10:26 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%7]) with mapi id 15.20.1792.018; Tue, 16 Apr 2019
 22:10:26 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     =?utf-8?B?UGV0ciDFoHRldGlhcg==?= <ynezz@true.cz>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        John Crispin <john@phrozen.org>,
        =?utf-8?B?UGV0ciDFoHRldGlhcg==?= <ynezz@true.cz>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v2] MIPS: perf: ath79: Fix perfcount IRQ assignment
Thread-Topic: [PATCH v2] MIPS: perf: ath79: Fix perfcount IRQ assignment
Thread-Index: AQHU8XPq46qITC5HyUGq8suZ70CawKY/X28A
Date:   Tue, 16 Apr 2019 22:10:25 +0000
Message-ID: <MWHPR2201MB12776250EC4360AB559C160DC1240@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <1555103312-28232-1-git-send-email-ynezz@true.cz>
In-Reply-To: <1555103312-28232-1-git-send-email-ynezz@true.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0104.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::45) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce54c0be-f4b4-4514-79d9-08d6c2b85367
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR2201MB1230;
x-ms-traffictypediagnostic: MWHPR2201MB1230:
x-microsoft-antispam-prvs: <MWHPR2201MB1230E2882F8817DC243C4B79C1240@MWHPR2201MB1230.namprd22.prod.outlook.com>
x-forefront-prvs: 000947967F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39850400004)(346002)(366004)(136003)(199004)(189003)(71190400001)(102836004)(8676002)(76176011)(305945005)(52536014)(71200400001)(6246003)(5660300002)(8936002)(44832011)(316002)(105586002)(66066001)(6506007)(106356001)(386003)(81166006)(81156014)(4326008)(11346002)(74316002)(68736007)(446003)(54906003)(33656002)(53936002)(25786009)(186003)(99286004)(256004)(9686003)(14454004)(2906002)(6436002)(476003)(7736002)(97736004)(55016002)(478600001)(26005)(6116002)(42882007)(486006)(229853002)(3846002)(52116002)(6916009)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1230;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CUJpOGav0fYE0Y/rkQe5bcvaT7jDS1FNYalpOPiwpCHNL2uQkUQYnTSXQfqJCroKPBWJiZnHLv50sdc7aU5ovocaBDiu7YGjiP2tUbHWWzqu4oCw6xMQ/2bgTjbxRsjjWDBiLW7KKJA4ra4NfmTLUEAShQZRLP6NoSjAeeNrNSTvvOSgxOqy/gCZ8L1anAiPJHYszGgV6P4QyYc2aSvsherbSC9hIUWeVwywwGj8IUZXBKHMG8yb7f2i2yXyKf0wdZfdgcAyqCL+NtfUTlhXGYI+0sYnWYZOA2nJwr7EBcVLFDiGoxnwrAhtETbYtXmLeMftv+RzrPbeSklcLRqA5nrOLDw4HXbKvWF1dQC31G7OppJwQvbnN3tq4YmTNgpUWr3DeN4Pd2+G1//htj/frz9aICgIyG8BG3bFW4aMU2U=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce54c0be-f4b4-4514-79d9-08d6c2b85367
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2019 22:10:25.9204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1230
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

SGVsbG8sDQoNClBldHIgxaB0ZXRpYXIgd3JvdGU6DQo+IEN1cnJlbnRseSBpdCdzIG5vdCBwb3Nz
aWJsZSB0byB1c2UgcGVyZiBvbiBhdGg3OSBkdWUgdG8gZ2VuaXJxIGZsYWdzDQo+IG1pc21hdGNo
IGhhcHBlbmluZyBvbiBzdGF0aWMgdmlydHVhbCBJUlEgMTMgd2hpY2ggaXMgdXNlZCBmb3INCj4g
cGVyZm9ybWFuY2UgY291bnRlcnMgaGFyZHdhcmUgSVJRIDUuDQo+IA0KPiBPbiBUUC1MaW5rIEFy
Y2hlciBDN3Y1Og0KPiANCj4gQ1BVMA0KPiAyOiAgICAgICAgICAwICAgICAgTUlQUyAgIDIgIGF0
aDlrDQo+IDQ6ICAgICAgICAzMTggICAgICBNSVBTICAgNCAgMTkwMDAwMDAuZXRoDQo+IDc6ICAg
ICAgNTUwMzQgICAgICBNSVBTICAgNyAgdGltZXINCj4gODogICAgICAgMTIzNiAgICAgIE1JU0Mg
ICAzICB0dHlTMA0KPiAxMjogICAgICAgICAgMCAgICAgIElOVEMgICAxICBlaGNpX2hjZDp1c2Ix
DQo+IDEzOiAgICAgICAgICAwICBncGlvLWF0aDc5ICAgMiAga2V5cw0KPiAxNDogICAgICAgICAg
MCAgZ3Bpby1hdGg3OSAgIDUgIGtleXMNCj4gMTU6ICAgICAgICAgMzEgIEFSNzI0WCBQQ0kgICAg
MSAgYXRoMTBrX3BjaQ0KPiANCj4gJCBwZXJmIHRvcA0KPiBnZW5pcnE6IEZsYWdzIG1pc21hdGNo
IGlycSAxMy4gMDAwMTRjODMgKG1pcHNfcGVyZl9wbXUpIHZzLiAwMDAwMjAwMyAoa2V5cykNCj4g
DQo+IE9uIFRQLUxpbmsgQXJjaGVyIEM3djQ6DQo+IA0KPiBDUFUwDQo+IDQ6ICAgICAgICAgIDAg
ICAgICBNSVBTICAgNCAgMTkwMDAwMDAuZXRoDQo+IDU6ICAgICAgIDcxMzUgICAgICBNSVBTICAg
NSAgMWEwMDAwMDAuZXRoDQo+IDc6ICAgICAgOTgzNzkgICAgICBNSVBTICAgNyAgdGltZXINCj4g
ODogICAgICAgICAzMCAgICAgIE1JU0MgICAzICB0dHlTMA0KPiAxMjogICAgICA5MDAyOCAgICAg
IElOVEMgICAwICBhdGg5aw0KPiAxMzogICAgICAgNTUyMCAgICAgIElOVEMgICAxICBlaGNpX2hj
ZDp1c2IxDQo+IDE0OiAgICAgICA0NjIzICAgICAgSU5UQyAgIDIgIGVoY2lfaGNkOnVzYjINCj4g
MTU6ICAgICAgMzI4NDQgIEFSNzI0WCBQQ0kgICAgMSAgYXRoMTBrX3BjaQ0KPiAxNjogICAgICAg
ICAgMCAgZ3Bpby1hdGg3OSAgMTYgIGtleXMNCj4gMjM6ICAgICAgICAgIDAgIGdwaW8tYXRoNzkg
IDIzICBrZXlzDQo+IA0KPiAkIHBlcmYgdG9wDQo+IGdlbmlycTogRmxhZ3MgbWlzbWF0Y2ggaXJx
IDEzLiAwMDAxNGM4MCAobWlwc19wZXJmX3BtdSkgdnMuIDAwMDAwMDgwIChlaGNpX2hjZDp1c2Ix
KQ0KPiANCj4gVGhpcyBwcm9ibGVtIGlzIGhhcHBlbmluZywgYmVjYXVzZSBjdXJyZW50bHkgc3Rh
dGljYWxseSBhc3NpZ25lZCB2aXJ0dWFsDQo+IElSUSAxMyBmb3IgcGVyZm9ybWFuY2UgY291bnRl
cnMgaXMgbm90IGNsYWltZWQgZHVyaW5nIHRoZSBpbml0aWFsaXphdGlvbg0KPiBvZiBNSVBTIFBN
VSBkdXJpbmcgdGhlIGJvb3R1cCwgc28gdGhlIElSUSBzdWJzeXN0ZW0gZG9lc24ndCBrbm93LCB0
aGF0DQo+IHRoaXMgaW50ZXJydXB0IGlzbid0IGF2YWlsYWJsZSBmb3IgZnVydGhlciB1c2UuDQo+
IA0KPiBTbyB0aGlzIHBhdGNoIGZpeGVzIHRoZSBpc3N1ZSBieSBzaW1wbHkgYm9va2luZyBoYXJk
d2FyZSBJUlEgNSBmb3IgTUlQUyBQTVUuDQo+IA0KPiBUZXN0ZWQtYnk6IEtldmluICdsZGlyJyBE
YXJieXNoaXJlLUJyeWFudCA8bGRpckBkYXJieXNoaXJlLWJyeWFudC5tZS51az4NCj4gU2lnbmVk
LW9mZi1ieTogUGV0ciDDhcKgdGV0aWFyIDx5bmV6ekB0cnVlLmN6Pg0KPiBBY2tlZC1ieTogSm9o
biBDcmlzcGluIDxqb2huQHBocm96ZW4ub3JnPg0KPiBBY2tlZC1ieTogTWFyYyBaeW5naWVyIDxt
YXJjLnp5bmdpZXJAYXJtLmNvbT4NCg0KQXBwbGllZCB0byBtaXBzLWZpeGVzLg0KDQpUaGFua3Ms
DQogICAgUGF1bA0KDQpbIFRoaXMgbWVzc2FnZSB3YXMgYXV0by1nZW5lcmF0ZWQ7IGlmIHlvdSBi
ZWxpZXZlIGFueXRoaW5nIGlzIGluY29ycmVjdA0KICB0aGVuIHBsZWFzZSBlbWFpbCBwYXVsLmJ1
cnRvbkBtaXBzLmNvbSB0byByZXBvcnQgaXQuIF0NCg==
