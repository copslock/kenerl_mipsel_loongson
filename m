Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:35:49 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025307AbbDCW1VoKFNs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:27:21 +0200
Date:   Fri, 3 Apr 2015 23:27:21 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips@linux-mips.org
Subject: [PATCH 42/48] MIPS: Correct ISA masking in FPU feature
 determination
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504032044280.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46759
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

Correct an ISA level determination problem introduced with 8b8aa636 
[MIPS: kernel: cpu-probe.c: Add support for MIPS R6], reverting explicit 
masking against individual `MIPS_CPU_ISA_*' macros in FPU feature 
determination.

Feature macros such as `cpu_has_mips_r' cannot be used here, because 
they operate on CPU #0 and we want to refer to the current CPU instead.  
They cannot be used for masking against the current CPU either because 
they mask against CPU #0 too, e.g.:

# define cpu_has_mips32r1	(cpu_data[0].isa_level & MIPS_CPU_ISA_M32R1)

Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-fpu-probe-isa.diff
Index: linux/arch/mips/kernel/cpu-probe.c
===================================================================
--- linux.orig/arch/mips/kernel/cpu-probe.c	2015-04-02 20:27:52.971189000 +0100
+++ linux/arch/mips/kernel/cpu-probe.c	2015-04-02 20:27:58.700229000 +0100
@@ -1367,7 +1367,9 @@ void cpu_probe(void)
 	if (c->options & MIPS_CPU_FPU) {
 		c->fpu_id = cpu_get_fpu_id();
 
-		if (c->isa_level & cpu_has_mips_r) {
+		if (c->isa_level & (MIPS_CPU_ISA_M32R1 | MIPS_CPU_ISA_M64R1 |
+				    MIPS_CPU_ISA_M32R2 | MIPS_CPU_ISA_M64R2 |
+				    MIPS_CPU_ISA_M32R6 | MIPS_CPU_ISA_M64R6)) {
 			if (c->fpu_id & MIPS_FPIR_3D)
 				c->ases |= MIPS_ASE_MIPS3D;
 			if (c->fpu_id & MIPS_FPIR_FREP)
