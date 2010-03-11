Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Mar 2010 06:42:40 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:50512 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491775Ab0CKFmg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Mar 2010 06:42:36 +0100
Received: from localhost.localdomain (pek-lpgbuild1.wrs.com [128.224.153.29])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o2B5gO9A011081;
        Wed, 10 Mar 2010 21:42:28 -0800 (PST)
From:   Yang Shi <yang.shi@windriver.com>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Fix elfcore.c build warning
Date:   Thu, 11 Mar 2010 13:42:22 +0800
Message-Id: <1268286142-20615-1-git-send-email-yang.shi@windriver.com>
X-Mailer: git-send-email 1.6.0.4
Return-Path: <yang.shi@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26197
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
Precedence: bulk
X-list: linux-mips

kernel/elfcore.c includes elf.h which includes arch specific elf.h.
In MIPS elf.h, 'struct pt_regs' is declared inside the parameter
list of elf_dump_regs function. This cause kernel build warning.

So, move the declaration out of the function parameter list to
remove build warning.

Signed-off-by: Yang Shi <yang.shi@windriver.com>
---
 arch/mips/include/asm/elf.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index e53d7be..370bf50 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -311,8 +311,9 @@ do {									\
 #endif /* CONFIG_64BIT */
 
 struct task_struct;
+struct pt_regs;
 
-extern void elf_dump_regs(elf_greg_t *, struct pt_regs *regs);
+extern void elf_dump_regs(elf_greg_t *, struct pt_regs *);
 extern int dump_task_regs(struct task_struct *, elf_gregset_t *);
 extern int dump_task_fpu(struct task_struct *, elf_fpregset_t *);
 
-- 
1.6.3.3
