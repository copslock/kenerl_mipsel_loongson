Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Dec 2017 11:02:51 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:40299 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994630AbdLLKAxJ48UC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Dec 2017 11:00:53 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 12 Dec 2017 10:00:46 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 12 Dec 2017 01:59:56 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
CC:     <linux-mips@linux-mips.org>
Subject: [RFC PATCH 10/16] MIPS: Move the CONFIG_CPU_JUMP_WORKAROUNDS into setup_kernel_mode
Date:   Tue, 12 Dec 2017 09:57:56 +0000
Message-ID: <1513072682-1371-11-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1513072682-1371-1-git-send-email-matt.redfearn@mips.com>
References: <1513072682-1371-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1513072838-637138-2170-866389-8
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187894
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

This workaround is necessary on certain CPUs when switching from user
mode to kernel mode. Move it from its slightly odd location in the
middle of get_saved_sp (which it is unrelated to) into the
setup_kernel_mode macro.

Since the setup_kernel_mode is a new self contained macro, we can ensure
that reordering is on and drop the NOP delay slot fillers.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 arch/mips/include/asm/stackframe.h | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index 494fe41f5619..a47a9f5591a3 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -49,6 +49,24 @@
 #endif
 
 		.macro setup_kernel_mode docfi=0
+		.set	push
+		.set	reorder
+
+#if !defined(CONFIG_SMP) && defined(CONFIG_CPU_JUMP_WORKAROUNDS)
+		/*
+		 * Clear BTB (branch target buffer), forbid RAS (return address
+		 * stack) to workaround the Out-of-order Issue in Loongson2F
+		 * via its diagnostic register.
+		 */
+		move	k0, ra
+		jal	1f
+1:		jal	1f
+1:		jal	1f
+1:		jal	1f
+1:		move	ra, k0
+		li	k0, 3
+		mtc0	k0, $22
+#endif /* !CONFIG_SMP && CONFIG_CPU_JUMP_WORKAROUNDS */
 
 		/* Set thread_info if we're coming from user mode */
 		ori	$28, sp, _THREAD_MASK
@@ -59,6 +77,7 @@
 		pref	0, 0($28)       /* Prefetch the current pointer */
 		.set	pop
 #endif
+		.set	pop
 		.endm
 
 		.macro	SAVE_AT docfi=0
@@ -160,25 +179,6 @@
 #else /* !CONFIG_SMP */
 		/* Uniprocessor variation */
 		.macro	get_saved_sp docfi=0 tosp=0
-#ifdef CONFIG_CPU_JUMP_WORKAROUNDS
-		/*
-		 * Clear BTB (branch target buffer), forbid RAS (return address
-		 * stack) to workaround the Out-of-order Issue in Loongson2F
-		 * via its diagnostic register.
-		 */
-		move	k0, ra
-		jal	1f
-		 nop
-1:		jal	1f
-		 nop
-1:		jal	1f
-		 nop
-1:		jal	1f
-		 nop
-1:		move	ra, k0
-		li	k0, 3
-		mtc0	k0, $22
-#endif /* CONFIG_CPU_JUMP_WORKAROUNDS */
 #if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
 		lui	k1, %hi(kernelsp)
 #else
-- 
2.7.4
