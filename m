Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Aug 2017 14:31:04 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:56190 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993931AbdHUMaMb00mG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Aug 2017 14:30:12 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id B7D4D1A45B8;
        Mon, 21 Aug 2017 14:30:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from mcs19.domain.local (mcs19.domain.local [10.10.13.51])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 81B531A21AC;
        Mon, 21 Aug 2017 14:30:06 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2 4/6] MIPS: math-emu: Add FP emu debugfs statistics for branches
Date:   Mon, 21 Aug 2017 14:24:50 +0200
Message-Id: <20170821122526.22072-5-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170821122526.22072-1-aleksandar.markovic@rt-rk.com>
References: <20170821122526.22072-1-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksandar.markovic@rt-rk.com
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

From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

Add FP emu debugfs counter for branches.

The new counter is displayed the same way as existing counter, and
its default path is /sys/kernel/debug/mips/fpuemustats/.

The limitation of this counter is that it counts only R6 branch
instructions BC1NEZ and BC1EQZ.

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 arch/mips/include/asm/fpu_emulator.h | 1 +
 arch/mips/math-emu/cp1emu.c          | 1 +
 arch/mips/math-emu/me-debugfs.c      | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/mips/include/asm/fpu_emulator.h b/arch/mips/include/asm/fpu_emulator.h
index c05369e..7f5cf1f 100644
--- a/arch/mips/include/asm/fpu_emulator.h
+++ b/arch/mips/include/asm/fpu_emulator.h
@@ -36,6 +36,7 @@ struct mips_fpu_emulator_stats {
 	unsigned long emulated;
 	unsigned long loads;
 	unsigned long stores;
+	unsigned long branches;
 	unsigned long cp1ops;
 	unsigned long cp1xops;
 	unsigned long errors;
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 1ad15f8..40c74e1 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1230,6 +1230,7 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 				break;
 			}
 branch_common:
+			MIPS_FPU_EMU_INC_STATS(branches);
 			set_delay_slot(xcp);
 			if (cond) {
 				/*
diff --git a/arch/mips/math-emu/me-debugfs.c b/arch/mips/math-emu/me-debugfs.c
index be650ed..78b26c8 100644
--- a/arch/mips/math-emu/me-debugfs.c
+++ b/arch/mips/math-emu/me-debugfs.c
@@ -53,6 +53,7 @@ do {									\
 	FPU_STAT_CREATE(emulated);
 	FPU_STAT_CREATE(loads);
 	FPU_STAT_CREATE(stores);
+	FPU_STAT_CREATE(branches);
 	FPU_STAT_CREATE(cp1ops);
 	FPU_STAT_CREATE(cp1xops);
 	FPU_STAT_CREATE(errors);
-- 
2.9.3
