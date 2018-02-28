Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2018 17:15:02 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53661 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992869AbeB1QOx09Plz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Feb 2018 17:14:53 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1er3Yt-0006XW-4a; Wed, 28 Feb 2018 15:22:31 +0000
Received: from ben by deadeye with local (Exim 4.90_1)
        (envelope-from <ben@decadent.org.uk>)
        id 1er3Yg-00004y-BG; Wed, 28 Feb 2018 15:22:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ralf Baechle" <ralf@linux-mips.org>,
        "Ezequiel Garcia" <ezequiel.garcia@imgtec.com>,
        "Markos Chandras" <Markos.Chandras@imgtec.com>,
        "Paul Martin" <paul.martin@codethink.co.uk>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org, "James Hogan" <james.hogan@imgtec.com>
Date:   Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.158675123@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 101/254] MIPS: Fix a preemption issue with thread's
 FPU defaults
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62749
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

commit 03dce595270f22d59a6f37e9170287c1afd94bc2 upstream.

Fix "BUG: using smp_processor_id() in preemptible" reported in accesses
to thread's FPU defaults: the value to initialise FSCR to at program
startup, the FCSR r/w mask and the contents of FIR in full FPU
emulation, removing a regression introduced with 9b26616c [MIPS: Respect
the ISA level in FCSR handling] and f6843626 [MIPS: math-emu: Set FIR
feature flags for full emulation].

Use `boot_cpu_data' to obtain the data from, following the approach that
`cpu_has_*' macros take and avoiding the call to `smp_processor_id' made
in the reference to `current_cpu_data'.  The contents of FSCR have to be
consistent across processors in an SMP system, the settings there must
not change as a thread is migrated across processors.  And the contents
of FIR are guaranteed to be consistent in FPU emulation, by definition.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Tested-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Tested-by: Paul Martin <paul.martin@codethink.co.uk>
Cc: Markos Chandras <Markos.Chandras@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10030/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[bwh: Backported to 3.16:
 - Drop change in cop1_cfc()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -277,7 +277,7 @@ do {									\
 									\
 	current->thread.abi = &mips_abi;				\
 									\
-	current->thread.fpu.fcr31 = current_cpu_data.fpu_csr31;		\
+	current->thread.fpu.fcr31 = boot_cpu_data.fpu_csr31;		\
 } while (0)
 
 #endif /* CONFIG_32BIT */
@@ -337,7 +337,7 @@ do {									\
 	else								\
 		current->thread.abi = &mips_abi;			\
 									\
-	current->thread.fpu.fcr31 = current_cpu_data.fpu_csr31;		\
+	current->thread.fpu.fcr31 = boot_cpu_data.fpu_csr31;		\
 									\
 	p = personality(current->personality);				\
 	if (p != PER_LINUX32 && p != PER_LINUX)				\
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -177,7 +177,7 @@ int ptrace_setfpregs(struct task_struct
 
 	__get_user(value, data + 64);
 	fcr31 = child->thread.fpu.fcr31;
-	mask = current_cpu_data.fpu_msk31;
+	mask = boot_cpu_data.fpu_msk31;
 	child->thread.fpu.fcr31 = (value & ~mask) | (fcr31 & mask);
 
 	/* FIR may not be written.  */
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -934,7 +934,7 @@ emul:
 				 * Preserve read-only bits,
 				 * and convert to ieee library modes
 				 */
-				mask = current_cpu_data.fpu_msk31;
+				mask = boot_cpu_data.fpu_msk31;
 				ctx->fcr31 = (value & ~(mask | FPU_CSR_RM)) |
 					     (ctx->fcr31 & mask) |
 					     modeindex(value);
