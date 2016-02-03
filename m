Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 15:12:35 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7782 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011683AbcBCOMcApGuO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 15:12:32 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 757B441F8DC8;
        Wed,  3 Feb 2016 14:12:26 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 03 Feb 2016 14:12:26 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 03 Feb 2016 14:12:26 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 1387580F2CD5C;
        Wed,  3 Feb 2016 14:12:24 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 14:12:26 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 14:12:25 +0000
Date:   Wed, 3 Feb 2016 14:12:25 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        "Miguel Ojeda Sandonis" <miguel.ojeda.sandonis@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Jiri Slaby <jslaby@suse.com>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 02/15] auxdisplay: driver for simple memory mapped
 ASCII LCD displays
Message-ID: <20160203141225.GF5464@jhogan-linux.le.imgtec.org>
References: <1454499045-5020-1-git-send-email-paul.burton@imgtec.com>
 <1454499045-5020-3-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GV0iVqYguTV4Q9ER"
Content-Disposition: inline
In-Reply-To: <1454499045-5020-3-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 56f439c
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51691
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

--GV0iVqYguTV4Q9ER
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 03, 2016 at 11:30:32AM +0000, Paul Burton wrote:
> Add a driver for simple memory mapped ASCII LCD displays such as those
> found on the MIPS Malta & Boston development boards. The driver displays
> the Linux kernel version as the default message, but allows the message
> to be changed via a character device. Messages longer then the number of
> characters that the display can show will scroll.
>=20
> This provides different behaviour to the existing LCD display code for
> the MIPS Malta platform in the following ways:
>=20
>   - The default string to display is not "LINUX ON MALTA" but "Linux"
>     followed by the version number of the kernel (UTS_RELEASE).
>=20
>   - Since that string tends to significantly longer it scrolls twice
>     as fast, moving every 500ms rather than every 1s.
>=20
>   - The LCD won't be updated until the driver is probed, so it doesn't
>     provide the early "LINUX" string.
>=20
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>=20
> Changes in v2: None
>=20
>  MAINTAINERS                    |   1 +
>  drivers/auxdisplay/Kconfig     |   7 ++
>  drivers/auxdisplay/Makefile    |   1 +
>  drivers/auxdisplay/ascii-lcd.c | 230 +++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 239 insertions(+)
>  create mode 100644 drivers/auxdisplay/ascii-lcd.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cd19e5f..301bc429 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1823,6 +1823,7 @@ ASCII LCD DRIVER
>  M:	Paul Burton <paul.burton@imgtec.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/ascii-lcd.txt
> +F:	drivers/auxdisplay/ascii-lcd.c
> =20
>  ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
>  M:	Corentin Chary <corentin.chary@gmail.com>
> diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
> index c07e725..a465e0d 100644
> --- a/drivers/auxdisplay/Kconfig
> +++ b/drivers/auxdisplay/Kconfig
> @@ -119,4 +119,11 @@ config CFAG12864B_RATE
>  	  If you compile this as a module, you can still override this
>  	  value using the module parameters.
> =20
> +config ASCII_LCD
> +	tristate "ASCII LCD Display"
> +	default y if MIPS_MALTA
> +	help
> +	  Enable this to support simple memory mapped ASCII LCD displays such
> +	  as those found on the MIPS Malta & Boston development boards.
> +
>  endif # AUXDISPLAY
> diff --git a/drivers/auxdisplay/Makefile b/drivers/auxdisplay/Makefile
> index 8a8936a..8a5aa81 100644
> --- a/drivers/auxdisplay/Makefile
> +++ b/drivers/auxdisplay/Makefile
> @@ -4,3 +4,4 @@
> =20
>  obj-$(CONFIG_KS0108)		+=3D ks0108.o
>  obj-$(CONFIG_CFAG12864B)	+=3D cfag12864b.o cfag12864bfb.o
> +obj-$(CONFIG_ASCII_LCD)		+=3D ascii-lcd.o
> diff --git a/drivers/auxdisplay/ascii-lcd.c b/drivers/auxdisplay/ascii-lc=
d.c
> new file mode 100644
> index 0000000..5c9ec32
> --- /dev/null
> +++ b/drivers/auxdisplay/ascii-lcd.c
> @@ -0,0 +1,230 @@
> +/*
> + * Copyright (C) 2015 Imagination Technologies
> + * Author: Paul Burton <paul.burton@imgtec.com>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or (at your
> + * option) any later version.
> + */
> +
> +#include <generated/utsrelease.h>
> +#include <linux/kernel.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +
> +struct ascii_lcd_ctx;
> +
> +struct ascii_lcd_config {
> +	unsigned num_chars;
> +	void (*update)(struct ascii_lcd_ctx *ctx);
> +};
> +
> +struct ascii_lcd_ctx {
> +	struct platform_device *pdev;
> +	void __iomem *base;
> +	const struct ascii_lcd_config *cfg;
> +	char *message;
> +	unsigned message_len;
> +	unsigned scroll_pos;
> +	unsigned scroll_rate;
> +	struct timer_list timer;
> +	char curr[] __aligned(8);
> +};
> +
> +static void update_boston(struct ascii_lcd_ctx *ctx)
> +{
> +	u32 val32;
> +	u64 val64;
> +
> +	if (config_enabled(CONFIG_64BIT)) {
> +		val64 =3D *((u64 *)&ctx->curr[0]);
> +		__raw_writeq(val64, ctx->base);
> +	} else {
> +		val32 =3D *((u32 *)&ctx->curr[0]);
> +		__raw_writel(val32, ctx->base);
> +		val32 =3D *((u32 *)&ctx->curr[4]);
> +		__raw_writel(val32, ctx->base + 4);
> +	}
> +}
> +
> +static void update_malta(struct ascii_lcd_ctx *ctx)
> +{
> +	unsigned i;
> +
> +	for (i =3D 0; i < ctx->cfg->num_chars; i++)
> +		__raw_writel(ctx->curr[i], ctx->base + (i * 8));
> +}
> +
> +static struct ascii_lcd_config boston_config =3D {
> +	.num_chars =3D 8,
> +	.update =3D update_boston,
> +};
> +
> +static struct ascii_lcd_config malta_config =3D {
> +	.num_chars =3D 8,
> +	.update =3D update_malta,
> +};
> +
> +static const struct of_device_id ascii_lcd_matches[] =3D {
> +	{ .compatible =3D "img,boston-lcd", .data =3D &boston_config },
> +	{ .compatible =3D "mti,malta-lcd", .data =3D &malta_config },
> +};

MODULE_DEVICE_TABLE?

> +
> +static void ascii_lcd_scroll(unsigned long arg)
> +{
> +	struct ascii_lcd_ctx *ctx =3D (struct ascii_lcd_ctx *)arg;
> +	unsigned i, ch =3D ctx->scroll_pos;
> +	unsigned num_chars =3D ctx->cfg->num_chars;
> +
> +	/* update the current message string */
> +	for (i =3D 0; i < num_chars;) {
> +		/* copy as many characters from the string as possible */
> +		for (; i < num_chars && ch < ctx->message_len; i++, ch++)
> +			ctx->curr[i] =3D ctx->message[ch];
> +
> +		/* wrap around to the start of the string */
> +		ch =3D 0;
> +	}

should this pad ctx->curr wth spaces for the case where
ctx->message_len <=3D ctx->cfg->num_chars?

> +
> +	/* update the LCD */
> +	ctx->cfg->update(ctx);
> +
> +	/* move on to the next character */
> +	ctx->scroll_pos++;
> +	ctx->scroll_pos %=3D ctx->message_len;
> +
> +	/* rearm the timer */
> +	if (ctx->message_len > ctx->cfg->num_chars)
> +		mod_timer(&ctx->timer, jiffies + ctx->scroll_rate);
> +}
> +
> +static int ascii_lcd_display(struct ascii_lcd_ctx *ctx,
> +			     const char *msg, ssize_t count)
> +{
> +	char *new_msg;
> +
> +	/* stop the scroll timer */
> +	del_timer_sync(&ctx->timer);
> +
> +	if (count =3D=3D -1)
> +		count =3D strlen(msg);
> +
> +	/* if the string ends with a newline, trim it */
> +	if (msg[count - 1] =3D=3D '\n')
> +		count--;
> +
> +	new_msg =3D devm_kmalloc(&ctx->pdev->dev, count + 1, GFP_KERNEL);
> +	if (!new_msg)
> +		return -ENOMEM;
> +
> +	memcpy(new_msg, msg, count);
> +	new_msg[count] =3D 0;

'\0' probably shows the intent more clearly.

> +
> +	if (ctx->message)
> +		devm_kfree(&ctx->pdev->dev, ctx->message);
> +
> +	ctx->message =3D new_msg;
> +	ctx->message_len =3D count;
> +	ctx->scroll_pos =3D 0;

Does this need locking to prevent concurrent writes from racing and
leaking memory?

> +
> +	/* update the LCD */
> +	ascii_lcd_scroll((unsigned long)ctx);
> +
> +	return 0;
> +}
> +
> +static ssize_t message_show(struct device *dev, struct device_attribute =
*attr,
> +			    char *buf)
> +{
> +	struct ascii_lcd_ctx *ctx =3D dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%s\n", ctx->message);
> +}
> +
> +static ssize_t message_store(struct device *dev, struct device_attribute=
 *attr,
> +			     const char *buf, size_t count)
> +{
> +	struct ascii_lcd_ctx *ctx =3D dev_get_drvdata(dev);
> +	int err;
> +
> +	err =3D ascii_lcd_display(ctx, buf, count);
> +	return err ?: count;
> +}
> +
> +static DEVICE_ATTR_RW(message);
> +
> +static int ascii_lcd_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *match;
> +	const struct ascii_lcd_config *cfg;
> +	struct ascii_lcd_ctx *ctx;
> +	struct resource *res;
> +	int err;
> +
> +	match =3D of_match_device(ascii_lcd_matches, &pdev->dev);
> +	if (!match)
> +		return -ENODEV;
> +
> +	cfg =3D match->data;
> +	ctx =3D devm_kzalloc(&pdev->dev, sizeof(*ctx) + cfg->num_chars,
> +			   GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	ctx->base =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(ctx->base))
> +		return PTR_ERR(ctx->base);
> +
> +	ctx->pdev =3D pdev;
> +	ctx->cfg =3D cfg;
> +	ctx->message =3D NULL;
> +	ctx->scroll_pos =3D 0;
> +	ctx->scroll_rate =3D HZ / 2;
> +
> +	/* initialise a timer for scrolling the message */
> +	init_timer(&ctx->timer);
> +	ctx->timer.function =3D ascii_lcd_scroll;
> +	ctx->timer.data =3D (unsigned long)ctx;
> +
> +	platform_set_drvdata(pdev, ctx);
> +
> +	/* display a default message */
> +	err =3D ascii_lcd_display(ctx, "Linux " UTS_RELEASE "       ", -1);

should the number of spaces depend on the length of the display?

> +	if (err)
> +		goto out_del_timer;

the only error case in ascii_led_display seems to be failure to
allocate, at which point timer won't have been started yet, so you could
just return err here. Any future error case added after starting timer
should probably be handled by ascii_lcd_display() anyway.

> +
> +	err =3D device_create_file(&pdev->dev, &dev_attr_message);
> +	if (err)
> +		goto out_del_timer;
> +
> +	return 0;
> +out_del_timer:
> +	del_timer_sync(&ctx->timer);
> +	return err;
> +}
> +
> +static int ascii_lcd_remove(struct platform_device *pdev)
> +{
> +	struct ascii_lcd_ctx *ctx =3D platform_get_drvdata(pdev);
> +
> +	device_remove_file(&pdev->dev, &dev_attr_message);
> +	del_timer_sync(&ctx->timer);
> +	return 0;
> +}
> +
> +static struct platform_driver ascii_lcd_driver =3D {
> +	.driver =3D {
> +		.name		=3D "ascii-lcd",
> +		.of_match_table	=3D ascii_lcd_matches,
> +	},
> +	.probe	=3D ascii_lcd_probe,
> +	.remove	=3D ascii_lcd_remove,
> +};
> +module_platform_driver(ascii_lcd_driver);

Should you have MODULE_AUTHOR/DESCRIPTION/LICENSE and friends in here
too for when built as a module?

Cheers
James

> --=20
> 2.7.0
>=20
>=20

--GV0iVqYguTV4Q9ER
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWsgrJAAoJEGwLaZPeOHZ6je4P/0ROyvzzNTuozCnyevRzy7pR
jBI/w+eGhA2tlL35lqsMgTABrZzEgAo9F/CjpTFOC8hyUr1RBSg1qQ/01SFlS4ZX
1JGMEW3RvjvtIkPT+kZt5F90E5vcEywLDxQ/mFTyvM68cvwmETC08DZEw279roIe
CF3OjRzf4IxPlxF0H34Xf09QVEfApPbQ/+E65qk78xBq0HrmnlgJvrhkywrtsFEi
yeOnyG5w3mkgXJeZXn9P87V9VvpJKjOYbDoTJS94EB66ShKj7IXtoEG46nPce45B
cS9zcYqIi1cY6MHUpNfQwbHgJ5+HfT8U87HMARsB1h61t1HaxONwSmdgQy7NHOah
9SaXNgTdxYUc3872pRtVazRz5f5iqr/xsIoyhl2GPhCvO0H0fZyy7bqzqiZ44VVb
exbQ7tQKqaK9aKPUQPyQscj0lYAReqQzD5l2VII7SSQmiN6C5QZi7hv8uH9U8cvB
A/5/eHRtPPT/B08qY9bemLNrCo0kLIRdMshLp83MkgNmjsQfpf8Dbptm4ktQqpDs
bJ0c0LZjQCGfpqpDZgb47OSBgd3V3nC+4YiADOC0gAfapdu1dXsnqKuOWZUhhGZd
GofcS2t7hp4Yjjoi6GmGQdF0ZhEsGt9pybf23fIQ7ur2FE6PpuNmMiJAUajwcMAR
4Do7hQAlR3RL6JJSExzK
=ItHg
-----END PGP SIGNATURE-----

--GV0iVqYguTV4Q9ER--
