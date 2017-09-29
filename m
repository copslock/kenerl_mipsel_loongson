Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Sep 2017 23:36:05 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17377 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992625AbdI2Vf5iJmnB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Sep 2017 23:35:57 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 83959960F7F45;
        Fri, 29 Sep 2017 22:35:44 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 29 Sep
 2017 22:35:48 +0100
Date:   Fri, 29 Sep 2017 22:35:48 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
CC:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/2] MIPS: add crc instruction support flag to elf_hwcap
Message-ID: <20170929213548.GC24591@jhogan-linux.le.imgtec.org>
References: <1506514716-29470-1-git-send-email-marcin.nowakowski@imgtec.com>
 <1506514716-29470-2-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zbGR4y+acU1DwHSi"
Content-Disposition: inline
In-Reply-To: <1506514716-29470-2-git-send-email-marcin.nowakowski@imgtec.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60205
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

--zbGR4y+acU1DwHSi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2017 at 02:18:35PM +0200, Marcin Nowakowski wrote:
> Indicate that CRC32 and CRC32C instuctions are supported by the CPU
> through elf_hwcap flags.
>=20
> This will be used by a follow-up commit that introduces crc32(c) crypto
> acceleration modules and is required by GENERIC_CPU_AUTOPROBE feature.
>=20
> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>

Looks good to me,
Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> ---
>  arch/mips/include/asm/mipsregs.h   | 1 +
>  arch/mips/include/uapi/asm/hwcap.h | 1 +
>  arch/mips/kernel/cpu-probe.c       | 3 +++
>  3 files changed, 5 insertions(+)
>=20
> diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mip=
sregs.h
> index a681092..9db53cc 100644
> --- a/arch/mips/include/asm/mipsregs.h
> +++ b/arch/mips/include/asm/mipsregs.h
> @@ -664,6 +664,7 @@
>  #define MIPS_CONF5_FRE		(_ULCAST_(1) << 8)
>  #define MIPS_CONF5_UFE		(_ULCAST_(1) << 9)
>  #define MIPS_CONF5_CA2		(_ULCAST_(1) << 14)
> +#define MIPS_CONF5_CRCP		(_ULCAST_(1) << 18)
>  #define MIPS_CONF5_MSAEN	(_ULCAST_(1) << 27)
>  #define MIPS_CONF5_EVA		(_ULCAST_(1) << 28)
>  #define MIPS_CONF5_CV		(_ULCAST_(1) << 29)
> diff --git a/arch/mips/include/uapi/asm/hwcap.h b/arch/mips/include/uapi/=
asm/hwcap.h
> index c7484a7..c7d2cb6 100644
> --- a/arch/mips/include/uapi/asm/hwcap.h
> +++ b/arch/mips/include/uapi/asm/hwcap.h
> @@ -4,5 +4,6 @@
>  /* HWCAP flags */
>  #define HWCAP_MIPS_R6		(1 << 0)
>  #define HWCAP_MIPS_MSA		(1 << 1)
> +#define HWCAP_MIPS_CRC32	(1 << 2)
> =20
>  #endif /* _UAPI_ASM_HWCAP_H */
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index cf3fd54..6b07b73 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -848,6 +848,9 @@ static inline unsigned int decode_config5(struct cpui=
nfo_mips *c)
>  	if (config5 & MIPS_CONF5_CA2)
>  		c->ases |=3D MIPS_ASE_MIPS16E2;
> =20
> +	if (config5 & MIPS_CONF5_CRCP)
> +		elf_hwcap |=3D HWCAP_MIPS_CRC32;
> +
>  	return config5 & MIPS_CONF_M;
>  }
> =20
> --=20
> 2.7.4
>=20
>=20

--zbGR4y+acU1DwHSi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlnOvLQACgkQbAtpk944
dnrytBAAmsDFGL4tuIuK3lITwr70MVHEB5f0plHe1M/uucJAmRaMOVp1MQoRbwsD
O0PoJME3wOwrAtAP9fsgMhG7X9WHVeGbjqgGHbiD1nz+/7klw9OM97mt4RfSVR5p
8+Zjmcq1jwG5NyjqtM1dBw7OksRPpIxdn8vePKu8swULzx4b8ZVqVO1KmXKpr1EX
1d7jPnfKuHF5uYakqOGwO6gD14bbUv/xWJM6Fyvag+wZ0qC9W9ojRdO3pqWxtUeo
F9lSTVomdhuXTy+olJiyZJPEtElXWthXnsxxgnZPavom1/PTtixOeKN1PStU9cZD
HhFEDkuDnsQKIoo7ZX8rcXyjFlbND5nkduRrcopFQLpUvQh7cxnUK6IJ3Up2j7G9
wWljPWJF1HKjpY7I2ZFkDi3SE3dkjHZH0G4iCOsjLXXB/7fQ+sbtAD59NfMJPCF2
b9WM+wrjS4rCCRzGGPc/+KGZzHhqhM1fa6jrmtLMgti9oKQAYf6SvAkouP7qzCic
LCfzj8gfX/ttwbGZ+MtZ494X0PDASxmKYi0Nygc8v5EIoL81ON0l5m0ert9Xc5sA
EfpgyhjIOHT14Qfa9F3zV+laNmQ9YPbt+8ZlpGRPeo481w5iIUml7ba+AIJucrAG
sXKpcU0NUk9VasUzL7HK/VL8esYxM8g5B+HIE9+mrpJynKZB+lM=
=kJR7
-----END PGP SIGNATURE-----

--zbGR4y+acU1DwHSi--
