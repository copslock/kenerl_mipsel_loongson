Return-Path: <SRS0=lXGt=PL=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06B9C43387
	for <linux-mips@archiver.kernel.org>; Thu,  3 Jan 2019 23:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21ECE208E3
	for <linux-mips@archiver.kernel.org>; Thu,  3 Jan 2019 23:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=darbyshire-bryant.me.uk header.i=@darbyshire-bryant.me.uk header.b="TrHq9/Bu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfACXNa (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 3 Jan 2019 18:13:30 -0500
Received: from mail-eopbgr20064.outbound.protection.outlook.com ([40.107.2.64]:64545
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725919AbfACXN3 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 3 Jan 2019 18:13:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=darbyshire-bryant.me.uk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSJRKyZEyBS1j4KH8krT75tJ/qwr7Vv2Kv/ZZPF5JbU=;
 b=TrHq9/Bu+8RFJv/TApdgEI4y4z0QdZeBz7Ewsj0vPNQvqsdnXrkJ4UsOId9emDa6nh76825WWd/ZHZI83sViT+jtStHWXQMFgtxwPqkVQ2KayvucaMMdT06zQBk9SHxdb4kIraZ52wqGwk33HX9488CRPNYNeZFqSHlbzOcegy0=
Received: from VI1PR0302MB2750.eurprd03.prod.outlook.com (10.171.105.143) by
 VI1PR0302MB3181.eurprd03.prod.outlook.com (52.134.11.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Thu, 3 Jan 2019 23:13:16 +0000
Received: from VI1PR0302MB2750.eurprd03.prod.outlook.com
 ([fe80::d77:d217:1660:c5d4]) by VI1PR0302MB2750.eurprd03.prod.outlook.com
 ([fe80::d77:d217:1660:c5d4%2]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 23:13:16 +0000
From:   Kevin 'ldir' Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>
To:     Hauke Mehrtens <hauke@hauke-m.de>
CC:     "paul.burton@mips.com" <paul.burton@mips.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "jonas.gorski@gmail.com" <jonas.gorski@gmail.com>
Subject: Re: [PATCH] MIPS: Add CPU option reporting to /proc/cpuinfo
Thread-Topic: [PATCH] MIPS: Add CPU option reporting to /proc/cpuinfo
Thread-Index: AQHUmxJAeVFEpnFmuk+WQwjlWhVAMaWNmOUAgABN7ICAABEaAIACBXiAgAKOy4CAAAhCAIALkeiAgAAXUQA=
Date:   Thu, 3 Jan 2019 23:13:16 +0000
Message-ID: <DE033D2C-DA1C-49AA-9980-BFB88ED5FB80@darbyshire-bryant.me.uk>
References: <20181223225224.23042-1-hauke@hauke-m.de>
 <81623E5E-FAB2-4C91-B7F9-8C5BB8422D5C@darbyshire-bryant.me.uk>
 <89c9e62d-850c-2c78-3d09-269ce0c619a1@hauke-m.de>
 <4088FEE6-B2A4-49CE-8816-1A33D5443E21@darbyshire-bryant.me.uk>
 <FA3C385D-0FE2-4462-A7CA-89D984BBB234@darbyshire-bryant.me.uk>
 <23a09eea-2836-a07d-4a10-c87f170a94fb@hauke-m.de>
 <5B483FB8-8081-45E9-A082-FCA7F77EE06F@darbyshire-bryant.me.uk>
 <57008009-6432-7c83-b15b-aa9a9ae567c3@hauke-m.de>
In-Reply-To: <57008009-6432-7c83-b15b-aa9a9ae567c3@hauke-m.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ldir@darbyshire-bryant.me.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2a02:c7f:1240:ee00::dc83]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0302MB3181;6:PUoDBHFfcrQYBGxrIoo4dEHCRHx2Uje67UqJ5ggOBIImZT49k+RkLDVZ+iz8vXXR8O//XduCcE+If6Hn9tspAgH9J3B56md7iZkJX4UtttNBp8KZ3kXvKjgLml5V2ImZyC3tBtUzpI5IKplNoSy+XdtdViyl5f3p1XR5whBeLPgHS/AaM6JdLwTgLe3sncYyIoDR3b9zKzZH+hH9HEf/ScoiJ0gntLOzccqaWjNc/2B5s6GJbxxSY79I9W9BvgWseFtJaKYgrMOLflmTcNA81NybMuXqJvlSfuj/iWYJlpL3mNHKvdn9ZlYv6FG1z6bvJ5mTlkZFk2eD37zA8yjAQOE48beBESELQbhIIal8KXpu6kz4kjP3gqks1Kmth+tQ2c1X/WAOgiBiIVQeCypA84q61Us7Ck57B2BrSzzXM2ZFaffmxsxjKeSXE/NL4WdGA0SZFRYcD9CgqDnNmIj38g==;5:Coxk2/DDwDFXQOlBFJMURaCt8P9Drl8SzoggCrxwVG08UBHVcfdMIrwJ1/NUgaV2YULXF8DnVukvsDDENNeeIDfOENINSm1DYCZ3+eidF18wmFv+03Naet1s8eOlM6i1itDfNe/IYko2AGpRX1b5hT9DmbPX2qHgDaavtEHebEQ=;7:xEw/ZvONuLu6GbYLj7HgNYq3JtmSawSX/BZIQRes4flifAscCanMo/d/hJY03UuEg0paNh21vdq9Fl4CHNt+BIIwnm/qQgZAS10mxAuiDEXnMIkWbdEWzn8qfVTP62WjocKfDs62Iu/7iY6zBYsbUw==
x-ms-office365-filtering-correlation-id: bb53a86b-3abc-44f5-22c4-08d671d10b10
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0302MB3181;
x-ms-traffictypediagnostic: VI1PR0302MB3181:
x-microsoft-antispam-prvs: <VI1PR0302MB3181E4FBCB31D01C00FAD0D7C98D0@VI1PR0302MB3181.eurprd03.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(6041310)(20161123564045)(2016111802025)(20161123560045)(20161123562045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1PR0302MB3181;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0302MB3181;
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39830400003)(346002)(366004)(136003)(376002)(396003)(189003)(199004)(6512007)(6116002)(6306002)(106356001)(105586002)(81156014)(36756003)(8676002)(7736002)(97736004)(93886005)(76176011)(83716004)(8936002)(71190400001)(71200400001)(81166006)(53936002)(99286004)(39060400002)(6246003)(2906002)(305945005)(74482002)(33656002)(446003)(11346002)(86362001)(46003)(316002)(14454004)(4326008)(25786009)(186003)(54906003)(508600001)(102836004)(966005)(5660300001)(2616005)(476003)(229853002)(6436002)(6916009)(53546011)(6506007)(82746002)(256004)(68736007)(486006)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0302MB3181;H:VI1PR0302MB2750.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: darbyshire-bryant.me.uk does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: x6I4+1Nu7oUqU/nD2JHxiETMiuMvcVFxpv7GEAoKJ/MyCRuKiBUmB8/9QQdVjH0owdA32xmfeM7o50DrZAd1MAEE/VgZHWqnxg1U3wVBNNcAUGSZeCdOABp2qlqwIm3PiOCpfIkwO48HbZnslzpRJYg3WP6cnWRe0rCOsH+4rlScx6dxu+iGsuXH+soRW+G8uC15V2WSx68VJOwbPXQQbnj6BjgamwWG/qE+PNjQbWCl2ie/F6u3sjGFW3bh42NR5w5PFYrZ+/nyEV9QDxXdAO7OOFU9TS8NfE0zorEH1YUqvSNUoABZpmx+T0ARmdCQ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5832DDC15BA184EBD26DC254B43FF9E@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: darbyshire-bryant.me.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: bb53a86b-3abc-44f5-22c4-08d671d10b10
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 23:13:16.5092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9151708b-c553-406f-8e56-694f435154a4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0302MB3181
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

DQoNCj4gT24gMyBKYW4gMjAxOSwgYXQgMjE6NDksIEhhdWtlIE1laHJ0ZW5zIDxoYXVrZUBoYXVr
ZS1tLmRlPiB3cm90ZToNCj4gDQo+IE9uIDEyLzI3LzE4IDI6MDggUE0sIEtldmluICdsZGlyJyBE
YXJieXNoaXJlLUJyeWFudCB3cm90ZToNCj4+PiBPbiAyNyBEZWMgMjAxOCwgYXQgMTI6MzksIEhh
dWtlIE1laHJ0ZW5zIDxoYXVrZUBoYXVrZS1tLmRlPiB3cm90ZToNCj4+PiANCj4+Pj4gDQo+Pj4g
SGkgS2V2aW4sDQo+Pj4gDQo+Pj4gSSBkbyBub3Qgc2VlIGFueSBjb25kaXRpb24gYmFzZWQgb24g
Q09ORklHX01JUFNfUEVSRl9TSEFSRURfVENfQ09VTlRFUlMgaW4gYXJjaC9taXBzL2luY2x1ZGUv
YXNtL2NwdS1mZWF0dXJlcy5oLCB3aGljaCBrZXJuZWwgdmVyc2lvbiBkaWQgeW91IHVzZSB0byB0
ZXN0IHRoaXMgcGF0Y2g/IGNwdV9oYXNfbWlwc210X3BlcnRjY291bnRlcnMgd2FzIGludHJvZHVj
ZWQgYmV0d2VlbiBrZXJuZWwgNC4xNCBhbmQgNC4xOSwgc28gaXQgaXMgbm90IGF2YWlsYWJsZSBp
biBvbGRlciBrZXJuZWwgdmVyc2lvbnMuDQo+Pj4gDQo+Pj4gSGF1a2UNCj4+IFRoaXMgaXMgNC4x
NC45MCBvbiBvcGVud3J04oCmYW5kIEkgZG9u4oCZdCB0aGluayB0aGVyZSBhcmUgYW55IHNuZWFr
eSBiYWNrcG9ydHMgaW52b2x2ZWQgaW4gdGhpcyBhcmVhLg0KPj4gVGFrZSBhIGxvb2sgYXJvdW5k
IGxpbmUgMTMxIG9mIGFyY2gvbWlwcy9rZXJuZWwvcGVyZl9ldmVudF9taXBzeHguYw0KPiANCj4g
SGkgS2V2aW4sDQo+IA0KPiBJIGFzc3VtZSB5b3UgYXJlIHRhbGtpbmcgYWJvdXQgdGhpczoNCj4g
aHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjQuMTkuMTMvc291cmNlL2FyY2gvbWlw
cy9rZXJuZWwvcGVyZl9ldmVudF9taXBzeHguYyNMMTMxDQoNCklmIHlvdSBsb29rIGF0IDQuMTQu
OTEgaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjQuMTQuOTEvc291cmNlL2FyY2gv
bWlwcy9rZXJuZWwvcGVyZl9ldmVudF9taXBzeHguYyNMMTMxDQoNCg0KPiANCj4gSSBzdGlsbCBk
byBub3QgZ2V0IHdoeSB0aGlzIGlzIGEgcHJvYmxlbS4NCg0KSG9wZWZ1bGx5IHlvdeKAmWxsIHNl
ZSB3aHkgaXTigJlzIGEgcHJvYmxlbSwg4oCYY29zIA0KDQojaWZkZWYgQ09ORklHX01JUFNfUEVS
Rl9TSEFSRURfVENfQ09VTlRFUlMNCnN0YXRpYyBpbnQgY3B1X2hhc19taXBzbXRfcGVydGNjb3Vu
dGVyczsNCg0KDQpTbyBJIHN1c3BlY3QgdGhpcyBpcyBteSBmYXVsdC9jb25mdXNpb24gZm9yIHRy
eWluZyB0byBiYWNrcG9ydCBhIGZlYXR1cmUgZnJvbSA0LjE5IHRvIDQuMTQgYW5kIHRyeWluZyB0
byBmbGFnIHRoYXQgY2FzZSAtIEnigJltIGFmcmFpZCBhbSB2ZXJ5IHRpbWUgY29uc3RyYWluZWQg
YXQgdGhlIG1vbWVudCBhbmQgSSB0aGluayB0aGUgYmVzdCB0aGluZyBpcyB0byBpZ25vcmUgbWUg
Oi0pDQoNCkNoZWVycywNCg0KS2V2aW4=
