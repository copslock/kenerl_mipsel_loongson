Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 May 2006 17:09:03 +0200 (CEST)
Received: from mail.gmx.de ([213.165.64.20]:15496 "HELO mail.gmx.net")
	by ftp.linux-mips.org with SMTP id S8133467AbWE3PIx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 30 May 2006 17:08:53 +0200
Received: (qmail 5021 invoked by uid 0); 30 May 2006 15:08:47 -0000
Received: 62.58.165.82 by service.gmx.net with HTTP;
 Tue, 30 May 2006 17:08:47 +0200 (CEST)
X-Flags: 0001
Message-ID: <20060530150847.102900@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date:	Tue, 30 May 2006 17:08:47 +0200
cc:	linux-mips@linux-mips.org
from:	Tom Weustink <freshy98@gmx.net>
In-Reply-To: <20060530145841.GA28223@linux-mips.org>
References: <4477B8C9.3050909@gmx.net> <20060530145841.GA28223@linux-mips.org>
Subject: Re: Re: SGI O2+ RM7000 set_uncached_handler error during kernel built
to:	Ralf Baechle <ralf@linux-mips.org>
X-Authenticated: #11016536
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
x-priority: 3
Content-Transfer-Encoding: 7bit
Return-Path: <freshy98@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11602
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freshy98@gmx.net
Precedence: bulk
X-list: linux-mips

> 
> > I finally got a round building a toolchain for creating kernels for my 
> > SGI O2+ RM7000 machine.
> > 
> > I did a ip32_defconfig and used menuconfig to edit some small options.
> > One was to set it too RM7000 obviously.
> > 
> > When I build it, I get the following error:
> > 
> >  CC      arch/mips/kernel/traps.o
> > arch/mips/kernel/traps.c: In function `set_uncached_handler':
> > arch/mips/kernel/traps.c:1360: error: `TO_PHYS_MASK' undeclared (first 
> > use in this function)
> > 
> > When I build it for R5000 (only that changed in menuconfig) the compile 
> > runs without a problem.
> > 
> > Checking arch/mips/kernel/traps.c:1360 shows that installs the uncached 
> > CPU exception handler to UNCAC.
> > Now I know the RM7000 is kinda weird, but shouldn't it just work on it 
> > since it does work on R5000 since it's MIPS64?
> > 
> > I also heard from `Kumba that the kernel won't boot at all due to a bug 
> > in IP32 so that it hangs extremely early, but having it to just built 
> > would be nice for me atm.
> 
> The build error part was trivial, fix below.
> 
>   Ralf
> 
Great! I will try it out tonight.
I kind of had the idea something pointing to RM7000 was missing, obviously I had no idea where though.

Tom


> commit 948a25c865f2c486f3f2a6034c359c2104c777df
> Author: Ralf Baechle <ralf@linux-mips.org>
> Date:   Tue May 30 15:55:05 2006 +0100
> 
>     [MIPS] Fix 64-bit build for RM7000.
>     
>     RM7000 has 40-bit virtual / 36-bit physical address space.
>     
>     Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> diff --git a/include/asm-mips/addrspace.h b/include/asm-mips/addrspace.h
> index 42520cc..1386af1 100644
> --- a/include/asm-mips/addrspace.h
> +++ b/include/asm-mips/addrspace.h
> @@ -129,6 +129,7 @@ #define PHYS_TO_XKPHYS(cm,a)		(_LLCONST_
>  #if defined (CONFIG_CPU_R4300)						\
>      || defined (CONFIG_CPU_R4X00)					\
>      || defined (CONFIG_CPU_R5000)					\
> +    || defined (CONFIG_CPU_RM7000)					\
>      || defined (CONFIG_CPU_NEVADA)					\
>      || defined (CONFIG_CPU_TX49XX)					\
>      || defined (CONFIG_CPU_MIPS64)

-- 


Bis zu 70% Ihrer Onlinekosten sparen: GMX SmartSurfer!
      Kostenlos downloaden: http://www.gmx.net/de/go/smartsurfer
    
