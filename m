Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Apr 2018 03:28:55 +0200 (CEST)
Received: from mail1.bemta8.messagelabs.com ([216.82.243.198]:50923 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990502AbeDYB2p2Ti5t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Apr 2018 03:28:45 +0200
Received: from [216.82.242.36] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta-8.messagelabs.com id 1D/D8-28268-BC9DFDA5; Wed, 25 Apr 2018 01:28:43 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSe0hTYRjG+845247m6mve3iwJR1FJs9l1f5S
  FBQ0rjCAiieqsTttsF9lZZUSQRaZOmWXLWqNMKjAMyVlpShcvpRWZ2kXF2MotzChCguiids7O
  up2/nvM+v+/9nvfjpUnFXWkCzebaWZuFMSmlkdSie05W9bjPl6UeL5mp8fsdMs3z95s0J9pHK
  E2p66RMU93BrpRoB0eHKG2D+7VM6wveIbW1Vwul2raqa8QGSZbEaNFZc3dIDEcCH4mc8pW5rp
  45h1H1iiIUSStwAYK8DwOoCEXQgA/CJ4+fEAzA4whaOr2ESJWR8MLnCf1Q2ElC3ycfJTqnCWg
  fcYcxP4LhMbdEaCbFi6Ex+IMSdAyeBQ2edpkAkfgBAq/3jFQwojEDrQ+awpAOHjX4ZKJOh7zq
  QKhO8YfH3j0MaTneCh99/aSgFfghgu++UD0Cp8HXG22hKRBOhLLbeYSgSRwP3WWVUnE6DJeaO
  klRx8L7wTGJyG+DJ7UF4RdIgjpHYZhPhO4LDiS+Rj0FQ053GFLBZ5eLFI2bCMpu1IRPJENBSS
  Ul6mVw/H5QJuo90OVoDDMZ4BnPD+uzJPh700uR2v1PWDeieT0Xam7PF8tJcMrxRuYOzT8FOs4
  GqApEXUWzOda2j7WpNCk6m1FvsJsZo0mVqtakmFmOY/SsidFxKTut5lrEr9EE/qtHLUdXNaOp
  NKGMlZcTvizFJJ111wEDwxm22/aaWK4ZTadpJcjn9fLeFBurZ3N3G038Lv62gY5SxsjrBFvO5
  TBmzqgXrUdoIT2QX1xM0oGe08WkgrJYLWxCvHyJgGIBNey1/Gn0e6+7UWJCtBzx0RRROazNbL
  T/7w+jeBopo+VxQpcoo8X+575hPgrBRymYOiBEsTN/rYTDyFmqWV+6xrN8qety37yiWyPZaR3
  HXFLv+dgr2aq+ZzOj12TUvikfuXioYvbmquOjp3QZa+uqvr8sPPb1pndF1tOaYNKAHjJXrxub
  rB79Mtmr3LJo2uW4xqqNeOKZ5JxW6zsv29kVwAvP1x/dOqO9Yvzn/gVF9W9fUcu+ZaZGnet3X
  lcrKc7ApCaTNo75BTEcAT7SAwAA
X-Env-Sender: ikegami@allied-telesis.co.jp
X-Msg-Ref: server-16.tower-94.messagelabs.com!1524619722!193432009!1
X-Originating-IP: [52.192.143.101]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 144213 invoked from network); 25 Apr 2018 01:28:43 -0000
Received: from mo.allied-telesis-co-jp.hdemail.jp (HELO mo.allied-telesis-co-jp.hdemail.jp) (52.192.143.101)
  by server-16.tower-94.messagelabs.com with SMTP; 25 Apr 2018 01:28:43 -0000
Received: by mo.allied-telesis-co-jp.hdemail.jp (hde-mf-postfix, from userid 504)
        id 70189294002; Wed, 25 Apr 2018 10:28:42 +0900 (JST)
X-Received: from unknown (HELO mo.allied-telesis-co-jp.hdemail.jp) (127.0.0.1)
  by 0 with SMTP; 25 Apr 2018 10:28:42 +0900
X-Received: from mo.allied-telesis-co-jp.hdemail.jp (localhost.localdomain [127.0.0.1])
        by mo.allied-telesis-co-jp.hdemail.jp (hde-ma-postfix) with ESMTP id 1C79E1AC001;
        Wed, 25 Apr 2018 10:28:42 +0900 (JST)
        (envelope-from ikegami@allied-telesis.co.jp)
Received: from JPN01-TY1-obe.outbound.protection.outlook.com (mail-ty1jpn01lp0177.outbound.protection.outlook.com [23.103.139.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mo.allied-telesis-co-jp.hdemail.jp (hde-mf-postfix) with ESMTPS id 15BD2294001;
        Wed, 25 Apr 2018 10:28:42 +0900 (JST)
        (envelope-from ikegami@allied-telesis.co.jp)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atjp.onmicrosoft.com;
 s=selector1-alliedtelesis-co-jp01e;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3tvQcIe0zb7HvvhBhHSldQf7B2SNwTvTYDOWPvoWVRY=;
 b=Q2dzr0tDmPMpGA1fg+u838omB+a1KFenbwsAOt8/gWSAs97oAIS8iSBCxBwcrvLGInmAisR2B6PnrE0Oi7SZeFwlFtybzpuN1s61gophuWrw2aWjsd1TI2ssC56zt5XUFGZApU1nHBoCQt51GDYRmQcES9fw18mgk49cBB6R6hI=
Received: from TY1PR01MB0954.jpnprd01.prod.outlook.com (10.167.157.141) by
 TY1PR01MB1484.jpnprd01.prod.outlook.com (52.133.161.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.696.13; Wed, 25 Apr 2018 01:28:40 +0000
Received: from TY1PR01MB0954.jpnprd01.prod.outlook.com
 ([fe80::495f:2227:40ea:9f08]) by TY1PR01MB0954.jpnprd01.prod.outlook.com
 ([fe80::495f:2227:40ea:9f08%13]) with mapi id 15.20.0696.019; Wed, 25 Apr
 2018 01:28:39 +0000
From:   IKEGAMI Tokunori <ikegami@allied-telesis.co.jp>
To:     Hauke Mehrtens <hauke@hauke-m.de>
CC:     James Hogan <jhogan@kernel.org>,
        PACKHAM Chris <chris.packham@alliedtelesis.co.nz>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH] MIPS: BCM47XX: Enable MIPS32 74K Core ExternalSync for
 BCM47XX PCIe erratum
Thread-Topic: [PATCH] MIPS: BCM47XX: Enable MIPS32 74K Core ExternalSync for
 BCM47XX PCIe erratum
Thread-Index: AdPbnW6Ya94HI7S/R6SR34cQ5ieoegAY8HeAAAT8u4AABTKsIA==
Date:   Wed, 25 Apr 2018 01:28:39 +0000
Message-ID: <TY1PR01MB0954ACCE99F0985569BDCEE6DC8F0@TY1PR01MB0954.jpnprd01.prod.outlook.com>
References: <TY1PR01MB0954C80E15BA87D03E3A6880DC880@TY1PR01MB0954.jpnprd01.prod.outlook.com>
 <20180424191939.16082-1-smtpuser@allied-telesis.co.jp>
 <95d854d4-e24b-e10f-679d-25e047f02cb9@hauke-m.de>
In-Reply-To: <95d854d4-e24b-e10f-679d-25e047f02cb9@hauke-m.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [61.215.194.29]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1484;7:H/U8kys+EWB6Ywy9zxGOyRVpTU5iTLaHo4NkI6EoWWYF/fIwjwWiRz8ViatqzrCi6nJffcIHM5iZT0fAdTtmcycMdfy7UxZzrqaRX04ajHeNoUgNtFZm7sRh+CbtngNV82dggm3KaWpAdz/w1uPwNrNQQ1gk7GYa/HCOQO1LEtGrxVzfpmCpJJHUcPCcIvOEFUfKhAXdbYGFv5F94H5PNocpvXf+FIVkHTHkcKiXoBctsKz/ruysKMteWUOmwv73;20:vCY6LeaHzstqeSqNtTetDG8zdGUy8tKKp6MhFnc/z3bgbXcgntRblhTO3laIOVkfUl8XthNV7CCWF3CTVf2YNPMg1wvT34N0hIC17F5/VBaOZZ0/BVSeFshHu57nX/G7jemeXP6fxICzbs4+N42bcoFuCvez85UK12vzPiD5CBB0biXLMvFEEbwLbQ/PGqexxnpnL0aiGkQMHazoFc0TarpHaZ26UmZUmLpDRHMLDbHF2k0USkhuTHu0SuxXxzu1
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1484;
x-ms-traffictypediagnostic: TY1PR01MB1484:
x-ld-processed: 1a8a37cf-9ecc-4cef-abb0-1ab01a15a6ad,ExtAddr
x-microsoft-antispam-prvs: <TY1PR01MB1484EA73B3110F390FABFEE6DC8F0@TY1PR01MB1484.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(84791874153150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231232)(944501410)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:TY1PR01MB1484;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1484;
x-forefront-prvs: 06530126A4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(39850400004)(346002)(39380400002)(189003)(13464003)(199004)(51444003)(50944005)(74482002)(8936002)(33656002)(8676002)(25786009)(6306002)(54906003)(6436002)(551934003)(3660700001)(81166006)(66066001)(81156014)(102836004)(316002)(9686003)(6116002)(3846002)(6916009)(14454004)(39060400002)(305945005)(74316002)(2906002)(478600001)(97736004)(26005)(55016002)(99286004)(966005)(2900100001)(186003)(3280700002)(53936002)(229853002)(4326008)(11346002)(446003)(86362001)(59450400001)(5250100002)(7696005)(476003)(5660300001)(486006)(76176011)(7736002)(6506007)(53546011)(6246003)(68736007)(105586002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1484;H:TY1PR01MB0954.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: allied-telesis.co.jp does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: lLx30OtpuetAtnj4kYAXokVVRT6uWKA15joVjjCsdLsQKgwgFB7BPTwUNobWfggpIYd3voxH/azzQFRY4gHpfFZGTEwwLEfMsJerYfJbaArVWTPSOPJTqDUl8/VGZAUicbyH2HOmf34qK5GVqkrKc05vyDiX3hJFD9ZVLGRqvq/q2vYmVG0w0OPmjxvXc+37
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d78b53ad-610e-464b-7720-08d5aa4bdff6
X-OriginatorOrg: allied-telesis.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d78b53ad-610e-464b-7720-08d5aa4bdff6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2018 01:28:39.8440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1a8a37cf-9ecc-4cef-abb0-1ab01a15a6ad
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1484
Return-Path: <ikegami@allied-telesis.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63739
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGF1a2UgTWVocnRlbnMg
W21haWx0bzpoYXVrZUBoYXVrZS1tLmRlXQ0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDI1LCAy
MDE4IDY6NDIgQU0NCj4gVG86IElLRUdBTUkgVG9rdW5vcmkNCj4gQ2M6IEphbWVzIEhvZ2FuOyBQ
QUNLSEFNIENocmlzOyBSYWZhxYIgTWnFgmVja2k7IGxpbnV4LW1pcHNAbGludXgtbWlwcy5vcmcN
Cj4gU3ViamVjdDogUmU6IFtQQVRDSF0gTUlQUzogQkNNNDdYWDogRW5hYmxlIE1JUFMzMiA3NEsg
Q29yZSBFeHRlcm5hbFN5bmMNCj4gZm9yIEJDTTQ3WFggUENJZSBlcnJhdHVtDQo+IA0KPiBPbiAw
NC8yNC8yMDE4IDA5OjE5IFBNLCBzbXRwdXNlciB3cm90ZToNCj4gPiBGcm9tOiBUb2t1bm9yaSBJ
a2VnYW1pIDxpa2VnYW1pQGFsbGllZC10ZWxlc2lzLmNvLmpwPg0KPiA+DQo+ID4gVGhlIGVycmF0
dW0gYW5kIHdvcmthcm91bmQgYXJlIGRlc2NyaWJlZCBieSBCQ001MzAwWC1FUzMwMC1SRFMucGRm
IGFzDQo+IGJlbG93Lg0KPiA+DQo+ID4gICBSMTA6IFBDSWUgVHJhbnNhY3Rpb25zIFBlcmlvZGlj
YWxseSBGYWlsDQo+ID4NCj4gPiAgICAgRGVzY3JpcHRpb246IFRoZSBCQ001MzAwWCBQQ0llIGRv
ZXMgbm90IG1haW50YWluIHRyYW5zYWN0aW9uDQo+IG9yZGVyaW5nLg0KPiA+ICAgICAgICAgICAg
ICAgICAgVGhpcyBtYXkgY2F1c2UgUENJZSB0cmFuc2FjdGlvbiBmYWlsdXJlLg0KPiA+ICAgICBG
aXggQ29tbWVudDogQWRkIGEgZHVtbXkgUENJZSBjb25maWd1cmF0aW9uIHJlYWQgYWZ0ZXIgYSBQ
Q0llDQo+ID4gICAgICAgICAgICAgICAgICBjb25maWd1cmF0aW9uIHdyaXRlIHRvIGVuc3VyZSBQ
Q0llIGNvbmZpZ3VyYXRpb24NCj4gYWNjZXNzDQo+ID4gICAgICAgICAgICAgICAgICBvcmRlcmlu
Zy4gU2V0IEVTIGJpdCBvZiBDUDAgY29uZmlndTcgcmVnaXN0ZXIgdG8gZW5hYmxlDQo+ID4gICAg
ICAgICAgICAgICAgICBzeW5jIGZ1bmN0aW9uIHNvIHRoYXQgdGhlIHN5bmMgaW5zdHJ1Y3Rpb24g
aXMNCj4gZnVuY3Rpb25hbC4NCj4gPiAgICAgUmVzb2x1dGlvbjogIGhuZHBjaS5jOiBleHRwY2lf
d3JpdGVfY29uZmlnKCkNCj4gPiAgICAgICAgICAgICAgICAgIGhuZG1pcHMuYzogc2lfbWlwc19p
bml0KCkNCj4gPiAgICAgICAgICAgICAgICAgIG1pcHNpbmMuaCBDT05GN19FUw0KPiA+DQo+ID4g
VGhpcyBpcyBmaXhlZCBieSB0aGUgQ0ZFIE1JUFMgYmNtc2kgY2hpcHNldCBkcml2ZXIgYWxzbyBm
b3IgQkNNNDdYWC4NCj4gPiBBbHNvIHRoZSBkdW1teSBQQ0llIGNvbmZpZ3VyYXRpb24gcmVhZCBp
cyBhbHJlYWR5IGltcGxlbWVudGVkIGluIHRoZSBMaW51eA0KPiA+IEJDTUEgZHJpdmVyLg0KPiA+
IEVuYWJsZSBFeHRlcm5hbFN5bmMgaW4gQ29uZmlnNyB3aGVuIENPTkZJR19CQ01BX0RSSVZFUl9Q
Q0lfSE9TVE1PREU9eQ0KPiA+IHRvbyBzbyB0aGF0IHRoZSBzeW5jIGluc3RydWN0aW9uIGlzIGV4
dGVybmFsaXNlZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRva3Vub3JpIElrZWdhbWkgPGlr
ZWdhbWlAYWxsaWVkLXRlbGVzaXMuY28uanA+DQo+ID4gQ2M6IENocmlzIFBhY2toYW0gPGNocmlz
LnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4NCj4gPiBDYzogSGF1a2UgTWVocnRlbnMgPGhh
dWtlQGhhdWtlLW0uZGU+DQo+ID4gQ2M6IFJhZmHFgiBNacWCZWNraSA8emFqZWM1QGdtYWlsLmNv
bT4NCj4gPiBDYzogbGludXgtbWlwc0BsaW51eC1taXBzLm9yZw0KPiA+IC0tLQ0KPiA+IEkgaGF2
ZSBqdXN0IGZpeGVkIHlvdXIgY29tbWVudHMuDQo+ID4gVGhpcyBwYXRjaCB3aWxsIGJlIHNlbnQg
YnkgZ2l0LXNlbmQtZW1haWwuDQo+ID4gQWxzbyBmb3Igb3VyIGNvbXBhbnkgbWFpbCBzeXN0ZW0g
dGhlIHNlbmRlciBtYWlsIGFkZHJlc3MgaXMgbmVlZGVkIHRvDQo+IGJlIHNldCBhcyBzbXRwdXNl
ciA8c210cHVzZXJAYWxsaWVkLXRlbGVzaXMuY28uanA+Lg0KPiA+IEJ1dCBkbyBub3QgcmVwbHkg
dG8gdGhlIGVtYWlsIGFkZHJlc3Mgc210cHVzZXINCj4gPHNtdHB1c2VyQGFsbGllZC10ZWxlc2lz
LmNvLmpwPi4NCj4gPiBQbGVhc2UgcmVwbHkgdG8gbXkgZW1haWwgYWRkcmVzcyBpZiBhbnkgY29t
ZW1udCBvciBwcm9ibGVtLg0KPiA+IFNvcnJ5IGZvciBpbmNvbnZpbmllbnQgYWJvdXQgdGhpcy4N
Cj4gDQo+IERvZXMgdGhlIENGRSBib290IGxvYWRlciBub3JtYWxseSBhcHBseSB0aGlzIHdvcmth
cm91bmQ/IEFsbCBkZXZpY2VzIEkNCj4gaGF2ZSB3aXRoIHRoaXMgU29DIHVzZSBDRkUgdG8gYm9v
dCBMaW51eCBhbmQgSSBhbSB3b25kZXJpbmcgd2h5ICJvbmx5Ig0KPiB0aGUgd29ya2Fyb3VuZCBp
biB0aGUgZHJpdmVyIGhlbHBlZCB0byB3b3JrYXJvdW5kIHRoaXMgcHJvYmxlbS4NCj4gDQo+IE5v
dCBhbGwgQnJvYWRjb20gTUlQUyBTb0NzIGZyb20gdGhlIEJSQ000N3h4IGxpbmUgd2l0aCBNSVBT
IDc0SyBDUFVzIGFyZQ0KPiBhZmZlY3RlZC4NCj4gDQo+IFNlZSBoZXJlLCB3ZSBvbmx5IGFwcGx5
IHRoaXMgZm9yIHRoZSBCQ000NzE2IFNvQ3M6DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvbGlu
dXMvMjVjMTU1NjY2MzVmZWY4NmU4N2Y3NjJmNzNhMTlmMjQ1OThlNDVmYQ0KPiANCj4gSGVyZSB0
aGUgYnJjbXNtYWMgZHJpdmVyIHByb3ZpZGVkIGJ5IEJyb2FkY29tLCBpdCBzYXlzIHRoYXQgb25s
eSBCQ000NzE2DQo+IGFuZCBCQ000NzA2IGFyZSBhZmZlY3RlZDoNCj4gaHR0cHM6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZQ0K
PiBlL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9icmNtc21hYy90eXBl
cy5oI24yNTUNCj4gDQo+IEkgYW0gbm90IHN1cmUgaWYgdGhlIHZlcnNpb24gb2YgdGhlIGJjbTQ3
MDYgd2hpY2ggaXMgdXNlZCBvbiBtb3N0DQo+IGRldmljZXMgaXMgYWZmZWN0ZWQgYXMgdGhpcyB3
b3JrYXJvdW5kIGlzIG5vdCBhcHBsaWVkIGZvciB0aGlzIFNvQyBpbg0KPiBiNDMsIGNvdWxkIGJl
IHRoYXQgQnJvYWRjb20gZml4ZWQgdGhhdCBpbiBhIGxhdGVyIHJldmlzaW9uIGFuZCB0aGUNCj4g
YnJva2VuIHJldmlzaW9uIG5ldmVyIG1hZGUgaXQgaW50byBtYXNzIHByb2R1Y3Rpb24uDQoNClRo
YW5rIHlvdSBzbyBtdWNoIGZvciB5b3VyIGNvbW1lbnRzLg0KVGhlIENGRSBpcyBpbXBsZW1lbnRl
ZCB0byBlbmFibGUgdGhlIEV4dGVybmFsU3luYyBvbiB0aGUgYmNtc2kgY2hpcCBzZXQgdGhvc2Ug
YXJlIGRlZmluZWQgYXMgbWlwczc0ayBDUFUgYWxzby4NCkFsc28gZm9yIG90aGVyIGJvYXJkcyBm
b3IgZXhhbXBsZSBiY205NDcwNGNwY2kgdGhhdCBJIHRoaW5rIHRoYXQgdGhpcyBpcyBmb3IgQkNN
NDcwNCB0aGUgQ1BVIGlzIGRlZmluZWQgYXMgYmNtY29yZSwgc2IxMjUwIG9yIG1wYzgyNDUgYnV0
IG5vdCBkZWZpbmVkIGFzIG1pcHM3NGsuDQpJIGhhdmUganVzdCBjb25maXJtZWQgdGhhdCBCQ001
MzU3eCBmYW1pbHkgdXNlcyBBUk0gQ1BVIHNvIGl0IHNlZW1zIG5vIHByb2JsZW0uDQpJIGFtIG5v
dCBzdXJlIGlmIHRoZXJlIGlzIGFueSBvdGhlciBNSVBTIDc0SyBDUFUgZW5hYmxlZCBDT05GSUdf
QkNNQV9EUklWRVJfUENJX0hPU1RNT0RFIG9wdGlvbi4NCkJ1dCBpZiBuZWVkZWQgdG8gbWFrZSBz
dXJlIEkgY2FuIGNoYW5nZSB0byB1c2UgQ09ORklHX0JDTTQ3WFggZm9yIHRoZSBjaGFuZ2UgaW5z
dGVhZCBvZiBDT05GSUdfQkNNQV9EUklWRVJfUENJX0hPU1RNT0RFLg0KU28gcGxlYXNlIGxldCBt
ZSBrbm93IGlmIG5lZWRlZCB0byBjaGFuZ2UuDQogIE5vdGU6IEZvciBvdXIgQkNNNTMwMDMgQ1BV
IGlmIHBvc3NpYmxlIHdlIHdvdWxkIGxpa2UgdG8gdXNlIENPTkZJR19CQ01BX0RSSVZFUl9QQ0lf
SE9TVE1PREUgYXMgY3VycmVudCBwYXRjaC4NCg0KPiBEbyB5b3Ugc2VzIHRoZSBwcm9ibGVtIG9u
IHRoZSBCQ001MzAwMSBJIHRoaW5rIHRoaXMgaXMgdGhlIHNhbWUgc2lsaWNvbg0KPiBhcyB0aGUg
YmNtNDcwNj8NCg0KWWVzIHdlIGFyZSB1c2luZyBCQ001MzAwMyBhbmQgdGhlIEJDTTUzMDAzIGNo
aXAgSUQgaXMgc2FtZSB3aXRoIEJDTTQ3MDYuDQpTbyBpdCBsb29rcyB0aGF0IHRoZSBCQ001MzAw
MSBpcyBhbHNvIHNhbWUuDQpBdCB0aGlzIG1vbWVudCBJIGNvdWxkIG5vdCBjb25maXJtIHRoZSBh
Y3R1YWwgZXJyYXR1bSBlcnJvciBiZWhhdmlvci4NCg0KPiA+ICBhcmNoL21pcHMvaW5jbHVkZS9h
c20vbWlwc3JlZ3MuaCB8ICAzICsrKw0KPiA+ICBhcmNoL21pcHMva2VybmVsL2NwdS1wcm9iZS5j
ICAgICB8IDEyICsrKysrKysrKysrLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL21pcHMvaW5j
bHVkZS9hc20vbWlwc3JlZ3MuaA0KPiBiL2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9taXBzcmVncy5o
DQo+ID4gaW5kZXggODU4NzUyZGFjMzM3Li4wZjk0YWNmNjAxNDQgMTAwNjQ0DQo+ID4gLS0tIGEv
YXJjaC9taXBzL2luY2x1ZGUvYXNtL21pcHNyZWdzLmgNCj4gPiArKysgYi9hcmNoL21pcHMvaW5j
bHVkZS9hc20vbWlwc3JlZ3MuaA0KPiA+IEBAIC02ODAsNiArNjgwLDggQEANCj4gPiAgI2RlZmlu
ZSBNSVBTX0NPTkY3X1dJSQkJKF9VTENBU1RfKDEpIDw8IDMxKQ0KPiA+DQo+ID4gICNkZWZpbmUg
TUlQU19DT05GN19SUFMJCShfVUxDQVNUXygxKSA8PCAyKQ0KPiA+ICsvKiBFeHRlcm5hbFN5bmMg
Ki8NCj4gPiArI2RlZmluZSBNSVBTX0NPTkY3X0VTCQkoX1VMQ0FTVF8oMSkgPDwgOCkNCj4gPg0K
PiA+ICAjZGVmaW5lIE1JUFNfQ09ORjdfSUFSCQkoX1VMQ0FTVF8oMSkgPDwgMTApDQo+ID4gICNk
ZWZpbmUgTUlQU19DT05GN19BUgkJKF9VTENBU1RfKDEpIDw8IDE2KQ0KPiA+IEBAIC0yNzU5LDYg
KzI3NjEsNyBAQCBfX0JVSUxEX1NFVF9DMChzdGF0dXMpDQo+ID4gIF9fQlVJTERfU0VUX0MwKGNh
dXNlKQ0KPiA+ICBfX0JVSUxEX1NFVF9DMChjb25maWcpDQo+ID4gIF9fQlVJTERfU0VUX0MwKGNv
bmZpZzUpDQo+ID4gK19fQlVJTERfU0VUX0MwKGNvbmZpZzcpDQo+ID4gIF9fQlVJTERfU0VUX0Mw
KGludGNvbnRyb2wpDQo+ID4gIF9fQlVJTERfU0VUX0MwKGludGN0bCkNCj4gPiAgX19CVUlMRF9T
RVRfQzAoc3JzbWFwKQ0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL21pcHMva2VybmVsL2NwdS1wcm9i
ZS5jDQo+IGIvYXJjaC9taXBzL2tlcm5lbC9jcHUtcHJvYmUuYw0KPiA+IGluZGV4IGNmM2ZkNTQ5
ZTE2ZC4uNzUwMzllODk2OTRmIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvbWlwcy9rZXJuZWwvY3B1
LXByb2JlLmMNCj4gPiArKysgYi9hcmNoL21pcHMva2VybmVsL2NwdS1wcm9iZS5jDQo+ID4gQEAg
LTQyNyw4ICs0MjcsMTggQEAgc3RhdGljIGlubGluZSB2b2lkIGNoZWNrX2VycmF0YSh2b2lkKQ0K
PiA+ICAJCSAqIG1ha2luZyB1c2Ugb2YgVlBFMSB3aWxsIGJlIHJlc3BvbnNhYmxlIGZvciB0aGF0
IFZQRS4NCj4gPiAgCQkgKi8NCj4gPiAgCQlpZiAoKGMtPnByb2Nlc3Nvcl9pZCAmIFBSSURfUkVW
X01BU0spIDw9DQo+IFBSSURfUkVWXzM0S19WMV8wXzIpDQo+ID4gLQkJCXdyaXRlX2MwX2NvbmZp
ZzcocmVhZF9jMF9jb25maWc3KCkgfA0KPiBNSVBTX0NPTkY3X1JQUyk7DQo+ID4gKwkJCXNldF9j
MF9jb25maWc3KE1JUFNfQ09ORjdfUlBTKTsNCj4gPiAgCQlicmVhazsNCj4gPiArI2lmZGVmIENP
TkZJR19CQ01BX0RSSVZFUl9QQ0lfSE9TVE1PREUNCj4gPiArCWNhc2UgQ1BVXzc0SzoNCj4gPiAr
CQkvKg0KPiA+ICsJCSAqIEJDTTQ3WFggRXJyYXR1bSAiUjEwOiBQQ0llIFRyYW5zYWN0aW9ucyBQ
ZXJpb2RpY2FsbHkNCj4gRmFpbCINCj4gPiArCQkgKiBFbmFibGUgRXh0ZXJuYWxTeW5jIGZvciBz
eW5jIGluc3RydWN0aW9uIHRvIHRha2UgZWZmZWN0DQo+ID4gKwkJICovDQo+ID4gKwkJcHJfaW5m
bygiRXh0ZXJuYWxTeW5jIGhhcyBiZWVuIGVuYWJsZWRcbiIpOw0KPiA+ICsJCXNldF9jMF9jb25m
aWc3KE1JUFNfQ09ORjdfRVMpOw0KPiA+ICsJCWJyZWFrOw0KPiA+ICsjZW5kaWYNCj4gPiAgCWRl
ZmF1bHQ6DQo+ID4gIAkJYnJlYWs7DQo+ID4gIAl9DQo+ID4NCg0K
