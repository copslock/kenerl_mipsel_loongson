Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Nov 2018 01:25:30 +0100 (CET)
Received: from mail-eopbgr780103.outbound.protection.outlook.com ([40.107.78.103]:43840
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994059AbeK2AZ1NuV-i (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 Nov 2018 01:25:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07zuwZ5gpk1oehYke2PsvrHCVSzK3b7kHxJHmeREADY=;
 b=S0d6/QhlASVvWgoWeU0s/UY9kYBmFJBWEvf2nvmzSJxPxcKow3+U6Z9oJIMkkDZ/eMBjW7buzvLrmVIii88Ifegzzrwx45S9c4o6rxA/4UFLPf16uVA/BUbYxml7WXiwrnonYsO6GeodKUNrr/FbUQnqWMc9g0PaGmL9D/wsqDE=
Received: from CY4PR2201MB1254.namprd22.prod.outlook.com (10.171.216.140) by
 CY4PR2201MB1496.namprd22.prod.outlook.com (10.171.241.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Thu, 29 Nov 2018 00:25:23 +0000
Received: from CY4PR2201MB1254.namprd22.prod.outlook.com
 ([fe80::b5ee:c737:5320:9475]) by CY4PR2201MB1254.namprd22.prod.outlook.com
 ([fe80::b5ee:c737:5320:9475%3]) with mapi id 15.20.1361.019; Thu, 29 Nov 2018
 00:25:22 +0000
From:   Yunqiang Su <ysu@wavecomp.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V5 8/8] MIPS: Loongson: Introduce and use WAR_LLSC_MB
Thread-Topic: [PATCH V5 8/8] MIPS: Loongson: Introduce and use WAR_LLSC_MB
Thread-Index: AQHUhzeRHnUoSFyE702JpMksTdYL2KVlY8ZMgAArEoCAAFazgA==
Date:   Thu, 29 Nov 2018 00:25:22 +0000
Message-ID: <1562154C-5A13-452C-802F-F48F919D4DC4@wavecomp.com>
References: <1542268439-4146-1-git-send-email-chenhc@lemote.com>
 <1542268439-4146-9-git-send-email-chenhc@lemote.com>
 <683DD368-80DC-47CC-A8DD-5D229FF501D0@wavecomp.com>
 <MWHPR2201MB126144067773D533638F1759DED10@MWHPR2201MB1261.namprd22.prod.outlook.com>
 <20181128191451.6prt4tfnq7lcc6xn@pburton-laptop>
In-Reply-To: <20181128191451.6prt4tfnq7lcc6xn@pburton-laptop>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ysu@wavecomp.com; 
x-originating-ip: [2409:8900:1e50:49ce:6d5a:134c:b122:bdd0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2201MB1496;6:YQJ1Vo8Es9gqL0hpilp7wTRCIHQc2HNRoHRbff9r3fLHygJhSAhJwERWQw6n3oBKvolDxm2tYC1sXvhfHz840zLK5hkbJszI2VqNI/jrUezktZl8IcC7AtltejVxuzMPqZKoEIB4bqI2JONQqsOJKRXEVz9FF6dkCgqegfH57UnQVIBu3QcHdHZgmaVS9x9SkBHoQmFCtJ5zWwXaNok1TuDN93/PWuZLLDWA5fHpIcKBqnSsC48fUkdOkrwXp8hhztS8wzOw95ROr3ENnsRLO08hj0XIo6M/L78MaQyFREsd0tibBT5IfUo6Rc98UKma1ETZyUGWPd6S3Ieky1N+B51w4+Oioc/yLldI5vTvQCd72XdmqoXBTTrzS9Udr9P6XpimPk6yL3yn0f++7yrLtntULu9x5/2AZ8B5oCcipK02BpkXpiiY15aUgrDtoinqarEhhkPx2Wb1oyv/Yjsrwg==;5:nR8g+e4swTV3enwrhbG586CXD/QKVmT4686MCStUPJo2bYjfILI/1B49GGDnO+owRdZ6LSQAVZVXooXnPRBBQlL7z/kkdYBN+b0qY4f+ckC7qU2eghFAxXRL6KhK5ZhcoDzRgEd8U+W31hs1rhj9aRPWP6XLkl/64jwEAGMvKIg=;7:10H/rMg39zC3ZrYQS4ABD6fx5/YBOj/UyBS2jJIRoI4xXjmQcFq7eqvmQosKHtBRJJEWWgDY4f3VehT510ngkl6kB9YZamKOVBHjNKGtC0u5aqkrZfhTMEdAuYU1LIVkHTgOoldrduX9btVM3B+I9Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(39850400004)(346002)(366004)(199004)(189003)(93886005)(39060400002)(36756003)(186003)(7736002)(305945005)(6636002)(2906002)(97736004)(229853002)(6862004)(316002)(86362001)(54906003)(256004)(37006003)(5660300001)(83716004)(14454004)(71190400001)(71200400001)(6512007)(76176011)(33656002)(4326008)(102836004)(53936002)(2616005)(8936002)(68736007)(81166006)(25786009)(99286004)(81156014)(6506007)(82746002)(6246003)(106356001)(105586002)(6116002)(486006)(6436002)(476003)(478600001)(446003)(11346002)(46003)(6486002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1496;H:CY4PR2201MB1254.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: c05d9856-0fff-4f5a-35b7-08d65591266e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1496;
x-ms-traffictypediagnostic: CY4PR2201MB1496:
x-microsoft-antispam-prvs: <CY4PR2201MB1496CE966BEFC36FDA115E7CDED20@CY4PR2201MB1496.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231443)(999002)(944501410)(52105112)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(2016111802025)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);SRVR:CY4PR2201MB1496;BCL:0;PCL:0;RULEID:;SRVR:CY4PR2201MB1496;
x-forefront-prvs: 0871917CDA
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: R8qSYuCmB4zvTKBlH2pM24Wt/evmA+wXIEte8yraY6wqijbbhOYI3+WrIdTF8gIloelSwBjYC9u7IPo1dd/eMsRBZJfOtrnoOAfKOksXnUYJStfshO+sfWyoK7ieTeP+N0SYd+K/asp2jT++FECdpFRbhscLZAcwlsaULqzN+3SXv8DXGkezSbVuMRIbGy4CBrGXPGc01PeO4GBwF2cbIwL2W40McA3+UGnQANbbV1GkHDHsBB9TbbWLuS4KLd4FcoQxHpnyactX4Hc/Jt5c3pE9kVP33YNOZ8Z+q76uMw+9Ubx1dKjtgrsBlG3VdJPc8UpTkdvQ2M7h2nGtLHW9g2endFxKc18QPWw7HCxs5R0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-ID: <8945DE2E05BA5F46952A8D7BFEBECF9E@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c05d9856-0fff-4f5a-35b7-08d65591266e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 00:25:22.0223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1496
Return-Path: <ysu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ysu@wavecomp.com
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

DQoNCj4g1NogMjAxOMTqMTHUwjI5yNWjrMnPzuczOjE0o6xQYXVsIEJ1cnRvbiA8cGJ1cnRvbkB3
YXZlY29tcC5jb20+INC0tcCjug0KPiANCj4gSGkgWXVucWlhbmcsDQo+IA0KPiBQbGVhc2Ugc2Vu
ZCBvbmx5IHBsYWluIHRleHQgbWFpbCB0byB0aGUgbGludXgtbWlwcyBtYWlsaW5nIGxpc3QsIGFu
ZA0KPiBkb24ndCB0b3AtcG9zdC4NCj4gDQo+IE9uIFdlZCwgTm92IDI4LCAyMDE4IGF0IDA4OjQy
OjA4QU0gLTA4MDAsIFl1bnFpYW5nIFN1IHdyb3RlOg0KPj4+INTaIDIwMTjE6jEx1MIxNcjVo6zP
ws7nMzo1M6OsSHVhY2FpIENoZW4gPGNoZW5oY0BsZW1vdGUuY29tPiDQtLXAo7oNCj4+PiANCj4+
PiBPbiB0aGUgTG9vbmdzb24tMkcvMkgvM0EvM0IgdGhlcmUgaXMgYSBoYXJkd2FyZSBmbGF3IHRo
YXQgbGwvc2MgYW5kDQo+Pj4gbGxkL3NjZCBpcyB2ZXJ5IHdlYWsgb3JkZXJpbmcuIFdlIHNob3Vs
ZCBhZGQgc3luYyBpbnN0cnVjdGlvbnMgYmVmb3JlDQo+Pj4gZWFjaCBsbC9sbGQgYW5kIGFmdGVy
IHRoZSBsYXN0IHNjL3NjZCB0byB3b3JrYXJvdW5kLiBPdGhlcndpc2UsIHRoaXMNCj4+PiBmbGF3
IHdpbGwgY2F1c2UgZGVhZGxvY2sgb2NjYXRpb25hbGx5IChlLmcuIHdoZW4gZG9pbmcgaGVhdnkg
bG9hZCB0ZXN0DQo+Pj4gd2l0aCBMVFApLg0KPj4+IA0KPj4+IFRoaXMgcGF0Y2ggaXMgbm90IGEg
bWluaW1hbCBjaGFuZ2UgKGl0IGlzIHZlcnkgZGlmZmljdWx0IHRvIG1ha2UgYQ0KPj4+IG1pbmlt
YWwgY2hhbmdlKSwgYnV0IGl0IGlzIGEgc2FmZXN0IGNoYW5nZS4NCj4+PiANCj4+PiBXaHkgZGlz
YWJsZSBmaXgtbG9vbmdzb24zLWxsc2MgaW4gY29tcGlsZXI/DQo+Pj4gQmVjYXVzZSBjb21waWxl
ciBmaXggd2lsbCBjYXVzZSBwcm9ibGVtcyBpbiBrZXJuZWwncyAuZml4dXAgc2VjdGlvbi4NCj4+
IA0KPj4gQFBhdWwgQnVydG9uIExvb25nc29uIDNBL0IgMzAwMCBoYXZlIGEgYnVnIG9mIGxsL3Nj
LCB3aGljaCBpcyBub3QgaW4gM0EvM0IgMTAwMA0KPj4gZXZlbi4NCj4gDQo+IERvIHlvdSBoYXZl
IGFueSBkZXRhaWxzPyBBcmUgeW91IHNheWluZyB0aGF0IHRoZSBwcm9ibGVtIEh1YWNhaSdzIHBh
dGNoDQo+IGFkZHJlc3NlcyBvbmx5IGFwcGxpZXMgdG8gdGhvc2UgbW9kZWxzLCBvciB0aGF0IHRo
ZXJlJ3MgYSBzZXBhcmF0ZQ0KPiBwcm9ibGVtPw0KDQpZZXMuIDMwMDAgaW50cm9kdWNlcyBzb21l
IG5ldyBidWdzLCB0aGlzIGlzIG9uZSBvZiB0aGVtLg0KMTAwMCBkb2VzbqGvdCBoYXZlIHRoaXMg
cHJvYmxlbS4NCg0KV2l0aG91dCB0aGlzIHBhdGNoLCAzQSAzMDAwIGlzIHF1aXRlIHVuc3RhYmxl
IHdoZW4gaGVhdnkgbG9hZCwgYXMgYW4gcGVyc29uYWwgZXhwZXJpZW5jZSwNCmJ1aWxkaW5nIGtl
cm5lbCwgd2l0aCAtajUgd29ya3Mgd2VsbCwgd2hpbGUgLWo5IGFsd2F5cyBtYWtlcyB0aGUgbWFj
aGluZSBoYW5ncy4NCg0KM0EgMTAwMCBoYXMgaXRzZWxmIGJ1Z3MsIG5vdCB0aGUgc2FtZSB3aXRo
IDNBIDMwMDAsIGFuZCBzb21lIG9mIDEwMDChr3MgYnVnIGlzIGZpeGVkIGluIDMwMDAuDQoNCj4g
DQo+IFRoYW5rcywNCj4gICAgUGF1bA0KDQo=
