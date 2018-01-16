Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2018 23:06:50 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:50784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994668AbeAPWGnx6-ng (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Jan 2018 23:06:43 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74ECE2171F;
        Tue, 16 Jan 2018 22:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74ECE2171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Tue, 16 Jan 2018 22:06:31 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v7 10/14] MIPS: ingenic: Detect machtype from SoC
 compatible string
Message-ID: <20180116220630.GD29126@saruman>
References: <20180105182513.16248-2-paul@crapouillou.net>
 <20180116154804.21150-1-paul@crapouillou.net>
 <20180116154804.21150-11-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Hf61M2y+wYpnELGG"
Content-Disposition: inline
In-Reply-To: <20180116154804.21150-11-paul@crapouillou.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62194
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


--Hf61M2y+wYpnELGG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2018 at 04:48:00PM +0100, Paul Cercueil wrote:
> Previously, the mips_machtype variable was always initialized
> to MACH_INGENIC_JZ4740 even if running on different SoCs.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  arch/mips/jz4740/prom.c  |  1 -
>  arch/mips/jz4740/setup.c | 22 +++++++++++++++++++---
>  2 files changed, 19 insertions(+), 4 deletions(-)
>=20
>  v2: No change
>  v3: No change
>  v4: No change
>  v5: Use SPDX license identifier
>  v6: Init mips_machtype from DT compatible string instead of using
>      MIPS_MACHINE
>  v7: Fix system name not initialized
>=20
> diff --git a/arch/mips/jz4740/prom.c b/arch/mips/jz4740/prom.c
> index a62dd8e6ecf9..eb9f2f97bedb 100644
> --- a/arch/mips/jz4740/prom.c
> +++ b/arch/mips/jz4740/prom.c
> @@ -25,7 +25,6 @@
> =20
>  void __init prom_init(void)
>  {
> -	mips_machtype =3D MACH_INGENIC_JZ4740;
>  	fw_init_cmdline();
>  }
> =20
> diff --git a/arch/mips/jz4740/setup.c b/arch/mips/jz4740/setup.c
> index 6d0152321819..afb40f8bce96 100644
> --- a/arch/mips/jz4740/setup.c
> +++ b/arch/mips/jz4740/setup.c
> @@ -53,6 +53,16 @@ static void __init jz4740_detect_mem(void)
>  	add_memory_region(0, size, BOOT_MEM_RAM);
>  }
> =20
> +static unsigned long __init get_board_mach_type(const void *fdt)
> +{
> +	if (!fdt_node_check_compatible(fdt, 0, "ingenic,jz4780"))
> +		return MACH_INGENIC_JZ4780;
> +	if (!fdt_node_check_compatible(fdt, 0, "ingenic,jz4770"))
> +		return MACH_INGENIC_JZ4770;

Based on the assumption that fdt will always be non-NULL since commit
ffb1843d059c ("MIPS: JZ4740: require & include DT"):

Reviewed-by: James Hogan <jhogan@kernel.org>

Cheers
James

> +
> +	return MACH_INGENIC_JZ4740;
> +}
> +
>  void __init plat_mem_setup(void)
>  {
>  	int offset;
> @@ -63,6 +73,8 @@ void __init plat_mem_setup(void)
>  	offset =3D fdt_path_offset(__dtb_start, "/memory");
>  	if (offset < 0)
>  		jz4740_detect_mem();
> +
> +	mips_machtype =3D get_board_mach_type(__dtb_start);
>  }
> =20
>  void __init device_tree_init(void)
> @@ -75,10 +87,14 @@ void __init device_tree_init(void)
> =20
>  const char *get_system_type(void)
>  {
> -	if (IS_ENABLED(CONFIG_MACH_JZ4780))
> +	switch (mips_machtype) {
> +	case MACH_INGENIC_JZ4780:
>  		return "JZ4780";
> -
> -	return "JZ4740";
> +	case MACH_INGENIC_JZ4770:
> +		return "JZ4770";
> +	default:
> +		return "JZ4740";
> +	}
>  }
> =20
>  void __init arch_init_irq(void)
> --=20
> 2.11.0
>=20

--Hf61M2y+wYpnELGG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlped2YACgkQbAtpk944
dnrE0g//YvX0bWzNFweVaQ56+ZG87QlEb4C/+YFfWbizaH/3Vp/15VfJAVPmULVI
I7d68yukNWGIInE2PGn+Cc3vkaRtGTzvZwqnChWPYnuLeVujOJoFSaQ+AYTynfRL
aOHvMxRfA6FZ/ZlSPgybY4cEPj0mXdImiB/P45DcDLfZxJ81G5Gpe6pU7OY/DDxL
JOYDIjLXBWNctnZwAb6yTzXAfL0T+y/IciLupZECz+Z/1pWoHSup0plKvZUWahzN
K5TupyXSoZk61ht9avNigv0vtHnMxK4GbqmcYAwSSmeKhuX/27al1uJa4NQVtzHY
8kS0AhvFhvJW4DxsyK9zZS+ktQiP2zfJccxbYhM7AfkME44b+Uci0oXxkcLuxoNy
JJ+rWJFTe8yP8VdsS09V0CF5MHgQY2L9GYuTi/OP04eI6vG9ILMcjbBW1DoC7qDD
zRX7eXpoiQzf4YCQCcjERQ3bWGmFEtWpWcZ5ft5HRc5X4tc0hLJthZ6bRN4+8S3t
0esFEklIWfNhM3q4oziUC16h33Ae2jlyFkqdwSeLGjg4nj4Mxlyf8T1NN0LsY4RI
EutsK6e0j6IPYw7R2ZweKhck4BwsIGu9cTpteQrIoSB6HXsZrmDnnSSPNR781S60
98q25dCk0xYCxVKPUwEQaIVoepBS6AE5xjT3qhJb5SH7a8aYCrk=
=u6Xx
-----END PGP SIGNATURE-----

--Hf61M2y+wYpnELGG--
