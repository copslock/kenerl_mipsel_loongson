Return-Path: <SRS0=1crz=QO=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80484C282C2
	for <linux-mips@archiver.kernel.org>; Thu,  7 Feb 2019 19:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD912147C
	for <linux-mips@archiver.kernel.org>; Thu,  7 Feb 2019 19:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="XpfAwY4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfBGTm1 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:42:27 -0500
Received: from mail-eopbgr740104.outbound.protection.outlook.com ([40.107.74.104]:22215
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726401AbfBGTm1 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 7 Feb 2019 14:42:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmCAU7dzgrJTA05DC0VlDsI/1uhUv1K8L+knFtKD1vU=;
 b=XpfAwY4G8U392VpEnpzYm4+3KcSL3rvce0YhfXi7XsDMuIwzmBKmH3kwBJjT170XrCDoM7cfRfuY2DMLmBAtapI1YhScYnQ1FFPQyNOo6WUkrmDmNwXd1wS1YcGKHCzO3lqXnc5simUGHDsWKiaicO7WvGzzUX59lz7+QZDADO8=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1038.namprd22.prod.outlook.com (10.174.167.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Thu, 7 Feb 2019 19:42:20 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Thu, 7 Feb 2019
 19:42:20 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Workaround bugged BCM4704 & BCM5354 that crash with
 kmap_coherent()
Thread-Topic: [PATCH] MIPS: Workaround bugged BCM4704 & BCM5354 that crash
 with kmap_coherent()
Thread-Index: AQHUvv0YjlnhFMEPoUCFp7JVR25f/qXUvH0A
Date:   Thu, 7 Feb 2019 19:42:20 +0000
Message-ID: <20190207194218.dapt5wz4y7ehzjy2@pburton-laptop>
References: <20190207155200.16880-1-zajec5@gmail.com>
In-Reply-To: <20190207155200.16880-1-zajec5@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0017.namprd08.prod.outlook.com
 (2603:10b6:a03:100::30) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1038;6:bI8vEDbmOd/2w+HoCs1cr1ANI0KIsIF3y20tgqeqc9hHDuHsWmQrh8wOXlZxz6JIF3REdGuAHJw1H8lSA9adZXW7sB40QnJLxEHLAfTO1xzcAzrhloKZKMuB5H/htSHpAMx1hKnnEHmh4/jlLEZh+8Ua5HHlf2XYxUiQci4vW3x5TSFp+KsrxGNtQDmBRzJiKalZlGEcuC7AAty+tAZv7Z6P24NoYPTsYi9t8XnfRGyR2RLXr/Yr0HWiJmFwD0H/CAWKxKCf2SlT69g9siG7qFAZBTzAuibotp+F1l+QelxWORItX1JPGYREUjTeUy8orOW5lv64KksTxYTfK2h1diLnPt5CvVRGUMTwdSc70vAyDfnyMaMhSvvyVk7tO35tDoUJKqCLE2qUfGS1/cXSYsS9PTE3dUtsZev2+05Jp1NXSjOD+Eup4oA3nBbG5pXxaIGc3DP+GoZAhAqvguQMYA==;5:GoCNNwRPUT2VEu6L5tMkB0jyliS0iF0ClalGoexlTtNqDTV+FARMszpgo19pPuwNMZejmFSomYO9uCmXZGpiTgtrl/4cshvcZAOrrpknZ0uyZUXs6CPz7A9qWAvOCoUjPNq3nx0dNoeQO5lahbmTn+d7fPO0xHCjJ9QgnKCDrnWjlXDxHsqbRvJpKwJCwLzAcOKM8IiA9Jda9Hy2mX+Tjw==;7:ixoIqtNY7n0RYZjtlRDNjsRBMMJ7UnrvWR2JeyN87U75LMs+ajpcXCOV9DQz5XefDamnJcvrxiJdJCD7thSq7c+2HpP5+y5o0sy4rnVDgoKlc3pLylIlRpc3OuO6nqhUJfncBzcFFdEAhO8CgNvhMA==
x-ms-office365-filtering-correlation-id: 6223cd91-3820-496a-742a-08d68d345f7e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1038;
x-ms-traffictypediagnostic: MWHPR2201MB1038:
x-microsoft-antispam-prvs: <MWHPR2201MB10389ACA65BF531B2AE5C805C1680@MWHPR2201MB1038.namprd22.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(396003)(136003)(39840400004)(346002)(376002)(189003)(199004)(71190400001)(14454004)(186003)(106356001)(2906002)(42882007)(105586002)(52116002)(33896004)(71200400001)(81166006)(486006)(1411001)(33716001)(8936002)(6436002)(76176011)(305945005)(11346002)(446003)(68736007)(229853002)(53936002)(7736002)(102836004)(6486002)(44832011)(81156014)(8676002)(6246003)(25786009)(6512007)(9686003)(6916009)(1076003)(476003)(66066001)(7416002)(6116002)(4326008)(478600001)(3846002)(316002)(386003)(99286004)(256004)(58126008)(54906003)(6506007)(97736004)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1038;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fhYuqEpDeOL5OafNmZsZdMGnTdkpQe2gTEsO95ka6+Th2dBBxlvgQqvcGdheC+Jb3sTd8miS4wCWisVOWR9hJuHDhNOuAlEGKTz4DM8fY7HCcRIomA3yF3/WT3pzZO1gMByUCVNzJ5wWg6thimv7LX6BdcArJRNbPtA6XQB5V52IlI03vTqWD49+QMa+xU1pQr6eWWrgwEuTemGNW2wuejuqF/jJ9I6AoREU1kLkuR5Ru8ZMB5q8cnqlYrYHqjt1SvD/+heTjsO2r2jBFyegcJ/6WpBX4H1e6yBJDUg1ddZ9xcc0gUpv46+LSt2Zbw9QbjYQ2Jm9F94Ou0gT2ZSPu4Kfe9fw9T8WEVg35Y+ZluwlBO0+W/caSneZnU9Ra/RZZ30eQNlmq7Zt8uYkn+MD1NsCBLjh2IHGxP2jiVqJgy0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16F460C49825D046940DFA23AEC9D34F@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6223cd91-3820-496a-742a-08d68d345f7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 19:42:19.8861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1038
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

SGkgUmFmYcWCLA0KDQpPbiBUaHUsIEZlYiAwNywgMjAxOSBhdCAwNDo1MjowMFBNICswMTAwLCBS
YWZhxYIgTWnFgmVja2kgd3JvdGU6DQo+IEZyb206IFJhZmHFgiBNacWCZWNraSA8cmFmYWxAbWls
ZWNraS5wbD4NCj4gDQo+IFRoaXMgd29ya2Fyb3VuZHMgd2hhdCBzZWVtcyB0byBiZSBhIGhhcmR3
YXJlIGJ1ZyBwcmVzZW50IGluIHNvbWUgZWFybHkNCj4gQnJvYWRjb20gTUlQUyBDUFVzLiBGb3Ig
c29tZSByZWFzb24gdXNpbmcga21hcF9jb2hlcmVudCgpIGZvciBjb3B5aW5nIGENCj4gbWVtb3J5
IGNhdXNlcyBhICJEYXRhIGJ1cyBlcnJvciIgb3IgU29DIHJlYm9vdC4NCj4NCj4lDQo+DQo+IGRp
ZmYgLS1naXQgYS9hcmNoL21pcHMvaW5jbHVkZS9hc20vbWFjaC1iY200N3h4L2NwdS1mZWF0dXJl
LW92ZXJyaWRlcy5oIGIvYXJjaC9taXBzL2luY2x1ZGUvYXNtL21hY2gtYmNtNDd4eC9jcHUtZmVh
dHVyZS1vdmVycmlkZXMuaA0KPiBpbmRleCBiMjNmZjQ3ZWE0NzUuLjU1MzUwNWRlYTYwYiAxMDA2
NDQNCj4gLS0tIGEvYXJjaC9taXBzL2luY2x1ZGUvYXNtL21hY2gtYmNtNDd4eC9jcHUtZmVhdHVy
ZS1vdmVycmlkZXMuaA0KPiArKysgYi9hcmNoL21pcHMvaW5jbHVkZS9hc20vbWFjaC1iY200N3h4
L2NwdS1mZWF0dXJlLW92ZXJyaWRlcy5oDQo+IEBAIC04MCw0ICs4MCwxMiBAQA0KPiAgI2RlZmlu
ZSBjcHVfc2NhY2hlX2xpbmVfc2l6ZSgpCQkwDQo+ICAjZGVmaW5lIGNwdV9oYXNfdnoJCQkwDQo+
ICANCj4gKy8qDQo+ICsgKiBXb3JrYXJvdW5kIGZvciB0aGUgYnVnZ2VkIEJDTTQ3MDQgJiBCQ001
MzU0Og0KPiArICogY29weV9mcm9tX3VzZXJfcGFnZSgpICsga21hcF9jb2hlcmVudCgpIGNhdXNl
cyAiRGF0YSBidXMgZXJyb3IiDQo+ICsgKiBjb3B5X3RvX3VzZXJfcGFnZSgpICsga21hcF9jb2hl
cmVudCgpIGNhdXNlcyBpbW1lZGlhdGUgcmVib290DQo+ICsgKi8NCj4gKyNkZWZpbmUgY3B1X2hh
c19rbWFwX2NvaGVyZW50CQkoY3B1X2RhdGFbMF0ucHJvY2Vzc29yX2lkICE9IDB4MjkwMDYgJiYg
XA0KPiArCQkJCQkgY3B1X2RhdGFbMF0ucHJvY2Vzc29yX2lkICE9IDB4MjkwMjkpDQo+ICsNCj4g
ICNlbmRpZiAvKiBfX0FTTV9NQUNIX0JDTTQ3WFhfQ1BVX0ZFQVRVUkVfT1ZFUlJJREVTX0ggKi8N
Cj4gZGlmZiAtLWdpdCBhL2FyY2gvbWlwcy9tbS9pbml0LmMgYi9hcmNoL21pcHMvbW0vaW5pdC5j
DQo+IGluZGV4IGMzYjQ1ZTI0ODgwNi4uNjcwMDdiZjE1NTQzIDEwMDY0NA0KPiAtLS0gYS9hcmNo
L21pcHMvbW0vaW5pdC5jDQo+ICsrKyBiL2FyY2gvbWlwcy9tbS9pbml0LmMNCj4gQEAgLTE3NCw3
ICsxNzQsNyBAQCB2b2lkIGNvcHlfdXNlcl9oaWdocGFnZShzdHJ1Y3QgcGFnZSAqdG8sIHN0cnVj
dCBwYWdlICpmcm9tLA0KPiAgCXZvaWQgKnZmcm9tLCAqdnRvOw0KPiAgDQo+ICAJdnRvID0ga21h
cF9hdG9taWModG8pOw0KPiAtCWlmIChjcHVfaGFzX2RjX2FsaWFzZXMgJiYNCj4gKwlpZiAoY3B1
X2hhc19rbWFwX2NvaGVyZW50ICYmIGNwdV9oYXNfZGNfYWxpYXNlcyAmJg0KPiAgCSAgICBwYWdl
X21hcGNvdW50KGZyb20pICYmICFQYWdlX2RjYWNoZV9kaXJ0eShmcm9tKSkgew0KPiAgCQl2ZnJv
bSA9IGttYXBfY29oZXJlbnQoZnJvbSwgdmFkZHIpOw0KPiAgCQljb3B5X3BhZ2UodnRvLCB2ZnJv
bSk7DQoNCldvbid0IHRoaXMgaW50cm9kdWNlIGNhY2hlIGFsaWFzaW5nIHByb2JsZW1zPw0KDQpU
aGUgcmVhc29uIGZvciB1c2luZyBrbWFwX2NvaGVyZW50IGF0IGFsbCBpcyB0byBlbnN1cmUgd2Ug
dXNlIGEgbWFwcGluZw0Kd2l0aCB0aGUgc2FtZSBjYWNoZSBjb2xvdXJpbmcgYXMgdGhlIHVzZXIn
cyBtYXBwaW5nLiBJZiB0aGUgQ1BVIHN1ZmZlcnMNCmZyb20gZGNhY2hlIGFsaWFzaW5nICYgd2Ug
ZG9uJ3QgZG8gdGhhdCBjb2xvdXJpbmcgdGhlbiBpdCBzZWVtcyBsaWtlDQp0aGlzIG1pZ2h0IGxl
YWQgdG8gdXMgcmVhZGluZy9jb3B5aW5nIHN0YWxlIGRhdGE/DQoNClRoYW5rcywNCiAgICBQYXVs
DQo=
