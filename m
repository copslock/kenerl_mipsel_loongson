Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:26:40 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025262AbbDCWY3BcBbu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:24:29 +0200
Date:   Fri, 3 Apr 2015 23:24:29 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 11/48] MIPS: Correct the comment for and reformat
 `movf_func'
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504030229500.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

Correct a copy-and-paste issue with the description for `movf_func' 
referring to `movt_func'.  Reformat the former function to match the 
latter.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-r6-movf-comment.patch
Index: linux/arch/mips/kernel/mips-r2-to-r6-emul.c
===================================================================
--- linux.orig/arch/mips/kernel/mips-r2-to-r6-emul.c	2015-04-02 20:18:51.890522000 +0100
+++ linux/arch/mips/kernel/mips-r2-to-r6-emul.c	2015-04-02 20:27:53.338178000 +0100
@@ -187,7 +187,7 @@ static inline int mipsr6_emul(struct pt_
 }
 
 /**
- * movt_func - Emulate a MOVT instruction
+ * movf_func - Emulate a MOVF instruction
  * @regs: Process register set
  * @ir: Instruction
  *
@@ -200,9 +200,12 @@ static int movf_func(struct pt_regs *reg
 
 	csr = current->thread.fpu.fcr31;
 	cond = fpucondbit[MIPSInst_RT(ir) >> 2];
+
 	if (((csr & cond) == 0) && MIPSInst_RD(ir))
 		regs->regs[MIPSInst_RD(ir)] = regs->regs[MIPSInst_RS(ir)];
+
 	MIPS_R2_STATS(movs);
+
 	return 0;
 }
 
