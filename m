Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Sep 2002 18:40:39 +0200 (CEST)
Received: from buserror-extern.convergence.de ([212.84.236.66]:4613 "EHLO hell")
	by linux-mips.org with ESMTP id <S1122987AbSIPQki>;
	Mon, 16 Sep 2002 18:40:38 +0200
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 17qyvK-0003HG-00
	for <linux-mips@linux-mips.org>; Mon, 16 Sep 2002 18:40:34 +0200
Date: Mon, 16 Sep 2002 18:40:34 +0200
From: Johannes Stezenbach <js@convergence.de>
To: linux-mips@linux-mips.org
Subject: Once again: test_and_set for CPUs w/o LL/SC
Message-ID: <20020916164034.GA12489@convergence.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <js@convergence.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 192
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@convergence.de
Precedence: bulk
X-list: linux-mips


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

the thread with subject "LL/SC benchmarking" in mid July
died away, since I was busy doing more pressing things.

To refresh your memory:
The NEC VR41xx CPU has no LL/SC instructions, so they must
be emulated by the kernel, which slows down the test-and-set
and compare-and-swap operations (used by linux-threads)
considerably. For the VR41xx (and other CPUs which have
branch-likely instructions), there exisits a workaround
which enables userspace-only atomic operations, with minor
help from the kernel: The kernel must guarantee that register
k1 is not equal to some magic value after every transition
to userspace.

Two things were left open in July:
- find out the minimal amount of changes to the kernel
  to guarantee k1 != MAGIC after eret
- determine how to tell glibc to use the branch-likely
  workaround instead of emulated LL/SC

I looked through the kernel code, and I think that
arch/mips/mm/tlbex-r4k.S always leaves the last value
from CP0_ENTRYLO in k1, thus bit 31 of k1 is guarateed
to be zero.
The other interrupt and exception handlers seem to
be too complex to make any guarantees about the value left
in k1, so I added a 'move k1,$0' to RESTORE_SP_AND_RET
in include/asm-mips/stackframe.h, and conditionalized
it via CONFIG_MIPS_USERSPACE_ATOMIC_OPS.

To tell glibc about the support for the branch-likely
workaround I added a sysctl.

A few things:
- I couldn't come up with a better name for the config
  option and sysctl.
- If glibc were to use sysctl(2) to query for
  mips_userspace_atomic_ops, glibc would depend on
  linux/sysctl.h from the very newest kernel, which
  is bad; maybe glibc should just query for exisitence
  of the file /proc/sys/kernel/mips_userspace_atomic_ops?
  Or maybe we should just add a /proc/foobar instead
  of a sysctl?
- Maybe I should add some comments to tlbex-r4k.S so
  no-one accidentally breaks the k1 < 0x80000000 assertion?


Please comment on the appended patch.
If we could agree the kernel support for this, I would
prepare a matching glibc patch.


Regards,
Johannes

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-oss-nollsc.patch"

Index: Documentation/Configure.help
===================================================================
RCS file: /cvs/linux/Documentation/Attic/Configure.help,v
retrieving revision 1.109.2.8
diff -a -u -r1.109.2.8 Configure.help
--- Documentation/Configure.help	2002/09/11 12:44:23	1.109.2.8
+++ Documentation/Configure.help	2002/09/16 14:39:29
@@ -2337,6 +2337,20 @@
   for better performance, N if you don't know.  You must say Y here
   for multiprocessor machines.
 
+Support userspace atomic ops for MIPS2 CPUs
+CONFIG_MIPS_USERSPACE_ATOMIC_OPS
+  Say Y here if your CPU supports the MIPS2 ISA (i.e. it has
+  support for the "branch likely" instructions), but does not
+  have the LL and SC instructions which normally are required for
+  userspace atomic operations, e.g. for the NEC VR41xx CPUs.
+  Selecting this option guarantees that the value of the k1 register,
+  which is normally reserved for the kernel, is lower than
+  0x80000000 after any transition from kernel to userspace. It
+  also sets the read-only sysctl kernel.mips_userspace_atomic_ops to
+  the value "1", so that libc/libpthread can detect kernel support for
+  a fast test-and-set implementation for this kind of CPU (instead
+  of LL/SC emulation). If in doubt, say N.
+
 lld and scd instructions available
 CONFIG_CPU_HAS_LLDSCD
   Say Y here if your CPU has the lld and scd instructions, the 64-bit
Index: arch/mips/config-shared.in
===================================================================
RCS file: /cvs/linux/arch/mips/config-shared.in,v
retrieving revision 1.1.2.18
diff -a -u -r1.1.2.18 config-shared.in
--- arch/mips/config-shared.in	2002/09/11 12:44:28	1.1.2.18
+++ arch/mips/config-shared.in	2002/09/16 14:39:31
@@ -513,6 +513,9 @@
 dep_bool 'Override CPU Options' CONFIG_CPU_ADVANCED $CONFIG_MIPS32
 if [ "$CONFIG_CPU_ADVANCED" = "y" ]; then
    bool '  ll/sc Instructions available' CONFIG_CPU_HAS_LLSC
+   if [ "$CONFIG_CPU_HAS_LLSC" = "n" ]; then
+      bool '    Support userspace atomic ops for MIPS2 CPUs' CONFIG_MIPS_USERSPACE_ATOMIC_OPS
+   fi
    bool '  lld/scd Instructions available' CONFIG_CPU_HAS_LLDSCD
    bool '  Writeback Buffer available' CONFIG_CPU_HAS_WB
 else
@@ -528,6 +531,11 @@
 	 define_bool CONFIG_CPU_HAS_LLDSCD n
 	 define_bool CONFIG_CPU_HAS_WB n
       fi
+      if [ "$CONFIG_CPU_VR41XX" = "y" ]; then
+         define_bool CONFIG_MIPS_USERSPACE_ATOMIC_OPS y
+      else
+         define_bool CONFIG_MIPS_USERSPACE_ATOMIC_OPS n
+      fi
    else
       if [ "$CONFIG_CPU_MIPS32" = "y" ]; then
 	 define_bool CONFIG_CPU_HAS_LLSC y
@@ -538,6 +546,7 @@
 	 define_bool CONFIG_CPU_HAS_LLDSCD y
 	 define_bool CONFIG_CPU_HAS_WB n
       fi
+      define_bool CONFIG_MIPS_USERSPACE_ATOMIC_OPS n
    fi
 fi
 if [ "$CONFIG_CPU_R3000" = "y" ]; then
Index: include/asm-mips/stackframe.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/stackframe.h,v
retrieving revision 1.18.2.2
diff -a -u -r1.18.2.2 stackframe.h
--- include/asm-mips/stackframe.h	2002/08/05 23:53:37	1.18.2.2
+++ include/asm-mips/stackframe.h	2002/09/16 14:39:35
@@ -201,8 +201,15 @@
 		lw	$3,  PT_R3(sp);                  \
 		lw	$2,  PT_R2(sp)
 
+#ifdef CONFIG_MIPS_USERSPACE_ATOMIC_OPS
+#define CLEAR_K1 move k1,$0;
+#else
+#define CLEAR_K1
+#endif
+
 #define RESTORE_SP_AND_RET                               \
 		lw	sp,  PT_R29(sp);                 \
+		CLEAR_K1                                 \
 		.set	mips3;				 \
 		eret;					 \
 		.set	mips0
Index: include/linux/sysctl.h
===================================================================
RCS file: /cvs/linux/include/linux/sysctl.h,v
retrieving revision 1.44.2.3
diff -a -u -r1.44.2.3 sysctl.h
--- include/linux/sysctl.h	2002/09/11 12:45:40	1.44.2.3
+++ include/linux/sysctl.h	2002/09/16 14:39:35
@@ -124,6 +124,7 @@
 	KERN_CORE_USES_PID=52,		/* int: use core or core.%pid */
 	KERN_TAINTED=53,	/* int: various kernel tainted flags */
 	KERN_CADPID=54,		/* int: PID of the process to notify on CAD */
+	KERN_MIPS_USERSPACE_ATOMIC_OPS=55, /* int: kernel supports atomicity w/o LL/SC */
 };
 
 
Index: kernel/sysctl.c
===================================================================
RCS file: /cvs/linux/kernel/sysctl.c,v
retrieving revision 1.46.2.4
diff -a -u -r1.46.2.4 sysctl.c
--- kernel/sysctl.c	2002/09/10 15:32:56	1.46.2.4
+++ kernel/sysctl.c	2002/09/16 14:39:36
@@ -96,6 +96,10 @@
 extern int acct_parm[];
 #endif
 
+#ifdef CONFIG_MIPS_USERSPACE_ATOMIC_OPS
+static int mips_userspace_atomic_ops = 1;
+#endif
+
 extern int pgt_cache_water[];
 
 static int parse_table(int *, int, void *, size_t *, void *, size_t,
@@ -255,6 +259,10 @@
 #endif
 	{KERN_S390_USER_DEBUG_LOGGING,"userprocess_debug",
 	 &sysctl_userprocess_debug,sizeof(int),0644,NULL,&proc_dointvec},
+#endif
+#ifdef CONFIG_MIPS_USERSPACE_ATOMIC_OPS
+	{KERN_MIPS_USERSPACE_ATOMIC_OPS, "mips_userspace_atomic_ops",
+	 &mips_userspace_atomic_ops, sizeof(int), 0444, NULL, &proc_dointvec},
 #endif
 	{0}
 };

--FCuugMFkClbJLl1L--
