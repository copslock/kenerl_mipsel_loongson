Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Aug 2007 16:39:53 +0100 (BST)
Received: from adicia.telenet-ops.be ([195.130.132.56]:37832 "EHLO
	adicia.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20021297AbXHOPjn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 15 Aug 2007 16:39:43 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by adicia.telenet-ops.be (Postfix) with SMTP id 7EBF02300B6;
	Wed, 15 Aug 2007 17:39:33 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by adicia.telenet-ops.be (Postfix) with ESMTP id 26F042300D5;
	Wed, 15 Aug 2007 17:39:32 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-8) with ESMTP id l7FFdWs1015744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 15 Aug 2007 17:39:32 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id l7FFdVt5015741;
	Wed, 15 Aug 2007 17:39:31 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Wed, 15 Aug 2007 17:39:31 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Aurelien Jarno <aurelien@aurel32.net>
Cc:	Andrew Morton <akpm@linux-foundation.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH -mm][MIPS] GPIO LED driver for the WGT634U machine
In-Reply-To: <20070815112507.GB17615@hall.aurel32.net>
Message-ID: <Pine.LNX.4.64.0708151736150.5158@anakin>
References: <20070815112507.GB17615@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16197
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 15 Aug 2007, Aurelien Jarno wrote:
> --- a/arch/mips/bcm947xx/wgt634u.c
> +++ b/arch/mips/bcm947xx/wgt634u.c

> +static const struct gpio_led wgt634u_leds[] = {

> +static const struct gpio_led_platform_data wgt634u_led_data = {
> +	.num_leds =     ARRAY_SIZE(wgt634u_leds),
> +	.leds =         (void *) wgt634u_leds,
                        ^^^^^^^^

gpio_led_platform_data.leds is of type struct gpio_led *.
Should it be const, or should the const be dropped from wgt634u_leds?

> +static struct platform_device wgt634u_gpio_leds = {
> +	.name =         "leds-gpio",
> +	.id =           -1,
> +	.dev = {
> +		.platform_data = (void *) &wgt634u_led_data,
                                 ^^^^^^^^
device.platform_data is a void *, so you can drop the cast.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
