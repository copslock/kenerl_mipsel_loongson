Return-Path: <SRS0=rTdo=QL=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A757BC282C4
	for <linux-mips@archiver.kernel.org>; Mon,  4 Feb 2019 21:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E2520811
	for <linux-mips@archiver.kernel.org>; Mon,  4 Feb 2019 21:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="hbltspMP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbfBDVSW (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:18:22 -0500
Received: from mail-eopbgr800109.outbound.protection.outlook.com ([40.107.80.109]:6327
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726843AbfBDVSW (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 4 Feb 2019 16:18:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Whw1N6VGEmL359GjynxIPEzHOkIKKGn5J5rCKWlepK4=;
 b=hbltspMPdPfFFQQdj1B9YR5hE4GZwNIjxLjnCWCSTZ/vu848z39w83QoFq3mFWNVa7+n2fLOzWQYGKPa0pvghCK1IN5uF2/cVfu/XomRQTqyhYcIiDzkncbZG4gOrdf/6MXpzBdANtNLLuUf89Hyl1WX+VTdeq5nopjax98MNCM=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1118.namprd22.prod.outlook.com (10.174.169.156) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Mon, 4 Feb 2019 21:17:38 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 21:17:38 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Huang Pei <huangpei@loongson.cn>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "ambrosehua@gmail.com" <ambrosehua@gmail.com>,
        Paul Burton <pburton@wavecomp.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Xu Chenghua <xuchenghua@loongson.cn>,
        Huacai Chen <chenhc@lemote.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Loongson: Introduce and use loongson_llsc_mb()
Thread-Topic: [PATCH] MIPS: Loongson: Introduce and use loongson_llsc_mb()
Thread-Index: AQHUrKkbszYPX2Jfj0W1/vsCD7U4s6XQRMiA
Date:   Mon, 4 Feb 2019 21:17:38 +0000
Message-ID: <MWHPR2201MB1277AC96754C6D4993A17DD5C16D0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <1547539494-7870-1-git-send-email-huangpei@loongson.cn>
In-Reply-To: <1547539494-7870-1-git-send-email-huangpei@loongson.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::14) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1118;6:EovQdesIYFdXwMdmMQK7Jaeb2PeOd4gmAt4AgidS9dI4Gzfwy1O0KoGqmicAttS4T08hVAfpGyEjq5Ii+MxPnDBVpH2cV9PnUDVfwPSsu1eNkuonkmuQBxeyFUCZI0fCtMhkix+HrkX9tbSF2yJH6x6jAGVPnG2bx1baLejUkiAscbfBQUu1Ridh9OcxZb0BP85n3uxbEFglvV5zBW5EZTzY3FJmAOT1azWgn/jdO9RDlWyK9zBdtfSH7/L/kcvn0BOqok2t706ixJ/lca+fIXlrY/w4DlhL1+S4Yazk2iTWd3/lTnH6f0O42LozEYVUBIx/EdIUCBVQLNwtvMDateJSKzQlEwgC15f9iOwjC0kHnJb1hHCd1UJX9MWe+9PV6zDRUkmX0qRBwghD1PYzrC04apxqJaPWYu7aS+eJWIMCL0ka4VJ811kMYb0yNQBGma3kZnIgp0P3GjZkZaLt5Q==;5:sB5yg2nqCgPD/cNUV3uLWlvIqoo/JFOhrjPiAw7gCiJlX8g6R9/Zbl0Irimy0XtGeZCl8WTRbzPC8T60t5RNaLZezmJqwXYC8XEBNb3s1cGHMnQ36kBhgnt4TSwQn3U+8l8BIlfjewLb0ROAG41x56jJ/NDHfudZAFxaYy05FFGCQ89Hr2r7hsdlxDtVvhVMwxANUbGEnpM2EIg9QKbCZQ==;7:U7vfr+swcPcROmbV63ki9inD13bunhpP/pBUc8XWOtgCNLX82iV8H38/JF+81s2cPlfBqojPsWwgLti5H3mOZBIE+e5CgtwYtrFn0aRpuI35JhuD6TjNEasQpxro+5RU76dNFtPUc34Nk8PHm1sfdg==
x-ms-office365-filtering-correlation-id: b50765c0-442f-4381-22d0-08d68ae630a7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1118;
x-ms-traffictypediagnostic: MWHPR2201MB1118:
x-microsoft-antispam-prvs: <MWHPR2201MB1118C2E4656ABC556F666894C16D0@MWHPR2201MB1118.namprd22.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(39840400004)(396003)(346002)(189003)(199004)(76176011)(6916009)(81156014)(81166006)(476003)(6116002)(11346002)(3846002)(7696005)(14454004)(486006)(52116002)(97736004)(4326008)(71190400001)(6436002)(229853002)(44832011)(33656002)(66066001)(9686003)(6506007)(55016002)(386003)(2906002)(99286004)(7736002)(54906003)(42882007)(71200400001)(102836004)(478600001)(105586002)(186003)(6246003)(106356001)(26005)(256004)(14444005)(25786009)(74316002)(446003)(305945005)(53936002)(8936002)(8676002)(7416002)(316002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1118;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mBdsZ5sq/AadISBlX883dp7T3d8xOci++MMvvW6153dNxPGAghXdCHaF7HCNuzkfKQgdUoOQq9U5e2kN3FvPdWEv+kMdpIcUGjpkI9uDwOVqMlgFVa51JGyAWwqzKQGXjwHid66ldGwrP6HIWD8Bmiuy3s9Ww0coHRLKMxbJ78iA58KtC1erKRGPl7WSXACgGThSbGfXbQvY9SaIqbv//mCQW3f5VIXX9KX9olb7MLAdSK141/GdqLQ9mPkAkN744oL7oPlgCgxIl0ue6MVkQjcWVeXAOldKwwqavle1oXXdbSpe6q60hNvnlwM25/8iTpz4W5qWCYcBfCWpHJMwn+7ONRdkjucjhFtn3I8MEpLmB/XfTwnI3LdsHrZ6fxWvnjiDeIYemreHhF010U4S2GAzPa1xp/HfcJX4o1iAlqw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50765c0-442f-4381-22d0-08d68ae630a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 21:17:38.2314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1118
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Huang Pei wrote:
> From: Huacai Chen <chenhc@lemote.com>
>=20
> On the Loongson-2G/2H/3A/3B there is a hardware flaw that ll/sc and
> lld/scd is very weak ordering. We should add sync instructions "before
> each ll/lld" and "at the branch-target between ll/sc" to workaround.
> Otherwise, this flaw will cause deadlock occasionally (e.g. when doing
> heavy load test with LTP).
>=20
> Below is the explaination of CPU designer:
>=20
> "For Loongson 3 family, when a memory access instruction (load, store,
> or prefetch)'s executing occurs between the execution of LL and SC, the
> success or failure of SC is not predictable. Although programmer would
> not insert memory access instructions between LL and SC, the memory
> instructions before LL in program-order, may dynamically executed
> between the execution of LL/SC, so a memory fence (SYNC) is needed
> before LL/LLD to avoid this situation.
>=20
> Since Loongson-3A R2 (3A2000), we have improved our hardware design to
> handle this case. But we later deduce a rarely circumstance that some
> speculatively executed memory instructions due to branch misprediction
> between LL/SC still fall into the above case, so a memory fence (SYNC)
> at branch-target (if its target is not between LL/SC) is needed for
> Loongson 3A1000, 3B1500, 3A2000 and 3A3000.
>=20
> Our processor is continually evolving and we aim to to remove all these
> workaround-SYNCs around LL/SC for new-come processor."
>=20
> Here is an example:
>=20
> Both cpu1 and cpu2 simutaneously run atomic_add by 1 on same atomic var,
> this bug cause both 'sc' run by two cpus (in atomic_add) succeed at same
> time('sc' return 1), and the variable is only *added by 1*, sometimes,
> which is wrong and unacceptable(it should be added by 2).
>=20
> Why disable fix-loongson3-llsc in compiler?
> Because compiler fix will cause problems in kernel's __ex_table section.
>=20
> This patch fix all the cases in kernel, but:
>=20
> +. the fix at the end of futex_atomic_cmpxchg_inatomic is for branch-targ=
et
> of 'bne', there other cases which smp_mb__before_llsc() and smp_llsc_mb()=
 fix
> the ll and branch-target coincidently such as atomic_sub_if_positive/
> cmpxchg/xchg, just like this one.
>=20
> +. Loongson 3 does support CONFIG_EDAC_ATOMIC_SCRUB, so no need to touch
> edac.h
>=20
> +. local_ops and cmpxchg_local should not be affected by this bug since
> only the owner can write.
>=20
> +. mips_atomic_set for syscall.c is deprecated and rarely used, just let
> it go
>=20
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Huang Pei <huangpei@loongson.cn>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
