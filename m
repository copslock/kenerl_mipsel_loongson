Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Jan 2008 12:33:04 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:61126 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023410AbYAMMc4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 13 Jan 2008 12:32:56 +0000
Received: from localhost (p7032-ipad201funabasi.chiba.ocn.ne.jp [222.146.70.32])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C4F669A8F; Sun, 13 Jan 2008 21:32:51 +0900 (JST)
Date:	Sun, 13 Jan 2008 21:32:44 +0900 (JST)
Message-Id: <20080113.213244.41629740.anemo@mba.ocn.ne.jp>
To:	technoboy85@gmail.com
Cc:	linux-mips@linux-mips.org, florian@openwrt.org, nbd@openwrt.org,
	ejka@imfi.kspu.ru, nico@openwrt.org, ralf@linux-mips.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH][MIPS]: AR7 GPIO
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <200801121818.02550.technoboy85@gmail.com>
References: <200801121818.02550.technoboy85@gmail.com>
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
X-archive-position: 18010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 12 Jan 2008 18:18:02 +0100, Matteo Croce <technoboy85@gmail.com> wrote:
> +static inline void gpio_set_value(unsigned gpio, int value)
> +{
> +	static void __iomem *gpio_out;
> +	unsigned tmp;
> +
> +	if (!gpio_out)
> +		gpio_out = (void __iomem *)
> +				KSEG1ADDR(AR7_REGS_GPIO + AR7_GPIO_OUTPUT);
> +
> +	tmp = readl(gpio_out) & ~(1 << gpio);
> +	if (value)
> +		tmp |= 1 << gpio;
> +	writel(tmp, gpio_out);
> +}

It seems the compiler can calculate gpio_out value at compile time.
So I think caching it just make the function slower.

---
Atsushi Nemoto
