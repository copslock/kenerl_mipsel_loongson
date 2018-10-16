Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Oct 2018 17:00:49 +0200 (CEST)
Received: from mail1.bemta24.messagelabs.com ([67.219.250.112]:11577 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992869AbeJPPAneW1wL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Oct 2018 17:00:43 +0200
Received: from [67.219.250.196] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.us-west-2.aws.symcld.net id 3E/6E-08740-F0DF5CB5; Tue, 16 Oct 2018 15:00:31 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VSa0hTYRj22znbTuKpz5n5Kkk5KUo6y9mFFXY
  hiEZk1B+FJOssT24059iZtAoyg8o1yjuZFVkaliWBlvPWRVNRG2YWZGWkZTejsgt2sbRzdpbV
  v+d7n+d53+f9eClCdVsRRnEOO2ezsGa1wp9ceDObY6b8ak2Mrviq1PX3u5S63PZPpC6nME+pu
  9TBrST1z3+9JvV1xU+U+qoKp0LfeqFStoHcJDdZDGmOrXJj75fvSuv+UEd5doN8H+qFw8ifUu
  EsBAf6rioOo0kU4D1wzHNDKeFxBP0XrZKogICS0nJCfJD4IgH3qpvkEpMrg/auZkK0qPBTBLf
  7kkSswIug4cUoKeKpOBL6f9Qh0UDgcwhKng145wVhI3Tf7RRElCAywesxkPQx8CBv0Osl8Sxw
  NwwiEdN4M5x1u5A0+ASColfZ3sGTsAb6Bs54RQiHQ359pkzEBA6Bnvyzvt0wlDXeISQcDG+ej
  8klfRJ4qrKQVI+AKy6nTx8OPaddvnqNDIZOLpIwA8OFhb4+cTCSc9AbCHA7gk73SZ8hCg61eH
  yiWDjU9ML3qWb49vKrTMJLoezWqDIHaYv/yVos/AWB58Ll+vlSOQIKXAPKYu/+gdBxfJAsQWQ
  F0hlsphSjPZU1mRltdDSj1cYw2gULmRhtjIbdzRg06Tyzk+PtjPDcyWv4XanbzMkaC2evQsIx
  JVsP3q9FP8pTmlEoJVMH03MaWxNVkw1pybuMLG/cYks3c3wzmk5RaqA/jwpcoI1L4RzbTWbhI
  v/QQAWop9JNIk3zVjaVN6VIVCdaQr0vGT9GUNcfHSgiqPseZxGhIi1pFi4shL4mGrBoMKZbJt
  r9ufEeFB4WRCM/Pz9VgJWzpZrs//NDKIRC6iB69k+hS4DJYp+YOiQEkgmB1ixrEQPZ2b9U2D7
  kzN3dZcs0YM/xyrS6Kc2JD0f0M95mOgdaIlsfDiUNl/rXLN42s2hV2xHXePeD1cPy1ajNcc0d
  tfHxR2Nt5Oe2iOWhc+PX08EBK/Trq+OnNX4vvZPwofve2Kl5ZRk7umOP5NUAm1D44V1G10jHW
  r7l6Ma98R1701dk5OW6z/da4tblq0neyGqjCBvP/gZKm+VH3gMAAA==
X-Env-Sender: ikegami@allied-telesis.co.jp
X-Msg-Ref: server-21.tower-344.messagelabs.com!1539702030!487559!1
X-Originating-IP: [52.192.143.101]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17540 invoked from network); 16 Oct 2018 15:00:30 -0000
Received: from mo.allied-telesis-co-jp.hdemail.jp (HELO mo.allied-telesis-co-jp.hdemail.jp) (52.192.143.101)
  by server-21.tower-344.messagelabs.com with SMTP; 16 Oct 2018 15:00:30 -0000
Received: by mo.allied-telesis-co-jp.hdemail.jp (hde-mf-postfix, from userid 504)
        id DF983294002; Wed, 17 Oct 2018 00:00:29 +0900 (JST)
X-Received: from unknown (HELO mo.allied-telesis-co-jp.hdemail.jp) (127.0.0.1)
  by 0 with SMTP; 17 Oct 2018 00:00:29 +0900
X-Received: from mo.allied-telesis-co-jp.hdemail.jp (localhost.localdomain [127.0.0.1])
        by mo.allied-telesis-co-jp.hdemail.jp (hde-ma-postfix) with ESMTP id 83C5F1AC001;
        Wed, 17 Oct 2018 00:00:29 +0900 (JST)
        (envelope-from ikegami@allied-telesis.co.jp)
Received: from APC01-PU1-obe.outbound.protection.outlook.com (mail-pu1apc01lp0022.outbound.protection.outlook.com [65.55.88.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mo.allied-telesis-co-jp.hdemail.jp (hde-mf-postfix) with ESMTPS id 3059A294001;
        Wed, 17 Oct 2018 00:00:29 +0900 (JST)
        (envelope-from ikegami@allied-telesis.co.jp)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atjp.onmicrosoft.com;
 s=selector1-alliedtelesis-co-jp01e;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WPwkvF5Ew6Je6Z6BqjnVF9tSXAS5pHxn8Hl26+9azo=;
 b=dFhmHTyo2sdkan5ThPf3J/sN8bFy2DAJjZbecobaX22mvwcFJtkeUoFqaPW8qKeDpEJ+plPBT0KM0/JZD8bWanI4P9CxfIANtrHhUEOcP8kDfqlHNbJ0azvNu/bsMCBCOstYJ39eqY8fctPQEw2C4tMyLFg0xOKZTvqNeDCEbHY=
Received: from TY2PR01MB2169.jpnprd01.prod.outlook.com (52.133.183.150) by
 TY2PR01MB2297.jpnprd01.prod.outlook.com (52.133.184.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.25; Tue, 16 Oct 2018 15:00:27 +0000
Received: from TY2PR01MB2169.jpnprd01.prod.outlook.com
 ([fe80::495d:29aa:ec66:fc8c]) by TY2PR01MB2169.jpnprd01.prod.outlook.com
 ([fe80::495d:29aa:ec66:fc8c%2]) with mapi id 15.20.1228.027; Tue, 16 Oct 2018
 15:00:27 +0000
From:   IKEGAMI Tokunori <ikegami@allied-telesis.co.jp>
To:     James Hogan <jhogan@kernel.org>
CC:     PACKHAM Chris <chris.packham@alliedtelesis.co.nz>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH v5 1/1] MIPS: BCM47XX: Enable MIPS32 74K Core ExternalSync
 for BCM47XX PCIe erratum
Thread-Topic: [PATCH v5 1/1] MIPS: BCM47XX: Enable MIPS32 74K Core
 ExternalSync for BCM47XX PCIe erratum
Thread-Index: AQHT/ORCNG54zbrsUkCsjIZgy15I2KUix2MA
Date:   Tue, 16 Oct 2018 15:00:26 +0000
Message-ID: <TY2PR01MB2169367E0F1E82AF60A7C0D8DCFE0@TY2PR01MB2169.jpnprd01.prod.outlook.com>
References: <20180603140201.10593-1-ikegami@allied-telesis.co.jp>
 <20180603140201.10593-2-ikegami@allied-telesis.co.jp>
 <20180605154529.GA19361@jamesdev>
In-Reply-To: <20180605154529.GA19361@jamesdev>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [61.215.194.29]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY2PR01MB2297;20:+2Sf90AYHMirg/hCpE22a0BnimJ/s41WlXOQYytf9Jvc6ZZc8aYh7R33yydAR48kabAhomgevqqJTrO947h4z2PVOHRUfiTBPqr46pAQZlJSN/3HzKoHFZGTqUQXIW3qlvA9ooxCxy2EXfObhX0k9OWA/LRgnmHARMLDog/cS92PFU0blQxLM3NQ2IT5yK0x4LKxHFyruNCrJaqF5HoB09L3CeZbW44Qy92MdPHAOd7ysCEbraFosdTEvqGCf+EZ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ef1b1a17-55d4-4930-45b5-08d633781b86
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:TY2PR01MB2297;
x-ms-traffictypediagnostic: TY2PR01MB2297:
x-ld-processed: 1a8a37cf-9ecc-4cef-abb0-1ab01a15a6ad,ExtAddr
x-microsoft-antispam-prvs: <TY2PR01MB22976907525C7C4A4B0C59CADCFE0@TY2PR01MB2297.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:TY2PR01MB2297;BCL:0;PCL:0;RULEID:;SRVR:TY2PR01MB2297;
x-forefront-prvs: 0827D7ACB9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(396003)(136003)(376002)(366004)(346002)(50944005)(189003)(199004)(51914003)(13464003)(33656002)(551934003)(39060400002)(2900100001)(186003)(66574009)(102836004)(4326008)(81166006)(26005)(8676002)(97736004)(14454004)(81156014)(105586002)(106356001)(8936002)(9686003)(55016002)(229853002)(256004)(6436002)(68736007)(11346002)(446003)(74482002)(316002)(53936002)(476003)(486006)(99286004)(3846002)(6916009)(6116002)(6246003)(14444005)(5250100002)(5660300001)(7696005)(66066001)(2906002)(71200400001)(7736002)(54906003)(25786009)(74316002)(71190400001)(478600001)(76176011)(305945005)(6506007)(86362001)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2PR01MB2297;H:TY2PR01MB2169.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: allied-telesis.co.jp does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: 1kZJXGROuKXXNWKK9e2DEZVd6NpHR1X/wxq5aeIgMK5MQ0Dxebm/8Jx5aA9IdMPSz/yCSC7tEY/zFFL5YPYhI40w/n/ulZZFhXtPN2lhO+boFjvQYFhKxGjQMMNedJhFXA320YFP/M/jc1TVItD8Aq7Ay+LzVz0QPgVNUCYfYU0+Ve9GiQOqxb38PqoPY5rKJLOtaZlmPVIZiyb6HVU5D0Pem3tu6+uF3dvBRAz4nfqGFb59GtIjjDR4FAxGNYf6G4L7TgOVjsInt6S4p9GWuEBhXLJQ3MORA6BmQ7zonQiE9eQLxd50zAkwbzaO/mdxoWsUwiPdY6Ny7TD8Ky+UmnGLGMyVVL9lVDeSsNAWWVI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: allied-telesis.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1b1a17-55d4-4930-45b5-08d633781b86
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2018 15:00:27.0090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1a8a37cf-9ecc-4cef-abb0-1ab01a15a6ad
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2297
Return-Path: <ikegami@allied-telesis.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66873
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

SGkgSmFtZXMtc2FuLA0KDQpWZXJ5IHNvcnJ5IGZvciB0b28gbGF0ZSB0byByZXBseSB0byB5b3Vy
IG1haWwuDQpBcyByZXZlcnRlZCB0aGUgcGF0Y2ggYWxyZWFkeSBhcyB5b3Uga25vdyBubyBuZWVk
IHRvIGJhY2sgcG9ydC4NCkFnYWluIHZlcnkgc29ycnkgZm9yIHRoZSBwcm9ibGVtLg0KDQpSZWdh
cmRzLA0KSWtlZ2FtaQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEph
bWVzIEhvZ2FuIFttYWlsdG86amhvZ2FuQGtlcm5lbC5vcmddDQo+IFNlbnQ6IFdlZG5lc2RheSwg
SnVuZSAwNiwgMjAxOCAxMjo0NiBBTQ0KPiBUbzogSUtFR0FNSSBUb2t1bm9yaQ0KPiBDYzogUEFD
S0hBTSBDaHJpczsgUmFmYcWCIE1pxYJlY2tpOyBsaW51eC1taXBzQGxpbnV4LW1pcHMub3JnDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMS8xXSBNSVBTOiBCQ000N1hYOiBFbmFibGUgTUlQUzMy
IDc0SyBDb3JlDQo+IEV4dGVybmFsU3luYyBmb3IgQkNNNDdYWCBQQ0llIGVycmF0dW0NCj4gDQo+
IE9uIFN1biwgSnVuIDAzLCAyMDE4IGF0IDExOjAyOjAxUE0gKzA5MDAsIFRva3Vub3JpIElrZWdh
bWkgd3JvdGU6DQo+ID4gVGhlIGVycmF0dW0gYW5kIHdvcmthcm91bmQgYXJlIGRlc2NyaWJlZCBi
eSBCQ001MzAwWC1FUzMwMC1SRFMucGRmIGFzDQo+IGJlbG93Lg0KPiA+DQo+ID4gICBSMTA6IFBD
SWUgVHJhbnNhY3Rpb25zIFBlcmlvZGljYWxseSBGYWlsDQo+ID4NCj4gPiAgICAgRGVzY3JpcHRp
b246IFRoZSBCQ001MzAwWCBQQ0llIGRvZXMgbm90IG1haW50YWluIHRyYW5zYWN0aW9uDQo+IG9y
ZGVyaW5nLg0KPiA+ICAgICAgICAgICAgICAgICAgVGhpcyBtYXkgY2F1c2UgUENJZSB0cmFuc2Fj
dGlvbiBmYWlsdXJlLg0KPiA+ICAgICBGaXggQ29tbWVudDogQWRkIGEgZHVtbXkgUENJZSBjb25m
aWd1cmF0aW9uIHJlYWQgYWZ0ZXIgYSBQQ0llDQo+ID4gICAgICAgICAgICAgICAgICBjb25maWd1
cmF0aW9uIHdyaXRlIHRvIGVuc3VyZSBQQ0llIGNvbmZpZ3VyYXRpb24NCj4gYWNjZXNzDQo+ID4g
ICAgICAgICAgICAgICAgICBvcmRlcmluZy4gU2V0IEVTIGJpdCBvZiBDUDAgY29uZmlndTcgcmVn
aXN0ZXIgdG8gZW5hYmxlDQo+ID4gICAgICAgICAgICAgICAgICBzeW5jIGZ1bmN0aW9uIHNvIHRo
YXQgdGhlIHN5bmMgaW5zdHJ1Y3Rpb24gaXMNCj4gZnVuY3Rpb25hbC4NCj4gPiAgICAgUmVzb2x1
dGlvbjogIGhuZHBjaS5jOiBleHRwY2lfd3JpdGVfY29uZmlnKCkNCj4gPiAgICAgICAgICAgICAg
ICAgIGhuZG1pcHMuYzogc2lfbWlwc19pbml0KCkNCj4gPiAgICAgICAgICAgICAgICAgIG1pcHNp
bmMuaCBDT05GN19FUw0KPiA+DQo+ID4gVGhpcyBpcyBmaXhlZCBieSB0aGUgQ0ZFIE1JUFMgYmNt
c2kgY2hpcHNldCBkcml2ZXIgYWxzbyBmb3IgQkNNNDdYWC4NCj4gPiBBbHNvIHRoZSBkdW1teSBQ
Q0llIGNvbmZpZ3VyYXRpb24gcmVhZCBpcyBhbHJlYWR5IGltcGxlbWVudGVkIGluIHRoZSBMaW51
eA0KPiA+IEJDTUEgZHJpdmVyLg0KPiA+IEVuYWJsZSBFeHRlcm5hbFN5bmMgaW4gQ29uZmlnNyB3
aGVuIENPTkZJR19CQ01BX0RSSVZFUl9QQ0lfSE9TVE1PREU9eQ0KPiA+IHRvbyBzbyB0aGF0IHRo
ZSBzeW5jIGluc3RydWN0aW9uIGlzIGV4dGVybmFsaXNlZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFRva3Vub3JpIElrZWdhbWkgPGlrZWdhbWlAYWxsaWVkLXRlbGVzaXMuY28uanA+DQo+ID4g
UmV2aWV3ZWQtYnk6IFBhdWwgQnVydG9uIDxwYXVsLmJ1cnRvbkBtaXBzLmNvbT4NCj4gPiBBY2tl
ZC1ieTogSGF1a2UgTWVocnRlbnMgPGhhdWtlQGhhdWtlLW0uZGU+DQo+ID4gQ2M6IENocmlzIFBh
Y2toYW0gPGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4NCj4gPiBDYzogUmFmYcWC
IE1pxYJlY2tpIDx6YWplYzVAZ21haWwuY29tPg0KPiA+IENjOiBsaW51eC1taXBzQGxpbnV4LW1p
cHMub3JnDQo+IA0KPiBJIHByZXN1bWUgdGhpcyBwYXRjaCBpcyByZWFkeSB0byBhcHBseSBub3cg
KHRoYW5rcyBmb3IgdGhlIHJldmlld3MNCj4gZm9sa3MpLg0KPiANCj4gSG93IGZhciBiYWNrIGRv
ZXMgdGhpcyBuZWVkIGJhY2twb3J0aW5nIHRvIHN0YWJsZSBicmFuY2hlcz8NCj4gDQo+IEl0IGFw
cGxpZXMgZWFzaWx5IGJhY2sgdG8gMy4xNCBJIHRoaW5rIChjb21taXQgM2MwNmIxMmIwNDZlICgi
TUlQUzoNCj4gQkNNNDdYWDogZml4IHBvc2l0aW9uIG9mIGNwdV93YWl0IGRpc2FibGluZyIpKSwg
YnV0IHlvdSBtZW50aW9uZWQgb3RoZXINCj4gZml4ZXMgdG9vLiBIYXZlIHRob3NlIGJlZW4gYmFj
a3BvcnRlZCB0b28sIGFuZCBpZiBub3QgaXMgdGhlcmUgYW55IHBvaW50DQo+IGJhY2twb3J0aW5n
IHRoaXM/DQo+IA0KPiBUaGFua3MNCj4gSmFtZXMNCg==
