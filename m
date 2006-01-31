Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2006 17:10:38 +0000 (GMT)
Received: from allen.werkleitz.de ([80.190.251.108]:62134 "EHLO
	allen.werkleitz.de") by ftp.linux-mips.org with ESMTP
	id S8133537AbWAaRKT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Jan 2006 17:10:19 +0000
Received: from p54be8dcc.dip0.t-ipconnect.de ([84.190.141.204] helo=void.local)
	by allen.werkleitz.de with esmtpsa (TLS-1.0:DHE_RSA_3DES_EDE_CBC_SHA1:24)
	(Exim 4.60)
	(envelope-from <js@linuxtv.org>)
	id 1F3z5w-0007He-TO
	for linux-mips@linux-mips.org; Tue, 31 Jan 2006 18:15:14 +0100
Received: from js by void.local with local (Exim 3.35 #1 (Debian))
	id 1F3z5w-0001jm-00
	for <linux-mips@linux-mips.org>; Tue, 31 Jan 2006 18:15:08 +0100
Date:	Tue, 31 Jan 2006 18:15:08 +0100
From:	Johannes Stezenbach <js@linuxtv.org>
To:	linux-mips@linux-mips.org
Message-ID: <20060131171508.GB6341@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: 84.190.141.204
Subject: gdb vs. gdbserver with -mips3 / 32bitmode userspace
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Return-Path: <js@linuxtv.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@linuxtv.org
Precedence: bulk
X-list: linux-mips

Hi,

I'm trying to debug a userspace application with gdb-6.3 / gdbserver.
Objdump -p reports:
  private flags = 20001107: [abi=O32] [mips3] [32bitmode]

With gdb-6.0 from an older toolchain this works, but gdb-6.3
reports the infamous "Reply contains invalid hex digit 59".
The reason for this is that gdb and gdbserver disagree
about the register size. Gdbserver seems to be hardcoded
to 32bit register size (regformats/reg-mips.dat), while gdb-6.3 assumes
that mips3 binaries use 64bit registers. (Actually E_MIPS_ARCH_3
gets transformed into bfd_mach_mips4000 in bfd/elfxx-mips.c, which
has 64bit registers according to bfd/cpu-mips.c).

(I briefly checked gdb-6.4, it seems to do the same.)

The workaround given in this posting seems to work for
userspace, too:
http://www.linux-mips.org/archives/linux-mips/2005-11/msg00154.html
I.e. "set architecture mips:isa32" overrides the register size
which gdb uses to talk to gdbserver.

However, I wonder why gdb doesn't evaluate the 32bitmode flag
from the ELF e_flags header. To be honest, I also wonder what
the exact semantics of this flag are. The NUBI document says:

  "32BIT_MODE: (e_flags&EF_MIPS_32BITMODE) - 1 when code assumes 32-bit
  registers only. Always set for NUBI32, but NUBI-compliant software
  should not rely on it."

I think (maybe in error ;-), that all binaries compiled for
a 32bit ABI, but a 64bit ISA, have this flag set, as the kernel
will refuse to execute 64bt code (i.e. not o32 or n32 ABI). Therefore,
shouldn't gdb also evaluate this flag when deciding about the ISA
register size?

How about this patch:


--- gdb-6.3/gdb/mips-tdep.c.orig	2004-10-15 09:25:03.000000000 +0200
+++ gdb-6.3/gdb/mips-tdep.c	2006-01-30 21:13:09.000000000 +0100
@@ -258,6 +258,15 @@ mips_abi (struct gdbarch *gdbarch)
 int
 mips_isa_regsize (struct gdbarch *gdbarch)
 {
+  struct gdbarch_tdep *tdep = gdbarch_tdep (current_gdbarch);
+  if (tdep != NULL)
+    {
+      int ef_mips_32bitmode;
+      ef_mips_32bitmode = (tdep->elf_flags & EF_MIPS_32BITMODE);
+      if (ef_mips_32bitmode)
+        return 4;
+    }
+
   return (gdbarch_bfd_arch_info (gdbarch)->bits_per_word
 	  / gdbarch_bfd_arch_info (gdbarch)->bits_per_byte);
 }


I also considered if adding 64bit support to gdbserver would be
the right thing, but I think not as o32 ABI executables don't have
64bit registers, right?

Please don't be too hard on me, my understanding of gdb etc. is pretty
limited. I'm especially confused by this ISA regsize vs. ABI regsize
thing ;-/. Thus my patch looks at the 32bitmode flag and not at
the o32 ABI to decide about this register size, however I'm not
sure if any of this makes actually sense. It seems to work for me,
though ;-)

But I'd be willing to do some work to get this fixed properly in
upstream gdb, if I get some guidance.


Thanks,
Johannes
