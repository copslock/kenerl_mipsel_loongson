Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA1GrtU14508
	for linux-mips-outgoing; Thu, 1 Nov 2001 08:53:55 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA1Gro014504
	for <linux-mips@oss.sgi.com>; Thu, 1 Nov 2001 08:53:50 -0800
Received: from drow by nevyn.them.org with local (Exim 3.32 #1 (Debian))
	id 15zL67-0008Ja-00; Thu, 01 Nov 2001 11:53:43 -0500
Date: Thu, 1 Nov 2001 11:53:43 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "Steven J. Hill" <sjhill@cotw.com>
Cc: gdb@sources.redhat.com, linux-mips@oss.sgi.com
Subject: Re: Stabs and discarded functions (was Re: Old bug with 'gdb/dbxread.c' and screwed up MIPS symbolic debugging...)
Message-ID: <20011101115343.A31822@nevyn.them.org>
Mail-Followup-To: "Steven J. Hill" <sjhill@cotw.com>,
	gdb@sources.redhat.com, linux-mips@oss.sgi.com
References: <3BDF7F79.6050205@cygnus.com> <3BE02E31.3B2CA5FC@cotw.com> <20011031113208.A1882@nevyn.them.org> <3BE03ECD.5060904@cygnus.com> <20011031174749.A28985@nevyn.them.org> <3BE182FB.2B8D8F8B@cotw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BE182FB.2B8D8F8B@cotw.com>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Nov 01, 2001 at 11:14:35AM -0600, Steven J. Hill wrote:
>    GNU gdb 2001-11-01-cvs
>    Copyright 2001 Free Software Foundation, Inc.
>    GDB is free software, covered by the GNU General Public License, and you are
>    welcome to change it and/or distribute copies of it under certain conditions.
>    Type "show copying" to see the conditions.
>    There is absolutely no warranty for GDB.  Type "show warranty" for details.
>    This GDB was configured as "--host=i686-pc-linux-gnu
> --target=mips-linux-elf"...
>    (gdb) target remote /dev/ttyS1
>    Remote debugging using /dev/ttyS1
>    0x80012c88 in breakinst () at gdb-stub.c:907
>    907             __asm__ __volatile__("
>    (gdb) bt
>    #0  0x80012c88 in breakinst () at gdb-stub.c:907
>    #1  0x8020aabc in brcm_irq_setup () at irq.c:421
>    #2  0x8020aaf0 in init_IRQ () at irq.c:434
>    #3  0x801fc83c in start_kernel () at init/main.c:524
>    #4  0x801fd6f8 in init_arch (argc=160, argv=0xb3000000, envp=0x2, 
>        prom_vec=0xbf) at setup.c:425
>    (gdb) c
>    Continuing.
> 
>    Program received signal SIGTRAP, Trace/breakpoint trap.
>    0x80012c88 in breakinst () at gdb-stub.c:907

... I wonder why you get a second SIGTRAP.  Never happens to me.  Quirk
of your hardware?

>    907             __asm__ __volatile__("
>    (gdb) bt
>    #0  0x80012c88 in breakinst () at gdb-stub.c:907
>    #1  0x8001a554 in sys_create_module (name_user=0x10001dc8 "brcmdrv", 
>        size=713264) at module.c:305
>    (gdb) c
>    Continuing.
> 
> So, it would seem according to you and Keith, we have a linker bug that
> is specific to MIPS and other architectures that do not use PC relative
> branches that needs to be resolved?

No, I think that what Keith was saying described a worse side effect of
the removed sections.  I've no idea why this doesn't manifest on other
platforms.

So can we work around this in GDB, or can we get the .stabs removed? 
Does ld edit the .stabs?  I'll enquire over on that list.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
