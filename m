Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBDKHvj24263
	for linux-mips-outgoing; Thu, 13 Dec 2001 12:17:57 -0800
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBDKHno24260
	for <linux-mips@oss.sgi.com>; Thu, 13 Dec 2001 12:17:49 -0800
Received: from localhost.localdomain ([127.0.0.1] helo=cotw.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 16EbMV-0004GJ-00
	for <linux-mips@oss.sgi.com>; Thu, 13 Dec 2001 13:17:43 -0600
Message-ID: <3C18FED6.29254CF8@cotw.com>
Date: Thu, 13 Dec 2001 13:17:42 -0600
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Inlining of certain functions prevent R3000 kernel from booting...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello.

While trying to compile the latest CVS kernel, I notice that by not
inlining certain functions my kernel boots fine. If I put the inlines
back in, the kernel hangs and does not boot. Below are the three
functions that I am unable to inline:

****************************************************************
diff -urN -X cvs-exc.txt nino-linux/arch/mips/kernel/traps.c /opt/sgi-cvs/linux-
2.4/linux/arch/mips/kernel/traps.c
--- nino-linux/arch/mips/kernel/traps.c Wed Dec 12 17:42:53 2001
+++ /opt/sgi-cvs/linux-2.4/linux/arch/mips/kernel/traps.c       Sun Dec  2 05:34
:38 2001
@@ -100,7 +100,7 @@
 
 static struct task_struct *ll_task = NULL;
 
-static void simulate_ll(struct pt_regs *regp, unsigned int opcode)
+static inline void simulate_ll(struct pt_regs *regp, unsigned int opcode)
 {
        unsigned long value, *vaddr;
        long offset;
@@ -141,7 +141,7 @@
                send_sig(signal, current, 1);
 }
 
-static void simulate_sc(struct pt_regs *regp, unsigned int opcode)
+static inline void simulate_sc(struct pt_regs *regp, unsigned int opcode)
 {
        unsigned long *vaddr, reg;
        long offset;
diff -urN -X cvs-exc.txt nino-linux/arch/mips/kernel/unaligned.c /opt/sgi-cvs/li
nux-2.4/linux/arch/mips/kernel/unaligned.c
--- nino-linux/arch/mips/kernel/unaligned.c     Wed Dec 12 17:47:27 2001
+++ /opt/sgi-cvs/linux-2.4/linux/arch/mips/kernel/unaligned.c   Sat Dec  1 00:04
:49 2001
@@ -96,7 +96,7 @@
        if ((long)(~(pc) & ((a) | ((a)+(s)))) < 0)      \
                goto sigbus;
 
-static void emulate_load_store_insn(struct pt_regs *regs,
+static inline void emulate_load_store_insn(struct pt_regs *regs,
                                            unsigned long addr, unsigned long pc
)
 {
        union mips_instruction insn;
****************************************************************

I attempted to do a 'objdump -d' on the kernels with and without
the inline statements to see if any registers might be getting
hammered. I was not able to see anything obvious, but I did find
it difficult to decipher things once inlining was enabled. I have
placed the unstripped kernels in a tarball at:

    ftp://ftp.cotw.com/MIPS/mips-r3k-inline-kernels.tar.bz2

The cross toolchain was made up of:

    binutils-2.11.92.0.10
    gcc-3.0.2
    glibc-2.2.3

Is anyone else having problems like this? I am doing the Philips Nino port
which has a PR31700 (R3000A core) chip in it. Thanks.

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer
