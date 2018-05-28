Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 May 2018 03:47:25 +0200 (CEST)
Received: from mail1.bemta8.messagelabs.com ([216.82.243.207]:56954 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992759AbeE1BrQYxgW9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 May 2018 03:47:16 +0200
Received: from [216.82.242.36] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-15.bemta-8.messagelabs.com id B2/F0-22406-2AF5B0B5; Mon, 28 May 2018 01:47:14 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSWUwTURSGezvTzqgUL4WGI1qXGhMltgouaZA
  H1Je+GLcYo1VwqmPb2AU7FSEmbg+grSiIRanElRgBcakYtC4R1CANLqkbGlEIYEQkLnWJEpdO
  Z3B5++/9zv3Pf08OTSiD8hSazXezLgdj08iHktOv72G1R3OGGadG2jL0HR1eSv+wd4m+9PZHU
  l/i20vpT7WwWTJD14/XpOGSv50yvOy5RhgCNTvlhlvVddIFsuUyq8PkzF8ls/SXd1C5T+PzfT
  8St6Lr8R40lFbiHQgqmu8iDxpCA94E1Q1+ggeAfyEI7bpGCFVlBBzob6P4A4lrCWgIV4qkXAq
  HjlbLhcMLBJ5zr2S8mRzPgMs9AySvk/ASKO17HntB4AYEzzwROQ8S8SJor3ohF4oWw9Xt9whB
  p0N95EIsFYknQKjsbcxIgVfA58pOitdKnAWnDwZiegieDcc+PY5phNVQFtwm5TWBkyFcdkwu/
  A5D1RXBH7AKert+ygQ9Duq9O8UaNYQPe5EwgYsknGztF4EW3vt84mi2Izj3PSSCVIi8axY7Z0
  NrYIc4y0woauyhBL0Obr7tFTtnQNWNAfF+NNQUd5IlKM3/T1g/oqN6EpwJThGux8E+byflj/0
  /AVoquskjiKxBEznWlce6tNNn6Ewuq9nitjNWmzZtql5nZzmOMbM2xsTpVjvtARTdoy0SCbqI
  ft40NqERtFSjUuhLaaMy3uRcU2BhOEuOa4ON5ZrQKJrWgMKbPcyoTHCxZjZ/rdUWXcZBDHScJ
  knRsjKKFVwuY+esZgGFkJbuflC+i1CSDqeDTUlWLOI9MF9k2eD4YzG40mGkTklUIIlEoozLZV
  12q/t//gYl00iTqPDwLnFWh/tPpzfRENJoiNO1FB/CzfxFKVvRrPFNG81qaY9OfVZSUpDXev5
  bzhO24viHbmx1pu9tKFx6yaH6lGr8WljwKKNxQdLICpvpzq3Auq8z2waaQydU9jTD+rnFn+f0
  webiTN20ou72xq7g5Md5dc8+RrLvpzbF+4K7x58ZnvV+dHgM/jJPlT7/7v7jzMOx7KhlC78lr
  +4r0JCchUlLJVwc8xsSqVkAzQMAAA==
X-Env-Sender: ikegami@allied-telesis.co.jp
X-Msg-Ref: server-3.tower-94.messagelabs.com!1527472033!188489944!1
X-Originating-IP: [52.192.143.101]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 80362 invoked from network); 28 May 2018 01:47:13 -0000
Received: from mo.allied-telesis-co-jp.hdemail.jp (HELO mo.allied-telesis-co-jp.hdemail.jp) (52.192.143.101)
  by server-3.tower-94.messagelabs.com with SMTP; 28 May 2018 01:47:13 -0000
Received: by mo.allied-telesis-co-jp.hdemail.jp (hde-mf-postfix, from userid 504)
        id E90D0294002; Mon, 28 May 2018 10:47:12 +0900 (JST)
X-Received: from unknown (HELO mo.allied-telesis-co-jp.hdemail.jp) (127.0.0.1)
  by 0 with SMTP; 28 May 2018 10:47:12 +0900
X-Received: from mo.allied-telesis-co-jp.hdemail.jp (localhost.localdomain [127.0.0.1])
        by mo.allied-telesis-co-jp.hdemail.jp (hde-ma-postfix) with ESMTP id 9CDC71AC001;
        Mon, 28 May 2018 10:47:12 +0900 (JST)
        (envelope-from ikegami@allied-telesis.co.jp)
Received: from JPN01-TY1-obe.outbound.protection.outlook.com (mail-ty1jpn01lp0183.outbound.protection.outlook.com [23.103.139.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mo.allied-telesis-co-jp.hdemail.jp (hde-mf-postfix) with ESMTPS id 95E19294001;
        Mon, 28 May 2018 10:47:12 +0900 (JST)
        (envelope-from ikegami@allied-telesis.co.jp)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atjp.onmicrosoft.com;
 s=selector1-alliedtelesis-co-jp01e;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6C6Hb8S3TcUuAMijqrxov2sF7BiXRaQwyXphX+LwMw=;
 b=q/PzgY8pqSzFlQmzpv8iw6cveQHDujVKi6iWXGF4kZWM0b2+hbRHPwOYa07+h1MHWWiYH3xbGHzZYevrLZmeSKaBoeotFhAbZCSb1xuliH4NeRgWmjqq9iIT/d0b9JHG37DiUtM+BmPqjo1AOlqcDyE77ydBhz/yW6UGYGnW0Q4=
Received: from TY1PR01MB0954.jpnprd01.prod.outlook.com (10.167.157.141) by
 TY1PR01MB0409.jpnprd01.prod.outlook.com (10.167.155.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.797.11; Mon, 28 May 2018 01:47:11 +0000
Received: from TY1PR01MB0954.jpnprd01.prod.outlook.com
 ([fe80::6033:a971:9df0:62c]) by TY1PR01MB0954.jpnprd01.prod.outlook.com
 ([fe80::6033:a971:9df0:62c%13]) with mapi id 15.20.0797.017; Mon, 28 May 2018
 01:47:10 +0000
From:   IKEGAMI Tokunori <ikegami@allied-telesis.co.jp>
To:     IKEGAMI Tokunori <ikegami@allied-telesis.co.jp>,
        James Hogan <jhogan@kernel.org>
CC:     PACKHAM Chris <chris.packham@alliedtelesis.co.nz>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Rafa~B Mi~Becki <zajec5@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH v2 0/1] MIPS: BCM47XX: Apply BCM5300X PCIe erratum
 workaround
Thread-Topic: [PATCH v2 0/1] MIPS: BCM47XX: Apply BCM5300X PCIe erratum
 workaround
Thread-Index: AQHT9hpdNUEFHo809kquIA7jTxCbYaREXc2g
Date:   Mon, 28 May 2018 01:47:10 +0000
Message-ID: <TY1PR01MB095451ED26B92752BFB11937DC6E0@TY1PR01MB0954.jpnprd01.prod.outlook.com>
References: <20180528002451.2622-1-ikegami@allied-telesis.co.jp>
In-Reply-To: <20180528002451.2622-1-ikegami@allied-telesis.co.jp>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [61.215.194.29]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB0409;7:SOu3R+edFBq8g+T9/pCBVkSmu3iRs2Ng8zdf6kUbjLJc/f8VXMpDd22lgr5y5kQFSjK50Ud/jH4O5qHM9TI0k0Yvg/HWevl7BpqHdrrCdC368eNOMPtf89iAqhqlxHcAhAx2gP8ns6Rjr2/kutF171tMkan109WiKR2n+PdErFlxT/h+O84lLtNdc54ve6NioGUPzJS84q/qnpLKu6AaoFytFBzCB/Y3g1w+HpkwyOdrDIj6C4CAhrlkpRZsmV8U;20:NLnv/oajTxSfghAsrT96r+/tvNIXbi0BtoyFWM9W6ucq9cZy3xMB1hDiVDbfbMSWOPMHJH29767I9EhYMHaCVKH9ZRE7nJHZpNzOn2qxPvs8fbUuIF7nMLjYaxmxQp/gQOlCHflljIu0c00R3LhsarL5ZFu3zNpp3j/nWrXrL8E1mHHHLU5RFyP7hQ2rZDaO8iU2xl4BwzHy7lBFVF3SZs5+19u4wM0LLRlLaugZVHnOZfm8lHQboZKjPIRQQOcM
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB0409;
x-ms-traffictypediagnostic: TY1PR01MB0409:
x-ld-processed: 1a8a37cf-9ecc-4cef-abb0-1ab01a15a6ad,ExtAddr
x-microsoft-antispam-prvs: <TY1PR01MB0409C9F094143158E338743DDC6E0@TY1PR01MB0409.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:TY1PR01MB0409;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB0409;
x-forefront-prvs: 06860EDC7B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(376002)(346002)(366004)(39840400004)(189003)(199004)(13464003)(54534003)(105586002)(2906002)(476003)(54906003)(53936002)(110136005)(66066001)(2900100001)(97736004)(486006)(76176011)(55016002)(68736007)(9686003)(7696005)(316002)(99286004)(6116002)(8676002)(4326008)(102836004)(3846002)(74482002)(6246003)(26005)(81166006)(81156014)(106356001)(229853002)(14454004)(5660300001)(3280700002)(5250100002)(8936002)(39060400002)(6436002)(3660700001)(59450400001)(86362001)(74316002)(7736002)(33656002)(305945005)(478600001)(446003)(53546011)(25786009)(6506007)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB0409;H:TY1PR01MB0954.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: allied-telesis.co.jp does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: dXNveKCZQofaqVtOCefaSYr+bo1BdjoGV7VhrpcWreUEn/OFcQGSlxUElavT4xS5gzk6mPOqVofR83odW5VcGUWepLu6PTelEYgvLJIH389QjVceZHuPBVOYvW5b5zx5BAn1ZAJYvRrhj/G32Gk7OLHFxDS2Sf3K/tHBc6Eq2YN41aWkycRsMVXhsbsrTZEy
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: ad556e7a-9e05-47b0-d349-08d5c43cedcf
X-OriginatorOrg: allied-telesis.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ad556e7a-9e05-47b0-d349-08d5c43cedcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2018 01:47:10.9226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1a8a37cf-9ecc-4cef-abb0-1ab01a15a6ad
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB0409
Return-Path: <ikegami@allied-telesis.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64080
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

SGksDQoNClNvcnJ5IGEgY2hhbmdlbG9nIGhhcyBub3QgYmVlbiBkZXNjcmliZWQgYnkgdGhlIHYy
IHBhdGNoIHNvIGxldCBtZSBzZW5kIG1haWwgYWJvdXQgdGhpcy4NClRoZXJlIGlzIG5vIGNoYW5n
ZSBmcm9tIHRoZSB2MSBwYXRjaCB0aGF0IHdhcyByZXNlbnQgdG8gZml4IHRoZSByZXZpZXcgY29t
bWVudHMgZm9yIHRoZSBvcmlnaW5hbCB2MSBwYXRjaC4NCiAgTm90ZTogVGhlIHYxIHBhdGNoIHdh
cyBjaGFuZ2VkIGJlbG93IGZvciB0aGUgcmV2aWV3IGNvbW1lbnRzLg0KICAgICAgICAtIFVzZSBz
ZXRfYzBfY29uZmlnNyBpbnN0ZWFkIG9mIHdyaXRlX2MwX2NvbmZpZzcuDQoNClJlZ2FyZHMsDQpJ
a2VnYW1pDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVG9rdW5vcmkg
SWtlZ2FtaSBbbWFpbHRvOmlrZWdhbWlAYWxsaWVkLXRlbGVzaXMuY28uanBdDQo+IFNlbnQ6IE1v
bmRheSwgTWF5IDI4LCAyMDE4IDk6MjUgQU0NCj4gVG86IEphbWVzIEhvZ2FuDQo+IENjOiBJS0VH
QU1JIFRva3Vub3JpOyBQQUNLSEFNIENocmlzOyBIYXVrZSBNZWhydGVuczsgUmFmYX5CIE1pfkJl
Y2tpOw0KPiBsaW51eC1taXBzQGxpbnV4LW1pcHMub3JnDQo+IFN1YmplY3Q6IFtQQVRDSCB2MiAw
LzFdIE1JUFM6IEJDTTQ3WFg6IEFwcGx5IEJDTTUzMDBYIFBDSWUgZXJyYXR1bQ0KPiB3b3JrYXJv
dW5kDQo+IA0KPiBUaGUgd29ya2Fyb3VuZCBpcyB0byBlYW5ibGUgRXh0ZXJuYWxTeW5jIG1vZGUg
YW5kIGl0IGlzIGltcGxlbWVudGVkIG9uIENGRS4NCj4gQnV0IHRvIGVuYWJsZSB0aGlzIHdpdGhv
dXQgQ0ZFIGltcGxlbWVudGVkIGl0IGFkZCB0aGUgd29ya2Fyb3VuZCBpbnRvIExpbnV4Lg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogVG9rdW5vcmkgSWtlZ2FtaSA8aWtlZ2FtaUBhbGxpZWQtdGVsZXNp
cy5jby5qcD4NCj4gQ2M6IENocmlzIFBhY2toYW0gPGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNp
cy5jby5uej4NCj4gQ2M6IEhhdWtlIE1laHJ0ZW5zIDxoYXVrZUBoYXVrZS1tLmRlPg0KPiBDYzog
UmFmYX5CIE1pfkJlY2tpIDx6YWplYzVAZ21haWwuY29tPg0KPiBDYzogbGludXgtbWlwc0BsaW51
eC1taXBzLm9yZw0KPiANCj4gVG9rdW5vcmkgSWtlZ2FtaSAoMSk6DQo+ICAgTUlQUzogQkNNNDdY
WDogRW5hYmxlIE1JUFMzMiA3NEsgQ29yZSBFeHRlcm5hbFN5bmMgZm9yIEJDTTQ3WFggUENJZQ0K
PiAgICAgZXJyYXR1bQ0KPiANCj4gIGFyY2gvbWlwcy9pbmNsdWRlL2FzbS9taXBzcmVncy5oIHwg
IDMgKysrDQo+ICBhcmNoL21pcHMva2VybmVsL2NwdS1wcm9iZS5jICAgICB8IDEyICsrKysrKysr
KysrLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+IA0KPiAtLQ0KPiAyLjE2LjENCg0K
