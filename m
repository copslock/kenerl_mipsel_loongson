Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2016 18:34:26 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57278 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992232AbcJQQeSvDkrz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Oct 2016 18:34:18 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 16ADC41F8DD8;
        Mon, 17 Oct 2016 17:33:49 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.44.0.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 17 Oct 2016 17:33:49 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 17 Oct 2016 17:33:49 +0100
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 56E55D4FE918A;
        Mon, 17 Oct 2016 17:34:09 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 17 Oct 2016
 17:34:13 +0100
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 17 Oct
 2016 17:34:12 +0100
Date:   Mon, 17 Oct 2016 17:34:12 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: Use generic asm/unaligned.h
Message-ID: <20161017163412.GC9443@jhogan-linux.le.imgtec.org>
References: <20161017145621.21415-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Content-Disposition: inline
In-Reply-To: <20161017145621.21415-1-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1cc78754
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55465
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

--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 17, 2016 at 03:56:21PM +0100, Paul Burton wrote:
> The MIPS-specific asm/unaligned.h provides nothing that the generic
> version doesn't - it simply uses MIPS-specific endianness macros in
> place of generic ones & lacks support for
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS. Remove it & switch to using the
> generic version to remove duplication.
>=20
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: linux-mips@linux-mips.org
> Cc: Ralf Baechle <ralf@linux-mips.org>

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> ---
>=20
>  arch/mips/include/asm/Kbuild      |  1 +
>  arch/mips/include/asm/unaligned.h | 28 ----------------------------
>  2 files changed, 1 insertion(+), 28 deletions(-)
>  delete mode 100644 arch/mips/include/asm/unaligned.h
>=20
> diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
> index 9740066..96b5be5 100644
> --- a/arch/mips/include/asm/Kbuild
> +++ b/arch/mips/include/asm/Kbuild
> @@ -17,6 +17,7 @@ generic-y +=3D sections.h
>  generic-y +=3D segment.h
>  generic-y +=3D serial.h
>  generic-y +=3D trace_clock.h
> +generic-y +=3D unaligned.h
>  generic-y +=3D user.h
>  generic-y +=3D word-at-a-time.h
>  generic-y +=3D xor.h
> diff --git a/arch/mips/include/asm/unaligned.h b/arch/mips/include/asm/un=
aligned.h
> deleted file mode 100644
> index 42f66c3..0000000
> --- a/arch/mips/include/asm/unaligned.h
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -/*
> - * This file is subject to the terms and conditions of the GNU General P=
ublic
> - * License.  See the file "COPYING" in the main directory of this archive
> - * for more details.
> - *
> - * Copyright (C) 2007 Ralf Baechle (ralf@linux-mips.org)
> - */
> -#ifndef _ASM_MIPS_UNALIGNED_H
> -#define _ASM_MIPS_UNALIGNED_H
> -
> -#include <linux/compiler.h>
> -#if defined(__MIPSEB__)
> -# include <linux/unaligned/be_struct.h>
> -# include <linux/unaligned/le_byteshift.h>
> -# define get_unaligned	__get_unaligned_be
> -# define put_unaligned	__put_unaligned_be
> -#elif defined(__MIPSEL__)
> -# include <linux/unaligned/le_struct.h>
> -# include <linux/unaligned/be_byteshift.h>
> -# define get_unaligned	__get_unaligned_le
> -# define put_unaligned	__put_unaligned_le
> -#else
> -#  error "MIPS, but neither __MIPSEB__, nor __MIPSEL__???"
> -#endif
> -
> -# include <linux/unaligned/generic.h>
> -
> -#endif /* _ASM_MIPS_UNALIGNED_H */
> --=20
> 2.10.0
>=20
>=20

--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYBP15AAoJEGwLaZPeOHZ6BsQP/ipq8YX0Mee5bIpFI4wUVNVR
Kj3QRPJgxCKQUKvf3zm7mzLD2xeBXSlJ85fEFYRukKLAFvVhUyh2JSuVTMqkmi3v
MfilggFSV7xCHQWI05Av5AZyALUwEMtbwFoEQOl963eWd3/PQwaOx3z8bJQR8x9y
vJjUZ8xOGG3BHLAr8N3tvb56X44XMunFq62d31IJbBKRQJbWs0Ji0Cba6Gijetfi
tlKxWuu8Ty5Xn4fG+UcgJQjD6EWbKXc4UUajVIpdDqde4ViG2v+lq9KR6Vpsl/ZZ
p+Xxg34z840PkV+B6CPrTygYB822vgGEq5xCDOKg9fgE+pSI8XcpQ1N9bLNZ3X2H
ySm/nz1SieMswsXKdHeDBu1G2ToCFYEsD0M3Lop7yZgIpCOgw/CDitqckHKOQOMC
JhF9S6waQ9jTyweCNx+vDJ+DFnRE/IyV0jZ++/b0aX/RQligF4YrIKw1/dyZfyIA
E7L3B37pWe61IBRQw6weT0Id6oklh+MRLMtXQNx2NeEKN+KfvbqCFMiihSMfbTl+
SMCcLP2+CrRR3LF808qQyrrcVWkJ2aoagqvQyu+15pOz11cyvW0NkSxO0vjqGQ/6
QWXpFs7huaxAgluwTwANHiJ3AqOxEgrNgYZ66NJBY8Q7LoJ0ko9cWlKGYqfyZZR7
wrt3Ues2P/YPA2t+YlGf
=8zN7
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
