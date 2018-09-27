Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Sep 2018 20:16:21 +0200 (CEST)
Received: from mail-sn1nam02on0112.outbound.protection.outlook.com ([104.47.36.112]:58000
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992501AbeI0SQSuh2SS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Sep 2018 20:16:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPvzFSbwGCGl1VJPngx2cvKaiSFm3CstEMwV6zpQa+M=;
 b=b60OhXTm3Hlj7ZIdI2AApT5D2SiawrRcSpsHmRrO5O8tEwRK3Uua/JcUABONtBWtAiPUW01RCI+Y+JBK9JGdFdQwW39tLiAwaOZAEJLKrsndG7qXrw5ApUOnfsown4odz3Bo8IN5opberXYye3tDZeh3MlRe9XdNkoPuI8/iFh4=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1710.namprd22.prod.outlook.com (10.164.206.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Thu, 27 Sep 2018 18:16:07 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::1886:62b2:fbe4:9627]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::1886:62b2:fbe4:9627%9]) with mapi id 15.20.1164.024; Thu, 27 Sep 2018
 18:16:07 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
CC:     Huacai Chen <chenhuacai@gmail.com>,
        linux-mips <linux-mips@linux-mips.org>,
        stable <stable@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>
Subject: Re: [PATCH] MIPS: VDSO: Always map near top of user memory
Thread-Topic: [PATCH] MIPS: VDSO: Always map near top of user memory
Thread-Index: AQHUVo4oFdgskwzc3kCgvnsq+/h4VQ==
Date:   Thu, 27 Sep 2018 18:16:07 +0000
Message-ID: <20180927181604.4kczgxeaot7utnuh@pburton-laptop>
References: <1536990690-17778-1-git-send-email-chenhc@lemote.com>
 <20180925232221.28953-1-paul.burton@mips.com>
 <tencent_7D95F91F120F9BCE2DCAC958@qq.com>
In-Reply-To: <tencent_7D95F91F120F9BCE2DCAC958@qq.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR14CA0025.namprd14.prod.outlook.com
 (2603:10b6:903:101::11) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1710;6:IkZMVHIM8qFnRFSFy1pA+HB8YX9W3bkBOZRurbOAaJL/yV2JbY8M/wguGmEnz8IcKqTqZxZxyxBnLJV0PnxiqFk5LU8tiTNl6509bJQKY3nU1smLTONh0Og2vyn28cdT9zhS+A9wW785rbXpEc7gNwJac88nlQIs2ZkBNkWNb7sgTvlwbdRg3x9CQj4dMiHobCGm5DfX4IZ81V4V42pKCW/oxFBdpKsR0Jv9TLjYJnPc4V/tONHy/N5oxwIvIF21QzGJMWpS/XxfHChkMw3PTzy0eTAgbmQNOFCikgVRQlX46nOwnEAFoSbY5uNYT1/P7Gv5zcQQOIBiMSkUgGTmGmsEF4YYZ6ZP7ZzURN6vunCZwCHMYhTXFzZfg6HBgpGUKyNd1ZWV8J57cXIqjjrDq3L3VoSzIZZ9mIGuvA4xjKxUqno06LrMOskQxXYrChr/vWV0PXo624gRViZnln26WQ==;5:JUSCsLpbf/xOszaWfuhtOyoKf+Wfw74baBTducvsn+VV71BN0rZQKmD6b+tA674TaVTWkf0PVeTkS+C3WuuHnVoESHgHEZK17OpLtQ08PlMtKRXQiHpjWv2004LT6lshmzfh7t6E2cNlHj+q87+XRojaTSlsfK0gxlWBnT8Y14g=;7:vSdqc1h5cVXWlvMWJQZjUoudYoWSO0PJYnbEc2wWww416nHzbYGwrEX6UtfMoyYn7BYBXQ2F9KJcuMMNICMyyIKv9WMOKiU9coA8iYOeG4xUPitoPC0DV65oydF6QvHHMjRUlUp235WSuQ6z87pxHZxMLIJLUvkonMMANn1tnLytVFDcW5yie5tOPq5wU+rObpv+AnIiCWsZ4bZXKkiJ5jOdySPbjnGKzrt5epG2yhGOgniFy9hJ7NuW7Tl8Mnxy
x-ms-office365-filtering-correlation-id: d13132df-0276-4ae5-8545-08d624a54b17
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989299)(5600074)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1710;
x-ms-traffictypediagnostic: MWHPR2201MB1710:
x-microsoft-antispam-prvs: <MWHPR2201MB1710E6F3AB867AC3FCF42BEFC1140@MWHPR2201MB1710.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(3231355)(944501410)(52105095)(10201501046)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123560045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699051);SRVR:MWHPR2201MB1710;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1710;
x-forefront-prvs: 0808323E97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(346002)(366004)(376002)(396003)(39840400004)(52314003)(189003)(199004)(81166006)(81156014)(8676002)(42882007)(5660300001)(26005)(25786009)(54906003)(5250100002)(53936002)(6246003)(107886003)(39060400002)(4326008)(186003)(316002)(34290500001)(58126008)(575784001)(229853002)(33716001)(68736007)(102836004)(14444005)(6486002)(256004)(6506007)(66066001)(71190400001)(476003)(71200400001)(386003)(11346002)(33896004)(76176011)(446003)(6916009)(6116002)(52116002)(1076002)(106356001)(99286004)(44832011)(8936002)(105586002)(6512007)(9686003)(14454004)(2906002)(305945005)(7736002)(486006)(97736004)(6436002)(3846002)(2900100001)(508600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1710;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zQQkdM1wxehkVjHRp1l0Tx1uZJCIWDGi1A7nugFRTDGbe1hYzSTDkP5MKfnYF707eKT6sq0seFwjlxL1wdyDTWJABeoTxGUOAeANN7SeReWbTJSN2+dYMgFVOBFP3pMYznjtcIGfE/XhVqWPKC0PvLHlRgkCEG1EGH/1+/lpy5vhPKD+PYyPq8tzGfy4AfpyDHsVVBUU56tQ0JX9eSZUKQpZFkJhUvIy50IWS6SihwzoqMt1rw2pxgqcFMl96HJbznG0U18Zoxtl1ovCB/8M/B3yA4pRkch7sVYW/ssr+NnIJdqpbBY8dGcaX5TuZupumn/qYT9e89G9iZ32FGteBqcFoZZidRScPZwg+B9dxac=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <930E4EFE3D97EB4BADB2F6C480814F71@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13132df-0276-4ae5-8545-08d624a54b17
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 18:16:07.5707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1710
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66602
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

SGkgSHVhY2FpLA0KDQpPbiBUaHUsIFNlcCAyNywgMjAxOCBhdCAwMjoyNjo0MlBNICswODAwLCDp
mYjljY7miY0gd3JvdGU6DQo+IEkgdGhpbmsgdGhpcyBwYXRjaCBjYW4gc29sdmUgbXkgcHJvYmxl
bSwgYnV0IEkgaGF2ZSBzb21ldGhpbmcgdG8gc2F5Og0KPg0KPiAxLCBWRFNPIHJhbmRvbWl6YXRp
b24gaXMgaW50cm9kdWNlZCBpbiBjb21taXQNCj4gY2NkMzk4ODA4NjM2NDgzN2QwYzBmYjQ1NjNk
NyBpbiAzLjE5LiBTbyB0aGlzIHBhdGNoIHNob3VsZCBiYWNrcG9ydGVkDQo+IGFzIGVhcmx5IGFz
IDMuMTkuDQoNClVnaCwgT0sgc28gdGhlIG5vdC1yZWFsbHktYS1WRFNPIHBhZ2UgdGhhdCB3ZSBj
YWxsZWQgVkRTTyBiZWZvcmUgd2UNCnJlYWxseSBoYWQgYSBWRFNPIHdhcyByYW5kb21seSBsb2Nh
dGVkIHRvby4gQSBiYWNrcG9ydCB0byB0aGF0IHdvdWxkDQpuZWVkIHRvIGJlIHNpZ25pZmljYW50
bHkgZGlmZmVyZW50Lg0KDQpIb3dldmVyIHRoZSBvbmx5IGN1cnJlbnRseSBzdXBwb3J0ZWQgTFRT
IGtlcm5lbCBvbGRlciB0aGFuIDQuNCAod2hpY2gNCmludHJvZHVjZWQgdGhlIHJlYWwgVkRTTykg
aXMgMy4xNi4gMy4xNiBkaWRuJ3Qgc3VwcG9ydCB0aGUgcmFuZG9taXphdGlvbg0KYW55d2F5LCBJ
IGRvbid0IHRoaW5rIGl0J3Mgd29ydGggdGhlIGVmZm9ydCB0byBiYWNrcG9ydCBhbnkgZnVydGhl
ciB0aGFuDQo0LjQuDQoNCj4gMiwgdmRzb19iYXNlKCkgbWF5IG5lZWQgdG8gYmUgbW9kaWZpZWQg
Zm9yIDQuNCwgYmVjYXVzZSA0LjQgaGFzIG5vDQo+IGRlbGF5IHNsb3QgZW11bGF0aW9uLg0KDQpZ
ZXMgSSBrbm93LiBUaGUgR0lDIGNvZGUgY2hhbmdlZCBpbiA0LjE0IHRvbyBzbyBiYWNrcG9ydHMg
d2lsbCBuZWVkIHRvDQp0YWtlIHRoYXQgaW50byBhY2NvdW50IHRvby4NCg0KPiAzLCBNYXliZSBp
dCBpcyBiZXR0ZXIgdG8gc2V0IFZEU09fUkFORE9NSVpFX1NJWkUgdG8gMTZNQiBmb3IgNjRiaXQN
Cj4ga2VybmVsLCBiZWNhdXNlIGNvbW1pdCBjY2QzOTg4MDg2MzY0ODM3ZDBjMGZiNDU2M2Q3IHVz
ZSAxNk1CLg0KDQpJdCBhY3R1YWxseSB1c2VzIDI1Nk1CIGZvciBNSVBTNjQuIFNpbmNlIGFkZHJl
c3Mgc3BhY2UgaXNuJ3Qgc2NhcmNlDQpmb3IgTUlQUzY0IEknbGwgZ28gd2l0aCB0aGF0Lg0KDQpU
aGFua3MsDQogICAgUGF1bA0K
