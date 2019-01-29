Return-Path: <SRS0=QFq2=QF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C95C169C4
	for <linux-mips@archiver.kernel.org>; Tue, 29 Jan 2019 19:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5692080F
	for <linux-mips@archiver.kernel.org>; Tue, 29 Jan 2019 19:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="WTvwMd+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfA2Tvd (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:51:33 -0500
Received: from mail-eopbgr820093.outbound.protection.outlook.com ([40.107.82.93]:49718
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729244AbfA2Tvd (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 29 Jan 2019 14:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1nHNamYEDcEtOc3G2jJhBiyzfKYtYgOgO3wy/2NHgY=;
 b=WTvwMd+P/f255y6XK7r3FjhBqXwdACZBHnwNPvJ96IiWjyAoqnxx4ntLYduWMRU+ZiSk0yQP5akZoZUCrlgWjRZ3gY63z9IcKRgB4HHUbjwE1wqHfG1ZJEc9ESsRd5gRuSUvyLr9UR310ZRKt0BiWJBHNvLaJ0dc/lQTzKLY9gA=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1054.namprd22.prod.outlook.com (10.174.169.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Tue, 29 Jan 2019 19:51:30 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 19:51:30 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "Maciej W . Rozycki" <macro@linux-mips.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: VDSO: Use same -m%-float cflag as the kernel proper
Thread-Topic: [PATCH] MIPS: VDSO: Use same -m%-float cflag as the kernel
 proper
Thread-Index: AQHUt1fJgj73RYZvOE+WwXH4dUqACqXGqVwA
Date:   Tue, 29 Jan 2019 19:51:29 +0000
Message-ID: <MWHPR2201MB1277B05AE4D8ED4109CA96AAC1970@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190128222106.19100-1-paul.burton@mips.com>
In-Reply-To: <20190128222106.19100-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:a03:40::22) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1054;6:AyX6squXeV8rNds6ZBXZse3y1Jm+RQWrG1lMEK3iTEUBIioXYKYLDgoNUr+/Wp7p/R1BDo9jEdJZbY+DBGYCEB0+hS3FsHapzOfOS04hHU4R4/EzcRolBmSwnamoE0JBmBMq5m/xMSbyOVlbEI785PRA8f0K9V/VgbfAaGYDJDLi9kWtfsy4XNIfqOA8a+pWOLz4yzYz40/UROnfbCg9Bd79Z867rfOxjhoM9vPo09sVlYmnBwHg4kVwUf/fPqV2RxwT/jKURzFr1Q78709F9CIYv/lxuEAEeb5eJHL0oiplZVFm+2t9f9suBuoHYk8G+0zfRuZRIBnWqzg5KoAw1QrTA6rRlBsUFVkSDOrZskW67pVKTGvAo68NL9KITvAYY7nFETRqWyXGFR4nn6uen0EtwXjQvo9lvDZMKgC9wRtgzmeOnEzKxQREvkcFOJLGnaInSa9HjJ3nL5b/bhaJMA==;5:R6Mn+Xe+xuqJ+DC3YPqr0jUMPjBI2zlJ04JyLIIEfNNOAj0kDhaNGO3MahrPFmZIr8SISk48Zq74W5F4aSz+/TXrRSssRzBqIxjsFI2QeXFJsKdJn7M2dzjWp9iHRzpM5rXcsw2d2L3q2NHyC+C0Vwt+CAf4Jh8+dY/5A922eDSK6EST+bQGX6MADJ/G738Sm6wr/S0mhISI8/C87LsrZA==;7:8hoMCkhj0jkebwCsvV0hOCUQwn1thuYTFtIx0jK3UOX/l6weI66u26nDune9rVgrb7qvXmf8ksOKgxcH02u3VBGN5aSEZEiYI/CtUTzAW5avJo4eGBFKmz1YAiGQCt3oCf0C316+oL6eYEUuQNkMjg==
x-ms-office365-filtering-correlation-id: ea6811ba-98e9-42d0-24b6-08d686232977
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1054;
x-ms-traffictypediagnostic: MWHPR2201MB1054:
x-microsoft-antispam-prvs: <MWHPR2201MB1054F8EF2903AE65A93E8984C1970@MWHPR2201MB1054.namprd22.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39850400004)(346002)(366004)(376002)(136003)(199004)(189003)(54906003)(2906002)(8936002)(476003)(105586002)(446003)(97736004)(26005)(11346002)(7736002)(106356001)(486006)(55016002)(6306002)(71190400001)(71200400001)(9686003)(102836004)(74316002)(6862004)(6436002)(33656002)(386003)(256004)(42882007)(6506007)(14444005)(44832011)(8676002)(305945005)(6246003)(316002)(53936002)(68736007)(7696005)(14454004)(76176011)(52116002)(966005)(4326008)(81166006)(229853002)(25786009)(99286004)(66066001)(81156014)(6116002)(186003)(478600001)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1054;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ddO6WF6gQgCjus1JwTEfv4gX96K2PBhHMaNut3gfv7QslOwRlbKSr1ViJ7DBcmL9k+VeFFylwJgPCdWUt8nC+E1VmF1/YYQotk1ogV8Pz/hCeahcsSkQ80eMAKLdfMDtRviPdCjhan7OBnIFude2GxArLg9POfe+c9fE9wJqQQcDWFH1a7dndcQiFOMDag1EeEuZuaAXDkw04Wn5qFbmhAhO9xsCJtojNMVxNUAEy3TLz+mpv+XsrTiWnZoo+degLEQTarI5/ENPUZPOpFyB73HEzrCGV5zpPFtFkrw/GHjkVZHeOUnhXU8FaSG4eY4V/KBRi4gOEOnV3n645P80IfviX1cVFR6ravd1kGz6sCevNmXVfdiCP+lgGh7VZGycMpKY1481D1khst4XC5KFDk91rwxHiy8BxoJhHdictIo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6811ba-98e9-42d0-24b6-08d686232977
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 19:51:29.6686
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

Paul Burton wrote:
> The MIPS VDSO build currently doesn't provide the -msoft-float flag to
> the compiler as the kernel proper does. This results in an attempt to
> use the compiler's default floating point configuration, which can be
> problematic in cases where this is incompatible with the target CPU's
> -march=3D flag. For example decstation_defconfig fails to build using
> toolchains in which gcc was configured --with-fp-32=3Dxx with the
> following error:
>=20
> LDS     arch/mips/vdso/vdso.lds
> cc1: error: '-march=3Dr3000' requires '-mfp32'
> make[2]: *** [scripts/Makefile.build:379: arch/mips/vdso/vdso.lds] Error =
1
>=20
> The kernel proper avoids this error because we build with the
> -msoft-float compiler flag, rather than using the compiler's default.
> Pass this flag through to the VDSO build so that it too becomes agnostic
> to the toolchain's floating point configuration.
>=20
> Note that this is filtered out from KBUILD_CFLAGS rather than simply
> always using -msoft-float such that if we switch the kernel to use
> -mno-float in the future the VDSO will automatically inherit the change.
>=20
> The VDSO doesn't actually include any floating point code, and its
> .MIPS.abiflags section is already manually generated to specify that
> it's compatible with any floating point ABI. As such this change should
> have no effect on the resulting VDSO, apart from fixing the build
> failure for affected toolchains.
>=20
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Reported-by: Kevin Hilman <khilman@baylibre.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Cc: Maciej W. Rozycki <macro@linux-mips.org>
> References: https://lore.kernel.org/linux-mips/1477843551-21813-1-git-sen=
d-email-linux@roeck-us.net/
> References: https://kernelci.org/build/id/5c4e4ae059b5142a249ad004/logs/

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
