Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Oct 2002 20:23:46 +0200 (CEST)
Received: from buserror-extern.convergence.de ([212.84.236.66]:50438 "EHLO
	hell") by linux-mips.org with ESMTP id <S1123253AbSJPSXq>;
	Wed, 16 Oct 2002 20:23:46 +0200
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 181spU-00075K-00; Wed, 16 Oct 2002 20:23:36 +0200
Date: Wed, 16 Oct 2002 20:23:35 +0200
From: Johannes Stezenbach <js@convergence.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Once again: test_and_set for CPUs w/o LL/SC
Message-ID: <20021016182335.GA27216@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
References: <20021007184344.GA17548@convergence.de> <Pine.GSO.3.96.1021015171817.16503B-100000@delta.ds2.pg.gda.pl> <20021016181135.GA26994@convergence.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <20021016181135.GA26994@convergence.de>
User-Agent: Mutt/1.4i
Return-Path: <js@convergence.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@convergence.de
Precedence: bulk
X-list: linux-mips


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 16, 2002 at 08:11:35PM +0200, Johannes Stezenbach wrote:
> Here's patch for the kernel.

Now with the patch...

Johannes

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-mips-nollsc.patch"

Index: Documentation/Configure.help
===================================================================
RCS file: /home/cvs/linux/Documentation/Attic/Configure.help,v
retrieving revision 1.109.2.9
diff -u -r1.109.2.9 Configure.help
--- Documentation/Configure.help	3 Oct 2002 01:27:58 -0000	1.109.2.9
+++ Documentation/Configure.help	16 Oct 2002 17:44:12 -0000
@@ -2349,6 +2349,20 @@
   for better performance, N if you don't know.  You must say Y here
   for multiprocessor machines.
 
+Support userspace ll/sc emulation
+CONFIG_CPU_USERSPACE_LLSC_EMUL
+  Say Y here if your CPU does not have the Load Linked (ll)
+  and Store Conditional (sc) instructions, but supports
+  the Branch Likely instructions, e.g. the NEC VR41xx CPUs.
+  Then the kernel guarantees that the k1 register is 0 after
+  any transition from kernel to userspace, which enables an
+  optimized system library to implement a userspace-only
+  ll/sc emulation.
+
+  If you don't run multithreaded software or don't have a
+  matching libpthread, you don't need it.
+  If in doubt, say N.
+
 lld and scd instructions available
 CONFIG_CPU_HAS_LLDSCD
   Say Y here if your CPU has the lld and scd instructions, the 64-bit
Index: arch/mips/config-shared.in
===================================================================
RCS file: /home/cvs/linux/arch/mips/config-shared.in,v
retrieving revision 1.1.2.23
diff -u -r1.1.2.23 config-shared.in
--- arch/mips/config-shared.in	6 Oct 2002 12:28:03 -0000	1.1.2.23
+++ arch/mips/config-shared.in	16 Oct 2002 17:44:12 -0000
@@ -547,6 +547,11 @@
 dep_bool 'Override CPU Options' CONFIG_CPU_ADVANCED $CONFIG_MIPS32
 if [ "$CONFIG_CPU_ADVANCED" = "y" ]; then
    bool '  ll/sc Instructions available' CONFIG_CPU_HAS_LLSC
+   if [ "$CONFIG_CPU_HAS_LLSC" = "n" ]; then
+      bool '    Support userspace atomic ops for MIPS2 CPUs' CONFIG_CPU_USERSPACE_LLSC_EMUL
+   else
+      define_bool CONFIG_CPU_USERSPACE_LLSC_EMUL n
+   fi
    bool '  lld/scd Instructions available' CONFIG_CPU_HAS_LLDSCD
    bool '  Writeback Buffer available' CONFIG_CPU_HAS_WB
 else
@@ -562,6 +567,11 @@
 	 define_bool CONFIG_CPU_HAS_LLDSCD n
 	 define_bool CONFIG_CPU_HAS_WB n
       fi
+      if [ "$CONFIG_CPU_VR41XX" = "y" ]; then
+         define_bool CONFIG_CPU_USERSPACE_LLSC_EMUL y
+      else
+         define_bool CONFIG_CPU_USERSPACE_LLSC_EMUL n
+      fi
    else
       if [ "$CONFIG_CPU_MIPS32" = "y" ]; then
 	 define_bool CONFIG_CPU_HAS_LLSC y
@@ -572,6 +582,7 @@
 	 define_bool CONFIG_CPU_HAS_LLDSCD y
 	 define_bool CONFIG_CPU_HAS_WB n
       fi
+      define_bool CONFIG_CPU_USERSPACE_LLSC_EMUL n
    fi
 fi
 if [ "$CONFIG_CPU_R3000" = "y" ]; then
Index: arch/mips/mm/tlbex-r4k.S
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/tlbex-r4k.S,v
retrieving revision 1.2.2.10
diff -u -r1.2.2.10 tlbex-r4k.S
--- arch/mips/mm/tlbex-r4k.S	2 Oct 2002 19:42:04 -0000	1.2.2.10
+++ arch/mips/mm/tlbex-r4k.S	16 Oct 2002 17:44:12 -0000
@@ -182,7 +182,11 @@
 	b	1f
 	tlbwr					# write random tlb entry
 1:
+#ifdef CONFIG_CPU_USERSPACE_LLSC_EMUL
+	move k1, zero
+#else
 	nop
+#endif
 	eret					# return from trap
 	END(except_vec0_r4000)
 
@@ -207,7 +211,11 @@
 	P_MTC0	k1, CP0_ENTRYLO1
 	nop
 	tlbwr
+#ifdef CONFIG_CPU_USERSPACE_LLSC_EMUL
+	move k1, zero
+#else
 	nop
+#endif
 	eret
 	END(except_vec0_r4600)
 
@@ -244,7 +252,11 @@
 	nop					# QED specified nops
 	nop
 	tlbwr					# write random tlb entry
+#ifdef CONFIG_CPU_USERSPACE_LLSC_EMUL
+	move k1, zero
+#else
 	nop					# traditional nop
+#endif
 	eret					# return from trap
 	END(except_vec0_nevada)
 
@@ -276,7 +288,12 @@
 	P_MTC0	k1, CP0_ENTRYLO1		# load it
 	b	1f
 	tlbwr					# write random tlb entry
-1:	nop
+1:
+#ifdef CONFIG_CPU_USERSPACE_LLSC_EMUL
+	move k1, zero
+#else
+	nop
+#endif
 2:	eret					# return from trap
 	END(except_vec0_sb1_m3)
 #endif /* BCM1250_M3_WAR */
@@ -308,7 +325,11 @@
 	bltzl	k0, 1f
 	tlbwr
 1:
+#ifdef CONFIG_CPU_USERSPACE_LLSC_EMUL
+	move k1, zero
+#else
 	nop
+#endif
 	eret
 	END(except_vec0_r45k_bvahwbug)
 
@@ -340,7 +361,11 @@
 	bltzl	k0, 1f
 	tlbwr
 1:
+#ifdef CONFIG_CPU_USERSPACE_LLSC_EMUL
+	move k1, zero
+#else
 	nop
+#endif
 	eret
 	END(except_vec0_r4k_mphwbug)
 #endif
@@ -371,7 +396,11 @@
 	b	1f
 	tlbwr
 1:
+#ifdef CONFIG_CPU_USERSPACE_LLSC_EMUL
+	move k1, zero
+#else
 	nop
+#endif
 	eret
 	END(except_vec0_r4k_250MHZhwbug)
 
@@ -405,7 +434,11 @@
 	bltzl	k0, 1f
 	tlbwr
 1:
+#ifdef CONFIG_CPU_USERSPACE_LLSC_EMUL
+	move k1, zero
+#else
 	nop
+#endif
 	eret
 	END(except_vec0_r4k_MP250MHZhwbug)
 #endif
@@ -456,7 +489,11 @@
 	b	1f
 	 tlbwi
 1:
+#ifdef CONFIG_CPU_USERSPACE_LLSC_EMUL
+	move k1, zero
+#else
 	nop
+#endif
 	.set	mips3
 	eret
 	.set	mips0
@@ -482,7 +519,11 @@
 	b	1f
 	 tlbwi
 1:
+#ifdef CONFIG_CPU_USERSPACE_LLSC_EMUL
+	move k1, zero
+#else
 	nop
+#endif
 	.set	mips3
 	eret
 	.set	mips0
@@ -513,7 +554,11 @@
 	b	1f
 	 tlbwi
 1:
+#ifdef CONFIG_CPU_USERSPACE_LLSC_EMUL
+	move k1, zero
+#else
 	nop
+#endif
 	.set	mips3
 	eret
 	.set	mips0
Index: include/asm-mips/stackframe.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/stackframe.h,v
retrieving revision 1.18.2.2
diff -u -r1.18.2.2 stackframe.h
--- include/asm-mips/stackframe.h	5 Aug 2002 23:53:37 -0000	1.18.2.2
+++ include/asm-mips/stackframe.h	16 Oct 2002 17:44:13 -0000
@@ -201,8 +201,15 @@
 		lw	$3,  PT_R3(sp);                  \
 		lw	$2,  PT_R2(sp)
 
+#ifdef CONFIG_CPU_USERSPACE_LLSC_EMUL
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

--X1bOJ3K7DJ5YkBrT--
