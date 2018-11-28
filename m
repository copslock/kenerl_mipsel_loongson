Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Nov 2018 20:15:00 +0100 (CET)
Received: from mail-eopbgr810108.outbound.protection.outlook.com ([40.107.81.108]:39620
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993997AbeK1TO5nJiFb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Nov 2018 20:14:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q21+nfemNPT7yVPfWgeTKbUOmMcnnAlfPTlRzglD4GU=;
 b=WcMD6AQcdJfDYYQ9bHGsbMFzKF25ItOnwm9cwGE3aIBhVAbP7hOBfZ3hgXbOYfCK65XBuQ6NMyzxAZFnwVY5P3nPlI4WrJzqoVb9IS+2x9f+e0Z8IsOMfFkg5QqXtsyQchcbh7/KHh94OcNHfHW25hXKsAWBu6bOInheBcA6Orc=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1407.namprd22.prod.outlook.com (10.172.63.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Wed, 28 Nov 2018 19:14:53 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985%3]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 19:14:53 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Yunqiang Su <ysu@wavecomp.com>
CC:     Huacai Chen <chenhc@lemote.com>,
        Paul Burton <pburton@wavecomp.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V5 8/8] MIPS: Loongson: Introduce and use WAR_LLSC_MB
Thread-Topic: [PATCH V5 8/8] MIPS: Loongson: Introduce and use WAR_LLSC_MB
Thread-Index: AQHUhzeVHnUoSFyE702JpMksTdYL2KVlZCsAgAAqq4A=
Date:   Wed, 28 Nov 2018 19:14:53 +0000
Message-ID: <20181128191451.6prt4tfnq7lcc6xn@pburton-laptop>
References: <1542268439-4146-1-git-send-email-chenhc@lemote.com>
 <1542268439-4146-9-git-send-email-chenhc@lemote.com>
 <683DD368-80DC-47CC-A8DD-5D229FF501D0@wavecomp.com>
 <MWHPR2201MB126144067773D533638F1759DED10@MWHPR2201MB1261.namprd22.prod.outlook.com>
In-Reply-To: <MWHPR2201MB126144067773D533638F1759DED10@MWHPR2201MB1261.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:300:4b::32) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1407;6:0J8DcicbO4WrkSp/EQAz4/z5AnN7tmE5ME3SczA7qLVayPnAPBGcTsbChgA0oyUrb1IGb4b/17kO4rzhFEP1JxGezd+BSy47LFfbP1yX6AzEW7j8mm9di3h3Bpats/H64e8OQ12c6mYH2iKmZgCQf5zJYjhfcmfVlOrVYfpOvk0jqYtqf+zf3tpa5OSuIVHsokOwDOWccJeR5WOp+cOqrnYwrHD1i7lQGpBp7W0T8XsxQM1aTIk+/NaktMpey1Ipt0RPj4Oqkm3fts5u/nf57DXOmzc5NGNGnwTTaMh4cPbIACiKUDz5mo+Z34LktKSJda4sJWKTA8kvSyKWcAFKnroKiP4nBYufmgAHlKjARp2SpV09fRVMy9aU6ineJb8GmLCy85dK0WbRspU9aLi7yBrstS4xa311Ivty131jMmGboRbXXO/AZqNmQYEoWMpcnUpbPrh5cGhTSQXBMpTUZw==;5:J69EKk/MlEAgo5guJwjzI7S4NxxgKnZzlo3Y/IwIO056tgG5rgwJsvfpM1LcoGA/IeVyPO/UTeQyx+z9nkmLKfkhWwk2isbL/WSZYTrHpa295huhgeujIf99lWsJKp4hGX4x+z3Gx5Ieq9NHYrCRkMQLEQUwK+8HJtQfqIaAKHQ=;7:EtPHO6gojlWvL1YqgrxOv3sK1R9nHpBnDr4GOH1pYV+L11hVpH1TeIuMX5aB/K2gQHj29W4+5bPDTXnGISvwmAPTk0H/L+3rAdFdC7fFDnXrwU438m3mEVXbQqW12dtb65mHvBsAHeSrHXto7pV0JA==
x-ms-office365-filtering-correlation-id: dfb32fa3-30cc-4ba2-706c-08d65565c658
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1407;
x-ms-traffictypediagnostic: MWHPR2201MB1407:
x-microsoft-antispam-prvs: <MWHPR2201MB14072F2009176E4EC0B88DD8C1D10@MWHPR2201MB1407.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231443)(999002)(944501410)(52105112)(93006095)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(2016111802025)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1407;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1407;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(39840400004)(396003)(346002)(376002)(366004)(199004)(189003)(8676002)(8936002)(81166006)(229853002)(3846002)(6116002)(66066001)(81156014)(33716001)(316002)(1076002)(58126008)(54906003)(14454004)(5660300001)(93886005)(305945005)(2906002)(7736002)(478600001)(42882007)(476003)(446003)(486006)(11346002)(53936002)(44832011)(4326008)(6246003)(68736007)(39060400002)(6862004)(52116002)(105586002)(6506007)(106356001)(26005)(102836004)(76176011)(33896004)(71200400001)(99286004)(386003)(256004)(6436002)(6512007)(9686003)(186003)(71190400001)(6486002)(97736004)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1407;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4kzymGFkkNwhe5ovoVu98NUab6Ll+oQhNbylIUoQa/uxehyRveuk2LMrO9DcHNjpaRB9QDaiGU2tY17fYUmSWKpEWdzPI9ss3aLkXY42fum9qtHioLOswDLly4cSfUD/7xrRWpeKiBdn/h225kHMQlrHdyBpwV531CiAIX9JGG4OmLkEaSZbxprGjzDGXPYhH/cNXVQIqAyZms7G6A8J5YrrzzSW6Op82JcQoXMtbzlTJvMnH1TAEgXHTttXxl4sIFT6UbxSsFcSrkk/VlZQez8wlwv3G79rjMb3dgdV3RcGzRPwUAdeSmCJplX3lRcePmA03IRdqSjQmacvDkzX7YI04m9+ahjCGJF7mr3/XMw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B041A93253DE4442A979097E1FB5C0AA@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb32fa3-30cc-4ba2-706c-08d65565c658
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 19:14:53.3027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1407
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67537
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

SGkgWXVucWlhbmcsDQoNClBsZWFzZSBzZW5kIG9ubHkgcGxhaW4gdGV4dCBtYWlsIHRvIHRoZSBs
aW51eC1taXBzIG1haWxpbmcgbGlzdCwgYW5kDQpkb24ndCB0b3AtcG9zdC4NCg0KT24gV2VkLCBO
b3YgMjgsIDIwMTggYXQgMDg6NDI6MDhBTSAtMDgwMCwgWXVucWlhbmcgU3Ugd3JvdGU6DQo+ID4g
5ZyoIDIwMTjlubQxMeaciDE15pel77yM5LiL5Y2IMzo1M++8jEh1YWNhaSBDaGVuIDxjaGVuaGNA
bGVtb3RlLmNvbT4g5YaZ6YGT77yaDQo+ID4NCj4gPiBPbiB0aGUgTG9vbmdzb24tMkcvMkgvM0Ev
M0IgdGhlcmUgaXMgYSBoYXJkd2FyZSBmbGF3IHRoYXQgbGwvc2MgYW5kDQo+ID4gbGxkL3NjZCBp
cyB2ZXJ5IHdlYWsgb3JkZXJpbmcuIFdlIHNob3VsZCBhZGQgc3luYyBpbnN0cnVjdGlvbnMgYmVm
b3JlDQo+ID4gZWFjaCBsbC9sbGQgYW5kIGFmdGVyIHRoZSBsYXN0IHNjL3NjZCB0byB3b3JrYXJv
dW5kLiBPdGhlcndpc2UsIHRoaXMNCj4gPiBmbGF3IHdpbGwgY2F1c2UgZGVhZGxvY2sgb2NjYXRp
b25hbGx5IChlLmcuIHdoZW4gZG9pbmcgaGVhdnkgbG9hZCB0ZXN0DQo+ID4gd2l0aCBMVFApLg0K
PiA+DQo+ID4gVGhpcyBwYXRjaCBpcyBub3QgYSBtaW5pbWFsIGNoYW5nZSAoaXQgaXMgdmVyeSBk
aWZmaWN1bHQgdG8gbWFrZSBhDQo+ID4gbWluaW1hbCBjaGFuZ2UpLCBidXQgaXQgaXMgYSBzYWZl
c3QgY2hhbmdlLg0KPiA+DQo+ID4gV2h5IGRpc2FibGUgZml4LWxvb25nc29uMy1sbHNjIGluIGNv
bXBpbGVyPw0KPiA+IEJlY2F1c2UgY29tcGlsZXIgZml4IHdpbGwgY2F1c2UgcHJvYmxlbXMgaW4g
a2VybmVsJ3MgLmZpeHVwIHNlY3Rpb24uDQo+DQo+IEBQYXVsIEJ1cnRvbiBMb29uZ3NvbiAzQS9C
IDMwMDAgaGF2ZSBhIGJ1ZyBvZiBsbC9zYywgd2hpY2ggaXMgbm90IGluIDNBLzNCIDEwMDANCj4g
ZXZlbi4NCg0KRG8geW91IGhhdmUgYW55IGRldGFpbHM/IEFyZSB5b3Ugc2F5aW5nIHRoYXQgdGhl
IHByb2JsZW0gSHVhY2FpJ3MgcGF0Y2gNCmFkZHJlc3NlcyBvbmx5IGFwcGxpZXMgdG8gdGhvc2Ug
bW9kZWxzLCBvciB0aGF0IHRoZXJlJ3MgYSBzZXBhcmF0ZQ0KcHJvYmxlbT8NCg0KVGhhbmtzLA0K
ICAgIFBhdWwNCg==
