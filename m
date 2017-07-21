Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jul 2017 16:25:41 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25270 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993958AbdGUOZepThPm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Jul 2017 16:25:34 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 1A2B741F8EBE;
        Fri, 21 Jul 2017 16:36:35 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 21 Jul 2017 16:36:35 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 21 Jul 2017 16:36:35 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 63E915F944655;
        Fri, 21 Jul 2017 15:25:25 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 21 Jul
 2017 15:25:29 +0100
Date:   Fri, 21 Jul 2017 15:25:28 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
CC:     <linux-mips@linux-mips.org>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v3 04/16] MIPS: VDSO: Fix clobber lists in fallback code
 paths
Message-ID: <20170721142528.GI6973@jhogan-linux.le.imgtec.org>
References: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1500646206-2436-5-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="npqkS5PSNd2BVonv"
Content-Disposition: inline
In-Reply-To: <1500646206-2436-5-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59193
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

--npqkS5PSNd2BVonv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 04:09:02PM +0200, Aleksandar Markovic wrote:
> From: Goran Ferenc <goran.ferenc@imgtec.com>
>=20
> Extend clobber lists to include all GP registers.
>=20

Consider adding:
Fixes: 0b523a85e134 ("MIPS: VDSO: Add implementation of gettimeofday() fall=
back")

> Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> ---
>  arch/mips/vdso/gettimeofday.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/mips/vdso/gettimeofday.c b/arch/mips/vdso/gettimeofday.c
> index 974276e..e2690d7 100644
> --- a/arch/mips/vdso/gettimeofday.c
> +++ b/arch/mips/vdso/gettimeofday.c
> @@ -35,7 +35,8 @@ static __always_inline long gettimeofday_fallback(struc=
t timeval *_tv,
>  	"       syscall\n"
>  	: "=3Dr" (ret), "=3Dr" (error)
>  	: "r" (tv), "r" (tz), "r" (nr)
> -	: "memory");
> +	: "$1", "$3", "$8", "$9", "$10", "$11", "$12", "$13",
> +	  "$14", "$15", "$24", "$25", "hi", "lo", "memory");
> =20
>  	return error ? -ret : ret;
>  }
> @@ -55,7 +56,8 @@ static __always_inline long clock_gettime_fallback(cloc=
kid_t _clkid,
>  	"       syscall\n"
>  	: "=3Dr" (ret), "=3Dr" (error)
>  	: "r" (clkid), "r" (ts), "r" (nr)
> -	: "memory");
> +	: "$1", "$3", "$8", "$9", "$10", "$11", "$12", "$13",
> +	  "$14", "$15", "$24", "$25", "hi", "lo", "memory");
> =20
>  	return error ? -ret : ret;
>  }
> --=20
> 2.7.4
>=20

--npqkS5PSNd2BVonv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllyDtcACgkQbAtpk944
dnoQqA//bTTtqNCB9Yj6iq6FSFKbqHeKMheT2Whd5Kl8TC12CO/5oqDyf2ocRjPj
MuHR8pBoxkw6BCnReDzQYilR/fOJGzyeKJt+V6O+T8WFLjv7eMbkgVfsrR1vaQ1z
8m1hcpxyB4urmItr1YjYhxvyWv4SGw6KqL9L1tzbJ+IZ98mKgnj5gxziHudboAx6
2NYqv1YI+Icl6Ufl25Eb9psnT89BL4JqWSB/Ina7iPT38sXXnq5lr2KCkCkggLVR
w0/62yulIPet65OPX8+5KBw+Q5OZ56w5nzO/my+Qxcst37QnWW4/CW0D/+2d22wf
pGMAzibGWNOAZGUNjMzbIu4X4Biq6E68vA/p90kGTEHiv5zn1PYppJNFMHeEvmIl
rZi0TbW/BXAKnTiY9Ek+Q7djl2VYA6VY4A06bpEOq0Mflxpd5LC40K3fmIBWwN/D
RogbJAFtj/ooz4TTdv5qgDiDq3pnzSabJr2gSNWcJ/ZtiVY8ctfuAXZYeYV4NYjz
rVi9aJxrIKTcUCbbUVDUYRpHsv4CBjaUxRxxfkGWci9X3BPTfxCOFx1vYHSuHPNm
WQB7oerYkmbtsnUh10zwl+VqtuUqMEqpyZ/ThEe4QmW+UTmhafqjo7jrs0ruXIKi
WZWevcYUI/kVM/IwbEZ9LIye40D5B8KzYiBgkqsv19Cp9C1XVYU=
=NZL4
-----END PGP SIGNATURE-----

--npqkS5PSNd2BVonv--
