Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f34MDiO02093
	for linux-mips-outgoing; Wed, 4 Apr 2001 15:13:44 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f34MDeM02086;
	Wed, 4 Apr 2001 15:13:40 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 2DCAD7F8; Thu,  5 Apr 2001 00:13:38 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 4DD5AEE86; Thu,  5 Apr 2001 00:13:29 +0200 (CEST)
Date: Thu, 5 Apr 2001 00:13:29 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: [FIX] sysmips(MIPS_ATMIC_SET, ...) ret_from_sys_call vs. o32_ret_from_sys_call
Message-ID: <20010405001329.G1221@paradigm.rfc822.org>
References: <20010124163048.B15348@paradigm.rfc822.org> <20010124165919.C15348@paradigm.rfc822.org> <20010125165530.B12576@paradigm.rfc822.org> <3A70705C.5020600@redhat.com> <3A707FFB.60802@redhat.com> <20010125141952.C2311@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010125141952.C2311@bacchus.dhis.org>; from ralf@oss.sgi.com on Thu, Jan 25, 2001 at 02:19:52PM -0800
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jan 25, 2001 at 02:19:52PM -0800, Ralf Baechle wrote:
> It's more:
> 
> sysmips(MIPS_ATOMIC_SET, ptr, val)
> {
> 	result = *ptr;
> 	*ptr = val;
> 
> 	return result;
> }

If thats the case - shouldnt the attached patch fix the sysmips stuff ?
I stumbled once again over sysmips - To get a MIPS ISA I compatible
glibc 2.2.2 you need to compile it with sysmips(MIPS_ATOMIC_SET, ...)
which breaks badly with "Illegal Instruction" on current cvs kernels.


Index: arch/mips/kernel/sysmips.c
===================================================================
RCS file: /cvs/linux/arch/mips/kernel/sysmips.c,v
retrieving revision 1.17
diff -u -r1.17 sysmips.c
--- arch/mips/kernel/sysmips.c	2001/02/09 21:05:46	1.17
+++ arch/mips/kernel/sysmips.c	2001/04/04 22:09:18
@@ -75,7 +75,6 @@
 	}
 
 	case MIPS_ATOMIC_SET: {
-		unsigned int tmp;
 
 		p = (int *) arg1;
 		errno = verify_area(VERIFY_WRITE, p, sizeof(*p));
@@ -98,7 +97,7 @@
 			".word\t1b, 3b\n\t"
 			".word\t2b, 3b\n\t"
 			".previous\n\t"
-			: "=&r" (tmp), "=o" (* (u32 *) p), "=r" (errno)
+			: "=&r" (retval), "=o" (* (u32 *) p), "=r" (errno)
 			: "r" (arg2), "o" (* (u32 *) p), "2" (errno)
 			: "$1");
 
@@ -109,15 +108,7 @@
 		if (current->ptrace & PT_TRACESYS)
 			syscall_trace();
 
-		((struct pt_regs *)&cmd)->regs[2] = tmp;
-		((struct pt_regs *)&cmd)->regs[7] = 0;
-
-		__asm__ __volatile__(
-			"move\t$29, %0\n\t"
-			"j\to32_ret_from_sys_call"
-			: /* No outputs */
-			: "r" (&cmd));
-		/* Unreached */
+		goto out;
 	}
 
 	case MIPS_FIXADE:


What makes me wonder is that we try to return -EFAULT and stuff
which then limits the values for MIPS_ATOMIC_SET to positive ints. 
I dont think this is correct.

Comments ?

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
