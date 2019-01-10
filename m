Return-Path: <SRS0=2fGM=PS=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2712C43387
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 18:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6937F206B7
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 18:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="lCdUlXev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfAJSpg (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:45:36 -0500
Received: from mail-eopbgr800113.outbound.protection.outlook.com ([40.107.80.113]:6240
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728005AbfAJSpf (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 10 Jan 2019 13:45:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jqkflf/VZDrr+3nQ4Of6W8Yqje6Ui3asm3drdwo7kEc=;
 b=lCdUlXevRjonWMWUFOFWkVhoradTm9FIFUUC0uijP3H4KAoXaZWgpAoUlj1Xd7IV9lDw+uhtvz7CGgUVFn93dGgWj3XY4rXoRx8/JPynIZlFFHlGdjvPDSw3t+4NN/GQfTj8ZiF35elVGI2KJtGz1oKFfF+IZrOQUI8JopOMrZc=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1167.namprd22.prod.outlook.com (10.174.168.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Thu, 10 Jan 2019 18:45:31 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110%4]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 18:45:31 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Yunqiang Su <ysu@wavecomp.com>
CC:     Paul Burton <pburton@wavecomp.com>, YunQiang Su <syq@debian.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>
Subject: Re: [PATCH v2] Disable MSI also when pcie-octeon.pcie_disable on
Thread-Topic: [PATCH v2] Disable MSI also when pcie-octeon.pcie_disable on
Thread-Index: AQHUpxVYS+YSucY4hEqdri6AUUk7laWo1ViAgAAC74CAAALgAA==
Date:   Thu, 10 Jan 2019 18:45:31 +0000
Message-ID: <20190110184530.7odyys2qyrmfcjkk@pburton-laptop>
References: <20190108054510.7393-1-syq@debian.org>
 <20190110182443.dic3trktlnn23ynn@pburton-laptop>
 <D0125B24-7506-48D0-B2A8-D1D1AC75ECC1@wavecomp.com>
In-Reply-To: <D0125B24-7506-48D0-B2A8-D1D1AC75ECC1@wavecomp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::38) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1167;6:sdmDic5omWiQCs1Cxn6vaalR5usJjnbLbl4BOt91soAcx0lgA8tRX2waM0awJ8x9EH3I6D+eVLYzfPJMvhG7TC3Pvl8CedtvHqMl/cmxpbPFNWul65+GpIb0/IFoCNdjIA+HL17tXaHaMCJdXb33jkX9S462ya0Umbg4vB2PLezW2J2/ZEhFiB3d4UqWNFqkgtIphr46VXcZcCFp1msgoUGjjOmG2wQ4PeqQMeFnSPJMXEZpUKjBqK+iKcAYzmvAQFPPVIjNbNZIF3WL3LBXiqO3/Lxe+XgqyeOF39pqLpPYqeO/ub4Z8PjBvOQK0HHkyu6tFGbfV1mGOK4uWlrXqmJ7fqE7zMpoR/fU2tBPR7DNdwBNlk5RbqXce1WLZcMISsgAhKddv+AR71x5agNEbAH/5QQeCLYfXCDvcsUL6CPA181DMJ6jXmCXRV5NgLd1FvJkcJI30xAHIqC02YNHQA==;5:DHFmrzz59C+lQIvyBdwknCOnEgsBBUPlFdvsn95INZPyHkeWqRSEkkIJ9tx8El+778RmXhhwxKlr4ehfyF8H6AzKRVGOjWnqmNFmyYNrs5IDCt2q2U/vc1bb5IDMOejVoXOh0CI09sCu6kDqThnBsFRjaSCz03+aLeckMc4tbmcaQw9HYZKOo7tBYkh4ymHTWVyNE7nkufDt644kQe3KYw==;7:BIlgotBuVWcOBkK5iKcVvP6ZHxc74CouJL5qDKC+4K/W8hz/SVzr1Ns/zeqwX9QrIr3lQTYFe4O+FrY02dkUogW2Ki6R+AarCyyb0lyAHC8aWCIq+O1k6A9YeTiKW1unxO9z8IYjRMkthtzFV4cTZw==
x-ms-office365-filtering-correlation-id: 51492f00-b2fd-4a7c-6d28-08d6772bcc2c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1167;
x-ms-traffictypediagnostic: MWHPR2201MB1167:
x-microsoft-antispam-prvs: <MWHPR2201MB1167DAEE3DE10A6712A8B5ECC1840@MWHPR2201MB1167.namprd22.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(7916004)(366004)(376002)(346002)(39840400004)(396003)(136003)(189003)(199004)(52116002)(14454004)(42882007)(66066001)(102836004)(6506007)(386003)(8936002)(76176011)(33896004)(26005)(186003)(54906003)(1076003)(58126008)(81156014)(81166006)(5660300001)(316002)(8676002)(229853002)(6486002)(6436002)(478600001)(256004)(14444005)(105586002)(6512007)(486006)(305945005)(44832011)(97736004)(7736002)(68736007)(4326008)(6862004)(476003)(3846002)(2906002)(446003)(106356001)(6246003)(71200400001)(33716001)(25786009)(71190400001)(11346002)(9686003)(99286004)(53936002)(6116002)(567974002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1167;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3Q36ME+ef3xHFa2Fw38S8z5ElehPqb0MgzmP98HYNBKXknerWer43ZVoYmDoa3G23i8nQViBzwzuU/PHnbS82zG9Ic1SmcZmMTLBx1XWs/zqMFdEAC3LkJyZrrfpQcjPUfZ/+1yM1QvgW1JxXEj47lyqN0RettkLTf1GwBVKSRTroT9C27UcD486pEdjGfnMTVWwNsosahKQDlqloItF7HpL1zJyaA47hDqLDm39eyEVMn8MTZk1goUjtyT8PmY5GMR+fNhD9xVXvVNEgZJnjamA0Kh61hiMTo8viyBA3VXV+YjqTiV9ucctYU83vePC
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3DA698530D67C419B7E3D1F8A932261@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51492f00-b2fd-4a7c-6d28-08d6772bcc2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 18:45:31.4528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1167
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

SGkgWXVucWlhbmcsDQoNCk9uIFRodSwgSmFuIDEwLCAyMDE5IGF0IDEwOjM1OjEzQU0gLTA4MDAs
IFl1bnFpYW5nIFN1IHdyb3RlOg0KPiA+IOWcqCAyMDE55bm0MeaciDEx5pel77yM5LiK5Y2IMjoy
NO+8jFBhdWwgQnVydG9uIDxwYnVydG9uQHdhdmVjb21wLmNvbT4g5YaZ6YGT77yaDQo+ID4gSGkg
WXVuUWlhbmcsDQo+ID4gDQo+ID4gT24gVHVlLCBKYW4gMDgsIDIwMTkgYXQgMDE6NDU6MTBQTSAr
MDgwMCwgWXVuUWlhbmcgU3Ugd3JvdGU6DQo+ID4+IEZyb206IFl1blFpYW5nIFN1IDx5c3VAd2F2
ZWNvbXAuY29tPg0KPiA+PiANCj4gPj4gT2N0ZW9uIGhhcyBhbiBib290LXRpbWUgb3B0aW9uIHRv
IGRpc2FibGUgcGNpZS4NCj4gPj4gDQo+ID4+IFNpbmNlIE1TSSBkZXBlbmRzIG9uIFBDSS1FLCB3
ZSBzaG91bGQgYWxzbyBkaXNhYmxlIE1TSSBhbHNvIHdpdGgNCj4gPj4gdGhpcyBvcHRpb25zIGlz
IG9uLg0KPiA+IA0KPiA+IERvZXMgdGhpcyBmaXggYSBidWcgeW91J3JlIHNlZWluZz8gT3IgaXMg
aXQganVzdCBpbnRlbmRlZCB0byBhdm9pZA0KPiA+IHJlZHVuZGFudCB3b3JrPw0KPiANCj4gSSBo
YXZlIG5vIGlkZWEgd2hldGhlciB0aGlzIGlzIGEgYnVnIG9yIG5ldyBmZWF0aGVycy4NCj4gSSBn
ZXQgYW4gQ2F2aXVtIG1hY2hpbmUsIHdoaWNoIGhhcyBubyBQQ0kgYXQgYWxsLCBhbmQgc28gSSBo
YXZlIHRvIGRpc2FibGUgdGhlIFBDSSB0b3RhbGx5Lg0KPiANCj4gRm9yIG1lIHRoZXJlIGFyZSAy
IHdheXM6IGRpc2FibGUgb24gYnVpbGQtdGltZSBvciBkaXNhYmxlIG9uIHJ1bnRpbWUuDQo+IFNp
bmNlIERlYmlhbiBwcmVmZXIgdG8gdXNlIGEgc2luZ2xlIGtlcm5lbCBpbWFnZS4NCj4gU28gSSBu
ZWVkIHRvIGRpc2FibGUgaXQgb24gcnVudGltZS4NCg0KTGV0IG1lIHBocmFzZSB0aGlzIGFub3Ro
ZXIgd2F5IC0gaWYgeW91IGJvb3Qgd2l0aCBQQ0llIGRpc2FibGVkLCBidXQNCndpdGhvdXQgeW91
ciBwYXRjaCBhcHBsaWVkLCB3aGF0IGhhcHBlbnM/IERvZXMgdGhlIHN5c3RlbSB3b3JrIG9yIGRv
ZXMNCml0IGJyZWFrPw0KDQpZb3UgbXVzdCBoYXZlIHdyaXR0ZW4gdGhlIHBhdGNoIGZvciBhIHJl
YXNvbiwgSSBqdXN0IHdhbnQgdG8ga25vdyB3aGF0DQp0aGF0IHJlYXNvbiBpcy4NCg0KPiA+IElm
IGl0IGZpeGVzIGEgYnVnIHRoZW4gSSdsbCBhcHBseSBpdCB0byBtaXBzLWZpeGVzICYgY29weSBz
dGFibGUsDQo+ID4gb3RoZXJ3aXNlIEknbGwgYXBwbHkgaXQgdG8gbWlwcy1uZXh0ICYgbm90IGNv
cHkgc3RhYmxlLg0KPiANCj4gSSBwcmVmZXIgaXQgdG8gYmUgYmFja3BvcnRlZC4NCg0KT25seSBp
ZiBpdCBmaXhlcyBhIGJ1Zy4NCg0KVGhhbmtzLA0KICAgIFBhdWwNCg==
