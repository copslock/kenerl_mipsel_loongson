Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Mar 2018 16:47:57 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:41550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994719AbeCGPru5XjNy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Mar 2018 16:47:50 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3296F2172D;
        Wed,  7 Mar 2018 15:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3296F2172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 7 Mar 2018 15:47:39 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/5] MIPS: generic: Add support for Microsemi Ocelot
Message-ID: <20180307154739.GR4197@saruman>
References: <20180306121607.1567-1-alexandre.belloni@bootlin.com>
 <20180306121607.1567-5-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ayym4vmyMU9P4uDb"
Content-Disposition: inline
In-Reply-To: <20180306121607.1567-5-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62840
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


--Ayym4vmyMU9P4uDb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Mar 06, 2018 at 01:16:06PM +0100, Alexandre Belloni wrote:
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index d1ca839c3981..d2882244cf1f 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -543,6 +543,10 @@ generic_defconfig:
>  # now that the boards have been converted to use the generic kernel they are
>  # wrappers around the generic rules above.
>  #
> +.PHONY: ocelot_defconfig
> +ocelot_defconfig:
> +	$(Q)$(MAKE) -f $(srctree)/Makefile 32r2el_defconfig BOARDS=ocelot

FYI this conflicts with https://patchwork.linux-mips.org/patch/18596/,
but can be trivially fixed up when applied to the following, so no need
for you to rebase:

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 2ed4c8927701..646a2d98012d 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -565,6 +565,9 @@ generic_defconfig:
 # now that the boards have been converted to use the generic kernel they are
 # wrappers around the generic rules above.
 #
+legacy_defconfigs		+= ocelot_defconfig
+ocelot_defconfig-y		:= 32r2el_defconfig BOARDS=ocelot
+
 legacy_defconfigs		+= sead3_defconfig
 sead3_defconfig-y		:= 32r2el_defconfig BOARDS=sead-3

> +
>  .PHONY: sead3_defconfig
>  sead3_defconfig:
>  	$(Q)$(MAKE) -f $(srctree)/Makefile 32r2el_defconfig BOARDS=sead-3
> diff --git a/arch/mips/configs/generic/board-ocelot.config b/arch/mips/configs/generic/board-ocelot.config
> new file mode 100644
> index 000000000000..fa4e8988ebc8
> --- /dev/null
> +++ b/arch/mips/configs/generic/board-ocelot.config
> @@ -0,0 +1,36 @@
> +# require CONFIG_32BIT=y

That should be implied now by CPU_SUPPORTS_64BIT_KERNEL=n since
CONFIG_CPU_MIPS32_R2=y.

> +# require CONFIG_CPU_MIPS32_R2=y

> +static __init bool ocelot_detect(void)
> +{
> +	u32 rev;
> +
> +	rev = __raw_readl((void *)DEVCPU_GCB_CHIP_REGS_CHIP_ID);

How about a TLB check first, a bit like _kvm_mips_host_tlb_inv() in
arch/mips/kvm/tlb.c, i.e.:

	int idx;

	/* Look for the TLB entry set up by redboot before trying to use it */
	write_c0_entryhi(DEVCPU_GCB_CHIP_REGS_CHIP_ID);
	mtc0_tlbw_hazard();
	tlb_probe();
	tlb_probe_hazard();
	idx = read_c0_index();
	if (idx < 0)
		return 0;

	/* A TLB entry exists, lets assume its usable and check the CHIP ID */
	rev = __raw_readl((void __iomem *)DEVCPU_GCB_CHIP_REGS_CHIP_ID);

(That assumes that if a TLB entry exists that it will be usable, which
isn't technically complete since the entry may not be marked valid, but
its probably sufficient in practice).

Incidentally you need to use __iomem there to avoid the following sparse
error:

arch/mips/generic/board-ocelot.c:21:28: warning: incorrect type in argument 1 (different address spaces)
arch/mips/generic/board-ocelot.c:21:28:    expected void const volatile [noderef] <asn:2>*mem
arch/mips/generic/board-ocelot.c:21:28:    got void *<noident>

Cheers
James

--Ayym4vmyMU9P4uDb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqgCZsACgkQbAtpk944
dnrKjg//cqAgqz2QxebXprkbAg4FBbkE+q3fhBURg0O4tIS93jrslAybY8Ej7558
gMr6RTNhE2sZVjZpE4zHOoDYd4ruow8+1UVSezqwPErZMD0IZJSF1xl3XX4eDoSq
i3zz1Vb8iQBYNRDoQEpJhpZ/B7bqUgI0cmY/obbxJTnVIg9e6PowzXuIVJj/5txm
tE8yRlPdT+uhOuAP2fl39/sM8R6Eq0t/ZoJ/bdaJg9Q6/lDBoTbqxEdPaj+06YLn
vJb2IcqCVSclLBJQ10Psxxl31+28Qk6Z00rpTaHof0Koc2GmXRVqi0oXILdeZEUG
UxoB6wKJibtSgbqFHhn3grzbDKQ/UPkltdE6+vy8XlRDrDuZbhBWf68mbk3ThB6y
ftMvcNIL0vGwxAilBx1Xf6pBPLf6AG6IujoLiXMrYB1BlojBUYm5sNUZe3L1JAih
poVchrZDX5QLOrpqarYgfEeM3XOm/2MvNzBVlFnonp6Rbu7MOd6Srbj0vbfvdehq
ypWi18MrisCktP7k9pAtGxPL7DNfNNhpYjwRpD6BNQzruZn4DVLN04e8pxbdrxk5
rtekEC2nnxxslfuCUsYs6loxWUD+FWOb8cmHRQVY+nlqVS9TNC6K+8cpFiFrDRzo
XgeebXOH27wBTSz8FI+AB5Pu1vO76hXbtBaVfPZ3eICuI8v+Hvs=
=sWNK
-----END PGP SIGNATURE-----

--Ayym4vmyMU9P4uDb--
