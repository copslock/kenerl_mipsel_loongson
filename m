Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jun 2017 22:31:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:5871 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993942AbdF0UbiEfKog (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Jun 2017 22:31:38 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id BA87241F8E1D;
        Tue, 27 Jun 2017 22:41:33 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 27 Jun 2017 22:41:33 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 27 Jun 2017 22:41:33 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 70A4E369E1899;
        Tue, 27 Jun 2017 21:31:28 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 27 Jun
 2017 21:31:32 +0100
Date:   Tue, 27 Jun 2017 21:31:31 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Karl Beldan <karl.beldan@gmail.com>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Karl Beldan <karl.beldan+oss@gmail.com>,
        <stable@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Jonas Gorski <jogo@openwrt.org>
Subject: Re: [RESEND PATCH] MIPS: head: Reorder instructions missing a delay
 slot
Message-ID: <20170627203131.GH31455@jhogan-linux.le.imgtec.org>
References: <20170627192216.29364-1-karl.beldan+oss@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qM81t570OJUP5TU/"
Content-Disposition: inline
In-Reply-To: <20170627192216.29364-1-karl.beldan+oss@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58834
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

--qM81t570OJUP5TU/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2017 at 07:22:16PM +0000, Karl Beldan wrote:
> In this sequence the 'move' is assumed in the delay slot of the 'beq',
> but head.S is in reorder mode and the former gets pushed one 'nop'
> farther by the assembler.
>=20
> The corrected behavior made booting with an UHI supplied dtb erratic.
>=20
> Fixes: 15f37e158892 ("MIPS: store the appended dtb address in a variable")
> Cc: <stable@vger.kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Jonas Gorski <jogo@openwrt.org>
> Signed-off-by: Karl Beldan <karl.beldan+oss@gmail.com>

Ouch, nice catch.

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> ---
>  arch/mips/kernel/head.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
> index cf05220..d1bb506 100644
> --- a/arch/mips/kernel/head.S
> +++ b/arch/mips/kernel/head.S
> @@ -106,8 +106,8 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
>  	beq		t0, t1, dtb_found
>  #endif
>  	li		t1, -2
> -	beq		a0, t1, dtb_found
>  	move		t2, a1
> +	beq		a0, t1, dtb_found
> =20
>  	li		t2, 0
>  dtb_found:
> --=20
> 2.10.1
>=20
>=20

--qM81t570OJUP5TU/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllSwJgACgkQbAtpk944
dnp1DQ/+IEdOAz26vchVYYc5yqErxCK4ArA/5eZ+gcCbm0HkUrg1nSU28KKPI6Lu
w8UcdNCi5EoeST4aN6/BySKGPubdq20aJLxzKRr6e+m8+/w7i/8zYuHCmpwcNxMe
YpiuUsddUfaahwXfpI1Icwo+HQfyLXEUcglMwojVXT8tktnEWZaUWQQ+JeiQxwsR
OHFWMHBF7rHrxzIuK9+rI33Eb83UnbBzCuR+NzrAZBMP8htiaN90JCk+dIDDmvsv
bEQSZO5E+YKwvwmt5JA/CuSHJPJ7TaCZgROmQ8I/vmjWJa1xk+qPcFHBEredz4Fc
8QqV+zZY2KcMswtf4nZUhHUznfGAKHw63EnfQm0GpnOBuOTo8U9bE8Z7moUKlk7K
D781bn0kvvYsBIxHeIe4JsNOrqPjfmS/A0PKgVaeLEByUZNdGTrzznk7sEa0LyXV
3ccTPztZlbvgGn2CSNjW9d/KENOqjtcFu3fTWTzh7udVN+VLd4SbeuNtT/LhM3RS
Va3fQJtMxuz2YGTWlqUTIHXn7DH5+ArbgAaEigx6vDjRa0u7Q7ac47Zrs2uKKdhv
Hp5oKJDxA2sXRrJpEdnHpn1QkauI6M6rA3V8NfB40JRKtIxPen3zVui+YDrfjwZy
VuUGtCX1DuMPVa0zKBjIfqMKOubgjH6UT44g6DBH8yGVL034beU=
=TLTq
-----END PGP SIGNATURE-----

--qM81t570OJUP5TU/--
