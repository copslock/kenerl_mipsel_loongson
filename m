Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Sep 2007 17:16:40 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:14023 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20026337AbXIVQQb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 22 Sep 2007 17:16:31 +0100
Received: from localhost (p3087-ipad306funabasi.chiba.ocn.ne.jp [123.217.173.87])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9C2B3962A; Sun, 23 Sep 2007 01:16:24 +0900 (JST)
Date:	Sun, 23 Sep 2007 01:18:01 +0900 (JST)
Message-Id: <20070923.011801.41198840.anemo@mba.ocn.ne.jp>
To:	technoboy85@gmail.com
Cc:	linux-mips@linux-mips.org, florian@openwrt.org, nbd@openwrt.org,
	ejka@imfi.kspu.ru, nico@openwrt.org, ralf@linux-mips.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH][MIPS][1/7] AR7: core support
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <200709201743.48164.technoboy85@gmail.com>
References: <200709201728.10866.technoboy85@gmail.com>
	<200709201743.48164.technoboy85@gmail.com>
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
X-archive-position: 16636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 20 Sep 2007 17:43:46 +0200, Matteo Croce <technoboy85@gmail.com> wrote:
> +static inline int gpio_get_value(unsigned gpio)
> +{
> +	void __iomem *gpio_in =
> +		(void __iomem *)KSEG1ADDR(AR7_REGS_GPIO + AR7_GPIO_INPUT);
> +
> +	if (gpio >= AR7_GPIO_MAX)
> +		return -EINVAL;

Checking with AR7_GPIO_MAX can be dropped from gpio_set_value() and
gpio_get_value().  The validity checking is done in gpio_direction_*().

--- excerpt from Documentation/gpio.txt ---
The get/set calls have no error returns because "invalid GPIO" should have
been reported earlier from gpio_direction_*().  However, note that not all
platforms can read the value of output pins; those that can't should always
return zero.  Also, using these calls for GPIOs that can't safely be accessed
without sleeping (see below) is an error.

Platform-specific implementations are encouraged to optimize the two
calls to access the GPIO value in cases where the GPIO number (and for
output, value) are constant.  ...
--- excerpt ---

> +
> +	return ((readl(gpio_in) & (1 << gpio)) != 0);

The gpio API defines any non-zero value (not only '1') for "high", so
"!= 0" is not required.

> +}
> +
> +static inline void gpio_set_value(unsigned gpio, int value)
> +{
> +	void __iomem *gpio_out =
> +		(void __iomem *)KSEG1ADDR(AR7_REGS_GPIO + AR7_GPIO_OUTPUT);
> +	volatile unsigned tmp;

This 'volatile' has no sense and can be just dropped.

> +
> +	if (gpio >= AR7_GPIO_MAX)
> +		return;

Ditto.

> +
> +	tmp = readl(gpio_out) & ~(1 << gpio);
> +	if (value)
> +		tmp |= 1 << gpio;
> +	writel(tmp, gpio_out);
> +}

---
Atsushi Nemoto
