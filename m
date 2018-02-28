Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2018 17:15:28 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53694 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994032AbeB1QPNbe0az (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Feb 2018 17:15:13 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1er3Yt-0006Xe-Gp; Wed, 28 Feb 2018 15:22:31 +0000
Received: from ben by deadeye with local (Exim 4.90_1)
        (envelope-from <ben@decadent.org.uk>)
        id 1er3Yg-0008WF-7V; Wed, 28 Feb 2018 15:22:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org, "Ralf Baechle" <ralf@linux-mips.org>
Date:   Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.799017230@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 097/254] MIPS: Always clear FCSR cause bits after
 emulation
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62750
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Maciej W. Rozycki" <macro@linux-mips.org>

commit 443c44032a54f9acf027a8e688380fddc809bc19 upstream.

Clear any FCSR cause bits recorded in the saved FPU context after
emulation in all cases rather than in `do_fpe' only, so that any
unmasked IEEE 754 exception left from emulation does not cause a fatal
kernel-mode FPE hardware exception with the CTC1 instruction used by the
kernel to subsequently restore FCSR hardware from the saved FPU context.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9704/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[bwh: Backported to 3.16: drop changes in mips-r2-to-r6-emul and simulate_fp()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -775,7 +775,7 @@ asmlinkage void do_fpe(struct pt_regs *r
 
 		/*
 		 * We can't allow the emulated instruction to leave any of
-		 * the cause bit set in $fcr31.
+		 * the cause bits set in $fcr31.
 		 */
 		current->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;
 
@@ -1292,6 +1292,13 @@ asmlinkage void do_cpu(struct pt_regs *r
 			sig = fpu_emulator_cop1Handler(regs,
 						       &current->thread.fpu,
 						       0, &fault_addr);
+
+			/*
+			 * We can't allow the emulated instruction to leave
+			 * any of the cause bits set in $fcr31.
+			 */
+			current->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;
+
 			if (!process_fpemu_return(sig, fault_addr) && !err)
 				mt_ase_fp_affinity();
 		}
