Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 23:37:31 +0200 (CEST)
Received: from sauhun.de ([88.99.104.3]:50578 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992670AbeENVhVM01Cv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2018 23:37:21 +0200
Received: from localhost (p54B3354D.dip0.t-ipconnect.de [84.179.53.77])
        by pokefinder.org (Postfix) with ESMTPSA id 667003640A8;
        Mon, 14 May 2018 23:37:20 +0200 (CEST)
Date:   Mon, 14 May 2018 23:37:20 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-i2c@vger.kernel.org
Cc:     Greg Ungerer <gerg@uclinux.org>,
        Russell King <linux@armlinux.org.uk>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-mips@linux-mips.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 1/7] i2c: i2c-gpio: move header to platform_data
Message-ID: <20180514213719.o6ceftp2quem3s7f@ninjato>
References: <20180419200015.15095-1-wsa@the-dreams.de>
 <20180419200015.15095-2-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tcoidkrh63ciwaqm"
Content-Disposition: inline
In-Reply-To: <20180419200015.15095-2-wsa@the-dreams.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wsa@the-dreams.de
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


--tcoidkrh63ciwaqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


>  arch/arm/mach-ks8695/board-acs5k.c               | 2 +-
>  arch/arm/mach-sa1100/simpad.c                    | 2 +-
>  arch/mips/alchemy/board-gpr.c                    | 2 +-

Those still need acks...

> diff --git a/arch/arm/mach-ks8695/board-acs5k.c b/arch/arm/mach-ks8695/bo=
ard-acs5k.c
> index 937eb1d47e7b..ef835d82cdb9 100644
> --- a/arch/arm/mach-ks8695/board-acs5k.c
> +++ b/arch/arm/mach-ks8695/board-acs5k.c
> @@ -19,7 +19,7 @@
>  #include <linux/gpio/machine.h>
>  #include <linux/i2c.h>
>  #include <linux/i2c-algo-bit.h>
> -#include <linux/i2c-gpio.h>
> +#include <linux/platform_data/i2c-gpio.h>
>  #include <linux/platform_data/pca953x.h>
> =20
>  #include <linux/mtd/mtd.h>

=2E..

> diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
> index ace010479eb6..49a61e6f3c5f 100644
> --- a/arch/arm/mach-sa1100/simpad.c
> +++ b/arch/arm/mach-sa1100/simpad.c
> @@ -37,7 +37,7 @@
>  #include <linux/input.h>
>  #include <linux/gpio_keys.h>
>  #include <linux/leds.h>
> -#include <linux/i2c-gpio.h>
> +#include <linux/platform_data/i2c-gpio.h>
> =20
>  #include "generic.h"
> =20
> diff --git a/arch/mips/alchemy/board-gpr.c b/arch/mips/alchemy/board-gpr.c
> index 4e79dbd54a33..fa75d75b5ba9 100644
> --- a/arch/mips/alchemy/board-gpr.c
> +++ b/arch/mips/alchemy/board-gpr.c
> @@ -29,7 +29,7 @@
>  #include <linux/leds.h>
>  #include <linux/gpio.h>
>  #include <linux/i2c.h>
> -#include <linux/i2c-gpio.h>
> +#include <linux/platform_data/i2c-gpio.h>
>  #include <linux/gpio/machine.h>
>  #include <asm/bootinfo.h>
>  #include <asm/idle.h>

=2E.. and this was the shortened diff for those.

Greg, Russell, Ralf, James? Is it okay if I take this via my tree?

Thanks,

   Wolfram


--tcoidkrh63ciwaqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlr6AYsACgkQFA3kzBSg
KbbazA//bpr6/qUgGIXnVTTVquilOsWl6XIWFNDxE7TweCbHbjHsf72+og1lNDGd
oqyZuuuBrNg749CO9e9mvgkefDr7q80j84bzRwj0uvmULtAB/kvHV67kepBmmqJ0
xrmTOquVT4owzbiE46lJWPMp5x1K1JII7/lsWk9Ftlq2SzZX0Z/64y9MCcod23Iq
7JaAraqsGRQAu39/DqO+oQugPqX2zPnp1BSXDIM5UUJUXBKjzdpS9JpUUJTqiVM0
9hBcYxd8aE4SQrhkiVArvELgO1gvERL13q6LNe185j+9c8Jo5ACR9mSCGi+oRzPC
4ZAtlWjluD7nXr6ZnaAd7IEg2LVnO9SSDuztnMGXN8c3taV+jb6EnhGmubuGn6yM
sug3NzFRT29jvyn3jLwZjZfJDQtuTlQz6+VtsrrIRNyrEohgWAd/ZrJJr91tV0DK
31DCDEYWZ4t0b9ZSty+EQ2LrBrxZoZo0cQ+jW1/2SI6dJbB3zLNSMyTKx56AjYR/
NGqPw5sIkpoylOkVKUOvz9VTsidTroNE49/jMzkUIaepIrO8Zh5sqSRo8W2TEuGJ
VwU/QYzKhGrOtHd5n9nXYqikcRjet+rFGSwtQQCpOKRuu7lcZZ5l6965wBGHEocu
XVJlX0I6t956kRNIEdgrAVWT1PbAHcm4ztc4NMby6j8DiozPSbw=
=rmj3
-----END PGP SIGNATURE-----

--tcoidkrh63ciwaqm--
