Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 May 2007 16:13:43 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:8703 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20024187AbXETPNl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 20 May 2007 16:13:41 +0100
Received: from localhost (p1167-ipad204funabasi.chiba.ocn.ne.jp [222.146.88.167])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id D8411B743; Mon, 21 May 2007 00:12:19 +0900 (JST)
Date:	Mon, 21 May 2007 00:12:38 +0900 (JST)
Message-Id: <20070521.001238.41198930.anemo@mba.ocn.ne.jp>
To:	yoichi_yuasa@tripeaks.co.jp
Cc:	florian.fainelli@telecomint.eu, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH 1/2] Add MIPS generic GPIO support
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070520182301.7d7831e5.yoichi_yuasa@tripeaks.co.jp>
References: <200705192151.37338.florian.fainelli@telecomint.eu>
	<20070520182301.7d7831e5.yoichi_yuasa@tripeaks.co.jp>
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
X-archive-position: 15095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 20 May 2007 18:23:01 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> diff -pruN -X gpio/Documentation/dontdiff gpio-orig/include/asm-mips/gpio.h gpio/include/asm-mips/gpio.h
> --- gpio-orig/include/asm-mips/gpio.h	1970-01-01 09:00:00.000000000 +0900
> +++ gpio/include/asm-mips/gpio.h	2007-05-20 17:21:36.332456000 +0900
> @@ -0,0 +1,6 @@
> +#ifndef __ASM_MIPS_GPIO_H
> +#define __ASM_MIPS_GPIO_H
> +
> +#include <gpio.h>
> +
> +#endif /* __ASM_MIPS_GPIO_H */

This looks good for me.

> diff -pruN -X gpio/Documentation/dontdiff gpio-orig/include/asm-mips/mach-generic/gpio.h gpio/include/asm-mips/mach-generic/gpio.h
> --- gpio-orig/include/asm-mips/mach-generic/gpio.h	1970-01-01 09:00:00.000000000 +0900
> +++ gpio/include/asm-mips/mach-generic/gpio.h	2007-05-20 17:24:07.401897250 +0900
> @@ -0,0 +1,6 @@
> +#ifndef __ASM_MACH_GENERIC_GPIO_H
> +#define __ASM_MACH_GENERIC_GPIO_H
> +
> +/* no GPIO support */ 
> +
> +#endif /* __ASM_MACH_GENERIC_GPIO_H */

But is this really needed?  I can not see any point of this empty gpio.h ...

---
Atsushi Nemoto
