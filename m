Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Jan 2008 12:21:48 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:3309 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023363AbYAMMVk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 13 Jan 2008 12:21:40 +0000
Received: from localhost (p7032-ipad201funabasi.chiba.ocn.ne.jp [222.146.70.32])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 08017820F; Sun, 13 Jan 2008 21:21:32 +0900 (JST)
Date:	Sun, 13 Jan 2008 21:21:24 +0900 (JST)
Message-Id: <20080113.212124.25909412.anemo@mba.ocn.ne.jp>
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
X-archive-position: 18009
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 12 Jan 2008 18:18:02 +0100, Matteo Croce <technoboy85@gmail.com> wrote:
> This new patch caches addresses as suggested by Atsushi Nemoto

Well, I cannot remember any suggestion about caches.  I just said you
should kill all volatiles.

> +static inline int gpio_get_value(unsigned gpio)
> +{
> +	static unsigned addr;
> +
> +	if (!addr) {
> +		void __iomem *gpio_in = (void __iomem *)
> +				KSEG1ADDR(AR7_REGS_GPIO + AR7_GPIO_INPUT);
> +		addr = readl(gpio_in);
> +	}
> +
> +	return addr & (1 << gpio);
> +}

Anyway, this is absolutely broken.  You are caching the GPIO value,
not the address.

---
Atsushi Nemoto
