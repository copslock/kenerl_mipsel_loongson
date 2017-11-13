Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2017 12:24:18 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:55761 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990425AbdKMLYLX26Gn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Nov 2017 12:24:11 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 13 Nov 2017 11:23:53 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 13 Nov
 2017 03:23:14 -0800
Date:   Mon, 13 Nov 2017 11:23:12 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
CC:     <linux-mips@linux-mips.org>, Rob Herring <robh+dt@kernel.org>,
        "Frank Rowand" <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH] MIPS: implement a "bootargs-append" DT property
Message-ID: <20171113112312.GZ15260@jhogan-linux>
References: <1510420788-25184-1-git-send-email-daniel@gimpelevich.san-francisco.ca.us>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PxDrs/Fpf4pPiewX"
Content-Disposition: inline
In-Reply-To: <1510420788-25184-1-git-send-email-daniel@gimpelevich.san-francisco.ca.us>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510572233-321459-27073-240527-2
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186875
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

--PxDrs/Fpf4pPiewX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2017 at 09:19:48AM -0800, Daniel Gimpelevich wrote:
> There are two uses for this:
>=20
> 1) It may be useful to split a device-specific kernel command line between
> a .dts file and a .dtsi file, with "bootargs" in one and "bootargs-append"
> in the other, such as for variations of a reference board.
>=20
> 2) There are kernel configuration options for prepending "bootargs" to the
> kernel command line that the bootloader has passed, but not for appending.
> A new option for this would be a less future-proof solution, since things
> like this should be in the dtb.
>=20
> This is tested on MIPS, but it can be useful on other architectures also.
>=20
> Signed-off-by: Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>

The device tree maintainers should be on Cc. Adding them now.

Cheers
James

> ---
>  arch/mips/kernel/setup.c | 3 +++
>  drivers/of/fdt.c         | 4 ++++
>  2 files changed, 7 insertions(+)
>=20
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index fe39397..95e9bf2 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -826,7 +826,10 @@ static void __init arch_mem_init(char **cmdline_p)
>  	extern void plat_mem_setup(void);
> =20
>  	/* call board setup routine */
> +	strlcpy(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
>  	plat_mem_setup();
> +	if (strncmp(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE) =3D=3D =
0)
> +		boot_command_line[0] =3D '\0';
> =20
>  	/*
>  	 * Make sure all kernel memory is in the maps.  The "UP" and
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index ce30c9a..65dbda6 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1127,6 +1127,10 @@ int __init early_init_dt_scan_chosen(unsigned long=
 node, const char *uname,
>  	p =3D of_get_flat_dt_prop(node, "bootargs", &l);
>  	if (p !=3D NULL && l > 0)
>  		strlcpy(data, p, min((int)l, COMMAND_LINE_SIZE));
> +	p =3D of_get_flat_dt_prop(node, "bootargs-append", &l);
> +	if (p !=3D NULL && l > 0)
> +		strlcat(data, p, min_t(int, strlen(data) + l,
> +					COMMAND_LINE_SIZE));
> =20
>  	/*
>  	 * CONFIG_CMDLINE is meant to be a default in case nothing else
> --=20
> 1.9.1
>=20
>=20

--PxDrs/Fpf4pPiewX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloJgJgACgkQbAtpk944
dnpf+xAAmG5LEovzRhR7TAmxD1nvBm0tHkZU+/HwJiu5w4nG305C6oMO/WKtdHDr
w5fgwnipppZnMpX+K39Nkr2pa0mB0AZS0SFHDehr/Kq03oN/LpGLTUgGVM7HyhBu
3qQoYuBOSiGnQTMBkxbSMGYFKHYqAEJYD8LcPr5g3LP7xXubVUXFYI/cQr1QnkH5
m2AgRHMTXAyIAkPTHxe+fzA2KaHaE2une6uA0bsMR9/rQv2nHoJy33X6r4+dyKPd
upXmxWsrnRmO3FDYnthyo587Jqpq+Equ/R1uGnPylePk/izjWlj5braseyUtdE0C
SfFIHTagkce2kTn9jeSOvDaj2UuD4curgVEBV44/b5kk2rKdUc1dXUVZd/nihvyH
/29pTCr9ROU3OCuMdwF838q9mvZV2mhFg2fQTLxrPJLKBKYkNWWVjSqLI0U0gng2
4msI/EXmjB//F1WQ3o8s8j8HAnUYVofJHMPBnOkreripEmfJxxyvx3m/nMfEG9AI
nO/zDzFPQZ/aS9yig+j2tjlktAZE/4GdcLHixkFHGWx8P/c77mIkXUq1dPLOFn7/
olhpkcR/qMWe6M+i2QzNrKaaROK/wQZfKbhl5AnmB/iHHWbPajuiYl1N+H7k9VJM
eN2qGIx7citvTK1GVykdR9tr++owNvKGaYVuPgjO/t3zzQNlBJo=
=DCvJ
-----END PGP SIGNATURE-----

--PxDrs/Fpf4pPiewX--
