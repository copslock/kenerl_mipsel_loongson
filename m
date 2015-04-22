Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Apr 2015 19:24:08 +0200 (CEST)
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:53432 "EHLO
        ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025940AbbDVRYHTO0cR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Apr 2015 19:24:07 +0200
Received: from localhost (localhost [127.0.0.1])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 4464A460812
        for <linux-mips@linux-mips.org>; Wed, 22 Apr 2015 18:24:03 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
        by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id prvO9YCnXkUL for <linux-mips@linux-mips.org>;
        Wed, 22 Apr 2015 18:24:01 +0100 (BST)
Received: from pm-laptop.codethink.co.uk (pm-laptop.dyn.ducie.codethink.co.uk [10.24.1.94])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id D3E4146080C
        for <linux-mips@linux-mips.org>; Wed, 22 Apr 2015 18:24:00 +0100 (BST)
Received: from localhost ([::1] helo=paulmartin.codethink.co.uk)
        by pm-laptop.codethink.co.uk with esmtp (Exim 4.84)
        (envelope-from <paul.martin@codethink.co.uk>)
        id 1YkyNU-0005yD-FF
        for linux-mips@linux-mips.org; Wed, 22 Apr 2015 18:24:00 +0100
Date:   Wed, 22 Apr 2015 18:24:00 +0100
From:   Paul Martin <paul.martin@codethink.co.uk>
To:     linux-mips@linux-mips.org
Subject: [RFC] MIPS: Prevent "BUG: using smp_processor_id() in
 preemptible..." errors
Message-ID: <20150422172359.GA20553@paulmartin.codethink.co.uk>
Mail-Followup-To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <paul.martin@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47009
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.martin@codethink.co.uk
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

Commit 9b26616c8d9dae53fbac7f7cb2c6dd1308102976 "MIPS: Respect the ISA
level in FCSR handling" added references to current_cpu_data, which is
a macro expanding to cpu_data[smp_processor_id()].  Change these to
raw_current_cpu_data.

These changes may or may not be a good idea.

There may also be a need for a similar change in
arch/mips/kernel/ptrace.c which I haven't made.

---
 arch/mips/include/asm/elf.h | 4 ++--
 arch/mips/math-emu/cp1emu.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index a594d8e..63f3bbc 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -304,7 +304,7 @@ do {									\
 									\
 	current->thread.abi = &mips_abi;				\
 									\
-	current->thread.fpu.fcr31 = current_cpu_data.fpu_csr31;		\
+	current->thread.fpu.fcr31 = raw_current_cpu_data.fpu_csr31;	\
 } while (0)
 
 #endif /* CONFIG_32BIT */
@@ -366,7 +366,7 @@ do {									\
 	else								\
 		current->thread.abi = &mips_abi;			\
 									\
-	current->thread.fpu.fcr31 = current_cpu_data.fpu_csr31;		\
+	current->thread.fpu.fcr31 = raw_current_cpu_data.fpu_csr31;	\
 									\
 	p = personality(current->personality);				\
 	if (p != PER_LINUX32 && p != PER_LINUX)				\
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index d31c537..52ea70c 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -921,7 +921,7 @@ static inline void cop1_ctc(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			 (void *)xcp->cp0_epc, MIPSInst_RT(ir), value);
 
 		/* Preserve read-only bits.  */
-		mask = current_cpu_data.fpu_msk31;
+		mask = raw_current_cpu_data.fpu_msk31;
 		fcr31 = (value & ~mask) | (fcr31 & mask);
 		break;
 
-- 
2.1.4



-- 
Paul Martin                                  http://www.codethink.co.uk/
Senior Software Developer, Codethink Ltd.
