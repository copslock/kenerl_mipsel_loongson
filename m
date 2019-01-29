Return-Path: <SRS0=QFq2=QF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069DBC169C4
	for <linux-mips@archiver.kernel.org>; Tue, 29 Jan 2019 19:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FE32080F
	for <linux-mips@archiver.kernel.org>; Tue, 29 Jan 2019 19:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="HH2GSXTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbfA2Tvh (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:51:37 -0500
Received: from mail-eopbgr820135.outbound.protection.outlook.com ([40.107.82.135]:63648
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729244AbfA2Tvh (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 29 Jan 2019 14:51:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJZ4f21xRmsMSaqeujR8lwjdPLpc5oOzoRhrTZp9nFw=;
 b=HH2GSXTt+SnVmJXXODLYBEnauXoXGGm1EGSCJtEuVzAXnqodKYy9P2Fj9/prF93N5B+KysunuNrdcDx8Clcxl98XxZMLVdiPJcwtbRDCk2dnwCg/88BNeWECsWx3JHXRkvcI73vqPlcV6U0L9wFDNA56zPoEgCZEt3IrHKWPKak=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1054.namprd22.prod.outlook.com (10.174.169.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Tue, 29 Jan 2019 19:51:32 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 19:51:31 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "Maciej W . Rozycki" <macro@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: VDSO: Include $(ccflags-vdso) in o32,n32 .lds
 builds
Thread-Topic: [PATCH] MIPS: VDSO: Include $(ccflags-vdso) in o32,n32 .lds
 builds
Thread-Index: AQHUt197+z06kmnkZECwkX3QHAg4ZKXGqU8A
Date:   Tue, 29 Jan 2019 19:51:31 +0000
Message-ID: <MWHPR2201MB127720F85FCC9A1661940E2FC1970@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190128231518.31459-1-paul.burton@mips.com>
In-Reply-To: <20190128231518.31459-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0058.namprd02.prod.outlook.com
 (2603:10b6:a03:54::35) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1054;6:g1ZtJq9z6sY/oVmjdAMgoideySh1l01EdGS6l0E0yytlCKRuXAmxZObKE25CuiVihEh9kASAh2SoFvae+hPSiRv78vBvA7QsNhRwU3yfTtS7K5JY5fyYbephUCNQyMVPf/VNz3Y9oEsaos7K6hYM1jt3QHYLsgN7GYQJXgOuIrKKsMc4p/eJVzDWqaP7HVl+RufjPxbFMLXajO4tCB6kh/JgDDpCocjHYHObwg0XRFbq3KuFUclrYas2xO1bAgDdKEW4TPpY2mMYTrbQxbbpTMon9oIWmwT1kiZcZSisjH7HUJ7p3GoSf4Na0oKXeRwlJrusyin4kvNRLsIHhj1YfmGGCqQk/G6JsJ7G6UycCtlxhB62ARcL2BWkkYs2AMBtOYTNy0keAoy+nTJfWXRSK2kiCVuZ50z0cBSxdr9wv9kHQd7/N+GJvhLgQLSrMZYK9aRFLUr40JqS+zcNLKEvZQ==;5:926EVWo+1nun7GLJF1/Lm/6xXDa/B9yWHqg05yVrx3uJeWlr+hb5/4VHh6SBwzO6JUcwqwR/sW7s56jSkx5aUk7rH0EatIkb243WXFjvd1S4tF2V1RP5/5eeAASDX8mp4T4nfxNx0YKK2UYHnVWguSUQMkiU4WSIS8lfaIF1NdMLz45pStqJFrEmeJgYU7pdCaLFN4opEiXVvWzg6+3vlA==;7:luQxGkPUbvo0funzPsuENeWisjuwIJH8BGs9L/+GU2QUVCxkQywvMKtkSLshgWgtzhnRkRez36wwGJufnN8ZaDaIFHJrPQ+dyZBKJXiulRCzcKklA/8eCt6hsroBsoHVV4cngPddPqrsK/rVbAOUkw==
x-ms-office365-filtering-correlation-id: daf777a4-8d94-4b96-a015-08d686232a97
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1054;
x-ms-traffictypediagnostic: MWHPR2201MB1054:
x-microsoft-antispam-prvs: <MWHPR2201MB10542DD97FF3C3F5757279F7C1970@MWHPR2201MB1054.namprd22.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(39850400004)(346002)(366004)(376002)(136003)(199004)(189003)(54906003)(2906002)(8936002)(476003)(105586002)(446003)(97736004)(26005)(11346002)(7736002)(106356001)(486006)(55016002)(71190400001)(71200400001)(9686003)(102836004)(74316002)(6862004)(6436002)(33656002)(386003)(256004)(42882007)(6506007)(14444005)(44832011)(8676002)(305945005)(6246003)(316002)(53936002)(68736007)(7696005)(14454004)(76176011)(52116002)(4326008)(81166006)(229853002)(25786009)(99286004)(66066001)(81156014)(6116002)(186003)(478600001)(3846002)(142923001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1054;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pzg61IPolLkB8mQLqrpf5aKhSAY+sA7+H3UqbSo4e4wH8l8dT8NHPU2DRQ5MlPTZXR02wUk+fgDLQNYPDJASav+6luufTaCCoo4yUvp7nYoANQ9GRlGSw4O5ZNTArIwN7GA+mUsaaX47pVqs/gpWkfKBHE7lIA6YGiTDaSXz6UhUNQZQqXhn5IvBJ7ZjlPzhfRJVUcERlT39x2kab9eLMVj5/hwrqzqPXJEepOzvfaf0jvJ0xv9C04fGcbBbkNs+EdgbFVV2Zz+tFbXwYO5qsRwcjRxxjAsaNu0TMHMdJ4RnObxRdXFBq24P4jLoXbGGX3/p09bBcHAC17JIDMLHZEmjVypnuHcAquy2YaVeyeIsYyJWAGWEo8hCHcjXKvHxJ4pC7d7IAjF/7t8fhvqnJo3zEFU4QFj2r/N1EbXpyik=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf777a4-8d94-4b96-a015-08d686232a97
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 19:51:31.5436
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
> When generating vdso-o32.lds & vdso-n32.lds for use with programs
> running as compat ABIs under 64b kernels, we previously haven't included
> the compiler flags that are supposedly common to all ABIs - ie. those in
> the ccflags-vdso variable.
>=20
> This is problematic in cases where we need to provide the -m%-float flag
> in order to ensure that we don't attempt to use a floating point ABI
> that's incompatible with the target CPU & ABI. For example a toolchain
> using current gcc trunk configured --with-fp-32=3Dxx fails to build a
> 64r6el_defconfig kernel with the following error:
>=20
> cc1: error: '-march=3Dmips1' requires '-mfp32'
> make[2]: *** [arch/mips/vdso/Makefile:135: arch/mips/vdso/vdso-o32.lds] E=
rror 1
>=20
> Include $(ccflags-vdso) for the compat VDSO .lds builds, just as it is
> included for the native VDSO .lds & when compiling objects for the
> compat VDSOs. This ensures we consistently provide the -msoft-float flag
> amongst others, avoiding the problem by ensuring we're agnostic to the
> toolchain defaults.
>=20
> Signed-off-by: Paul Burton <paul.burton@mips.com>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
