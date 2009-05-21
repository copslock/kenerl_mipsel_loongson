Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 May 2009 10:41:06 +0100 (BST)
Received: from hall.aurel32.net ([88.191.82.174]:45790 "EHLO hall.aurel32.net"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023916AbZEUJlA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 May 2009 10:41:00 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.69)
	(envelope-from <aurelien@aurel32.net>)
	id 1M74li-0007XF-Rh; Thu, 21 May 2009 11:40:54 +0200
Date:	Thu, 21 May 2009 11:40:54 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	matthieu castet <castet.matthieu@free.fr>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix gpio_direction_output for bcm47xx
Message-ID: <20090521094054.GB22500@hall.aurel32.net>
References: <4A0EBC77.2010806@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <4A0EBC77.2010806@free.fr>
X-Mailer: Mutt 1.5.18 (2008-05-17)
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

On Sat, May 16, 2009 at 03:15:35PM +0200, matthieu castet wrote:
> gpio_direction_output should also set to a output value per gpio API.
>
> Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>

Acked-by: Aurelien Jarno <aurelien@aurel32.net>

> diff --git a/arch/mips/include/asm/mach-bcm47xx/gpio.h b/arch/mips/include/asm/mach-bcm47xx/gpio.h
> index 1784fde..9850414 100644
> --- a/arch/mips/include/asm/mach-bcm47xx/gpio.h
> +++ b/arch/mips/include/asm/mach-bcm47xx/gpio.h
> @@ -37,6 +37,9 @@ static inline int gpio_direction_input(unsigned gpio)
>  
>  static inline int gpio_direction_output(unsigned gpio, int value)
>  {
> +	/* first set the gpio out value */
> +	ssb_gpio_out(&ssb_bcm47xx, 1 << gpio, value ? 1 << gpio : 0);
> +	/* then set the gpio mode */
>  	ssb_gpio_outen(&ssb_bcm47xx, 1 << gpio, 1 << gpio);
>  	return 0;
>  }


-- 
Aurelien Jarno	                        GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net
