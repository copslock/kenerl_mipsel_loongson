Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2003 01:26:20 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:33011 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225531AbTJVA0R>;
	Wed, 22 Oct 2003 01:26:17 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id RAA15707;
	Tue, 21 Oct 2003 17:22:14 -0700
Subject: Re: Au1500 kernel?
From: Pete Popov <ppopov@mvista.com>
To: Greg Herlein <gherlein@herlein.com>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <Pine.LNX.4.44.0310211348290.3164-200000@io.herlein.com>
References: <Pine.LNX.4.44.0310211348290.3164-200000@io.herlein.com>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1066782264.21027.164.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 21 Oct 2003 17:24:24 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, 2003-10-21 at 14:53, Greg Herlein wrote:
> I grabbed the latest CVS code from linux-mips.org (2.6.0-test8) 
> and tried to compile it with my cross-comiler environment - which 
> is the toolchain that came with my Pb1500 development board that 
> uses the Au1500 SOC chip.  My gcc is:
> 
> [gherlein@io linux]$ 
> /usr/local/comp/mips-elf/gcc-3.2/bin/mips-elf-gcc -v
> Reading specs from 
> /usr/local/comp/mips-elf/gcc-3.2/lib/gcc-lib/mips-elf/3.2/specs
> Configured with: ../gcc-3.2/configure --target=mips-elf 
> --with-gnu-as --with-gnu-ld --with-newlib 
> --prefix=/usr/local/comp/mips-elf/gcc-3.2 
> --enable-languages=c,c++
> Thread model: single
> gcc version 3.2
> 
> But the lernel is failing at:
> 
>   CC      arch/mips/kernel/offset.s
> In file included from include/linux/signal.h:7,
>                  from include/linux/sched.h:25,
>                  from arch/mips/kernel/offset.c:13:
> include/asm/siginfo.h:83: flexible array member not at end of 
> struct
> make[1]: *** [arch/mips/kernel/offset.s] Error 1
> make: *** [arch/mips/kernel/offset.s] Error 2
> 
> which smells like some new gcc'ism that is causing the issue.  Is 
> anyone else seeing this?  Is there something I am doing wrong? 
> Advice?  Suggestions?

I think I had the same problem, if I remember correctly, so I used the
2.95 compiler on linux-mips.org.

BTW, only serial console, ethernet, and MTD have been updated in 2.6. I
haven't had time for anything else yet, including the 36 bit address
support.

Pete
