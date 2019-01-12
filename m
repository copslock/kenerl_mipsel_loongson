Return-Path: <SRS0=GeJD=PU=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1B4C43387
	for <linux-mips@archiver.kernel.org>; Sat, 12 Jan 2019 03:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C1320872
	for <linux-mips@archiver.kernel.org>; Sat, 12 Jan 2019 03:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="S4Pt/9OI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfALDmC (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 11 Jan 2019 22:42:02 -0500
Received: from mail-eopbgr740117.outbound.protection.outlook.com ([40.107.74.117]:6073
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726276AbfALDmC (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 11 Jan 2019 22:42:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHbR0ykXKbT2RawICjzV6p4KC/djqn41wZOhyRaczy8=;
 b=S4Pt/9OICQ2SoMcuVckgwHQb8yydCr6aJ055AP687sGwnKdU9Vi+6GUa7iuR4FMQpg3z/CU7hi7tR5HqH4ow3C7U1DI/IErWaHeItVpj3lCIvml4FUjnUWu5A3rlTasHwUaQqdGU401ZeHI8YQ1xmimlFiHZ8gQuCRcp+aCSty4=
Received: from MWHPR2201MB1261.namprd22.prod.outlook.com (10.174.162.13) by
 MWHPR2201MB1056.namprd22.prod.outlook.com (10.174.169.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Sat, 12 Jan 2019 03:41:57 +0000
Received: from MWHPR2201MB1261.namprd22.prod.outlook.com
 ([fe80::68d4:cfd:fb76:4ba0]) by MWHPR2201MB1261.namprd22.prod.outlook.com
 ([fe80::68d4:cfd:fb76:4ba0%6]) with mapi id 15.20.1516.016; Sat, 12 Jan 2019
 03:41:56 +0000
From:   Yunqiang Su <ysu@wavecomp.com>
To:     huangpei <huangpei@loongson.cn>
CC:     =?gb2312?B?0Oyzybuq?= <xuchenghua@loongson.cn>,
        Paul Burton <pburton@wavecomp.com>,
        Paul Burton <pburton@wavecomp.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "chenhc@lemote.com" <chenhc@lemote.com>,
        "zhangfx@lemote.com" <zhangfx@lemote.com>,
        "wuzhangjin@gmail.com" <wuzhangjin@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2] MIPS: Loongson, add sync before target of branch
 between llsc
Thread-Topic: [PATCH 1/2] MIPS: Loongson, add sync before target of branch
 between llsc
Thread-Index: AQHUqarpvsCLr64aWEy92ndIbg3Pu6Wq+YsAgAAEpYA=
Date:   Sat, 12 Jan 2019 03:41:56 +0000
Message-ID: <D6CAABA8-132C-4BDB-AFE0-5E7D782D5142@wavecomp.com>
References: <37e1dca1.5987.1683cede2ff.Coremail.xuchenghua@loongson.cn>
 <20190112112518.4cc0b1d7@ambrosehua-ThinkPad-X201s>
In-Reply-To: <20190112112518.4cc0b1d7@ambrosehua-ThinkPad-X201s>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ysu@wavecomp.com; 
x-originating-ip: [2001:250:218:3717:812c:bad:6e54:cb98]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1056;6:gd4+ZmYv0bMEMeJudFsrFi9HWKZx1++ut5Iq2tCRb4qbiqVhWIKuaFf5vmLEeHAOYtm4mwmAfG/+/VSwD9K77B/W/oARHRwn8Tbx+8zeUEXXj0oWtk+7ryQITtYZNVNsYt4xzppZJc87dA8jQ8aEZnykL3g4XzE3FIurFlpj7lyOCv/8J/Wk6bZFt16ygQEwnUACeiK9sQg533LeBQoxk/qBWVoQLm1BuzATKKAV8gPqEid7okXc/7yza9is1JQ4bryKgp7i8DanlG8dvLVWM/ObevcGnBVfzTqUL4TtvvnM4wpmMqwErr+Ic9Pj7FPQSjQuDT2VMW6VQhmXkPqycETFJ3Cus9BCPQ7CG+L4kkmzk18GysP8ofmlsGrvR9DCXSq8EptfhyFHcaKfnNLhdOtiWKefh9iG6TlqH2EowMrxxyaJrWnqCSP88YlxuW4wWi7zKqjL6hTB6H8UuvNR5A==;5:hFXKsbSj8jRCv4ccgR+xOCCPfbyIQR2B4Syl3VlKrx2+MKUddSQleHSvqnx8fn3QXOZdRgyTCrkX+93nhBHuKYMPEtTeLwaVkn0yROZPi0+8ZHgxb0RM+BTT+EpshTECCOCLIIYzHLmfhM7zwmZsztDeAMzh4o/ODv7OBDZNUzVv6tA0dLPJlcduuBFEQ+tl0ROQKFZ97/0Zq29+5X/u0w==;7:xBMdwdcsRzcWdn2PwrOURbT7Tiy1fEAjRnGHvtBUbwfhEAJuas7ecRbE/UVheFJ87iBKr6gHm2KWYV4K/kMamgwvWceqxqw2rCudI6V+29JAjnizUxoWz+OBMAAQT3u4pylrS6T5543JX5ongZy1WA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(366004)(39840400004)(396003)(136003)(346002)(376002)(199004)(189003)(14444005)(5024004)(256004)(486006)(6506007)(102836004)(6116002)(186003)(82746002)(39060400002)(86362001)(25786009)(53936002)(68736007)(5660300001)(6246003)(6512007)(71190400001)(2906002)(83716004)(71200400001)(36756003)(4326008)(99286004)(6916009)(81166006)(229853002)(106356001)(46003)(14454004)(478600001)(305945005)(7736002)(6486002)(81156014)(8676002)(8936002)(54906003)(6436002)(76176011)(2616005)(476003)(446003)(11346002)(33656002)(97736004)(316002)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1056;H:MWHPR2201MB1261.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:zh-cn;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: b7696e98-4797-4d2f-a742-08d6783fe695
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1056;
x-ms-traffictypediagnostic: MWHPR2201MB1056:
x-microsoft-antispam-prvs: <MWHPR2201MB105692A971DD45EAC1382554DE860@MWHPR2201MB1056.namprd22.prod.outlook.com>
x-forefront-prvs: 0915875B28
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BgvUQuv30dJ884+OGPb8YjdZvywPd1vnUcd0VUtOBYrvJE3dqoD664Gq5EM5qA8tdibntWYW+TYeNOReHMpBL7aJit+qazqGQrz+o45+0UHW8zT8b6uV28EXnTOB/oEqhhlBROSQIg787m6SrOjzlTZWHyEi9ZDnnqnOw7ibH7gwc9YAEChbT11QA1HnxHbd5YBM3u12ZapWuQHSqAWwvEN3nl9B0wZn/WUfK3REp8ItPR5L0VUKANNsxwFbNMBY6V7u1Z1UrpIzd2xgzTDvbsZUWQH/FsGWRTs3jq2lH4LJDhWBGsw+fv+g31IlBrKajfH98Y9Ik0AeM3i7pCoHWnRyriGf/MFhH0XToV8lonlrFr3JPOWj+HJ/YrDMGnwjwHfPkzDFUa3jPhBte5x90IZ4WIx+RYCSRb3Yh1xRZrE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-ID: <F03F33003BC2314B857665B80EB9D94C@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7696e98-4797-4d2f-a742-08d6783fe695
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2019 03:41:56.5112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1056
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

PisjZGVmaW5lIF9fTFMzQV9XQVJfTExTQwkJIgkuc2V0IG1pcHM2NHIyXG5zeW5jaSAwXG4uc2V0
IG1pcHMwXG4iDQo+KyNkZWZpbmUgX19sczNhX3dhcl9sbHNjKCkJX19hc21fXyBfX3ZvbGF0aWxl
X18oInN5bmNpIDAiIDogOiA6Im1lbW9yeaGxKQ0KDQq/tMbwwLTV4rj21rvTw9PaMTAwMKOsy/nS
1M7SvvW1w8P719bTprjDyscgX19sczN4MWsgu/LV38Dgy8a1xA0KwanPwruuz9/Q6NKqw7Sjvw0K
DQo+IHNtcF9sbHNjX21iIGluIGNtcHhjaGcuaCBpcyBlbm91Z2h0DQplbm91Z2h0xrTQtLTtwcsN
Cg0KLQkJX19XRUFLX0xMU0NfTUINCiAJCSIzOgkJCQkJCQlcbiINCisJCV9fV0VBS19MTFNDX01C
DQoNCtXiwO+/ycTcu+HTsM/sxuTL+0NQVbXE0NTE3KO/DQoNCg0KDQogI2RlZmluZSBUWDQ5WFhf
SUNBQ0hFX0lOREVYX0lOVl9XQVIJMA0KICNkZWZpbmUgSUNBQ0hFX1JFRklMTFNfV09SS0FST1VO
RF9XQVIJMA0KICNkZWZpbmUgUjEwMDAwX0xMU0NfV0FSCQkJMA0KKyNkZWZpbmUgTE9PTkdTT05f
TExTQ19XQVIJCTANCiAjZGVmaW5lIE1JUFMzNEtfTUlTU0VEX0lUTEJfV0FSCQkwDQoNCtXiuPbT
prjD0qq447j2Q09ORklHX8m2ybbJtiCjv7HPvrnS1LrztcTQvsasuty/ycTcw7vV4s7KzOLBy6Gj
DQoNCg0KPiDU2iAyMDE5xOox1MIxMsjVo6zJz87nMTE6MjWjrGh1YW5ncGVpIDxodWFuZ3BlaUBs
b29uZ3Nvbi5jbj4g0LS1wKO6DQo+IA0KPiBoaSwgdGhpcyBpcyB0aGUgcGF0Y2ggZm9yIGxsL3Nj
IGJ1ZyBpbiBMb29uZ3NvbjMgYmFzZWQgb24gTGludXgtNC4yMA0KPiAoOGZlMjhjYjU4YmNiMjM1
MDM0YjY0Y2JiYjc1NTBhOGE0M2ZkODhiZSkNCj4gDQo+ICsuIGl0IGNvdmVyIGFsbCBsb29uZ3Nv
bjMgQ1BVOw0KPiANCj4gKy4gdG8gZml4IHRoZSBsbC9zYyBidWcgKnN1ZmZpY2llbnRseSBhbmQg
ZXhhY3RseSosIHRoaXMgcGF0Y2ggc2hvd3MNCj4gaG93IG1hbnkgcGxhY2VzIG5lZWQgdG8gdG91
Y2gNCj4gDQo+ICsuIGl0IGlzIGJ1aWx0IG9rIGZvciBvbiBMb29uZ3NvbjMgYW5kIENhdml1bS9P
Y3Rlb24sIG9sZCB2ZXJzaW9uIGlzDQo+IHRlc3RlZCBpbiBoaWdoIHByZXNzdXJlIHRlc3QNCj4g
DQo+IA0KPiBPbiBGcmksIDExIEphbiAyMDE5IDIwOjQwOjQ5ICswODAwIChHTVQrMDg6MDApDQo+
INDss8m7qiA8eHVjaGVuZ2h1YUBsb29uZ3Nvbi5jbj4gd3JvdGU6DQo+IA0KPj4gSGkgUGF1bCBC
dXJ0b24sDQo+PiANCj4+IEZvciBMb29uZ3NvbiAzQTEwMDAgYW5kIDNBMzAwMCwgd2hlbiBhIG1l
bW9yeSBhY2Nlc3MgaW5zdHJ1Y3Rpb24NCj4+IChsb2FkLCBzdG9yZSwgb3IgcHJlZmV0Y2gpJ3Mg
ZXhlY3V0aW5nIG9jY3VycyBiZXR3ZWVuIHRoZSBleGVjdXRpb24NCj4+IG9mIExMIGFuZCBTQywg
dGhlIHN1Y2Nlc3Mgb3IgZmFpbHVyZSBvZiBTQyBpcyBub3QgcHJlZGljdGFibGUuDQo+PiBBbHRo
b3VnaCBwcm9ncmFtbWVyIHdvdWxkIG5vdCBpbnNlcnQgbWVtb3J5IGFjY2VzcyBpbnN0cnVjdGlv
bnMNCj4+IGJldHdlZW4gTEwgYW5kIFNDLCB0aGUgbWVtb3J5IGluc3RydWN0aW9ucyBiZWZvcmUg
TEwgaW4NCj4+IHByb2dyYW0tb3JkZXIsIG1heSBkeW5hbWljYWxseSBleGVjdXRlZCBiZXR3ZWVu
IHRoZSBleGVjdXRpb24gb2YNCj4+IExML1NDLCBzbyBhIG1lbW9yeSBmZW5jZShTWU5DKSBpcyBu
ZWVkZWQgYmVmb3JlIExML0xMRCB0byBhdm9pZCB0aGlzDQo+PiBzaXR1YXRpb24uDQo+PiANCj4+
IFNpbmNlIDNBMzAwMCwgd2UgaW1wcm92ZWQgb3VyIGhhcmR3YXJlIGRlc2lnbiB0byBoYW5kbGUg
dGhpcyBjYXNlLg0KPj4gQnV0IHdlIGxhdGVyIGRlZHVjZSBhIHJhcmVseSBjaXJjdW1zdGFuY2Ug
dGhhdCBzb21lIHNwZWN1bGF0aXZlbHkNCj4+IGV4ZWN1dGVkIG1lbW9yeSBpbnN0cnVjdGlvbnMg
ZHVlIHRvIGJyYW5jaCBtaXNwcmVkaWN0aW9uIGJldHdlZW4NCj4+IExML1NDIHN0aWxsIGZhbGwg
aW50byB0aGUgYWJvdmUgY2FzZSwgc28gYSBtZW1vcnkgZmVuY2UoU1lOQykgYXQNCj4+IGJyYW5j
aC10YXJnZXQoaWYgaXRzIHRhcmdldCBpcyBub3QgYmV0d2VlbiBMTC9TQykgaXMgbmVlZGVkIGZv
cg0KPj4gM0ExMDAwIGFuZCAzQTMwMDAuDQo+PiANCj4+IE91ciBwcm9jZXNzb3IgaXMgY29udGlu
dWFsbHkgZXZvbHZpbmcgYW5kIHdlIGFpbSB0byB0byByZW1vdmUgYWxsDQo+PiB0aGVzZSB3b3Jr
YXJvdW5kLVNZTkNzIGFyb3VuZCBMTC9TQyBmb3IgbmV3LWNvbWUgcHJvY2Vzc29yLiANCj4+IA0K
Pj4gsbG+qcrQuqO17cf41tC52LTlu7exo7/GvLzKvre21LDB+tC+svrStdSwMrrFwqUgMTAwMDk1
tee7sDogKzg2ICgxMCkNCj4+IDYyNTQ2NjY4tKvV5jogKzg2ICgxMCkNCj4+IDYyNjAwODI2d3d3
Lmxvb25nc29uLmNusb7Tyrz+vLDG5Li9vP66rNPQwfrQvtbQv8a8vMr109DP3rmry761xMnM0rXD
2MPc0MXPoqOsvfbP3tPat6LLzbj4yc/D5rXY1rfW0MHQs/a1xLj2yMu78si61+mho7371rnIzrrO
xuTL+8jL0tTIzrrO0M7Kvcq508OjqLD8wKi1q7K7z97T2sirsr+78rK/DQo+PiC31rXY0LnCtqGi
uLTWxrvyyaK3oqOpsb7Tyrz+vLDG5Li9vP7W0LXE0MXPoqGjyOe5+8T6tO3K1bG+08q8/qOsx+vE
+sGivLS157uwu/LTyrz+zajWqreivP7Iy7Kiyb6z/bG+08q8/qGjIA0KPj4gDQo+PiBUaGlzIGVt
YWlsIGFuZCBpdHMgYXR0YWNobWVudHMgY29udGFpbiBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24g
ZnJvbQ0KPj4gTG9vbmdzb24gVGVjaG5vbG9neSBDb3Jwb3JhdGlvbiBMaW1pdGVkLCB3aGljaCBp
cyBpbnRlbmRlZCBvbmx5IGZvcg0KPj4gdGhlIHBlcnNvbiBvciBlbnRpdHkgd2hvc2UgYWRkcmVz
cyBpcyBsaXN0ZWQgYWJvdmUuIEFueSB1c2Ugb2YgdGhlDQo+PiBpbmZvcm1hdGlvbiBjb250YWlu
ZWQgaGVyZWluIGluIGFueSB3YXkgKGluY2x1ZGluZywgYnV0IG5vdCBsaW1pdGVkDQo+PiB0bywg
dG90YWwgb3IgcGFydGlhbCBkaXNjbG9zdXJlLCByZXByb2R1Y3Rpb24gb3IgZGlzc2VtaW5hdGlv
bikgYnkNCj4+IHBlcnNvbnMgb3RoZXIgdGhhbiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpIGlz
IHByb2hpYml0ZWQuIElmIHlvdQ0KPj4gcmVjZWl2ZSB0aGlzIGVtYWlsIGluIGVycm9yLCBwbGVh
c2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcGhvbmUgb3INCj4+IGVtYWlsIGltbWVkaWF0ZWx5IGFu
ZCBkZWxldGUgaXQuIA0KPiA8MDAwMS1sb29uZ3NvbjY0LWFkZC1oZWxwZXItZm9yLWxsLXNjLWJ1
Z2ZpeC1pbi1sb29uZ3NvbjMucGF0Y2g+PDAwMDItbG9vbmdzb242NC1maXgtbGwtc2MtYnVnLW9m
LWxvb25nc29uMy1pbi1pbmxpbmUtYXNtLnBhdGNoPjwwMDAzLWxvb25nc29uNjQtZml4LWxsLXNj
LWJ1Zy1vZi1Mb29uZ3Nvbi0zLWluLWhhbmRsZV90bGIucGF0Y2g+DQoNCg==
