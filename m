Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Nov 2003 22:30:04 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:47246 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225391AbTKQW3w>;
	Mon, 17 Nov 2003 22:29:52 +0000
Received: from drow by nevyn.them.org with local (Exim 4.24 #1 (Debian))
	id 1ALrsK-0002i1-8d; Mon, 17 Nov 2003 17:29:40 -0500
Date: Mon, 17 Nov 2003 17:29:40 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Jeffrey Baitis <baitisj@evolution.com>
Cc: linux-mips@linux-mips.org, Adam_Kiepul@pmc-sierra.com,
	"Mr. Brian R. Gunnison" <brian@evolution.com>,
	Francis Yu <francisyu@synergyrep.com>,
	Johnny Lam <Johnny_Lam@pmc-sierra.com>
Subject: Re: Newbie R5K questions -- -mips2 vs -mips4; is n32 ABI supported by Linux?
Message-ID: <20031117222940.GA10372@nevyn.them.org>
References: <1069106666.1829.323.camel@powerpuff.evo1.pas.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1069106666.1829.323.camel@powerpuff.evo1.pas.lab>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 17, 2003 at 02:04:26PM -0800, Jeffrey Baitis wrote:
> Hi all:
> 
> I'm currently trying to increase performance on our PMC-Sierra RM5231
> system by taking advantage of the MIPS IV ISA. This processor has a
> 32-bit address bus interface with 64-bit GPRs, so I guess that the
> choice of -mabi=n32 is ideal for this processor.
> 
> Why is it that the Linux kernel defaults to -mcpu=r5000 -mips2 for the
> 52XX? Wouldn't there be good reasons to use the enhancements present in
> the MIPS IV instruction set?
> 
> I've tried modifying the mips Makefile so that the Nevada adds the
> cflags -mabi=n32 -mcpu=r5000 -mips4. I also modified asm/unistd.h so
> that __NR_sigreturn is defined for the case where _MIPS_SIM ==
> _MIPS_SIM_NABI32. Unfortunately, I get link errors: (gcc 3.2.3)
> 
>         arch/mips/kernel/kernel.o(.data+0x4240): undefined reference to
>         `sys_stat64'
>         arch/mips/kernel/kernel.o(.data+0x4244): undefined reference to
>         `sys_lstat64'
>         arch/mips/kernel/kernel.o(.data+0x4248): undefined reference to
>         `sys_fstat64'
>         drivers/ide/idedriver.o(.data.init+0x8): undefined reference to
>         `init_setup_it8172'

Do not even attempt to run an n32 kernel.  Use a 64-bit kernel (you
can't just say -mabi=n64, of course!  See ARCH=mips64 in 2.4 or
CONFIG_MIPS64 in 2.6).

> The goal is that I want to be able to execute MIPS IV or MIPS III
> instructions in user mode, since the profiling program that I'm using is
> based in userspace and does not measure kernel performance. I already
> have measured performance using MIPS I binaries. Under a -mips1-compiled
> uClibc/busybox root filesystem, I tried executing -mips2, -mips3, and
> -mips4 binaries -- but it seemed that the ELF interpreter was unable to
> recognize them as valid ELF files (resulting in a shell 'Syntax Error').
> 
> After doing some digging, I found some documentation on SGI's website
> about different ABI levels:
> 
> http://www.parallab.uib.no/SGI_bookshelves/SGI_Developer/books/MproCplrDbx_TG/sgi_html/ch06.html#Z70233
> 
> Here, I read that the OS, my libraries, and, of course, the application
> must support the ABI of my choice. So, this takes me to my second
> question: does Linux support the n32 ABI? How do I enable this support,
> so that it is possible to take advantage of MIPS IV instructions?

Currently, the tools are just beginning to support n32 and n64 user
programs.  No released version of binutils, gcc, or glibc contains the
support.  Current CVS versions may or may not.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
