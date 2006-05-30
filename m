Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 May 2006 16:58:50 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:63659 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133359AbWE3O6m (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 30 May 2006 16:58:42 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k4UEwg2i028243;
	Tue, 30 May 2006 15:58:42 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k4UEwfYj028242;
	Tue, 30 May 2006 15:58:41 +0100
Date:	Tue, 30 May 2006 15:58:41 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Tom Weustink <freshy98@gmx.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: SGI O2+ RM7000 set_uncached_handler error during kernel built
Message-ID: <20060530145841.GA28223@linux-mips.org>
References: <4477B8C9.3050909@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4477B8C9.3050909@gmx.net>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11601
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, May 27, 2006 at 04:26:17AM +0200, Tom Weustink wrote:

> I finally got a round building a toolchain for creating kernels for my 
> SGI O2+ RM7000 machine.
> 
> I did a ip32_defconfig and used menuconfig to edit some small options.
> One was to set it too RM7000 obviously.
> 
> When I build it, I get the following error:
> 
>  CC      arch/mips/kernel/traps.o
> arch/mips/kernel/traps.c: In function `set_uncached_handler':
> arch/mips/kernel/traps.c:1360: error: `TO_PHYS_MASK' undeclared (first 
> use in this function)
> 
> When I build it for R5000 (only that changed in menuconfig) the compile 
> runs without a problem.
> 
> Checking arch/mips/kernel/traps.c:1360 shows that installs the uncached 
> CPU exception handler to UNCAC.
> Now I know the RM7000 is kinda weird, but shouldn't it just work on it 
> since it does work on R5000 since it's MIPS64?
> 
> I also heard from `Kumba that the kernel won't boot at all due to a bug 
> in IP32 so that it hangs extremely early, but having it to just built 
> would be nice for me atm.

The build error part was trivial, fix below.

  Ralf

commit 948a25c865f2c486f3f2a6034c359c2104c777df
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Tue May 30 15:55:05 2006 +0100

    [MIPS] Fix 64-bit build for RM7000.
    
    RM7000 has 40-bit virtual / 36-bit physical address space.
    
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/include/asm-mips/addrspace.h b/include/asm-mips/addrspace.h
index 42520cc..1386af1 100644
--- a/include/asm-mips/addrspace.h
+++ b/include/asm-mips/addrspace.h
@@ -129,6 +129,7 @@ #define PHYS_TO_XKPHYS(cm,a)		(_LLCONST_
 #if defined (CONFIG_CPU_R4300)						\
     || defined (CONFIG_CPU_R4X00)					\
     || defined (CONFIG_CPU_R5000)					\
+    || defined (CONFIG_CPU_RM7000)					\
     || defined (CONFIG_CPU_NEVADA)					\
     || defined (CONFIG_CPU_TX49XX)					\
     || defined (CONFIG_CPU_MIPS64)
