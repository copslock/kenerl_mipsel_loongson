Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Sep 2016 11:34:32 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:17289 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991965AbcI3JeBB11Le (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Sep 2016 11:34:01 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 527AACFEC27B7;
        Fri, 30 Sep 2016 10:33:52 +0100 (IST)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL03.hh.imgtec.org (10.44.0.22) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 30 Sep 2016 10:33:54 +0100
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Subject: [PATCH 2/2] MIPS: tracing: disable uprobe/kprobe on compact branch instructions
Date:   Fri, 30 Sep 2016 11:33:46 +0200
Message-ID: <1475228026-25831-2-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1475228026-25831-1-git-send-email-marcin.nowakowski@imgtec.com>
References: <1475228026-25831-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

Current instruction decoder for uprobe/kprobe handler only handles
branches with delay slots. For compact branches the behaviour is rather
unpredictable - and depending on the encoding of a compact branch
instruction may result in one (or more) of:
- executing an instruction that follows a branch which wasn't in a delay
  slot and shouldn't have been executed
- incorrectly emulating a branch leading to a jump to a wrong location
- unexpected branching out of the single-stepped code and never reaching
  the breakpoint that should terminate the probe handler

Results of these actions are generally unpredictable, but can end up
with a probed application or kernel crash, so disable placing probes on
compact branches until they are handled properly.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 arch/mips/kernel/branch.c        | 34 ++++++++++++++++++++++++++++++++++
 arch/mips/kernel/kprobes.c       |  6 ++++++
 arch/mips/kernel/probes-common.h |  2 ++
 arch/mips/kernel/uprobes.c       |  6 ++++++
 4 files changed, 48 insertions(+)

diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index 46c227f..c3dce43 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -866,3 +866,37 @@ unaligned:
 	force_sig(SIGBUS, current);
 	return -EFAULT;
 }
+
+#if (defined CONFIG_KPROBES) || (defined CONFIG_UPROBES)
+
+int __insn_is_compact_branch(union mips_instruction insn)
+{
+	if (!cpu_has_mips_r6)
+		return 0;
+
+	switch (insn.i_format.opcode) {
+	case blezl_op:
+	case bgtzl_op:
+	case blez_op:
+	case bgtz_op:
+		/*
+		 * blez[l] and bgtz[l] opcodes with non-zero rt
+		 * are MIPS R6 compact branches
+		 */
+		if (insn.i_format.rt)
+			return 1;
+		break;
+	case bc6_op:
+	case balc6_op:
+	case pop10_op:
+	case pop30_op:
+	case pop66_op:
+	case pop76_op:
+		return 1;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__insn_is_compact_branch);
+
+#endif  /* CONFIG_KPROBES || CONFIG_UPROBES */
diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
index 747e3bf..f5c8bce 100644
--- a/arch/mips/kernel/kprobes.c
+++ b/arch/mips/kernel/kprobes.c
@@ -106,6 +106,12 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 		goto out;
 	}
 
+	if (__insn_is_compact_branch(insn)) {
+		pr_notice("Kprobes for compact branches are not supported\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
 	/* insn: must be on special executable page on mips. */
 	p->ainsn.insn = get_insn_slot();
 	if (!p->ainsn.insn) {
diff --git a/arch/mips/kernel/probes-common.h b/arch/mips/kernel/probes-common.h
index c979c37..dd08e41 100644
--- a/arch/mips/kernel/probes-common.h
+++ b/arch/mips/kernel/probes-common.h
@@ -13,6 +13,8 @@
 
 #include <asm/inst.h>
 
+int __insn_is_compact_branch(union mips_instruction insn);
+
 static inline int __insn_has_delay_slot(const union mips_instruction insn)
 {
 	switch (insn.i_format.opcode) {
diff --git a/arch/mips/kernel/uprobes.c b/arch/mips/kernel/uprobes.c
index a30ca7b..d3c82ad 100644
--- a/arch/mips/kernel/uprobes.c
+++ b/arch/mips/kernel/uprobes.c
@@ -36,6 +36,12 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *aup,
 		return -EINVAL;
 
 	inst.word = aup->insn[0];
+
+	if (__insn_is_compact_branch(inst)) {
+		pr_notice("Uprobes for compact branches are not supported\n");
+		return -EINVAL;
+	}
+
 	aup->ixol[0] = aup->insn[insn_has_delay_slot(inst)];
 	aup->ixol[1] = UPROBE_BRK_UPROBE_XOL;		/* NOP  */
 
-- 
2.7.4
