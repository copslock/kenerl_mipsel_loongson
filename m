Return-Path: <SRS0=SHWW=RO=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6576DC43381
	for <linux-mips@archiver.kernel.org>; Mon, 11 Mar 2019 22:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157AC2148D
	for <linux-mips@archiver.kernel.org>; Mon, 11 Mar 2019 22:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="AQzwcmnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbfCKWg0 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:36:26 -0400
Received: from mail-eopbgr760139.outbound.protection.outlook.com ([40.107.76.139]:2759
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725819AbfCKWg0 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 11 Mar 2019 18:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFSqmTzruqcmhlEiO7dIVMAN4HULTnVxTNrj+rVwcPI=;
 b=AQzwcmnr1vmH2R8YJmNbhHurtmUtXxGmnypfQYzQD9EpDmwrtszLCsDfRURy1D1GcEj9caTLVjCsuKq3G3A53gCDhS5zqc75CbnHUXrrKVgG6VpXdSuVngkyiBSNQjblOJgB8vC3lfV9VXTCDq11e5AjphVNpikUdsdOCQwso1A=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1727.namprd22.prod.outlook.com (10.164.206.157) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 22:36:16 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018%3]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 22:36:16 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     =?utf-8?B?UGV0ciDFoHRldGlhcg==?= <ynezz@true.cz>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        =?utf-8?B?UGV0ciDFoHRldGlhcg==?= <ynezz@true.cz>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] mips: bcm47xx: Enable USB power on Netgear WNDR3400v2
Thread-Topic: [PATCH] mips: bcm47xx: Enable USB power on Netgear WNDR3400v2
Thread-Index: AQHU2E/j2+uRXrd+vUuYTPwZj4ka86YHBQsA
Date:   Mon, 11 Mar 2019 22:36:16 +0000
Message-ID: <MWHPR2201MB12770A1FA8373378E4D12CEFC1480@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <1552338502-9511-1-git-send-email-ynezz@true.cz>
In-Reply-To: <1552338502-9511-1-git-send-email-ynezz@true.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0038.namprd08.prod.outlook.com
 (2603:10b6:a03:117::15) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [96.64.207.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80aa73c6-3d4c-40ce-83ca-08d6a671f925
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1727;
x-ms-traffictypediagnostic: MWHPR2201MB1727:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjIyMDFNQjE3Mjc7MjM6aUxGbzVjd3JxeWR5K3pDVk1RSGhwNGp1?=
 =?utf-8?B?cHljT0FXUW5Zd21mZEY0dWtuMnkzK0VheVRzT2s1NkR6MXJheW5CSW8rUEJK?=
 =?utf-8?B?TnhhSkorRmVzREI5TVp4eHQ0ZHZyMUhOaHBOaFZUbmJUMVZxV2xiM1IwTU5i?=
 =?utf-8?B?dFJPdkRXVDVTcE1DNnd1dE55WGRCOWw3a1hDSVhla2U3enJ2WTRwZkkzdVVY?=
 =?utf-8?B?TTRWT1paSUR0Z3pPNmtSNGdaRDFkYnJlQVFWZkx0UExXczUzeHladjVFQkdN?=
 =?utf-8?B?a28zeG5XcVc2akJVNXZacHRwZFJkbXVFRC8wNGlhcWRtN1pTN1o1ZFdzaHZ0?=
 =?utf-8?B?eitHd3ltTW1JRTl0dWpXRGZUMnRGUkx2MWRUMnkvVTBibER0MTFoWGppTjMv?=
 =?utf-8?B?bFZQTk1qNk55VlBBenhYWFJDTjEwY3BvZUlIVkdyVDAwaE9OdSswak5JVXpt?=
 =?utf-8?B?aVJVWHlWYWNRTGNubmhBcU8zaVVZSXA1aW11d2RjWkpQUzZyb0JDZmtnYUZQ?=
 =?utf-8?B?Uk8rYlY5SXExNXFCR0xPQ3ZIQUFIQ3l3dExESVQ5YjhtR1YxMk9FTUY2L21V?=
 =?utf-8?B?cTJxRkxGMHFaaGdvQVUrL0xGNGpWWDNIRjRoSkZxaXNkRS9wR2JlSjBDaGhN?=
 =?utf-8?B?MERlakEyOHlxWS9xQkNkTG00WE9qQlgwaUVNOHo0MnV2dG1naHIzNDhvcW1N?=
 =?utf-8?B?QnMyaVVpYk5KS1MzTkZTMG1CTGNuMDAxNldadXU3WlVWazgrNG4xcFRtYkdH?=
 =?utf-8?B?N0d1UHZzYjdBZDJFWUd3MEZreHlkQ0h2dnVvRjZZR05Eczg4Yk5seTRZbHVr?=
 =?utf-8?B?aVIrUUFJc21ydm1Fa2dUakUyZWZsMVhRYkFiOFg3U0NCdG9CZk5HeWV0NlNN?=
 =?utf-8?B?b0wzNFNlY0NjSWxGZmZzWVVtTFYwa05DaWdxN1J2NnRxMzRvdU1EUjAvZGxz?=
 =?utf-8?B?YkdqNSt0a1gzanRSSkZNTUtxaWVEdUFHU2x4ZFVZS0dRZENGamhSWm9WaERO?=
 =?utf-8?B?OWppTHFtYmtxUWY1MmdTLzIxeUFrYjJxekJ2aEFraURJQWhHSWYzZkFFOFIv?=
 =?utf-8?B?eStUUUZSTDdBbG9LZWttWFRZZTFiQm5Ta1RRVW5kN21uTytSellla0NKMTBl?=
 =?utf-8?B?OXNweUlpRDlJK2NLb2l5R0NCVzRhOUFuM1hMb1I0ZDVRamJ5VFBnbmozZndI?=
 =?utf-8?B?THZxK2NNNlNyUStid3JDZGM5UEowVzIxM0pJTk5MYjBmVG1FL3JXOFNYR2Vy?=
 =?utf-8?B?MmNhK3JYMkZvcGVlRXlVQk5ZZ0JiVVRUSkN1bW5LSFo3cHlJaEdnQUFURTR1?=
 =?utf-8?B?WlFRU1dqa1lVUVYwU3NOb3p5N2htWUVWYnFSaDA4MEIwTXpLT29YNjZPeTJM?=
 =?utf-8?B?VXluenkvTUxYWWZWOG50TWZPc1pOSG15UUJVbzI0Y1hsNC9qQVAwOGY0elQ5?=
 =?utf-8?B?Q3czUzdMSk9LeCt6MTU5bld4WlR0NGJaL0ZPOE0rODFaNVJOL0hkTE9zT29L?=
 =?utf-8?B?aThtZzBsangxZWdFYWlBV1R3b3BTSWdjaEZ3UCtVa0RQVjFtRGF3SW9sNlEz?=
 =?utf-8?B?SExFaVdRditQdlVTMXNnNjBLRnpXR2ovcEE5M0hvck55QXp5NG1FR2FRREZX?=
 =?utf-8?B?RGN2SjhDQUp4Y1F5NE9EZnMvdGNJZUROWUZVREVUVHJNOE5mNE51NE1qdXNV?=
 =?utf-8?B?M2Z3ekQxL0wvS1NrQ0RBNjlpMHhSSWpVMm5WWmZzNkI4TjRVQ0YyTHQ4ZWxI?=
 =?utf-8?B?NVkwUVN1Zm1wK1AxeGkwYlNsQTl6bTNYQ2VOUHczVElabDR5U3hHK2V6bHBl?=
 =?utf-8?B?bFZhcHpqQnJvMm1zZDVuYUtOejVnMFZXZ0tJejNwclk3Z1JNaG5DTW9UcS9x?=
 =?utf-8?Q?eXQOW0wZrO1WY=3D?=
x-microsoft-antispam-prvs: <MWHPR2201MB1727D8EDFCBCBD2CD44F4BFCC1480@MWHPR2201MB1727.namprd22.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39850400004)(346002)(366004)(376002)(189003)(199004)(6306002)(55016002)(106356001)(53936002)(478600001)(6436002)(9686003)(386003)(102836004)(186003)(966005)(76176011)(6246003)(99286004)(26005)(6506007)(316002)(229853002)(7696005)(4744005)(54906003)(5660300002)(6116002)(3846002)(347745004)(52536013)(4326008)(52116002)(33656002)(25786009)(97736004)(6916009)(68736007)(42882007)(476003)(446003)(11346002)(44832011)(8676002)(81156014)(81166006)(16799955002)(74316002)(486006)(7736002)(8936002)(105586002)(2906002)(14454004)(256004)(71190400001)(66066001)(71200400001)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1727;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U5Ol1VA9oMfmTAc2sovBxIg2tB94w85bVZz9lVbkPX+38khuQHs28cC9TPzTXVaNHwO5a7r9C+EuULiqFfa+9Z/HgZnmcjjw4x3iLxtmgqKaYKE16pia71QXorVerM71E9XKqSYMDQH5VT1DPrxMOEdVaghji51BDDrmE4ATNnYE2LhB3mwyXB0HKA7tjj69SOnhtQJgf602MEXIaXNHHb9pqXJePEHRHs6F+90XS2GPLYlZP5H9lYeWnUqNqyS0+XyqYww0wE3oZZP1plRNLo3wO23RlBHGAJbmVT1/0QdVntfMyzkgPr9J8wVOV8UUvTV9jvh7LjCVoFUNt8qNOVnfFPEN1YHsRo/YFMtCk9uTveZWpW1VdHdnUCnXztACeE6YGf/p+6+kLC9Jr6QFqWA+kAnqC+kEqa5rJJBRT1A=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80aa73c6-3d4c-40ce-83ca-08d6a671f925
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 22:36:16.3466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1727
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

SGVsbG8sDQoNClBldHIgxaB0ZXRpYXIgd3JvdGU6DQo+IEVyaWMgaGFzIHJlcG9ydGVkIG9uIE9w
ZW5XcnQncyBidWcgdHJhY2tpbmcgc3lzdGVtWzFdLCB0aGF0IGhlJ3Mgbm90DQo+IGFibGUgdG8g
dXNlIFVTQiBkZXZpY2VzIG9uIGhpcyBXTkRSMzQwMHYyIGRldmljZSBhZnRlciB0aGUgYm9vdCwg
dW50aWwNCj4gaGUgdHVybnMgb24gR1BJTyAjMjEgbWFudWFsbHkgdGhyb3VnaCBzeXNmcy4NCj4g
DQo+IDEuIGh0dHBzOi8vYnVncy5vcGVud3J0Lm9yZy9pbmRleC5waHA/ZG89ZGV0YWlscyZ0YXNr
X2lkPTIxNzANCj4gDQo+IENjOiBSYWZhw4XCgiBNacOFwoJlY2tpIDx6YWplYzVAZ21haWwuY29t
Pg0KPiBDYzogSGF1a2UgTWVocnRlbnMgPGhhdWtlQGhhdWtlLW0uZGU+DQo+IFJlcG9ydGVkLWJ5
OiBFcmljIEJvaGxtYW4gPGVyaWNib2hsbWFuQGdtYWlsLmNvbT4NCj4gVGVzdGVkLWJ5OiBFcmlj
IEJvaGxtYW4gPGVyaWNib2hsbWFuQGdtYWlsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUGV0ciDD
hcKgdGV0aWFyIDx5bmV6ekB0cnVlLmN6Pg0KDQpBcHBsaWVkIHRvIG1pcHMtZml4ZXMuDQoNClRo
YW5rcywNCiAgICBQYXVsDQoNClsgVGhpcyBtZXNzYWdlIHdhcyBhdXRvLWdlbmVyYXRlZDsgaWYg
eW91IGJlbGlldmUgYW55dGhpbmcgaXMgaW5jb3JyZWN0DQogIHRoZW4gcGxlYXNlIGVtYWlsIHBh
dWwuYnVydG9uQG1pcHMuY29tIHRvIHJlcG9ydCBpdC4gXQ0K
