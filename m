Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jun 2018 16:06:26 +0200 (CEST)
Received: from mail1.bemta8.messagelabs.com ([216.82.243.193]:33793 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992737AbeFCOGTPYIiM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Jun 2018 16:06:19 +0200
Received: from [216.82.241.100] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta-8.messagelabs.com id DE/76-26999-9D5F31B5; Sun, 03 Jun 2018 14:06:17 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTWUwTURSGezvTdiCMubYSDiBGGhfEtBS3VDH
  EaKJ9MASjPihGHXSgo23BTjHVCC4hshSVpUjAoGjARIRocAWUAIoRXFDcYuJCgaJtjFEUH3Dt
  dArq23/P9597zj05lyKUHfIIirXbWKuFManlweSC9mOs5uWoKkVXNBKl7+93KPRPPev1JXdHS
  H1xealC39DNLpMZBn++Jw3NVa8VhrfuNsLQVF8gN3Sda5QmyzbKOEtqhn2rzDg41izPbNTZLw
  7XEgfQq7hCFEwpcT4Ct+u0tBAFUYD3gqf6ikIAgH8jcFY0SkVXGQGXa0flwoHE5wlwtfQQIim
  Wwqd7HYSQr8RvEPSdzBS0HC+EVvd3UtBT8Ep4VH8JCQkErkNQM+CSC0CFjXDld2HAxMHjU+2E
  qOdB9ZF+JGgSz4DWd7n+Bmm8CRwVuaRY+RyCsvKH/ouCcCKcqfyoEDTCUVDWctCfQOAw6Cs7I
  xdfh6H2Ri8h6lDwDP6Sif7NcL8pH4nxaLjsKAj4o6DvlAOJ07hOwseuxsCYNPCpvJwQwVUEb5
  xtgexY+Nb2LVBhKeR1uBWi3gkNx1oD8SVQe+t7ID4N6o+4yGIUX/VPs1WI8uk5cKElTgxHg9P
  hUlT5BzAZuiuHyBpE1qMYnrXuZq2aefHaVCuXbrSZGc6kidfptWaW55l01sSk8tptGeYm5Fuk
  /RIJuo6ae1d1onBKqg6lvXZVinJSasb2PUaGN26xZplYvhNNpSg10J6vPjbZyqaz9jTO5NvGc
  QxUiHoKXShgms9kzDyXLqIeNJ96dbioiKCGnhwvIpSkJcPCRoTRhwQrFqzGLMvEReOb3YeiIl
  Q0kkgkypBM1mrmbP9zLwqjkFpFK30fQBnCWWwT9by+VqS+Vobt/lZszF8UcQCtyP2cqOu9U6M
  NWpm945qjmp5bkIBnctlTI0tz3Fz7jpxlA4fmjOaNaaVPXecXlyT3pvQ8k8aemHV0xv01MUmn
  02YTSZ3ZkriK1ZHNzuTwFwkDGtOXR+w63b4NnQ8SEqBget6iupsfdp29PXhyzBzmjPbmPKxZr
  vA8/xF+cM9a7406NckbmfhYwsozfwDxF2ql1AMAAA==
X-Env-Sender: ikegami@allied-telesis.co.jp
X-Msg-Ref: server-8.tower-220.messagelabs.com!1528034776!199946887!1
X-Originating-IP: [52.192.143.101]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13611 invoked from network); 3 Jun 2018 14:06:16 -0000
Received: from mo.allied-telesis-co-jp.hdemail.jp (HELO mo.allied-telesis-co-jp.hdemail.jp) (52.192.143.101)
  by server-8.tower-220.messagelabs.com with SMTP; 3 Jun 2018 14:06:16 -0000
Received: by mo.allied-telesis-co-jp.hdemail.jp (hde-mf-postfix, from userid 504)
        id 3E54E294002; Sun,  3 Jun 2018 23:06:16 +0900 (JST)
X-Received: from unknown (HELO mo.allied-telesis-co-jp.hdemail.jp) (127.0.0.1)
  by 0 with SMTP; 3 Jun 2018 23:06:15 +0900
X-Received: from mo.allied-telesis-co-jp.hdemail.jp (localhost.localdomain [127.0.0.1])
        by mo.allied-telesis-co-jp.hdemail.jp (hde-ma-postfix) with ESMTP id D81061AC001;
        Sun,  3 Jun 2018 23:06:15 +0900 (JST)
        (envelope-from ikegami@allied-telesis.co.jp)
Received: from JPN01-TY1-obe.outbound.protection.outlook.com (mail-ty1jpn01lp0175.outbound.protection.outlook.com [23.103.139.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mo.allied-telesis-co-jp.hdemail.jp (hde-mf-postfix) with ESMTPS id C4040294001;
        Sun,  3 Jun 2018 23:06:15 +0900 (JST)
        (envelope-from ikegami@allied-telesis.co.jp)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atjp.onmicrosoft.com;
 s=selector1-alliedtelesis-co-jp01e;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6TngwsK9JO6Izn5NXd7NGQK4tEWJ/IRPh85kJkqvW0=;
 b=EsFCf62ahW2Zyf5POYXcWHItiiJ2hNQTyaSHQxUti+jNYlM1Lw8/2Gc8Q8UZ+LWdrszgPuD3Ml4UB4KvehdzF2/RfyB6Ux1uIdiO4GtpVZ68PQiQTZXfKNfWevEtLuE2nZVLEWb5fCdYdRiuyFQRwcc4gUFFSPCYydCs/k8MSNw=
Received: from TY1PR01MB0954.jpnprd01.prod.outlook.com (10.167.157.141) by
 TY1PR01MB1277.jpnprd01.prod.outlook.com (10.174.226.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.13; Sun, 3 Jun 2018 14:06:14 +0000
Received: from TY1PR01MB0954.jpnprd01.prod.outlook.com
 ([fe80::3d74:245b:c1e5:b0ab]) by TY1PR01MB0954.jpnprd01.prod.outlook.com
 ([fe80::3d74:245b:c1e5:b0ab%4]) with mapi id 15.20.0820.015; Sun, 3 Jun 2018
 14:06:13 +0000
From:   IKEGAMI Tokunori <ikegami@allied-telesis.co.jp>
To:     Hauke Mehrtens <hauke@hauke-m.de>, James Hogan <jhogan@kernel.org>
CC:     PACKHAM Chris <chris.packham@alliedtelesis.co.nz>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH v4 1/1] MIPS: BCM47XX: Enable MIPS32 74K Core ExternalSync
 for BCM47XX PCIe erratum
Thread-Topic: [PATCH v4 1/1] MIPS: BCM47XX: Enable MIPS32 74K Core
 ExternalSync for BCM47XX PCIe erratum
Thread-Index: AQHT+lity0tuFXP2RUu2+zG3uONry6ROkopw
Date:   Sun, 3 Jun 2018 14:06:13 +0000
Message-ID: <TY1PR01MB0954B0764B7B9F499CEEC923DC600@TY1PR01MB0954.jpnprd01.prod.outlook.com>
References: <20180531221911.6210-1-ikegami@allied-telesis.co.jp>
 <20180531221911.6210-2-ikegami@allied-telesis.co.jp>
 <8f968192-0a69-3586-5e0d-e03b243110f6@hauke-m.de>
In-Reply-To: <8f968192-0a69-3586-5e0d-e03b243110f6@hauke-m.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [61.215.194.29]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1277;7:pQwQhHTuhec3N13vJ0d7DUDuPFvQ9HzFfnTbDeqvN98stRWpxed81R3gEY6kr+DcaRE0KyUNGSKzLvAKsmdFr3WWBiNz4Rth/5KVpjUBcg7Rq1X35VuY63pMQ1RUpmXmmV0YaVkHsxOu8hVkgCD0QEYfD7eJ04B0yhlLPY5yb/yYv8HqLdd6G/xCpyI6zJa8u7gCQRhg+nve1r93fNyUEvA/C6JJC5FfGA1R+i3kjRg7aiTkz7Z1EIZ8yGfMRRrV;20:i25bZM9M8GeHDsvqnnUcDBItuizeKjRNbsrlgQv5l3nRZbvEfkKqKY3s/cFe8Ay7Og0Epb9YIQiN+gkFdKsrnJi9OvQFs3gWZg4f5AnWROyn6MBKU1fqEJuwgEWokOTatiPfEbgVppxKLqQnyMg+i6NV1NiwPk/ZNNqKmapKknxswzjJA0+8W8QqHE9U/7XeKJuUHA9JCSlENFq+E8386q65CMlpRdm+YVCo27nLwNi6qu0YhJu6nXRIQaC7AnXG
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1277;
x-ms-traffictypediagnostic: TY1PR01MB1277:
x-ld-processed: 1a8a37cf-9ecc-4cef-abb0-1ab01a15a6ad,ExtAddr
x-microsoft-antispam-prvs: <TY1PR01MB12772CD3D484FFFB75A30A1FDC600@TY1PR01MB1277.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:TY1PR01MB1277;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1277;
x-forefront-prvs: 069255B8B8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(396003)(39380400002)(346002)(376002)(366004)(13464003)(50944005)(189003)(199004)(110136005)(5660300001)(2900100001)(478600001)(39060400002)(966005)(6246003)(229853002)(25786009)(86362001)(55016002)(74482002)(4326008)(14454004)(53936002)(6436002)(6306002)(9686003)(81156014)(81166006)(106356001)(8676002)(102836004)(8936002)(6506007)(53546011)(76176011)(551934003)(99286004)(7696005)(486006)(476003)(446003)(11346002)(305945005)(186003)(74316002)(105586002)(7736002)(59450400001)(3280700002)(3660700001)(5250100002)(26005)(54906003)(97736004)(2906002)(68736007)(66066001)(6116002)(3846002)(33656002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1277;H:TY1PR01MB0954.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: allied-telesis.co.jp does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: moKW5Qerw8f7AKLJK47lEK5OAcNtGLY78hO6E4FcXbzB5SlUqbA11QkPplrBXyXAV9BPRAaw7MZ/NyXrIEaAp/z00yh/tprNFAWsZr83H+tAzW5iDcv+2H7Nq9PU7fnbOhjZ4iairzLXlqUnCjy6dQLoWGQZNSxQnTgsaHG0MxDPgXjQkVbF8nAKPQPo0VOk
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: ce606066-5c71-4442-cd52-08d5c95b2aa9
X-OriginatorOrg: allied-telesis.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ce606066-5c71-4442-cd52-08d5c95b2aa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2018 14:06:13.6677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1a8a37cf-9ecc-4cef-abb0-1ab01a15a6ad
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1277
Return-Path: <ikegami@allied-telesis.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64165
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ikegami@allied-telesis.co.jp
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

SGkgSGF1a2Utc2FuLA0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3aW5nIGFuZCBjb21tZW50cy4N
Cg0KPiBZb3UgZG8gaXQgbm93IHVuY29uZGl0aW9uYWxseSBvbiBhbGwgTUlQUyBTb0NzIHVzaW5n
IGJjbWEuDQo+IA0KPiBUaGVyZSBhcmUgbXVsdGlwbGUgZGlmZmVyZW50IHNpbGljb25zIGZyb20g
dGhlIEJyb2FkY29tIEJDTTQ3eHggYW5kDQo+IEJDTTUzeHggbGluZSB3aXRoIGEgTUlQUyA3NEsg
Y29yZSwgc2VlDQo+IGh0dHBzOi8vd2lraWRldmkuY29tL3dpa2kvQnJvYWRjb20gSSBoYXZlbid0
IHRlc3RlZCBpZiB0aGlzIGZpeCBpcyBvaw0KPiBmb3IgYWxsIG9mIHRoZW0sIGJ1dCBJIHRoaW5r
IHNvLg0KDQogIEkgc2VlIGFuZCB5ZXMgSSB0aGluayBzbyBmcm9tIHRoZSBDRkUgaW1wbGVtZW50
YXRpb24uDQoNCj4gQWNrZWQtYnk6IEhhdWtlIE1laHJ0ZW5zIDxoYXVrZUBoYXVrZS1tLmRlPg0K
DQogIEp1c3Qgc2VudCB0aGUgdjUgdmVyc2lvbiBwYXRjaCB0byBjaGFuZ2UgeW91ciBuYW1lIHRh
ZyBhcyBBY2tlZC1ieS4NCg0KUmVnYXJkcywNCklrZWdhbWkNCg0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBIYXVrZSBNZWhydGVucyBbbWFpbHRvOmhhdWtlQGhhdWtlLW0u
ZGVdDQo+IFNlbnQ6IFNhdHVyZGF5LCBKdW5lIDAyLCAyMDE4IDY6NTQgUE0NCj4gVG86IElLRUdB
TUkgVG9rdW5vcmk7IEphbWVzIEhvZ2FuDQo+IENjOiBQQUNLSEFNIENocmlzOyBSYWZhxYIgTWnF
gmVja2k7IGxpbnV4LW1pcHNAbGludXgtbWlwcy5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
NCAxLzFdIE1JUFM6IEJDTTQ3WFg6IEVuYWJsZSBNSVBTMzIgNzRLIENvcmUNCj4gRXh0ZXJuYWxT
eW5jIGZvciBCQ000N1hYIFBDSWUgZXJyYXR1bQ0KPiANCj4gT24gMDYvMDEvMjAxOCAxMjoxOSBB
TSwgVG9rdW5vcmkgSWtlZ2FtaSB3cm90ZToNCj4gPiBUaGUgZXJyYXR1bSBhbmQgd29ya2Fyb3Vu
ZCBhcmUgZGVzY3JpYmVkIGJ5IEJDTTUzMDBYLUVTMzAwLVJEUy5wZGYgYXMNCj4gYmVsb3cuDQo+
ID4NCj4gPiAgIFIxMDogUENJZSBUcmFuc2FjdGlvbnMgUGVyaW9kaWNhbGx5IEZhaWwNCj4gPg0K
PiA+ICAgICBEZXNjcmlwdGlvbjogVGhlIEJDTTUzMDBYIFBDSWUgZG9lcyBub3QgbWFpbnRhaW4g
dHJhbnNhY3Rpb24NCj4gb3JkZXJpbmcuDQo+ID4gICAgICAgICAgICAgICAgICBUaGlzIG1heSBj
YXVzZSBQQ0llIHRyYW5zYWN0aW9uIGZhaWx1cmUuDQo+ID4gICAgIEZpeCBDb21tZW50OiBBZGQg
YSBkdW1teSBQQ0llIGNvbmZpZ3VyYXRpb24gcmVhZCBhZnRlciBhIFBDSWUNCj4gPiAgICAgICAg
ICAgICAgICAgIGNvbmZpZ3VyYXRpb24gd3JpdGUgdG8gZW5zdXJlIFBDSWUgY29uZmlndXJhdGlv
bg0KPiBhY2Nlc3MNCj4gPiAgICAgICAgICAgICAgICAgIG9yZGVyaW5nLiBTZXQgRVMgYml0IG9m
IENQMCBjb25maWd1NyByZWdpc3RlciB0byBlbmFibGUNCj4gPiAgICAgICAgICAgICAgICAgIHN5
bmMgZnVuY3Rpb24gc28gdGhhdCB0aGUgc3luYyBpbnN0cnVjdGlvbiBpcw0KPiBmdW5jdGlvbmFs
Lg0KPiA+ICAgICBSZXNvbHV0aW9uOiAgaG5kcGNpLmM6IGV4dHBjaV93cml0ZV9jb25maWcoKQ0K
PiA+ICAgICAgICAgICAgICAgICAgaG5kbWlwcy5jOiBzaV9taXBzX2luaXQoKQ0KPiA+ICAgICAg
ICAgICAgICAgICAgbWlwc2luYy5oIENPTkY3X0VTDQo+ID4NCj4gPiBUaGlzIGlzIGZpeGVkIGJ5
IHRoZSBDRkUgTUlQUyBiY21zaSBjaGlwc2V0IGRyaXZlciBhbHNvIGZvciBCQ000N1hYLg0KPiA+
IEFsc28gdGhlIGR1bW15IFBDSWUgY29uZmlndXJhdGlvbiByZWFkIGlzIGFscmVhZHkgaW1wbGVt
ZW50ZWQgaW4gdGhlIExpbnV4DQo+ID4gQkNNQSBkcml2ZXIuDQo+ID4gRW5hYmxlIEV4dGVybmFs
U3luYyBpbiBDb25maWc3IHdoZW4gQ09ORklHX0JDTUFfRFJJVkVSX1BDSV9IT1NUTU9ERT15DQo+
ID4gdG9vIHNvIHRoYXQgdGhlIHN5bmMgaW5zdHJ1Y3Rpb24gaXMgZXh0ZXJuYWxpc2VkLg0KPiAN
Cj4gWW91IGRvIGl0IG5vdyB1bmNvbmRpdGlvbmFsbHkgb24gYWxsIE1JUFMgU29DcyB1c2luZyBi
Y21hLg0KPiANCj4gVGhlcmUgYXJlIG11bHRpcGxlIGRpZmZlcmVudCBzaWxpY29ucyBmcm9tIHRo
ZSBCcm9hZGNvbSBCQ000N3h4IGFuZA0KPiBCQ001M3h4IGxpbmUgd2l0aCBhIE1JUFMgNzRLIGNv
cmUsIHNlZQ0KPiBodHRwczovL3dpa2lkZXZpLmNvbS93aWtpL0Jyb2FkY29tIEkgaGF2ZW4ndCB0
ZXN0ZWQgaWYgdGhpcyBmaXggaXMgb2sNCj4gZm9yIGFsbCBvZiB0aGVtLCBidXQgSSB0aGluayBz
by4NCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogVG9rdW5vcmkgSWtlZ2FtaSA8aWtlZ2FtaUBhbGxp
ZWQtdGVsZXNpcy5jby5qcD4NCj4gPiBSZXZpZXdlZC1ieTogUGF1bCBCdXJ0b24gPHBhdWwuYnVy
dG9uQG1pcHMuY29tPg0KPiA+IENjOiBDaHJpcyBQYWNraGFtIDxjaHJpcy5wYWNraGFtQGFsbGll
ZHRlbGVzaXMuY28ubno+DQo+ID4gQ2M6IEhhdWtlIE1laHJ0ZW5zIDxoYXVrZUBoYXVrZS1tLmRl
Pg0KPiA+IENjOiBSYWZhxYIgTWnFgmVja2kgPHphamVjNUBnbWFpbC5jb20+DQo+ID4gQ2M6IGxp
bnV4LW1pcHNAbGludXgtbWlwcy5vcmcNCj4gDQo+IEFja2VkLWJ5OiBIYXVrZSBNZWhydGVucyA8
aGF1a2VAaGF1a2UtbS5kZT4NCj4gDQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBzaW5jZSB2MzoNCj4g
PiAtIEFkZCBSZXZpZXdlZC1ieTogUGF1bCBCdXJ0b24gdGFnLg0KPiA+IC0gUmVtb3ZlIHByX2lu
Zm8oKS4NCj4gPg0KPiA+IENoYW5nZXMgc2luY2UgdjI6DQo+ID4gLSBNb3ZlIHRoZSBjaGFuZ2Ug
aW50byBwbGF0Zm9ybS1zcGVjaWZpYyBjb2RlIGJjbTQ3eHhfY3B1X2ZpeGVzKCkNCj4gZnVuY3Rp
b24gZnJvbSBpbiBnZW5lcmljIGNvZGUuDQo+ID4NCj4gPiBDaGFuZ2VzIHNpbmNlIHYxIHJlc2Vu
dDoNCj4gPiAtIE5vbmUuDQo+ID4NCj4gPiBDaGFuZ2VzIHNpbmNlIHYxIG9yaWdpbmFsOg0KPiA+
IC0gQ2hhbmdlIHRvIHVzZSBzZXRfYzBfY29uZmlnNyBpbnN0ZWFkIG9mIHdyaXRlX2MwX2NvbmZp
ZzcuDQo+ID4NCj4gPiAgYXJjaC9taXBzL2JjbTQ3eHgvc2V0dXAuYyAgICAgICAgfCA2ICsrKysr
Kw0KPiA+ICBhcmNoL21pcHMvaW5jbHVkZS9hc20vbWlwc3JlZ3MuaCB8IDMgKysrDQo+ID4gIDIg
ZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJj
aC9taXBzL2JjbTQ3eHgvc2V0dXAuYyBiL2FyY2gvbWlwcy9iY200N3h4L3NldHVwLmMNCj4gPiBp
bmRleCA2MDU0ZDQ5ZTYwOGUuLjhjOWNiZjEzZDMyYSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL21p
cHMvYmNtNDd4eC9zZXR1cC5jDQo+ID4gKysrIGIvYXJjaC9taXBzL2JjbTQ3eHgvc2V0dXAuYw0K
PiA+IEBAIC0yMTIsNiArMjEyLDEyIEBAIHN0YXRpYyBpbnQgX19pbml0IGJjbTQ3eHhfY3B1X2Zp
eGVzKHZvaWQpDQo+ID4gIAkJICovDQo+ID4gIAkJaWYgKGJjbTQ3eHhfYnVzLmJjbWEuYnVzLmNo
aXBpbmZvLmlkID09DQo+IEJDTUFfQ0hJUF9JRF9CQ000NzA2KQ0KPiA+ICAJCQljcHVfd2FpdCA9
IE5VTEw7DQo+ID4gKw0KPiA+ICsJCS8qDQo+ID4gKwkJICogQkNNNDdYWCBFcnJhdHVtICJSMTA6
IFBDSWUgVHJhbnNhY3Rpb25zIFBlcmlvZGljYWxseQ0KPiBGYWlsIg0KPiA+ICsJCSAqIEVuYWJs
ZSBFeHRlcm5hbFN5bmMgZm9yIHN5bmMgaW5zdHJ1Y3Rpb24gdG8gdGFrZSBlZmZlY3QNCj4gPiAr
CQkgKi8NCj4gPiArCQlzZXRfYzBfY29uZmlnNyhNSVBTX0NPTkY3X0VTKTsNCj4gPiAgCQlicmVh
azsNCj4gPiAgI2VuZGlmDQo+ID4gIAl9DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvbWlwcy9pbmNs
dWRlL2FzbS9taXBzcmVncy5oDQo+IGIvYXJjaC9taXBzL2luY2x1ZGUvYXNtL21pcHNyZWdzLmgN
Cj4gPiBpbmRleCA4NTg3NTJkYWMzMzcuLjBmOTRhY2Y2MDE0NCAxMDA2NDQNCj4gPiAtLS0gYS9h
cmNoL21pcHMvaW5jbHVkZS9hc20vbWlwc3JlZ3MuaA0KPiA+ICsrKyBiL2FyY2gvbWlwcy9pbmNs
dWRlL2FzbS9taXBzcmVncy5oDQo+ID4gQEAgLTY4MCw2ICs2ODAsOCBAQA0KPiA+ICAjZGVmaW5l
IE1JUFNfQ09ORjdfV0lJCQkoX1VMQ0FTVF8oMSkgPDwgMzEpDQo+ID4NCj4gPiAgI2RlZmluZSBN
SVBTX0NPTkY3X1JQUwkJKF9VTENBU1RfKDEpIDw8IDIpDQo+ID4gKy8qIEV4dGVybmFsU3luYyAq
Lw0KPiA+ICsjZGVmaW5lIE1JUFNfQ09ORjdfRVMJCShfVUxDQVNUXygxKSA8PCA4KQ0KPiA+DQo+
ID4gICNkZWZpbmUgTUlQU19DT05GN19JQVIJCShfVUxDQVNUXygxKSA8PCAxMCkNCj4gPiAgI2Rl
ZmluZSBNSVBTX0NPTkY3X0FSCQkoX1VMQ0FTVF8oMSkgPDwgMTYpDQo+ID4gQEAgLTI3NTksNiAr
Mjc2MSw3IEBAIF9fQlVJTERfU0VUX0MwKHN0YXR1cykNCj4gPiAgX19CVUlMRF9TRVRfQzAoY2F1
c2UpDQo+ID4gIF9fQlVJTERfU0VUX0MwKGNvbmZpZykNCj4gPiAgX19CVUlMRF9TRVRfQzAoY29u
ZmlnNSkNCj4gPiArX19CVUlMRF9TRVRfQzAoY29uZmlnNykNCj4gPiAgX19CVUlMRF9TRVRfQzAo
aW50Y29udHJvbCkNCj4gPiAgX19CVUlMRF9TRVRfQzAoaW50Y3RsKQ0KPiA+ICBfX0JVSUxEX1NF
VF9DMChzcnNtYXApDQo+ID4NCg0K
