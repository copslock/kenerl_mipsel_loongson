Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Dec 2016 14:41:01 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39832 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993060AbcLBNjnAdCQ6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Dec 2016 14:39:43 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 7E2B2407CDCC1;
        Fri,  2 Dec 2016 13:39:33 +0000 (GMT)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 2 Dec 2016 13:39:37 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 3/5] MIPS: Only change $28 to thread_info if coming from user mode
Date:   Fri, 2 Dec 2016 13:39:15 +0000
Message-ID: <1480685957-18809-4-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1480685957-18809-1-git-send-email-matt.redfearn@imgtec.com>
References: <1480685957-18809-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

The SAVE_SOME macro is used to save the execution context on all
exceptions.
If an exception occurs while executing user code, the stack is switched
to the kernel's stack for the current task, and register $28 is switched
to point to the current_thread_info, which is at the bottom of the stack
region.
If the exception occurs while executing kernel code, the stack is left,
and this change ensures that register $28 is not updated. This is the
correct behaviour when the kernel can be executing on the separate irq
stack, because the thread_info will not be at the base of it.

With this change, register $28 is only switched to it's kernel
conventional usage of the currrent thread info pointer at the point at
which execution enters kernel space. Doing it on every exception was
redundant, but OK without an IRQ stack, but will be erroneous once that
is introduced.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

 arch/mips/include/asm/stackframe.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index eebf39549606..5782fa3d63be 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -216,12 +216,22 @@
 		LONG_S	$25, PT_R25(sp)
 		LONG_S	$28, PT_R28(sp)
 		LONG_S	$31, PT_R31(sp)
+
+		/* Set thread_info if we're coming from user mode */
+		.set	reorder
+		mfc0	k0, CP0_STATUS
+		sll	k0, 3		/* extract cu0 bit */
+		.set	noreorder
+		bltz	k0, 9f
+		 nop
+
 		ori	$28, sp, _THREAD_MASK
 		xori	$28, _THREAD_MASK
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 		.set    mips64
 		pref    0, 0($28)       /* Prefetch the current pointer */
 #endif
+9:
 		.set	pop
 		.endm
 
-- 
2.7.4
