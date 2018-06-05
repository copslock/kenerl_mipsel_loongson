Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2018 01:28:15 +0200 (CEST)
Received: from mail1.bemta12.messagelabs.com ([216.82.251.15]:30408 "EHLO
        mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994714AbeFEX2HTLL6w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2018 01:28:07 +0200
Received: from [216.82.251.38] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-15.bemta-12.messagelabs.com id 48/14-23913-28C171B5; Tue, 05 Jun 2018 23:28:02 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSbUhTYRTH9+zebVdz9bgZOy0VXC+UtqVpJRV
  RECQE0ac+aKjXurnhNuXeKSuCLCmdLsx8oRalE5MyxTIztaKcRM6CfPlQkJbvLUmM9WZJ2u7u
  evv2f87/95zzP3AoQnFXqqYYq4VhzbRRIw0mEx6XMtpT4aqU2PF3MYkjIyWyxLIeL5l4vvKCL
  LHRzewik8Z/esikDsewLKmlwSZNenKjSXyATJYYzBnZ1nSJvtDuRjk2jfX0jIfIR31RxSiYUu
  AiBI2eAqIYBVGAj4NtsVMq6EUEBd+SBaicgEeTL2X8g8Q3CbjnqCUEp1QM/c5PMuHxBsGtD08
  R/1+KN8P9yXmS12F4FYz86EA8ROBrCGrGRv1DlFgPff29PojyQQbwLIAgN8H4Q44nSLwamoec
  /nhyfAhaXReQMOsygovvSv1GENbB0KjTPxfhCCjvPCXmNYFVMFBeG9gHQ92DF4E9l8P78QWJw
  KfC85YiJNSjoLXEFuAjYKC6xD8McDsJVX19gc9a+FhZSQhGG4JP7kopnxpwNBTe3ikwO6Cwa1
  Im6Cz4MDtDCnob1HXPB+qR0HBulDyP4hz/ZHX4OhF4PTR3bhTKUVBRMipz+PcPBfelCbIGkQ1
  oHceweQyrjY/XZbCGTL3FRBuM2ri4TToTw3F0JmOkMzjd4WxTC/Idz0mRCLUjtzPFhVZQYs1y
  eZdClaJYmpF95Jie5vRpbK6R4VwonKI0ID+70ueFskwmYz1qMPou8LcNVIgmTD7D23IuhzZxh
  kzB6kXx1NBZu52gJgar7ISCNGebGbVKPsajmEf1ueY/jX5f8wCKUCvlSCQSKUJyGNZksPzvTy
  MVhTRK+WW+S4jBbPkzb9oXReyLMmVV8lEs9F9LnY/SD7VxqY3e65L2hHLTWoloX8/bO/VXVjY
  /a5p+ZJe51nlPb3/V1B7xekmOl909d3BwmXMsq7joy2dben3CMBmkXpgK3fB9y8Taq5F7FJdW
  dc/HlNVN3YrUasT72+6c2VrROxf1dWNrKjdbGGNP6wjaO5xWpjyhy8sLb4hdo4bqh20aktPTc
  dEEy9G/ABLppJnIAwAA
X-Env-Sender: ikegami@allied-telesis.co.jp
X-Msg-Ref: server-8.tower-163.messagelabs.com!1528241281!156821215!1
X-Originating-IP: [52.192.143.101]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 53140 invoked from network); 5 Jun 2018 23:28:01 -0000
Received: from mo.allied-telesis-co-jp.hdemail.jp (HELO mo.allied-telesis-co-jp.hdemail.jp) (52.192.143.101)
  by server-8.tower-163.messagelabs.com with SMTP; 5 Jun 2018 23:28:01 -0000
Received: by mo.allied-telesis-co-jp.hdemail.jp (hde-mf-postfix, from userid 504)
        id A2002294002; Wed,  6 Jun 2018 08:28:00 +0900 (JST)
X-Received: from unknown (HELO mo.allied-telesis-co-jp.hdemail.jp) (127.0.0.1)
  by 0 with SMTP; 6 Jun 2018 08:28:00 +0900
X-Received: from mo.allied-telesis-co-jp.hdemail.jp (localhost.localdomain [127.0.0.1])
        by mo.allied-telesis-co-jp.hdemail.jp (hde-ma-postfix) with ESMTP id 4551C1AC001;
        Wed,  6 Jun 2018 08:28:00 +0900 (JST)
        (envelope-from ikegami@allied-telesis.co.jp)
Received: from JPN01-TY1-obe.outbound.protection.outlook.com (mail-ty1jpn01lp0179.outbound.protection.outlook.com [23.103.139.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mo.allied-telesis-co-jp.hdemail.jp (hde-mf-postfix) with ESMTPS id 316CC294001;
        Wed,  6 Jun 2018 08:28:00 +0900 (JST)
        (envelope-from ikegami@allied-telesis.co.jp)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atjp.onmicrosoft.com;
 s=selector1-alliedtelesis-co-jp01e;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+E0hwRkJfIzknrk661tTOWw0qpo8Mngj1U4OO8RfJHQ=;
 b=GcF9lkCtstTvYVYKwBzbGmd9MnIEzegQ0q3QPm1QPpdOm3IOcHDAoN6QTITrEcaNVlDwD0kC7SN8XjErE+HZIsaAypqJZuCQqWAwEIAm7B6bNc6RIhnxgw0D++2e9xL2RI/QSl2j2xdvxUa8RY++jsHcuUYNIhjA+HdfbiMTK5s=
Received: from TY1PR01MB0954.jpnprd01.prod.outlook.com (10.167.157.141) by
 TY1PR01MB1069.jpnprd01.prod.outlook.com (10.174.225.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.15; Tue, 5 Jun 2018 23:27:59 +0000
Received: from TY1PR01MB0954.jpnprd01.prod.outlook.com
 ([fe80::3d74:245b:c1e5:b0ab]) by TY1PR01MB0954.jpnprd01.prod.outlook.com
 ([fe80::3d74:245b:c1e5:b0ab%4]) with mapi id 15.20.0820.015; Tue, 5 Jun 2018
 23:27:58 +0000
From:   IKEGAMI Tokunori <ikegami@allied-telesis.co.jp>
To:     James Hogan <jhogan@kernel.org>
CC:     PACKHAM Chris <chris.packham@alliedtelesis.co.nz>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH v5 1/1] MIPS: BCM47XX: Enable MIPS32 74K Core ExternalSync
 for BCM47XX PCIe erratum
Thread-Topic: [PATCH v5 1/1] MIPS: BCM47XX: Enable MIPS32 74K Core
 ExternalSync for BCM47XX PCIe erratum
Thread-Index: AQHT/ORCNG54zbrsUkCsjIZgy15I2KRSS8Vw
Date:   Tue, 5 Jun 2018 23:27:58 +0000
Message-ID: <TY1PR01MB095430C18876D7BE9CC53E08DC660@TY1PR01MB0954.jpnprd01.prod.outlook.com>
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
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1069;7:LEZsd9Gn97ul6lfbPOeG6nYghiWq/jLynfvsmY2fS0h//25b62uW3AI7ejo0u2qT2KX6NpeUEuS4q4QNt1im6Ymufp78gdhtyXDi+DUvHaw4vjEEseeCP9Aa2ACOmxyFpo1qSHelWsP+/f6jBSBhh/xinkm06CUXj4NECT6Se7FHYbM4NbEpPM6CmZqsoHTd+iO+fwq6OnmbzJqywgKUUFYLUw0S1OTjBHmeR0cYrqNA+PvsDR33NVosWHIaLTab;20:adDqBOSH9C0eAmu/D2xei8zRxBg+NjHlTSilMNhR7vYhjZ7smK9u1WRTJTsy4kIY6CiJ9ysip+5tbXWAx9wxcBU7gQ4GIIxKTC3wGBkRs6JTinURfmA+m8b0ChqANLHZ6kZA8U3YAtPqHhBQsimm/j2X6nvkzN3IjU6dlZAvTu1Wtar5G8IW3YmC3Qe5X6WZ/3FD0R374UoIshCc2pljL9qP9r4Q+HZ+Vv0aUtZ31Ffn/FllpHS0QDqttWc07+Kq
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1069;
x-ms-traffictypediagnostic: TY1PR01MB1069:
x-ld-processed: 1a8a37cf-9ecc-4cef-abb0-1ab01a15a6ad,ExtAddr
x-microsoft-antispam-prvs: <TY1PR01MB1069FB111705794B9F73ABF3DC660@TY1PR01MB1069.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:TY1PR01MB1069;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1069;
x-forefront-prvs: 0694C54398
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(39840400004)(376002)(396003)(346002)(51914003)(13464003)(189003)(50944005)(199004)(54906003)(6436002)(53936002)(316002)(6246003)(551934003)(55016002)(33656002)(6306002)(74482002)(2900100001)(25786009)(4326008)(11346002)(486006)(476003)(446003)(478600001)(74316002)(305945005)(7736002)(14454004)(5250100002)(99286004)(9686003)(59450400001)(53546011)(6506007)(102836004)(6116002)(3846002)(105586002)(106356001)(6916009)(97736004)(7696005)(3660700001)(8676002)(2906002)(66066001)(68736007)(8936002)(39060400002)(3280700002)(81156014)(81166006)(86362001)(186003)(26005)(76176011)(5660300001)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1069;H:TY1PR01MB0954.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: allied-telesis.co.jp does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: 0ZNRBye/1qUj6EzKOqcpOV3NCPx0olFbh1n6eFap8PXpgzfG8yXW0e5ZUDJvvizEtuno7EYgb/tQGan1fMaDYuC2ta9s3o9/2CGa8DLYIpoqrdzEZVyI3cNL72LH5weDfb2SfrHiNPAc6a+pjtuvI+P9RnMkKLNw5SYpU1WYCCvGt//Fuz8b36HGN7hPFfWc
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 2d33edda-e05d-4029-0fa4-08d5cb3bf950
X-OriginatorOrg: allied-telesis.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d33edda-e05d-4029-0fa4-08d5cb3bf950
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2018 23:27:58.8294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1a8a37cf-9ecc-4cef-abb0-1ab01a15a6ad
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1069
Return-Path: <ikegami@allied-telesis.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64197
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

SGkgSmFtZXMtc2FuLA0KDQo+IEkgcHJlc3VtZSB0aGlzIHBhdGNoIGlzIHJlYWR5IHRvIGFwcGx5
IG5vdyAodGhhbmtzIGZvciB0aGUgcmV2aWV3cw0KPiBmb2xrcykuDQoNCiAgSSBhbSB2ZXJ5IGhh
cHB5IHdpdGggdGhpcy4gVGhhbmsgeW91IHNvIG11Y2ggZm9yIHlvdXIgcmV2aWV3aW5nLg0KDQo+
IEhvdyBmYXIgYmFjayBkb2VzIHRoaXMgbmVlZCBiYWNrcG9ydGluZyB0byBzdGFibGUgYnJhbmNo
ZXM/DQoNCiAgVGhlIHBhdGNoIGlzIGZvciBtYWludGVuYW5jZSBwdXJwb3NlIHNvIGJldHRlciB0
byBhcHBseSBzdGFibGUgYnJhbmNoZXMuDQoNCj4gSXQgYXBwbGllcyBlYXNpbHkgYmFjayB0byAz
LjE0IEkgdGhpbmsgKGNvbW1pdCAzYzA2YjEyYjA0NmUgKCJNSVBTOg0KPiBCQ000N1hYOiBmaXgg
cG9zaXRpb24gb2YgY3B1X3dhaXQgZGlzYWJsaW5nIikpLCBidXQgeW91IG1lbnRpb25lZCBvdGhl
cg0KPiBmaXhlcyB0b28uIEhhdmUgdGhvc2UgYmVlbiBiYWNrcG9ydGVkIHRvbywgYW5kIGlmIG5v
dCBpcyB0aGVyZSBhbnkgcG9pbnQNCj4gYmFja3BvcnRpbmcgdGhpcz8NCg0KICBZZXMgdGhlIG90
aGVyIGZpeGVzIGFsc28gYXJlIHBvc3NpYmxlIHRvIGJlIGFwcGxpZWQgdG8gc3RhYmxlIGJyYW5j
aGVzLg0KICBUaGUgcGF0Y2hlcyB3ZXJlIHJldmlld2VkIGFzIGJlbG93IGFuZCBhcHBsaWVkIGlu
dG8gdGhlIG10ZC9uZXh0IGJyYW5jaC4NCiAgICA8aHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9y
Zy9wcm9qZWN0L2xpbnV4LW10ZC9saXN0Lz9zZXJpZXM9NDc0NjQmc3RhdGU9Kj4NCiAgICA8aHR0
cDovL2dpdC5pbmZyYWRlYWQub3JnL2xpbnV4LW10ZC5naXQvc2hvcnRsb2cvcmVmcy9oZWFkcy9t
dGQvbmV4dD4NCg0KICBUaGUgcGF0Y2hlcyAxLzEgdG8gNC81IGFyZSB0YWdnZWQgQ2M6IHN0YWJs
ZSB0byBhcHBseSBpbnRvIHN0YWJsZSBicmFuY2hlcy4NCiAgQnV0IGFjdHVhbGx5IHRob3NlIGhh
dmUgbm90IGJlZW4gYXBwbGllZCB5ZXQgaW50byBzdGFibGUgYnJhbmNoZXMgSSB0aGluay4NCg0K
UmVnYXJkcywNCklrZWdhbWkNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBKYW1lcyBIb2dhbiBbbWFpbHRvOmpob2dhbkBrZXJuZWwub3JnXQ0KPiBTZW50OiBXZWRuZXNk
YXksIEp1bmUgMDYsIDIwMTggMTI6NDYgQU0NCj4gVG86IElLRUdBTUkgVG9rdW5vcmkNCj4gQ2M6
IFBBQ0tIQU0gQ2hyaXM7IFJhZmHFgiBNacWCZWNraTsgbGludXgtbWlwc0BsaW51eC1taXBzLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDEvMV0gTUlQUzogQkNNNDdYWDogRW5hYmxlIE1J
UFMzMiA3NEsgQ29yZQ0KPiBFeHRlcm5hbFN5bmMgZm9yIEJDTTQ3WFggUENJZSBlcnJhdHVtDQo+
IA0KPiBPbiBTdW4sIEp1biAwMywgMjAxOCBhdCAxMTowMjowMVBNICswOTAwLCBUb2t1bm9yaSBJ
a2VnYW1pIHdyb3RlOg0KPiA+IFRoZSBlcnJhdHVtIGFuZCB3b3JrYXJvdW5kIGFyZSBkZXNjcmli
ZWQgYnkgQkNNNTMwMFgtRVMzMDAtUkRTLnBkZiBhcw0KPiBiZWxvdy4NCj4gPg0KPiA+ICAgUjEw
OiBQQ0llIFRyYW5zYWN0aW9ucyBQZXJpb2RpY2FsbHkgRmFpbA0KPiA+DQo+ID4gICAgIERlc2Ny
aXB0aW9uOiBUaGUgQkNNNTMwMFggUENJZSBkb2VzIG5vdCBtYWludGFpbiB0cmFuc2FjdGlvbg0K
PiBvcmRlcmluZy4NCj4gPiAgICAgICAgICAgICAgICAgIFRoaXMgbWF5IGNhdXNlIFBDSWUgdHJh
bnNhY3Rpb24gZmFpbHVyZS4NCj4gPiAgICAgRml4IENvbW1lbnQ6IEFkZCBhIGR1bW15IFBDSWUg
Y29uZmlndXJhdGlvbiByZWFkIGFmdGVyIGEgUENJZQ0KPiA+ICAgICAgICAgICAgICAgICAgY29u
ZmlndXJhdGlvbiB3cml0ZSB0byBlbnN1cmUgUENJZSBjb25maWd1cmF0aW9uDQo+IGFjY2Vzcw0K
PiA+ICAgICAgICAgICAgICAgICAgb3JkZXJpbmcuIFNldCBFUyBiaXQgb2YgQ1AwIGNvbmZpZ3U3
IHJlZ2lzdGVyIHRvIGVuYWJsZQ0KPiA+ICAgICAgICAgICAgICAgICAgc3luYyBmdW5jdGlvbiBz
byB0aGF0IHRoZSBzeW5jIGluc3RydWN0aW9uIGlzDQo+IGZ1bmN0aW9uYWwuDQo+ID4gICAgIFJl
c29sdXRpb246ICBobmRwY2kuYzogZXh0cGNpX3dyaXRlX2NvbmZpZygpDQo+ID4gICAgICAgICAg
ICAgICAgICBobmRtaXBzLmM6IHNpX21pcHNfaW5pdCgpDQo+ID4gICAgICAgICAgICAgICAgICBt
aXBzaW5jLmggQ09ORjdfRVMNCj4gPg0KPiA+IFRoaXMgaXMgZml4ZWQgYnkgdGhlIENGRSBNSVBT
IGJjbXNpIGNoaXBzZXQgZHJpdmVyIGFsc28gZm9yIEJDTTQ3WFguDQo+ID4gQWxzbyB0aGUgZHVt
bXkgUENJZSBjb25maWd1cmF0aW9uIHJlYWQgaXMgYWxyZWFkeSBpbXBsZW1lbnRlZCBpbiB0aGUg
TGludXgNCj4gPiBCQ01BIGRyaXZlci4NCj4gPiBFbmFibGUgRXh0ZXJuYWxTeW5jIGluIENvbmZp
Zzcgd2hlbiBDT05GSUdfQkNNQV9EUklWRVJfUENJX0hPU1RNT0RFPXkNCj4gPiB0b28gc28gdGhh
dCB0aGUgc3luYyBpbnN0cnVjdGlvbiBpcyBleHRlcm5hbGlzZWQuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBUb2t1bm9yaSBJa2VnYW1pIDxpa2VnYW1pQGFsbGllZC10ZWxlc2lzLmNvLmpwPg0K
PiA+IFJldmlld2VkLWJ5OiBQYXVsIEJ1cnRvbiA8cGF1bC5idXJ0b25AbWlwcy5jb20+DQo+ID4g
QWNrZWQtYnk6IEhhdWtlIE1laHJ0ZW5zIDxoYXVrZUBoYXVrZS1tLmRlPg0KPiA+IENjOiBDaHJp
cyBQYWNraGFtIDxjaHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+DQo+ID4gQ2M6IFJh
ZmHFgiBNacWCZWNraSA8emFqZWM1QGdtYWlsLmNvbT4NCj4gPiBDYzogbGludXgtbWlwc0BsaW51
eC1taXBzLm9yZw0KPiANCj4gSSBwcmVzdW1lIHRoaXMgcGF0Y2ggaXMgcmVhZHkgdG8gYXBwbHkg
bm93ICh0aGFua3MgZm9yIHRoZSByZXZpZXdzDQo+IGZvbGtzKS4NCj4gDQo+IEhvdyBmYXIgYmFj
ayBkb2VzIHRoaXMgbmVlZCBiYWNrcG9ydGluZyB0byBzdGFibGUgYnJhbmNoZXM/DQo+IA0KPiBJ
dCBhcHBsaWVzIGVhc2lseSBiYWNrIHRvIDMuMTQgSSB0aGluayAoY29tbWl0IDNjMDZiMTJiMDQ2
ZSAoIk1JUFM6DQo+IEJDTTQ3WFg6IGZpeCBwb3NpdGlvbiBvZiBjcHVfd2FpdCBkaXNhYmxpbmci
KSksIGJ1dCB5b3UgbWVudGlvbmVkIG90aGVyDQo+IGZpeGVzIHRvby4gSGF2ZSB0aG9zZSBiZWVu
IGJhY2twb3J0ZWQgdG9vLCBhbmQgaWYgbm90IGlzIHRoZXJlIGFueSBwb2ludA0KPiBiYWNrcG9y
dGluZyB0aGlzPw0KPiANCj4gVGhhbmtzDQo+IEphbWVzDQo=
