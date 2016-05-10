Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 May 2016 12:02:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54780 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27028613AbcEJKCSRxm8l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 May 2016 12:02:18 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 8361A41F8E23;
        Tue, 10 May 2016 11:02:10 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 10 May 2016 11:02:10 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 10 May 2016 11:02:10 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 3C5F5B9E3F797;
        Tue, 10 May 2016 11:02:07 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 10 May 2016 11:02:10 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Tue, 10 May
 2016 11:02:09 +0100
Date:   Tue, 10 May 2016 11:02:09 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <Matt.Redfearn@imgtec.com>
Subject: Re: [PATCH 2/5] MIPS: Add defs & probing of 64-bit CP0_EBase
Message-ID: <20160510100209.GB12554@jhogan-linux.le.imgtec.org>
References: <1461937563-13199-1-git-send-email-james.hogan@imgtec.com>
 <1461937563-13199-3-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
In-Reply-To: <1461937563-13199-3-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 6e37d52
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53340
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

--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 29, 2016 at 02:46:00PM +0100, James Hogan wrote:
> MIPS64r2 and later cores may optionally have a 64-bit CP0_EBase
> register, with a write gate (WG) bit to allow the upper half to be
> written. The presence of this feature will need to be known about for VZ
> support in order to correctly save and restore the guest CP0_EBase
> register, so add CPU feature definitions and probing for this
> capability.

Okay, so it turns out EBase.WG can be present on MIPS32 too, to allow
writing of bits 31:30 (thanks Matt!), so this needs a little more
thought.

Cheers
James

>=20
> Probing the WG bit is a bit fiddly, since 64-bit COP0 register access
> instructions were UNDEFINED for 32-bit registers prior to MIPS r6, and
> it'd be nice to be able to probe without clobbering the existing state,
> so there are 3 potential paths:
>=20
> - If we do a 32-bit read of CP0_EBase and the WG bit is already set, the
>   register must be 64-bit.
>=20
> - On MIPS r6 we can do a 64-bit read-modify-write to set CP0_EBase.WG,
>   since the upper bits will read 0 and be ignored on write if the
>   register is 32-bit.
>=20
> - On pre-r6 cores, we do a 32-bit read-modify-write of CP0_EBase. This
>   avoids the potentially UNDEFINED behaviour, but will clobber the upper
>   32-bits of CP0_EBase if it isn't a simple sign extension (which also
>   requires us to ensure BEV=3D1 or modifying the exception base would be
>   UNDEFINED too). It is hopefully unlikely a bootloader would set up
>   CP0_EBase to a 64-bit segment and leave WG=3D0.
>=20
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> ---
>  arch/mips/include/asm/cpu-features.h |  4 ++++
>  arch/mips/include/asm/cpu.h          |  1 +
>  arch/mips/include/asm/mipsregs.h     |  3 +++
>  arch/mips/kernel/cpu-probe.c         | 35 ++++++++++++++++++++++++++++++=
+++++
>  4 files changed, 43 insertions(+)
>=20
> diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm=
/cpu-features.h
> index da92d513a395..a3d3de8ab145 100644
> --- a/arch/mips/include/asm/cpu-features.h
> +++ b/arch/mips/include/asm/cpu-features.h
> @@ -432,4 +432,8 @@
>  #define cpu_has_nan_2008	(cpu_data[0].options & MIPS_CPU_NAN_2008)
>  #endif
> =20
> +#ifndef cpu_has_ebase64
> +# define cpu_has_ebase64	(cpu_data[0].options & MIPS_CPU_EBASE64)
> +#endif
> +
>  #endif /* __ASM_CPU_FEATURES_H */
> diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
> index 79ce9ae0a3c7..11a7f78bb1f7 100644
> --- a/arch/mips/include/asm/cpu.h
> +++ b/arch/mips/include/asm/cpu.h
> @@ -403,6 +403,7 @@ enum cpu_type_enum {
>  #define MIPS_CPU_NAN_2008	MBIT_ULL(39)	/* 2008 NaN implemented */
>  #define MIPS_CPU_VP		MBIT_ULL(40)	/* MIPSr6 Virtual Processors (multi-th=
reading) */
>  #define MIPS_CPU_LDPTE		MBIT_ULL(41)	 /* CPU has ldpte/lddir instruction=
s */
> +#define MIPS_CPU_EBASE64	MBIT_ULL(42)	/* CPU has 64-bit EBase */
> =20
>  /*
>   * CPU ASE encodings
> diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mip=
sregs.h
> index 24904f1f6fe1..cc17f4886f00 100644
> --- a/arch/mips/include/asm/mipsregs.h
> +++ b/arch/mips/include/asm/mipsregs.h
> @@ -1456,6 +1456,9 @@ do {									\
>  #define read_c0_ebase()		__read_32bit_c0_register($15, 1)
>  #define write_c0_ebase(val)	__write_32bit_c0_register($15, 1, val)
> =20
> +#define read_c0_ebase_64()	__read_64bit_c0_register($15, 1)
> +#define write_c0_ebase_64(val)	__write_64bit_c0_register($15, 1, val)
> +
>  #define read_c0_cdmmbase()	__read_ulong_c0_register($15, 2)
>  #define write_c0_cdmmbase(val)	__write_ulong_c0_register($15, 2, val)
> =20
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index b766952afc5c..eb62c730b97f 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -845,6 +845,41 @@ static void decode_configs(struct cpuinfo_mips *c)
>  	if (ok)
>  		ok =3D decode_config5(c);
> =20
> +	/* Probe the size of the EBase register */
> +	if (config_enabled(CONFIG_64BIT) && cpu_has_mips_r2_r6) {
> +		unsigned long ebase;
> +		unsigned int status;
> +
> +		/* {read,write}_c0_ebase_64() may be UNDEFINED prior to r6 */
> +		ebase =3D cpu_has_mips64r6 ? read_c0_ebase_64()
> +					 : (s32)read_c0_ebase();
> +		if (ebase & MIPS_EBASE_WG) {
> +			/* WG bit already set, we can avoid the clumsy probe */
> +			c->options |=3D MIPS_CPU_EBASE64;
> +		} else {
> +			/* Its UNDEFINED to change EBase while BEV=3D0 */
> +			status =3D read_c0_status();
> +			write_c0_status(status | ST0_BEV);
> +			irq_enable_hazard();
> +			/*
> +			 * On pre-r6 cores, this may well clobber the upper bits
> +			 * of EBase. This is hard to avoid without potentially
> +			 * hitting UNDEFINED dm*c0 behaviour if EBase is 32-bit.
> +			 */
> +			if (cpu_has_mips64r6)
> +				write_c0_ebase_64(ebase | MIPS_EBASE_WG);
> +			else
> +				write_c0_ebase(ebase | MIPS_EBASE_WG);
> +			back_to_back_c0_hazard();
> +			/* Restore BEV */
> +			write_c0_status(status);
> +			if (read_c0_ebase() & MIPS_EBASE_WG) {
> +				c->options |=3D MIPS_CPU_EBASE64;
> +				write_c0_ebase(ebase);
> +			}
> +		}
> +	}
> +
>  	mips_probe_watch_registers(c);
> =20
>  #ifndef CONFIG_MIPS_CPS
> --=20
> 2.4.10
>=20

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMbGhAAoJEGwLaZPeOHZ614sQAJcOcDtnixfr/nPirtF8xZiV
Pilstfjs8oFBfk9p7L++lIHnRKFyv01MOrcL6nkD+174bAGNhHEjJoQeeSnKlPWi
3IZe1ovitn2mS31Q9XvxQXx0TH3DFWArV4D29W+XeaDm2AODbbVc/zQeSN5CkEKH
8JQjji/PC+ighXCEGMU+H6AQszQ6EF18Lc4h9lNqw1ZpnwHmDQoIdrEdWrVv0O3g
w3hd/MYwZtYoG8a2HLkXiaSqhNOHpETDoqg5M+AiAzhm4U4twDiYYn180gLmgn7C
FSQt2LviqEqGzGmrkjFlZULfQnz34lQrrD3Jns1/ZFoQpS051MM4XYf9yvtfUo4b
arld5nrF8xULXcTVGnA4PBqtuoBa6vvtUV2B6mJ8UVDVJn/8TR0pCFjwbO3jYAEV
mM/c2mwb/oNsvQznc0vWTvaG5TtYpZYiL9jUeD1mFCyZlhwGh1eaHPePOdR6D9Cb
o1cuR0Hv2iGVnbM9SigeJoeF0QhM30tspvK7rBOd135hkKNg+n5C7g4ybVxShN38
ZmmqtA9Yww6sjcIoYR0y0WiWwZwTlTMOtp0/gCZkRtUBF6A5yed1Tweq4Zl2BTWz
RnkUGN5NoA9YABJdCVae8k3Kmovps6tPNJj0U+lIQnRM0aSgi4ED/k65fL5sHBA6
EY8kj+8N77RymyoiLgno
=vHQY
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
