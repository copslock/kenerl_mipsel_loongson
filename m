Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Aug 2012 19:42:33 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48076 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903559Ab2HORm0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Aug 2012 19:42:26 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q7FHgMKm010478;
        Wed, 15 Aug 2012 19:42:22 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q7FHgJ9Z010477;
        Wed, 15 Aug 2012 19:42:19 +0200
Date:   Wed, 15 Aug 2012 19:42:19 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jayachandran C <jchandra@broadcom.com>,
        David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Fix for warning from FPU emulation code
Message-ID: <20120815174219.GB4222@linux-mips.org>
References: <20120814133858.GA30856@linux-mips.org>
 <1344960220-30068-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1344960220-30068-1-git-send-email-jchandra@broadcom.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34181
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Aug 14, 2012 at 09:33:40PM +0530, Jayachandran C wrote:

> The default implementation of 'cpu_has_fpu' macro calls
> smp_processor_id() which causes this warning to be printed when
> preemption is enabled:
> 
> [    4.664000] Algorithmics/MIPS FPU Emulator v1.5
> [    4.676000] BUG: using smp_processor_id() in preemptible [00000000] code: ini
> [    4.700000] caller is fpu_emulator_cop1Handler+0x434/0x27b8
> 
> Use 'raw_cpu_has_fpu' macro in cop1_64bit() instead of 'cpu_has_fpu'
> to fix this. Fix suggested by Ralf Baechle <ralf@linux-mips.org>

I think your patch was 34K-ly correct but I never managed to convince
myself that it really was and anyway, cpu_has_fpu expands into too much
code for the runtime detection case.  With below patch all platforms I
tested have either unchanged or smaller code size depending on the
kernel configuration.

The whole problem got introduced in November 2009 by
af1d2af877ef6c36990671bc86a5b9c5bb50b1da (lmo) [MIPS: Fix emulation of
64-bit FPU on 64-bit CPUs.] rsp.  da0bac33413b2888d3623dad3ad19ce76b688f07
(kernel.org) [MIPS: Fix emulation of 64-bit FPU on FPU-less 64-bit CPUs.]
in 2.6.32.

  Ralf

 arch/mips/math-emu/cp1emu.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index a03bf00..47c77e7 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -171,16 +171,17 @@ static int isBranchInstr(mips_instruction * i)
  * In the Linux kernel, we support selection of FPR format on the
  * basis of the Status.FR bit.  If an FPU is not present, the FR bit
  * is hardwired to zero, which would imply a 32-bit FPU even for
- * 64-bit CPUs.  For 64-bit kernels with no FPU we use TIF_32BIT_REGS
- * as a proxy for the FR bit so that a 64-bit FPU is emulated.  In any
- * case, for a 32-bit kernel which uses the O32 MIPS ABI, only the
- * even FPRs are used (Status.FR = 0).
+ * 64-bit CPUs so we rather look at TIF_32BIT_REGS.
+ * FPU emu is slow and bulky and optimizing this function offers fairly
+ * sizeable benefits so we try to be clever and make this function return
+ * a constant whenever possible, that is on 64-bit kernels without O32
+ * compatibility enabled and on 32-bit kernels.
  */
 static inline int cop1_64bit(struct pt_regs *xcp)
 {
-	if (cpu_has_fpu)
-		return xcp->cp0_status & ST0_FR;
-#ifdef CONFIG_64BIT
+#if defined(CONFIG_64BIT) && !defined(CONFIG_MIPS32_O32)
+	return 1;
+#elif defined(CONFIG_64BIT) && defined(CONFIG_MIPS32_O32)
 	return !test_thread_flag(TIF_32BIT_REGS);
 #else
 	return 0;
