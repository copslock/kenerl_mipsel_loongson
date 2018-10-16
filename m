Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Oct 2018 16:58:33 +0200 (CEST)
Received: from mail1.bemta23.messagelabs.com ([67.219.246.211]:56985 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992869AbeJPO62EmpuL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Oct 2018 16:58:28 +0200
Received: from [67.219.247.52] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-d.us-east-1.aws.symcld.net id 09/05-11391-C8CF5CB5; Tue, 16 Oct 2018 14:58:20 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHJsWRWlGSWpSXmKPExsVicqA/Vbfnz9F
  og/dv5S0ePOhmt7jyMtRi4olPLBYTpk5itzj6OMai7/UxZovdaxcxWVzao2Kx5mSqA6fH478v
  WDx2zrrL7nH/6T5mj02rOtk8jq5cy+SxbfNJJo/zUz09Xh95yBLAEcWamZeUX5HAmjF7ynn2g
  qPyFdv+LGBtYJwg38XIxSEk0MEo8fzwDrYuRk4OCYFqiVlLdzKDJCQE/jNKrF61ig2iaiqzxJ
  G/X1hAHBaB1cwSvw4uZ4HITGSSuHGqHcq5zyhx+cNlsGFsAqYSu5/+ZgGxRQRiJO58ec0IUsQ
  ssJtJ4mrLD1aQhLBAtMS3O2fgilY0nwSKcwDZRhLzl4aDhFkEVCXeLLzLCGLzCsRK/Pw8mQnE
  FhJIl9g97xnYGE4BW4mVzyayg9iMArISk3c1gtUwC4hLXJq8COo5AYkle84zQ9iiEi8f/2OFq
  I+TOLOpgxEiriixpbsTql5W4tL8bqj4NiaJuRtKIGxdiQ9Tp0LN8ZXY/mwFNMBOMEqc2j4Hqk
  FLov3IGagiG4n2g0/ZIewciS2bp0DFLSU+b3/CNIHRcBaSW2cBvc8soCmxfpc+RFhRYkr3Q/Z
  ZYO8LSpyc+YRlASPLKkbTpKLM9IyS3MTMHF1DAwNdQ0MjIK1roJdYpZuiV1qsm5pYXKJrqJdY
  XqxXXJmbnJOil5dasokRmOZSCrgYdjC+WZp+iFGSg0lJlFdjz9FoIb6k/JTKjMTijPii0pzU4
  kOMMhwcShK8s38D5QSLUtNTK9Iyc4AJFyYtwcGjJMJ7ECTNW1yQmFucmQ6ROsXoynFs4f/pzB
  z7brXOYOa4cqYTSLY9vQ4kO0CkEEtefl6qlDjvXpBmAZDmjNI8uNGwbHGJUVZKmJeRgYFBiKc
  gtSg3swRV/hWjOAejkjDvBpApPJl5JXAXvAI6jgnoOHfbIyDHlSQipKQaGDelR512an9+am3O
  d47p/kK2X4q8V06XfVyYUVk8g7nagLs1uWHFF7eoGZ+LY+3P3JaXTnOVf9lZwP64kOeUgH1Bj
  YPkff623eHvHs45ekSyxciZseTsntWVXoInxHQD9u72YN9iyXvw3drAXuPVS88eTZr172DCjb
  rpnz42rdO7tuavL0v9LCWW4oxEQy3mouJEAGGBnggRBAAA
X-Env-Sender: ikegami@allied-telesis.co.jp
X-Msg-Ref: server-10.tower-424.messagelabs.com!1539701899!381674!1
X-Originating-IP: [52.192.143.101]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10969 invoked from network); 16 Oct 2018 14:58:20 -0000
Received: from mo.allied-telesis-co-jp.hdemail.jp (HELO mo.allied-telesis-co-jp.hdemail.jp) (52.192.143.101)
  by server-10.tower-424.messagelabs.com with SMTP; 16 Oct 2018 14:58:19 -0000
Received: by mo.allied-telesis-co-jp.hdemail.jp (hde-mf-postfix, from userid 504)
        id 1A946294002; Tue, 16 Oct 2018 23:58:19 +0900 (JST)
X-Received: from unknown (HELO mo.allied-telesis-co-jp.hdemail.jp) (127.0.0.1)
  by 0 with SMTP; 16 Oct 2018 23:58:18 +0900
X-Received: from mo.allied-telesis-co-jp.hdemail.jp (localhost.localdomain [127.0.0.1])
        by mo.allied-telesis-co-jp.hdemail.jp (hde-ma-postfix) with ESMTP id A01E81AC001;
        Tue, 16 Oct 2018 23:58:18 +0900 (JST)
        (envelope-from ikegami@allied-telesis.co.jp)
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-hk2apc01lp0212.outbound.protection.outlook.com [65.55.88.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mo.allied-telesis-co-jp.hdemail.jp (hde-mf-postfix) with ESMTPS id 51384294001;
        Tue, 16 Oct 2018 23:58:18 +0900 (JST)
        (envelope-from ikegami@allied-telesis.co.jp)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atjp.onmicrosoft.com;
 s=selector1-alliedtelesis-co-jp01e;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7lre20UGxZ7a1cx16Lqc2TH91ijNZPgnRRF+2NIZ44=;
 b=AH7BGClstvkuuUDFkD20svPedeIH7Cd9kCTifsXgNPUBqqBYGolel0aQ7uNbYK8cJJP6UvNUjL9xaeEUjVf/2/7CvFlYYOaL+xAzcSI84hC29gcceWoYzKGEg/UiR/cLtC0+tMYb7bA/CvlOaWOlgIqoczUHvqeq+MnXBCUb03c=
Received: from TY2PR01MB2169.jpnprd01.prod.outlook.com (52.133.183.150) by
 TY2PR01MB2297.jpnprd01.prod.outlook.com (52.133.184.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.25; Tue, 16 Oct 2018 14:58:16 +0000
Received: from TY2PR01MB2169.jpnprd01.prod.outlook.com
 ([fe80::495d:29aa:ec66:fc8c]) by TY2PR01MB2169.jpnprd01.prod.outlook.com
 ([fe80::495d:29aa:ec66:fc8c%2]) with mapi id 15.20.1228.027; Tue, 16 Oct 2018
 14:58:16 +0000
From:   IKEGAMI Tokunori <ikegami@allied-telesis.co.jp>
To:     Paul Burton <paul.burton@mips.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Marley <michael@michaelmarley.com>,
        PACKHAM Chris <chris.packham@alliedtelesis.co.nz>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: RE: [PATCH] Revert "MIPS: BCM47XX: Enable 74K Core ExternalSync for
 PCIe erratum"
Thread-Topic: [PATCH] Revert "MIPS: BCM47XX: Enable 74K Core ExternalSync for
 PCIe erratum"
Thread-Index: AQHUJc0L+/NUhmbC80GP6qNaNL6ZlaUicVvQ
Date:   Tue, 16 Oct 2018 14:58:15 +0000
Message-ID: <TY2PR01MB21698D32EE2305430D714090DCFE0@TY2PR01MB2169.jpnprd01.prod.outlook.com>
References: <20180727111339.17895-1-zajec5@gmail.com>
 <20180727171238.ybtoxddx2xulspu5@pburton-laptop>
In-Reply-To: <20180727171238.ybtoxddx2xulspu5@pburton-laptop>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [61.215.194.29]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY2PR01MB2297;20:2+XYLc/QDCN68v4ipkxgOSlLfBFaHC4ZQynSlOhQ6+199tCvVMdX75ArZ63cuLBdQMZyWzwCcrK1J0OMlNgsYmzeynDmUrhAfkrmkdFgT9l6fYpO6U0zcmcHuqrL1wiKXdHgDTLMNyd8BMVI+Yfus393ygSurlhIPZZOST92mMVC8F6MnIjsl+nznAvwQE0y6phDFKKdxyjLBFp9fWSwv693GcF+Roi1iPHKUBzboo45ihRs9by7IYmDnNq6pA6n
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0d8d01b1-dacf-440f-272c-08d63377cd70
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:TY2PR01MB2297;
x-ms-traffictypediagnostic: TY2PR01MB2297:
x-ld-processed: 1a8a37cf-9ecc-4cef-abb0-1ab01a15a6ad,ExtAddr
x-microsoft-antispam-prvs: <TY2PR01MB22977C3112DA340F55B81F0CDCFE0@TY2PR01MB2297.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:TY2PR01MB2297;BCL:0;PCL:0;RULEID:;SRVR:TY2PR01MB2297;
x-forefront-prvs: 0827D7ACB9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(13464003)(33656002)(6306002)(39060400002)(2900100001)(186003)(66574009)(102836004)(4326008)(81166006)(26005)(8676002)(97736004)(14454004)(81156014)(105586002)(106356001)(8936002)(9686003)(55016002)(229853002)(256004)(6436002)(68736007)(11346002)(446003)(16799955002)(74482002)(316002)(53936002)(476003)(486006)(99286004)(3846002)(6116002)(6246003)(14444005)(5250100002)(5660300001)(7696005)(66066001)(2906002)(71200400001)(110136005)(7736002)(54906003)(25786009)(74316002)(71190400001)(347745004)(478600001)(76176011)(305945005)(6506007)(966005)(86362001)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2PR01MB2297;H:TY2PR01MB2169.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: allied-telesis.co.jp does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: AZN7zLUSmX4o6vl1lxU88/kUVJb6qT35gur9zieMTjGVPo4H2hNzaM4+5o19bJKZcz6S3VTb5FHvm+DnAQ4Hfqv3wlYF5Bd6xAxQLPZcDOk6Kq06rNIwXODsXsyVPWBkta8PI7IiCAMxEMgvQfVz+tiWdp/AUIN7ufumLvzUFR1ViY1KK+D63pcdvNDOK6Dzt4wY7dlOs/+sYWgz55x7Afal0wo4S4sIzIigZNvl3OJWuNDEiXyp058d9r1F1jR5qYLHpfNN9xZcxBmLh2vd6/1H6HJDR8ZbRxG9Rag10dNWSu7yfiPi8y1ypfRWCuKN5oZ75hojyXF95ilW4MwG4DlEPYlrNDDlS/vazKcmv9E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: allied-telesis.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8d01b1-dacf-440f-272c-08d63377cd70
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2018 14:58:15.9517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1a8a37cf-9ecc-4cef-abb0-1ab01a15a6ad
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2297
Return-Path: <ikegami@allied-telesis.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66872
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

SGksDQoNCkkgYW0gdmVyeSBzb3JyeSBmb3IgdGhlIHByb2JsZW0gY2F1c2VkIGJ5IG15IHBhdGNo
Lg0KQW5kIHZlcnkgc29ycnkgZm9yIHRvbyBsYXRlIHRvIHJlcGx5IHRvIHRoZSBtYWlsIHNpbmNl
IEkgaGF2ZSBqdXN0IG5vdGljZWQgdGhpcyByZXZlcnQgdG9kYXkuLi4NCihUaGUgbWFpbCB3YXMg
YXV0b21hdGljYWxseSBzYXZlZCBpbnRvIGEgZm9sZGVyIHRvIGZpbHRlciBtYWlscyB1bmludGVu
dGlvbmFsbHkuLi4pDQpBbHNvIFRoYW5rIHlvdSBzbyBtdWNoIGZvciB5b3VyIGZpeCBieSByZXZl
cnRpbmcgdGhlIHBhdGNoLg0KDQo+IFRva3Vub3JpIC0gaWYgdGhpcyBicmVha3MgeW91ciBzeXN0
ZW0gdGhlbiB3ZSdsbCBuZWVkIHRvIGxvb2sgYXQNCj4gYXBwbHlpbmcgdGhlIHdvcmthcm91bmQg
bW9yZSBzZWxlY3RpdmVseS4NCg0KICBUaGFuayB5b3Ugc28gbXVjaC4NCiAgTm90ZWQgaXQuDQog
IEF0IHRoaXMgbW9tZW50IGl0IGlzIG5vdCBicm9rZW4gb24gb3VyIHN5c3RlbSBidXQgaWYgbmVl
ZGVkIEkgd2lsbCBkbyBpdC4NCg0KUmVnYXJkcywNCklrZWdhbWkNCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYXVsIEJ1cnRvbiBbbWFpbHRvOnBhdWwuYnVydG9uQG1p
cHMuY29tXQ0KPiBTZW50OiBTYXR1cmRheSwgSnVseSAyOCwgMjAxOCAyOjEzIEFNDQo+IFRvOiBS
YWZhxYIgTWnFgmVja2k7IElLRUdBTUkgVG9rdW5vcmkNCj4gQ2M6IEphbWVzIEhvZ2FuOyBSYWxm
IEJhZWNobGU7IE1pY2hhZWwgTWFybGV5OyBQQUNLSEFNIENocmlzOyBIYXVrZQ0KPiBNZWhydGVu
czsgbGludXgtbWlwc0BsaW51eC1taXBzLm9yZzsgUmFmYcWCIE1pxYJlY2tpDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0hdIFJldmVydCAiTUlQUzogQkNNNDdYWDogRW5hYmxlIDc0SyBDb3JlIEV4dGVy
bmFsU3luYw0KPiBmb3IgUENJZSBlcnJhdHVtIg0KPiANCj4gSGkgUmFmYcWCLA0KPiANCj4gT24g
RnJpLCBKdWwgMjcsIDIwMTggYXQgMDE6MTM6MzlQTSArMDIwMCwgUmFmYcWCIE1pxYJlY2tpIHdy
b3RlOg0KPiA+IEZyb206IFJhZmHFgiBNacWCZWNraSA8cmFmYWxAbWlsZWNraS5wbD4NCj4gPg0K
PiA+IFRoaXMgcmV2ZXJ0cyBjb21taXQgMmEwMjdiNDdkYmE2Yjc3YWI4YzhlNDdiNTg5YWU5YmJj
NWFjNjE3NS4NCj4gPg0KPiA+IEVuYWJsaW5nIEV4dGVybmFsU3luYyBjYXVzZWQgYSByZWdyZXNz
aW9uIGZvciBCQ000NzE4QTEgKHVzZWQgZS5nLiBpbg0KPiA+IE5ldGdlYXIgRTMwMDAgYW5kIEFT
VVMgUlQtTjE2KTogaXQgc2ltcGx5IGhhbmdzIGR1cmluZyBQQ0llDQo+ID4gaW5pdGlhbGl6YXRp
b24uIEl0J3MgbGlrZWx5IHRoYXQgQkNNNDcxN0ExIGlzIGFsc28gYWZmZWN0ZWQuDQo+ID4NCj4g
PiBJIGRpZG4ndCBub3RpY2UgdGhhdCBlYXJsaWVyIGFzIHRoZSBvbmx5IEJDTTQ3WFggZGV2aWNl
cyB3aXRoIFBDSWUgSQ0KPiA+IG93biBhcmU6DQo+ID4gMSkgQkNNNDcwNiB3aXRoIDIgeCAxNGU0
OjQzMzENCj4gPiAyKSBCQ000NzA2IHdpdGggMTRlNDo0MzYwIGFuZCAxNGU0OjQzMzENCj4gPiBp
dCBhcHBlYXJzIHRoYXQgQkNNNDcwNiBpcyB1bmFmZmVjdGVkLg0KPiA+DQo+ID4gV2hpbGUgQkNN
NTMwMFgtRVMzMDAtUkRTLnBkZiBzZWVtcyB0byBkb2N1bWVudCB0aGF0IGVycmF0dW0gYW5kIGl0
cw0KPiA+IHdvcmthcm91bmRzIChhY2NvcmRpbmcgdG8gcXVvdGVzIHByb3ZpZGVkIGJ5IFRva3Vu
b3JpKSBpdCBzZWVtcyBub3QgZXZlbg0KPiA+IEJyb2FkY29tIGZvbGxvd3MgdGhlbS4NCj4gPg0K
PiA+IEFjY29yZGluZyB0byB0aGUgcHJvdmlkZWQgaW5mbyBCcm9hZGNvbSBzaG91bGQgZGVmaW5l
IENPTkY3X0VTIGluIHRoZWlyDQo+ID4gU0RLJ3MgbWlwc2luYy5oIGFuZCBpbXBsZW1lbnQgd29y
a2Fyb3VuZCBpbiB0aGUgc2lfbWlwc19pbml0KCkuIENoZWNraW5nDQo+ID4gYm90aCBkaWRuJ3Qg
cmV2ZWFsIHN1Y2ggY29kZS4gSXQgKmNvdWxkKiBtZWFuIEJyb2FkY29tIGFsc28gaGFkIHNvbWUN
Cj4gPiBwcm9ibGVtcyB3aXRoIHRoZSBnaXZlbiB3b3JrYXJvdW5kLg0KPiA+DQo+ID4gUmVwb3J0
ZWQtYnk6IE1pY2hhZWwgTWFybGV5IDxtaWNoYWVsQG1pY2hhZWxtYXJsZXkuY29tPg0KPiA+IENj
OiBUb2t1bm9yaSBJa2VnYW1pIDxpa2VnYW1pQGFsbGllZC10ZWxlc2lzLmNvLmpwPg0KPiA+IENj
OiBQYXVsIEJ1cnRvbiA8cGF1bC5idXJ0b25AbWlwcy5jb20+DQo+ID4gQ2M6IEhhdWtlIE1laHJ0
ZW5zIDxoYXVrZUBoYXVrZS1tLmRlPg0KPiA+IENjOiBDaHJpcyBQYWNraGFtIDxjaHJpcy5wYWNr
aGFtQGFsbGllZHRlbGVzaXMuY28ubno+DQo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcN
Cj4gPiBDYzogSmFtZXMgSG9nYW4gPGpob2dhbkBrZXJuZWwub3JnPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFJhZmHFgiBNacWCZWNraSA8cmFmYWxAbWlsZWNraS5wbD4NCj4gPiAtLS0NCj4gPiBUaGlz
IGhhcyBiZWVuIHJlcG9ydGVkIGJ5IE1pY2hhZWwgYXMgT3BlbldydCBidWcgYXQ6DQo+ID4gaHR0
cHM6Ly9idWdzLm9wZW53cnQub3JnL2luZGV4LnBocD9kbz1kZXRhaWxzJnRhc2tfaWQ9MTY4OA0K
PiA+IC0tLQ0KPiA+ICBhcmNoL21pcHMvYmNtNDd4eC9zZXR1cC5jICAgICAgICB8IDYgLS0tLS0t
DQo+ID4gIGFyY2gvbWlwcy9pbmNsdWRlL2FzbS9taXBzcmVncy5oIHwgMyAtLS0NCj4gPiAgMiBm
aWxlcyBjaGFuZ2VkLCA5IGRlbGV0aW9ucygtKQ0KPiANCj4gVGhhbmtzIC0gSSd2ZSBhcHBsaWVk
IHRoaXMgdG8gbWlwcy1maXhlcywgYW5kIHdpbGwgc2VuZCB0byBMaW51cyBiZWZvcmUNCj4gdjQu
MTggZmluYWwgc28gdGhpcyByZWdyZXNzaW9uIHNob3VsZG4ndCBhcHBlYXIgaW4gYSBzdGFibGUg
a2VybmVsLg0KPiANCj4gVG9rdW5vcmkgLSBpZiB0aGlzIGJyZWFrcyB5b3VyIHN5c3RlbSB0aGVu
IHdlJ2xsIG5lZWQgdG8gbG9vayBhdA0KPiBhcHBseWluZyB0aGUgd29ya2Fyb3VuZCBtb3JlIHNl
bGVjdGl2ZWx5Lg0KPiANCj4gUGF1bA0K
