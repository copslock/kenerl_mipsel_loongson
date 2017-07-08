Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Jul 2017 00:24:52 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59436 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993423AbdGHWYo0iZvn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 9 Jul 2017 00:24:44 +0200
Date:   Sat, 8 Jul 2017 23:24:44 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org, stable@vger.kernel.org
Subject: [PATCH] MIPS: Fix MIPS I ISA /proc/cpuinfo reporting
Message-ID: <alpine.LFD.2.20.1707082259380.5208@eddie.linux-mips.org>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59071
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

Correct a commit 515a6393dbac ("MIPS: kernel: proc: Add MIPS R6 support 
to /proc/cpuinfo") regression that caused MIPS I systems to show no ISA 
levels supported in /proc/cpuinfo, e.g.:

system type		: Digital DECstation 2100/3100
machine			: Unknown
processor		: 0
cpu model		: R3000 V2.0  FPU V2.0
BogoMIPS		: 10.69
wait instruction	: no
microsecond timers	: no
tlb_entries		: 64
extra interrupt vector	: no
hardware watchpoint	: no
isa			:
ASEs implemented	:
shadow register sets	: 1
kscratch registers	: 0
package			: 0
core			: 0
VCED exceptions		: not available
VCEI exceptions		: not available

and similarly exclude `mips1' from the ISA list for any processors below 
MIPSr1.  This is because the condition to show `mips1' on has been made 
`cpu_has_mips_r1' rather than newly-introduced `cpu_has_mips_1'.  Use 
the correct condition then.

Cc: stable@vger.kernel.org # 3.19+
Fixes: 515a6393dbac ("MIPS: kernel: proc: Add MIPS R6 support to /proc/cpuinfo")
Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 arch/mips/kernel/proc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

linux-mips-proc-cpuinfo-isa-i.diff
Index: linux-sfr-3maxp/arch/mips/kernel/proc.c
===================================================================
--- linux-sfr-3maxp.orig/arch/mips/kernel/proc.c
+++ linux-sfr-3maxp/arch/mips/kernel/proc.c
@@ -83,7 +83,7 @@ static int show_cpuinfo(struct seq_file 
 	}
 
 	seq_printf(m, "isa\t\t\t:"); 
-	if (cpu_has_mips_r1)
+	if (cpu_has_mips_1)
 		seq_printf(m, " mips1");
 	if (cpu_has_mips_2)
 		seq_printf(m, "%s", " mips2");
