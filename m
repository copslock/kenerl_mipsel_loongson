Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Sep 2016 15:39:41 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:58914 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992197AbcIVNitiSU2r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Sep 2016 15:38:49 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 6ACE5303A5B79;
        Thu, 22 Sep 2016 14:38:40 +0100 (IST)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 22 Sep 2016 14:38:43 +0100
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Subject: [PATCH 2/3] MIPS: uprobes: remove incorrect set_orig_insn
Date:   Thu, 22 Sep 2016 15:38:32 +0200
Message-ID: <1474551513-30647-3-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1474551513-30647-1-git-send-email-marcin.nowakowski@imgtec.com>
References: <1474551513-30647-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55234
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

Generic kernel code implements a weak version of set_orig_insn that
moves cached 'insn' from arch_uprobe to the original code location when
the trap is removed.
MIPS variant used arch_uprobe->orig_inst which was never initialised
properly, so this code only inserted a nop instead of the original
instruction. With that change orig_inst can also be safely removed.

Fixes: 40e084a506eb ('MIPS: Add uprobes support.')
Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 arch/mips/include/asm/uprobes.h |  1 -
 arch/mips/kernel/uprobes.c      | 18 ------------------
 2 files changed, 19 deletions(-)

diff --git a/arch/mips/include/asm/uprobes.h b/arch/mips/include/asm/uprobes.h
index 28ab364..b86d1ae 100644
--- a/arch/mips/include/asm/uprobes.h
+++ b/arch/mips/include/asm/uprobes.h
@@ -36,7 +36,6 @@ struct arch_uprobe {
 	unsigned long	resume_epc;
 	u32	insn[2];
 	u32	ixol[2];
-	union	mips_instruction orig_inst[MAX_UINSN_BYTES / 4];
 };
 
 struct arch_uprobe_task {
diff --git a/arch/mips/kernel/uprobes.c b/arch/mips/kernel/uprobes.c
index cd8a689..3b8accb 100644
--- a/arch/mips/kernel/uprobes.c
+++ b/arch/mips/kernel/uprobes.c
@@ -280,24 +280,6 @@ int __weak set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	return uprobe_write_opcode(mm, vaddr, UPROBE_SWBP_INSN);
 }
 
-/**
- * set_orig_insn - Restore the original instruction.
- * @mm: the probed process address space.
- * @auprobe: arch specific probepoint information.
- * @vaddr: the virtual address to insert the opcode.
- *
- * For mm @mm, restore the original opcode (opcode) at @vaddr.
- * Return 0 (success) or a negative errno.
- *
- * This overrides the weak version in kernel/events/uprobes.c.
- */
-int set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
-		 unsigned long vaddr)
-{
-	return uprobe_write_opcode(mm, vaddr,
-			*(uprobe_opcode_t *)&auprobe->orig_inst[0].word);
-}
-
 void __weak arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 				  void *src, unsigned long len)
 {
-- 
2.7.4
