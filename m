Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2014 17:46:16 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17761 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6838840AbaGKPpaJFroH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Jul 2014 17:45:30 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1474AA1A6B47F
        for <linux-mips@linux-mips.org>; Fri, 11 Jul 2014 16:45:20 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 11 Jul 2014 16:45:23 +0100
Received: from pburton-laptop.home (192.168.79.172) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 11 Jul
 2014 16:45:22 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 03/13] MIPS: preserve scalar FP CSR when switching vector context
Date:   Fri, 11 Jul 2014 16:44:29 +0100
Message-ID: <1405093479-5123-4-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1405093479-5123-1-git-send-email-paul.burton@imgtec.com>
References: <1405093479-5123-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.79.172]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Switching the vector context implicitly saves & restores the state of
the aliased scalar FP data registers, however the scalar FP control
& status register is distinct from the MSA control & status register.
In order to allow scalar FP to function correctly in programs using
MSA, the scalar CSR needs to be saved & restored along with the MSA
vector context.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/kernel/r4k_switch.S | 4 +++-
 arch/mips/kernel/traps.c      | 5 +++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
index 81ca3f7..1a1aef0 100644
--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -64,8 +64,10 @@
 	/* Check whether we're saving scalar or vector context. */
 	bgtz	a3, 1f
 
-	/* Save 128b MSA vector context. */
+	/* Save 128b MSA vector context + scalar FP control & status. */
+	cfc1	t1, fcr31
 	msa_save_all	a0
+	sw	t1, THREAD_FCR31(a0)
 	b	2f
 
 1:	/* Save 32b/64b scalar FP context. */
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 51706d6..4792fd7 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1153,6 +1153,11 @@ static int enable_restore_fp_context(int msa)
 
 	/* We need to restore the vector context. */
 	restore_msa(current);
+
+	/* Restore the scalar FP control & status register */
+	if (!was_fpu_owner)
+		asm volatile("ctc1 %0, $31" : : "r"(current->thread.fpu.fcr31));
+
 	return 0;
 }
 
-- 
2.0.1
