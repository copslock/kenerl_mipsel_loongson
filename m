Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3KJ75003602
	for linux-mips-outgoing; Fri, 20 Apr 2001 12:07:05 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3KJ71M03595;
	Fri, 20 Apr 2001 12:07:01 -0700
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f3KJ2b003145;
	Fri, 20 Apr 2001 12:02:37 -0700
Message-ID: <3AE0885F.D1A3D26@mvista.com>
Date: Fri, 20 Apr 2001 12:05:03 -0700
From: Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en, bg
MIME-Version: 1.0
To: Florian Lohoff <flo@rfc822.org>
CC: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: Illegal instruction - a workaround or fix ?
References: <20010311191639.A8587@paradigm.rfc822.org> <20010312122134.B1235@bacchus.dhis.org> <20010312144131.C7715@paradigm.rfc822.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Florian Lohoff wrote:
> 
> On Mon, Mar 12, 2001 at 12:21:34PM +0100, Ralf Baechle wrote:
> > Thanks, that was the hint I needed.  o32_ret_from_sys_call expects the
> > content of s-registers to be unchanged from userspace but sys_sysmips
> > clobbers them.
> >
> > Below a patch from the famous ``Smoke This, It's Good For You (TM)''
> > series.  Lemme know if it helps.
> 
> As mentioned on IRC - This "Oopses" for me ...

I'm bringing this up again because none of the related patches on this
topic have been applied to the latest cvs kernel.  The patch Florian
refers to above oopses for me as well.  This patch below, from Florian,
but updated against the latest cvs kernel, works (at least the few
simple tests I've run do work now).  

--- arch/mips/kernel/sysmips.c.old      Fri Apr 20 11:58:38 2001
+++ arch/mips/kernel/sysmips.c  Fri Apr 20 11:59:59 2001
@@ -99,7 +99,7 @@
                        ".word\t1b, 3b\n\t"
                        ".word\t2b, 3b\n\t"
                        ".previous\n\t"
-                       : "=&r" (tmp), "=o" (* (u32 *) p), "=r" (errno)
+                       : "=&r" (retval), "=o" (* (u32 *) p), "=r"
(errno)
                        : "r" (arg2), "o" (* (u32 *) p), "2" (errno)
                        : "$1");
 
@@ -110,14 +110,7 @@
                if (current->ptrace & PT_TRACESYS)
                        syscall_trace();
 
-               ((struct pt_regs *)&cmd)->regs[2] = tmp;
-               ((struct pt_regs *)&cmd)->regs[7] = 0;
-
-               __asm__ __volatile__(
-                       "move\t$29, %0\n\t"
-                       "j\to32_ret_from_sys_call"
-                       : /* No outputs */
-                       : "r" (&cmd));
+               goto out;
                /* Unreached */
 #else
        printk("sys_sysmips(MIPS_ATOMIC_SET, ...) not ready for
!CONFIG_CPU_HAS_LLSC\n");
