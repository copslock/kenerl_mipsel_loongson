Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 May 2016 12:56:19 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32710 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27029060AbcEYK4Qn9X7t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 May 2016 12:56:16 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 612FA41F8D9C;
        Wed, 25 May 2016 11:56:11 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 25 May 2016 11:56:11 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 25 May 2016 11:56:11 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id BF1B06778D516;
        Wed, 25 May 2016 11:56:07 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 25 May 2016 11:56:11 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Wed, 25 May
 2016 11:56:10 +0100
Date:   Wed, 25 May 2016 11:56:10 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        "Andrew Bresticker" <abrestic@chromium.org>,
        <linux-kernel@vger.kernel.org>, "Jonas Gorski" <jogo@openwrt.org>
Subject: Re: [PATCH] MIPS: Pistachio: Enable KASLR
Message-ID: <20160525105610.GP1124@jhogan-linux.le.imgtec.org>
References: <1464173387-16847-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+hZIELbchok2+JHy"
Content-Disposition: inline
In-Reply-To: <1464173387-16847-1-git-send-email-matt.redfearn@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 6e37d52
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53655
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

--+hZIELbchok2+JHy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 25, 2016 at 11:49:47AM +0100, Matt Redfearn wrote:
> Allow KASLR to be selected on Pistachio based systems. Tested on a
> Creator Ci40.
>=20
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
>=20
> ---
>=20
>  arch/mips/Kconfig          | 1 +
>  arch/mips/pistachio/init.c | 8 ++++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index c5bedce4122d..f1e59cbf5fe4 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -398,6 +398,7 @@ config MACH_PISTACHIO
>  	select SYS_SUPPORTS_MIPS_CPS
>  	select SYS_SUPPORTS_MULTITHREADING
>  	select SYS_SUPPORTS_ZBOOT
> +	select SYS_SUPPORTS_RELOCATABLE

This list is (mostly) already sorted, so probably best to add this
before SYS_SUPPORTS_ZBOOT.

Other than that,
Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

>  	select SYS_HAS_EARLY_PRINTK
>  	select USE_GENERIC_EARLY_PRINTK_8250
>  	select USE_OF
> diff --git a/arch/mips/pistachio/init.c b/arch/mips/pistachio/init.c
> index 96ba2cc9ad3e..95f8767ce52e 100644
> --- a/arch/mips/pistachio/init.c
> +++ b/arch/mips/pistachio/init.c
> @@ -52,12 +52,16 @@ static void __init plat_setup_iocoherency(void)
>  	}
>  }
> =20
> -void __init plat_mem_setup(void)
> +void __init *plat_get_fdt(void)
>  {
>  	if (fw_arg0 !=3D -2)
>  		panic("Device-tree not present");
> +	return (void *)fw_arg1;
> +}
> =20
> -	__dt_setup_arch((void *)fw_arg1);
> +void __init plat_mem_setup(void)
> +{
> +	__dt_setup_arch(plat_get_fdt());
> =20
>  	plat_setup_iocoherency();
>  }
> --=20
> 2.5.0
>=20

--+hZIELbchok2+JHy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXRYTKAAoJEGwLaZPeOHZ6BPYP/3FcGxRIUqAEbAiNHSwmuEZi
iRgL34bBef+rUk/u85BD2rIb5EHn4DMHSf5I/ZHRyNtAZbDMe62Ui2WDHj0QuXNa
HcneTK4R2J8tpX9umnzFhBXsH5Ywlm09MIq91Zpdy/G+jRMP/I55KmHnGt2JPOw5
P2is94vyfbrdGTLabT45IY8QFid+nsbPc2Mk2UXtTI5cJIyAD1Zcude+GJfwv0OE
wdw+tyBg9U48eqG7R3g6oRo+R59OOqb4lDnmbuv+m0zZM/B/Yykbrf+4AiJLmfq2
8Ljl4Qnk5qj3G+havJlWRpp34AGhHWG/+oqPwU/DQ61uEO9h+eELp5ypIUmOvP2+
oWXFieVeVoFUlWoJV3h6Ilcqq+/lWlV8vrtTEhtu8rXcHWhpc1GR/L2LSGK3aqbd
bsNRWuihDy5dKMcwyIvH+Vykjf18+EGP58nURYKYCdXXtuzlDJXmQ1xeQnyiZ69z
QNSv67Omry9Zzjtbh/U3ltPCK+oyoXd0CX7ikZhvJGJ1KlR6PGc0gKR4uyyQUOmu
oIlv/2H68ALVoHGINYVV0D8CbcTRSu6x0rliL9G6DTTQd6c5rYLY0CrpcuApkM1b
+8SEmxfYlv5h9pQs7o3OjGvrk6OAkzWaxjd2uxCGJpTM2GrrHvDBK+JM+gSjP1fF
e20bvTjuRb13aiHJqcf9
=0k2Z
-----END PGP SIGNATURE-----

--+hZIELbchok2+JHy--
