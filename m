Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2018 12:09:29 +0100 (CET)
Received: from mail-ty1jpn01on0128.outbound.protection.outlook.com ([104.47.93.128]:36461
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992824AbeKGLJZj8g8E (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Nov 2018 12:09:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQk5RF6FblW9SXAzkArEiSjP1EfqpDzoRX2gF4zoxh0=;
 b=ffElWZZYKY3dob9CnFjcnMusf8b1ZCCfhzhN6v067slVhG3nd37T8RuyVqXAnhpTjdtjBf6iRNS5wYLUPfEJOWpjd3zG/qXJxOhCXwMTPQp982iIlscgD4M7vNZlCKFxIuKWoqd2SZKGEaTFZwCDIEfAJQo+n7KpT7PesWe3FAA=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.162.18) by
 TY1PR01MB1183.jpnprd01.prod.outlook.com (10.174.226.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Wed, 7 Nov 2018 11:09:18 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::b050:5108:7162:82a8]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::b050:5108:7162:82a8%4]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 11:09:18 +0000
From:   Chris Brandt <Chris.Brandt@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: RE: [renesas-drivers:topic/pinctrl-rza2-v2 1/2]
 drivers//pinctrl/pinctrl-rza2.c:25:43: error: 'RZA2_NPORTS' undeclared here
 (not in a function); did you mean 'RZA2_NPINS'?
Thread-Topic: [renesas-drivers:topic/pinctrl-rza2-v2 1/2]
 drivers//pinctrl/pinctrl-rza2.c:25:43: error: 'RZA2_NPORTS' undeclared here
 (not in a function); did you mean 'RZA2_NPINS'?
Thread-Index: AQHUdnrFCijrXpmRwEK19bXQqpsVGKVECccAgAACtgCAABlZsA==
Date:   Wed, 7 Nov 2018 11:09:18 +0000
Message-ID: <TY1PR01MB1562C57F509DF2B8876339EA8AC40@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <201811071730.l9oHq1qJ%fengguang.wu@intel.com>
 <CAMuHMdVO1kAVnsGFD6mc2Z-0RqT=w=mP4Et0iBRzhbBrF7CF3A@mail.gmail.com>
 <CAMuHMdWf1Lv_pd4EmL7ORwZ9oNZDuSV_kc8CZ+QMjAfDGA7TBg@mail.gmail.com>
In-Reply-To: <CAMuHMdWf1Lv_pd4EmL7ORwZ9oNZDuSV_kc8CZ+QMjAfDGA7TBg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1183;20:GUEBSRMwwtDX906njmAKHwn31CJMu/DfO4Zy3v0gMANevf15xCTj6ZB5mdjjKvTG6vlTTKq/QNt0s3OWmsW2750+JX7zsYQweH11OZN295FuFgeFUjDhZKJjmK6PlJmUvRQe6OtQ1wtQTd/Aa1Ll7qanOlcyYFtf1Il7p+cGCkQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1295baa1-9cc8-498e-a4c0-08d644a17660
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1183;
x-ms-traffictypediagnostic: TY1PR01MB1183:
x-microsoft-antispam-prvs: <TY1PR01MB1183B08DCAC02C9560F437858AC40@TY1PR01MB1183.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150)(275740015457677)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231382)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1183;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1183;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(136003)(346002)(199004)(189003)(52314003)(6306002)(71190400001)(99286004)(54906003)(71200400001)(2906002)(74316002)(7736002)(72206003)(4326008)(6246003)(53936002)(33656002)(966005)(8936002)(229853002)(316002)(186003)(2900100001)(478600001)(8676002)(486006)(3846002)(68736007)(86362001)(6506007)(6436002)(53546011)(575784001)(5024004)(256004)(6116002)(106356001)(14454004)(305945005)(55016002)(476003)(97736004)(5660300001)(25786009)(102836004)(66066001)(76176011)(9686003)(11346002)(7696005)(6916009)(81166006)(81156014)(26005)(446003)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1183;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1SGlLzkEcAn5JFy1I5qUi8JkEH3WyPTKEbc+NXjphrjkzbar11advTHccE0VGb9aGuvPwoe4hw377W/jjnnf6yWLMiZUbaJ/xyqYXSmP8G/p7bZUNG5BYupgzWLiVoPC1wS/BnTHBZ+1dXlTVJ5gb+xhZZQj9VOHBcphBsOdGmlQyH35WnlktBy5Ol9tg1hkrnEnOKpHeXKFc0qrdMa9BYEYrSUDpXXOdjnndrlZtxQVPtry+X/rpk/Ax/RGGWt2l2TNiF5kVHViFRtRjr1gaOD9+p8IMg7932Yow9285XkFK/IZE2v0FrgiMydeVchHioVFFSDrkHFmAmPzhVm5TMMQ22FDe/hbf1eWvMxfDrk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1295baa1-9cc8-498e-a4c0-08d644a17660
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 11:09:18.3120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1183
Return-Path: <Chris.Brandt@renesas.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67127
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Chris.Brandt@renesas.com
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

SGkgR2VlcnQsDQoNCj4gPiBHcmVhdCwgc28gTUlQUyBkZWZpbmVzIFBDLCBwcmVjbHVkaW5nIGl0
IHVzZSBpbiBhbnkgZHJpdmVyIHRoYXQgaW5jbHVkZXMNCj4gPiA8YXNtL3B0cmFjZS5oPiBpbiBz
b21lIHdheS4NCg0KVGhhdCByZWFsbHkgc3RpbmtzISEhDQoNCg0KPiBBbnl3YXksIGRyaXZlcnMv
L3BpbmN0cmwvcGluY3RybC1yemEyLmMgZG9lc24ndCByZWFsbHkgdXNlIHRoZSBlbnVtDQo+IHZh
bHVlcyBpdCBkZWZpbmVzLA0KPiBzbyB0aGV5IGNhbiBiZSByZW5hbWVkIChQQyAtPiBQT1JUQywg
b3IgUE9SVF9DKS4NCg0KT2YgY291cnNlIHRoYXQgbWVhbnMgSSBoYXZlIHRvIGdvIGJhY2sgYW5k
IGNoYW5nZSBldmVyeXRoaW5nIHRvIFBPUlR4Lg0KDQo6KA0KDQpEYW1uIHlvdSBNSVBTISEhISEN
Cg0KQ2hyaXMNCg0KDQpPbiBXZWRuZXNkYXksIE5vdmVtYmVyIDA3LCAyMDE4LCBHZWVydCBVeXR0
ZXJob2V2ZW4gd3JvdGU6DQo+IE9uIFdlZCwgTm92IDcsIDIwMTggYXQgMTA6MjIgQU0gR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gd3JvdGU6DQo+ID4gT24gV2Vk
LCBOb3YgNywgMjAxOCBhdCAxMDoxMiBBTSBrYnVpbGQgdGVzdCByb2JvdCA8bGtwQGludGVsLmNv
bT4gd3JvdGU6DQo+ID4gPiB0cmVlOiAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9s
aW51eC9rZXJuZWwvZ2l0L2dlZXJ0L3JlbmVzYXMtDQo+IGRyaXZlcnMuZ2l0IHRvcGljL3BpbmN0
cmwtcnphMi12Mg0KPiA+ID4gaGVhZDogICBiYjBmNDg4ZmIyOTA3ZjQ3MjUwZjdmMzRhZjYwYTQ4
MmZkM2RiZmU0DQo+ID4gPiBjb21taXQ6IGZlYWM5ZThjYjFhZDdiNDk3OWU0YjU1M2ZjZGYyZDg1
ODIwNDkyMjcgWzEvMl0gcGluY3RybDogQWRkDQo+IFJaL0EyIHBpbiBhbmQgZ3BpbyBjb250cm9s
bGVyDQo+ID4gPiBjb25maWc6IG1pcHMtYWxsbW9kY29uZmlnIChhdHRhY2hlZCBhcyAuY29uZmln
KQ0KPiA+ID4gY29tcGlsZXI6IG1pcHMtbGludXgtZ251LWdjYyAoRGViaWFuIDcuMi4wLTExKSA3
LjIuMA0KPiA+ID4gcmVwcm9kdWNlOg0KPiA+ID4gICAgICAgICB3Z2V0IGh0dHBzOi8vcmF3Lmdp
dGh1YnVzZXJjb250ZW50LmNvbS9pbnRlbC9sa3AtDQo+IHRlc3RzL21hc3Rlci9zYmluL21ha2Uu
Y3Jvc3MgLU8gfi9iaW4vbWFrZS5jcm9zcw0KPiA+ID4gICAgICAgICBjaG1vZCAreCB+L2Jpbi9t
YWtlLmNyb3NzDQo+ID4gPiAgICAgICAgIGdpdCBjaGVja291dCBmZWFjOWU4Y2IxYWQ3YjQ5Nzll
NGI1NTNmY2RmMmQ4NTgyMDQ5MjI3DQo+ID4gPiAgICAgICAgICMgc2F2ZSB0aGUgYXR0YWNoZWQg
LmNvbmZpZyB0byBsaW51eCBidWlsZCB0cmVlDQo+ID4gPiAgICAgICAgIEdDQ19WRVJTSU9OPTcu
Mi4wIG1ha2UuY3Jvc3MgQVJDSD1taXBzDQo+ID4gPg0KPiA+ID4gQWxsIGVycm9yL3dhcm5pbmdz
IChuZXcgb25lcyBwcmVmaXhlZCBieSA+Pik6DQo+ID4gPg0KPiA+ID4gICAgSW4gZmlsZSBpbmNs
dWRlZCBmcm9tIGFyY2gvbWlwcy9pbmNsdWRlL2FzbS9wdHJhY2UuaDoxOTowLA0KPiA+ID4gICAg
ICAgICAgICAgICAgICAgICBmcm9tIGluY2x1ZGUvbGludXgvaXJxLmg6MjQsDQo+ID4gPiAgICAg
ICAgICAgICAgICAgICAgIGZyb20gaW5jbHVkZS9saW51eC9ncGlvL2RyaXZlci5oOjcsDQo+ID4g
PiAgICAgICAgICAgICAgICAgICAgIGZyb20gaW5jbHVkZS9hc20tZ2VuZXJpYy9ncGlvLmg6MTMs
DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgIGZyb20gaW5jbHVkZS9saW51eC9ncGlvLmg6NjIs
DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgIGZyb20gZHJpdmVycy8vcGluY3RybC9waW5jdHJs
LXJ6YTIuYzoxNDoNCj4gPiA+ID4+IGFyY2gvbWlwcy9pbmNsdWRlL3VhcGkvYXNtL3B0cmFjZS5o
OjE3OjEzOiBlcnJvcjogZXhwZWN0ZWQNCj4gaWRlbnRpZmllciBiZWZvcmUgbnVtZXJpYyBjb25z
dGFudA0KPiA+ID4gICAgICNkZWZpbmUgUEMgIDY0DQo+ID4gPiAgICAgICAgICAgICAgICAgXg0K
PiA+DQo+ID4gR3JlYXQsIHNvIE1JUFMgZGVmaW5lcyBQQywgcHJlY2x1ZGluZyBpdCB1c2UgaW4g
YW55IGRyaXZlciB0aGF0IGluY2x1ZGVzDQo+ID4gPGFzbS9wdHJhY2UuaD4gaW4gc29tZSB3YXku
DQo+ID4NCj4gPiBIb3dldmVyLCBpdCBsb29rcyBsaWtlIDxsaW51eC9ncGlvL2RyaXZlci5oPiBk
b2Vzbid0IHJlYWxseSBuZWVkDQo+IDxsaW51eC9pcnEuaD4uDQo+ID4gV2lsbCBzZW5kIGEgcGF0
Y2ggdG8gdHJ5IHRoYXQuLi4NCj4gDQo+IERvZXNuJ3Qgd29yaywgYXMgaXQgYWxzbyBpbmNsdWRl
cyA8aXJxY2hpcC9jaGFpbmVkX2lycS5oPiwgd2hpY2ggaXMgbmVlZGVkLg0KPiANCj4gQW55d2F5
LCBkcml2ZXJzLy9waW5jdHJsL3BpbmN0cmwtcnphMi5jIGRvZXNuJ3QgcmVhbGx5IHVzZSB0aGUg
ZW51bQ0KPiB2YWx1ZXMgaXQgZGVmaW5lcywNCj4gc28gdGhleSBjYW4gYmUgcmVuYW1lZCAoUEMg
LT4gUE9SVEMsIG9yIFBPUlRfQykuDQo+IA0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2
ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LQ0K
PiBtNjhrLm9yZw0KPiANCj4gSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNh
bCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuDQo+IEJ1dA0KPiB3aGVuIEknbSB0YWxr
aW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBs
aWtlDQo+IHRoYXQuDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMg
VG9ydmFsZHMNCg==
