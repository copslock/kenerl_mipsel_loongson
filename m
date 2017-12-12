Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Dec 2017 11:03:20 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:57569 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994631AbdLLKAzw7JyC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Dec 2017 11:00:55 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx2.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 12 Dec 2017 10:00:50 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 12 Dec 2017 01:59:57 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
CC:     <linux-mips@linux-mips.org>
Subject: [RFC PATCH 11/16] MIPS: Move the CONFIG_EVA workaround into setup_kernel_mode
Date:   Tue, 12 Dec 2017 09:57:57 +0000
Message-ID: <1513072682-1371-12-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1513072682-1371-1-git-send-email-matt.redfearn@mips.com>
References: <1513072682-1371-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1513072842-298553-18501-36363-2
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
X-archive-position: 61441
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

This workaround is necessary when EVA is enabled when switching from
user mode to kernel mode. Move it from its location in SAVE_SOME into
the setup_kernel_mode macro.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 arch/mips/include/asm/stackframe.h | 51 +++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index a47a9f5591a3..bdcd4088d764 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -68,6 +68,32 @@
 		mtc0	k0, $22
 #endif /* !CONFIG_SMP && CONFIG_CPU_JUMP_WORKAROUNDS */
 
+#ifdef CONFIG_EVA
+		/*
+		 * Flush interAptiv's Return Prediction Stack (RPS) by writing
+		 * EntryHi. Toggling Config7.RPS is slower and less portable.
+		 *
+		 * The RPS isn't automatically flushed when exceptions are
+		 * taken, which can result in kernel mode speculative accesses
+		 * to user addresses if the RPS mispredicts. That's harmless
+		 * when user and kernel share the same address space, but with
+		 * EVA the same user segments may be unmapped to kernel mode,
+		 * even containing sensitive MMIO regions or invalid memory.
+		 *
+		 * This can happen when the kernel sets the return address to
+		 * ret_from_* and jr's to the exception handler, which looks
+		 * more like a tail call than a function call. If nested calls
+		 * don't evict the last user address in the RPS, it will
+		 * mispredict the return and fetch from a user controlled
+		 * address into the icache.
+		 *
+		 * More recent EVA-capable cores with MAAR to restrict
+		 * speculative accesses aren't affected.
+		 */
+		MFC0	k0, CP0_ENTRYHI
+		MTC0	k0, CP0_ENTRYHI
+#endif
+
 		/* Set thread_info if we're coming from user mode */
 		ori	$28, sp, _THREAD_MASK
 		xori	$28, _THREAD_MASK
@@ -216,31 +242,6 @@
 		.if \docfi
 		.cfi_register sp, k0
 		.endif
-#ifdef CONFIG_EVA
-		/*
-		 * Flush interAptiv's Return Prediction Stack (RPS) by writing
-		 * EntryHi. Toggling Config7.RPS is slower and less portable.
-		 *
-		 * The RPS isn't automatically flushed when exceptions are
-		 * taken, which can result in kernel mode speculative accesses
-		 * to user addresses if the RPS mispredicts. That's harmless
-		 * when user and kernel share the same address space, but with
-		 * EVA the same user segments may be unmapped to kernel mode,
-		 * even containing sensitive MMIO regions or invalid memory.
-		 *
-		 * This can happen when the kernel sets the return address to
-		 * ret_from_* and jr's to the exception handler, which looks
-		 * more like a tail call than a function call. If nested calls
-		 * don't evict the last user address in the RPS, it will
-		 * mispredict the return and fetch from a user controlled
-		 * address into the icache.
-		 *
-		 * More recent EVA-capable cores with MAAR to restrict
-		 * speculative accesses aren't affected.
-		 */
-		MFC0	k0, CP0_ENTRYHI
-		MTC0	k0, CP0_ENTRYHI
-#endif
 		.set	reorder
 		/* Called from user mode, new stack. */
 		get_saved_sp docfi=\docfi tosp=1
-- 
2.7.4
