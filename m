Return-Path: <SRS0=rYMR=PT=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73469C43387
	for <linux-mips@archiver.kernel.org>; Fri, 11 Jan 2019 19:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3449A2183F
	for <linux-mips@archiver.kernel.org>; Fri, 11 Jan 2019 19:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="E+tcDZNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388262AbfAKTAz (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:00:55 -0500
Received: from mail-eopbgr690137.outbound.protection.outlook.com ([40.107.69.137]:49856
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730650AbfAKTAz (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 11 Jan 2019 14:00:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfAhQEoi6O3MEXBQjdwV0WJXSHMueX/O7tkchS/dE44=;
 b=E+tcDZNB54ZqII/B4o0sz18997sd++RIKRJ8WwtS2aUAQxz/n3ASNThgZarINsOOVgpNRbvA1WDk7Sc0HfECCQX4E26bygXjiHWBYUgErm2T0HzCgCCqia/RgBcQzDpxluEj8eOyKGTA24YoRdj6YrUgDHQbWkOsKRwEW6q0eVo=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1309.namprd22.prod.outlook.com (10.174.162.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.15; Fri, 11 Jan 2019 19:00:50 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110%4]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 19:00:50 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     =?utf-8?B?5b6Q5oiQ5Y2O?= <xuchenghua@loongson.cn>
CC:     Yunqiang Su <ysu@wavecomp.com>, Paul Burton <pburton@wavecomp.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "chenhc@lemote.com" <chenhc@lemote.com>,
        "zhangfx@lemote.com" <zhangfx@lemote.com>,
        "wuzhangjin@gmail.com" <wuzhangjin@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        =?utf-8?B?6buE5rKb?= <huangpei@loongson.cn>
Subject: Re: [PATCH 1/2] MIPS: Loongson, add sync before target of branch
 between llsc
Thread-Topic: [PATCH 1/2] MIPS: Loongson, add sync before target of branch
 between llsc
Thread-Index: AQHUqarnjiLiHSxsNEufD/k7H0kS3qWqbJiA
Date:   Fri, 11 Jan 2019 19:00:50 +0000
Message-ID: <20190111190049.pba3243a5ln5fw56@pburton-laptop>
References: <37e1dca1.5987.1683cede2ff.Coremail.xuchenghua@loongson.cn>
In-Reply-To: <37e1dca1.5987.1683cede2ff.Coremail.xuchenghua@loongson.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:40::14) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1309;6:2wm25YIeHNkNtdofs7KTnamqI4KwinXa4uHknzUhpFdrg9xIKJ0rVQ2C5k61WemGAVHz8MLb2H7+rvOVYjkYKdwD3waVbOz0tb866Pt8kFwA/pLLUk+cyOmT12LFeZ9c7W4kWOKUdIFFtpabe+Tz0JtE61hAGKhW87AxuAokEh+oco7jRgx7Ia0cWmw5RbXBkq25nOJJuJxNZRV3cAlU/xTe5yNqvk+viiWVK+K1ZY08NNZLV238rcBsZLKhkVnWBqXsgYZShUwNPJM01/ZufCM1SK5iAm2pjGHHvcF3136zUaHqZJk4td35KFdbulCiQVR5qfMStrOsRsHK5Zl1wh7aOcRkwuhXjVtJ9uz0KeDGLx46HwKEuXG7MwsGwZENX9oYHpjoBINC4t1G3hXeQnuNRePrOhDZK7olicJbycnq19811asAA0/M20O+t10ieDvblbobLIJLtFWoRTHkBg==;5:WYmsyDUD3bBuNqpUCQV2i4k0sDSFAp2j9p04J+JaihW7uyt97GroRjUcAwLDTU05nWPbjsXTqooI9Qvc3n+/qcp3U4jJ+/OAE+Qm0Uugy5DLaNSiYUl3a3giXdNSpAqyZIoLy0R5z9nxbArdwfEwps8/uRAf87BxsrNEec0pqTjBQ44xpVqo1IaV4csGBafj1DA1I/6zj1ewQoYKk18dGg==;7:nIrGJ/q7y4Vs26bVj3zLjTJahk5WXQ63SbMOYiKDEh5bWfYJANj1NtupODW+Taf9ppz9mo3DkiO+Dn2/owt88iwMsw5o0fhOeTSPj3Mu5HhpCzklxhA5FHwZoKFFBey04sCH51XV6OPjlmCUKTHa6Q==
x-ms-office365-filtering-correlation-id: e3db5e4f-fd9d-46ae-f3ce-08d677f71a5e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1309;
x-ms-traffictypediagnostic: MWHPR2201MB1309:
x-microsoft-antispam-prvs: <MWHPR2201MB1309D3E6225464F1DF566FC2C1850@MWHPR2201MB1309.namprd22.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(346002)(39840400004)(366004)(136003)(376002)(52314003)(189003)(199004)(53936002)(8676002)(33896004)(14444005)(6486002)(54906003)(256004)(186003)(486006)(6916009)(476003)(99286004)(14454004)(52116002)(6436002)(9686003)(6512007)(39060400002)(71200400001)(66066001)(106356001)(71190400001)(76176011)(7736002)(25786009)(305945005)(1076003)(102836004)(316002)(26005)(6116002)(386003)(3846002)(58126008)(68736007)(5660300001)(97736004)(4326008)(81156014)(105586002)(42882007)(6246003)(6506007)(81166006)(11346002)(44832011)(8936002)(478600001)(446003)(2906002)(229853002)(33716001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1309;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FgQDOCRTyKw3hnkjGQbyXBcAEfjFC+aQTwNnNL4BjwyGLZUDUpcRM3sDhNlrnhBytZPvw50OdRe/KHrQ2SOGY+7b/SQGWfigWFxZ+0kj8Hg4djInWd1d3ho3AvNtbLJwc5OMbgwLGm7hdURR/wDMgEJYX7hVcLcbmdrewGjjzIPKudGWmS2yicN41n7bJZzeAensK3CRjVs4zBGLLacGMBI2Vcv1czCv1z5G2mI3wlqWJMopUmxmO+7JlyHGa6yMXXLfkjNMVWdK92i5bGGSdEdNx8kBvpg+ujd/f0xajDfPVtyX7a3K3h0Z6vsAhS5/rBcv9tuBKF2G/KNS588/LTPxh5CVUOXW+DvfBZ+KcCJk5FE8jlTSJmd+3AkO6J/0pV9XxIUTrsCA/lv/bV48PGVRnsJ17+zhR3U64RbCUGE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4309A4462D4E4444A9EB9F6DF96AC44A@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3db5e4f-fd9d-46ae-f3ce-08d677f71a5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 19:00:50.4613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1309
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

SGVsbG8sDQoNCk9uIEZyaSwgSmFuIDExLCAyMDE5IGF0IDA4OjQwOjQ5UE0gKzA4MDAsIOW+kOaI
kOWNjiB3cm90ZToNCj4gRm9yIExvb25nc29uIDNBMTAwMCBhbmQgM0EzMDAwLCB3aGVuIGEgbWVt
b3J5IGFjY2VzcyBpbnN0cnVjdGlvbg0KPiAobG9hZCwgc3RvcmUsIG9yIHByZWZldGNoKSdzIGV4
ZWN1dGluZyBvY2N1cnMgYmV0d2VlbiB0aGUgZXhlY3V0aW9uIG9mDQo+IExMIGFuZCBTQywgdGhl
IHN1Y2Nlc3Mgb3IgZmFpbHVyZSBvZiBTQyBpcyBub3QgcHJlZGljdGFibGUuICBBbHRob3VnaA0K
PiBwcm9ncmFtbWVyIHdvdWxkIG5vdCBpbnNlcnQgbWVtb3J5IGFjY2VzcyBpbnN0cnVjdGlvbnMg
YmV0d2VlbiBMTCBhbmQNCj4gU0MsIHRoZSBtZW1vcnkgaW5zdHJ1Y3Rpb25zIGJlZm9yZSBMTCBp
biBwcm9ncmFtLW9yZGVyLCBtYXkNCj4gZHluYW1pY2FsbHkgZXhlY3V0ZWQgYmV0d2VlbiB0aGUg
ZXhlY3V0aW9uIG9mIExML1NDLCBzbyBhIG1lbW9yeQ0KPiBmZW5jZShTWU5DKSBpcyBuZWVkZWQg
YmVmb3JlIExML0xMRCB0byBhdm9pZCB0aGlzIHNpdHVhdGlvbi4NCj4gDQo+IFNpbmNlIDNBMzAw
MCwgd2UgaW1wcm92ZWQgb3VyIGhhcmR3YXJlIGRlc2lnbiB0byBoYW5kbGUgdGhpcyBjYXNlLg0K
PiBCdXQgd2UgbGF0ZXIgZGVkdWNlIGEgcmFyZWx5IGNpcmN1bXN0YW5jZSB0aGF0IHNvbWUgc3Bl
Y3VsYXRpdmVseQ0KPiBleGVjdXRlZCBtZW1vcnkgaW5zdHJ1Y3Rpb25zIGR1ZSB0byBicmFuY2gg
bWlzcHJlZGljdGlvbiBiZXR3ZWVuIExML1NDDQo+IHN0aWxsIGZhbGwgaW50byB0aGUgYWJvdmUg
Y2FzZSwgc28gYSBtZW1vcnkgZmVuY2UoU1lOQykgYXQNCj4gYnJhbmNoLXRhcmdldChpZiBpdHMg
dGFyZ2V0IGlzIG5vdCBiZXR3ZWVuIExML1NDKSBpcyBuZWVkZWQgZm9yIDNBMTAwMA0KPiBhbmQg
M0EzMDAwLg0KDQpUaGFuayB5b3UgLSB0aGF0IGRlc2NyaXB0aW9uIGlzIHJlYWxseSBoZWxwZnVs
Lg0KDQpJIGhhdmUgYSBmZXcgZm9sbG93LXVwIHF1ZXN0aW9ucyBpZiB5b3UgZG9uJ3QgbWluZDoN
Cg0KIDEpIElzIGl0IGNvcnJlY3QgdG8gc2F5IHRoYXQgdGhlIG9ubHkgY29uc2VxdWVuY2Ugb2Yg
dGhlIGJ1ZyBpcyB0aGF0IGFuDQogICAgU0MgbWlnaHQgZmFpbCB3aGVuIGl0IG91Z2h0IHRvIGhh
dmUgc3VjY2VlZGVkPw0KDQogMikgRG9lcyB0aGF0IG1lYW4gcGxhY2luZyBhIHN5bmMgYmVmb3Jl
IHRoZSBMTCBpcyBwdXJlbHkgYSBwZXJmb3JtYW5jZQ0KICAgIG9wdGltaXphdGlvbj8gaWUuIGlm
IHdlIGRvbid0IGhhdmUgdGhlIHN5bmMgJiB0aGUgU0MgZmFpbHMgdGhlbg0KICAgIHdlJ2xsIHJl
dHJ5IHRoZSBMTC9TQyBhbnl3YXksIGFuZCB0aGlzIHRpbWUgbm90IGhhdmUgdGhlIHJlb3JkZXJl
ZA0KICAgIGluc3RydWN0aW9uIGZyb20gYmVmb3JlIHRoZSBMTCB0byBjYXVzZSBhIHByb2JsZW0u
DQoNCiAzKSBJbiB0aGUgc3BlY3VsYXRpdmUgZXhlY3V0aW9uIGNhc2Ugd291bGQgaXQgYWxzbyB3
b3JrIHRvIHBsYWNlIGEgc3luYw0KICAgIGJlZm9yZSB0aGUgYnJhbmNoIGluc3RydWN0aW9uLCBp
bnN0ZWFkIG9mIGF0IHRoZSBicmFuY2ggdGFyZ2V0PyBJbg0KICAgIHNvbWUgY2FzZXMgdGhpcyBt
aWdodCBiZSBuaWNlciBzaW5jZSB0aGUgd29ya2Fyb3VuZCB3b3VsZCBiZQ0KICAgIGNvbnRhaW5l
ZCB3aXRoaW4gdGhlIExML1NDIGxvb3AsIGJ1dCBJIGd1ZXNzIGl0IGNvdWxkIHBvdGVudGlhbGx5
DQogICAgYWRkIG1vcmUgb3ZlcmhlYWQgaWYgdGhlIGJyYW5jaCBpcyBjb25kaXRpb25hbCAmIG5v
dCB0YWtlbi4NCg0KIDQpIFdoZW4gd2UgdGFsayBhYm91dCBicmFuY2hlcyBoZXJlLCBpcyBpdCBy
ZWFsbHkganVzdCBicmFuY2gNCiAgICBpbnN0cnVjdGlvbnMgdGhhdCBhcmUgYWZmZWN0ZWQgb3Ig
d2lsbCB0aGUgQ1BVIHNwZWN1bGF0ZSBwYXN0IGp1bXANCiAgICBpbnN0cnVjdGlvbnMgdG9vPw0K
DQpJIGp1c3Qgd2FudCB0byBiZSBzdXJlIHRoYXQgd2Ugd29yayBhcm91bmQgdGhpcyBwcm9wZXJs
eSwgYW5kIGRvY3VtZW50DQppdCBpbiB0aGUga2VybmVsIHNvIHRoYXQgaXQncyBjbGVhciB0byBk
ZXZlbG9wZXJzIHdoeSB0aGUgd29ya2Fyb3VuZA0KZXhpc3RzICYgaG93IHRvIGF2b2lkIGludHJv
ZHVjaW5nIGJ1Z3MgZm9yIHRoZXNlIENQVXMgaW4gZnV0dXJlLg0KDQo+IE91ciBwcm9jZXNzb3Ig
aXMgY29udGludWFsbHkgZXZvbHZpbmcgYW5kIHdlIGFpbSB0byB0byByZW1vdmUgYWxsDQo+IHRo
ZXNlIHdvcmthcm91bmQtU1lOQ3MgYXJvdW5kIExML1NDIGZvciBuZXctY29tZSBwcm9jZXNzb3Iu
IA0KDQpJJ20gdmVyeSBnbGFkIHRvIGhlYXIgdGhhdCA6KQ0KDQpJIGhvcGUgb25lIGRheSBJIGNh
biBnZXQgbXkgaGFuZHMgb24gYSBuaWNlIExvb25nc29uIGxhcHRvcCB0byB0ZXN0DQp3aXRoLg0K
DQpUaGFua3MsDQogICAgUGF1bA0K
