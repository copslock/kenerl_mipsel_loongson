Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA1GOKR14015
	for linux-mips-outgoing; Thu, 1 Nov 2001 08:24:20 -0800
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA1GOD013967
	for <linux-mips@oss.sgi.com>; Thu, 1 Nov 2001 08:24:13 -0800
Received: from localhost.localdomain ([127.0.0.1] helo=cotw.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 15zKct-0003ga-00; Thu, 01 Nov 2001 10:23:31 -0600
Message-ID: <3BE182FB.2B8D8F8B@cotw.com>
Date: Thu, 01 Nov 2001 11:14:35 -0600
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: gdb@sources.redhat.com, linux-mips@oss.sgi.com
Subject: Re: Stabs and discarded functions (was Re: Old bug with 'gdb/dbxread.c' 
 and screwed up MIPS symbolic debugging...)
References: <3BDF7F79.6050205@cygnus.com> <3BE02E31.3B2CA5FC@cotw.com> <20011031113208.A1882@nevyn.them.org> <3BE03ECD.5060904@cygnus.com> <20011031174749.A28985@nevyn.them.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Daniel Jacobowitz wrote:

[snip]

> So it looks like binutils did not relocate the stabs for .text.exit properly.
> 
> Why?  It's pretty simple; there was nothing to relocate it to.  From the
> kernel's linker script:
> 
>   /* Sections to be discarded */
>   /DISCARD/ :
>   {
>         *(.text.exit)
>         *(.data.exit)
>         *(.exitcall.exit)
>   }
> 
> So instead of the subtle error we get in objfiles containing multiple
> sections, which we'll still need to deal with for the kernel for
> .text.init, we have a completely bogus result.
> 
> We need to discard the stabs records for discarded symbols.  Of course,
> we're just reading the psymtab in when we get here.  We don't have
> symbols yet.  We could do this by a second pass after reading, instead
> of the hack with textlow, but that's gross.
> 
> This makes it impossible to debug at least MIPS kernels with stabs and
> gdb, so I very much want to fix it.  I'm not sure how this works on
> x86, but I'd guess it had to do with differences in relocation types.
> Anyone have an example handy?
> 
> Meanwhile, Steven, as a quick hack - try removing the /DISCARD/ bit
> from your linker script and relinking.  What happens?  Does everything
> else seem to work?
> 
Success! Yes, leaving those sections in allows for the debugger to work
properly. Here is output from a fresh gdb checked out of cvs this morning:

   GNU gdb 2001-11-01-cvs
   Copyright 2001 Free Software Foundation, Inc.
   GDB is free software, covered by the GNU General Public License, and you are
   welcome to change it and/or distribute copies of it under certain conditions.
   Type "show copying" to see the conditions.
   There is absolutely no warranty for GDB.  Type "show warranty" for details.
   This GDB was configured as "--host=i686-pc-linux-gnu
--target=mips-linux-elf"...
   (gdb) target remote /dev/ttyS1
   Remote debugging using /dev/ttyS1
   0x80012c88 in breakinst () at gdb-stub.c:907
   907             __asm__ __volatile__("
   (gdb) bt
   #0  0x80012c88 in breakinst () at gdb-stub.c:907
   #1  0x8020aabc in brcm_irq_setup () at irq.c:421
   #2  0x8020aaf0 in init_IRQ () at irq.c:434
   #3  0x801fc83c in start_kernel () at init/main.c:524
   #4  0x801fd6f8 in init_arch (argc=160, argv=0xb3000000, envp=0x2, 
       prom_vec=0xbf) at setup.c:425
   (gdb) c
   Continuing.

   Program received signal SIGTRAP, Trace/breakpoint trap.
   0x80012c88 in breakinst () at gdb-stub.c:907
   907             __asm__ __volatile__("
   (gdb) bt
   #0  0x80012c88 in breakinst () at gdb-stub.c:907
   #1  0x8001a554 in sys_create_module (name_user=0x10001dc8 "brcmdrv", 
       size=713264) at module.c:305
   (gdb) c
   Continuing.

So, it would seem according to you and Keith, we have a linker bug that
is specific to MIPS and other architectures that do not use PC relative
branches that needs to be resolved?

I also tried a fresh checkout of the insight debugger from cvs this
morning and it works great too. Thanks for the interim solution.  I
would like to be copied on remaining discussions including the design
of the fix/patch. Thank you everyone.

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer
