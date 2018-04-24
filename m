Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Apr 2018 13:50:15 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:56776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992966AbeDXLuJPdF60 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Apr 2018 13:50:09 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2968821735;
        Tue, 24 Apr 2018 11:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2968821735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Tue, 24 Apr 2018 12:49:57 +0100
From:   James Hogan <jhogan@kernel.org>
To:     IKEGAMI Tokunori <ikegami@allied-telesis.co.jp>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        PACKHAM Chris <chris.packham@alliedtelesis.co.nz>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: MIPS: BCM47XX: Enable MIPS32 74K Core ExternalSync for BCM47XX
 PCIe erratum
Message-ID: <20180424114956.GA28813@saruman>
References: <TY1PR01MB0954C80E15BA87D03E3A6880DC880@TY1PR01MB0954.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <TY1PR01MB0954C80E15BA87D03E3A6880DC880@TY1PR01MB0954.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 24, 2018 at 07:33:51AM +0000, IKEGAMI Tokunori wrote:
> Let us consult to change MIPS BCM47XX to enable MIPS32 74K Core ExternalS=
ync.
> Can we change the MIPS BCM47XX driver like this?
> If any comment or concern please let us know.

Thanks for the patch.

Please use git-send-email to send patches in future if possible (you can
put additional comments that aren't part of the commit message after a
"---" separator). That should help format it correctly and will put a
[PATCH] prefix etc.

I've also Cc'd Hauke and Rafa=C5=82 who maintain the BCM47XX platform.
Running scripts/get_maintainer.pl on the patch will list some
maintainers who might be worth Cc'ing on a patch.

>=20
>=20
> From d6904a5fc90aaf205e982755e4d6cda62ad21273 Mon Sep 17 00:00:00 2001
> From: Tokunori Ikegami <ikegami@allied-telesis.co.jp>
> Date: Thu, 22 Feb 2018 12:02:16 +0900
> Subject: [PATCH 1/2] MIPS: BCM47XX: Enable MIPS32 74K Core ExternalSync f=
or
>  BCM47XX PCIe erratum
>=20
> The erratum and workaround are described by BCM5300X-ES300-RDS.pdf as bel=
ow.

Is that document accessible anywhere publicly?

>=20
>   R10: PCIe Transactions Periodically Fail
>=20
>     Description: The BCM5300X PCIe does not maintain transaction ordering.
>                  This may cause PCIe transaction failure.
>     Fix Comment: Add a dummy PCIe configuration read after a PCIe
>                  configuration write to ensure PCIe configuration access
>                  ordering. Set ES bit of CP0 configu7 register to enable
>                  sync function so that the sync instruction is functional.
>     Resolution:  hndpci.c: extpci_write_config()
>                  hndmips.c: si_mips_init()
>                  mipsinc.h CONF7_ES
>=20
> This is fixed by the CFE MIPS bcmsi chipset driver also for BCM47XX.
> Also the dummy PCIe configuration read is already implemented in the Linux
> BCMA driver.

> This patch is just to enable ExternalSync in the Linux driver.

I suggest rewording this line to explain how ES helps, maybe something
along the lines of:
"Enable ExternalSync in Config7 when CONFIG_BCMA_DRIVER_PCI_HOSTMODE=3Dy
too so that the sync instruction is externalised..."=20

(Best not to refer to "this patch", just say what it does, and in Linux
terminology this is architecture code, not really a driver).

>=20
> Change-Id: Ifc7a0ce46962933731297ad0c82682e7d39328ff

You can drop this from upstream submissions in future.

You also need a signed-off-by line as described in
Documentation/process/submitting-patches.rst to certify the work as
complying with the "Developer's Certificate of Origin".

> Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  arch/mips/include/asm/mipsregs.h | 2 ++
>  arch/mips/kernel/cpu-probe.c     | 7 +++++++
>  2 files changed, 9 insertions(+)
>=20
> diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mip=
sregs.h
> index 858752dac337..1d1f4416a0f3 100644
> --- a/arch/mips/include/asm/mipsregs.h
> +++ b/arch/mips/include/asm/mipsregs.h
> @@ -680,6 +680,8 @@
>  #define MIPS_CONF7_WII		(_ULCAST_(1) << 31)
> =20
>  #define MIPS_CONF7_RPS		(_ULCAST_(1) << 2)
> +/* ExternalSync */
> +#define MIPS_CONF7_ES		(_ULCAST_(1) << 8)
> =20
>  #define MIPS_CONF7_IAR		(_ULCAST_(1) << 10)
>  #define MIPS_CONF7_AR		(_ULCAST_(1) << 16)
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index cf3fd549e16d..9171928c40dd 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -429,6 +429,13 @@ static inline void check_errata(void)
>  		if ((c->processor_id & PRID_REV_MASK) <=3D PRID_REV_34K_V1_0_2)
>  			write_c0_config7(read_c0_config7() | MIPS_CONF7_RPS);
>  		break;
> +#ifdef CONFIG_BCMA_DRIVER_PCI_HOSTMODE
> +	case CPU_74K:
> +		/* Enable ExternalSync for sync instruction to take effect */

I think it would be helpful to mention the affected device and any
errata number in this comment.

> +		pr_info("ExternalSync has been enabled\n");
> +		write_c0_config7(read_c0_config7() | MIPS_CONF7_ES);
=20
(I would have suggested adding:

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsr=
egs.h
index f65859784a4c..af6e59cfc763 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -2760,6 +2760,7 @@ __BUILD_SET_C0(status)
 __BUILD_SET_C0(cause)
 __BUILD_SET_C0(config)
 __BUILD_SET_C0(config5)
+__BUILD_SET_C0(config7)
 __BUILD_SET_C0(intcontrol)
 __BUILD_SET_C0(intctl)
 __BUILD_SET_C0(srsmap)

Then you can just do:

set_c0_config7(MIPS_CONF7_ES);

But I see the write(read() | x) form is already there in that file, so
probably best to remain consistent with that. Using set_c0_config7() can
always be done later as a separate patch.)

Otherwise the change itself looks reasonable to me.

Thanks
James

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWt8Z5AAKCRA1zuSGKxAj
8rBsAP4qslu5a8WW0CnBf43bBPSjXWJGUj1zvHmHDhzYwZhfbgD+LdI1t43JML+f
afR7FZ/TtTxiDZdc7MQcBMMX8VcGbQ0=
=+kt5
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
