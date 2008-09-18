Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2008 10:32:50 +0100 (BST)
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:31217 "EHLO
	atlas.informatik.uni-freiburg.de") by ftp.linux-mips.org with ESMTP
	id S20045125AbYIRJcr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 Sep 2008 10:32:47 +0100
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1KgFsS-0000kE-V5; Thu, 18 Sep 2008 11:32:45 +0200
Received: from zeisberg by login.informatik.uni-freiburg.de with local (Exim 4.63)
	(envelope-from <zeisberg@login.informatik.uni-freiburg.de>)
	id 1KgFsR-00021n-14; Thu, 18 Sep 2008 11:32:43 +0200
Date:	Thu, 18 Sep 2008 11:32:42 +0200
From:	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	linux-kernel@vger.kernel.org, david-b@pacbell.net,
	ralf@linux-mips.org, linux-mips@linux-mips.org,
	g.liakhovetski@pengutronix.de, greg@kroah.com,
	kay.sievers@vrfy.org, rmk+kernel@arm.linux.org.uk
Subject: Re: [PATCH] gpio_free might sleep, mips architecture
Message-ID: <20080918093242.GA7627@informatik.uni-freiburg.de>
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, david-b@pacbell.net,
	ralf@linux-mips.org, linux-mips@linux-mips.org,
	g.liakhovetski@pengutronix.de, greg@kroah.com, kay.sievers@vrfy.org,
	rmk+kernel@arm.linux.org.uk
References: <1216884515-12084-1-git-send-email-Uwe.Kleine-Koenig@digi.com> <1221508963-27259-1-git-send-email-ukleinek@informatik.uni-freiburg.de> <1221508963-27259-2-git-send-email-ukleinek@informatik.uni-freiburg.de> <1221508963-27259-3-git-send-email-ukleinek@informatik.uni-freiburg.de> <20080917143955.2d3727e5.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20080917143955.2d3727e5.akpm@linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Organization: Universitaet Freiburg, Institut f. Informatik
Return-Path: <zeisberg@informatik.uni-freiburg.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zeisberg@informatik.uni-freiburg.de
Precedence: bulk
X-list: linux-mips

Hello,

Andrew Morton wrote:
> > diff --git a/include/asm-mips/mach-rc32434/gpio.h b/include/asm-mips/mach-rc32434/gpio.h
> > index f946f5f..9b4722e 100644
> > --- a/include/asm-mips/mach-rc32434/gpio.h
> > +++ b/include/asm-mips/mach-rc32434/gpio.h
> > @@ -13,6 +13,7 @@
> >  #ifndef _RC32434_GPIO_H_
> >  #define _RC32434_GPIO_H_
> >  
> > +#include <linux/kernel.h>
> >  #include <linux/types.h>
> >  
> >  struct rb532_gpio_reg {
> > @@ -88,6 +89,7 @@ static inline int gpio_request(unsigned gpio, const char *label)
> >  static inline void gpio_free(unsigned gpio)
> >  {
> >  	/* Not yet implemented */
> > +	might_sleep();
> >  }
> >  
> 
> There is no gpio_free() in linux-next's include/asm-mips/mach-rc32434/gpio.h
This is OK.  This machine type is converted to GPIO lib in linus-next.
So just drop the two hunks for this file.  (Note, you only dropped the
addition of might_sleep, but then including linux/kernel.h isn't needed
either.)

Best regards and thanks
Uwe

-- 
Uwe Kleine-König

exit vi, lesson II:
: w q ! <CR>

NB: write the current file
