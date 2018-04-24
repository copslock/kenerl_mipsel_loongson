Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Apr 2018 18:39:21 +0200 (CEST)
Received: from mail1.bemta12.messagelabs.com ([216.82.251.15]:52976 "EHLO
        mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994629AbeDXQjMtBsnS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Apr 2018 18:39:12 +0200
Received: from [216.82.251.38] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-15.bemta-12.messagelabs.com id 0D/A1-14918-EAD5FDA5; Tue, 24 Apr 2018 16:39:10 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VSe0hTcRTeb/du92reuE7Do2XUYpDGfGTlpIi
  CiGVBSUUk9rjazY22Kfeu0vojM6ily2e2HJTLMsylhVqopZWZWQTVtBphOTPLR28piJ67u9rj
  v++c7/t95/sdDokp7snDSDbLzHImxqCU++Pzrhey6rpNfckxJ98GaTyefELTM7xeU9z1CdcUl
  ZUQmrHnBbjm/B12iVw78GMI1zbbnxHavsE2TFtfc1iuvXWuVqod7ejH18iTZXpTakbWVpnurK
  NNlvkIsoZLHCgHnYc85E8qaAsCS12VNA/5kUDvhVFbMSYQQP9C0JOXS4iqUgy62st9BU4XYmA
  fy0MiUyaFpwVWqVh4EBQ0fsEFMzk9H64MfvPhYHolWA+6ZYIIo7sQVDQfwgQiiN4IvxzDSBQl
  w5NqNyHi5dBd+97Xx2kVvHG6fQkpOgU+dzrk4rSHXqPrQz4jP1oNd0e7fQ8QHQ6lLft9DzA6B
  FyllXLxezScuXofE/EUGB74KRP1m+FevQWJ/ZnQmH94XB8Orop8JK6jCYd6l2d8T2r4UFY2bn
  QZwbMWlYgj4Xahbby/CA7dGCREvAPa3DexCY2lwy4VTcsxaG3OxYtQjP2fsHZEenEEXGiJFts
  z4Wh+P2H3LSAQ7pS/xB0Ir0GzeZbbxXLquXFRqZw+XWc2MnqDOjZ2bpSR5XkmnTUwqXxUWoax
  Hnlvap9EgpqQ05bYjkJJqXIKZZP2JSsmp2Zsy9YxvG4Lt9PA8u1oGkkqgXKmeLlAjk1ns7brD
  d7DnKCBDFAGU6cEmuIzGSOvTxepuyiO7D1otWLky+5jVkyBmzJMbFgI1SxIaUGq22n6YzRx5C
  4UHhZEIYlEogjIZDmj3vw/P4JCSKQMoqoElwC9yfxn3og3itQbxRLaK0QxM3+psBy0IvLEO82
  Liwk4dnzDsphz31/3pmWrPkbHLGiNMgXGJ82gKvvnzPIbylElhFcFJK1q6Fy8fuHXPesGX58e
  6NbGrX1gDM6dWv29Wu9aWvMKKzidyzc6kzw9KqK69kiTezp/YNJ7f65/9bVLj2dDFTGQGOH8e
  Nu2cNvu3kcdDaOrlPHflDivY2IjMY5nfgOE2l5I3wMAAA==
X-Env-Sender: ikegami@allied-telesis.co.jp
X-Msg-Ref: server-14.tower-163.messagelabs.com!1524587949!160954285!1
X-Originating-IP: [52.192.143.101]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 121460 invoked from network); 24 Apr 2018 16:39:09 -0000
Received: from mo.allied-telesis-co-jp.hdemail.jp (HELO mo.allied-telesis-co-jp.hdemail.jp) (52.192.143.101)
  by server-14.tower-163.messagelabs.com with SMTP; 24 Apr 2018 16:39:09 -0000
Received: by mo.allied-telesis-co-jp.hdemail.jp (hde-mf-postfix, from userid 504)
        id 16DEC294002; Wed, 25 Apr 2018 01:39:09 +0900 (JST)
X-Received: from unknown (HELO mo.allied-telesis-co-jp.hdemail.jp) (127.0.0.1)
  by 0 with SMTP; 25 Apr 2018 01:39:08 +0900
X-Received: from mo.allied-telesis-co-jp.hdemail.jp (localhost.localdomain [127.0.0.1])
        by mo.allied-telesis-co-jp.hdemail.jp (hde-ma-postfix) with ESMTP id AEA5F1AC001;
        Wed, 25 Apr 2018 01:39:08 +0900 (JST)
        (envelope-from ikegami@allied-telesis.co.jp)
Received: from JPN01-OS2-obe.outbound.protection.outlook.com (mail-os2jpn01lp0146.outbound.protection.outlook.com [23.103.139.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mo.allied-telesis-co-jp.hdemail.jp (hde-mf-postfix) with ESMTPS id 923C8294001;
        Wed, 25 Apr 2018 01:39:08 +0900 (JST)
        (envelope-from ikegami@allied-telesis.co.jp)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atjp.onmicrosoft.com;
 s=selector1-alliedtelesis-co-jp01e;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=adX7FNsjNxXLoV84OaABXA6ccx7kr6gIb2fYAKL/SAg=;
 b=kaLDTWXEuxzNQvciv41CQMqqOMoXI06RSBmRzQJfs9tLCqFlesXb5PCaZj9uiB9fSkL9n2EIiYZQhCU37CavauleMRU0XdY77VYGB8eZhRxgV8pN/oDfF229FVPY8/htuLucpn/5TL4l2s03O7ySQuuY+SxDyObhuRG427MdE2w=
Received: from TY1PR01MB0954.jpnprd01.prod.outlook.com (10.167.157.141) by
 TY1PR01MB1101.jpnprd01.prod.outlook.com (10.174.225.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.696.13; Tue, 24 Apr 2018 16:39:06 +0000
Received: from TY1PR01MB0954.jpnprd01.prod.outlook.com
 ([fe80::495f:2227:40ea:9f08]) by TY1PR01MB0954.jpnprd01.prod.outlook.com
 ([fe80::495f:2227:40ea:9f08%13]) with mapi id 15.20.0696.019; Tue, 24 Apr
 2018 16:39:06 +0000
From:   IKEGAMI Tokunori <ikegami@allied-telesis.co.jp>
To:     James Hogan <jhogan@kernel.org>,
        Matt Redfearn <matt.redfearn@mips.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        PACKHAM Chris <chris.packham@alliedtelesis.co.nz>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: RE: MIPS: BCM47XX: Enable MIPS32 74K Core ExternalSync for BCM47XX
 PCIe erratum
Thread-Topic: MIPS: BCM47XX: Enable MIPS32 74K Core ExternalSync for BCM47XX
 PCIe erratum
Thread-Index: AdPbnW6Ya94HI7S/R6SR34cQ5ieoegAJO9WAAACRlgAAAOjogAAHnRag
Date:   Tue, 24 Apr 2018 16:39:06 +0000
Message-ID: <TY1PR01MB095475FD56447D79E93A4F2DDC880@TY1PR01MB0954.jpnprd01.prod.outlook.com>
References: <TY1PR01MB0954C80E15BA87D03E3A6880DC880@TY1PR01MB0954.jpnprd01.prod.outlook.com>
 <20180424114956.GA28813@saruman>
 <f7af849f-f720-fc95-b6b9-8a0f94e04e9f@mips.com>
 <20180424123216.GB25058@saruman>
In-Reply-To: <20180424123216.GB25058@saruman>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [61.215.194.29]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1101;7:lrqAtf28l7K4hI4p7R7wWrnBXQAk6gswHE30P7FG9eNAC9eAX1wn4upeyUdBx2Xml8dLehMDcvXjGhkK2NqZHCdMlObXDDYXERCZLOX9mnSN2laN7xPC62irfOaZSJKFHIxbgZAD3ky5Crnh8G9uuACFBOCnswXXbkVOeLkRyJLSIqOr5NNBaE0D6pRDnLzSzgG4HhltmJ4Qp9Ne0J2F+kKcnRq2py5Amdd5yDCgGktjByOkjOb9eqL+t+9bjTiO;20:Ze9ti8vEdo7tRZpxFGgqlXidsJe1A8KDj6p7NfLiqgANsIy7K4wdLvLNIff87undgFYESVAtAUfb9MNJM2QHG0NQB+m3kv6Ub2fiLIulPE1Jnn9SpQqpE6UBXttnUYShNuv9kWw8x7uluAfJvuP2JY84jIggG8zPXW2h5Sg7u3jZIh+A19ZkkIrajPi6exENnZOrEOj14NJObg7rONAzmg+rxIbKbhDvlL51XVUNs6/NOcKaKqOyZMerjVtilysz
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1101;
x-ms-traffictypediagnostic: TY1PR01MB1101:
x-ld-processed: 1a8a37cf-9ecc-4cef-abb0-1ab01a15a6ad,ExtAddr
x-microsoft-antispam-prvs: <TY1PR01MB1101D2CD95EF206C47F69D55DC880@TY1PR01MB1101.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501410)(52105095)(93006095)(93001095)(10201501046)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:TY1PR01MB1101;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1101;
x-forefront-prvs: 0652EA5565
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(39850400004)(39380400002)(376002)(13464003)(189003)(199004)(81166006)(6116002)(3846002)(86362001)(5660300001)(3280700002)(4326008)(105586002)(3660700001)(7736002)(68736007)(106356001)(74316002)(486006)(305945005)(74482002)(5250100002)(229853002)(81156014)(33656002)(54906003)(478600001)(476003)(11346002)(446003)(110136005)(102836004)(2900100001)(25786009)(8936002)(186003)(99286004)(316002)(9686003)(8676002)(2906002)(26005)(6506007)(93886005)(14454004)(39060400002)(76176011)(6436002)(6246003)(55016002)(66066001)(7696005)(53936002)(53546011)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1101;H:TY1PR01MB0954.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: allied-telesis.co.jp does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: vaz+nD3/iWRSoQbjm7dGRaRvffHNxX+n2mXArObFlEG9U2D8F6b/TGSeux3Kd7fMy6uy/GOufiMcSCbLllHg1FSnYOsXjam7zeRXjNbzZ54Fl0ma6/E86tOpxmYaImJAh7sPZxqVGQQetOQ6VsZiUNAqbbbp9+VVO5bdxCKQs2fOpI+JPVpWuWZEqTvHEXMn
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8ec57a78-42c6-4dbd-17bc-08d5aa01e588
X-OriginatorOrg: allied-telesis.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec57a78-42c6-4dbd-17bc-08d5aa01e588
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2018 16:39:06.4915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1a8a37cf-9ecc-4cef-abb0-1ab01a15a6ad
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1101
Return-Path: <ikegami@allied-telesis.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63735
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

SGkgTWF0dC1zYW4gYW5kIEphbWVzLXNhbiwNCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0K
DQo+ID4gPj4gKy8qIEV4dGVybmFsU3luYyAqLw0KPiA+ID4+ICsjZGVmaW5lIE1JUFNfQ09ORjdf
RVMJCShfVUxDQVNUXygxKSA8PCA4KQ0KPiA+IA0KPiA+IFNpbmNlIHRoZSBjb25maWc3IHJlZ2lz
dGVyIGlzIGltcGxlbWVudGF0aW9uIHNwZWNpZmljLCBtYXkgSSBzdWdnZXN0IA0KPiA+IGNoYW5n
aW5nIHRoZSBNSVBTXyBwcmVmaXggdG8gc29tZXRoaW5nIHZlbmRvciBzcGVjaWZpYyBzdWNoIGFz
DQo+ID4gQlJDTV9DT05GN19FUyBhbmQgc3RhcnQgYSBuZXcgc2VjdGlvbiB3aXRoIGEgY29tbWVu
dCBsaWtlOg0KPiA+IA0KPiA+IC8qIENvbmZpZzcgQml0cyBzcGVjaWZpYyB0byBCcm9hZGNvbSBp
bXBsZW1lbnRhdGlvbnMgKi8NCj4NCj4gU2VlIGhlcmU6DQo+DQo+ID4gPj4gKwljYXNlIENQVV83
NEs6DQo+DQo+IFNvIGl0cyBNSVBTIDc0SyBzcGVjaWZpYywgYW5kIHNvbWUgb3RoZXIgY29yZXMg
aGF2ZSBpdCB0b28gKEkgY2hlY2tlZA0KPiBQNTYwMCBhbmQgaW50ZXJBcHRpdiBtYW51YWxzLCBz
byBJJ2QgZ3Vlc3MgbW9zdCByZWNlbnRpc2ggTUlQUyBjb3JlcykuDQoNCiAgWWVzIHRoZSBFeHRl
cm5hbFN5bmMgaXMgZGVzY3JpYmVkIGJ5IHRoZSBNSVBTMzIgNzRLIFNvZnR3YXJlIFVzZXIgTWFu
dWFsIE1EMDA1MTktMkItNzRLLVNVTS0wMS4wNS5wZGYuDQoNCj4gU28gbWF5YmUgaXRzIHdvcnRo
IHMvTUlQUy9NVEkvIHRvIGNsYXJpZnkgaXQgaXNuJ3QgcGFydCBvZiB0aGUgTUlQUzMyDQo+IGFy
Y2hpdGVjdHVyZS4NCj4NCj4gTm90ZSB0aGF0IHRoZSBzYW1lIGFwcGxpZXMgdG8gYWxsIHRoZSBD
T05GNiBhbmQgQ09ORjcgZGVmaW5pdGlvbnMgYXJvdW5kDQo+IHRoZXJlLCBidXQgaXRzIHdvcnRo
IGdldHRpbmcgdGhpcyBvbmUgcmlnaHQgbm93IEkgdGhpbmssIGxldHMgbm90DQo+IHVubmVjZXNz
YXJpbHkgYWRkIGEgbmV3IGRlZmluaXRpb24gYW5kIGhhdmUgdG8gcmVuYW1lIGl0IGxhdGVyLg0K
DQogIE9rYXkgaWYgbmVlZGVkIEkgd2lsbCBkbyBjaGFuZ2Ugc28gbGV0IG1lIGtub3cgaWYgbmVl
ZGVkLg0KDQpSZWdhcmRzLA0KSWtlZ2FtaQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogSmFtZXMgSG9nYW4gW21haWx0bzpqaG9nYW5Aa2VybmVsLm9yZ10gDQpTZW50OiBUdWVz
ZGF5LCBBcHJpbCAyNCwgMjAxOCA5OjMyIFBNDQpUbzogTWF0dCBSZWRmZWFybg0KQ2M6IElLRUdB
TUkgVG9rdW5vcmk7IGxpbnV4LW1pcHNAbGludXgtbWlwcy5vcmc7IFBBQ0tIQU0gQ2hyaXM7IEhh
dWtlIE1laHJ0ZW5zOyBSYWZhxYIgTWnFgmVja2kNClN1YmplY3Q6IFJlOiBNSVBTOiBCQ000N1hY
OiBFbmFibGUgTUlQUzMyIDc0SyBDb3JlIEV4dGVybmFsU3luYyBmb3IgQkNNNDdYWCBQQ0llIGVy
cmF0dW0NCg0KT24gVHVlLCBBcHIgMjQsIDIwMTggYXQgMDE6MDY6MTRQTSArMDEwMCwgTWF0dCBS
ZWRmZWFybiB3cm90ZToNCj4gPj4gKy8qIEV4dGVybmFsU3luYyAqLw0KPiA+PiArI2RlZmluZSBN
SVBTX0NPTkY3X0VTCQkoX1VMQ0FTVF8oMSkgPDwgOCkNCj4gDQo+IFNpbmNlIHRoZSBjb25maWc3
IHJlZ2lzdGVyIGlzIGltcGxlbWVudGF0aW9uIHNwZWNpZmljLCBtYXkgSSBzdWdnZXN0IA0KPiBj
aGFuZ2luZyB0aGUgTUlQU18gcHJlZml4IHRvIHNvbWV0aGluZyB2ZW5kb3Igc3BlY2lmaWMgc3Vj
aCBhcw0KPiBCUkNNX0NPTkY3X0VTIGFuZCBzdGFydCBhIG5ldyBzZWN0aW9uIHdpdGggYSBjb21t
ZW50IGxpa2U6DQo+IA0KPiAvKiBDb25maWc3IEJpdHMgc3BlY2lmaWMgdG8gQnJvYWRjb20gaW1w
bGVtZW50YXRpb25zICovDQoNClNlZSBoZXJlOg0KDQo+ID4+ICsJY2FzZSBDUFVfNzRLOg0KDQpT
byBpdHMgTUlQUyA3NEsgc3BlY2lmaWMsIGFuZCBzb21lIG90aGVyIGNvcmVzIGhhdmUgaXQgdG9v
IChJIGNoZWNrZWQNClA1NjAwIGFuZCBpbnRlckFwdGl2IG1hbnVhbHMsIHNvIEknZCBndWVzcyBt
b3N0IHJlY2VudGlzaCBNSVBTIGNvcmVzKS4NCg0KU28gbWF5YmUgaXRzIHdvcnRoIHMvTUlQUy9N
VEkvIHRvIGNsYXJpZnkgaXQgaXNuJ3QgcGFydCBvZiB0aGUgTUlQUzMyDQphcmNoaXRlY3R1cmUu
DQoNCk5vdGUgdGhhdCB0aGUgc2FtZSBhcHBsaWVzIHRvIGFsbCB0aGUgQ09ORjYgYW5kIENPTkY3
IGRlZmluaXRpb25zIGFyb3VuZA0KdGhlcmUsIGJ1dCBpdHMgd29ydGggZ2V0dGluZyB0aGlzIG9u
ZSByaWdodCBub3cgSSB0aGluaywgbGV0cyBub3QNCnVubmVjZXNzYXJpbHkgYWRkIGEgbmV3IGRl
ZmluaXRpb24gYW5kIGhhdmUgdG8gcmVuYW1lIGl0IGxhdGVyLg0KDQpDaGVlcnMNCkphbWVzDQo=
