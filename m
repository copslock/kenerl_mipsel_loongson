Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Mar 2007 17:40:21 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:36278 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022652AbXCYQkT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 25 Mar 2007 17:40:19 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2PGeCcp011897;
	Sun, 25 Mar 2007 17:40:13 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2PGe8ee011896;
	Sun, 25 Mar 2007 17:40:08 +0100
Date:	Sun, 25 Mar 2007 17:40:08 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	kumba@gentoo.org, linux-mips@linux-mips.org, ths@networkno.de,
	vagabon.xyz@gmail.com
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
Message-ID: <20070325164008.GA29334@linux-mips.org>
References: <20070324.234727.25910303.anemo@mba.ocn.ne.jp> <20070324231602.GP2311@networkno.de> <46062400.8080307@gentoo.org> <20070326.011000.75185255.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070326.011000.75185255.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 26, 2007 at 01:10:00AM +0900, Atsushi Nemoto wrote:

> On Sun, 25 Mar 2007 03:25:52 -0400, Kumba <kumba@gentoo.org> wrote:
> > Going on this, I propose the following patch to fix our lovely SGI/Cobalt 
> > systems, and eliminate a confusing Kconfig option whose time is likely long 
> > since passed.  The attached patch achieves the following:
> > 
> > * Introduces a new flag for IP22, IP32, and Cobalt called 'kernel_loads_in_ckseg0'.
> > * Introduces a new header, mem-layout.h, in include/asm-mips/mach-<platform>/ 
> > for this flag for these three systems, and a dummy entry for mach-generic, 
> > calling it in where appropriate.
> > * Removes CONFIG_BUILD_ELF64 from Kconfig, Makefile, and several defconfigs, and 
> > replaces its few references in header files with 'kernel_loads_in_ckseg0', with 
> > appropriate flips in logic (except in stackframe.h).
> > * Includes Frank's patch to eliminate the need for -mno-explicit-relocs.
> > * Moves -msym32 calling to the Makefile locations for the three machines that 
> > actually need it.
> 
> I can not see why you handle IP22, IP32, Cobalt as so "special".
> There are many other platforms which supports 64-bit and uses CKSEG0
> load address (well, actually all 64-bit platforms except for IP27).

Note IP27 works fine either way and the code size difference is considerable:
Here are numbers for ip27_defconfig with gcc 4.1.2 and binutils 2.17:

   text    data     bss     dec     hex filename
3397944  415768  256816 4070528  3e1c80 vmlinux BUILD_ELF64=n
3774968  415768  248624 4439360  43bd40 vmlinux BUILD_ELF64=y

> So I think Franck's approach, which enables -msym32 and defines
> KBUILD_64BIT_SYM32 automatically if load-y was CKSEG0, is better.  Are
> there any problem with his patchset?

Alot more platforms could make use of this approach; the kernel size savings
are considerable.

The worst thing about CONFIG_BUILD_ELF64 is that it's interactivly available
so making it easy for the user to choose suboptimal value or one that
does not work at all, so it must become unavailable from Kconfig.

  Ralf
