Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Nov 2017 23:53:46 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:54377 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992910AbdKGWxhpvSVC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Nov 2017 23:53:37 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 07 Nov 2017 22:53:18 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 7 Nov 2017
 14:50:54 -0800
Date:   Tue, 7 Nov 2017 22:52:16 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Mirko Parthey <mirko.parthey@web.de>
CC:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: BCM47XX: Fix LED inversion for WRT54GSv1
Message-ID: <20171107225215.GN15260@jhogan-linux>
References: <20170518193002.GA8186@guitar.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kkcDP0v44wDpNmbp"
Content-Disposition: inline
In-Reply-To: <20170518193002.GA8186@guitar.localdomain>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510095194-321459-25230-8844-2
X-BESS-VER: 2017.12-r1709122024
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186690
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
X-archive-position: 60757
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

--kkcDP0v44wDpNmbp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2017 at 09:30:03PM +0200, Mirko Parthey wrote:
> The WLAN LED on the Linksys WRT54GSv1 is active low, but the software
> treats it as active high. Fix the inverted logic.
>=20
> Signed-off-by: Mirko Parthey <mirko.parthey@web.de>

Thanks, applied for 4.15.

Cheers
James

> ---
>  arch/mips/bcm47xx/leds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/bcm47xx/leds.c b/arch/mips/bcm47xx/leds.c
> index a35f1d5cde9f..08ad23c492e7 100644
> --- a/arch/mips/bcm47xx/leds.c
> +++ b/arch/mips/bcm47xx/leds.c
> @@ -330,7 +330,7 @@ bcm47xx_leds_linksys_wrt54g3gv2[] __initconst =3D {
>  /* Verified on: WRT54GS V1.0 */
>  static const struct gpio_led
>  bcm47xx_leds_linksys_wrt54g_type_0101[] __initconst =3D {
> -	BCM47XX_GPIO_LED(0, "green", "wlan", 0, LEDS_GPIO_DEFSTATE_OFF),
> +	BCM47XX_GPIO_LED(0, "green", "wlan", 1, LEDS_GPIO_DEFSTATE_OFF),
>  	BCM47XX_GPIO_LED(1, "green", "power", 0, LEDS_GPIO_DEFSTATE_ON),
>  	BCM47XX_GPIO_LED(7, "green", "dmz", 1, LEDS_GPIO_DEFSTATE_OFF),
>  };
> --=20
> 2.1.4
>=20
>=20

--kkcDP0v44wDpNmbp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloCOR8ACgkQbAtpk944
dnrVLxAAhTN2mioVknQPnyCE7I35xOc58HbiY08rCWmwYHjyl06AfOn4jDt6VaEd
5Rvg43vK/Mo9eaLcG2vHAK/9p00NGYVVkHMm1qnUMVxPcNKFOa/xKgXbmNJqZmRY
cDn6Qq3cB5LatE+OnuWlMeeJ8HbRxeAG1ZKCW0hlv2lcsIOoF5ymEDuxF5y9Y0nl
BQa+YLnTs+wMElqWXda0bVa2NRAvHOGoM90GEqcZh2slSx+UAp/xrthirUlPpmhc
fq3BJDlvdy3sLDJ9qTrRBuMCM0o6QoAyNIG7ALDJXyktJFoEtcfhItKRrwZNM7OS
a4qgyY7+rLJweMC2T0U6UCDDhQ317aEhsOq9woIq8etMwqf9SO95P2hLuGoKjUBQ
pt9PQU3c5CNXPdDTCqCp3sejqZKWR695ADrq+64i/ISaBi0+oSP2ipkcHQ/S44yP
G6ItanFZYB80TzIKMDv4HerBSOKFUFh+YE6veFjfoeebEOlzYFhOSeiTYJzXSN67
WxHAkPedFgKR6U2Wnp9dja0y6e5xjYYFWgrJQRtlBzEEIhyZy+R3ZdAYOa7CZU79
1Q/mhIkMu8FgJThyXTPmljb7gqRgPKZrlQmmp7UHd9MkYLaFz2dQpvY3zjbF2GzN
AcNIPvIZdBf0PxJls+GBMn8YFcW7a64CTHAu5Cfvk0aOFltHoyM=
=c17P
-----END PGP SIGNATURE-----

--kkcDP0v44wDpNmbp--
