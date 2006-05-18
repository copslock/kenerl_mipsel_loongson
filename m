Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 May 2006 12:12:42 +0200 (CEST)
Received: from sorrow.cyrius.com ([65.19.161.204]:35853 "HELO
	sorrow.cyrius.com") by ftp.linux-mips.org with SMTP
	id S8133862AbWERKMe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 May 2006 12:12:34 +0200
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id AB4AC64D54; Thu, 18 May 2006 10:12:26 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 6D05B66F5A; Thu, 18 May 2006 12:12:12 +0200 (CEST)
Date:	Thu, 18 May 2006 12:12:12 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	dmitry pervushin <dpervushin@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] NEC EMMA2RH support
Message-ID: <20060518101212.GI7018@deprecation.cyrius.com>
References: <1147946423.8223.4.camel@diimka-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147946423.8223.4.camel@diimka-laptop>
User-Agent: Mutt/1.5.11+cvs20060330
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11482
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

Some minor comments regarding the coding style:

* dmitry pervushin <dpervushin@ru.mvista.com> [2006-05-18 14:00]:
> +	  Features : kernel debugging, serial terminal, NFS root fs, on-board

There shouldn't be a space before the colon.

> ===================================================================
> --- linux-malta.orig/arch/mips/Makefile
> +++ linux-malta/arch/mips/Makefile
> @@ -196,7 +196,7 @@ cflags-$(CONFIG_CPU_MIPS64R2)	+= \
>  
>  cflags-$(CONFIG_CPU_R5000)	+= \
>  			$(call set_gccflags,r5000,mips4,r5000,mips4,mips2) \
> -			-Wa,--trap 
> +			-Wa,--trap
>  
>  cflags-$(CONFIG_CPU_R5432)	+= \
>  			$(call set_gccflags,r5400,mips4,r5000,mips4,mips2) \
> @@ -776,7 +776,7 @@ archclean:
>  	@$(MAKE) $(clean)=arch/mips/boot
>  	@$(MAKE) $(clean)=arch/mips/lasat
>  
> -# Generate <asm/offset.h 
> +# Generate <asm/offset.h

Those unrelated changes shouldn't be made.

> +// #include <linux/kdev_t.h>
> +#include <linux/types.h>
> +// #include <linux/sched.h>
> +// #include <linux/pci.h>

I think C++ style comments should't be used in the kernel.  In any
case, you could just remove them if they're not used.

-- 
Martin Michlmayr
http://www.cyrius.com/
