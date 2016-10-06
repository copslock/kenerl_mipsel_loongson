Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Oct 2016 10:54:30 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:37668 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990518AbcJFIyWwaWKo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Oct 2016 10:54:22 +0200
Received: from localhost (unknown [62.214.2.210])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 779EC904;
        Thu,  6 Oct 2016 08:54:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 33/93] MIPS: uprobes: remove incorrect set_orig_insn
Date:   Thu,  6 Oct 2016 10:29:03 +0200
Message-Id: <20161006074732.529599894@linuxfoundation.org>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161006074731.150212126@linuxfoundation.org>
References: <20161006074731.150212126@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>

commit ddabfa5c2e33f1b495f3e0176de7057850915c0b upstream.

Generic kernel code implements a weak version of set_orig_insn that
moves cached 'insn' from arch_uprobe to the original code location when
the trap is removed.
MIPS variant used arch_uprobe->orig_inst which was never initialised
properly, so this code only inserted a nop instead of the original
instruction. With that change orig_inst can also be safely removed.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Fixes: 40e084a506eb ('MIPS: Add uprobes support.')
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14299/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/uprobes.h |    1 -
 arch/mips/kernel/uprobes.c      |   18 ------------------
 2 files changed, 19 deletions(-)

--- a/arch/mips/include/asm/uprobes.h
+++ b/arch/mips/include/asm/uprobes.h
@@ -36,7 +36,6 @@ struct arch_uprobe {
 	unsigned long	resume_epc;
 	u32	insn[2];
 	u32	ixol[2];
-	union	mips_instruction orig_inst[MAX_UINSN_BYTES / 4];
 };
 
 struct arch_uprobe_task {
--- a/arch/mips/kernel/uprobes.c
+++ b/arch/mips/kernel/uprobes.c
@@ -280,24 +280,6 @@ int __weak set_swbp(struct arch_uprobe *
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
