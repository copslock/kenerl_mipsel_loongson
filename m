Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2008 15:00:08 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:43424 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S28586174AbYIROAG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 18 Sep 2008 15:00:06 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m8IDxt10010100;
	Thu, 18 Sep 2008 15:59:55 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m8IDxoeB010098;
	Thu, 18 Sep 2008 15:59:50 +0200
Date:	Thu, 18 Sep 2008 15:59:50 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, david-b@pacbell.net,
	linux-mips@linux-mips.org, g.liakhovetski@pengutronix.de,
	greg@kroah.com, kay.sievers@vrfy.org, rmk+kernel@arm.linux.org.uk
Subject: Re: [PATCH] gpio_free might sleep, mips architecture
Message-ID: <20080918135950.GA8104@linux-mips.org>
References: <1216884515-12084-1-git-send-email-Uwe.Kleine-Koenig@digi.com> <1221508963-27259-1-git-send-email-ukleinek@informatik.uni-freiburg.de> <1221508963-27259-2-git-send-email-ukleinek@informatik.uni-freiburg.de> <1221508963-27259-3-git-send-email-ukleinek@informatik.uni-freiburg.de> <20080917143955.2d3727e5.akpm@linux-foundation.org> <20080918093242.GA7627@informatik.uni-freiburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20080918093242.GA7627@informatik.uni-freiburg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 18, 2008 at 11:32:42AM +0200, Uwe Kleine-König wrote:

> Andrew Morton wrote:
> > > diff --git a/include/asm-mips/mach-rc32434/gpio.h b/include/asm-mips/mach-rc32434/gpio.h
> > > index f946f5f..9b4722e 100644
> > > --- a/include/asm-mips/mach-rc32434/gpio.h
> > > +++ b/include/asm-mips/mach-rc32434/gpio.h
> > > @@ -13,6 +13,7 @@
> > >  #ifndef _RC32434_GPIO_H_
> > >  #define _RC32434_GPIO_H_
> > >  
> > > +#include <linux/kernel.h>
> > >  #include <linux/types.h>
> > >  
> > >  struct rb532_gpio_reg {
> > > @@ -88,6 +89,7 @@ static inline int gpio_request(unsigned gpio, const char *label)
> > >  static inline void gpio_free(unsigned gpio)
> > >  {
> > >  	/* Not yet implemented */
> > > +	might_sleep();
> > >  }
> > >  
> > 
> > There is no gpio_free() in linux-next's include/asm-mips/mach-rc32434/gpio.h
> This is OK.  This machine type is converted to GPIO lib in linus-next.
> So just drop the two hunks for this file.  (Note, you only dropped the
> addition of might_sleep, but then including linux/kernel.h isn't needed
> either.)

A few days ago I've put a patch to move include/asm-mips/ to arch/ like
several other architectures already did so you patch may conflict ...

  Ralf
