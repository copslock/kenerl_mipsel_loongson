Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Jun 2013 00:15:07 +0200 (CEST)
Received: from mail-pa0-f51.google.com ([209.85.220.51]:59588 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834875Ab3FUWPG0beYy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 22 Jun 2013 00:15:06 +0200
Received: by mail-pa0-f51.google.com with SMTP id lf11so8411268pab.10
        for <multiple recipients>; Fri, 21 Jun 2013 15:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=POBqs4hRAsljDWD2H9IKJ7+n7PF/8HO5Mz8/ylTioFQ=;
        b=D7NxXn5M10atQYzc9UHp0/nk+w3ovzw8i2I2y/sBeS8lLk+k5y/u0A6I4a1LZexEvo
         1XaaNIP5+w0/1Nf2Ersx8a4JGqvONiuomyHcTNDH/KEez9kGm+SEjUrlEaJ5kBZxUukB
         uXZZ0MM2Z1+cZqnkhFiogPtZl2pZPM8PIW44fmhSRveOlz+dWHxA9zseR9XLX4P2KJGC
         0NMvKIvGL6yZbJ+h5xnG/50JDoZi+SMLP6A1j1x8ttns5eIyu1axRMe9U63rl3N/DRkG
         6WnSymixPpGw4I/XXysEMJa1wmLwz2UZPuEmUHCKK7RnvkBuclIV02dHZ+oPd7sBGmDi
         f8BA==
X-Received: by 10.66.164.232 with SMTP id yt8mr18120030pab.21.1371852899351;
        Fri, 21 Jun 2013 15:14:59 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id kq2sm7347480pab.19.2013.06.21.15.14.57
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 21 Jun 2013 15:14:58 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r5LMEuTV004064;
        Fri, 21 Jun 2013 15:14:56 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r5LMEsis004063;
        Fri, 21 Jun 2013 15:14:54 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Don't save/restore OCTEON wide multiplier state on syscalls.
Date:   Fri, 21 Jun 2013 15:14:53 -0700
Message-Id: <1371852893-4029-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: David Daney <david.daney@cavium.com>

The ABI allows these to be clobbered on syscalls, so only save and
restore the multiplier state when the temporary registers need to be
preserved.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/stackframe.h | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index a89d1b1..23fc95e 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -70,6 +70,14 @@
 #ifndef CONFIG_CPU_HAS_SMARTMIPS
 		LONG_S	v1, PT_LO(sp)
 #endif
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+		/*
+		 * The Octeon multiplier state is affected by general
+		 * multiply instructions. It must be saved before and
+		 * kernel code might corrupt it
+		 */
+		jal     octeon_mult_save
+#endif
 		.endm
 
 		.macro	SAVE_STATIC
@@ -218,17 +226,8 @@
 		ori	$28, sp, _THREAD_MASK
 		xori	$28, _THREAD_MASK
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
-		.set	mips64
-		pref	0, 0($28)	/* Prefetch the current pointer */
-		pref	0, PT_R31(sp)	/* Prefetch the $31(ra) */
-		/* The Octeon multiplier state is affected by general multiply
-		    instructions. It must be saved before and kernel code might
-		    corrupt it */
-		jal	octeon_mult_save
-		LONG_L	v1, 0($28)  /* Load the current pointer */
-			 /* Restore $31(ra) that was changed by the jal */
-		LONG_L	ra, PT_R31(sp)
-		pref	0, 0(v1)    /* Prefetch the current thread */
+		.set    mips64
+		pref    0, 0($28)       /* Prefetch the current pointer */
 #endif
 		.set	pop
 		.endm
@@ -248,6 +247,10 @@
 		.endm
 
 		.macro	RESTORE_TEMP
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+		/* Restore the Octeon multiplier state */
+		jal	octeon_mult_restore
+#endif
 #ifdef CONFIG_CPU_HAS_SMARTMIPS
 		LONG_L	$24, PT_ACX(sp)
 		mtlhx	$24
@@ -360,10 +363,6 @@
 		DVPE	5				# dvpe a1
 		jal	mips_ihb
 #endif /* CONFIG_MIPS_MT_SMTC */
-#ifdef CONFIG_CPU_CAVIUM_OCTEON
-		/* Restore the Octeon multiplier state */
-		jal	octeon_mult_restore
-#endif
 		mfc0	a0, CP0_STATUS
 		ori	a0, STATMASK
 		xori	a0, STATMASK
-- 
1.7.11.7
