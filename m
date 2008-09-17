Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Sep 2008 22:40:39 +0100 (BST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46986 "EHLO
	smtp1.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S20234192AbYIQVke (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Sep 2008 22:40:34 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8HLdu8x031980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Sep 2008 14:39:57 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m8HLdtq3031768;
	Wed, 17 Sep 2008 14:39:55 -0700
Date:	Wed, 17 Sep 2008 14:39:55 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Cc:	linux-kernel@vger.kernel.org, david-b@pacbell.net,
	ralf@linux-mips.org, linux-mips@linux-mips.org,
	g.liakhovetski@pengutronix.de, greg@kroah.com,
	kay.sievers@vrfy.org, rmk+kernel@arm.linux.org.uk
Subject: Re: [PATCH] gpio_free might sleep, mips architecture
Message-Id: <20080917143955.2d3727e5.akpm@linux-foundation.org>
In-Reply-To: <1221508963-27259-3-git-send-email-ukleinek@informatik.uni-freiburg.de>
References: <1216884515-12084-1-git-send-email-Uwe.Kleine-Koenig@digi.com>
	<1221508963-27259-1-git-send-email-ukleinek@informatik.uni-freiburg.de>
	<1221508963-27259-2-git-send-email-ukleinek@informatik.uni-freiburg.de>
	<1221508963-27259-3-git-send-email-ukleinek@informatik.uni-freiburg.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20524
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Mon, 15 Sep 2008 22:02:41 +0200
Uwe Kleine-K__nig <ukleinek@informatik.uni-freiburg.de> wrote:

> According to the documentation gpio_free should only be called from task
> context only.  To make this more explicit add a might sleep to all
> implementations.
> 
> This patch changes the gpio_free implementations for the mips
> architecture.
> 
> Signed-off-by: Uwe Kleine-K__nig <ukleinek@informatik.uni-freiburg.de>
> Cc: David Brownell <david-b@pacbell.net>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: Guennadi Liakhovetski <g.liakhovetski@pengutronix.de>
> Cc: Greg KH <greg@kroah.com>
> Cc: Kay Sievers <kay.sievers@vrfy.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  include/asm-mips/mach-au1x00/gpio.h  |    2 ++
>  include/asm-mips/mach-bcm47xx/gpio.h |    3 +++
>  include/asm-mips/mach-rc32434/gpio.h |    2 ++
>  3 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/include/asm-mips/mach-au1x00/gpio.h b/include/asm-mips/mach-au1x00/gpio.h
> index 2dc61e0..31eddba 100644
> --- a/include/asm-mips/mach-au1x00/gpio.h
> +++ b/include/asm-mips/mach-au1x00/gpio.h
> @@ -1,6 +1,7 @@
>  #ifndef _AU1XXX_GPIO_H_
>  #define _AU1XXX_GPIO_H_
>  
> +#include <linux/kernel.h>
>  #include <linux/types.h>
>  
>  #define AU1XXX_GPIO_BASE	200
> @@ -31,6 +32,7 @@ static inline int gpio_request(unsigned gpio, const char *label)
>  static inline void gpio_free(unsigned gpio)
>  {
>  	/* Not yet implemented */
> +	might_sleep();
>  }
>  
>  static inline int gpio_direction_input(unsigned gpio)
> diff --git a/include/asm-mips/mach-bcm47xx/gpio.h b/include/asm-mips/mach-bcm47xx/gpio.h
> index cfc8f4d..af17ccd 100644
> --- a/include/asm-mips/mach-bcm47xx/gpio.h
> +++ b/include/asm-mips/mach-bcm47xx/gpio.h
> @@ -9,6 +9,8 @@
>  #ifndef __BCM47XX_GPIO_H
>  #define __BCM47XX_GPIO_H
>  
> +#include <linux/kernel.h>
> +
>  #define BCM47XX_EXTIF_GPIO_LINES	5
>  #define BCM47XX_CHIPCO_GPIO_LINES	16
>  
> @@ -25,6 +27,7 @@ static inline int gpio_request(unsigned gpio, const char *label)
>  
>  static inline void gpio_free(unsigned gpio)
>  {
> +	might_sleep();
>  }
>  
>  static inline int gpio_to_irq(unsigned gpio)
> diff --git a/include/asm-mips/mach-rc32434/gpio.h b/include/asm-mips/mach-rc32434/gpio.h
> index f946f5f..9b4722e 100644
> --- a/include/asm-mips/mach-rc32434/gpio.h
> +++ b/include/asm-mips/mach-rc32434/gpio.h
> @@ -13,6 +13,7 @@
>  #ifndef _RC32434_GPIO_H_
>  #define _RC32434_GPIO_H_
>  
> +#include <linux/kernel.h>
>  #include <linux/types.h>
>  
>  struct rb532_gpio_reg {
> @@ -88,6 +89,7 @@ static inline int gpio_request(unsigned gpio, const char *label)
>  static inline void gpio_free(unsigned gpio)
>  {
>  	/* Not yet implemented */
> +	might_sleep();
>  }
>  

There is no gpio_free() in linux-next's include/asm-mips/mach-rc32434/gpio.h
