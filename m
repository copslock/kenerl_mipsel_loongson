Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 May 2018 02:35:06 +0200 (CEST)
Received: from mail1.bemta8.messagelabs.com ([216.82.243.203]:25737 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992735AbeE1Ae6kKIel (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 May 2018 02:34:58 +0200
Received: from [216.82.242.36] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-11.bemta-8.messagelabs.com id E8/FF-30468-1BE4B0B5; Mon, 28 May 2018 00:34:57 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSfUgTcRjH/e1ud1e5uqbhk2XgqKiRS8tgkZF
  QxDCMSIrISm95baNt2m6GIb36kjatlq5sWEaYkVrWelMnZvaCWlBZ9l4aaflWhFGmketuN3u5
  v77P7/O97/P8fjwUJr9FBFNsmpW1mBmjghiLRzYcYsMurhwXH37LrVR3dNhI9ZOeNWp70wCuP
  uw4Qqorm9loqeb9r25cU+N8Q2rau+oxjas8l9DcOXdeskq6Xmowa5PTEqX6/gdvpCn2FWn2h8
  34HlQYcwCNpeR0DoLG2h50AI2hgE4Hp+uaRABAexC4npeQoqsAgw+fv+NCgdMVGNTUOwiROCR
  w0ZMjEYu3CO4XtkqEMIJeAO6un7igA+kZUFPc5M3C6LsILl8uIgQQQDNw+26dz6SFlpp2UtTL
  4dtwm1TQOP/z0JNMr0dGb4DB1wcxsVsTgoaBUm83RIdAQe1er8boIGgtOE2IV6KhtO4BJupJ0
  PN+RCr6N8F9V47v2qFwxZbr84dAa4kNiU9QjcOhq58kIgiDLw4HJoJrCKoGBnERKOHpx0xfUh
  Tsv9lFinorPM144escA8WebF+HaVCe/w4Xg1wY7PucRRxG4c5/Jnciitezoap2rngcCoW2d6T
  T+wITofl4J34K4eVoFsdatrOWsIhwldZi0OmtJsZg5Cu1ysRyHKNjjYyWU21ONrkQv0p+/FeN
  qrKWNqLJlEQxSaa2U/Hy8drkpB16htMnWFKNLNeIplKUAmRXY8fFyydaWB2btsVg5PdxFAPlr
  wiU2QQs41IYE2fQiagFzadeZ+flYVTn46N5mBw3J5vZ4CBZjGClBas+1fwnaHS3W1FIcIAM8a
  PJ/VNYi8lg/Z/3oiAKKQJkz4QUf4PZ+qdfLz+KhB/lQgUpjGJl/qLgPWj3zLXZJ1+V6IaiI9r
  PDxDzlPNbppedcPc1tyUEnO3bG3N9x5wp0SO4p46LvO7Xtm3n4o3Ozq0fyNWe7kdLdoWk3igK
  JKN3X1oW+XXMS9uE/HVQeS42ruTYrJy++oXdSdgie1zZkLsspbRjAjoT+kOVnq+8ZzVEbajO6
  B/2S5zTa9YocE7PRCgxC8f8BoBw3KLWAwAA
X-Env-Sender: ikegami@allied-telesis.co.jp
X-Msg-Ref: server-16.tower-94.messagelabs.com!1527467695!188263252!1
X-Originating-IP: [52.192.143.101]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 76002 invoked from network); 28 May 2018 00:34:56 -0000
Received: from mo.allied-telesis-co-jp.hdemail.jp (HELO mo.allied-telesis-co-jp.hdemail.jp) (52.192.143.101)
  by server-16.tower-94.messagelabs.com with SMTP; 28 May 2018 00:34:56 -0000
Received: by mo.allied-telesis-co-jp.hdemail.jp (hde-mf-postfix, from userid 504)
        id 60126294002; Mon, 28 May 2018 09:34:55 +0900 (JST)
X-Received: from unknown (HELO mo.allied-telesis-co-jp.hdemail.jp) (127.0.0.1)
  by 0 with SMTP; 28 May 2018 09:34:55 +0900
X-Received: from mo.allied-telesis-co-jp.hdemail.jp (localhost.localdomain [127.0.0.1])
        by mo.allied-telesis-co-jp.hdemail.jp (hde-ma-postfix) with ESMTP id 0B8551AC001;
        Mon, 28 May 2018 09:34:55 +0900 (JST)
        (envelope-from ikegami@allied-telesis.co.jp)
Received: from JPN01-TY1-obe.outbound.protection.outlook.com (mail-ty1jpn01lp0178.outbound.protection.outlook.com [23.103.139.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mo.allied-telesis-co-jp.hdemail.jp (hde-mf-postfix) with ESMTPS id 03924294001;
        Mon, 28 May 2018 09:34:55 +0900 (JST)
        (envelope-from ikegami@allied-telesis.co.jp)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atjp.onmicrosoft.com;
 s=selector1-alliedtelesis-co-jp01e;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Vip+4Vj4BEuexQk5Hjwp4tEe4yUhn/OdEQsy40N6pM=;
 b=UlhCWXz/Eksh1CH1I8SSFIHDqZBOE3lC08eGV41BOBeoCh/61zY/TcVsd4JeEkSZj3JUn3M8OKkxwM1uKHZWceRe8O313rT7LxVlZwbwta7vLUEpCGuod6JCTw/WLHhlurVeUwNxSZAh4BF8F2aYDy1BVjJ073CvdObVk3bUy2o=
Received: from TY1PR01MB0954.jpnprd01.prod.outlook.com (10.167.157.141) by
 TY1PR01MB1230.jpnprd01.prod.outlook.com (10.174.226.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.797.11; Mon, 28 May 2018 00:34:54 +0000
Received: from TY1PR01MB0954.jpnprd01.prod.outlook.com
 ([fe80::6033:a971:9df0:62c]) by TY1PR01MB0954.jpnprd01.prod.outlook.com
 ([fe80::6033:a971:9df0:62c%13]) with mapi id 15.20.0797.017; Mon, 28 May 2018
 00:34:53 +0000
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
Thread-Index: AdPbnW6Ya94HI7S/R6SR34cQ5ieoegAY8HeAAAT8u4AABTKsIAZ8IH8Q
Date:   Mon, 28 May 2018 00:34:53 +0000
Message-ID: <TY1PR01MB0954C329C82FFB8E28BF3A9EDC6E0@TY1PR01MB0954.jpnprd01.prod.outlook.com>
References: <TY1PR01MB0954C80E15BA87D03E3A6880DC880@TY1PR01MB0954.jpnprd01.prod.outlook.com>
 <20180424191939.16082-1-smtpuser@allied-telesis.co.jp>
 <95d854d4-e24b-e10f-679d-25e047f02cb9@hauke-m.de> 
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [61.215.194.29]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1230;7:Ul3Xrk+Psq+n2mv+jlWqkvJgyLqWdyIYc2h4e6aohXOcdYaXnvy7a3/bJ6g6oy5syqEy+KkY7vgIBGVKgW6+wbJNHvW/mSeG+vvfgtHtaQ1XAdixDSpUxCpwdwwzb3iUxRBhdZz8BUbLx26JIQOr87mMF7jEk64bA02PeHL4Cp+QDRW1QZR4BMLvXFrp4vZowJ54/p8z3LSMx7O69Fnup6IiN5pJ8NSr74BAKgs8losHf1iUw0MZDX2GNy7oVkRh;20:T5/xVh29h0ptORLIkxRrxUBvqphZuRSyaNvdl5j7y5Ml3OAR2X8PGuGI6EDzliAa1k7KcA8WbBDG2Jc4vNB2t+CHLB3/xB58uA6QlNGSXSnR9hQBKPLUCm6S3RuRcuFYAs+DxntOfJ5AwkRpbTxGd8JCIiyEeBqQicgTpGsg6OrCNmUwVXRhiK1+CQVE6DdPzxHmrGFHeSIXVWpCCX4IMUU2tlPe2OKa8PEJQuxQDNbMNdhuskzHsl7CTbePSc0S
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1230;
x-ms-traffictypediagnostic: TY1PR01MB1230:
x-ld-processed: 1a8a37cf-9ecc-4cef-abb0-1ab01a15a6ad,ExtAddr
x-microsoft-antispam-prvs: <TY1PR01MB1230A6AAB7EDA0E4E8FFAF34DC6E0@TY1PR01MB1230.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:TY1PR01MB1230;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1230;
x-forefront-prvs: 06860EDC7B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(366004)(39840400004)(39380400002)(51444003)(13464003)(189003)(199004)(50944005)(476003)(74316002)(3280700002)(3846002)(9686003)(966005)(54906003)(486006)(6116002)(53936002)(7736002)(446003)(33656002)(97736004)(3660700001)(2906002)(4326008)(6916009)(186003)(53546011)(102836004)(55016002)(76176011)(86362001)(8936002)(5250100002)(6436002)(68736007)(6506007)(551934003)(26005)(6306002)(59450400001)(6246003)(81166006)(8676002)(81156014)(7696005)(105586002)(5660300001)(106356001)(66066001)(305945005)(39060400002)(478600001)(2900100001)(316002)(99286004)(229853002)(74482002)(25786009)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1230;H:TY1PR01MB0954.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: allied-telesis.co.jp does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: DzCQgRuG7UB2KExq07ZrAIjBIY1N0jennnZ4GZhPZaMlrfv/YoqkbzQwnPN/whsG8tX/H82xkNpoG/sKmZgKr20NySP+qP+pQJ3gwLMl+pVFYrXtPKxTSN0n/OEZtvyaWEDFjYhVnQv1gvyBIoshrIdZVRXsyQePJ/5XgRLVkLih2aw5tDfxgfke8mFV919i
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 135caae4-de8c-427b-5623-08d5c432d469
X-OriginatorOrg: allied-telesis.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 135caae4-de8c-427b-5623-08d5c432d469
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2018 00:34:53.2781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1a8a37cf-9ecc-4cef-abb0-1ab01a15a6ad
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1230
Return-Path: <ikegami@allied-telesis.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64079
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

SGksDQoNCkkgaGF2ZSBqdXN0IHNlbnQgdGhlIHYyIHZlcnNpb24gcGF0Y2ggd2l0aCBjb3ZlciBs
ZXR0ZXIgc28gcGxlYXNlIHJldmlldyBhZ2Fpbi4NClRoZSBwYXRjaCBpdHNlbGYgaXMgbm90IGNo
YW5nZWQgZnJvbSBwcmV2aW91cyB2ZXJzaW9uIHRoYXQgZml4ZWQgZnJvbSBvcmlnaW5hbCB2ZXJz
aW9uLg0KQnV0IGl0IGlzIG5vdCBpbiBwYXRjaHdvcmsgc28gbGV0IG1lIHNlbmQgdGhpcyBhcyB0
aGUgdjIgdmVyc2lvbi4NClBsZWFzZSByZXZpZXcgdGhlIHBhdGNoIGFnYWluIGFuZCBpZiBhbnkg
Y29uY2VybiBvciBwcm9ibGVtIHBsZWFzZSBsZXQgbWUga25vdy4NCldlIHdvdWxkIGxpa2UgdG8g
cmVzb2x2ZSB0aGUgaXNzdWUgY2F1c2VkIG9uIG91ciBwcm9kdWN0cyBieSB0aGlzIHBhdGNoLg0K
DQpSZWdhcmRzLA0KSWtlZ2FtaQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IElLRUdBTUkgVG9rdW5vcmkNCj4gU2VudDogV2VkbmVzZGF5LCBBcHJpbCAyNSwgMjAxOCAx
MDoyOSBBTQ0KPiBUbzogJ0hhdWtlIE1laHJ0ZW5zJw0KPiBDYzogSmFtZXMgSG9nYW47IFBBQ0tI
QU0gQ2hyaXM7IFJhZmHFgiBNacWCZWNraTsgbGludXgtbWlwc0BsaW51eC1taXBzLm9yZw0KPiBT
dWJqZWN0OiBSRTogW1BBVENIXSBNSVBTOiBCQ000N1hYOiBFbmFibGUgTUlQUzMyIDc0SyBDb3Jl
IEV4dGVybmFsU3luYw0KPiBmb3IgQkNNNDdYWCBQQ0llIGVycmF0dW0NCj4gDQo+IA0KPiANCj4g
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IEhhdWtlIE1laHJ0ZW5zIFtt
YWlsdG86aGF1a2VAaGF1a2UtbS5kZV0NCj4gPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDI1LCAy
MDE4IDY6NDIgQU0NCj4gPiBUbzogSUtFR0FNSSBUb2t1bm9yaQ0KPiA+IENjOiBKYW1lcyBIb2dh
bjsgUEFDS0hBTSBDaHJpczsgUmFmYcWCIE1pxYJlY2tpOyBsaW51eC1taXBzQGxpbnV4LW1pcHMu
b3JnDQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gTUlQUzogQkNNNDdYWDogRW5hYmxlIE1JUFMz
MiA3NEsgQ29yZSBFeHRlcm5hbFN5bmMNCj4gPiBmb3IgQkNNNDdYWCBQQ0llIGVycmF0dW0NCj4g
Pg0KPiA+IE9uIDA0LzI0LzIwMTggMDk6MTkgUE0sIHNtdHB1c2VyIHdyb3RlOg0KPiA+ID4gRnJv
bTogVG9rdW5vcmkgSWtlZ2FtaSA8aWtlZ2FtaUBhbGxpZWQtdGVsZXNpcy5jby5qcD4NCj4gPiA+
DQo+ID4gPiBUaGUgZXJyYXR1bSBhbmQgd29ya2Fyb3VuZCBhcmUgZGVzY3JpYmVkIGJ5IEJDTTUz
MDBYLUVTMzAwLVJEUy5wZGYgYXMNCj4gPiBiZWxvdy4NCj4gPiA+DQo+ID4gPiAgIFIxMDogUENJ
ZSBUcmFuc2FjdGlvbnMgUGVyaW9kaWNhbGx5IEZhaWwNCj4gPiA+DQo+ID4gPiAgICAgRGVzY3Jp
cHRpb246IFRoZSBCQ001MzAwWCBQQ0llIGRvZXMgbm90IG1haW50YWluIHRyYW5zYWN0aW9uDQo+
ID4gb3JkZXJpbmcuDQo+ID4gPiAgICAgICAgICAgICAgICAgIFRoaXMgbWF5IGNhdXNlIFBDSWUg
dHJhbnNhY3Rpb24gZmFpbHVyZS4NCj4gPiA+ICAgICBGaXggQ29tbWVudDogQWRkIGEgZHVtbXkg
UENJZSBjb25maWd1cmF0aW9uIHJlYWQgYWZ0ZXIgYSBQQ0llDQo+ID4gPiAgICAgICAgICAgICAg
ICAgIGNvbmZpZ3VyYXRpb24gd3JpdGUgdG8gZW5zdXJlIFBDSWUgY29uZmlndXJhdGlvbg0KPiA+
IGFjY2Vzcw0KPiA+ID4gICAgICAgICAgICAgICAgICBvcmRlcmluZy4gU2V0IEVTIGJpdCBvZiBD
UDAgY29uZmlndTcgcmVnaXN0ZXIgdG8gZW5hYmxlDQo+ID4gPiAgICAgICAgICAgICAgICAgIHN5
bmMgZnVuY3Rpb24gc28gdGhhdCB0aGUgc3luYyBpbnN0cnVjdGlvbiBpcw0KPiA+IGZ1bmN0aW9u
YWwuDQo+ID4gPiAgICAgUmVzb2x1dGlvbjogIGhuZHBjaS5jOiBleHRwY2lfd3JpdGVfY29uZmln
KCkNCj4gPiA+ICAgICAgICAgICAgICAgICAgaG5kbWlwcy5jOiBzaV9taXBzX2luaXQoKQ0KPiA+
ID4gICAgICAgICAgICAgICAgICBtaXBzaW5jLmggQ09ORjdfRVMNCj4gPiA+DQo+ID4gPiBUaGlz
IGlzIGZpeGVkIGJ5IHRoZSBDRkUgTUlQUyBiY21zaSBjaGlwc2V0IGRyaXZlciBhbHNvIGZvciBC
Q000N1hYLg0KPiA+ID4gQWxzbyB0aGUgZHVtbXkgUENJZSBjb25maWd1cmF0aW9uIHJlYWQgaXMg
YWxyZWFkeSBpbXBsZW1lbnRlZCBpbiB0aGUNCj4gTGludXgNCj4gPiA+IEJDTUEgZHJpdmVyLg0K
PiA+ID4gRW5hYmxlIEV4dGVybmFsU3luYyBpbiBDb25maWc3IHdoZW4gQ09ORklHX0JDTUFfRFJJ
VkVSX1BDSV9IT1NUTU9ERT15DQo+ID4gPiB0b28gc28gdGhhdCB0aGUgc3luYyBpbnN0cnVjdGlv
biBpcyBleHRlcm5hbGlzZWQuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogVG9rdW5vcmkg
SWtlZ2FtaSA8aWtlZ2FtaUBhbGxpZWQtdGVsZXNpcy5jby5qcD4NCj4gPiA+IENjOiBDaHJpcyBQ
YWNraGFtIDxjaHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+DQo+ID4gPiBDYzogSGF1
a2UgTWVocnRlbnMgPGhhdWtlQGhhdWtlLW0uZGU+DQo+ID4gPiBDYzogUmFmYcWCIE1pxYJlY2tp
IDx6YWplYzVAZ21haWwuY29tPg0KPiA+ID4gQ2M6IGxpbnV4LW1pcHNAbGludXgtbWlwcy5vcmcN
Cj4gPiA+IC0tLQ0KPiA+ID4gSSBoYXZlIGp1c3QgZml4ZWQgeW91ciBjb21tZW50cy4NCj4gPiA+
IFRoaXMgcGF0Y2ggd2lsbCBiZSBzZW50IGJ5IGdpdC1zZW5kLWVtYWlsLg0KPiA+ID4gQWxzbyBm
b3Igb3VyIGNvbXBhbnkgbWFpbCBzeXN0ZW0gdGhlIHNlbmRlciBtYWlsIGFkZHJlc3MgaXMgbmVl
ZGVkIHRvDQo+ID4gYmUgc2V0IGFzIHNtdHB1c2VyIDxzbXRwdXNlckBhbGxpZWQtdGVsZXNpcy5j
by5qcD4uDQo+ID4gPiBCdXQgZG8gbm90IHJlcGx5IHRvIHRoZSBlbWFpbCBhZGRyZXNzIHNtdHB1
c2VyDQo+ID4gPHNtdHB1c2VyQGFsbGllZC10ZWxlc2lzLmNvLmpwPi4NCj4gPiA+IFBsZWFzZSBy
ZXBseSB0byBteSBlbWFpbCBhZGRyZXNzIGlmIGFueSBjb21lbW50IG9yIHByb2JsZW0uDQo+ID4g
PiBTb3JyeSBmb3IgaW5jb252aW5pZW50IGFib3V0IHRoaXMuDQo+ID4NCj4gPiBEb2VzIHRoZSBD
RkUgYm9vdCBsb2FkZXIgbm9ybWFsbHkgYXBwbHkgdGhpcyB3b3JrYXJvdW5kPyBBbGwgZGV2aWNl
cyBJDQo+ID4gaGF2ZSB3aXRoIHRoaXMgU29DIHVzZSBDRkUgdG8gYm9vdCBMaW51eCBhbmQgSSBh
bSB3b25kZXJpbmcgd2h5ICJvbmx5Ig0KPiA+IHRoZSB3b3JrYXJvdW5kIGluIHRoZSBkcml2ZXIg
aGVscGVkIHRvIHdvcmthcm91bmQgdGhpcyBwcm9ibGVtLg0KPiA+DQo+ID4gTm90IGFsbCBCcm9h
ZGNvbSBNSVBTIFNvQ3MgZnJvbSB0aGUgQlJDTTQ3eHggbGluZSB3aXRoIE1JUFMgNzRLIENQVXMg
YXJlDQo+ID4gYWZmZWN0ZWQuDQo+ID4NCj4gPiBTZWUgaGVyZSwgd2Ugb25seSBhcHBseSB0aGlz
IGZvciB0aGUgQkNNNDcxNiBTb0NzOg0KPiA+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvbGludXMv
MjVjMTU1NjY2MzVmZWY4NmU4N2Y3NjJmNzNhMTlmMjQ1OThlNDVmYQ0KPiA+DQo+ID4gSGVyZSB0
aGUgYnJjbXNtYWMgZHJpdmVyIHByb3ZpZGVkIGJ5IEJyb2FkY29tLCBpdCBzYXlzIHRoYXQgb25s
eSBCQ000NzE2DQo+ID4gYW5kIEJDTTQ3MDYgYXJlIGFmZmVjdGVkOg0KPiA+DQo+IGh0dHBzOi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4Lmdp
dC90cmUNCj4gPiBlL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9icmNt
c21hYy90eXBlcy5oI24yNTUNCj4gPg0KPiA+IEkgYW0gbm90IHN1cmUgaWYgdGhlIHZlcnNpb24g
b2YgdGhlIGJjbTQ3MDYgd2hpY2ggaXMgdXNlZCBvbiBtb3N0DQo+ID4gZGV2aWNlcyBpcyBhZmZl
Y3RlZCBhcyB0aGlzIHdvcmthcm91bmQgaXMgbm90IGFwcGxpZWQgZm9yIHRoaXMgU29DIGluDQo+
ID4gYjQzLCBjb3VsZCBiZSB0aGF0IEJyb2FkY29tIGZpeGVkIHRoYXQgaW4gYSBsYXRlciByZXZp
c2lvbiBhbmQgdGhlDQo+ID4gYnJva2VuIHJldmlzaW9uIG5ldmVyIG1hZGUgaXQgaW50byBtYXNz
IHByb2R1Y3Rpb24uDQo+IA0KPiBUaGFuayB5b3Ugc28gbXVjaCBmb3IgeW91ciBjb21tZW50cy4N
Cj4gVGhlIENGRSBpcyBpbXBsZW1lbnRlZCB0byBlbmFibGUgdGhlIEV4dGVybmFsU3luYyBvbiB0
aGUgYmNtc2kgY2hpcCBzZXQNCj4gdGhvc2UgYXJlIGRlZmluZWQgYXMgbWlwczc0ayBDUFUgYWxz
by4NCj4gQWxzbyBmb3Igb3RoZXIgYm9hcmRzIGZvciBleGFtcGxlIGJjbTk0NzA0Y3BjaSB0aGF0
IEkgdGhpbmsgdGhhdCB0aGlzIGlzDQo+IGZvciBCQ000NzA0IHRoZSBDUFUgaXMgZGVmaW5lZCBh
cyBiY21jb3JlLCBzYjEyNTAgb3IgbXBjODI0NSBidXQgbm90IGRlZmluZWQNCj4gYXMgbWlwczc0
ay4NCj4gSSBoYXZlIGp1c3QgY29uZmlybWVkIHRoYXQgQkNNNTM1N3ggZmFtaWx5IHVzZXMgQVJN
IENQVSBzbyBpdCBzZWVtcyBubw0KPiBwcm9ibGVtLg0KPiBJIGFtIG5vdCBzdXJlIGlmIHRoZXJl
IGlzIGFueSBvdGhlciBNSVBTIDc0SyBDUFUgZW5hYmxlZA0KPiBDT05GSUdfQkNNQV9EUklWRVJf
UENJX0hPU1RNT0RFIG9wdGlvbi4NCj4gQnV0IGlmIG5lZWRlZCB0byBtYWtlIHN1cmUgSSBjYW4g
Y2hhbmdlIHRvIHVzZSBDT05GSUdfQkNNNDdYWCBmb3IgdGhlIGNoYW5nZQ0KPiBpbnN0ZWFkIG9m
IENPTkZJR19CQ01BX0RSSVZFUl9QQ0lfSE9TVE1PREUuDQo+IFNvIHBsZWFzZSBsZXQgbWUga25v
dyBpZiBuZWVkZWQgdG8gY2hhbmdlLg0KPiAgIE5vdGU6IEZvciBvdXIgQkNNNTMwMDMgQ1BVIGlm
IHBvc3NpYmxlIHdlIHdvdWxkIGxpa2UgdG8gdXNlDQo+IENPTkZJR19CQ01BX0RSSVZFUl9QQ0lf
SE9TVE1PREUgYXMgY3VycmVudCBwYXRjaC4NCj4gDQo+ID4gRG8geW91IHNlcyB0aGUgcHJvYmxl
bSBvbiB0aGUgQkNNNTMwMDEgSSB0aGluayB0aGlzIGlzIHRoZSBzYW1lIHNpbGljb24NCj4gPiBh
cyB0aGUgYmNtNDcwNj8NCj4gDQo+IFllcyB3ZSBhcmUgdXNpbmcgQkNNNTMwMDMgYW5kIHRoZSBC
Q001MzAwMyBjaGlwIElEIGlzIHNhbWUgd2l0aCBCQ000NzA2Lg0KPiBTbyBpdCBsb29rcyB0aGF0
IHRoZSBCQ001MzAwMSBpcyBhbHNvIHNhbWUuDQo+IEF0IHRoaXMgbW9tZW50IEkgY291bGQgbm90
IGNvbmZpcm0gdGhlIGFjdHVhbCBlcnJhdHVtIGVycm9yIGJlaGF2aW9yLg0KPiANCj4gPiA+ICBh
cmNoL21pcHMvaW5jbHVkZS9hc20vbWlwc3JlZ3MuaCB8ICAzICsrKw0KPiA+ID4gIGFyY2gvbWlw
cy9rZXJuZWwvY3B1LXByb2JlLmMgICAgIHwgMTIgKysrKysrKysrKystDQo+ID4gPiAgMiBmaWxl
cyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPg0KPiA+ID4g
ZGlmZiAtLWdpdCBhL2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9taXBzcmVncy5oDQo+ID4gYi9hcmNo
L21pcHMvaW5jbHVkZS9hc20vbWlwc3JlZ3MuaA0KPiA+ID4gaW5kZXggODU4NzUyZGFjMzM3Li4w
Zjk0YWNmNjAxNDQgMTAwNjQ0DQo+ID4gPiAtLS0gYS9hcmNoL21pcHMvaW5jbHVkZS9hc20vbWlw
c3JlZ3MuaA0KPiA+ID4gKysrIGIvYXJjaC9taXBzL2luY2x1ZGUvYXNtL21pcHNyZWdzLmgNCj4g
PiA+IEBAIC02ODAsNiArNjgwLDggQEANCj4gPiA+ICAjZGVmaW5lIE1JUFNfQ09ORjdfV0lJCQko
X1VMQ0FTVF8oMSkgPDwgMzEpDQo+ID4gPg0KPiA+ID4gICNkZWZpbmUgTUlQU19DT05GN19SUFMJ
CShfVUxDQVNUXygxKSA8PCAyKQ0KPiA+ID4gKy8qIEV4dGVybmFsU3luYyAqLw0KPiA+ID4gKyNk
ZWZpbmUgTUlQU19DT05GN19FUwkJKF9VTENBU1RfKDEpIDw8IDgpDQo+ID4gPg0KPiA+ID4gICNk
ZWZpbmUgTUlQU19DT05GN19JQVIJCShfVUxDQVNUXygxKSA8PCAxMCkNCj4gPiA+ICAjZGVmaW5l
IE1JUFNfQ09ORjdfQVIJCShfVUxDQVNUXygxKSA8PCAxNikNCj4gPiA+IEBAIC0yNzU5LDYgKzI3
NjEsNyBAQCBfX0JVSUxEX1NFVF9DMChzdGF0dXMpDQo+ID4gPiAgX19CVUlMRF9TRVRfQzAoY2F1
c2UpDQo+ID4gPiAgX19CVUlMRF9TRVRfQzAoY29uZmlnKQ0KPiA+ID4gIF9fQlVJTERfU0VUX0Mw
KGNvbmZpZzUpDQo+ID4gPiArX19CVUlMRF9TRVRfQzAoY29uZmlnNykNCj4gPiA+ICBfX0JVSUxE
X1NFVF9DMChpbnRjb250cm9sKQ0KPiA+ID4gIF9fQlVJTERfU0VUX0MwKGludGN0bCkNCj4gPiA+
ICBfX0JVSUxEX1NFVF9DMChzcnNtYXApDQo+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9taXBzL2tl
cm5lbC9jcHUtcHJvYmUuYw0KPiA+IGIvYXJjaC9taXBzL2tlcm5lbC9jcHUtcHJvYmUuYw0KPiA+
ID4gaW5kZXggY2YzZmQ1NDllMTZkLi43NTAzOWU4OTY5NGYgMTAwNjQ0DQo+ID4gPiAtLS0gYS9h
cmNoL21pcHMva2VybmVsL2NwdS1wcm9iZS5jDQo+ID4gPiArKysgYi9hcmNoL21pcHMva2VybmVs
L2NwdS1wcm9iZS5jDQo+ID4gPiBAQCAtNDI3LDggKzQyNywxOCBAQCBzdGF0aWMgaW5saW5lIHZv
aWQgY2hlY2tfZXJyYXRhKHZvaWQpDQo+ID4gPiAgCQkgKiBtYWtpbmcgdXNlIG9mIFZQRTEgd2ls
bCBiZSByZXNwb25zYWJsZSBmb3IgdGhhdCBWUEUuDQo+ID4gPiAgCQkgKi8NCj4gPiA+ICAJCWlm
ICgoYy0+cHJvY2Vzc29yX2lkICYgUFJJRF9SRVZfTUFTSykgPD0NCj4gPiBQUklEX1JFVl8zNEtf
VjFfMF8yKQ0KPiA+ID4gLQkJCXdyaXRlX2MwX2NvbmZpZzcocmVhZF9jMF9jb25maWc3KCkgfA0K
PiA+IE1JUFNfQ09ORjdfUlBTKTsNCj4gPiA+ICsJCQlzZXRfYzBfY29uZmlnNyhNSVBTX0NPTkY3
X1JQUyk7DQo+ID4gPiAgCQlicmVhazsNCj4gPiA+ICsjaWZkZWYgQ09ORklHX0JDTUFfRFJJVkVS
X1BDSV9IT1NUTU9ERQ0KPiA+ID4gKwljYXNlIENQVV83NEs6DQo+ID4gPiArCQkvKg0KPiA+ID4g
KwkJICogQkNNNDdYWCBFcnJhdHVtICJSMTA6IFBDSWUgVHJhbnNhY3Rpb25zIFBlcmlvZGljYWxs
eQ0KPiA+IEZhaWwiDQo+ID4gPiArCQkgKiBFbmFibGUgRXh0ZXJuYWxTeW5jIGZvciBzeW5jIGlu
c3RydWN0aW9uIHRvIHRha2UgZWZmZWN0DQo+ID4gPiArCQkgKi8NCj4gPiA+ICsJCXByX2luZm8o
IkV4dGVybmFsU3luYyBoYXMgYmVlbiBlbmFibGVkXG4iKTsNCj4gPiA+ICsJCXNldF9jMF9jb25m
aWc3KE1JUFNfQ09ORjdfRVMpOw0KPiA+ID4gKwkJYnJlYWs7DQo+ID4gPiArI2VuZGlmDQo+ID4g
PiAgCWRlZmF1bHQ6DQo+ID4gPiAgCQlicmVhazsNCj4gPiA+ICAJfQ0KPiA+ID4NCg0K
