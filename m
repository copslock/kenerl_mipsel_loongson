Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jul 2017 20:33:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13777 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993873AbdGCSdC2Qe7O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Jul 2017 20:33:02 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 740AB41F8E08;
        Mon,  3 Jul 2017 20:43:12 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 03 Jul 2017 20:43:12 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 03 Jul 2017 20:43:12 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 9B8C580E1BBDB;
        Mon,  3 Jul 2017 19:32:50 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 3 Jul
 2017 19:32:54 +0100
Date:   Mon, 3 Jul 2017 19:32:54 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/4] MIPS16e2: Identify ASE presence
Message-ID: <20170703183254.GK31455@jhogan-linux.le.imgtec.org>
References: <alpine.DEB.2.00.1705180145220.2590@tp.orcam.me.uk>
 <alpine.DEB.2.00.1705230023360.2590@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fUvfsPTz/SzOZDdw"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1705230023360.2590@tp.orcam.me.uk>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59007
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

--fUvfsPTz/SzOZDdw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2017 at 01:37:05PM +0100, Maciej W. Rozycki wrote:
> Identify the presence of the MIPS16e2 ASE as per the architecture=20
> specification[1], by checking for CP0 Config5.CA2 bit being 1[2].
>=20
> References:
>=20
> [1] "MIPS32 Architecture for Programmers: MIPS16e2 Application-Specific
>     Extension Technical Reference Manual", Imagination Technologies
>     Ltd., Document Number: MD01172, Revision 01.00, April 26, 2016,
>     Section 1.2 "Software Detection of the ASE", p. 5
>=20
> [2] "MIPS32 interAptiv Multiprocessing System Software User's Manual",
>     Imagination Technologies Ltd., Document Number: MD00904, Revision=20
>     02.01, June 15, 2016, Section 2.2.1.6 "Device Configuration 5 --=20
>     Config5 (CP0 Register 16, Select 5)", pp. 71-72
>=20
> Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> ---
>  NB the designation of the CP0 Config5.CA2 bit has not yet made it to a=
=20
> published release of the architecture specification, so the definition in=
=20
> the interAptiv MR2 core manual will have to do for the time being.
>=20
>   Maciej
>=20
> linux-mips16e2-ase-ident.diff
> Index: linux-sfr-test/arch/mips/include/asm/cpu-features.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-sfr-test.orig/arch/mips/include/asm/cpu-features.h	2017-05-22 2=
2:42:15.904852000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/cpu-features.h	2017-05-22 22:48:=
43.819622000 +0100
> @@ -138,6 +138,9 @@
>  #ifndef cpu_has_mips16
>  #define cpu_has_mips16		(cpu_data[0].ases & MIPS_ASE_MIPS16)
>  #endif
> +#ifndef cpu_has_mips16e2
> +#define cpu_has_mips16e2	(cpu_data[0].ases & MIPS_ASE_MIPS16E2)
> +#endif
>  #ifndef cpu_has_mdmx
>  #define cpu_has_mdmx		(cpu_data[0].ases & MIPS_ASE_MDMX)
>  #endif
> Index: linux-sfr-test/arch/mips/include/asm/cpu.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-sfr-test.orig/arch/mips/include/asm/cpu.h	2017-05-22 22:42:15.9=
05865000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/cpu.h	2017-05-22 22:48:43.827611=
000 +0100
> @@ -430,5 +430,6 @@ enum cpu_type_enum {
>  #define MIPS_ASE_VZ		0x00000080 /* Virtualization ASE */
>  #define MIPS_ASE_MSA		0x00000100 /* MIPS SIMD Architecture */
>  #define MIPS_ASE_DSP3		0x00000200 /* Signal Processing ASE Rev 3*/
> +#define MIPS_ASE_MIPS16E2	0x00000400 /* MIPS16e2 */
> =20
>  #endif /* _ASM_CPU_H */
> Index: linux-sfr-test/arch/mips/include/asm/mipsregs.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-sfr-test.orig/arch/mips/include/asm/mipsregs.h	2017-05-22 22:42=
:16.046860000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mipsregs.h	2017-05-22 22:48:43.7=
66613000 +0100
> @@ -652,6 +652,7 @@
>  #define MIPS_CONF5_SBRI		(_ULCAST_(1) << 6)
>  #define MIPS_CONF5_FRE		(_ULCAST_(1) << 8)
>  #define MIPS_CONF5_UFE		(_ULCAST_(1) << 9)
> +#define MIPS_CONF5_CA2		(_ULCAST_(1) << 14)
>  #define MIPS_CONF5_MSAEN	(_ULCAST_(1) << 27)
>  #define MIPS_CONF5_EVA		(_ULCAST_(1) << 28)
>  #define MIPS_CONF5_CV		(_ULCAST_(1) << 29)
> Index: linux-sfr-test/arch/mips/kernel/cpu-probe.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-sfr-test.orig/arch/mips/kernel/cpu-probe.c	2017-05-22 22:41:59.=
908735000 +0100
> +++ linux-sfr-test/arch/mips/kernel/cpu-probe.c	2017-05-22 22:48:43.79861=
1000 +0100
> @@ -861,6 +861,8 @@ static inline unsigned int decode_config
>  		c->options |=3D MIPS_CPU_MVH;
>  	if (cpu_has_mips_r6 && (config5 & MIPS_CONF5_VP))
>  		c->options |=3D MIPS_CPU_VP;
> +	if (config5 & MIPS_CONF5_CA2)
> +		c->ases |=3D MIPS_ASE_MIPS16E2;
> =20
>  	return config5 & MIPS_CONF_M;
>  }

--fUvfsPTz/SzOZDdw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllajbQACgkQbAtpk944
dnoWDA/9GkHcA7LipuhpjUjtiLFKKv8Y4QyGHVs52cFBxdP1GnWLEu241NLNkXm1
SGGwPKJC5EPuF0ET3Pj0MzlGiTCV6da57XE660fxzxzqk9r8GzYv8hHHHm7+AJON
mXSEhqQLO/D0iryN1tF6rK8m8hHEiZonPOIIRNvu3SlEDNBnFCb3QGhpdKG2UUxx
dEwEO5Xf4W39E0PWYzaXAHxc2KYtqk/CybmVidnMUPp5G5kwsV4WUHEclL1HjR2q
MRXtz9MdxwzYn/7Ssv0YDQibON7TtdJq58ocegkIdAEWnbe38AZ51KSXBUhEtyG7
UnCwRwpl6fJUrBXsiv8gbcZ7E3fK0Q/ADEK/ttmx1KDbcMfPVax5wzzm+YwFaA2z
SOmVNZNjHg07OaGxvB9Mhl1KWe/YFJg3r0QK9eD3c8wOKEOso5KBx90o0n5DxhZq
tPkG+oTthAdDwzl//bj09AczuNb/bt6IEeDn+Z4EZk7DfjD8aGfTQE8t6SNYrGld
olz2YTvpZ5Gr7t909EIfZnIz+KuHQXoqSbtPZZBOopqSofeGoMMJSXkj7POsOSRt
aooOIquRj5huUyhrp8uUZfLE/552/LUg65LJdTlTaHFzUUfv694pAgXmV4QBHPyE
DvGZP4RA+uscx3HQFAcI0lcXZfJ/7vkZfMSoZ1D2KX7yFNTACHw=
=r+8l
-----END PGP SIGNATURE-----

--fUvfsPTz/SzOZDdw--
