Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Sep 2018 09:30:23 +0200 (CEST)
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:12915 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991063AbeICHaQoC75e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Sep 2018 09:30:16 +0200
X-IronPort-AV: E=Sophos;i="5.53,324,1531810800"; 
   d="scan'208";a="19977861"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Sep 2018 00:29:48 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 3 Sep 2018 00:29:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elXRJKqpxhlymoPi44YK+e0GCZqblfa71evPISY45y8=;
 b=YkF5aiNsTVJ2yuD84JYun8jpV6VU5RTkBgSuizSOcwLnfjSKr6MnJuJGGMaxsPOiy9sIn4+bxGD48UK3Cbuumpbt4ToIBq6pN9VdtO/0w5dNnC3YWXQHjQ8F5BX9O1Vfpc5AHLKff2im+ZbOsAo8MoTUUOnZejKLRQCvP+vJFt0=
Received: from CY4PR11MB0069.namprd11.prod.outlook.com (10.171.254.158) by
 CY4PR11MB1607.namprd11.prod.outlook.com (10.172.71.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.17; Mon, 3 Sep 2018 07:29:46 +0000
Received: from CY4PR11MB0069.namprd11.prod.outlook.com
 ([fe80::c1e3:bfb:bd3e:d922]) by CY4PR11MB0069.namprd11.prod.outlook.com
 ([fe80::c1e3:bfb:bd3e:d922%2]) with mapi id 15.20.1080.020; Mon, 3 Sep 2018
 07:29:46 +0000
From:   <Rene.Nielsen@microchip.com>
To:     <hauke@hauke-m.de>, <paul.burton@mips.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-mips@linux-mips.org>, <jhogan@kernel.org>,
        <stable@vger.kernel.org>, <rene.nielsen@microsemi.com>
Subject: RE: [PATCH] MIPS: VDSO: Match data page cache colouring when D$
 aliases
Thread-Topic: [PATCH] MIPS: VDSO: Match data page cache colouring when D$
 aliases
Thread-Index: AQHUQIvMxxMZtjRaY0+gv9gK9oaxQaTZ+OqAgAQ1wwA=
Date:   Mon, 3 Sep 2018 07:29:45 +0000
Message-ID: <CY4PR11MB00699EEA41CC36E15B051613990C0@CY4PR11MB0069.namprd11.prod.outlook.com>
References: <20180828160254.GC16561@piout.net>
 <20180830180121.25363-1-paul.burton@mips.com>
 <7f92c83f-3f23-8dd2-31ca-aaf268d52bed@hauke-m.de>
In-Reply-To: <7f92c83f-3f23-8dd2-31ca-aaf268d52bed@hauke-m.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rene.Nielsen@microchip.com; 
x-originating-ip: [82.163.121.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR11MB1607;6:oOSpwgq5cwr8J1MQuLZkKIkp9gSnQQRQ/wIC80RWBwL2sJ5WEDkS1X3NehFGV9U9aIb+2n0aw2klmocfGWjTYI7O4y5ocqBED+ntwJ+p5RLQG+Wy6BhusnIQkyR27G4Lpp9jMG3w7VkacKKdrJbkAg5Vj5lS8P6Hcbl7Gh8MzdPl2AMLCWdHDBOMNdzzFegOOejAysyHIM6NtnHpcTnlMiVP20KHo4Ad0bCQpjsfV0pzzijzFbqFNvuAdmnaIKd7EMZknOgJFCCTZLQNnEC9DCXFWzRUP3AvF36XJ7NsYOUL6iOTuiQdLbcZm3LF87PwIGd7I7rcAKGbTh9Mp0mBuqOvHiPpZewn5NkD9v+OizMMKv4eSrNVoM8Ur7aFO9DAi9S/TXYngiOZWnNRjS0jN+qLLL0WPJZZMbMe/ya0UQrw9l9mQZiElRq5ra2Z2nGfXFzDQSrG58fwKIa/10g3DQ==;5:t0hUFQ4E123PKHQKeDECTxTIWMfcMBGW17haEqeCK+fyJnH3UIOi7BYwfr4Ig78w1OFq8x7t4kNCOz7T6tzLonL8ebQZnWfrjsRd2hjw2J0HsN9Gqx7F7ccbqRGAOQhRW9JBWOI6gyg/0YiMGmCLORDx6iZ/ZCPmE/UK9mggOQw=;7:HnjHVJ1iCNUaj+zZ/0eyZG/eb6M93jxv8jmEmgYnY91f0EN2XPrMaLu8LAsUCQD47v67u+mXPZOZMJ+bfQrC8118sN8UOEMohe5RjiHOnRYjhdthF6+z0Qm7DuzXsRqFs81LtINp48v628PRfhHuHr8S+pmUooODsuGH9AA6RsW5RW1QnTbTXnOWdCENSQv5CLtFHx6uigJruin8l9838nPoNRx0wTTvL+rc+Vw1GC0+U9+/jYiQE9r9pkdzzgDR
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a357ceb6-947e-41ce-d7af-08d6116f0619
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR11MB1607;
x-ms-traffictypediagnostic: CY4PR11MB1607:
x-microsoft-antispam-prvs: <CY4PR11MB1607A5A85AE1179F5227B2D1990C0@CY4PR11MB1607.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(190756311086443)(9452136761055)(72170198267865);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:CY4PR11MB1607;BCL:0;PCL:0;RULEID:;SRVR:CY4PR11MB1607;
x-forefront-prvs: 0784C803FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(396003)(136003)(346002)(189003)(199004)(76176011)(446003)(25786009)(53546011)(81166006)(5660300001)(86362001)(7696005)(72206003)(8936002)(99286004)(3846002)(6116002)(6246003)(106356001)(68736007)(6506007)(102836004)(4326008)(2906002)(186003)(5250100002)(105586002)(26005)(316002)(74316002)(53936002)(8676002)(486006)(81156014)(11346002)(33656002)(229853002)(97736004)(14454004)(7736002)(305945005)(66066001)(2900100001)(110136005)(9686003)(6436002)(54906003)(55016002)(256004)(14444005)(476003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB1607;H:CY4PR11MB0069.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mRmWcUXBFfFVpfTbwlNnLlUJr6eE7U/FK1fhSRw2/x0l1SP1HL1kJDDFOnjAO9IR1ttLhg9Dn3MAp7d4Knb/pepunlegdGBrGvaRUYXXL3OlqHySUrvF0xwghZi4mWDWYfrBHKvYzds72qnnBCX3ItOwcHGpIeXj88q2TLcOR++jgdyb8hHuAOVRs3BW2b608Bq/5OhIA/uaLShXOtiBWTcQLpV6UMmGI0iWGXOlD9lDDg/DIgsGrx/0oOG33QLVVepo3QxhawZbFsxqyuk2V3i04bZ9rZxUh04RDfrYv9cWyaGqM9nkgSKOQ7RyXf6UwM8oZF0Kdcowm+y2IhswVg1LPUkB4mcuVVDEpEi8JQU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a357ceb6-947e-41ce-d7af-08d6116f0619
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2018 07:29:45.9652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1607
X-OriginatorOrg: microchip.com
Return-Path: <Rene.Nielsen@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Rene.Nielsen@microchip.com
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

T24gMDgvMzEvMjAxOCAwNToxMiBQTSwgSGF1a2UgTWVydGVucyB3cm90ZToNCj4gT24gMDgvMzAv
MjAxOCAwODowMSBQTSwgUGF1bCBCdXJ0b24gd3JvdGU6DQo+PiBXaGVuIGEgc3lzdGVtIHN1ZmZl
cnMgZnJvbSBkY2FjaGUgYWxpYXNpbmcgYSB1c2VyIHByb2dyYW0gbWF5IG9ic2VydmUgDQo+PiBz
dGFsZSBWRFNPIGRhdGEgZnJvbSBhbiBhbGlhc2VkIGNhY2hlIGxpbmUuIE5vdGFibHkgdGhpcyBj
YW4gYnJlYWsgdGhlIA0KPj4gZXhwZWN0YXRpb24gdGhhdCBjbG9ja19nZXR0aW1lKENMT0NLX01P
Tk9UT05JQywgLi4uKSBpcywgYXMgaXRzIG5hbWUgDQo+PiBzdWdnZXN0cywgbW9ub3RvbmljLg0K
Pj4gDQo+PiBJbiBvcmRlciB0byBlbnN1cmUgdGhhdCB1c2VycyBvYnNlcnZlIHVwZGF0ZXMgdG8g
dGhlIFZEU08gZGF0YSBwYWdlIGFzIA0KPj4gaW50ZW5kZWQsIGFsaWduIHRoZSB1c2VyIG1hcHBp
bmdzIG9mIHRoZSBWRFNPIGRhdGEgcGFnZSBzdWNoIHRoYXQgDQo+PiB0aGVpciBjYWNoZSBjb2xv
dXJpbmcgbWF0Y2hlcyB0aGF0IG9mIHRoZSB2aXJ0dWFsIGFkZHJlc3MgcmFuZ2Ugd2hpY2ggDQo+
PiB0aGUga2VybmVsIHdpbGwgdXNlIHRvIHVwZGF0ZSB0aGUgZGF0YSBwYWdlIC0gdHlwaWNhbGx5
IGl0cyB1bm1hcHBlZCANCj4+IGFkZHJlc3Mgd2l0aGluIGtzZWcwLg0KPj4gDQo+PiBUaGlzIGVu
c3VyZXMgdGhhdCB3ZSBkb24ndCBpbnRyb2R1Y2UgYWxpYXNpbmcgY2FjaGUgbGluZXMgZm9yIHRo
ZSBWRFNPIA0KPj4gZGF0YSBwYWdlLCBhbmQgdGhlcmVmb3JlIHRoYXQgdXNlcmxhbmQgd2lsbCBv
YnNlcnZlIHVwZGF0ZXMgd2l0aG91dCANCj4+IHJlcXVpcmluZyBjYWNoZSBpbnZhbGlkYXRpb24u
DQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IFBhdWwgQnVydG9uIDxwYXVsLmJ1cnRvbkBtaXBzLmNv
bT4NCj4+IFJlcG9ydGVkLWJ5OiBIYXVrZSBNZWhydGVucyA8aGF1a2VAaGF1a2UtbS5kZT4NCj4+
IFJlcG9ydGVkLWJ5OiBSZW5lIE5pZWxzZW4gPHJlbmUubmllbHNlbkBtaWNyb3NlbWkuY29tPg0K
Pj4gUmVwb3J0ZWQtYnk6IEFsZXhhbmRyZSBCZWxsb25pIDxhbGV4YW5kcmUuYmVsbG9uaUBib290
bGluLmNvbT4NCj4+IEZpeGVzOiBlYmI1ZTc4Y2M2MzQgKCJNSVBTOiBJbml0aWFsIGltcGxlbWVu
dGF0aW9uIG9mIGEgVkRTTyIpDQo+PiBDYzogSmFtZXMgSG9nYW4gPGpob2dhbkBrZXJuZWwub3Jn
Pg0KPj4gQ2M6IGxpbnV4LW1pcHNAbGludXgtbWlwcy5vcmcNCj4+IENjOiBzdGFibGVAdmdlci5r
ZXJuZWwub3JnICMgdjQuNCsNCg0KPiBUZXN0ZWQtYnk6IEhhdWtlIE1laHJ0ZW5zIDxoYXVrZUBo
YXVrZS1tLmRlPg0KDQpUZXN0ZWQtYnk6IFJlbmUgTmllbHNlbiA8cmVuZS5uaWVsc2VuQG1pY3Jv
Y2hpcC5jb20+DQoNCj4gV2l0aG91dCB0aGlzIHBhdGNoIHBpbmcgc2hvd3MgdGhlc2UgcmVzdWx0
cyBvbiBrZXJuZWwgNC4xOS1yYzEgb24gdGhlIExhbnRpcSBWUjkgU29DIHRvIGEgUEMgZGlyZWN0
bHkgY29ubmVjdGVkIHRvIHRoZSBMQU4gcG9ydDoNCg0KPiByb290QE9wZW5XcnQ6fiMgcGluZyAx
OTIuMTY4LjEuMTk1DQo+IFBJTkcgMTkyLjE2OC4xLjE5NSAoMTkyLjE2OC4xLjE5NSk6IDU2IGRh
dGEgYnl0ZXMNCj4gNjQgYnl0ZXMgZnJvbSAxOTIuMTY4LjEuMTk1OiBzZXE9MCB0dGw9NjQgdGlt
ZT0wLjY4OSBtcw0KPiA2NCBieXRlcyBmcm9tIDE5Mi4xNjguMS4xOTU6IHNlcT0xIHR0bD02NCB0
aW1lPTIzNi41MjcgbXMNCj4gNjQgYnl0ZXMgZnJvbSAxOTIuMTY4LjEuMTk1OiBzZXE9MiB0dGw9
NjQgdGltZT00Mjk0OTYzLjgyOSBtcw0KPiA2NCBieXRlcyBmcm9tIDE5Mi4xNjguMS4xOTU6IHNl
cT0zIHR0bD02NCB0aW1lPTQyOTQ0MjMuODI0IG1zDQo+IDY0IGJ5dGVzIGZyb20gMTkyLjE2OC4x
LjE5NTogc2VxPTQgdHRsPTY0IHRpbWU9OTYwLjUyNyBtcw0KPiA2NCBieXRlcyBmcm9tIDE5Mi4x
NjguMS4xOTU6IHNlcT01IHR0bD02NCB0aW1lPTQ3Mi41MzAgbXMNCj4gNjQgYnl0ZXMgZnJvbSAx
OTIuMTY4LjEuMTk1OiBzZXE9NiB0dGw9NjQgdGltZT00NjQuNTMwIG1zDQo+IDY0IGJ5dGVzIGZy
b20gMTkyLjE2OC4xLjE5NTogc2VxPTcgdHRsPTY0IHRpbWU9NDUyLjUzMCBtcw0KPg0KPiBXaXRo
IHRoaXMgcGF0Y2ggaXQgbG9va3MgbGlrZSB0aGlzOg0KPg0KPnJvb3RAT3BlbldydDp+IyBwaW5n
IDE5Mi4xNjguMS4xOTUNCj4gUElORyAxOTIuMTY4LjEuMTk1ICgxOTIuMTY4LjEuMTk1KTogNTYg
ZGF0YSBieXRlcw0KPiA2NCBieXRlcyBmcm9tIDE5Mi4xNjguMS4xOTU6IHNlcT0wIHR0bD02NCB0
aW1lPTAuNjM4IG1zDQo+IDY0IGJ5dGVzIGZyb20gMTkyLjE2OC4xLjE5NTogc2VxPTEgdHRsPTY0
IHRpbWU9MC41NzMgbXMNCj4gNjQgYnl0ZXMgZnJvbSAxOTIuMTY4LjEuMTk1OiBzZXE9MiB0dGw9
NjQgdGltZT0wLjYwNSBtcw0KPiA2NCBieXRlcyBmcm9tIDE5Mi4xNjguMS4xOTU6IHNlcT0zIHR0
bD02NCB0aW1lPTAuNTI0IG1zDQo+IDY0IGJ5dGVzIGZyb20gMTkyLjE2OC4xLjE5NTogc2VxPTQg
dHRsPTY0IHRpbWU9MC41MzQgbXMNCj4gNjQgYnl0ZXMgZnJvbSAxOTIuMTY4LjEuMTk1OiBzZXE9
NSB0dGw9NjQgdGltZT0wLjUxOCBtcw0KPiA2NCBieXRlcyBmcm9tIDE5Mi4xNjguMS4xOTU6IHNl
cT02IHR0bD02NCB0aW1lPTAuNDg1IG1zDQo+IDY0IGJ5dGVzIGZyb20gMTkyLjE2OC4xLjE5NTog
c2VxPTcgdHRsPTY0IHRpbWU9MC41MDEgbXMNCj4NCj4NCj4+IC0tLQ0KPj4gSGkgQWxleGFuZHJl
LA0KPj4gDQo+PiBDb3VsZCB5b3UgdHJ5IHRoaXMgb3V0IG9uIHlvdXIgT2NlbG90IHN5c3RlbT8g
SG9wZWZ1bGx5IGl0J2xsIHNvbHZlIA0KPj4gdGhlIHByb2JsZW0ganVzdCBhcyB3ZWxsIGFzIEph
bWVzJyBwYXRjaCBidXQgZG9lc24ndCBuZWVkIHRoZSANCj4+IHF1ZXN0aW9uYWJsZSBjaGFuZ2Ug
dG8gYXJjaF9nZXRfdW5tYXBwZWRfYXJlYV9jb21tb24oKS4NCj4+IA0KPj4gVGhhbmtzLA0KPj4g
ICAgIFBhdWwNCj4+IC0tLQ0KPj4gIGFyY2gvbWlwcy9rZXJuZWwvdmRzby5jIHwgMjAgKysrKysr
KysrKysrKysrKysrKysNCj4+ICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKQ0KPj4g
DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9taXBzL2tlcm5lbC92ZHNvLmMgYi9hcmNoL21pcHMva2Vy
bmVsL3Zkc28uYyBpbmRleCANCj4+IDAxOTAzNWQ3MjI1Yy4uNWZiNjE3YTQyMzM1IDEwMDY0NA0K
Pj4gLS0tIGEvYXJjaC9taXBzL2tlcm5lbC92ZHNvLmMNCj4+ICsrKyBiL2FyY2gvbWlwcy9rZXJu
ZWwvdmRzby5jDQo+PiBAQCAtMTMsNiArMTMsNyBAQA0KPj4gICNpbmNsdWRlIDxsaW51eC9lcnIu
aD4NCj4+ICAjaW5jbHVkZSA8bGludXgvaW5pdC5oPg0KPj4gICNpbmNsdWRlIDxsaW51eC9pb3Bv
cnQuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQo+PiAgI2luY2x1ZGUgPGxpbnV4
L21tLmg+DQo+PiAgI2luY2x1ZGUgPGxpbnV4L3NjaGVkLmg+DQo+PiAgI2luY2x1ZGUgPGxpbnV4
L3NsYWIuaD4NCj4+IEBAIC0yMCw2ICsyMSw3IEBADQo+PiAgDQo+PiAgI2luY2x1ZGUgPGFzbS9h
YmkuaD4NCj4+ICAjaW5jbHVkZSA8YXNtL21pcHMtY3BzLmg+DQo+PiArI2luY2x1ZGUgPGFzbS9w
YWdlLmg+DQo+PiAgI2luY2x1ZGUgPGFzbS92ZHNvLmg+DQo+PiAgDQo+PiAgLyogS2VybmVsLXBy
b3ZpZGVkIGRhdGEgdXNlZCBieSB0aGUgVkRTTy4gKi8gQEAgLTEyOCwxMiArMTMwLDMwIEBAIA0K
Pj4gaW50IGFyY2hfc2V0dXBfYWRkaXRpb25hbF9wYWdlcyhzdHJ1Y3QgbGludXhfYmlucHJtICpi
cHJtLCBpbnQgdXNlc19pbnRlcnApDQo+PiAgCXZ2YXJfc2l6ZSA9IGdpY19zaXplICsgUEFHRV9T
SVpFOw0KPj4gIAlzaXplID0gdnZhcl9zaXplICsgaW1hZ2UtPnNpemU7DQo+PiAgDQo+PiArCS8q
DQo+PiArCSAqIEZpbmQgYSByZWdpb24gdGhhdCdzIGxhcmdlIGVub3VnaCBmb3IgdXMgdG8gcGVy
Zm9ybSB0aGUNCj4+ICsJICogY29sb3VyLW1hdGNoaW5nIGFsaWdubWVudCBiZWxvdy4NCj4+ICsJ
ICovDQo+PiArCWlmIChjcHVfaGFzX2RjX2FsaWFzZXMpDQo+PiArCQlzaXplICs9IHNobV9hbGln
bl9tYXNrICsgMTsNCj4+ICsNCj4+ICAJYmFzZSA9IGdldF91bm1hcHBlZF9hcmVhKE5VTEwsIDAs
IHNpemUsIDAsIDApOw0KPj4gIAlpZiAoSVNfRVJSX1ZBTFVFKGJhc2UpKSB7DQo+PiAgCQlyZXQg
PSBiYXNlOw0KPj4gIAkJZ290byBvdXQ7DQo+PiAgCX0NCj4+ICANCj4+ICsJLyoNCj4+ICsJICog
SWYgd2Ugc3VmZmVyIGZyb20gZGNhY2hlIGFsaWFzaW5nLCBlbnN1cmUgdGhhdCB0aGUgVkRTTyBk
YXRhIHBhZ2UgaXMNCj4+ICsJICogY29sb3VyZWQgdGhlIHNhbWUgYXMgdGhlIGtlcm5lbCdzIG1h
cHBpbmcgb2YgdGhhdCBtZW1vcnkuIFRoaXMNCj4+ICsJICogZW5zdXJlcyB0aGF0IHdoZW4gdGhl
IGtlcm5lbCB1cGRhdGVzIHRoZSBWRFNPIGRhdGEgdXNlcmxhbmQgd2lsbCBzZWUNCj4+ICsJICog
aXQgd2l0aG91dCByZXF1aXJpbmcgY2FjaGUgaW52YWxpZGF0aW9ucy4NCj4+ICsJICovDQo+PiAr
CWlmIChjcHVfaGFzX2RjX2FsaWFzZXMpIHsNCj4+ICsJCWJhc2UgPSBfX0FMSUdOX01BU0soYmFz
ZSwgc2htX2FsaWduX21hc2spOw0KPj4gKwkJYmFzZSArPSAoKHVuc2lnbmVkIGxvbmcpJnZkc29f
ZGF0YSAtIGdpY19zaXplKSAmIHNobV9hbGlnbl9tYXNrOw0KPj4gKwl9DQo+PiArDQo+PiAgCWRh
dGFfYWRkciA9IGJhc2UgKyBnaWNfc2l6ZTsNCj4+ICAJdmRzb19hZGRyID0gZGF0YV9hZGRyICsg
UEFHRV9TSVpFOw0KPj4gIA0KPj4gDQoNCg0K
