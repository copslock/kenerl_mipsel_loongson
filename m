Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Apr 2006 03:57:57 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:14201 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133715AbWDNC5q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Apr 2006 03:57:46 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 14 Apr 2006 12:09:50 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 25808207A8;
	Fri, 14 Apr 2006 12:09:45 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 131F420237;
	Fri, 14 Apr 2006 12:09:45 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k3E39i4D071077;
	Fri, 14 Apr 2006 12:09:44 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 14 Apr 2006 12:09:44 +0900 (JST)
Message-Id: <20060414.120944.25476367.nemoto@toshiba-tops.co.jp>
To:	ppopov@embeddedalley.com
Cc:	linux-mips@linux-mips.org
Subject: Re: mips64 kgdb fpu access bug
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1144961699.8372.127.camel@localhost.localdomain>
References: <1144961699.8372.127.camel@localhost.localdomain>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 13 Apr 2006 13:54:59 -0700, Pete Popov <ppopov@embeddedalley.com> wrote:
> .macro  fpu_save_double thread status tmp1 tmp2
>         sll     \tmp2, \tmp1, 5
>         bgez    \tmp2, 2f
>         fpu_save_16odd \thread
> 2:
>         fpu_save_16even \thread \tmp1                   # clobbers t1
>         .endm
> 
> tmp1 is "t0" and it's not clear to me why we're checking t0 instead of
> status in order to decide whether to save the odd registers or not. I
> must be missing something because others would have hit this bug by now.
> Any clues would be appreciated.

It seems commit d0fd5c21d07d6e13993a77f4471d8003a271a12b was somewhat
broken.

Could you try this patch?


fix register usage in fpu_save_double() and make fpu_restore_double()
more symmetric with fpu_save_double().

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
index 0b1b54a..db94e55 100644
--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -75,8 +75,8 @@
 	and	t0, t0, t1
 	LONG_S	t0, ST_OFF(t3)
 
-	fpu_save_double a0 t1 t0 t2		# c0_status passed in t1
-						# clobbers t0 and t2
+	fpu_save_double a0 t0 t1		# c0_status passed in t0
+						# clobbers t1
 1:
 
 	/*
@@ -129,9 +129,9 @@
  */
 LEAF(_save_fp)
 #ifdef CONFIG_64BIT
-	mfc0	t1, CP0_STATUS
+	mfc0	t0, CP0_STATUS
 #endif
-	fpu_save_double a0 t1 t0 t2		# clobbers t1
+	fpu_save_double a0 t0 t1		# clobbers t1
 	jr	ra
 	END(_save_fp)
 
@@ -139,7 +139,10 @@ LEAF(_save_fp)
  * Restore a thread's fp context.
  */
 LEAF(_restore_fp)
-	fpu_restore_double a0, t1		# clobbers t1
+#ifdef CONFIG_64BIT
+	mfc0	t0, CP0_STATUS
+#endif
+	fpu_restore_double a0 t0 t1		# clobbers t1
 	jr	ra
 	END(_restore_fp)
 
diff --git a/include/asm-mips/asmmacro-32.h b/include/asm-mips/asmmacro-32.h
index 11daf5c..5de3963 100644
--- a/include/asm-mips/asmmacro-32.h
+++ b/include/asm-mips/asmmacro-32.h
@@ -12,7 +12,7 @@
 #include <asm/fpregdef.h>
 #include <asm/mipsregs.h>
 
-	.macro	fpu_save_double thread status tmp1=t0 tmp2
+	.macro	fpu_save_double thread status tmp1=t0
 	cfc1	\tmp1,  fcr31
 	sdc1	$f0,  THREAD_FPR0(\thread)
 	sdc1	$f2,  THREAD_FPR2(\thread)
@@ -70,7 +70,7 @@
 	sw	\tmp, THREAD_FCR31(\thread)
 	.endm
 
-	.macro	fpu_restore_double thread tmp=t0
+	.macro	fpu_restore_double thread status tmp=t0
 	lw	\tmp, THREAD_FCR31(\thread)
 	ldc1	$f0,  THREAD_FPR0(\thread)
 	ldc1	$f2,  THREAD_FPR2(\thread)
diff --git a/include/asm-mips/asmmacro-64.h b/include/asm-mips/asmmacro-64.h
index 559c355..225feef 100644
--- a/include/asm-mips/asmmacro-64.h
+++ b/include/asm-mips/asmmacro-64.h
@@ -53,12 +53,12 @@
 	sdc1	$f31, THREAD_FPR31(\thread)
 	.endm
 
-	.macro	fpu_save_double thread status tmp1 tmp2
-	sll	\tmp2, \tmp1, 5
-	bgez	\tmp2, 2f
+	.macro	fpu_save_double thread status tmp
+	sll	\tmp, \status, 5
+	bgez	\tmp, 2f
 	fpu_save_16odd \thread
 2:
-	fpu_save_16even \thread \tmp1			# clobbers t1
+	fpu_save_16even \thread \tmp
 	.endm
 
 	.macro	fpu_restore_16even thread tmp=t0
@@ -101,13 +101,12 @@
 	ldc1	$f31, THREAD_FPR31(\thread)
 	.endm
 
-	.macro	fpu_restore_double thread tmp
-	mfc0	t0, CP0_STATUS
-	sll	t1, t0, 5
-	bgez	t1, 1f				# 16 register mode?
+	.macro	fpu_restore_double thread status tmp
+	sll	\tmp, \status, 5
+	bgez	\tmp, 1f				# 16 register mode?
 
-	fpu_restore_16odd a0
-1:	fpu_restore_16even a0, t0		# clobbers t0
+	fpu_restore_16odd \thread
+1:	fpu_restore_16even \thread \tmp
 	.endm
 
 	.macro	cpu_save_nonscratch thread
