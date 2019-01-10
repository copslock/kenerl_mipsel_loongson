Return-Path: <SRS0=2fGM=PS=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EDCC43387
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 18:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9F120874
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 18:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="T3QfVLQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfAJSfR (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:35:17 -0500
Received: from mail-eopbgr810113.outbound.protection.outlook.com ([40.107.81.113]:44928
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727846AbfAJSfR (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 10 Jan 2019 13:35:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jk9sp1GjmvZY3ol78DRnQO2lmNJDPy8aubgfZOZylAo=;
 b=T3QfVLQ+NqXIJ2efckS/BZgPdHNB+uVod3kN8VcWRs8e9dQ2/g+Xr7SYjyBk96jBHMHFBYHHMb4g8AAE9gPQm5DsHMZibxMuFlK/pvQTNyD14+V+8iyy2pJTqsT2o1Ux7jgOh7kc0VAahmwWCoS7TC9oPg6MsEmWgax7nV3RMsg=
Received: from MWHPR2201MB1261.namprd22.prod.outlook.com (10.174.162.13) by
 MWHPR2201MB1438.namprd22.prod.outlook.com (10.174.169.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Thu, 10 Jan 2019 18:35:13 +0000
Received: from MWHPR2201MB1261.namprd22.prod.outlook.com
 ([fe80::68d4:cfd:fb76:4ba0]) by MWHPR2201MB1261.namprd22.prod.outlook.com
 ([fe80::68d4:cfd:fb76:4ba0%6]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 18:35:13 +0000
From:   Yunqiang Su <ysu@wavecomp.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     YunQiang Su <syq@debian.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>
Subject: Re: [PATCH v2] Disable MSI also when pcie-octeon.pcie_disable on
Thread-Topic: [PATCH v2] Disable MSI also when pcie-octeon.pcie_disable on
Thread-Index: AQHUpxVZ7CUfCaG5YUa+qVgzJ72/H6Wo1VkAgAAC7QA=
Date:   Thu, 10 Jan 2019 18:35:13 +0000
Message-ID: <D0125B24-7506-48D0-B2A8-D1D1AC75ECC1@wavecomp.com>
References: <20190108054510.7393-1-syq@debian.org>
 <20190110182443.dic3trktlnn23ynn@pburton-laptop>
In-Reply-To: <20190110182443.dic3trktlnn23ynn@pburton-laptop>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ysu@wavecomp.com; 
x-originating-ip: [47.74.12.188]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1438;6:RY9UKawCIQ7tWYv2H5JG19qeEGYJZOqeWX7nUroeTVc8kmaqHJjDrsGgWYoNY5r3zMX5EFl8WiIzKGgc0YTDmzCRn1v68C8DVG0olZKhtFfDynugBrD276brHf6OjW6z8wIyo3l6DCPLuxm1T5Y3IM3632n7SdaXJnlI+N/bovNWb+s7gM2ygpPOdOIEItiC6uNwDiGBL3YlAwcuTKDTKYci7UT9RzavgQ4/8DnHcMpD7LeHKBykMWaVSW/sgVHe4Wrh4nC15pTgcNGgbCBNRthNqXTyBvP5481VxyQb6oCrW9eDRq/dw2YxYkr1mwPnbxmHGQFG0KDkv97VNTlKAItNQV6EEklWhEsh5c/eENsWTRk4i41WXHyLxls7eiyT8ZkjuMv1gRbi5CzOi1xN9dpI7nUll/2E1OIw0KLoKdOdDYpp2uT3faHBmyDtGD/VYM46VkMfhCbRTV8nJTs/Uw==;5:y6NH/Sj65635kHhQ3Vw2FL/LXA7gqpSh7br8iprL1ZDvFTbPbvF8A0lG817l2fzPSTizgMf3zxIkvC0nYOGJ4gIor6RZGR2nPQK+p5WC2vL70uMxRuevJeGxLhkQ7xgaNvylw6z4R+6XI39bP/bq15obMSJmZ5Z22yREg3T/6rw/g7OCcCSvbiYerqj5afaRHeQs4V8C6eelOHiJdVI+YA==;7:kVv0OaGwWt+LbLyNygGpfQ7ta7Ko4228PrvVGzIbvG4euECq6FonGsmPvjMjM/5Fdlhp2iAB5n2K9cSi+b0/MzBfHrblby1AaoPyKOOkyK2cAx2KepbyPnAiIf7PM0TTxRpssogNPxq2HEQqaS17Sg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39840400004)(396003)(136003)(199004)(189003)(8676002)(81166006)(446003)(54906003)(33656002)(186003)(82746002)(102836004)(316002)(8936002)(81156014)(2616005)(486006)(476003)(11346002)(76176011)(14444005)(14454004)(26005)(37006003)(567974002)(6506007)(6116002)(3846002)(36756003)(256004)(6636002)(4326008)(6436002)(66066001)(6862004)(6246003)(6512007)(229853002)(53936002)(97736004)(6486002)(5660300001)(25786009)(71200400001)(83716004)(71190400001)(305945005)(105586002)(68736007)(478600001)(7736002)(99286004)(106356001)(86362001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1438;H:MWHPR2201MB1261.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 11514859-7701-4cd9-8c44-08d6772a5bcc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1438;
x-ms-traffictypediagnostic: MWHPR2201MB1438:
x-microsoft-antispam-prvs: <MWHPR2201MB1438DC140817B0C74D73C43FDE840@MWHPR2201MB1438.namprd22.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qtIS/+1JTa7Capw1rtvnI52GdKuupBKncqBDHu2zdlVXWFpCHh5ZpTLSe/DD1gHt2typINw3WLSs3BR9nexmI4TPtyFSqz3/dIAHTJRzkzrWmX+lqnJBZH1CQyezTisGBvWClnzTLAYUy9zyTcZLVA48310IsEb06NG0YQInZV2KZ3FSASR0I5I0PriRoKa5yqAYZ0RRS96EwGRrWr6orBo6c2H6f5VqqH7Ke/fivIL6ANPycTN3DZYbN2cCmNbE7s10RA9wUcwnymlxe3iODKKRwElpmFwXPDojyKrhnRiRlA9B/1OUpjEd6sPHRC6r
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-ID: <2B49CE5BB699A2419289C9B9193E552E@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11514859-7701-4cd9-8c44-08d6772a5bcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 18:35:13.0356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1438
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

DQoNCj4g1NogMjAxOcTqMdTCMTHI1aOsyc/O5zI6MjSjrFBhdWwgQnVydG9uIDxwYnVydG9uQHdh
dmVjb21wLmNvbT4g0LS1wKO6DQo+IA0KPiBIaSBZdW5RaWFuZywNCj4gDQo+IE9uIFR1ZSwgSmFu
IDA4LCAyMDE5IGF0IDAxOjQ1OjEwUE0gKzA4MDAsIFl1blFpYW5nIFN1IHdyb3RlOg0KPj4gRnJv
bTogWXVuUWlhbmcgU3UgPHlzdUB3YXZlY29tcC5jb20+DQo+PiANCj4+IE9jdGVvbiBoYXMgYW4g
Ym9vdC10aW1lIG9wdGlvbiB0byBkaXNhYmxlIHBjaWUuDQo+PiANCj4+IFNpbmNlIE1TSSBkZXBl
bmRzIG9uIFBDSS1FLCB3ZSBzaG91bGQgYWxzbyBkaXNhYmxlIE1TSSBhbHNvIHdpdGgNCj4+IHRo
aXMgb3B0aW9ucyBpcyBvbi4NCj4gDQo+IERvZXMgdGhpcyBmaXggYSBidWcgeW91J3JlIHNlZWlu
Zz8gT3IgaXMgaXQganVzdCBpbnRlbmRlZCB0byBhdm9pZA0KPiByZWR1bmRhbnQgd29yaz8NCj4g
DQoNCkkgaGF2ZSBubyBpZGVhIHdoZXRoZXIgdGhpcyBpcyBhIGJ1ZyBvciBuZXcgZmVhdGhlcnMu
DQpJIGdldCBhbiBDYXZpdW0gbWFjaGluZSwgd2hpY2ggaGFzIG5vIFBDSSBhdCBhbGwsIGFuZCBz
byBJIGhhdmUgdG8gZGlzYWJsZSB0aGUgUENJIHRvdGFsbHkuDQoNCkZvciBtZSB0aGVyZSBhcmUg
MiB3YXlzOiBkaXNhYmxlIG9uIGJ1aWxkLXRpbWUgb3IgZGlzYWJsZSBvbiBydW50aW1lLg0KU2lu
Y2UgRGViaWFuIHByZWZlciB0byB1c2UgYSBzaW5nbGUga2VybmVsIGltYWdlLg0KU28gSSBuZWVk
IHRvIGRpc2FibGUgaXQgb24gcnVudGltZS4NCg0KPiBJZiBpdCBmaXhlcyBhIGJ1ZyB0aGVuIEkn
bGwgYXBwbHkgaXQgdG8gbWlwcy1maXhlcyAmIGNvcHkgc3RhYmxlLA0KPiBvdGhlcndpc2UgSSds
bCBhcHBseSBpdCB0byBtaXBzLW5leHQgJiBub3QgY29weSBzdGFibGUuDQo+IA0KDQpJIHByZWZl
ciBpdCB0byBiZSBiYWNrcG9ydGVkLg0KDQo+IFRoYW5rcywNCj4gICAgUGF1bA0KPiANCj4+IFNp
Z25lZC1vZmYtYnk6IFl1blFpYW5nIFN1IDx5c3VAd2F2ZWNvbXAuY29tPg0KPj4gLS0tDQo+PiBh
cmNoL21pcHMvcGNpL21zaS1vY3Rlb24uYyB8IDQgKysrLQ0KPj4gMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9t
aXBzL3BjaS9tc2ktb2N0ZW9uLmMgYi9hcmNoL21pcHMvcGNpL21zaS1vY3Rlb24uYw0KPj4gaW5k
ZXggMmE1YmI4NDliLi4yODhiNThiMDAgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL21pcHMvcGNpL21z
aS1vY3Rlb24uYw0KPj4gKysrIGIvYXJjaC9taXBzL3BjaS9tc2ktb2N0ZW9uLmMNCj4+IEBAIC0z
NjksNyArMzY5LDkgQEAgaW50IF9faW5pdCBvY3Rlb25fbXNpX2luaXRpYWxpemUodm9pZCkNCj4+
IAlpbnQgaXJxOw0KPj4gCXN0cnVjdCBpcnFfY2hpcCAqbXNpOw0KPj4gDQo+PiAtCWlmIChvY3Rl
b25fZG1hX2Jhcl90eXBlID09IE9DVEVPTl9ETUFfQkFSX1RZUEVfUENJRSkgew0KPj4gKwlpZiAo
b2N0ZW9uX2RtYV9iYXJfdHlwZSA9PSBPQ1RFT05fRE1BX0JBUl9UWVBFX0lOVkFMSUQpIHsNCj4+
ICsJCXJldHVybiAwOw0KPj4gKwl9IGVsc2UgaWYgKG9jdGVvbl9kbWFfYmFyX3R5cGUgPT0gT0NU
RU9OX0RNQV9CQVJfVFlQRV9QQ0lFKSB7DQo+PiAJCW1zaV9yY3ZfcmVnWzBdID0gQ1ZNWF9QRVhQ
X05QRUlfTVNJX1JDVjA7DQo+PiAJCW1zaV9yY3ZfcmVnWzFdID0gQ1ZNWF9QRVhQX05QRUlfTVNJ
X1JDVjE7DQo+PiAJCW1zaV9yY3ZfcmVnWzJdID0gQ1ZNWF9QRVhQX05QRUlfTVNJX1JDVjI7DQo+
PiAtLSANCj4+IDIuMjAuMQ0KPj4gDQoNCg==
