Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Mar 2007 15:45:29 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:47539 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20021479AbXCYOp2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 25 Mar 2007 15:45:28 +0100
Received: from lagash (88-106-169-123.dynamic.dsl.as9105.com [88.106.169.123])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 56F59B84F5;
	Sun, 25 Mar 2007 16:44:52 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1HVTy7-0000ve-Bl; Sun, 25 Mar 2007 15:45:15 +0100
Date:	Sun, 25 Mar 2007 15:45:15 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Kumba <kumba@gentoo.org>
Cc:	Linux MIPS List <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
Message-ID: <20070325144515.GB21439@networkno.de>
References: <4603DA74.70707@gentoo.org> <20070324.002440.93023010.anemo@mba.ocn.ne.jp> <46049BAD.1010705@gentoo.org> <20070324.234727.25910303.anemo@mba.ocn.ne.jp> <20070324231602.GP2311@networkno.de> <46062400.8080307@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46062400.8080307@gentoo.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14671
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Kumba wrote:
> Thiemo Seufer wrote:
> >>The replacement is CONFIG_BUILD_ELF64=n (it adds -msym32 option) +
> >>CONFIG_BOOT_ELF32=y (it adds vmlinux.32 to "all" target).  Not
> >>CONFIG_BUILD_ELF64=y.
> >>
> >>CONFIG_BUILD_ELF64=n enables -msym32 option, which means the kernel
> >>load address should be CKSEG0.
> >
> >This sounds wrong to me, since CONFIG_BUILD_ELF64=n will build a
> >ELF64 kernel (from compiler/linker POV). This tricks people into
> >believing they need no ELF64 capable toolchain for a 64bit kernel.
> >
> >IMO -msym32 should depend on:
> >    ((Compiler can do -msym32)
> >     && (load address is in ckseg0)
> >     && CONFIG_64BIT)
> >
> >which obsoletes the whole CONFIG_BUILD_ELF* stuff.
> >
> >
> >Thiemo
> 
> Going on this, I propose the following patch to fix our lovely SGI/Cobalt 
> systems, and eliminate a confusing Kconfig option whose time is likely long 
> since passed.  The attached patch achieves the following:
> 
> * Introduces a new flag for IP22, IP32, and Cobalt called 
> 'kernel_loads_in_ckseg0'.
> * Introduces a new header, mem-layout.h, in 
> include/asm-mips/mach-<platform>/ for this flag for these three systems, 
> and a dummy entry for mach-generic, calling it in where appropriate.
> * Removes CONFIG_BUILD_ELF64 from Kconfig, Makefile, and several 
> defconfigs, and replaces its few references in header files with 
> 'kernel_loads_in_ckseg0', with appropriate flips in logic (except in 
> stackframe.h).
> * Includes Frank's patch to eliminate the need for -mno-explicit-relocs.

[snip]
> diff -Naurp mipslinux/arch/mips/Makefile mipslinux.ckseg0/arch/mips/Makefile
> --- mipslinux/arch/mips/Makefile	2007-03-17 21:12:06.000000000 -0400
> +++ mipslinux.ckseg0/arch/mips/Makefile	2007-03-25 02:15:22.000000000 -0400
> @@ -60,11 +60,6 @@ vmlinux-32		= vmlinux.32
>  vmlinux-64		= vmlinux
>  
>  cflags-y		+= -mabi=64
> -ifdef CONFIG_BUILD_ELF64
> -cflags-y		+= $(call cc-option,-mno-explicit-relocs)
> -else
> -cflags-y		+= $(call cc-option,-msym32)
> -endif
>  endif

AFAICS this loses -mno-explicit-relocs completely, but it is needed for
all non-ckseg0 CONFIG_64BIT builds.


Thiemo
