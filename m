Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g478kxwJ004510
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 7 May 2002 01:46:59 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g478kxl1004509
	for linux-mips-outgoing; Tue, 7 May 2002 01:46:59 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g478kiwJ004504;
	Tue, 7 May 2002 01:46:44 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id BAA08698;
	Tue, 7 May 2002 01:48:00 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id BAA26276;
	Tue, 7 May 2002 01:47:57 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g478lub14619;
	Tue, 7 May 2002 10:47:57 +0200 (MEST)
Message-ID: <3CD794BC.43264E9E@mips.com>
Date: Tue, 07 May 2002 10:47:56 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: Jun Sun <jsun@mvista.com>, linux-mips <linux-mips@oss.sgi.com>
Subject: Re: what is the right behavior of copy_to_user(0x0, ..., ...)?
References: <3CD3052B.1050400@mvista.com> <20020503162337.A27366@dea.linux-mips.net> <3CD32044.9040109@mvista.com> <20020503184000.A1238@dea.linux-mips.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:

> On Fri, May 03, 2002 at 04:41:56PM -0700, Jun Sun wrote:
>
> > It appears earlier version of kernel does not have this problem.  I have not
> > fully figured out why.
>
> We didn't handle exceptions in branch delay slots.  Try this patch and
> tell me if it helps.

It fix a problem I have had for quite a while in the r4k_fpu.S. The code in
question is:
        jr      ra
        .set    nomacro
         EX(sw  t0,SC_FPC_EIR(a0))
        .set    macro

I have fixed it locally by removing the SW from the delay-slot, but obviously
your fix is the right one.
But I guess we need the same fix in arch/mips/kernel/unaligned.c.


>
>   Ralf
>
> Index: arch/mips/mm/fault.c
> ===================================================================
> RCS file: /home/pub/cvs/linux/arch/mips/mm/fault.c,v
> retrieving revision 1.25.2.2
> diff -u -r1.25.2.2 fault.c
> --- arch/mips/mm/fault.c        16 Jan 2002 03:49:24 -0000      1.25.2.2
> +++ arch/mips/mm/fault.c        4 May 2002 01:28:34 -0000
> @@ -19,6 +19,7 @@
>  #include <linux/smp_lock.h>
>  #include <linux/version.h>
>
> +#include <asm/branch.h>
>  #include <asm/hardirq.h>
>  #include <asm/pgalloc.h>
>  #include <asm/mmu_context.h>
> @@ -77,7 +78,7 @@
>         struct vm_area_struct * vma;
>         struct task_struct *tsk = current;
>         struct mm_struct *mm = tsk->mm;
> -       unsigned long fixup;
> +       unsigned long epc, fixup;
>         siginfo_t info;
>
>         /*
> @@ -181,7 +182,8 @@
>
>  no_context:
>         /* Are we prepared to handle this kernel fault?  */
> -       fixup = search_exception_table(regs->cp0_epc);
> +       epc = regs->cp0_epc + delay_slot(regs) ? 4 : 0;
> +       fixup = search_exception_table(epc);
>         if (fixup) {
>                 long new_epc;
>
> Index: arch/mips64/mm/fault.c
> ===================================================================
> RCS file: /home/pub/cvs/linux/arch/mips64/mm/fault.c,v
> retrieving revision 1.26.2.6
> diff -u -r1.26.2.6 fault.c
> --- arch/mips64/mm/fault.c      23 Feb 2002 02:16:42 -0000      1.26.2.6
> +++ arch/mips64/mm/fault.c      4 May 2002 01:28:34 -0000
> @@ -21,6 +21,7 @@
>  #include <linux/smp_lock.h>
>  #include <linux/version.h>
>
> +#include <asm/branch.h>
>  #include <asm/hardirq.h>
>  #include <asm/pgalloc.h>
>  #include <asm/mmu_context.h>
> @@ -103,7 +104,7 @@
>         struct vm_area_struct * vma;
>         struct task_struct *tsk = current;
>         struct mm_struct *mm = tsk->mm;
> -       unsigned long fixup;
> +       unsigned long epc, fixup;
>         siginfo_t info;
>
>  #if 0
> @@ -208,7 +209,8 @@
>
>  no_context:
>         /* Are we prepared to handle this kernel fault?  */
> -       fixup = search_exception_table(regs->cp0_epc);
> +       epc = regs->cp0_epc + delay_slot(regs) ? 4 : 0;
> +       fixup = search_exception_table(epc);
>         if (fixup) {
>                 long new_epc;
>

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
