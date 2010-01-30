Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2010 19:24:00 +0100 (CET)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40211 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493019Ab0A3SX4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jan 2010 19:23:56 +0100
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
        by metis.ext.pengutronix.de with esmtp (Exim 4.69)
        (envelope-from <wsa@pengutronix.de>)
        id 1NbHz0-0001hJ-Ha; Sat, 30 Jan 2010 19:23:46 +0100
Received: from wsa by octopus.hi.pengutronix.de with local (Exim 4.69)
        (envelope-from <wsa@pengutronix.de>)
        id 1NbHyx-0001yy-GE; Sat, 30 Jan 2010 19:23:43 +0100
Date:   Sat, 30 Jan 2010 19:23:43 +0100
From:   Wolfram Sang <w.sang@pengutronix.de>
To:     Maxime Bizon <mbizon@freebox.fr>
Cc:     Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] bcm63xx_uart: allow more than one uart to be
        registered.
Message-ID: <20100130182343.GA6971@pengutronix.de>
References: <1264873377-28479-1-git-send-email-mbizon@freebox.fr> <1264873377-28479-3-git-send-email-mbizon@freebox.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <1264873377-28479-3-git-send-email-mbizon@freebox.fr>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: wsa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@linux-mips.org
X-archive-position: 25771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w.sang@pengutronix.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19498


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 30, 2010 at 06:42:57PM +0100, Maxime Bizon wrote:
> The bcm6358 CPU has two uarts, make it possible to use the second one.
>=20
> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
> ---
>  drivers/serial/bcm63xx_uart.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/serial/bcm63xx_uart.c b/drivers/serial/bcm63xx_uart.c
> index f78ede8..6ab959a 100644
> --- a/drivers/serial/bcm63xx_uart.c
> +++ b/drivers/serial/bcm63xx_uart.c
> @@ -35,7 +35,7 @@
>  #include <bcm63xx_regs.h>
>  #include <bcm63xx_io.h>
> =20
> -#define BCM63XX_NR_UARTS	1
> +#define BCM63XX_NR_UARTS	2
> =20
>  static struct uart_port ports[BCM63XX_NR_UARTS];
> =20
> @@ -784,7 +784,7 @@ static struct uart_driver bcm_uart_driver =3D {
>  	.dev_name	=3D "ttyS",
>  	.major		=3D TTY_MAJOR,
>  	.minor		=3D 64,
> -	.nr		=3D 1,
> +	.nr		=3D 2,

Err, why not using the #define here?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktkeS8ACgkQD27XaX1/VRunaACfXCtn8XYadPAc+/ykB5n5HEiY
8IcAn2qX4XsClbWCBbaYwic8kUFU/Hxt
=gEJH
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
