Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9VGWIf04606
	for linux-mips-outgoing; Wed, 31 Oct 2001 08:32:18 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9VGW8004602
	for <linux-mips@oss.sgi.com>; Wed, 31 Oct 2001 08:32:08 -0800
Received: from drow by nevyn.them.org with local (Exim 3.32 #1 (Debian))
	id 15yyHg-0000jn-00; Wed, 31 Oct 2001 11:32:08 -0500
Date: Wed, 31 Oct 2001 11:32:08 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "Steven J. Hill" <sjhill@cotw.com>
Cc: gdb@sources.redhat.com, linux-mips@oss.sgi.com
Subject: Re: Old bug with 'gdb/dbxread.c' and screwed up MIPS symbolic debugging...
Message-ID: <20011031113208.A1882@nevyn.them.org>
Mail-Followup-To: "Steven J. Hill" <sjhill@cotw.com>,
	gdb@sources.redhat.com, linux-mips@oss.sgi.com
References: <3BDF7F79.6050205@cygnus.com> <3BE02E31.3B2CA5FC@cotw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BE02E31.3B2CA5FC@cotw.com>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Oct 31, 2001 at 11:00:33AM -0600, Steven J. Hill wrote:
> PROBLEM REPORT
> --------------
> I am using a NEC MIPS VR5432 in little endian and 32-bit mode. If I run
> 'mipsel-linux-objdump -d vmlinux', I get addresses starting with 0x8000XXXX.
> With older toolchains I remember getting 0xffffffff8000XXXX. My kernel boots

Well, the change in objdump output is purely cosmetic.  For 32bit
object formats we just truncate the display now.

> fine and patiently waits for GDB to connect. If I use GDB stock from CVS
> without applying any patches, the following output occurs:
> 
> This GDB was configured as "--host=i686-pc-linux-gnu --target=mips-linux-elf"...
> (gdb) target remote /dev/ttyS1
> Remote debugging using /dev/ttyS1
> 0x80012c88 in breakinst () at 1879
> 1879            sock_unregister(PF_PACKET);
> (gdb) bt
> #0  0x80012c88 in breakinst () at af_packet.c:1879
> #1  0x8020aabc in brcm_irq_setup () at irq.c:421
> #2  0x8020aaf0 in init_IRQ () at irq.c:434
> #3  0x801fc83c in start_kernel () at init/main.c:524
> #4  0x801fd6f8 in init_arch (argc=160, argv=0xb3000000, envp=0x2, 
>     prom_vec=0xbf) at setup.c:425
> (gdb) c
> Continuing.
> 
> Program received signal SIGTRAP, Trace/breakpoint trap.
> 0x80012c88 in breakinst () at af_packet.c:1879
> 1879            sock_unregister(PF_PACKET);
> (gdb) bt
> #0  0x80012c88 in breakinst () at af_packet.c:1879
> #1  0x8001a554 in sys_create_module (name_user=0x10001dc8 "brcmdrv", 
>     size=713264) at module.c:305
> (gdb) c
> Continuing.
> 
> Which is clearly wrong. 'breakinst' is clearly not in that file, but all the
> other symbolics in the backtrace are correct. Then if I go to insert a module,
> 'breakinst' again is decoded at the wrong place, but it gets 'sys_create_module'
> module symbol decoded right. I will point out that 'breakinst' is defined in
> 'arch/mips/kernel/gdb-stub.c' and FWIW, looks like:
> 
>         __asm__ __volatile__("
>                         .globl  breakinst
>                         .set    noreorder
>                         nop
> breakinst:              break
>                         nop
>                         .set    reorder
>         ");
> 

Does this happen for any other symbol than breakinst?  Breakinst is
effectively a function with no debugging info.  That case historically
causes us problems, so we probably missed another need for sign
extension.

> 
> "SOLUTION"
> ----------
> On August 15, H.J. Lu applied a patch to 'gdb/dbxread.c' shown here:
> 
>    diff -urN -x CVS work/gdb/dbxread.c gdb-5.0-08162001/gdb/dbxread.c
>    --- work/gdb/dbxread.c  Tue Oct 30 16:33:33 2001
>    +++ gdb-5.0-08162001/gdb/dbxread.c      Wed Aug 15 00:02:28 2001
>    @@ -951,7 +951,10 @@
>         (intern).n_type = bfd_h_get_8 (abfd, (extern)->e_type);            \
>         (intern).n_strx = bfd_h_get_32 (abfd, (extern)->e_strx);           \
>         (intern).n_desc = bfd_h_get_16 (abfd, (extern)->e_desc);           \
>    -    (intern).n_value = bfd_h_get_32 (abfd, (extern)->e_value);         \
>    +    if (bfd_get_sign_extend_vma
> (abfd))                                       \
>    +      (intern).n_value = bfd_h_get_signed_32 (abfd,
> (extern)->e_value);       \
>    +    else                                                               \
>    +      (intern).n_value = bfd_h_get_32 (abfd, (extern)->e_value);       \
>       }
>  
>     /* Invariant: The symbol pointed to by symbuf_idx is the first one
> 
> If I back out this change, my debug output is "correct", but I no longer
> have the nice line numbers and files decoded for me:

If you back it out, I believe we just give up in confusion :)  This is
int the reading of stabs info.  breakinst has no stabs info, so it's
getting its line info somewhere else.

Please point me at a copy of your kernel binary with debug info, and
I'll look into it.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
