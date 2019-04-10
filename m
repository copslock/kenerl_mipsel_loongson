Return-Path: <SRS0=erdp=SM=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC27C10F11
	for <linux-mips@archiver.kernel.org>; Wed, 10 Apr 2019 19:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF5420820
	for <linux-mips@archiver.kernel.org>; Wed, 10 Apr 2019 19:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Oz/KE43I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbfDJTWL (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:22:11 -0400
Received: from mail-eopbgr710124.outbound.protection.outlook.com ([40.107.71.124]:59472
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726022AbfDJTWL (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Wed, 10 Apr 2019 15:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MafABQDfec6FK+DGo5J59rnlwMCdOugUEqxvaBKfN7c=;
 b=Oz/KE43IYFb4V+33xiXXXoEep7Mc98/xhSV2M2I4VAX/lPi4crbLPb1QEfb2zcVpGNtXtCOcj7Pv4DM+SciusOhcJEIIFu9TV32zYwICXT4Ckz1hx2t01FmP0dUIRRWK1LcbZIlyLWl9hPmkQ1g4tDegpch4f3y6MLdgwfwnagw=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1055.namprd22.prod.outlook.com (10.174.169.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Wed, 10 Apr 2019 19:22:07 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%7]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 19:22:07 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        "cernekee@gmail.com" <cernekee@gmail.com>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: BMIPS: Add internal Broadcom mailing list
Thread-Topic: [PATCH] MAINTAINERS: BMIPS: Add internal Broadcom mailing list
Thread-Index: AQHU2PwTmL67wH3bhk+mLb5zWpP9SKY182EA
Date:   Wed, 10 Apr 2019 19:22:07 +0000
Message-ID: <MWHPR2201MB12771E0D61D558BD5854B087C12E0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190312175005.21264-1-f.fainelli@gmail.com>
In-Reply-To: <20190312175005.21264-1-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0104.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::45) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0e52c39-ddda-4569-e0ef-08d6bde9d269
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR2201MB1055;
x-ms-traffictypediagnostic: MWHPR2201MB1055:
x-microsoft-antispam-prvs: <MWHPR2201MB1055B1406BE8AC85DA5BA946C12E0@MWHPR2201MB1055.namprd22.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(396003)(366004)(346002)(39850400004)(199004)(189003)(7696005)(486006)(446003)(9686003)(4326008)(6116002)(305945005)(74316002)(99286004)(5660300002)(102836004)(186003)(52536014)(476003)(42882007)(55016002)(6246003)(52116002)(76176011)(106356001)(105586002)(71200400001)(97736004)(25786009)(6506007)(386003)(71190400001)(3846002)(7736002)(53936002)(33656002)(6916009)(6436002)(478600001)(14454004)(54906003)(316002)(26005)(11346002)(66066001)(8676002)(81156014)(44832011)(2906002)(68736007)(81166006)(256004)(4744005)(8936002)(229853002)(223123001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1055;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S8xMIxa/PD7r1Suusx+2MnPEJl8k/v+tKDWWMxPpGnVgWxy//9Zr/MnI4MLtyDoqKEjJzxCvUPd3mDXDmzUCJSIBkWEl+jY1/FKg/8KfUzz6v5MtlkfOErRLhNCxlLu1L/sYeDfC0RlvDdfDe9LyO8iUWvRF4ZVWo4hgxk67YDhzsV4ew/PvR8nGUQQ6k3oQ5pjBgj9xpoHvSgDHNYAokQ4iwHGR6OA2BPT06wwWNQokiY3K9zwZH+PKmZjKThYAUEVr/r5wvk+Na/w6Jxw8KASTV+7uDYeIM/0yt6i4uz2pOQCT0GT8yX5gY1AFzwjzhbIMB2C5El70/pCoifAkYpqSbE67Xk8/YR4dGZ7epIQuMJng4YleTOcQUa0P/HaxD+boxmFGnRSXtZFDXJgzZ2b9Sk5ltR3BXMeYS9xPods=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e52c39-ddda-4569-e0ef-08d6bde9d269
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 19:22:07.7369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1055
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

SGVsbG8sDQoNCkZsb3JpYW4gRmFpbmVsbGkgd3JvdGU6DQo+IFRoZXJlIGlzIGEgcGF0Y2h3b3Jr
IGluc3RhbmNlIGJlaGluZCBiY20ta2VybmVsLWZlZWRiYWNrLWxpc3QgdGhhdCBpcw0KPiBoZWxw
ZnVsIHRvIHRyYWNrIHN1Ym1pc3Npb25zLCBhZGQgdGhpcyBsaXN0IGZvciB0aGUgTUlQUyBCTUlQ
UyBlbnRyeS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEZsb3JpYW4gRmFpbmVsbGkgPGYuZmFpbmVs
bGlAZ21haWwuY29tPg0KDQpBcHBsaWVkIHRvIG1pcHMtZml4ZXMuDQoNClRoYW5rcywNCiAgICBQ
YXVsDQoNClsgVGhpcyBtZXNzYWdlIHdhcyBhdXRvLWdlbmVyYXRlZDsgaWYgeW91IGJlbGlldmUg
YW55dGhpbmcgaXMgaW5jb3JyZWN0DQogIHRoZW4gcGxlYXNlIGVtYWlsIHBhdWwuYnVydG9uQG1p
cHMuY29tIHRvIHJlcG9ydCBpdC4gXQ0K
