Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2005 15:57:15 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:28182 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225326AbVHaO45>; Wed, 31 Aug 2005 15:56:57 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j7VF2ues007079;
	Wed, 31 Aug 2005 16:02:56 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j7VF2upm007078;
	Wed, 31 Aug 2005 16:02:56 +0100
Date:	Wed, 31 Aug 2005 16:02:56 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Damian Dimmich <djd20@kent.ac.uk>
Cc:	linux-mips@linux-mips.org
Subject: Re: compiling kernel 2.6.13
Message-ID: <20050831150256.GC3377@linux-mips.org>
References: <200508311459.47273.djd20@kent.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508311459.47273.djd20@kent.ac.uk>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 31, 2005 at 02:59:46PM +0100, Damian Dimmich wrote:

> I had some trouble compiling 2.6.13 for the mips architecture.  I encountered 
> two errors:
> 
> 1)
> 
> In the file include/asm-mips/thread_info.h TIF_32BIT was undefined.
> 
> I added the following two lines which showed up in parisc and ppc64 's 
> thread-info's.  Don't know if these values are correct or if this actually 
> works.  It just gets it to compile...
> #define TIF_32BIT               5       /* 32 bit binary */
> #define _TIF_32BIT              (1<<TIF_32BIT)
> 
> The error was in drivers/input/evdev.c which includes 
> include/asm-mips/thread_info.h
> 
> The error was:
>  CC [M]  drivers/input/evdev.o
> drivers/input/evdev.c: In function `evdev_write':
> drivers/input/evdev.c:193: error: `TIF_32BIT' undeclared (first use in this 
> function)
> drivers/input/evdev.c:193: error: (Each undeclared identifier is reported only 
> once
> drivers/input/evdev.c:193: error: for each function it appears in.)
> drivers/input/evdev.c: In function `evdev_read':
> drivers/input/evdev.c:254: error: `TIF_32BIT' undeclared (first use in this 
> function)

That driver's 32-bit compatibility is totally broken, I'm afraid.  It'll
be easy to kludge though ...

> 2)
> 
> When linking .tmp_vmlinux1, KSEG1ADDR and KSEG1 where reported as undefined 
> and linking failed. 
>  LD      .tmp_vmlinux1
> arch/mips/sgi-ip22/built-in.o(.text+0x2854): In function `ip22_eisa_intr':
> : undefined reference to `KSEG1ADDR'
> arch/mips/sgi-ip22/built-in.o(.text+0x2864): In function `ip22_eisa_intr':
> : undefined reference to `KSEG1ADDR'
> arch/mips/sgi-ip22/built-in.o(.text+0x2870): In function `ip22_eisa_intr':
> : undefined reference to `KSEG1ADDR'
> arch/mips/sgi-ip22/built-in.o(.text+0x28ac): In function `ip22_eisa_intr':
> : undefined reference to `KSEG1ADDR'
> arch/mips/sgi-ip22/built-in.o(.text+0x28c0): In function `ip22_eisa_intr':
> : undefined reference to `KSEG1ADDR'
> arch/mips/sgi-ip22/built-in.o(.text+0x293c): more undefined references to 
> `KSEG1ADDR' follow
> make: *** [.tmp_vmlinux1] Error 1
> 
> 
> I fixed this by adding the lines:
> #define KSEG1ADDR(a)  (CPHYSADDR(a) | KSEG1)
> #define KSEG1     0xa0000000
> at the top of the file arch/mips/sgi-ip22/ip22-eisa.c
> These are copied from include/asm/addrspace.h
> 
> I found it quite strange that it only failed when linking the kernel and not 
> earlier.  The file asm/addrspace.h is included in ip22-eisa.c
> 
> eisa support is enabled and i'm compiling a 64 bit kernel.

Daring.  Hardly anybody is using EISA on that machine and even less so on
64-bit, expect to find bugs.

> gcc version 3.3.3 (Debian)

Should be a safe choice of compiler.

  Ralf
