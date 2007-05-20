Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 May 2007 16:27:44 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:53698 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20024195AbXETP1n (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 20 May 2007 16:27:43 +0100
Received: from localhost (p1167-ipad204funabasi.chiba.ocn.ne.jp [222.146.88.167])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 91160A000; Mon, 21 May 2007 00:26:23 +0900 (JST)
Date:	Mon, 21 May 2007 00:26:42 +0900 (JST)
Message-Id: <20070521.002642.108739229.anemo@mba.ocn.ne.jp>
To:	florian.fainelli@telecomint.eu
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] Add GPIO wrappers to Au1x00 boards
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <200705192151.39752.florian.fainelli@telecomint.eu>
References: <200705192151.39752.florian.fainelli@telecomint.eu>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 19 May 2007 21:51:39 +0200, Florian Fainelli <florian.fainelli@telecomint.eu> wrote:
> diff -urN linux-2.6.21.1/include/asm-mips/mach-au1x00/au1xxx_gpio.h linux-2.6.21.1.new/include/asm-mips/mach-au1x00/au1xxx_gpio.h
> --- linux-2.6.21.1/include/asm-mips/mach-au1x00/au1xxx_gpio.h	2007-04-27 23:49:26.000000000 +0200
> +++ linux-2.6.21.1.new/include/asm-mips/mach-au1x00/au1xxx_gpio.h	2007-05-19 21:34:27.000000000 +0200
> @@ -1,10 +1,7 @@
...
> +/* Wrappers for the arch-neutral GPIO API */
> +
> +static inline int gpio_request(unsigned gpio, const char *label)
> +{
> +	/* Not yet implemented */
> +	return 0;
> +}
> +
> +static inline void gpio_free(unsigned gpio)
> +{
> +	/* Not yet implemented */
> +}
> +
> +extern int gpio_direction_input(unsigned gpio);
> +extern int gpio_direction_output(unsigned gpio, int value);
> +
> +static inline int gpio_get_value(unsigned gpio)
> +{
> +	return au1xxx_gpio_get_value(gpio);
> +}
> +
> +static inline void gpio_set_value(unsigned gpio, int value)
> +{
> +	au1xxx_gpio_set_value(gpio, value);
> +}
> +
> +static inline int gpio_to_irq(unsigned gpio)
> +{
> +	return gpio;
> +}
> +
> +static inline int irq_to_gpio(unsigned irq)
> +{
> +	return irq;
> +}
> +
> +/* For cansleep */
> +#include <asm-generic/gpio.h>
> +
> +#endif /* _AU1XXX_GPIO_H_ */

These APIs should be usable by "#include <asm/gpio.h>".  So move
mach-au1x00/au1xxx_gpio.h to mach-au1x00/gpio.h and include it by
include/asm-mips/gpio.h (as Youichi said).

And it seems gpio_direction_input()/gpio_direction_output() are not
implemented.  A user of the GPIO API _should_ use these interfaces.

---
Atsushi Nemoto
