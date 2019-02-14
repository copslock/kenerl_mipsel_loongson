Return-Path: <SRS0=d8WL=QV=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F15C43381
	for <linux-mips@archiver.kernel.org>; Thu, 14 Feb 2019 18:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F54F21B68
	for <linux-mips@archiver.kernel.org>; Thu, 14 Feb 2019 18:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="T0cNVqTX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfBNScq (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:32:46 -0500
Received: from mail-eopbgr800134.outbound.protection.outlook.com ([40.107.80.134]:61152
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726443AbfBNScp (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 14 Feb 2019 13:32:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWT6hPpOUPAf4sY+gFa+rvQDv1C+rCVN82H411Qpobw=;
 b=T0cNVqTXNubGHhaEnQwdFCEYQxES80HMS/7GWotuRlh761Ue6BNuztj1yQCUkpxt3IhsE79rsKX4QKQT0Lr5OKIk3EyQc77KABePed+Yp9Vu8UFSZOFVoXiqMmToszXFpCjm02q0cIWdmEHOXgc8NSJ/OPS31qu3vAVBHtwJzUc=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1136.namprd22.prod.outlook.com (10.174.171.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Thu, 14 Feb 2019 18:32:40 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 18:32:40 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     Paul Burton <pburton@wavecomp.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: BCM47XX: Fix/improve Buffalo WHR-G54S support
Thread-Topic: [PATCH] MIPS: BCM47XX: Fix/improve Buffalo WHR-G54S support
Thread-Index: AQHUwWXxHk6ZJZokxE6cpx8jQkbJOaXfpIWA
Date:   Thu, 14 Feb 2019 18:32:39 +0000
Message-ID: <MWHPR2201MB1277718F9C81478C4BEA1E4FC1670@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190210172739.13904-1-zajec5@gmail.com>
In-Reply-To: <20190210172739.13904-1-zajec5@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0049.namprd07.prod.outlook.com
 (2603:10b6:a03:60::26) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddb3a047-6b7a-4acb-f512-08d692aacc60
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1136;
x-ms-traffictypediagnostic: MWHPR2201MB1136:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjIyMDFNQjExMzY7MjM6ZFpsTisyWE92dXVScnpTaTFYK1JndkxM?=
 =?utf-8?B?WGlXYVNSdGNwZ3FrdlNPTUE3NTF6dUpuY1BQYlR5ZGZsZ1ZOSElJY0J2cWsx?=
 =?utf-8?B?cFd6S29CUWRzSWVSVFNaTnBVK3FwQnUzTlhnWDF2NWtlbGJtV2lPV25VNDFI?=
 =?utf-8?B?NVZRU3AzWEtVR3FVZ0sxVEVucUhMKyswc0F4NStjUmlrUXBSWXFpTXZOOG5i?=
 =?utf-8?B?dW42SWFWeUtLOVprc1JHTkFBRzZKQWtXWnRudnorNVViU2g5emV5RWNQZHkr?=
 =?utf-8?B?K0xteVR1eUd0U0dDZThJclRENG4xMU5uSXJ0Y1puaW9jdDhTaFYwTFNobkRR?=
 =?utf-8?B?K0VJdFhkR2RZNkNRVE40SGFnYTltbVlzWUh6dmszWi9vMjBtVXQ3NlR4eDVw?=
 =?utf-8?B?WGdKZVBkTDkyQXlzVm9UZlpGbEF1bFdMMFRmQW4ySjVIUXZUNVN3cTA0c3Zj?=
 =?utf-8?B?ZFRONGt4eUxQckk3VkpVTTBRbEVQZGlUZjBYYUlkZXM2QSt6RTZ4REZtM254?=
 =?utf-8?B?RmwyT3k1UlZDajVxVm1kTmFlcXBreXF2eGFwNjJZckxzeEpBVWJyTHdKc0lk?=
 =?utf-8?B?U2RPNmlwTjNKOEE4L21JM3RYNE9VTWlxekhRZDZETmhXQVBDNXQ1Rzk2a25k?=
 =?utf-8?B?Y1FFRWJpSnRabXFiYXdydHUxQmlDNjBZUTI0c3hxYUlKSEw3SEtMT3lRbGp1?=
 =?utf-8?B?d2dIdzZIYUowcW9xeUNiWVJmTlVoejEwdnJsRE1tTmJTWjR2b0drd2YxWVpT?=
 =?utf-8?B?S050SkVkc2FoZnYrSHZNWXhLNnZPaWhMdVRlM3lYSGN5Z3Nra1R5SVZEQmc3?=
 =?utf-8?B?cnBVcE45bTdoVXkzY1laKzZYMnpveTRLaDBQQ1FDSHc0aTQ1ZU1RTUduaStJ?=
 =?utf-8?B?Sm9oZGU3b0w2dWVBVm5wRDdTcGRNdW9sRE5lVHV0cysvZEpjbjFoQ1AwclFC?=
 =?utf-8?B?UlhLZ0pFZlY4RGZoamdXYlhhYTVycnIrVHFIKzAxbDY5MUd3VmNsUUFBY1Br?=
 =?utf-8?B?WlpLcjJLMGV5Z2hSY0x0M1FPcGFtYm1lekhEdkZ1aW8zZnJPNWp5T0VMQVlw?=
 =?utf-8?B?T01aYkpNMmFlcWxBUmROQis0b1BUOXlxaVcxd0tzTDF2WGdqem5Eb3RpamI0?=
 =?utf-8?B?MUF6OVNrcXZZK1MrRnFXVkxmUStRNFRnQVIzdTVFMVlOY3d5c1FOZkFLL3RF?=
 =?utf-8?B?U2xNemhxclFrNVQvUm9iVUEwMVpYMXVFVmprM0VoeU1OeE1Vc29IN21xbytq?=
 =?utf-8?B?eHlUM0VLZ0crNDZvLy9nN1N0engxa3hzcjNjRTh3ZnB3MlB1Nks0SEN5VS9N?=
 =?utf-8?B?RzZqUUNLN29EK1VUdWQ5RTdxN0tMalJVcGtNMEU4WU9kaDNrTm9WdVZVTjNT?=
 =?utf-8?B?M3NqN2tpU2cvNzVjSHZFYnlpMk9LdDlya1Z1Vit5S3BtaWtRUE1hR3U2bnFG?=
 =?utf-8?B?Z2dPQkZNQlM5cXdYbXJ2U20wYkFaUGJWMmpEdFVCQlVLbkJLV2E4V3c3RmhK?=
 =?utf-8?B?bjUxby9DWUpjOWlXNDBGZzkzUVVYREl5T1JjNzVtSkJYWUI3d2ZSbmtHeVh3?=
 =?utf-8?B?eUVHM2xUZzA2Nkd1cWxJa1F6NGFTZjdFRlZmMEJoT1EwWG5TS25UWjNkck9Q?=
 =?utf-8?B?UzR5YUJtNENMc2F5MGFlQi9WSkdVZ3dVYlF5RXhVNHpCbzZ5M2ZNNU53WS9I?=
 =?utf-8?Q?DwXc2De3M3rwHKlGaV1MQQpbnkvYU58zbsXhbAXe1?=
x-microsoft-antispam-prvs: <MWHPR2201MB11369D138ACAC570798FCC5FC1670@MWHPR2201MB1136.namprd22.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(136003)(396003)(39850400004)(189003)(199004)(8676002)(71200400001)(8936002)(26005)(66066001)(68736007)(486006)(106356001)(76176011)(97736004)(81166006)(14454004)(81156014)(6436002)(256004)(6506007)(186003)(386003)(1411001)(2906002)(102836004)(71190400001)(52116002)(54906003)(7696005)(99286004)(74316002)(25786009)(4744005)(4326008)(229853002)(316002)(478600001)(42882007)(7736002)(44832011)(305945005)(6246003)(6116002)(3846002)(446003)(476003)(11346002)(53936002)(105586002)(33656002)(6916009)(9686003)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1136;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ywkb401G8l2lJJkoaj0RQUz5zgplSgM40dFlVYvfCe3HnyqJBUY435oHOhkP2AEIuk6nPBy9hYCqh+73UDFxLbDhEtS9basjmg6KjlGuvl1qBopAmuSP20qjpYQIE9/ubNPsyGZ70OlC7s3xH1ucZw2pWxMexQlEYfr65b3UcCbfKhx6uK6hCfLAXiK/TWJQhnHd3vPByfTzzauYUReP2spPSqZZ+KiSWew4+Y3Vu3XkkmFyfgz5t9Dns93uVeSJTMyk3J2QYj+qAjRffYm+zO5h0c6HUXcw3WHsJJDrDuEoXevFoQ3vd2aCuBY0DPsJ69Pv+kbdHPxkzrGKv3iwWyCzHpxn07VyktpNmrPaV+x7GetuYNn/b3kYTC2cvKK+ByoEBoNIneBx5Eh4QuC5zUgouZ/MRILzBFKHDa+OAOo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb3a047-6b7a-4acb-f512-08d692aacc60
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 18:32:38.9364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1136
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

SGVsbG8sDQoNClJhZmHFgiBNacWCZWNraSB3cm90ZToNCj4gRnJvbTogUmFmYcWCIE1pxYJlY2tp
IDxyYWZhbEBtaWxlY2tpLnBsPg0KPiANCj4gMSkgRml4IHJlc2V0IGJ1dHRvbiBzdXBwb3J0IHdo
aWNoIGlzIGFjdGl2ZSAqaGlnaCoNCj4gMikgU3BlY2lmeSBMRURzIGNvbG9ycw0KPiANCj4gU2ln
bmVkLW9mZi1ieTogUmFmYcWCIE1pxYJlY2tpIDxyYWZhbEBtaWxlY2tpLnBsPg0KDQpBcHBsaWVk
IHRvIG1pcHMtbmV4dC4NCg0KVGhhbmtzLA0KICAgIFBhdWwNCg0KWyBUaGlzIG1lc3NhZ2Ugd2Fz
IGF1dG8tZ2VuZXJhdGVkOyBpZiB5b3UgYmVsaWV2ZSBhbnl0aGluZyBpcyBpbmNvcnJlY3QNCiAg
dGhlbiBwbGVhc2UgZW1haWwgcGF1bC5idXJ0b25AbWlwcy5jb20gdG8gcmVwb3J0IGl0LiBdDQo=
