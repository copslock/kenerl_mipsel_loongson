Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 May 2006 12:35:12 +0200 (CEST)
Received: from rtsoft3.corbina.net ([85.21.88.6]:50916 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S8133864AbWERKfA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 May 2006 12:35:00 +0200
Received: from diimka-laptop.dev.rtsoft.ru ([10.150.0.9])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id k4IAYvs02415;
	Thu, 18 May 2006 15:34:57 +0500
Subject: Re: [PATCH] NEC EMMA2RH support
From:	dmitry pervushin <dpervushin@ru.mvista.com>
Reply-To: dpervushin@ru.mvista.com
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060518101212.GI7018@deprecation.cyrius.com>
References: <1147946423.8223.4.camel@diimka-laptop>
	 <20060518101212.GI7018@deprecation.cyrius.com>
Content-Type: text/plain; charset=KOI8-R
Organization: montavista
Date:	Thu, 18 May 2006 14:34:56 +0400
Message-Id: <1147948496.8223.6.camel@diimka-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 8bit
Return-Path: <dpervushin@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dpervushin@ru.mvista.com
Precedence: bulk
X-list: linux-mips

On Чтв, 2006-05-18 at 12:12 +0200, Martin Michlmayr wrote:
> Some minor comments regarding the coding style:
OK, thank you. I'll wait for another comments and resend the patch after
taking them into account
> 
> * dmitry pervushin <dpervushin@ru.mvista.com> [2006-05-18 14:00]:
> > +	  Features : kernel debugging, serial terminal, NFS root fs, on-board
> 
> There shouldn't be a space before the colon.
> 
> > ===================================================================
> > --- linux-malta.orig/arch/mips/Makefile
> > +++ linux-malta/arch/mips/Makefile
> > @@ -196,7 +196,7 @@ cflags-$(CONFIG_CPU_MIPS64R2)	+= \
> >  
> >  cflags-$(CONFIG_CPU_R5000)	+= \
> >  			$(call set_gccflags,r5000,mips4,r5000,mips4,mips2) \
> > -			-Wa,--trap 
> > +			-Wa,--trap
> >  
> >  cflags-$(CONFIG_CPU_R5432)	+= \
> >  			$(call set_gccflags,r5400,mips4,r5000,mips4,mips2) \
> > @@ -776,7 +776,7 @@ archclean:
> >  	@$(MAKE) $(clean)=arch/mips/boot
> >  	@$(MAKE) $(clean)=arch/mips/lasat
> >  
> > -# Generate <asm/offset.h 
> > +# Generate <asm/offset.h
> 
> Those unrelated changes shouldn't be made.
> 
> > +// #include <linux/kdev_t.h>
> > +#include <linux/types.h>
> > +// #include <linux/sched.h>
> > +// #include <linux/pci.h>
> 
> I think C++ style comments should't be used in the kernel.  In any
> case, you could just remove them if they're not used.
> 
-- 
cheers, dmitry pervushin
