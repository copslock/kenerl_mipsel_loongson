Return-Path: <SRS0=2fGM=PS=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2BDC43387
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 17:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8197D208E3
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 17:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="OeAzXEls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbfAJRf5 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:35:57 -0500
Received: from mail-eopbgr720132.outbound.protection.outlook.com ([40.107.72.132]:24928
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729918AbfAJRf5 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 10 Jan 2019 12:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ri++eyPjk2IgWeoZU7veDkwIWwiUofCProjuvt4K3hM=;
 b=OeAzXElsdPMYaJff4z15j4CpGq/RgGybGa+Wtz1m5I2halPL8/JjssUWzBAU6+NgTaALxmj+pxt3TaTSl/Y+fxgq34pEvbgYrn2ZfXbH0wpgc4b5+qQO/TIDyVR5hglv1/WpCjVCbBCV8R4KECpJGMybaoAeZgi65bX+xV1wY/w=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1167.namprd22.prod.outlook.com (10.174.168.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Thu, 10 Jan 2019 17:35:53 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110%4]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 17:35:53 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Yunqiang Su <ysu@wavecomp.com>, YunQiang Su <syq@debian.org>,
        "paul.hua.gm@gmail.com" <paul.hua.gm@gmail.com>
CC:     Paul Burton <pburton@wavecomp.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "chehc@lemote.com" <chehc@lemote.com>,
        "zhangfx@lemote.com" <zhangfx@lemote.com>,
        "wuzhangjin@gmail.com" <wuzhangjin@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2] MIPS: Loongson, add sync before target of branch
 between llsc
Thread-Topic: [PATCH 1/2] MIPS: Loongson, add sync before target of branch
 between llsc
Thread-Index: AQHUpQeBAWrYYUkmtUGq4PuZ5oHDz6WnhbYAgABAXoCAAQW6AA==
Date:   Thu, 10 Jan 2019 17:35:53 +0000
Message-ID: <20190110173552.aeghk2rjiqcglgh6@pburton-laptop>
References: <20190105150037.30261-1-syq@debian.org>
 <20190109220844.qk5ufkzjmfwxe5aq@pburton-laptop>
 <723B8029-77BE-4DF8-A9FB-74E59F8AA6F8@wavecomp.com>
In-Reply-To: <723B8029-77BE-4DF8-A9FB-74E59F8AA6F8@wavecomp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:74::35) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1167;6:6oLAGVO2XryajoifjN5M4eU38ddVw2011vwDJb0JNG/t2CLzF5ege5ixrkrU4itLITpO2iNMpUGCP9z10BIumP7hU7LIHA9ZRClIQWcf8b4tM0zrqc/a8ns5yRBPB1b2pCVSmPJ+fQQL2Xby/OrkLFlWDkVZF4VWlwnlQMXHdE8NQLjc/YBLNCkvx14FW/BGyXo8i1UQijM7vWyg7BrpztA4xSc6+RiIQu3R4OXb/o96zPBjPx+tDuVENVrmne50CjRQXgoQmvFH0cmsw/6FMtz2MzS4Ok2K0fIrY4ch76NfBVeiCnPti735qyVrbWUUbbpFWNsrrHF1sr31XhOCDbtHQ9Wq2utYoZhhyydA7xhC5ASk+M80NdGq5WJGTOfvCvgaX7v2htSIwvdeUvM5oLyunO+v/fn8+9RJg9dOS+/ph9tiKUHoEK2sAXhvX4wrsYoiT7R5bxE+UlRwIeo5Jw==;5:/k8asDB6r1JgrEjGiAgptOJ8w1m73NZf5QV/Tztm8to5xZ9qY4dMEACe7WZ80fenVUIzyiuTiIu2TPzZEF2YFO6x90GHIMM7H2h3K26bmAfE10mEWIg1V5R5nkTXdeX4tx6hspzIXo/6ljsiMEuU5RE4OZSThn5ig6pxWp6v2RAS6xHzt9ynYMVgNJLyGnFkfdUtMRNUTLS59qct1ZtGgw==;7:o2O9vRELr1jQrqejdsUNLTKgW6g3OSiV1Bormn6R6DiT8WJYdZwMdK6Nfm5rf5prYl6G/WygTa8xDEBViEYhpHySwAxKC1pzHNb1qmMZ0d6oRPWllNl/z5mZIjdhmiiNEPhyfrqq+ODpOb/S6hWT6g==
x-ms-office365-filtering-correlation-id: e17d2c5f-5b53-461c-d29c-08d6772211e3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1167;
x-ms-traffictypediagnostic: MWHPR2201MB1167:
x-microsoft-antispam-prvs: <MWHPR2201MB1167AC04A9FC49D57E5B7AA1C1840@MWHPR2201MB1167.namprd22.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39840400004)(396003)(366004)(136003)(376002)(346002)(199004)(189003)(7736002)(97736004)(3846002)(6512007)(476003)(68736007)(4326008)(39060400002)(105586002)(486006)(2501003)(305945005)(44832011)(9686003)(99286004)(53936002)(567974002)(6116002)(6246003)(71200400001)(2906002)(106356001)(6306002)(446003)(71190400001)(25786009)(11346002)(33716001)(33896004)(102836004)(6506007)(386003)(66066001)(8936002)(76176011)(186003)(26005)(54906003)(58126008)(1076003)(14454004)(52116002)(42882007)(966005)(6436002)(478600001)(256004)(8676002)(316002)(229853002)(81166006)(110136005)(5660300001)(81156014)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1167;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ytNmo9i9DbbTU13SD6HjpnyJT1y2oSiyx0nVOVkjm4NYC4b5LHPG/Q804dxCpB+WpXK5f7LHQO98KVj35IuNTFgFAKkVzfOF9wETMGiQFacCTZsc1DCmc88yMEEK6AGz6yzqHmGnvTMGf6K0ATnEy/FS1DxEmVqMlsNBmiUZqdeRtNiRIscIYXtBiR6XvEJM57bWUcBO3Wmtev280ywsFH3Y94KBwrLjAALvC/IGQikj3iWfRfZAwa1r8fXAYkLSnuO5iHW47aCybnOUZ7Pd0EVyDmIpdgGTs2+WNfP3uELPT9Sd+vbp+1LI7eAXRZlR
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F11274F5CDE0B42AE4A2BF822F137C8@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e17d2c5f-5b53-461c-d29c-08d6772211e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 17:35:53.6554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1167
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

SGkgWXVucWlhbmcsDQoNCk9uIFdlZCwgSmFuIDA5LCAyMDE5IGF0IDA1OjU5OjA3UE0gLTA4MDAs
IFl1bnFpYW5nIFN1IHdyb3RlOg0KPiA+IOWcqCAyMDE55bm0MeaciDEw5pel77yM5LiK5Y2INjow
OO+8jFBhdWwgQnVydG9uIDxwYnVydG9uQHdhdmVjb21wLmNvbT4g5YaZ6YGT77yaDQo+ID4gT24g
U2F0LCBKYW4gMDUsIDIwMTkgYXQgMTE6MDA6MzZQTSArMDgwMCwgWXVuUWlhbmcgU3Ugd3JvdGU6
DQo+ID4+IExvb25nc29uIDJHLzJILzNBLzNCIGlzIHF1aXRlIHdlYWsgc3luYydlZC4gSWYgdGhl
cmUgaXMgYSBicmFuY2gsDQo+ID4+IGFuZCB0aGUgdGFyZ2V0IGlzIG5vdCBpbiB0aGUgc2NvcGUg
b2YgbGwvc2Mgb3IgbGxkL3NjZCwgYSBzeW5jIGlzDQo+ID4+IG5lZWRlZCBhdCB0aGUgcG9zdGlv
biBvZiB0YXJnZXQuDQo+ID4gDQo+ID4gT0ssIHNvIGlzIHRoaXMgdGhlIHNhbWUgaXNzdWUgdGhh
dCB0aGUgc2Vjb25kIHBhdGNoIGluIHRoZSBzZXJpZXMgaXMNCj4gPiB3b3JraW5nIGFyb3VuZCBv
ciBhIGRpZmZlcmVudCBvbmU/DQo+ID4gDQo+ID4gSSdtIHByZXR0eSBjb25mdXNlZCBhdCB0aGlz
IHBvaW50IGFib3V0IHdoYXQgdGhlIGFjdHVhbCBidWdzIGFyZSBpbg0KPiA+IHRoZXNlIHZhcmlv
dXMgTG9vbmdzb24gQ1BVcy4gQ291bGQgc29tZW9uZSBwcm92aWRlIGFuIGFjdHVhbCBlcnJhdGEN
Cj4gPiB3cml0ZXVwIGRlc2NyaWJpbmcgdGhlIGJ1Z3MgaW4gZGV0YWlsPw0KPiA+IA0KPiA+IFdo
YXQgZG9lcyAiaW4gdGhlIHNjb3BlIG9mIGxsL3NjIiBtZWFuPw0KPiANCj4gTG9vbmdzb24gMyBz
ZXJpZXMgaGFzIHNvbWUgdmVyc2lvbiwgY2FsbGVkLCAxMDAwLCAyMDAwLCBhbmQgMzAwMC4NCj4g
DQo+IFRoZXJlIGFyZSAyIGJ1Z3MgYWxsIGFib3V0IExML1NDLiBMZXTigJlzIGNhbGwgdGhlbSBi
dWctMSBhbmQgYnVnLTIuDQo+IA0KPiBCVUctMTogIGEgYHN5bmPigJkgaXMgbmVlZGVkIGJlZm9y
ZSBMTCBvciBMTEQgaW5zdHJ1Y3Rpb24uDQo+ICAgICAgICAgICAgICAgVGhpcyBidWcgYXBwZWFy
cyBvbiAxMDAwIG9ubHksIGFuZCBJIGFtIHN1cmUgdGhhdCBpdCBoYXMgYmVlbiBmaXhlZCBpbiAz
MDAwLg0KPiANCj4gQlVHLTI6IGlmIHRoZXJlIGlzIGFuIGJyYW5jaCBpbnN0cnVjdGlvbiBpbnNp
ZGUgTEwvU0MsIGFuZCB0aGUgYnJhbmNoIHRhcmdldCBpcyBvdXRzaWRlDQo+ICAgICAgICAgICAg
ICBvZiB0aGUgc2NvcGUgb2YgTEwvU0MsIGEgYHN5bmPigJkgaXMgbmVlZGVkIGF0IHRoZSBicmFu
Y2ggdGFyZ2V0Lg0KPiAgICAgICAgICAgICAgQWthLCB0aGUgZmlyc3QgaW5zbiBvZiB0aGUgdGFy
Z2V0IGJyYW5jaCBzaG91bGQgYmUgYHN5bmPigJkuDQo+ICAgICAgICAgICAgICBMb29uZ3NvbiBz
YWlkIHRoYXQsIHdlIGRvbuKAmXQgcGxhbiBmaXggdGhpcyBwcm9ibGVtIGluIHNob3J0IHRpbWUg
YmVmb3JlIHRoZXkNCj4gICAgICAgICAgICAgIERlc2lnbmUgYSB0b3RhbGx5IG5ldyBjb3JlLg0K
PiAgICAgICAgICAgICAgIA0KPiANCj4gPiBXaGF0IGhhcHBlbnMgaWYgYSBicmFuY2ggdGFyZ2V0
IGlzIG5vdCAiaW4gdGhlIHNjb3BlIG9mIGxsL3Nj4oCdPw0KPiANCj4gQXQgbGVhc3QgdGhleSBz
YWlkIHRoYXQgdGhlcmUgd29u4oCZdCBiZSBhIHByb2JsZW0NCg0KWW91IHN0aWxsIGRpZG4ndCBk
ZWZpbmUgd2hhdCAiaW4gdGhlIHNjb3BlIG9mIGxsL3NjIiBtZWFucyAtIEknbQ0KZ3Vlc3Npbmcg
dGhhdCB5b3UncmUgcmVmZXJyaW5nIHRvIGEgYnJhbmNoIHRhcmdldCBhcyAiaW4gc2NvcGUiIGlm
IGl0IGlzDQppbiBiZXR3ZWVuIHRoZSBsbCAmIHNjIGluc3RydWN0aW9ucyAoaW5jbHVzaXZlPyku
IEJ1dCB0aGlzIGlzIGp1c3QgYQ0KZ3Vlc3MgJiBjbGFyaXR5IGZyb20gcGVvcGxlIHdobyBhY3R1
YWxseSBrbm93IHdvdWxkIGJlIGhlbHBmdWwuDQoNCkFuZCB0aGVyZSBtdXN0IGJlIGEgcHJvYmxl
bS4gVGhlIHdob2xlIHBvaW50IG9mIHRoaXMgaXMgdGhhdCB0aGVyZSdzIGENCmJ1ZywgcmlnaHQ/
IElmIHRoZXJlJ3Mgbm8gcHJvYmxlbSB0aGVuIHdlIGRvbid0IG5lZWQgdG8gZG8gYW55dGhpbmcg
OikNCg0KRnJvbSBhIGxvb2sgYXQgdGhlIEdDQyBwYXRjaCBpdCB0YWxrcyBhYm91dCBwbGFjaW5n
IGEgc3luYyBhdCBhIGJyYW5jaA0KdGFyZ2V0IGlmIGl0ICppcyogaW4gYmV0d2VlbiBhbiBsbCAm
IHNjIFsxXSwgd2hpY2ggSSBqdXN0IGNhbid0DQpyZWNvbmNpbGUgd2l0aCB0aGUgcGhyYXNlICJv
dXRzaWRlIG9mIHRoZSBzY29wZSBvZiBMTC9TQyIuIElzIHRoZQ0KcHJvYmxlbSB3aGVuIGEgYnJh
bmNoIHRhcmdldCAqaXMqIGluIGJldHdlZW4gYW4gbGwgJiBzYywgb3Igd2hlbiBpdCAqaXMNCm5v
dCogYmV0d2VlbiBhbiBsbCAmIHNjPw0KDQpSZWFkaW5nIHRoaXMga2VybmVsIHBhdGNoIGRvZXNu
J3QgbWFrZSBpdCBhbnkgY2xlYXJlciAtIGZvciBleGFtcGxlIHRoZQ0Kc3luYyBpdCBlbWl0cyBp
biBidWlsZF9sb29uZ3NvbjNfdGxiX3JlZmlsbF9oYW5kbGVyKCkgaXMgbm93aGVyZSBuZWFyIGFu
DQpsbCBvciBzYyBpbnN0cnVjdGlvbi4gU29tZXRoaW5nIGRvZXNuJ3QgYWRkIHVwIGhlcmUuDQoN
Cj4gPiBIb3cgZG9lcyB0aGUgc3luYyBoZWxwPw0KPiA+IA0KPiA+IEFyZSBqdW1wcyBhZmZlY3Rl
ZCwgb3IganVzdCBicmFuY2hlcz8NCj4gDQo+IEkgYW0gbm90IHN1cmUsIHNvIENDIGEgTG9vbmdz
b24gcGVvcGxlLg0KPiBAUGF1bCBIdWENCg0KSGkgUGF1bCAtIGFueSBoZWxwIG9idGFpbmluZyBh
IGRldGFpbGVkIGRlc2NyaXB0aW9uIG9mIHRoZXNlIGJ1Z3Mgd291bGQNCmJlIG11Y2ggYXBwcmVj
aWF0ZWQuIEV2ZW4gaWYgeW91IG9ubHkgaGF2ZSBzb21ldGhpbmcgaW4gQ2hpbmVzZSBJIGNhbg0K
cHJvYmFibHkgZ2V0IHNvbWVvbmUgdG8gaGVscCB0cmFuc2xhdGUuDQoNCj4gPiBEb2VzIHRoaXMg
YWZmZWN0IHVzZXJsYW5kIGFzIHdlbGwgYXMgdGhlIGtlcm5lbD8NCj4gDQo+IFRoZXJlIGlzIGZl
dyBwbGFjZSBjYW4gdHJpZ2dlciB0aGVzZSAyIGJ1Z3MgaW4ga2VybmVsLg0KPiBJbiB1c2VyIGxh
bmQgd2UgaGF2ZSB0byB3b3JrYXJvdW5kIGluIGJpbnV0aWxzOiAgDQo+ICAgIGh0dHBzOi8vd3d3
LnNvdXJjZXdhcmUub3JnL21sL2JpbnV0aWxzLzIwMTktMDEvbXNnMDAwMjUuaHRtbA0KPiANCj4g
SW4gZmFjdCB0aGUga2VybmVsIGlzIHRoZSBlYXNpZXN0IHNpbmNlIHdlIGNhbiBoYXZlIGEgZmxh
dm9yIGJ1aWxkIGZvciBMb29uZ3Nvbi4NCg0KTXkgY29uY2VybiB3aXRoIHJlZ2FyZHMgdG8gdXNl
cmxhbmQgaXMgdGhhdCB0aGVyZSdzIHRhbGsgb2YgYSAiZGVhZGxvY2siDQotIGlmIHVzZXJsYW5k
IGNhbiBoaXQgdGhpcyAmIHRoZSBDUFUgYWN0dWFsbHkgc3RhbGxzIHRoZW4gdGhlIHN5c3RlbSBp
cw0KaG9wZWxlc3NseSB2dWxuZXJhYmxlIHRvIGRlbmlhbCBvZiBzZXJ2aWNlIGZyb20gYSBtYWxp
Y2lvdXMgb3IgYnVnZ3kNCnVzZXJsYW5kIHByb2dyYW0sIG9yIHNpbXBseSBhbiBpbm5vY2VudCBw
cm9ncmFtIHVuYXdhcmUgb2YgdGhlIGVycmF0YS4NCg0KPiA+IC4uLmFuZCBwcm9iYWJseSBtb3Jl
IHF1ZXN0aW9ucyBkZXBlbmRpbmcgdXBvbiB0aGUgYW5zd2VycyB0byB0aGVzZSBvbmVzLg0KPiA+
IA0KPiA+PiBMb29uZ3NvbiBkb2Vzbid0IHBsYW4gdG8gZml4IHRoaXMgcHJvYmxlbSBpbiBmdXR1
cmUsIHNvIHdlIGFkZCB0aGUNCj4gPj4gc3luYyBoZXJlIGZvciBhbnkgY29uZGl0aW9uLg0KPiA+
IA0KPiA+IFNvIGFyZSB5b3Ugc2F5aW5nIHRoYXQgZnV0dXJlIExvb25nc29uIENQVXMgd2lsbCBh
bGwgYmUgYnVnZ3kgdG9vLCBhbmQNCj4gPiBzb21lb25lIHRoZXJlIGhhcyBzYWlkIHRoYXQgdGhl
eSBjb25zaWRlciB0aGlzIHRvIGJlIE9LLi4/IEkgcmVhbGx5DQo+ID4gcmVhbGx5IGhvcGUgdGhh
dCBpcyBub3QgdHJ1ZS4NCj4gDQo+IEJ1ZyBpcyBidWcuIEl0IGlzIG5vdCBPSy4NCj4gSSBibGFt
ZSB0aGVzZSBMb29uZ3NvbiBndXlzIGhlcmUuDQo+IFNvbWUgTG9vbmdzb24gZ3V5cyBpcyBub3Qg
c28gbm9ybWFsIHBlb3BsZS4NCj4gQW55d2F5IHRoZXkgYXJlIGEgbGl0dGxlIG1vcmUgbm9ybWFs
IG5vdywgYW5kIGFueXdheSBhZ2Fpbiwgc3RpbGwgYWJub3JtYWwuDQo+IA0KPiA+IElmIGhhcmR3
YXJlIHBlb3BsZSBzYXkgdGhleSdyZSBub3QgZ29pbmcgdG8gZml4IHRoZWlyIGJ1Z3MgdGhlbiB3
b3JraW5nDQo+ID4gYXJvdW5kIHRoZW0gaXMgZGVmaW5pdGVseSBub3QgZ29pbmcgdG8gYmUgYSBw
cmlvcml0eS4gSXQncyBvbmUgdGhpbmcgaWYNCj4gPiBhIENQVSBkZXNpZ25lciBzYXlzICJvb3Bz
LCBteSBiYWQsIHdvcmsgYXJvdW5kIHRoaXMgJiBJJ2xsIGZpeCBpdCBuZXh0DQo+ID4gdGltZSIu
IEl0J3MgcXVpdGUgYW5vdGhlciBmb3IgdGhlbSB0byBzYXkgdGhleSdyZSBub3QgaW50ZXJlc3Rl
ZCBpbg0KPiA+IGZpeGluZyB0aGVpciBidWdzIGF0IGFsbC4NCj4gDQo+IFRoZXkgaGF2ZSBpbnRl
cmVzdHMsIHdoaWxlIEkgZ3Vlc3MgdGhlIHRydWUgcmVhc29uIGlzIHRoYXQgdGhleSBoYXZlIG5v
IGVub3VnaA0KPiBwZW9wbGUgYW5kIG1vbmV5IHRvIGRlc2dpbiBhIGNvcmUsIHdoaWxlIHRoaXMg
YnVnIGlzIHF1aWx0IGhhcmQgdG8gZml4Lg0KDQpJJ20gbm90IHN1cmUgSSBmdWxseSB1bmRlcnN0
YW5kIHdoYXQgeW91J3JlIHNheWluZyBhYm92ZSwgYnV0DQplc3NlbnRpYWxseSBJIHdhbnQgdG8g
a25vdyB0aGF0IExvb25nc29uIGNhcmUgYWJvdXQgZml4aW5nIHRoZWlyIENQVQ0KYnVncy4gSWYg
dGhleSBkb24ndCwgYW5kIHRoZSBidWdzIGFyZSBhcyBiYWQgYXMgdGhleSBzb3VuZCwgdGhlbiBp
biBteQ0KdmlldyB3b3JraW5nIGFyb3VuZCB0aGVtIHdpbGwgb25seSByZWluZm9yY2UgdGhhdCBw
cm9kdWNpbmcgQ1BVcyB3aXRoDQpzdWNoIHNlcmlvdXMgYnVncyBpcyBhIGdvb2QgaWRlYS4NCg0K
U28gaWYgYW55b25lIGZyb20gTG9vbmdzb24gaXMgcmVhZGluZywgSSdkIHJlYWxseSBsaWtlIHRv
IGhlYXIgdGhhdCB0aGUNCmFib3ZlIGlzIGEgbWlzY29tbXVuaWNhdGlvbiAmIHRoYXQgeW91J3Jl
IG5vdCBpbnRlbmRpbmcgdG8ga25vd2luZ2x5DQpkZXNpZ24gYW55IGZ1cnRoZXIgQ1BVcyB3aXRo
IHRoZXNlIGJ1Z3MuDQoNClRoYW5rcywNCiAgICBQYXVsDQoNClsxXSBodHRwczovL2djYy5nbnUu
b3JnL21sL2djYy1wYXRjaGVzLzIwMTgtMTIvbXNnMDEwNjQuaHRtbA0KICAgICgiTG9vbmdzb24z
IG5lZWQgYSBzeW5jIGJlZm9yZSBicmFuY2ggdGFyZ2V0IHRoYXQgYmV0d2VlbiBsbCBhbmQgc2Mu
IikNCg==
