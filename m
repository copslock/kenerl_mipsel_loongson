Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA60908 for <linux-archive@neteng.engr.sgi.com>; Sat, 4 Jul 1998 17:33:36 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA39899
	for linux-list;
	Sat, 4 Jul 1998 17:32:53 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA04417
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 4 Jul 1998 17:32:49 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA27802
	for <linux@cthulhu.engr.sgi.com>; Sat, 4 Jul 1998 17:32:45 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-21.uni-koblenz.de [141.26.249.21])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id CAA01247
	for <linux@cthulhu.engr.sgi.com>; Sun, 5 Jul 1998 02:32:36 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id CAA00807;
	Sun, 5 Jul 1998 02:31:29 +0200
Message-ID: <19980705023122.A737@uni-koblenz.de>
Date: Sun, 5 Jul 1998 02:31:22 +0200
To: Mike Shaver <shaver@netscape.com>, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu
Subject: Re: mozilla on the Indy
References: <359A447B.2D25377D@netscape.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=IS0zKkzwUGydFO0o
X-Mailer: Mutt 0.91.1
In-Reply-To: <359A447B.2D25377D@netscape.com>; from Mike Shaver on Wed, Jul 01, 1998 at 10:15:23AM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii

On Wed, Jul 01, 1998 at 10:15:23AM -0400, Mike Shaver wrote:

> I'm also taking donations of gdb.

Look what I've found on my harddisk, I think you must be talking about
this?

Current directory is /home/ralf
GNU gdb 4.17
Copyright 1998 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "mips-unknown-linux-gnu"...
(gdb) break main
Breakpoint 1 at 0x40092c: file c.c, line 5.
(gdb) run
Starting program: /ext/gdb-mips/c
Cannot insert breakpoint -2:
Temporarily disabling shared library breakpoints:
-2

Program received signal SIGTRAP, Trace/breakpoint trap.
0x0 in ?? () from /lib/ld.so.1
(gdb) bt
#0  0x0 in ?? () from /lib/ld.so.1
#1  0x400924 in main () at c.c:4
(gdb)

A patch against the vanilla FSF gdb is appended.  Use it, test it, tell
me what's broken in it.  You'll also need to apply a patch to the
kernel include file <asm/ptrace.h>, it's also appended.  When testing
think of it, it's crude first cut.  Don't expect things to work to
well.

(Somebody interested in bringing the remote kernel debugging support
upto speed again?)

  Ralf

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="gdb-4.17.diff"

diff -urN gdb-4.17.orig/bfd/config.bfd gdb-4.17/bfd/config.bfd
--- gdb-4.17.orig/bfd/config.bfd	Tue Apr 21 00:01:31 1998
+++ gdb-4.17/bfd/config.bfd	Sun Jul  5 00:42:12 1998
@@ -427,11 +427,13 @@
     ;;
   mips*el*-*-linux* | mips*el*-*-openbsd*)
     targ_defvec=bfd_elf32_littlemips_vec
-    targ_selvecs="bfd_elf32_bigmips_vec bfd_elf64_bigmips_vec bfd_elf64_littlemips_vec ecoff_little_vec ecoff_big_vec"
+    #targ_selvecs="bfd_elf32_bigmips_vec bfd_elf64_bigmips_vec bfd_elf64_littlemips_vec ecoff_little_vec ecoff_big_vec"
+    targ_selvecs="bfd_elf32_bigmips_vec ecoff_little_vec ecoff_big_vec"
     ;;
   mips*-*-linux* | mips*-*-openbsd*)
     targ_defvec=bfd_elf32_bigmips_vec
-    targ_selvecs="bfd_elf32_littlemips_vec bfd_elf64_bigmips_vec bfd_elf64_littlemips_vec ecoff_big_vec ecoff_little_vec"
+    #targ_selvecs="bfd_elf32_littlemips_vec bfd_elf64_bigmips_vec bfd_elf64_littlemips_vec ecoff_big_vec ecoff_little_vec"
+    targ_selvecs="bfd_elf32_littlemips_vec ecoff_big_vec ecoff_little_vec"
     ;;
 
   mn10200-*-*)
Binary files gdb-4.17.orig/gdb/.mipslinux-nat.c.swp and gdb-4.17/gdb/.mipslinux-nat.c.swp differ
diff -urN gdb-4.17.orig/gdb/config/mips/mips-linux.mh gdb-4.17/gdb/config/mips/mips-linux.mh
--- gdb-4.17.orig/gdb/config/mips/mips-linux.mh	Thu Jan  1 01:00:00 1970
+++ gdb-4.17/gdb/config/mips/mips-linux.mh	Thu Jul  4 23:55:19 1996
@@ -0,0 +1,8 @@
+# Host: Big-endian MIPS running Linux
+XDEPFILES=
+XM_FILE= xm-linux.h
+NAT_FILE= nm-linux.h
+NATDEPFILES= infptrace.o inftarg.o mipslinux-nat.o corelow.o core-regset.o fork-child.o solib.o
+
+MMALLOC =
+MMALLOC_CFLAGS = -DNO_MMALLOC
diff -urN gdb-4.17.orig/gdb/config/mips/mips-linux.mt gdb-4.17/gdb/config/mips/mips-linux.mt
--- gdb-4.17.orig/gdb/config/mips/mips-linux.mt	Thu Jan  1 01:00:00 1970
+++ gdb-4.17/gdb/config/mips/mips-linux.mt	Thu Jul  4 23:55:19 1996
@@ -0,0 +1,3 @@
+# Target: Big-endian MIPS
+TDEPFILES= mips-tdep.o
+TM_FILE= tm-linux.h
diff -urN gdb-4.17.orig/gdb/config/mips/nm-linux.h gdb-4.17/gdb/config/mips/nm-linux.h
--- gdb-4.17.orig/gdb/config/mips/nm-linux.h	Thu Jan  1 01:00:00 1970
+++ gdb-4.17/gdb/config/mips/nm-linux.h	Thu Jul  4 23:55:19 1996
@@ -0,0 +1,50 @@
+/* Definitions for native support of Linux/MIPS.
+
+Copyright (C) 1996 Free Software Foundation, Inc.
+
+Contributed by David S. Miller (davem@caip.rutgers.edu) at
+Rutgers University CAIP Research Center.
+
+This file is part of GDB.
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation; either version 2 of the License, or
+(at your option) any later version.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program; if not, write to the Free Software
+Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
+
+#define GET_LONGJMP_TARGET(ADDR) get_longjmp_target(ADDR)
+extern int
+get_longjmp_target PARAMS ((CORE_ADDR *));
+
+/* Tell gdb that we can attach and detach other processes */
+#define ATTACH_DETACH
+
+/* ptrace register ``addresses'' are absolute.  */
+
+#define U_REGS_OFFSET 0
+
+#define PTRACE_ARG3_TYPE long
+
+/* ptrace transfers longs */
+
+#define PTRACE_XFER_TYPE long
+
+/* Linux has shared libraries.  */
+
+#define GDB_TARGET_HAS_SHARED_LIBS
+#define SVR4_SHARED_LIBS
+
+#include "solib.h"
+
+/* Wheee, really it is in stdio.h.  */
+
+#define PSIGNAL_IN_SIGNAL_H
diff -urN gdb-4.17.orig/gdb/config/mips/tm-linux.h gdb-4.17/gdb/config/mips/tm-linux.h
--- gdb-4.17.orig/gdb/config/mips/tm-linux.h	Thu Jan  1 01:00:00 1970
+++ gdb-4.17/gdb/config/mips/tm-linux.h	Thu Jul  4 23:55:19 1996
@@ -0,0 +1,93 @@
+/* Definitions to make GDB run on a MIPS box under Linux.  The
+   definitions here are used when the _target_ system is running Linux.
+   Copyright 1996 Free Software Foundation, Inc.
+
+This file is part of GDB.
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation; either version 2 of the License, or
+(at your option) any later version.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program; if not, write to the Free Software
+Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
+
+#ifndef TM_MIPSLINUX_H
+#define TM_MIPSLINUX_H
+
+#include "mips/tm-bigmips.h"
+
+/* Redefine register numbers for Linux. */
+
+#undef NUM_REGS
+#undef REGISTER_NAMES
+#undef FP0_REGNUM
+#undef PC_REGNUM
+#undef PS_REGNUM
+#undef HI_REGNUM
+#undef LO_REGNUM
+#undef CAUSE_REGNUM
+#undef BADVADDR_REGNUM
+#undef FCRCS_REGNUM
+#undef FCRIR_REGNUM
+
+/* Number of machine registers */
+
+#define NUM_REGS 71
+
+/* Initializer for an array of names of registers.
+   There should be NUM_REGS strings in this initializer.  */
+
+#define REGISTER_NAMES 	\
+    {	"zero",	"at",	"v0",	"v1",	"a0",	"a1",	"a2",	"a3", \
+	"t0",	"t1",	"t2",	"t3",	"t4",	"t5",	"t6",	"t7", \
+	"s0",	"s1",	"s2",	"s3",	"s4",	"s5",	"s6",	"s7", \
+	"t8",	"jp",	"k0",	"k1",	"gp",	"sp",	"fp",	"ra", \
+	"f0",   "f1",   "f2",   "f3",   "f4",   "f5",   "f6",   "f7", \
+	"f8",   "f9",   "f10",  "f11",  "f12",  "f13",  "f14",  "f15", \
+	"f16",  "f17",  "f18",  "f19",  "f20",  "f21",  "f22",  "f23",\
+	"f24",  "f25",  "f26",  "f27",  "f28",  "f29",  "f30",  "f31",\
+	"pc",	"cause", "badvaddr",	"lo",	"hi",	"fsr",  "fir" \
+    }
+
+/* Register numbers of various important registers.
+   Note that some of these values are "real" register numbers,
+   and correspond to the general registers of the machine,
+   and some are "phony" register numbers which are too large
+   to be actual register numbers as far as the user is concerned
+   but do serve to get the desired values when passed to read_register.  */
+
+#define FP0_REGNUM	32	/* Floating point register 0 (single float) */
+#define PC_REGNUM	64	/* Contains program counter */
+#define CAUSE_REGNUM	65	/* describes last exception */
+#define BADVADDR_REGNUM	66	/* bad vaddr for addressing exception */
+#define LO_REGNUM 	67	/* Multiple/divide temp */
+#define HI_REGNUM	68	/* ... */
+#define FCRCS_REGNUM	69	/* FP control/status */
+#define FCRIR_REGNUM	70	/* FP implementation/revision */
+
+#define CANNOT_FETCH_REGISTER(regno) \
+  ((regno) == FP_REGNUM || (regno) == ZERO_REGNUM)
+#define CANNOT_STORE_REGISTER(regno) \
+  ((regno) == FP_REGNUM || (regno) == ZERO_REGNUM)
+
+/* Must call functions within PIC code using $t9. */
+#undef  Dest_Reg
+#define Dest_Reg 25
+
+/* Just like the Sparc, we do single stepping in software, this
+   feature does _not_ belong in the kernel as far as I'm concerned.  */
+
+#define NO_SINGLE_STEP 1
+
+/* XXX TODO */
+#undef  IN_SIGTRAMP
+#define IN_SIGTRAMP(pc, name)	(0)
+
+#endif /* TM_MIPSLINUX_H */
diff -urN gdb-4.17.orig/gdb/config/mips/tm-mips.h gdb-4.17/gdb/config/mips/tm-mips.h
--- gdb-4.17.orig/gdb/config/mips/tm-mips.h	Thu Oct  9 22:26:08 1997
+++ gdb-4.17/gdb/config/mips/tm-mips.h	Thu Jul  4 23:56:58 1996
@@ -121,8 +121,6 @@
 
 #define INNER_THAN <
 
-#define BIG_ENDIAN 4321
-
 /* Old-style breakpoint macros.
    The IDT board uses an unusual breakpoint value, and sometimes gets
    confused when it sees the usual MIPS breakpoint instruction.  */
diff -urN gdb-4.17.orig/gdb/config/mips/xm-linux.h gdb-4.17/gdb/config/mips/xm-linux.h
--- gdb-4.17.orig/gdb/config/mips/xm-linux.h	Thu Jan  1 01:00:00 1970
+++ gdb-4.17/gdb/config/mips/xm-linux.h	Thu Jul  4 23:55:19 1996
@@ -0,0 +1,33 @@
+/* Definitions for Linux/MIPS hosting support.
+
+Copyright (C) 1996 Free Software Foundation, Inc.
+
+Contributed by David S. Miller (davem@caip.rutgers.edu) at
+Rutgers University CAIP Research Center.
+
+This file is part of GDB.
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation; either version 2 of the License, or
+(at your option) any later version.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program; if not, write to the Free Software
+Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
+
+#if !defined (HOST_BYTE_ORDER)
+#define HOST_BYTE_ORDER BIG_ENDIAN
+#endif
+
+/* The mips has no siginterrupt routine. */
+#define NO_SIGINTERRUPT
+
+#define HAVE_TERMIOS
+#define HAVE_SIGSETMASK 1
+#define USG
diff -urN gdb-4.17.orig/gdb/configure.host gdb-4.17/gdb/configure.host
--- gdb-4.17.orig/gdb/configure.host	Thu Apr 16 23:29:58 1998
+++ gdb-4.17/gdb/configure.host	Sun Jul  5 00:21:40 1998
@@ -114,6 +114,7 @@
 # Close enough for now.
 mips-sgi-irix6*)	gdb_host=irix5 ;;
 mips-sony-*)		gdb_host=news-mips ;;
+mips-*-linux*)		gdb_host=mips-linux ;;
 mips-*-mach3*)		gdb_host=mipsm3 ;;
 mips-*-sysv4*)		gdb_host=mipsv4 ;;
 mips-*-sysv*)		gdb_host=riscos ;;
diff -urN gdb-4.17.orig/gdb/configure.tgt gdb-4.17/gdb/configure.tgt
--- gdb-4.17.orig/gdb/configure.tgt	Thu Apr 16 23:29:59 1998
+++ gdb-4.17/gdb/configure.tgt	Sun Jul  5 00:25:31 1998
@@ -187,6 +187,7 @@
 mips*-sgi-irix6*)	gdb_target=irix5 ;;
 mips*-sgi-*)		gdb_target=irix3 ;;
 mips*-sony-*)		gdb_target=bigmips ;;
+mips*-*-linux*)		gdb_target=mips-linux ;;
 mips*-*-mach3*)		gdb_target=mipsm3 ;;
 mips*-*-sysv4*)		gdb_target=mipsv4 ;;
 mips*-*-sysv*)		gdb_target=bigmips ;;
diff -urN gdb-4.17.orig/gdb/mips-nat.c gdb-4.17/gdb/mips-nat.c
--- gdb-4.17.orig/gdb/mips-nat.c	Mon Sep  9 05:01:42 1996
+++ gdb-4.17/gdb/mips-nat.c	Thu Jul  4 23:55:19 1996
@@ -1,4 +1,4 @@
-/* Low level DECstation interface to ptrace, for GDB when running native.
+/* Low level Linux & DECstation interface to ptrace, for GDB when running native.
    Copyright 1988, 1989, 1991, 1992, 1995 Free Software Foundation, Inc.
    Contributed by Alessandro Forin(af@cs.cmu.edu) at CMU
    and by Per Bothner(bothner@cs.wisc.edu) at U.Wisconsin.
@@ -23,6 +23,10 @@
 #include "inferior.h"
 #include "gdbcore.h"
 #include <sys/ptrace.h>
+#ifdef __linux__
+# include <asm/reg.h>
+# include <mips/ptrace.h>
+#endif
 #include <sys/types.h>
 #include <sys/param.h>
 #include <sys/user.h>
diff -urN gdb-4.17.orig/gdb/mips-tdep.c gdb-4.17/gdb/mips-tdep.c
--- gdb-4.17.orig/gdb/mips-tdep.c	Wed Dec 17 20:46:10 1997
+++ gdb-4.17/gdb/mips-tdep.c	Thu Jul  4 23:55:19 1996
@@ -1500,6 +1500,148 @@
 /* MASK(i,j) == (1<<i) + (1<<(i+1)) + ... + (1<<j)). Assume i<=j<(MIPS_NUMREGS-1). */
 #define MASK(i,j) (((1 << ((j)+1))-1) ^ ((1 << (i))-1))
 
+#ifdef NO_SINGLE_STEP
+
+static int isbranch PARAMS ((long, CORE_ADDR, CORE_ADDR *));
+
+#define INSN_BRANCH_BITS (INSN_UNCOND_BRANCH_DELAY | \
+			  INSN_COND_BRANCH_DELAY | \
+			  INSN_COND_BRANCH_LIKELY)
+
+static int
+isbranch(insn, pc, target)
+     long insn;
+     CORE_ADDR pc;
+     CORE_ADDR *target;
+{
+  long delta;
+  int i;
+
+  for (i = 0; i < NUMOPCODES; ++i)
+    if (mips_opcodes[i].pinfo != INSN_MACRO
+	&& (insn & mips_opcodes[i].mask) == mips_opcodes[i].match)
+      break;
+  if (i >= NUMOPCODES)
+    return 0;
+  if((mips_opcodes[i].pinfo & INSN_BRANCH_BITS) == 0)
+    return 0;
+
+  /* We've got one. */
+  if (mips_opcodes[i].name[0] != 'j')
+    {
+      /* The easy PC-relative branch case.  */
+      delta = (insn & 0xffff);
+      if(delta & 0x8000)
+	delta |= ~0xffff;
+      *target = (CORE_ADDR) (((long)pc) + ((delta << 2) + 4));
+    }
+  else
+    {
+      /* It's a jump, slightly more difficult.  */
+      if(mips_opcodes[i].pinfo & INSN_READ_GPR_S)
+	{
+	  int target_regno;
+
+	  /* Target is source register. */
+	  target_regno = (insn >> OP_SH_RS) & OP_MASK_RS;
+	  *target = (CORE_ADDR) read_register (target_regno);
+	}
+      else
+	{
+	  CORE_ADDR target_part;
+
+	  /* Target is low order 26 bits of insn, shifted left by 2, and
+	     or'd with the high order bits of pc.  */
+	  target_part = ((insn >> OP_SH_TARGET) & OP_MASK_TARGET) << 2;
+	  *target = ((pc & 0xf0000000) | target_part);
+	}
+    }
+  return 1;
+}
+
+static CORE_ADDR next_pc, target;
+typedef char binsn_quantum[BREAKPOINT_MAX];
+static binsn_quantum break_mem[2];
+
+/* Non-zero if we just simulated a single-step ptrace call.  This is
+   needed because we cannot remove the breakpoints in the inferior
+   process until after the `wait' in `wait_for_inferior'.  */
+
+int one_stepped;
+
+/* This is so that the code below knows whether we need to clear one,
+   or two breakpoints when the inferior resumes.  */
+
+static int doing_branch = 0;
+
+/* single_step() is called just before we want to resume the inferior,
+   if we want to single-step it but there is no hardware or kernel single-step
+   support (MIPS on Linux for example).  We find all the possible targets of
+   the coming instruction and breakpoint them.
+
+   single_step is also called just after the inferior stops.  If we had
+   set up a simulated single-step, we undo our damage.  */
+
+void
+single_step (ignore)
+     enum target_signal ignore; /* pid, but we don't need it */
+{
+  CORE_ADDR pc;
+  long pc_instruction;
+  int br;
+
+  if (!one_stepped)
+    {
+      pc = read_register (PC_REGNUM);
+      pc_instruction = read_memory_integer (pc, 4);
+      br = isbranch (pc_instruction, pc, &target);
+
+      if (br)
+	{
+	  /* Breakpoint at target of branch and 2 insns
+	     later as well.  If the branch is to itself
+	     the best we can do is wait for it to fall
+	     out on us.  */
+	  if(target != pc)
+	    {
+	      target_insert_breakpoint(target, break_mem[1]);
+	      doing_branch = 1;
+	    }
+	  else
+	    {
+	      doing_branch = 0;
+	    }
+	  next_pc = pc + 8;
+	  target_insert_breakpoint(next_pc, break_mem[0]);
+	}
+      else
+	{
+	  /* Just the very next instruction needs a break.  */
+	  doing_branch = 0;
+	  next_pc = pc + 4;
+	  target_insert_breakpoint(next_pc, break_mem[0]);
+	}
+
+      /* We are ready to let it go */
+      one_stepped = 1;
+      return;
+    }
+  else
+    {
+      /* Remove breakpoints */
+      target_remove_breakpoint (next_pc, break_mem[0]);
+
+      if (doing_branch)
+	{
+	  target_remove_breakpoint (target, break_mem[1]);
+	}
+
+      one_stepped = 0;
+    }
+}
+
+#endif /* NO_SINGLE_STEP */
+
 void
 mips_push_dummy_frame()
 {
diff -urN gdb-4.17.orig/gdb/mipslinux-nat.c gdb-4.17/gdb/mipslinux-nat.c
--- gdb-4.17.orig/gdb/mipslinux-nat.c	Thu Jan  1 01:00:00 1970
+++ gdb-4.17/gdb/mipslinux-nat.c	Sun Jul  5 01:42:13 1998
@@ -0,0 +1,193 @@
+/* Low level MIPS/Linux interface, for GDB when running native.
+   Copyright 1996 Free Software Foundation, Inc.
+   Contributed by David S. Miller (davem@caip.rutgers.edu) at
+   Rutgers University CAIP Research Center.
+
+This file is part of GDB.
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation; either version 2 of the License, or
+(at your option) any later version.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program; if not, write to the Free Software
+Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
+
+#define __timespec_defined /* Yuck ... */
+#include <linux/time.h>
+
+#include "defs.h"
+#include "inferior.h"
+#include "gdbcore.h"
+#include "target.h"
+#include "gdb_string.h"
+#include "symtab.h"
+#include "bfd.h"
+#include "symfile.h"
+#include "objfiles.h"
+#include "command.h"
+#include "frame.h"
+#include "gnu-regex.h"
+#include "inferior.h"
+#include "language.h"
+#include "gdbcmd.h"
+#include <sys/ptrace.h>
+//#include <sys/time.h>
+#include <asm/reg.h>
+#include <linux/elf.h>
+#include <linux/elfcore.h>
+#include <sys/types.h>
+#include <sys/param.h>
+#include <sys/user.h>
+
+#include <setjmp.h>   /* For JB_PC and friends. */
+
+/* Size of elements in jmpbuf */
+
+#define JB_ELEMENT_SIZE 4
+
+/* Figure out where the longjmp will land.
+   We expect the first arg to be a pointer to the jmp_buf structure from which
+   we extract the pc (JB_PC) that we will land at.  The pc is copied into PC.
+   This routine returns true on success. */
+
+int
+get_longjmp_target(pc)
+     CORE_ADDR *pc;
+{
+  CORE_ADDR jb_addr;
+  char buf[TARGET_PTR_BIT / TARGET_CHAR_BIT];
+
+  jb_addr = read_register (A0_REGNUM);
+
+  if (target_read_memory (jb_addr + JB_PC * JB_ELEMENT_SIZE, buf,
+			  TARGET_PTR_BIT / TARGET_CHAR_BIT))
+    return 0;
+
+  *pc = extract_address (buf, TARGET_PTR_BIT / TARGET_CHAR_BIT);
+
+  return 1;
+}
+
+/*
+ * See the comment in m68k-tdep.c regarding the utility of these functions.
+ *
+ * These definitions are from the MIPS SVR4 ABI, so they may work for
+ * any MIPS SVR4 target.
+ */
+
+void 
+supply_gregset (gregsetp)
+     gregset_t *gregsetp;
+{
+  register int regi;
+  register unsigned int *regp = (unsigned int *) &(*gregsetp)[0];
+  static char zerobuf[MAX_REGISTER_RAW_SIZE] = {0};
+
+  for (regi = EF_REG0; regi <= EF_LO; regi++)
+    supply_register ((regi - EF_REG0), (char *)(regp + regi));
+
+  supply_register(PC_REGNUM, (char *)(regp + EF_CP0_EPC));
+  supply_register(CAUSE_REGNUM, (char *)(regp + EF_CP0_CAUSE));
+  supply_register(BADVADDR_REGNUM, (char *)(regp + EF_CP0_BADVADDR));
+  supply_register(LO_REGNUM, (char *)(regp + EF_LO));
+  supply_register(HI_REGNUM, (char *)(regp + EF_HI));
+
+  /* Fill inaccessible registers with zero.  */
+  supply_register (FP_REGNUM, zerobuf);
+  supply_register (UNUSED_REGNUM, zerobuf);
+}
+
+void
+fill_gregset (gregsetp, regno)
+     gregset_t *gregsetp;
+     int regno;
+{
+  int regi;
+  register unsigned int *regp = (unsigned int *) &(*gregsetp)[0];
+
+  for (regi = 0; regi <= (EF_SIZE / 4); regi++)
+    if ((regno == -1) || (regno == regi))
+      *(regp + regi) = *(unsigned int *) &registers[REGISTER_BYTE (regi)];
+}
+
+/* Now we do the same thing for floating-point registers.
+ * We don't bother to condition on FP0_REGNUM since any
+ * reasonable MIPS configuration has an R3010 in it.
+ *
+ * Again, see the comments in m68k-tdep.c.
+ */
+
+void
+supply_fpregset (fpregsetp)
+     fpregset_t *fpregsetp;
+{
+  register int regi;
+  static char zerobuf[MAX_REGISTER_RAW_SIZE] = {0};
+
+  for (regi = 0; regi < 32; regi++)
+    supply_register (FP0_REGNUM + regi,
+		     (char *)&fpregsetp[regi]);
+
+  supply_register (FCRCS_REGNUM, (char *)&fpregsetp[32]);
+
+  /* FIXME: how can we supply FCRIR_REGNUM?  The ABI doesn't tell us. */
+  supply_register (FCRIR_REGNUM, zerobuf);
+}
+
+void
+fill_fpregset (fpregsetp, regno)
+     fpregset_t *fpregsetp;
+     int regno;
+{
+  int regi;
+  char *from, *to;
+
+  for (regi = FP0_REGNUM; regi < FP0_REGNUM + 32; regi++)
+    {
+      if ((regno == -1) || (regno == regi))
+	{
+	  from = (char *) &registers[REGISTER_BYTE (regi)];
+	  to = (char *) &(fpregsetp[regi - FP0_REGNUM]);
+	  memcpy(to, from, REGISTER_RAW_SIZE (regi));
+	}
+    }
+
+#if 0
+  if ((regno == -1) || (regno == FCRCS_REGNUM))
+    fpregsetp[32] = *(unsigned int *) &registers[REGISTER_BYTE(FCRCS_REGNUM)];
+#endif
+}
+
+/* Map gdb internal register number to ptrace ``address''.
+   These ``addresses'' are defined in <mips/ptrace.h> */
+
+#define REGISTER_PTRACE_ADDR(regno) \
+   (regno < 32 ? 		regno   \
+  : regno == PC_REGNUM ?	PC	\
+  : regno == CAUSE_REGNUM ?	CAUSE	\
+  : regno == HI_REGNUM ?	MMHI	\
+  : regno == LO_REGNUM ?	MMLO	\
+  : regno == FCRCS_REGNUM ?	FPC_CSR	\
+  : regno == FCRIR_REGNUM ?	FPC_EIR	\
+  : regno >= FP0_REGNUM ?	FPR_BASE + (regno - FP0_REGNUM) \
+  : 0)
+
+/* Return the ptrace ``address'' of register REGNO. */
+
+CORE_ADDR
+register_addr (regno, blockend)
+     int regno;
+     CORE_ADDR blockend;
+{
+  if(regno < 0 || regno >= NUM_REGS)
+    error ("Bogon register number %d.", regno);
+
+  return REGISTER_PTRACE_ADDR (regno);
+}

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ptrace-patch

diff -urN linux-2.0.30.orig/include/asm-mips/ptrace.h linux-2.0.30/include/asm-mips/ptrace.h
--- linux-2.0.30.orig/include/asm-mips/ptrace.h	Sat Oct 11 21:13:51 1997
+++ linux-2.0.30/include/asm-mips/ptrace.h	Sun Jul  5 01:52:05 1998
@@ -15,6 +15,14 @@
 
 #include <linux/types.h>
 
+#define PC		0
+#define CAUSE		1
+#define MMLO		3
+#define MMHI		4
+#define FPC_CSR		5	/* XXX */
+#define FPC_EIR		4	/* XXX */
+#define FPR_BASE	5	/* XXX */
+
 #ifndef __ASSEMBLY__
 /*
  * This struct defines the way the registers are stored on the stack during a
@@ -59,6 +67,6 @@
 extern void (*show_regs)(struct pt_regs *);
 #endif /* !(__ASSEMBLY__) */
 
-#endif
+#endif /* __KERNEL__ */
 
 #endif /* __ASM_MIPS_PTRACE_H */

--IS0zKkzwUGydFO0o--
