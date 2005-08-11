Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Aug 2005 18:38:04 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:52237 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225323AbVHKRh2>; Thu, 11 Aug 2005 18:37:28 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j7BHfTS8028117;
	Thu, 11 Aug 2005 18:41:29 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j7BHfSLC028111;
	Thu, 11 Aug 2005 18:41:28 +0100
Date:	Thu, 11 Aug 2005 18:41:28 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Danny Home Educator <dannyhsdad@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: QEMU and mips linux
Message-ID: <20050811174128.GA31760@linux-mips.org>
References: <1634a4f105081110194fe8603d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634a4f105081110194fe8603d@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Aug 11, 2005 at 12:19:08PM -0500, Danny Home Educator wrote:

> I've gotten the binutils and gcc per chain tools directions (except for 
> mips-unknown-linux-gnu i.e., 32 bit version of the compiler, etc.) and built 
> my own mips cross compiler (I'm on Linux/x86). Then I got the kernel source 
> from CVS and in the make menuconfig, all I did was change the machine 
> selection to be QEMU and CPU selection to be R4x00.
> 
> Then I hand edited the .config to enable CONFIG_CROSSCOMPILE and then I 
> built the kernel:
> 
> make CROSS_COMPILE=mips-unknown-linux-gnu-
> 
> And then I got compile failure with:
> 
> LD init/built-in.o
> LD .tmp_vmlinux1
> arch/mips/kernel/built-in.o: In function `show_cpuinfo':
> proc.c:(.text+0x9c88): undefined reference to `get_system_type'
> proc.c:(.text+0x9c88): relocation truncated to fit: R_MIPS_26 against 
> `get_system_type'
> make: *** [.tmp_vmlinux1] Error 1
> 
> 
> I then edited arch/mips/qemu/q-setup.c to add:
> 
> 9,14d8
> < const char *get_system_type(void)
> < {
> < return "QEMU MIPS";
> < }
> <
> <

My bad.  I've so far compiled it with procfs disabled.  Will fix.

> And I was able to build vmlinux. I've gotten qemu-0.7.1, created blank 
> bios.bin file and when I try to run it, I get:
> 
> % qemu-system-mips -kernel vmlinux -m 16 -nographic
> (qemu) mips_r4k_init: start
> mips_r4k_init: load BIOS '/usr/local/share/qemu/mips_bios.bin' size 131072
> 
> And hangs there.
> 
> Has anyone else tried qemu with the latest mips linux? Thanks.

You need to enable serial console and add -append console=ttyS0 to the
Qemu options.  That all won't help you too much because the emulator will
hang on the first instruction in user mode.

  Ralf
