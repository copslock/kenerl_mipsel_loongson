Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jul 2017 22:33:03 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61150 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23994624AbdGCUc4fSOPZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Jul 2017 22:32:56 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 76EAF41F8E08;
        Mon,  3 Jul 2017 22:43:08 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 03 Jul 2017 22:43:08 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 03 Jul 2017 22:43:08 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 18279D8434FCD;
        Mon,  3 Jul 2017 21:32:46 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 3 Jul
 2017 21:32:50 +0100
Date:   Mon, 3 Jul 2017 21:32:50 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 4/4] MIPS16e2: Provide feature overrides for non-MIPS16
 systems
Message-ID: <20170703203250.GN31455@jhogan-linux.le.imgtec.org>
References: <alpine.DEB.2.00.1705180145220.2590@tp.orcam.me.uk>
 <alpine.DEB.2.00.1705230345530.2590@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SgT04PEqo/+yUDw3"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1705230345530.2590@tp.orcam.me.uk>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--SgT04PEqo/+yUDw3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2017 at 01:40:23PM +0100, Maciej W. Rozycki wrote:
> Hardcode the absence of the MIPS16e2 ASE for all the systems that do so=
=20
> for the MIPS16 ASE already, providing for code to be optimized away.
>=20
> Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>

I'm inclined to agree with Florian, that git formatted patches are
slightly easier to review, perhaps they just subjectively look more
familiar. Out of interest, do you not use git for retrieving kernel
source already?

Anyway the actual changes look acceptable to me, so
Reviewed-by: James Hogan <james.hogan@imgtec.com>

Thanks for the series.
James

> ---
> linux-mips16e2-ase-optim.diff
> Index: linux-sfr-test/arch/mips/include/asm/mach-ath25/cpu-feature-overri=
des.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-ath25/cpu-feature-over=
rides.h	2017-05-22 22:42:15.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-ath25/cpu-feature-overrides=
=2Eh	2017-05-22 22:57:28.987400000 +0100
> @@ -40,6 +40,7 @@
>  #endif
> =20
>  #define cpu_has_mips16			0
> +#define cpu_has_mips16e2		0
>  #define cpu_has_mdmx			0
>  #define cpu_has_mips3d			0
>  #define cpu_has_smartmips		0
> Index: linux-sfr-test/arch/mips/include/asm/mach-au1x00/cpu-feature-overr=
ides.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-au1x00/cpu-feature-ove=
rrides.h	2017-05-22 22:42:15.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-au1x00/cpu-feature-override=
s.h	2017-05-22 22:57:28.991406000 +0100
> @@ -31,6 +31,7 @@
>  #define cpu_has_ejtag			1
>  #define cpu_has_llsc			1
>  #define cpu_has_mips16			0
> +#define cpu_has_mips16e2		0
>  #define cpu_has_mdmx			0
>  #define cpu_has_mips3d			0
>  #define cpu_has_smartmips		0
> Index: linux-sfr-test/arch/mips/include/asm/mach-bcm63xx/cpu-feature-over=
rides.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-bcm63xx/cpu-feature-ov=
errides.h	2017-05-22 22:42:15.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrid=
es.h	2017-05-22 22:57:28.995412000 +0100
> @@ -19,6 +19,7 @@
>  #define cpu_has_ejtag			1
>  #define cpu_has_llsc			1
>  #define cpu_has_mips16			0
> +#define cpu_has_mips16e2		0
>  #define cpu_has_mdmx			0
>  #define cpu_has_mips3d			0
>  #define cpu_has_smartmips		0
> Index: linux-sfr-test/arch/mips/include/asm/mach-cobalt/cpu-feature-overr=
ides.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-cobalt/cpu-feature-ove=
rrides.h	2017-05-22 22:42:15.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-cobalt/cpu-feature-override=
s.h	2017-05-22 22:57:29.001406000 +0100
> @@ -37,6 +37,7 @@
>  #endif
> =20
>  #define cpu_has_mips16		0
> +#define cpu_has_mips16e2	0
>  #define cpu_has_mdmx		0
>  #define cpu_has_mips3d		0
>  #define cpu_has_smartmips	0
> Index: linux-sfr-test/arch/mips/include/asm/mach-dec/cpu-feature-override=
s.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-dec/cpu-feature-overri=
des.h	2017-05-22 22:42:15.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-dec/cpu-feature-overrides.h=
	2017-05-22 22:57:29.006398000 +0100
> @@ -27,6 +27,7 @@
>  #define cpu_has_mcheck			0
>  #define cpu_has_ejtag			0
>  #define cpu_has_mips16			0
> +#define cpu_has_mips16e2		0
>  #define cpu_has_mdmx			0
>  #define cpu_has_mips3d			0
>  #define cpu_has_smartmips		0
> Index: linux-sfr-test/arch/mips/include/asm/mach-ip22/cpu-feature-overrid=
es.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-ip22/cpu-feature-overr=
ides.h	2017-05-22 22:42:15.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-ip22/cpu-feature-overrides.=
h	2017-05-22 22:57:29.010397000 +0100
> @@ -19,6 +19,7 @@
>  #define cpu_has_32fpr		1
>  #define cpu_has_counter		1
>  #define cpu_has_mips16		0
> +#define cpu_has_mips16e2	0
>  #define cpu_has_divec		0
>  #define cpu_has_cache_cdex_p	1
>  #define cpu_has_prefetch	0
> Index: linux-sfr-test/arch/mips/include/asm/mach-ip27/cpu-feature-overrid=
es.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-ip27/cpu-feature-overr=
ides.h	2017-05-22 22:42:15.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.=
h	2017-05-22 22:57:29.020398000 +0100
> @@ -43,6 +43,7 @@
>  #define cpu_has_ejtag			0
>  #define cpu_has_llsc			1
>  #define cpu_has_mips16			0
> +#define cpu_has_mips16e2		0
>  #define cpu_has_mdmx			0
>  #define cpu_has_mips3d			0
>  #define cpu_has_smartmips		0
> Index: linux-sfr-test/arch/mips/include/asm/mach-ip28/cpu-feature-overrid=
es.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-ip28/cpu-feature-overr=
ides.h	2017-05-22 22:42:15.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-ip28/cpu-feature-overrides.=
h	2017-05-22 22:57:29.024398000 +0100
> @@ -16,6 +16,7 @@
>   */
>  #define cpu_has_watch		1
>  #define cpu_has_mips16		0
> +#define cpu_has_mips16e2	0
>  #define cpu_has_divec		0
>  #define cpu_has_vce		0
>  #define cpu_has_cache_cdex_p	0
> Index: linux-sfr-test/arch/mips/include/asm/mach-ip32/cpu-feature-overrid=
es.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-ip32/cpu-feature-overr=
ides.h	2017-05-22 22:42:15.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-ip32/cpu-feature-overrides.=
h	2017-05-22 22:57:29.028408000 +0100
> @@ -29,6 +29,7 @@
>  #define cpu_has_32fpr		1
>  #define cpu_has_counter		1
>  #define cpu_has_mips16		0
> +#define cpu_has_mips16e2	0
>  #define cpu_has_vce		0
>  #define cpu_has_cache_cdex_s	0
>  #define cpu_has_mcheck		0
> Index: linux-sfr-test/arch/mips/include/asm/mach-jz4740/cpu-feature-overr=
ides.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-jz4740/cpu-feature-ove=
rrides.h	2017-05-22 22:42:15.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-jz4740/cpu-feature-override=
s.h	2017-05-22 22:57:29.032407000 +0100
> @@ -23,6 +23,7 @@
>  #define cpu_has_ejtag 1
>  #define cpu_has_llsc		1
>  #define cpu_has_mips16 0
> +#define cpu_has_mips16e2	0
>  #define cpu_has_mdmx 0
>  #define cpu_has_mips3d 0
>  #define cpu_has_smartmips 0
> Index: linux-sfr-test/arch/mips/include/asm/mach-loongson64/cpu-feature-o=
verrides.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-loongson64/cpu-feature=
-overrides.h	2017-05-22 22:42:16.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-loongson64/cpu-feature-over=
rides.h	2017-05-22 22:57:29.043398000 +0100
> @@ -32,6 +32,7 @@
>  #define cpu_has_mcheck		0
>  #define cpu_has_mdmx		0
>  #define cpu_has_mips16		0
> +#define cpu_has_mips16e2	0
>  #define cpu_has_mips3d		0
>  #define cpu_has_mipsmt		0
>  #define cpu_has_smartmips	0
> Index: linux-sfr-test/arch/mips/include/asm/mach-netlogic/cpu-feature-ove=
rrides.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-netlogic/cpu-feature-o=
verrides.h	2017-05-22 22:42:16.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-netlogic/cpu-feature-overri=
des.h	2017-05-22 22:57:29.047397000 +0100
> @@ -13,6 +13,7 @@
>  #define cpu_has_4k_cache	1
>  #define cpu_has_watch		1
>  #define cpu_has_mips16		0
> +#define cpu_has_mips16e2	0
>  #define cpu_has_counter		1
>  #define cpu_has_divec		1
>  #define cpu_has_vce		0
> Index: linux-sfr-test/arch/mips/include/asm/mach-rc32434/cpu-feature-over=
rides.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-rc32434/cpu-feature-ov=
errides.h	2017-05-22 22:42:16.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-rc32434/cpu-feature-overrid=
es.h	2017-05-22 22:57:29.051411000 +0100
> @@ -48,6 +48,7 @@
>  #define cpu_has_llsc			1
> =20
>  #define cpu_has_mips16			0
> +#define cpu_has_mips16e2		0
>  #define cpu_has_mdmx			0
>  #define cpu_has_mips3d			0
>  #define cpu_has_smartmips		0
> Index: linux-sfr-test/arch/mips/include/asm/mach-rm/cpu-feature-overrides=
=2Eh
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-rm/cpu-feature-overrid=
es.h	2017-05-22 22:42:16.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-rm/cpu-feature-overrides.h	=
2017-05-22 22:57:29.066402000 +0100
> @@ -17,6 +17,7 @@
>  #define cpu_has_counter		1
>  #define cpu_has_watch		0
>  #define cpu_has_mips16		0
> +#define cpu_has_mips16e2	0
>  #define cpu_has_divec		0
>  #define cpu_has_cache_cdex_p	1
>  #define cpu_has_prefetch	0
> Index: linux-sfr-test/arch/mips/include/asm/mach-sibyte/cpu-feature-overr=
ides.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-sibyte/cpu-feature-ove=
rrides.h	2017-05-22 22:42:16.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-sibyte/cpu-feature-override=
s.h	2017-05-22 22:57:29.070404000 +0100
> @@ -13,6 +13,7 @@
>   */
>  #define cpu_has_watch		1
>  #define cpu_has_mips16		0
> +#define cpu_has_mips16e2	0
>  #define cpu_has_divec		1
>  #define cpu_has_vce		0
>  #define cpu_has_cache_cdex_p	0
> Index: linux-sfr-test/arch/mips/include/asm/mach-tx49xx/cpu-feature-overr=
ides.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-tx49xx/cpu-feature-ove=
rrides.h	2017-05-22 22:42:16.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-tx49xx/cpu-feature-override=
s.h	2017-05-22 22:57:29.074404000 +0100
> @@ -6,6 +6,7 @@
>  #define cpu_has_inclusive_pcaches	0
> =20
>  #define cpu_has_mips16		0
> +#define cpu_has_mips16e2	0
>  #define cpu_has_mdmx		0
>  #define cpu_has_mips3d		0
>  #define cpu_has_smartmips	0

--SgT04PEqo/+yUDw3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllaqfEACgkQbAtpk944
dnpkEQ//ZORZJjvGKp3/e33ivMg5724/HzJHHDr+BknV+mPYmG3YOCSehVjDZPbE
gMWeZ9GIiziQDaVYAEvqtNx8VGp+dpBGipBZ/H8r9Fbkmpe5piHCchdsRdDe0Yyn
/IQXQTPj4KQ7w+pnJe7u8iWTBkeMGU3lx9OcgdJ8D2aHmT4FngPchhpiy1iDLWFN
1ZX9oEUetTBOwMFYakQHeqKuIt+6/rCeFYElWT35W/KIMDJDorP6HhStUB+oUJI6
68R5+tJCmUZSrEb7rALJlzgWw+IpCx4s7aEf6sT/SfOndldiPBFSa8GDBLFVBf4B
JWpeEQR7aZ0XlBRRDu/5Jt4Hk8e1eCydVGvQXrY1z9dZIjkgwKBTp5KZwyqJNBdA
jiY/+SlH4601gG5cCqV4qvTGoU46F70SmCC7UyuS5djT8CXLoawG6jM1AtN4+XPW
dsXudw4iIJ/DmLM1k5W0prKx8MEgzcTKKoXngKodLpZ//Kd1t06rST/TqmNm5AQi
VXtz0LA6ionVHgm7t0q2O6gyKPFVcg6vfKJr4aLK2PLWKtRWVoa7hCsfM2ZZCT8K
eaf36+c34yyJc93RNQVifMbCbC5s5R1bRs8vmGKVT5eh/j8Xw8L8QFJ0t4B9BAGM
9xQ1WEqM0IWzhpj831SRm6OS15SPelB7lQREjXxSHpHvaEKa0d0=
=+Ds4
-----END PGP SIGNATURE-----

--SgT04PEqo/+yUDw3--
