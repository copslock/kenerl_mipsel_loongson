Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Aug 2017 20:21:45 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64922 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993924AbdHWSUyRlybI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Aug 2017 20:20:54 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id CEF66BEC8CD44;
        Wed, 23 Aug 2017 19:20:43 +0100 (IST)
Received: from localhost (10.20.1.88) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 23 Aug 2017 19:20:47
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        <trivial@kernel.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 08/11] MIPS: math-emu: Correct user fault_addr type
Date:   Wed, 23 Aug 2017 11:17:51 -0700
Message-ID: <20170823181754.24044-9-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170823181754.24044-1-paul.burton@imgtec.com>
References: <20170823181754.24044-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59784
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

The fault_addr argument to fpu_emulator_cop1Handler(), fpux_emu() and
cop1Emulate() has up until now been declared as:

  void *__user *fault_addr

This is essentially a pointer in user memory which points to a pointer
to void. This is not the intent for our code, which is actually
operating on a pointer to a pointer to void where the pointer to void is
pointing at user memory. ie. the pointer is in kernel memory & points to
user memory.

This mismatch produces a lot of sparse warnings that look like this:

arch/mips/math-emu/cp1emu.c:1485:45:
   warning: incorrect type in assignment (different address spaces)
      expected void *[noderef] <asn:1><noident>
      got unsigned int [noderef] [usertype] <asn:1>*[assigned] va

Fix these by modifying the declaration of the fault_addr argument to:

  void __user **fault_addr

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/fpu_emulator.h | 2 +-
 arch/mips/math-emu/cp1emu.c          | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/fpu_emulator.h b/arch/mips/include/asm/fpu_emulator.h
index c05369e0b8d6..8e50fa3623e3 100644
--- a/arch/mips/include/asm/fpu_emulator.h
+++ b/arch/mips/include/asm/fpu_emulator.h
@@ -62,7 +62,7 @@ do {									\
 
 extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
 				    struct mips_fpu_struct *ctx, int has_fpu,
-				    void *__user *fault_addr);
+				    void __user **fault_addr);
 void force_fcr31_sig(unsigned long fcr31, void __user *fault_addr,
 		     struct task_struct *tsk);
 int process_fpemu_return(int sig, void __user *fault_addr,
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index f08a7b4facb9..24d873a03327 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -58,7 +58,7 @@ static int fpu_emu(struct pt_regs *, struct mips_fpu_struct *,
 	mips_instruction);
 
 static int fpux_emu(struct pt_regs *,
-	struct mips_fpu_struct *, mips_instruction, void *__user *);
+	struct mips_fpu_struct *, mips_instruction, void __user **);
 
 /* Control registers */
 
@@ -973,7 +973,7 @@ static inline void cop1_ctc(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
  */
 
 static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
-		struct mm_decoded_insn dec_insn, void *__user *fault_addr)
+		struct mm_decoded_insn dec_insn, void __user **fault_addr)
 {
 	unsigned long contpc = xcp->cp0_epc + dec_insn.pc_inc;
 	unsigned int cond, cbit, bit0;
@@ -1460,7 +1460,7 @@ DEF3OP(nmadd, dp, ieee754dp_mul, ieee754dp_add, ieee754dp_neg);
 DEF3OP(nmsub, dp, ieee754dp_mul, ieee754dp_sub, ieee754dp_neg);
 
 static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
-	mips_instruction ir, void *__user *fault_addr)
+	mips_instruction ir, void __user **fault_addr)
 {
 	unsigned rcsr = 0;	/* resulting csr */
 
@@ -2553,7 +2553,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
  * For simplicity we always terminate upon an ISA mode switch.
  */
 int fpu_emulator_cop1Handler(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
-	int has_fpu, void *__user *fault_addr)
+	int has_fpu, void __user **fault_addr)
 {
 	unsigned long oldepc, prevepc;
 	struct mm_decoded_insn dec_insn;
-- 
2.14.1
