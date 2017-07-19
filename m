Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jul 2017 11:39:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:19134 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991061AbdGSJjZrDAu- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Jul 2017 11:39:25 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 0D62A41F8E08;
        Wed, 19 Jul 2017 11:50:20 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 19 Jul 2017 11:50:20 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 19 Jul 2017 11:50:20 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 0DCEF8F65D18A;
        Wed, 19 Jul 2017 10:39:17 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 19 Jul
 2017 10:39:20 +0100
Date:   Wed, 19 Jul 2017 10:39:19 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     "Steven J. Hill" <steven.hill@cavium.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: Octeon: Fix broken EDAC driver.
Message-ID: <20170719093919.GR31455@jhogan-linux.le.imgtec.org>
References: <1496251247-27123-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y2MHPAl/EzyWgzIZ"
Content-Disposition: inline
In-Reply-To: <1496251247-27123-1-git-send-email-steven.hill@cavium.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59143
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

--y2MHPAl/EzyWgzIZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2017 at 12:20:47PM -0500, Steven J. Hill wrote:
> From: "Steven J. Hill" <Steven.Hill@cavium.com>
>=20
> Commit 15f6847 "MIPS: Octeon: Remove unused L2C types and macros."

Please use 12 nibbles of hash and I think brackets around the subject is
common style, i.e.

Commit 15f6847923a8 ("MIPS: Octeon: Remove unused L2C types and
macros.") broke the EDAC driver...

> broke the EDAC driver. Bring back 'cvmx-l2d-defs.h' file and the
> missing types for L2C.
>=20

Lets add:
Fixes: 15f6847923a8 ("MIPS: Octeon: Remove unused L2C types and macros.")

> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>

I suppose we need this too now that 4.12 is out:
Cc: <stable@vger.kernel.org> # 4.12+

(Maybe Ralf can fix that stuff up when applying?)

The patch looks correct based on the definitions removed in the patch it
fixes, and it does indeed fix the build errors, so:

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Though this warning persists:

drivers/edac/octeon_edac-lmc.c In function =E2=80=98octeon_lmc_edac_poll_o2=
=E2=80=99:
drivers/edac/octeon_edac-lmc.c:87:24: warning: =E2=80=98((long unsigned int=
*)&int_reg)[0]=E2=80=99 may be used uninitialized in this function [-Wmaybe=
-uninitialized]
  if (int_reg.s.sec_err || int_reg.s.ded_err) {
                        ^

Thanks
James

> ---
>  arch/mips/include/asm/octeon/cvmx-l2c-defs.h | 37 ++++++++++++++++-
>  arch/mips/include/asm/octeon/cvmx-l2d-defs.h | 60 ++++++++++++++++++++++=
++++++
>  arch/mips/include/asm/octeon/cvmx.h          |  1 +
>  3 files changed, 97 insertions(+), 1 deletion(-)
>  create mode 100644 arch/mips/include/asm/octeon/cvmx-l2d-defs.h
>=20
> diff --git a/arch/mips/include/asm/octeon/cvmx-l2c-defs.h b/arch/mips/inc=
lude/asm/octeon/cvmx-l2c-defs.h
> index d045973..3ea84ac 100644
> --- a/arch/mips/include/asm/octeon/cvmx-l2c-defs.h
> +++ b/arch/mips/include/asm/octeon/cvmx-l2c-defs.h
> @@ -33,6 +33,10 @@
>  #define CVMX_L2C_DBG (CVMX_ADD_IO_SEG(0x0001180080000030ull))
>  #define CVMX_L2C_CFG (CVMX_ADD_IO_SEG(0x0001180080000000ull))
>  #define CVMX_L2C_CTL (CVMX_ADD_IO_SEG(0x0001180080800000ull))
> +#define CVMX_L2C_ERR_TDTX(block_id)					       \
> +	(CVMX_ADD_IO_SEG(0x0001180080A007E0ull) + ((block_id) & 3) * 0x40000ull)
> +#define CVMX_L2C_ERR_TTGX(block_id)					       \
> +	(CVMX_ADD_IO_SEG(0x0001180080A007E8ull) + ((block_id) & 3) * 0x40000ull)
>  #define CVMX_L2C_LCKBASE (CVMX_ADD_IO_SEG(0x0001180080000058ull))
>  #define CVMX_L2C_LCKOFF (CVMX_ADD_IO_SEG(0x0001180080000060ull))
>  #define CVMX_L2C_PFCTL (CVMX_ADD_IO_SEG(0x0001180080000090ull))
> @@ -66,9 +70,40 @@
>  		((offset) & 1) * 8)
>  #define CVMX_L2C_WPAR_PPX(offset) (CVMX_ADD_IO_SEG(0x0001180080840000ull=
)    + \
>  		((offset) & 31) * 8)
> -#define CVMX_L2D_FUS3 (CVMX_ADD_IO_SEG(0x00011800800007B8ull))
> =20
> =20
> +union cvmx_l2c_err_tdtx {
> +	uint64_t u64;
> +	struct cvmx_l2c_err_tdtx_s {
> +		__BITFIELD_FIELD(uint64_t dbe:1,
> +		__BITFIELD_FIELD(uint64_t sbe:1,
> +		__BITFIELD_FIELD(uint64_t vdbe:1,
> +		__BITFIELD_FIELD(uint64_t vsbe:1,
> +		__BITFIELD_FIELD(uint64_t syn:10,
> +		__BITFIELD_FIELD(uint64_t reserved_22_49:28,
> +		__BITFIELD_FIELD(uint64_t wayidx:18,
> +		__BITFIELD_FIELD(uint64_t reserved_2_3:2,
> +		__BITFIELD_FIELD(uint64_t type:2,
> +		;)))))))))
> +	} s;
> +};
> +
> +union cvmx_l2c_err_ttgx {
> +	uint64_t u64;
> +	struct cvmx_l2c_err_ttgx_s {
> +		__BITFIELD_FIELD(uint64_t dbe:1,
> +		__BITFIELD_FIELD(uint64_t sbe:1,
> +		__BITFIELD_FIELD(uint64_t noway:1,
> +		__BITFIELD_FIELD(uint64_t reserved_56_60:5,
> +		__BITFIELD_FIELD(uint64_t syn:6,
> +		__BITFIELD_FIELD(uint64_t reserved_22_49:28,
> +		__BITFIELD_FIELD(uint64_t wayidx:15,
> +		__BITFIELD_FIELD(uint64_t reserved_2_6:5,
> +		__BITFIELD_FIELD(uint64_t type:2,
> +		;)))))))))
> +	} s;
> +};
> +
>  union cvmx_l2c_cfg {
>  	uint64_t u64;
>  	struct cvmx_l2c_cfg_s {
> diff --git a/arch/mips/include/asm/octeon/cvmx-l2d-defs.h b/arch/mips/inc=
lude/asm/octeon/cvmx-l2d-defs.h
> new file mode 100644
> index 0000000..a951ad5
> --- /dev/null
> +++ b/arch/mips/include/asm/octeon/cvmx-l2d-defs.h
> @@ -0,0 +1,60 @@
> +/***********************license start***************
> + * Author: Cavium Networks
> + *
> + * Contact: support@caviumnetworks.com
> + * This file is part of the OCTEON SDK
> + *
> + * Copyright (c) 2003-2017 Cavium, Inc.
> + *
> + * This file is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, Version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This file is distributed in the hope that it will be useful, but
> + * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
> + * NONINFRINGEMENT.  See the GNU General Public License for more
> + * details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this file; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 =
USA
> + * or visit http://www.gnu.org/licenses/.
> + *
> + * This file may also be available under a different license from Cavium.
> + * Contact Cavium Networks for more information
> + ***********************license end*************************************=
*/
> +
> +#ifndef __CVMX_L2D_DEFS_H__
> +#define __CVMX_L2D_DEFS_H__
> +
> +#define CVMX_L2D_ERR	(CVMX_ADD_IO_SEG(0x0001180080000010ull))
> +#define CVMX_L2D_FUS3	(CVMX_ADD_IO_SEG(0x00011800800007B8ull))
> +
> +
> +union cvmx_l2d_err {
> +	uint64_t u64;
> +	struct cvmx_l2d_err_s {
> +		__BITFIELD_FIELD(uint64_t reserved_6_63:58,
> +		__BITFIELD_FIELD(uint64_t bmhclsel:1,
> +		__BITFIELD_FIELD(uint64_t ded_err:1,
> +		__BITFIELD_FIELD(uint64_t sec_err:1,
> +		__BITFIELD_FIELD(uint64_t ded_intena:1,
> +		__BITFIELD_FIELD(uint64_t sec_intena:1,
> +		__BITFIELD_FIELD(uint64_t ecc_ena:1,
> +		;)))))))
> +	} s;
> +};
> +
> +union cvmx_l2d_fus3 {
> +	uint64_t u64;
> +	struct cvmx_l2d_fus3_s {
> +		__BITFIELD_FIELD(uint64_t reserved_40_63:24,
> +		__BITFIELD_FIELD(uint64_t ema_ctl:3,
> +		__BITFIELD_FIELD(uint64_t reserved_34_36:3,
> +		__BITFIELD_FIELD(uint64_t q3fus:34,
> +		;))))
> +	} s;
> +};
> +
> +#endif
> diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/=
octeon/cvmx.h
> index 9742202..e638735 100644
> --- a/arch/mips/include/asm/octeon/cvmx.h
> +++ b/arch/mips/include/asm/octeon/cvmx.h
> @@ -62,6 +62,7 @@ enum cvmx_mips_space {
>  #include <asm/octeon/cvmx-iob-defs.h>
>  #include <asm/octeon/cvmx-ipd-defs.h>
>  #include <asm/octeon/cvmx-l2c-defs.h>
> +#include <asm/octeon/cvmx-l2d-defs.h>
>  #include <asm/octeon/cvmx-l2t-defs.h>
>  #include <asm/octeon/cvmx-led-defs.h>
>  #include <asm/octeon/cvmx-mio-defs.h>
> --=20
> 2.1.4
>=20
>=20

--y2MHPAl/EzyWgzIZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllvKMYACgkQbAtpk944
dnrvrxAAl7kMM5UqN4wR74x4BGL2yoljvDhZmvnwlLQD2WcoPhbN1i/JbHOChBvO
f/c20Yx1Gf4O9w5+Zsj3jdgDxnznhfeXGlxPDowI2H65hkuz9eiM1dVzV3QjCvvp
Lo8M48JMl2eUQu38S6J4jTPtcTM7xzl9pYpO8NZJQzYnaD8CYH5gM6dJ2h4F2ewM
8RM+lvlg9C5SCQInKPEdsfDBo7YWIdndMdi6406P55/cHz1mFsyfemW19zmoZ90e
trvhymgiEOLUxnnUCbg9q+soAUOm+v2AMuzTc5FaKsfaA4wnLD5PiTR+xPqcsus4
A5tIrmPHYZLjSEIna/e0ZNyrJKV87qnFuS3KsXjjQBFog5gxWmiSQdRp3883vUTM
d+r3EYIS2fWblpKXzxANuf5TH9pUE2vg68wisqtvi6U/pSJEe/Wo7C/VcBjJkDKZ
zXy9bOqYbwuape6jiiYYOCO9xZ5f7lg9MemhFvxORo4AHUCpG+CKsYkOVQDvMhd5
szCnwjrPi1ZLD0iOvKbBYRtkh+5d7mnBVDPhLqeOTuFPMtEpKMhtPLNMVc7gzFlO
UkYvOmEfST3yrZhbmAnZA/peNX3RhDkGTUN0ydSGeQU1sRmrhF8sTjdErt0NASSE
u13gRtNu/RWn2GPyPMbSw/j/JlowSj5s+Bbh/1LDRqrplTXKTJY=
=vP+4
-----END PGP SIGNATURE-----

--y2MHPAl/EzyWgzIZ--
