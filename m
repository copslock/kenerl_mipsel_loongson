Return-Path: <SRS0=OKHG=RD=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6D2C43381
	for <linux-mips@archiver.kernel.org>; Thu, 28 Feb 2019 03:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034C2218AE
	for <linux-mips@archiver.kernel.org>; Thu, 28 Feb 2019 03:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="XUTnZguR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbfB1DMt (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 27 Feb 2019 22:12:49 -0500
Received: from mail-eopbgr680133.outbound.protection.outlook.com ([40.107.68.133]:15724
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730131AbfB1DMt (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Wed, 27 Feb 2019 22:12:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmYPgEtI/Z/Q4QeeUx73FzoiahEIg2eAqxkmACXr9v8=;
 b=XUTnZguR8PXJkc1Y839EWRsVxqpRFOnlmvCoVNpFLyv/VuIDw75BuaQUkoGevOwXn2WT3zp8SmUKmAKJFO0Nyuk4GfBiJ7oZCfhfKdhF74Mt1FXEePQ/9HWkpSRaJUmCum3wJjcg3R3Cjo7c/30y565mfcG4NCLGeXD40fCZEZ8=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1023.namprd22.prod.outlook.com (10.174.167.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Thu, 28 Feb 2019 03:12:43 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1643.019; Thu, 28 Feb 2019
 03:12:43 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "kernel@xen0n.name" <kernel@xen0n.name>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Wang Xuerui <wangxuerui@qiniu.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [RFC PATCH 1/2] MIPS: Loongson: add extcc clocksource
Thread-Topic: [RFC PATCH 1/2] MIPS: Loongson: add extcc clocksource
Thread-Index: AQHUzCSQ2xkA2uQxg0iCaTOUZW+L+qX0jqWA
Date:   Thu, 28 Feb 2019 03:12:42 +0000
Message-ID: <20190228031241.bn3smi3yfycjqzum@pburton-laptop>
References: <20190224093635.1242-1-kernel@xen0n.name>
 <20190224093635.1242-2-kernel@xen0n.name>
In-Reply-To: <20190224093635.1242-2-kernel@xen0n.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0048.namprd07.prod.outlook.com
 (2603:10b6:a03:60::25) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f5ed457-4895-4c65-45ad-08d69d2a9a6b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1023;
x-ms-traffictypediagnostic: MWHPR2201MB1023:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;MWHPR2201MB1023;23:UXqQpi3+2ktXNpzoAfxRNR9BDYrmKxwfQ8ey2fF?=
 =?us-ascii?Q?7Rk77eAJ6q9fPFqsbKjIMXxI6ZScNbn9r9rZ8pVlk4ZB6Hk6zeeEC5QcG9jv?=
 =?us-ascii?Q?XiCdPtUNaKNv8NNf/UUdDA/a0Xr9B3vm3Nc00xz7yFtyfHvGOo5uTt8JIn06?=
 =?us-ascii?Q?2nb/Xy/jO+nWmTYmA3hcgOr0eZoG50TKSPs3C1MXQmhpZNnc1B+UBiKaB3Ko?=
 =?us-ascii?Q?3sTjw9J8ES5cdCQqO8sRgiIJKtnS0IH5QNdY7p3o7azDVybyaLQVzGLSR6iO?=
 =?us-ascii?Q?jvUNaw6rGJ7tt7Zp/uZmbueU++TEHYkHilnnXKdFlllKHWP97iI+LuklnbUd?=
 =?us-ascii?Q?LpkO8gxrlxETjAdCWUIV81k3sq0kDeOvdnthCyw/QrrT0AZRgk0082wPbpqS?=
 =?us-ascii?Q?Z6D7IIe2d0MBO9WvQ94Vje1KBYjpXPdg8LTVbLHJN+q/bwjPrTX9CuHJujBm?=
 =?us-ascii?Q?Z+QaKeYBz9tJiVtam2GAQGXfLOxrXJTxP5gKyMTPFNtQxHWSuqI0FDIDrfbs?=
 =?us-ascii?Q?FtkyV5yddt6JayZouKFq/bZJwgK9J3KT16K3QxwjbGEizpuOyqPoD4JxWiZ7?=
 =?us-ascii?Q?FPKtumsuuLLTlPsNWWD3aoVscJaRlq63XJ+PlqLlbbFmrqtL77E+D8t+ZO5x?=
 =?us-ascii?Q?8CvSENDzBUnEJcyk+iKPqx1P8XoV0zsHdh5bdBdy1TQt4j1Q14EXOamQZxRn?=
 =?us-ascii?Q?CXUn3yPWEuUaD1Im1MbOwS1ZA0bW70L7+9nGPpApxffNddNgR/BJztLdek/N?=
 =?us-ascii?Q?oDZDdLWDKXnhMnoHxX/tRB/ZYip9NZ5wATevf3SXaHzrY1pijdb6/tNulkUz?=
 =?us-ascii?Q?F2XlsvFL/L8OQkbyxMqQvY3vPfgJUrZtalj6Qr3JhcyrZ7dO1QbsgBB6Gl5Y?=
 =?us-ascii?Q?IZWC9chraqGoa4Dxj4amRckAAx9Z8EV9L4s3LakWB2nXILGcAhg6TRSHsBvi?=
 =?us-ascii?Q?sXgSVVt8aCV+rtWR0iWWk2gfy3w3zwE2Z/3WJpCUgvmEcgQbG9Ggjx0exB90?=
 =?us-ascii?Q?s5P8dGwHBn+ZQLag78foGt9P5onZuvZ5hZMMUml/WRHloG/G7POLrdcRDSh+?=
 =?us-ascii?Q?ZOtr/8XIUHrcaz0kwY9exKbwtJ4vjcL6IiwnRj+xafOanqOFKpdYnI5Ec0zl?=
 =?us-ascii?Q?HXgh7ZrhmyP1NC9GWJJTtS7FolDhivxepCIDUcu3veK7bRjis560JM8ygrhI?=
 =?us-ascii?Q?F6tJULQHdlfglbLY0DjtJrxFetkbMwDroOUwv5ZFIsw/9GIKMlmrUaJKDfeE?=
 =?us-ascii?Q?0CDjxZUY938ddJBYMQ2drXBsYsOdEHL+8JzZNTPkpBuJfRKltk1ahCfNrwv4?=
 =?us-ascii?Q?S4BOf6BnjrliFqL0D7ZOZrED2GIm7kGVvLod3LtJM5/InQP+Dg0279bCQv7l?=
 =?us-ascii?Q?Rd/kKYH4WuwAEthKOuqzdLORyVr/dRZYkLWlEdvZ6adt/t1fSNO3ydV8ZYJA?=
 =?us-ascii?Q?76jKlorgacg=3D=3D?=
x-microsoft-antispam-prvs: <MWHPR2201MB1023C64C2613CE0842B59977C1750@MWHPR2201MB1023.namprd22.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(39840400004)(396003)(346002)(366004)(136003)(199004)(189003)(51914003)(1730700003)(8676002)(256004)(5660300002)(33716001)(99286004)(42882007)(14444005)(54906003)(6436002)(5640700003)(7736002)(6486002)(229853002)(2906002)(6512007)(476003)(53936002)(9686003)(486006)(11346002)(2351001)(305945005)(316002)(6246003)(478600001)(97736004)(106356001)(446003)(44832011)(4326008)(186003)(8936002)(105586002)(25786009)(6116002)(81156014)(3846002)(26005)(58126008)(52116002)(2501003)(102836004)(386003)(6506007)(81166006)(6916009)(76176011)(68736007)(71190400001)(1076003)(14454004)(71200400001)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1023;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZfMrS14W8Goe1aNEjZaYimOWHBvMf+cldB6IRZ6STRa8i/cfy4AWEP5W8rvEBQWNZQ1FDtE8H4km3ujesN+xD7Hvb6plaF+0sQsk6jCXFwS6ljFrxEE1cjtvvGpjOELfrSM7wh63YW5DuDd/Hzzmnie9dWivIQdVde5VgJbETbPgDl0KqGDMQjc97P+7//X0kERILnvUtGuGB4KkKe9aAX1XV/i228HG+sP3kUqnsI/57yInLvsinYpCRExaZHKPfhBUsTtMzOYEeyf6a5w59Y4zQWOp9sAo0nOihAXDE/9F5/lSKzWh14iPK2gpc9TVrayGkoHEHqYVoNJn/NzlZiZ7GEtk9bpM9atzFrQZa+1zEVnHJkjTaSAFOqzmUfTcIXwAn23nOOJMwNA1ZvqPQUWJILaTqTODPfc213T47k0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <499C3B18B6552141A27408E5E66A0B59@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5ed457-4895-4c65-45ad-08d69d2a9a6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 03:12:42.3832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1023
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Wang,

Thanks for the patch - comments inline below.

On Sun, Feb 24, 2019 at 05:36:34PM +0800, kernel@xen0n.name wrote:
> From: Wang Xuerui <wangxuerui@qiniu.com>
>=20
> The ExtCC (external counter) is a Loongson GS464E-specific hardware
> register that ticks every internal bus cycle.  Hence, the counter is
> shared among cores of the same package and can be considered constant
> frequency.  The frequency is same as maximum frequency on all Loongson
> chips I have access to, and the resolution is very good.
>=20
> A previous iteration of the feature directly ripped x86 arch code, thus
> unsuitable for mainlining.  This time though it's implemented with the
> generic clocksource framework for simplicity, but without HPET-assisted
> calibration as in x86.  Instead, the ExtCC frequency is directly taken
> from firmware.
>=20
> Blindly trusting firmware-provided values indeed can lead to clock
> drifts, of course, but according to own observation on a 3A3000 board
> the drift is somewhat acceptable.  For example, during a certain test
> run, the firmware advertised 1400.020 MHz, which was refined to
> 1400.027 MHz by the old ported calibration code.
>=20
> The current code is tested on a single-socket Loongson 3A3000 board for
> slightly over a week, while the old code incorporating essentially the
> same logic was deployed for well over 2 years. Stability is perfect and
> responsiveness improved greatly, according to cyclictest.
>=20
> The cyclictest benchmark figures are to be filled later.
>=20
> Signed-off-by: Wang Xuerui <wangxuerui@qiniu.com>
> Tested-by: Wang Xuerui <wangxuerui@qiniu.com>

That should really be a given :) I'd drop the Tested-by: for your own
patch.

> Cc: Huacai Chen <chenhc@lemote.com>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> ---
>  arch/mips/include/asm/mach-loongson64/extcc.h | 26 +++++++++
>  arch/mips/loongson64/Kconfig                  | 13 +++++
>  arch/mips/loongson64/common/Makefile          |  5 ++
>  arch/mips/loongson64/common/extcc.c           | 55 +++++++++++++++++++
>  arch/mips/loongson64/common/time.c            |  7 +++
>  5 files changed, 106 insertions(+)
>  create mode 100644 arch/mips/include/asm/mach-loongson64/extcc.h
>  create mode 100644 arch/mips/loongson64/common/extcc.c
>=20
> diff --git a/arch/mips/include/asm/mach-loongson64/extcc.h b/arch/mips/in=
clude/asm/mach-loongson64/extcc.h
> new file mode 100644
> index 000000000000..9e70f195441e
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-loongson64/extcc.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_MACH_LOONGSON64_EXTCC_H
> +#define __ASM_MACH_LOONGSON64_EXTCC_H
> +
> +extern void extcc_clocksource_init(void);
> +
> +// TODO: is the sync really needed on GS464E? Or if this is really the c=
ase,
> +// is a weakly-ordered version of this suitable for coarser granularity,
> +// just like in x86?

Please use the standard kernel comment style:

/*
 * TODO: ...
 */

> +static __always_inline u64 __extcc_read_ordered(void)
> +{
> +	u64 result;
> +
> +	__asm__ __volatile__(
> +		".set	push\n\t"
> +		".set	arch=3Dmips32r2\n\t"

Generally I'd prefer:

	".set\t" MIPS_ISA_LEVEL "\n\t"

> +		".set	noreorder\n\t"

The .set noreorder directive here is redundant - there are no branches
or jumps in this inline asm & thus no delay slots for the assembler to
reorder instructions into.

> +		"sync\n\t"
> +		"rdhwr	%0, $30\n\t"
> +		".set	pop\n"
> +		: "=3Dr"(result));
> +
> +	return result;
> +}
> +
> +#endif /* __ASM_MACH_LOONGSON64_EXTCC_H */
> diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
> index 4c14a11525f4..a7213a25a6ab 100644
> --- a/arch/mips/loongson64/Kconfig
> +++ b/arch/mips/loongson64/Kconfig
> @@ -123,6 +123,19 @@ config RS780_HPET
> =20
>  	  If unsure, say Yes.
> =20
> +config LOONGSON_EXTCC_CLKSRC
> +	bool "GS464E external counter clocksource"
> +	depends on LOONGSON3_ENHANCEMENT && GENERIC_SCHED_CLOCK
> +	help
> +	  This option enables the external counter found on GS464E chips to
> +	  be used as clocksource.
> +
> +	  The external counter is an internal cycle counter independent of
> +	  processor cores, and provides very good (nanosecond-scale) time
> +	  resolution.
> +
> +	  If unsure, say Yes.
> +
>  config LOONGSON_UART_BASE
>  	bool
>  	default y
> diff --git a/arch/mips/loongson64/common/Makefile b/arch/mips/loongson64/=
common/Makefile
> index 684624f61f5a..5416c794123f 100644
> --- a/arch/mips/loongson64/common/Makefile
> +++ b/arch/mips/loongson64/common/Makefile
> @@ -25,3 +25,8 @@ obj-$(CONFIG_CS5536) +=3D cs5536/
>  #
> =20
>  obj-$(CONFIG_SUSPEND) +=3D pm.o
> +
> +#
> +# ExtCC clocksource support
> +#
> +obj-$(CONFIG_LOONGSON_EXTCC_CLKSRC) +=3D extcc.o
> diff --git a/arch/mips/loongson64/common/extcc.c b/arch/mips/loongson64/c=
ommon/extcc.c
> new file mode 100644
> index 000000000000..702cb389856a
> --- /dev/null
> +++ b/arch/mips/loongson64/common/extcc.c

I think this code belongs under drivers/clocksource/, and the relevant
maintainers should be copied:

$ ./scripts/get_maintainer.pl -f drivers/clocksource
Daniel Lezcano <daniel.lezcano@linaro.org> (supporter:CLOCKSOURCE, CLOCKEVE=
NT DRIVERS)
Thomas Gleixner <tglx@linutronix.de> (supporter:CLOCKSOURCE, CLOCKEVENT DRI=
VERS)
linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS)

> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/clocksource.h>
> +#include <linux/init.h>
> +#include <linux/sched_clock.h>
> +
> +#include <loongson.h>
> +#include <extcc.h>
> +
> +static u64 notrace extcc_read(struct clocksource *cs)
> +{
> +	return __extcc_read_ordered();
> +}
> +
> +static u64 notrace extcc_sched_clock(void)
> +{
> +	return __extcc_read_ordered();
> +}
> +
> +static struct clocksource extcc_clocksource =3D {
> +	.name		=3D "extcc",
> +	.read		=3D extcc_read,
> +	.mask		=3D CLOCKSOURCE_MASK(64),
> +	.flags		=3D CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_VALID_FOR_HRES,
> +	/* TODO later */
> +	.archdata	=3D { .vdso_clock_mode =3D VDSO_CLOCK_NONE },
> +};
> +
> +void __init extcc_clocksource_init(void)
> +{
> +	/* trust the firmware-provided frequency */
> +	u32 extcc_frequency =3D cpu_clock_freq;
> +	int ret;
> +
> +	if (extcc_frequency =3D=3D 0) {
> +		pr_err("Frequency not specified\n");
> +		return;
> +	}

Is this actually possible? The loongson64 implementation of
prom_init_env() seems to always assign a non-zero value to
cpu_clock_freq.

> +
> +	/*
> +	 * As for the rating, 200+ is good while 300+ is desirable.
> +	 * Use 1GHz as bar for "desirable"; most Loongson processors with suppo=
rt
> +	 * for ExtCC already satisfy this.
> +	 */
> +	extcc_clocksource.rating =3D 200 + extcc_frequency / 10000000;
> +
> +	ret =3D clocksource_register_hz(&extcc_clocksource, extcc_frequency);
> +	if (ret < 0)
> +		pr_warn("Unable to register clocksource\n");
> +
> +	/* mark extcc as sched clock */
> +	sched_clock_register(extcc_sched_clock, 64, extcc_frequency);
> +}
> +
> diff --git a/arch/mips/loongson64/common/time.c b/arch/mips/loongson64/co=
mmon/time.c
> index 0ba53c55ff33..afacc50b7501 100644
> --- a/arch/mips/loongson64/common/time.c
> +++ b/arch/mips/loongson64/common/time.c
> @@ -16,6 +16,9 @@
> =20
>  #include <loongson.h>
>  #include <cs5536/cs5536_mfgpt.h>
> +#ifdef CONFIG_LOONGSON_EXTCC_CLKSRC
> +#include <extcc.h>
> +#endif

Drop the #ifdef for header inclusion - it'll be harmless to include the
header even if nothing from it is used.

Thanks,
    Paul

> =20
>  void __init plat_time_init(void)
>  {
> @@ -27,6 +30,10 @@ void __init plat_time_init(void)
>  #else
>  	setup_mfgpt0_timer();
>  #endif
> +
> +#ifdef CONFIG_LOONGSON_EXTCC_CLKSRC
> +	extcc_clocksource_init();
> +#endif
>  }
> =20
>  void read_persistent_clock64(struct timespec64 *ts)
> --=20
> 2.20.1
>=20
>=20
