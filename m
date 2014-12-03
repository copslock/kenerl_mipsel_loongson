Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Dec 2014 00:45:26 +0100 (CET)
Received: from mail-ie0-f178.google.com ([209.85.223.178]:33637 "EHLO
        mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008073AbaLCXodUAHTx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Dec 2014 00:44:33 +0100
Received: by mail-ie0-f178.google.com with SMTP id tp5so14846217ieb.37
        for <multiple recipients>; Wed, 03 Dec 2014 15:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GtNxAxkrbJvzGGXz5fw8tuv0nzRG0uUF5c0Qsv44Ts4=;
        b=TFobz99jtrg5N0Zv4epqLTeHDpR+npEF0Addk57uxCoQWA83aAVAa7SXsCnVq3cudQ
         EzxzGhEjKEUmpI+jpYhxFgbfzWmi/ZCRS0jt7OYe7BU4hCBOguOxtcMRQJlo73p+yIDF
         c6h9sZP8uf69ZfA6gEOvX5fyIg9tqZezxRkF61h/AqDffCr0cAz8tT3Sdt0hV4DqldDg
         DtQCP/c84KiGeIFJPq5B6/zF24+WapOrDxxVDvHn4CJVAGVqCAyjxyEpcB0e3g4cm5kE
         u9K7D3ZlHMYZszOtntCPOm2pKAVigwkpstfn0RnKCrD2+FFsScZm+24FtT4EzHupdl5f
         XOEA==
X-Received: by 10.50.12.97 with SMTP id x1mr1526681igb.48.1417650267816;
        Wed, 03 Dec 2014 15:44:27 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id c1sm19413590igo.17.2014.12.03.15.44.26
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 03 Dec 2014 15:44:27 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id sB3NiQKk002861;
        Wed, 3 Dec 2014 15:44:26 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id sB3NiPGW002860;
        Wed, 3 Dec 2014 15:44:25 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Zubair.Kakakhel@imgtec.com, geert+renesas@glider.be,
        peterz@infradead.org, paul.gortmaker@windriver.com,
        macro@linux-mips.org, chenhc@lemote.com, cl@linux.com,
        mingo@kernel.org, richard@nod.at, zajec5@gmail.com,
        james.hogan@imgtec.com, keescook@chromium.org, tj@kernel.org,
        alex@alex-smith.me.uk, pbonzini@redhat.com, blogic@openwrt.org,
        paul.burton@imgtec.com, qais.yousef@imgtec.com,
        linux-kernel@vger.kernel.org, markos.chandras@imgtec.com,
        dengcheng.zhu@imgtec.com, manuel.lauss@gmail.com,
        lars.persson@axis.com, David Daney <david.daney@cavium.com>
Subject: [PATCH 3/3] MIPS: Use full instruction emulation for FPU emulator delay slot emulation.
Date:   Wed,  3 Dec 2014 15:44:18 -0800
Message-Id: <1417650258-2811-4-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1417650258-2811-1-git-send-email-ddaney.cavm@gmail.com>
References: <1417650258-2811-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

Current delay slot handling does eXecute Out of Line (XOL) on the
stack, which prevents a non-executable stack.  Use the instruction
emulator instead.

Tested by booting 32-bit Debian on OCTEON.  More than 1700
instructions emulated to login to command line.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/math-emu/cp1emu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index cac529a..787de7a 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -694,11 +694,12 @@ do {									\
  * Emulate the single floating point instruction pointed at by EPC.
  * Two instructions if the instruction is in a branch delay slot.
  */
-
+int mips_insn_emul(struct pt_regs *regs, mips_instruction ir, void *__user *fault_addr);
 static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 		struct mm_decoded_insn dec_insn, void *__user *fault_addr)
 {
 	unsigned long contpc = xcp->cp0_epc + dec_insn.pc_inc;
+	unsigned long origpc = xcp->cp0_epc;
 	unsigned int cond, cbit;
 	mips_instruction ir;
 	int likely, pc_inc;
@@ -1038,7 +1039,15 @@ emul:
 				 * Single step the non-cp1
 				 * instruction in the dslot
 				 */
-				return mips_dsemul(xcp, ir, contpc);
+				sig = mips_insn_emul(xcp, ir, fault_addr);
+				if (sig == 0) {
+					xcp->cp0_epc = contpc;
+					MIPS_FPU_EMU_INC_STATS(insn_emul);
+				} else {
+					xcp->cp0_epc = origpc;
+					pr_err("mips_insn_emul: %08x ->%d\n", (unsigned)ir, sig);
+				}
+				return sig;
 			} else if (likely) {	/* branch not taken */
 					/*
 					 * branch likely nullifies
-- 
1.7.11.7
