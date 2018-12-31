Return-Path: <SRS0=X/+O=PI=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB41C43387
	for <linux-mips@archiver.kernel.org>; Mon, 31 Dec 2018 15:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150AA20828
	for <linux-mips@archiver.kernel.org>; Mon, 31 Dec 2018 15:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="ZFgX01HL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbeLaPOK (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 31 Dec 2018 10:14:10 -0500
Received: from mail-eopbgr760098.outbound.protection.outlook.com ([40.107.76.98]:61041
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725899AbeLaPOK (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 31 Dec 2018 10:14:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjylkEmvbFkv/NMwRUNHY0UFiq//K5b7pplVXYG5ZKE=;
 b=ZFgX01HL0h6IZrNGA7KqNnCtbMXCHSEqItrK1/2xhqgzGoGZ8nb5c/quSsQeOVEGxNiQFeZGQeri1xeW7d/lZSCBKN65/AQhH4DslNBk1SqLhSmKvAi2eWhu2ZpNQoIZHPLo2G9ubojNdF7LYu0e5rXeewdLOPyhUyk39Vsh014=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1069.namprd22.prod.outlook.com (10.174.169.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Mon, 31 Dec 2018 15:14:00 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%9]) with mapi id 15.20.1471.019; Mon, 31 Dec 2018
 15:14:00 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Jonas Gorski <jonas.gorski@gmail.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: BCM63XX: drop unused and broken DSP platform device
Thread-Topic: [PATCH] MIPS: BCM63XX: drop unused and broken DSP platform
 device
Thread-Index: AQHUoDaHFTWlD5xg00aI8bXfwy8g3aWY9nUA
Date:   Mon, 31 Dec 2018 15:14:00 +0000
Message-ID: <MWHPR2201MB12777850068D56002ED99682C1B20@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20181230115509.6542-1-jonas.gorski@gmail.com>
In-Reply-To: <20181230115509.6542-1-jonas.gorski@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0397.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::25) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2a02:c7f:5e43:2c00:50fd:bec4:fe7e:44e7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1069;6:XOOTQGER+t7XEhpR9j4akKUitZ9mn9lCcWqd12xqEvOsP0hIQHB6WFQSIgF1yZK8eO8Gg3e0KjuRt5Y7Tqd/VfliFoPXkxrA5z9A/ab/AinaecDAflMdm9qlDkvUcwsEEKK9z2aXA7YSjCWKQoj9IiJmrGDYIbiGpmA7Lul081CPnJP4cjt6/A/QX/l14iQlSZ1By3S3klcHby58WfQ7oe5OIljdUiMVDfvxesohnzh4QNRO0/YyboTBACWAuF4W9SP6ZrKv5vPckmgoS0k2SCx/YJljX7RcVe2pN7316deuaUDUJuT0VrveNrXr5yW2WI3OUpREYISQh1fveXAURlUKOJ4oQvKUD0P7xbSQaNFKP2FQWgkH3ABMael5Lpg+FDxtoMae/vqGFoxY4Fj2EBR6l7L/Kd6zXCO/f9CdVsK5EXC1W5+OTgH07XjiC+9Db1xMr5Ca9jcL2rvEqjWTIg==;5:cmACDjGmT13rxyyQri9tvdgCjLQ9u/70qjTyrannaHu2fm8WIj5FZqyS7z5bF0FqjU1ieOB4VUFlb4nkYQzM5Stp7Gz6XVYRzn00hZLpIuouIVc2Wm9OJFWOotjGl4IYkhuImSOlRJbDd8D3YsL7iyWkhxNmwSEcaXqQis/FMdg=;7:RvmE6H6OoVp2zE4hpFO1Fd4zPttlhb2eiEIVIaLgrLjwbRPPZRnV9b9ZEOp0je4eV7do2Yi+gTtlwDCheniWxQfUx1Tdp2Gz47ot2iHliBX2seRZG8/T5gYpGHTrzdKbCRsTGQV47tRmrDKZQdyg3g==
x-ms-office365-filtering-correlation-id: 4fc717fa-298b-47dc-949e-08d66f32976d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1069;
x-ms-traffictypediagnostic: MWHPR2201MB1069:
x-microsoft-antispam-prvs: <MWHPR2201MB1069BEEBBE45121BA9695854C1B20@MWHPR2201MB1069.namprd22.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(3231475)(944501520)(52105112)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1069;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1069;
x-forefront-prvs: 0903DD1D85
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39830400003)(376002)(366004)(136003)(199004)(189003)(14454004)(508600001)(25786009)(99286004)(5660300001)(6246003)(39060400002)(53936002)(55016002)(97736004)(6916009)(74316002)(305945005)(4326008)(71190400001)(71200400001)(6116002)(2906002)(9686003)(14444005)(102836004)(46003)(105586002)(44832011)(486006)(256004)(6436002)(54906003)(6506007)(446003)(386003)(229853002)(106356001)(8676002)(33656002)(476003)(76176011)(81166006)(81156014)(7736002)(42882007)(11346002)(316002)(186003)(7696005)(68736007)(52116002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1069;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 653FvOJkZUeX69sZ1alTGioKiqQLSVWTXyf6iXnBSw/9mlO2U+wkBX4F0H07ZFLmDUeKVDznGVL2h/G0PkKVXn7bEatTEkt7Ha/Yv86vOBrHrWmFSE6uATvytnszlXuli+NyxW+gkz2wG6CvBfbTWRIee2t+NptCYQNIEvsJvxUcH+mp0y1lz/BV2LwGDjIyyhxDcrIIxN52QVPU5jksCMdlaKetVnrchMgCBXCifgnU25ho/4KYDASRk9Xo/n+Lq4EeEmatxtVQafvEgpypYSHC8vv0GzG0/MBQX23owP5csJKbAcpOSVrMhT9y5MX7
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc717fa-298b-47dc-949e-08d66f32976d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2018 15:14:00.3676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1069
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Jonas Gorski wrote:
> Trying to register the DSP platform device results in a null pointer
> access:
>=20
> [    0.124184] CPU 0 Unable to handle kernel paging request at virtual ad=
dress 00000000, epc =3D=3D 804e305c, ra =3D=3D 804e6f20
> [    0.135208] Oops[#1]:
> [    0.137514] CPU: 0 PID: 1 Comm: swapper Not tainted 4.14.87
> ...
> [    0.197117] epc   : 804e305c bcm63xx_dsp_register+0x80/0xa4
> [    0.202838] ra    : 804e6f20 board_register_devices+0x258/0x390
> ...
>=20
> This happens because it tries to copy the passed platform data over the
> platform_device's unpopulated platform_data.
>=20
> Since this code has been broken since its submission, no driver was ever
> submitted for it, and apparently nobody was using it, just remove it
> instead of trying to fix it.
>=20
> Fixes: e7300d04bd08 ("MIPS: BCM63xx: Add support for the Broadcom BCM63xx=
 family of SOCs.")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
