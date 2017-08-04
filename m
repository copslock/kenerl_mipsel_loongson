Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Aug 2017 15:43:34 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:65240 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23995074AbdHDNnAg-IOP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Aug 2017 15:43:00 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 0571783BDF665;
        Fri,  4 Aug 2017 14:27:16 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 4 Aug
 2017 14:27:19 +0100
Date:   Fri, 4 Aug 2017 14:27:19 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Yang Shi <yang.shi@windriver.com>
CC:     "david.daney@cavium.com" <david.daney@cavium.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] mips: octeon: unselect NR_CPUS_DEFAULT_16
Message-ID: <20170804132718.GY31455@jhogan-linux.le.imgtec.org>
References: <1455926968-12779-1-git-send-email-yang.shi@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lPJ5i9rX1WvdYcWF"
Content-Disposition: inline
In-Reply-To: <1455926968-12779-1-git-send-email-yang.shi@windriver.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59360
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

--lPJ5i9rX1WvdYcWF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 20, 2016 at 12:09:28AM +0000, Yang Shi wrote:
> In the octeon defconfig, NR_CPUS is 32. And, some model of OCTEON II do h=
ave
> > 16 cores. Given the typical memory size equipped by Octeon boards, it s=
ounds
> like not a big deal to set a bigger NR_CPUS value as default.
>=20
> Signed-off-by: Yang Shi <yang.shi@windriver.com>
> ---
>  arch/mips/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index ab433d3..a885156 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -885,7 +885,6 @@ config CAVIUM_OCTEON_SOC
>         select USE_OF
>         select ARCH_SPARSEMEM_ENABLE
>         select SYS_SUPPORTS_SMP
> -       select NR_CPUS_DEFAULT_16

So should this select NR_CPUS_DEFAULT_32 instead?

Cheers
James

>         select BUILTIN_DTB
>         select MTD_COMPLEX_MAPPINGS
>         help
> --
> 2.0.2
>=20
>=20

--lPJ5i9rX1WvdYcWF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlmEdjUACgkQbAtpk944
dnow2w//StwWOnNHJNbF62DPjGIqVOBDYFdEr1y3AA0fzZOGaI1C1DFESQ9RSoVa
WtSPGtNd1A/bqKO2SE3ffavCFcCos6HUBcOdPPG2cgwVeDT/GkqmXQ+ArAe2h6JC
wz/KLS41Mgo2HV+1/YwkhTBIOQwJbcHLe1EHl6LhbDMrTZA/eWgP49X2/v4llEak
2V+bUYyeMKz4mACU2SLgZSterHoM25rQdMyL0f6YVT+DLmmiVf6RtyLWN1HDZf5U
wxCpylN/YziY6ptXgjl5540Fm4zly++h41Rk/I6aexzBuEQ8/Pi+43pKJ+7WpICI
r4GztUFuD3BWi7sS98fTty+HPle/Ixzwxn9vTO1wApBgjRUf0E8lB7XylRw/wtNn
tBzGGmVKnMx6A5k7zNagRYq/etQMFtnZnRmjiSL8BvWIjZXrXsRn18kAmK5YWEkO
yiN3hl/+cuNUEGzkpWI8/Vj+4WsiMQm7asKYn9mYWnPyOt6pOrimCyMTB4+pLj5i
n+2SpaH2HcrYOcQr9eOpMpOxJAcgyDIDmUA1yrUbUsuSDakC49U3Yrhz9U9Bi26u
11+f11uECmAXucRagWNKiMZAuOZvsqrvqjj0nyGjo+ALdsO/ireTLF921N+bwtJK
3275NP3hyKmQUi8ti/1rdyqoN3Uiom1gA4+bIvVGZgaVArmveps=
=TCQH
-----END PGP SIGNATURE-----

--lPJ5i9rX1WvdYcWF--
