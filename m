Return-Path: <SRS0=uIlq=PE=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98777C43387
	for <linux-mips@archiver.kernel.org>; Thu, 27 Dec 2018 13:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541712070C
	for <linux-mips@archiver.kernel.org>; Thu, 27 Dec 2018 13:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=darbyshire-bryant.me.uk header.i=@darbyshire-bryant.me.uk header.b="l5oDDYF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbeL0NIt (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 27 Dec 2018 08:08:49 -0500
Received: from mail-eopbgr10045.outbound.protection.outlook.com ([40.107.1.45]:9027
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726761AbeL0NIt (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 27 Dec 2018 08:08:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=darbyshire-bryant.me.uk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phqZS/w2KkAd048u3yo3sPQAckXZMgP1vwksrPa87Tk=;
 b=l5oDDYF15S9nskDUIDLuniPX/tKqzp+nKoR56RhnRm7NOAn/9JiJFI9iLd2tIf4piO/q09iGw79WNROJWiZpHV3IsmwIHaYbSkMiSZb0DdJOOQY1RXcga4Xe0wpp4v5bkdDSk1aDmc7fyXe58lqpNzd8SunYldKBfspzzz3DHvg=
Received: from VI1PR0302MB2750.eurprd03.prod.outlook.com (10.171.105.143) by
 VI1PR0302MB3277.eurprd03.prod.outlook.com (52.134.12.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.24; Thu, 27 Dec 2018 13:08:43 +0000
Received: from VI1PR0302MB2750.eurprd03.prod.outlook.com
 ([fe80::d77:d217:1660:c5d4]) by VI1PR0302MB2750.eurprd03.prod.outlook.com
 ([fe80::d77:d217:1660:c5d4%2]) with mapi id 15.20.1471.019; Thu, 27 Dec 2018
 13:08:43 +0000
From:   Kevin 'ldir' Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>
To:     Hauke Mehrtens <hauke@hauke-m.de>
CC:     "paul.burton@mips.com" <paul.burton@mips.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "jonas.gorski@gmail.com" <jonas.gorski@gmail.com>
Subject: Re: [PATCH] MIPS: Add CPU option reporting to /proc/cpuinfo
Thread-Topic: [PATCH] MIPS: Add CPU option reporting to /proc/cpuinfo
Thread-Index: AQHUmxJAeVFEpnFmuk+WQwjlWhVAMaWNmOUAgABN7ICAABEaAIACBXiAgAKOy4CAAAhCAA==
Date:   Thu, 27 Dec 2018 13:08:43 +0000
Message-ID: <5B483FB8-8081-45E9-A082-FCA7F77EE06F@darbyshire-bryant.me.uk>
References: <20181223225224.23042-1-hauke@hauke-m.de>
 <81623E5E-FAB2-4C91-B7F9-8C5BB8422D5C@darbyshire-bryant.me.uk>
 <89c9e62d-850c-2c78-3d09-269ce0c619a1@hauke-m.de>
 <4088FEE6-B2A4-49CE-8816-1A33D5443E21@darbyshire-bryant.me.uk>
 <FA3C385D-0FE2-4462-A7CA-89D984BBB234@darbyshire-bryant.me.uk>
 <23a09eea-2836-a07d-4a10-c87f170a94fb@hauke-m.de>
In-Reply-To: <23a09eea-2836-a07d-4a10-c87f170a94fb@hauke-m.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ldir@darbyshire-bryant.me.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2a02:c7f:1240:ee00::dc83]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0302MB3277;6:y1+NtkyFsns9ZrXw19Jx2yYW9W9Be1ZxqMhgZS9OhUns+Mmf6s3Lr9FkE5GANa01oDF6+6fm/76PLahoPObLTmaqzleOdttgxjSfMnP2IzBr8O0msYqgZFSiJGrdPXf5E5VCjXaIdIbLJ9DVg0wbkH8ZTIO44pZcXlZsczcnDcEeRWq6F9hxgCHu/SIhucqCNFnzbZ/52NUigQG1da/vGcXYHuk+/ueHYQ2v6dRgF6WpugfA/o8CeiKEzrTM6itNzFtksIkgNicsIdeiS1b3gNWm1pI6qKUwcIiH+9UKxe8UPANGJILMJwImbvyv6OI++mqa9vSG6753YwaXj+9ohuZLPTHfrOTzMaaKZ1UyCgHymgUiJkhf8evRCrt+jxteD2IWHQZX2+G44adqJipL4KAd9arO3PSkqKGvW+904fjSKBbYOP+WGUf/y+L8qrU4D255jXx0oFwyCTWyE/AzHg==;5:oztJLke6bpEYlUejjwcbjiqdhCbCd/jd5kmsghTWZ6beulddnPkFybTsi05lS/TmcF8gxA6n2TWts2hdXVCG/1ItnEiecyofae1VbxVm5q1n0cABVVG4SQEc6nrKxuJDWi86thtH37qmRUKZSpoQ2IT3g9lAsc1fVO7SpMlu9lQ=;7:d114l/AL12Hwd8Fpm+JnNbSKpAK0sacCA3sqZt02wzP13xHcRq28kidbFmqZgW8k4rIwYMRv7JN9bWERNUZg/YEPaO0r3yPLLLNd1nqGIZ+2W+CedeQD8SDacDdO60Q3+/vi1ar78pkfOMNFLHscKg==
x-ms-office365-filtering-correlation-id: 09ed4bb5-52b1-44ae-536a-08d66bfc6dc1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600098)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0302MB3277;
x-ms-traffictypediagnostic: VI1PR0302MB3277:
x-microsoft-antispam-prvs: <VI1PR0302MB3277952431CB6E7054AE86D2C9B60@VI1PR0302MB3277.eurprd03.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220047)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123564045)(2016111802025)(20161123562045)(20161123558120)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1PR0302MB3277;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0302MB3277;
x-forefront-prvs: 0899B47777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39830400003)(366004)(136003)(376002)(346002)(396003)(189003)(199004)(229853002)(446003)(6486002)(316002)(6506007)(83716004)(14454004)(36756003)(71200400001)(71190400001)(11346002)(6512007)(54906003)(46003)(6116002)(2616005)(97736004)(102836004)(53936002)(8676002)(53546011)(508600001)(476003)(33656002)(6916009)(99286004)(81166006)(76176011)(81156014)(74482002)(106356001)(82746002)(256004)(7736002)(6246003)(2906002)(25786009)(305945005)(105586002)(486006)(68736007)(8936002)(6436002)(186003)(39060400002)(93886005)(5660300001)(86362001)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0302MB3277;H:VI1PR0302MB2750.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: darbyshire-bryant.me.uk does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7p4A7xU0clYAaJ2pe/LWovrllBCquGs3APKNfzooQqIuxj8T4hsFgLBcyhixed14oRMV4Of7Xgnr37CvGT1c+ydgNRPCVcxcIvqtrJrvwFdj3SUAcZ3Kr4h3c4QU2g34Of993r36WrCHeOEYQTnN9N10XPVCWXQkr7BFC+vlYnzrE3FkdCj8wAp5quNiW22J042VecWU3twYoTAf5T4atHPAZEkwDT/u41cXwXbb+f6PlohsSnO4ZB0qKWZpFEWyS8vN59pTtd31x6YfdZgqY8+4sTXUInnNNWqkmiwo6CY/osBsGsRa5OplOcknWYN1
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4981058FA70B9F42864425BC559A459B@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: darbyshire-bryant.me.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ed4bb5-52b1-44ae-536a-08d66bfc6dc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2018 13:08:43.5199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9151708b-c553-406f-8e56-694f435154a4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0302MB3277
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

DQoNCj4gT24gMjcgRGVjIDIwMTgsIGF0IDEyOjM5LCBIYXVrZSBNZWhydGVucyA8aGF1a2VAaGF1
a2UtbS5kZT4gd3JvdGU6DQo+IA0KPj4gDQo+IEhpIEtldmluLA0KPiANCj4gSSBkbyBub3Qgc2Vl
IGFueSBjb25kaXRpb24gYmFzZWQgb24gQ09ORklHX01JUFNfUEVSRl9TSEFSRURfVENfQ09VTlRF
UlMgaW4gYXJjaC9taXBzL2luY2x1ZGUvYXNtL2NwdS1mZWF0dXJlcy5oLCB3aGljaCBrZXJuZWwg
dmVyc2lvbiBkaWQgeW91IHVzZSB0byB0ZXN0IHRoaXMgcGF0Y2g/IGNwdV9oYXNfbWlwc210X3Bl
cnRjY291bnRlcnMgd2FzIGludHJvZHVjZWQgYmV0d2VlbiBrZXJuZWwgNC4xNCBhbmQgNC4xOSwg
c28gaXQgaXMgbm90IGF2YWlsYWJsZSBpbiBvbGRlciBrZXJuZWwgdmVyc2lvbnMuDQo+IA0KPiBI
YXVrZQ0KDQoNClRoaXMgaXMgNC4xNC45MCBvbiBvcGVud3J04oCmYW5kIEkgZG9u4oCZdCB0aGlu
ayB0aGVyZSBhcmUgYW55IHNuZWFreSBiYWNrcG9ydHMgaW52b2x2ZWQgaW4gdGhpcyBhcmVhLg0K
DQpUYWtlIGEgbG9vayBhcm91bmQgbGluZSAxMzEgb2YgYXJjaC9taXBzL2tlcm5lbC9wZXJmX2V2
ZW50X21pcHN4eC5jDQoNCkNoZWVycywNCg0KS2V2aW4gRC1CDQoNCjAxMkMgQUNCMiAyOEM2IEM1
M0UgOTc3NSAgOTEyMyBCM0EyIDM4OUIgOURFMiAzMzRBDQoNCg==
