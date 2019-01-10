Return-Path: <SRS0=2fGM=PS=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65E2C43387
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 01:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9015B20663
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 01:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="UYa63obr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfAJB7P (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 9 Jan 2019 20:59:15 -0500
Received: from mail-eopbgr680111.outbound.protection.outlook.com ([40.107.68.111]:64544
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726458AbfAJB7P (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Wed, 9 Jan 2019 20:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtHj2ER+I05sb6QczYUrvhMCaf3iCTO9kDiUfwjV84w=;
 b=UYa63obrsMvONA+SauSZzy5SVZc6IonxeiAyXwqZYCXeLoGkuGF21iu0oUFNydcO2xQQ1V56S8lsfDDYo58UPK7SX6H2UfsIz9o0b4+DHyLkb+0cM2yjc172RSfvPWyVmM0V/aNJOOHpfVTeEPE5BSFyhQV8TG5S4whZtFaNUTU=
Received: from MWHPR2201MB1261.namprd22.prod.outlook.com (10.174.162.13) by
 MWHPR2201MB1744.namprd22.prod.outlook.com (10.164.206.162) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Thu, 10 Jan 2019 01:59:09 +0000
Received: from MWHPR2201MB1261.namprd22.prod.outlook.com
 ([fe80::68d4:cfd:fb76:4ba0]) by MWHPR2201MB1261.namprd22.prod.outlook.com
 ([fe80::68d4:cfd:fb76:4ba0%6]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 01:59:08 +0000
From:   Yunqiang Su <ysu@wavecomp.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     YunQiang Su <syq@debian.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "chehc@lemote.com" <chehc@lemote.com>,
        "zhangfx@lemote.com" <zhangfx@lemote.com>,
        "wuzhangjin@gmail.com" <wuzhangjin@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "paul.hua.gm@gmail.com" <paul.hua.gm@gmail.com>
Subject: Re: [PATCH 1/2] MIPS: Loongson, add sync before target of branch
 between llsc
Thread-Topic: [PATCH 1/2] MIPS: Loongson, add sync before target of branch
 between llsc
Thread-Index: AQHUpQeBO1EnxrgIuU2pvOIUsWAth6WnhbgAgABAWwA=
Date:   Thu, 10 Jan 2019 01:59:07 +0000
Message-ID: <723B8029-77BE-4DF8-A9FB-74E59F8AA6F8@wavecomp.com>
References: <20190105150037.30261-1-syq@debian.org>
 <20190109220844.qk5ufkzjmfwxe5aq@pburton-laptop>
In-Reply-To: <20190109220844.qk5ufkzjmfwxe5aq@pburton-laptop>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ysu@wavecomp.com; 
x-originating-ip: [47.74.12.188]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1744;6:89SwMib+Y0t4oIzFN9PWjoIeWZBHIP0sVu6h4OwbP00+zbt+xf0JTWCi28ywnO7UTe0RH9vSy3g1Il0dgzsZD9WDVidfxFcGyK8AOSypBKt5wAQExdcsnuDik6AwrMkxuyBmjfpuMS8TxkpJEyb8uCXt/UbqPF4vKz8vbGOkrv28vjDa7wPWSS8MdU/bv2PeGeqB++0LUU+JPKDTxOQXB7PRZso6pCFk5VCcWOZBEXWl1mKPAEZR2k9kShzX/yFPhVOJkPrPIaOevL8GHL2vWmjsTbf+b2RkSbVNbI0k+G7qqQL46/Qolojq4EFtgazr/mFLhcltSP0URcuk7LcIGm1MFWwD80vG5iW13pbVaciytBNrkTs4idXLQ5LIwYz/HLd2+cCUfs+dFpZqSACYDGOSjM2+4QSRm8RbaQFn+GWNsU85/8b6otSxKlBDzmK3cQwnTWe9rDhdDlTk+vvtyw==;5:ipjrCX9atTwrrZrv/mnpxNrKk+2MOcKcBo8oUkUdWSwy4QT9PtytsRUlvC28R/QI4iMpjMloZ6v60JT198hhnN9RzjKJdePXJS1RftLp5AfTkI4JQR7MTS/+GvyDDvtZ8gk1/GhK6Nz3GF5C+06YbFHQZP9jfFBYmzyI6Cxsh4c0MQ+CnBVjKe6jZn+td5IBeQqqIq5t3IdSgdR2oqQNrg==;7:NbdK50R9rxDd21cjO5fFJoLyLdtFcTGjW8dQjXxr8mGCiFFBpnfa2pp2XlatLYJrJzZgigD1BIqI0cnfM9ejlxRigUYuFsX9lm8oQRantGoEOJToSb00ePGp5d2V56Jde0jpUFdIJ1PgL3a7UQIlFA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(346002)(39840400004)(396003)(199004)(189003)(6436002)(5660300001)(25786009)(6246003)(39060400002)(2906002)(6862004)(83716004)(486006)(2616005)(476003)(11346002)(71200400001)(446003)(7736002)(71190400001)(36756003)(6116002)(33656002)(229853002)(567974002)(966005)(14454004)(6486002)(3846002)(478600001)(6636002)(86362001)(6512007)(105586002)(82746002)(66066001)(4326008)(53936002)(6306002)(106356001)(186003)(97736004)(316002)(99286004)(37006003)(256004)(8936002)(68736007)(8676002)(81166006)(26005)(102836004)(6506007)(81156014)(305945005)(76176011)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1744;H:MWHPR2201MB1261.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 9aef09fd-f096-47a9-888d-08d6769f3526
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1744;
x-ms-traffictypediagnostic: MWHPR2201MB1744:
x-microsoft-antispam-prvs: <MWHPR2201MB174496DCB3F0420D55C6DBF1DE840@MWHPR2201MB1744.namprd22.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZBJcQ3YH3ZEnqYEUL4gcvrse/WUsMwKrCXfKyisrvoiddTqZ1GJn9EUoKMAUQ3xtHSsH7VTELHFSDNkEXknSGqLoCbK8ATCtbwq0zyNH4du3BVLO9Ge8hQ4zDXvfImWz3htSFRq3sHUqnDgEJHtwfbe4UbL2ygwR/spdmivMxFBamb7BNK1gEinytP5xOcfTSYF05H6t8Vo2RK8eDYwZt41pa2MLFu80ByIWBc1jHKeddVqwycA0Xdpgvesqbtj3Gjg4q1aeb7/tyirAeGKzSt2C/4gSK+gpg8S9i1Pg/m+AlrjoKSbr3GH5HI+wscYn
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-ID: <C3EE595FF258574CACB8E42E7B023EE1@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aef09fd-f096-47a9-888d-08d6769f3526
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 01:59:07.8835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1744
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

DQoNCj4g1NogMjAxOcTqMdTCMTDI1aOsyc/O5zY6MDijrFBhdWwgQnVydG9uIDxwYnVydG9uQHdh
dmVjb21wLmNvbT4g0LS1wKO6DQo+IA0KPiBIaSBZdW5RaWFuZywNCj4gDQo+IE9uIFNhdCwgSmFu
IDA1LCAyMDE5IGF0IDExOjAwOjM2UE0gKzA4MDAsIFl1blFpYW5nIFN1IHdyb3RlOg0KPj4gTG9v
bmdzb24gMkcvMkgvM0EvM0IgaXMgcXVpdGUgd2VhayBzeW5jJ2VkLiBJZiB0aGVyZSBpcyBhIGJy
YW5jaCwNCj4+IGFuZCB0aGUgdGFyZ2V0IGlzIG5vdCBpbiB0aGUgc2NvcGUgb2YgbGwvc2Mgb3Ig
bGxkL3NjZCwgYSBzeW5jIGlzDQo+PiBuZWVkZWQgYXQgdGhlIHBvc3Rpb24gb2YgdGFyZ2V0Lg0K
PiANCj4gT0ssIHNvIGlzIHRoaXMgdGhlIHNhbWUgaXNzdWUgdGhhdCB0aGUgc2Vjb25kIHBhdGNo
IGluIHRoZSBzZXJpZXMgaXMNCj4gd29ya2luZyBhcm91bmQgb3IgYSBkaWZmZXJlbnQgb25lPw0K
PiANCj4gSSdtIHByZXR0eSBjb25mdXNlZCBhdCB0aGlzIHBvaW50IGFib3V0IHdoYXQgdGhlIGFj
dHVhbCBidWdzIGFyZSBpbg0KPiB0aGVzZSB2YXJpb3VzIExvb25nc29uIENQVXMuIENvdWxkIHNv
bWVvbmUgcHJvdmlkZSBhbiBhY3R1YWwgZXJyYXRhDQo+IHdyaXRldXAgZGVzY3JpYmluZyB0aGUg
YnVncyBpbiBkZXRhaWw/DQo+IA0KPiBXaGF0IGRvZXMgImluIHRoZSBzY29wZSBvZiBsbC9zYyIg
bWVhbj8NCj4gDQoNCkxvb25nc29uIDMgc2VyaWVzIGhhcyBzb21lIHZlcnNpb24sIGNhbGxlZCwg
MTAwMCwgMjAwMCwgYW5kIDMwMDAuDQoNClRoZXJlIGFyZSAyIGJ1Z3MgYWxsIGFib3V0IExML1ND
LiBMZXShr3MgY2FsbCB0aGVtIGJ1Zy0xIGFuZCBidWctMi4NCg0KQlVHLTE6ICBhIGBzeW5joa8g
aXMgbmVlZGVkIGJlZm9yZSBMTCBvciBMTEQgaW5zdHJ1Y3Rpb24uDQogICAgICAgICAgICAgIFRo
aXMgYnVnIGFwcGVhcnMgb24gMTAwMCBvbmx5LCBhbmQgSSBhbSBzdXJlIHRoYXQgaXQgaGFzIGJl
ZW4gZml4ZWQgaW4gMzAwMC4NCg0KQlVHLTI6IGlmIHRoZXJlIGlzIGFuIGJyYW5jaCBpbnN0cnVj
dGlvbiBpbnNpZGUgTEwvU0MsIGFuZCB0aGUgYnJhbmNoIHRhcmdldCBpcyBvdXRzaWRlDQogICAg
ICAgICAgICAgb2YgdGhlIHNjb3BlIG9mIExML1NDLCBhIGBzeW5joa8gaXMgbmVlZGVkIGF0IHRo
ZSBicmFuY2ggdGFyZ2V0Lg0KICAgICAgICAgICAgIEFrYSwgdGhlIGZpcnN0IGluc24gb2YgdGhl
IHRhcmdldCBicmFuY2ggc2hvdWxkIGJlIGBzeW5joa8uDQogICAgICAgICAgICAgTG9vbmdzb24g
c2FpZCB0aGF0LCB3ZSBkb26hr3QgcGxhbiBmaXggdGhpcyBwcm9ibGVtIGluIHNob3J0IHRpbWUg
YmVmb3JlIHRoZXkNCiAgICAgICAgICAgICBEZXNpZ25lIGEgdG90YWxseSBuZXcgY29yZS4NCiAg
ICAgICAgICAgICAgDQoNCj4gV2hhdCBoYXBwZW5zIGlmIGEgYnJhbmNoIHRhcmdldCBpcyBub3Qg
ImluIHRoZSBzY29wZSBvZiBsbC9zY6GxPw0KDQpBdCBsZWFzdCB0aGV5IHNhaWQgdGhhdCB0aGVy
ZSB3b26hr3QgYmUgYSBwcm9ibGVtDQoNCj4gSG93IGRvZXMgdGhlIHN5bmMgaGVscD8NCj4gDQo+
IEFyZSBqdW1wcyBhZmZlY3RlZCwgb3IganVzdCBicmFuY2hlcz8NCg0KSSBhbSBub3Qgc3VyZSwg
c28gQ0MgYSBMb29uZ3NvbiBwZW9wbGUuDQpAUGF1bCBIdWENCg0KPiANCj4gRG9lcyB0aGlzIGFm
ZmVjdCB1c2VybGFuZCBhcyB3ZWxsIGFzIHRoZSBrZXJuZWw/DQo+IA0KDQpUaGVyZSBpcyBmZXcg
cGxhY2UgY2FuIHRyaWdnZXIgdGhlc2UgMiBidWdzIGluIGtlcm5lbC4NCkluIHVzZXIgbGFuZCB3
ZSBoYXZlIHRvIHdvcmthcm91bmQgaW4gYmludXRpbHM6ICANCiAgIGh0dHBzOi8vd3d3LnNvdXJj
ZXdhcmUub3JnL21sL2JpbnV0aWxzLzIwMTktMDEvbXNnMDAwMjUuaHRtbA0KDQpJbiBmYWN0IHRo
ZSBrZXJuZWwgaXMgdGhlIGVhc2llc3Qgc2luY2Ugd2UgY2FuIGhhdmUgYSBmbGF2b3IgYnVpbGQg
Zm9yIExvb25nc29uLg0KDQo+IC4uLmFuZCBwcm9iYWJseSBtb3JlIHF1ZXN0aW9ucyBkZXBlbmRp
bmcgdXBvbiB0aGUgYW5zd2VycyB0byB0aGVzZSBvbmVzLg0KPiANCj4+IExvb25nc29uIGRvZXNu
J3QgcGxhbiB0byBmaXggdGhpcyBwcm9ibGVtIGluIGZ1dHVyZSwgc28gd2UgYWRkIHRoZQ0KPj4g
c3luYyBoZXJlIGZvciBhbnkgY29uZGl0aW9uLg0KPiANCj4gU28gYXJlIHlvdSBzYXlpbmcgdGhh
dCBmdXR1cmUgTG9vbmdzb24gQ1BVcyB3aWxsIGFsbCBiZSBidWdneSB0b28sIGFuZA0KPiBzb21l
b25lIHRoZXJlIGhhcyBzYWlkIHRoYXQgdGhleSBjb25zaWRlciB0aGlzIHRvIGJlIE9LLi4/IEkg
cmVhbGx5DQo+IHJlYWxseSBob3BlIHRoYXQgaXMgbm90IHRydWUuDQo+IA0KDQpCdWcgaXMgYnVn
LiBJdCBpcyBub3QgT0suDQpJIGJsYW1lIHRoZXNlIExvb25nc29uIGd1eXMgaGVyZS4NClNvbWUg
TG9vbmdzb24gZ3V5cyBpcyBub3Qgc28gbm9ybWFsIHBlb3BsZS4NCkFueXdheSB0aGV5IGFyZSBh
IGxpdHRsZSBtb3JlIG5vcm1hbCBub3csIGFuZCBhbnl3YXkgYWdhaW4sIHN0aWxsIGFibm9ybWFs
Lg0KDQo+IElmIGhhcmR3YXJlIHBlb3BsZSBzYXkgdGhleSdyZSBub3QgZ29pbmcgdG8gZml4IHRo
ZWlyIGJ1Z3MgdGhlbiB3b3JraW5nDQo+IGFyb3VuZCB0aGVtIGlzIGRlZmluaXRlbHkgbm90IGdv
aW5nIHRvIGJlIGEgcHJpb3JpdHkuIEl0J3Mgb25lIHRoaW5nIGlmDQo+IGEgQ1BVIGRlc2lnbmVy
IHNheXMgIm9vcHMsIG15IGJhZCwgd29yayBhcm91bmQgdGhpcyAmIEknbGwgZml4IGl0IG5leHQN
Cj4gdGltZSIuIEl0J3MgcXVpdGUgYW5vdGhlciBmb3IgdGhlbSB0byBzYXkgdGhleSdyZSBub3Qg
aW50ZXJlc3RlZCBpbg0KPiBmaXhpbmcgdGhlaXIgYnVncyBhdCBhbGwuDQoNClRoZXkgaGF2ZSBp
bnRlcmVzdHMsIHdoaWxlIEkgZ3Vlc3MgdGhlIHRydWUgcmVhc29uIGlzIHRoYXQgdGhleSBoYXZl
IG5vIGVub3VnaA0KcGVvcGxlIGFuZCBtb25leSB0byBkZXNnaW4gYSBjb3JlLCB3aGlsZSB0aGlz
IGJ1ZyBpcyBxdWlsdCBoYXJkIHRvIGZpeC4NCg0KPiANCj4gVGhhbmtzLA0KPiAgICBQYXVsDQoN
Cg==
