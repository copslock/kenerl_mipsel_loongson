Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Jan 2004 21:03:32 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:3565 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225341AbUADVDb>;
	Sun, 4 Jan 2004 21:03:31 +0000
Received: from teasel.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i04L3QQF008202;
	Sun, 4 Jan 2004 22:03:27 +0100 (MET)
Received: (from dimitri@localhost)
	by teasel.sonytel.be (8.9.3+Sun/8.9.3) id WAA15510;
	Sun, 4 Jan 2004 22:03:27 +0100 (MET)
Date: Sun, 4 Jan 2004 22:03:27 +0100
From: Dimitri Torfs <dimitri@sonycom.com>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: Re: access_ok and CONFIG_MIPS32 for 2.6
Message-ID: <20040104210327.GA15475@sonycom.com>
References: <20040102145941.GA13426@sonycom.com> <20040102194403.GB31092@linux-mips.org> <20040104.210532.74756709.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040104.210532.74756709.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <dimitri@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3865
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dimitri@sonycom.com
Precedence: bulk
X-list: linux-mips

On Sun, Jan 04, 2004 at 09:05:32PM +0900, Atsushi Nemoto wrote:
> >>>>> On Fri, 2 Jan 2004 20:44:03 +0100, Ralf Baechle <ralf@linux-mips.org> said:
> 
> >> Does anybody know why TASK_SIZE is set to 0x7fff8000 and not
> >> 0x80000000 ?
> 
> ralf> There is a weird special case were 32-bit code running on a
> ralf> 64-bit kernel with c0_status.ux set will behave differently than
> ralf> on a 32-bit processor or with c0_status.ux clear.  The
> ralf> workaround for 64-bit kernels is to leave the top 32kB of the
> ralf> 2GB user virtual address space unused.  For sake of symmetry we
> ralf> do this on both 32-bit and 64-bit kernels.
> 
> Then, access_ok in 2.6 tree is broken, isn't it?
> 
> It seems there should be another definition of USER_DS for
> CONFIG_MIPS32 in 2.6.

Yes, I'm setting USER_DS to 0x80000000 for CONFIG_MIPS32:


--- linux-mips-2.6.orig/include/asm-mips/uaccess.h	2003-11-30 13:59:06.000000000 +0100
+++ linux.work/include/asm-mips/uaccess.h	2004-01-04 21:22:23.000000000 +0100
@@ -42,7 +42,12 @@
 #endif /* CONFIG_MIPS64 */
 
 #define KERNEL_DS	((mm_segment_t) { 0UL })
+
+#ifdef CONFIG_MIPS32
+#define USER_DS		((mm_segment_t) { 0x80000000UL })
+#else
 #define USER_DS		((mm_segment_t) { -TASK_SIZE })
+#endif
 
 #define VERIFY_READ    0
 #define VERIFY_WRITE   1


The USER_DS mask is also used in scall32-o32.S, scall64-64.S and
scall64-032.S. It think it would be cleaner if we replace there also
the ">= 0" check with the "== 0" check and add the correct size as you
suggested:


--- linux-mips-2.6.orig/arch/mips/kernel/scall64-64.S	2003-10-11 00:58:55.000000000 +0200
+++ linux.work/arch/mips/kernel/scall64-64.S	2004-01-04 21:45:45.000000000 +0100
@@ -119,10 +119,10 @@
 	bnez	v0, bad_alignment
 
 	LONG_L	v1, TI_ADDR_LIMIT($28)		# in legal address range?
-	LONG_ADDIU	a0, a1, 4
+	LONG_ADDIU	a0, a1, 3 
 	or	a0, a0, a1
 	and	a0, a0, v1
-	bltz	a0, bad_address
+	bnez	a0, bad_address
 
 #ifdef CONFIG_CPU_HAS_LLSC
 	/* Ok, this is the ll/sc case.  World is sane :-)  */


--- linux-mips-2.6.orig/arch/mips/kernel/scall32-o32.S	2003-08-26 02:28:51.000000000 +0200
+++ linux.work/arch/mips/kernel/scall32-o32.S	2004-01-04 21:48:39.000000000 +0100
@@ -187,10 +187,10 @@
 	bnez	v0, bad_alignment
 
 	lw	v1, TI_ADDR_LIMIT($28)		# in legal address range?
-	addiu	a0, a1, 4
+	addiu	a0, a1, 3 
 	or	a0, a0, a1
 	and	a0, a0, v1
-	bltz	a0, bad_address
+	bnez	a0, bad_address
 
 #ifdef CONFIG_CPU_HAS_LLSC
 	/* Ok, this is the ll/sc case.  World is sane :-)  */
@@ -280,11 +280,11 @@
 	bnez	v0, sigsegv
 
 	addu	v0, t0, 16			# v0 = usp + 16
-	addu	t1, v0, 12			# 3 32-bit arguments
+	addu	t1, v0, 11			# 3 32-bit arguments
 	lw	v1, TI_ADDR_LIMIT($28)
 	or	v0, v0, t1
 	and	v1, v1, v0
-	bltz	v1, efault
+	bnez	v1, efault
 
 	move	a0, a1				# shift argument registers
 	move	a1, a2



--- linux-mips-2.6.orig/arch/mips/kernel/scall64-64.S	2003-10-11 00:58:55.000000000 +0200
+++ linux.work/arch/mips/kernel/scall64-64.S	2004-01-04 21:45:45.000000000 +0100
@@ -119,10 +119,10 @@
 	bnez	v0, bad_alignment
 
 	LONG_L	v1, TI_ADDR_LIMIT($28)		# in legal address range?
-	LONG_ADDIU	a0, a1, 4
+	LONG_ADDIU	a0, a1, 3 
 	or	a0, a0, a1
 	and	a0, a0, v1
-	bltz	a0, bad_address
+	bnez	a0, bad_address
 
 #ifdef CONFIG_CPU_HAS_LLSC
 	/* Ok, this is the ll/sc case.  World is sane :-)  */



Dimitri
