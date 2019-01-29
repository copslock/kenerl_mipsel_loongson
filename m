Return-Path: <SRS0=QFq2=QF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84A3C169C4
	for <linux-mips@archiver.kernel.org>; Tue, 29 Jan 2019 19:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4052080F
	for <linux-mips@archiver.kernel.org>; Tue, 29 Jan 2019 19:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="PzGrUPiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbfA2Tvb (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:51:31 -0500
Received: from mail-eopbgr820093.outbound.protection.outlook.com ([40.107.82.93]:49718
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727056AbfA2Tvb (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 29 Jan 2019 14:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CmzO0Ji8nnsR1GLSszNE0wgT0IAGKsTO6vN3TWFrcA=;
 b=PzGrUPiRdTbRM6HY14E+iKhlZz7dtJHrWzmeBdQvNZ7e2UGADgccBhyG/T0IX0A15ul9LKwkMKUzfumwoKzYljqUpjZU1PIdt1++kNNgr4oJvus+79+Yek9MZy09mkXfSPW8qe43Yhy3WlJbU2G+AS5UROlD9c6jp+7HkROFBqc=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1054.namprd22.prod.outlook.com (10.174.169.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Tue, 29 Jan 2019 19:51:28 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 19:51:27 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: OCTEON: don't set octeon_dma_bar_type if PCI is
  disabled
Thread-Topic: [PATCH] MIPS: OCTEON: don't set octeon_dma_bar_type if PCI is
  disabled
Thread-Index: AQHUuAwFUdeIhUbIVk6NjPpeBQlnxg==
Date:   Tue, 29 Jan 2019 19:51:27 +0000
Message-ID: <MWHPR2201MB12770DE967A6416AF50AE241C1970@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190127212833.16520-1-aaro.koskinen@iki.fi>
In-Reply-To: <20190127212833.16520-1-aaro.koskinen@iki.fi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0050.namprd07.prod.outlook.com
 (2603:10b6:a03:60::27) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1054;6:OLpz85DgU3jK+8SzyBhNMGfFaqrp4HVagZgpweFlqCmH5phpbe5IpBGr7uWT4Q98qgArbyqWIC8TNA4jw2TwkporcBfFpW8x01ptOSvD5wi2W/pgSeL0gbTf4Eness5afBFdQTWecZ48KHw9suJIpiIuBmtTiGIg/kBZDfSy//drcbHV/45nPWdG4Jb8Znr/KARGHksrxoLxxI5vQJ/bJcTixqYMvywv955nlkN2Dyt7pzVBVc7wUSTgZXEUFgPu2fxgeJQ/nPEQaKArfEY4d2cs1HzKp4K6rDY2H4jPObRkbX8Co75utXygoUjOtAbhBOw0dnOeshdz07t8Xpt+2cfOJFkSro0q9Y0Mwmucnqh87u2EkuW1KW42XFib4u54Oxl6TvH3zhnq4cvOE9CophpYC2rFtrIK2OSHlWIKzSR8/4YpNjIJYUUGpl7ysQg1n6kun7KEx7dK7vp1BRnfSw==;5:0vaVT9DkoUOr/onwA3LypdQXz+QdZgkSzVC6VVbQBHN7dYfktjpQ5B1HmJuVpSsxOKWfG8Epoz+Ier4OH93Q1sg3ibbsGhzY+wuJFTLqnhkB98iDl4VugFY1GjNVOG11oLpsj7QFkHPSmkYFPKmtlN0/27BbEv5V4faQTo2y5na6tpn7jUvca1dGgBFuUCwJL7TAbHleQp8IEChwBhqA6A==;7:Y72hsGJFuQvalkwAQMrnEeURroGNW3sKeydV6MA7RtM1qOUKZT+WNZRLjiU1Ngs1Xw9Wtp7OmB7MQfa8bj6YTnuCcmwR5Wbig1VswEUdxFbRq9izXsxUMQvcJSicgsGVW0IbJApX2i397pxWs4bQ9w==
x-ms-office365-filtering-correlation-id: fbba8729-05e3-4cc5-488d-08d686232835
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1054;
x-ms-traffictypediagnostic: MWHPR2201MB1054:
x-microsoft-antispam-prvs: <MWHPR2201MB1054319BA89FBA58364E3520C1970@MWHPR2201MB1054.namprd22.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39850400004)(346002)(366004)(376002)(136003)(199004)(189003)(54906003)(2906002)(8936002)(476003)(105586002)(446003)(97736004)(26005)(11346002)(7736002)(106356001)(486006)(55016002)(71190400001)(71200400001)(9686003)(102836004)(74316002)(6916009)(6436002)(33656002)(386003)(256004)(42882007)(6506007)(14444005)(44832011)(8676002)(305945005)(6246003)(316002)(53936002)(68736007)(7696005)(14454004)(76176011)(52116002)(4326008)(81166006)(4744005)(229853002)(25786009)(99286004)(66066001)(81156014)(6116002)(186003)(478600001)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1054;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fDulXqAcfsYFTeTqS06pxsTwqMckCj6oryTjZvXoq4mqPP/SByUu51/BWXyvYiPEdxuc6HN8iRARCZoKdjKal/8NghhDir7xscBRlLDBG2ZGvp360eocVNnqAc6Vd8PP+RKa+45AgJh9ukRYhmnPMLvLnphnbykPk6rRI3INOknrozoAZWfKQUUHbkwrkMopLmhI8PNbWoQ2eZOUrMzYXsQVa0MkDgQzSpvEJBPtn0KFXg+UNT730jAx62lw4EuzWwhU/S26ZgqG4tj6Dgon/IyKPQp+FW3kgpntEhePgQzNG8+W3/LOr/Vooore9TW7RwQtno3JX7cTnwJ5ZMnGuVntdmqiF+pkfGvPtH8t0R219jEecch0ZZvPs6636SRZuia71KkjB+DDy8uQTLeea2IMwMfCWFSY3mW6lP+Bd7Q=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbba8729-05e3-4cc5-488d-08d686232835
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 19:51:27.5124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1054
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Aaro Koskinen wrote:
> Don't set octeon_dma_bar_type if PCI is disabled. This avoids creation
> of the MSI irqchip later on, and saves a bit of memory.
>=20
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
