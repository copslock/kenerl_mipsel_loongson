Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Apr 2014 23:06:31 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:32860 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816288AbaDFVG2jR9j8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Apr 2014 23:06:28 +0200
Date:   Sun, 6 Apr 2014 22:06:28 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH] DEC: Remove the Halt button interrupt on R4k systems
Message-ID: <alpine.LFD.2.11.1404062155000.15266@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39671
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

On R4k DECstations the Halt button is wired to the NMI processor input 
rather than an ordinary interrupt input such as on R3k DECstations.  This 
is possible with a different design of the CPU daughtercard that routes 
the Halt button line from the baseboard connector.  Additionally the 
interrupt input has been reused for a different purpose on the KN04 and 
KN05 R4k CPU daughtercards so it is better kept masked.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-dec-r4k-halt.patch
Index: linux-20140404-4maxp64/arch/mips/dec/setup.c
===================================================================
--- linux-20140404-4maxp64.orig/arch/mips/dec/setup.c
+++ linux-20140404-4maxp64/arch/mips/dec/setup.c
@@ -23,6 +23,7 @@
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
 #include <asm/cpu-features.h>
+#include <asm/cpu-type.h>
 #include <asm/irq.h>
 #include <asm/irq_cpu.h>
 #include <asm/mipsregs.h>
@@ -748,6 +749,10 @@ void __init arch_init_irq(void)
 		cpu_fpu_mask = 0;
 		dec_interrupt[DEC_IRQ_FPU] = -1;
 	}
+	/* Free the halt interrupt unused on R4k systems.  */
+	if (current_cpu_type() == CPU_R4000SC ||
+	    current_cpu_type() == CPU_R4400SC)
+		dec_interrupt[DEC_IRQ_HALT] = -1;
 
 	/* Register board interrupts: FPU and cascade. */
 	if (dec_interrupt[DEC_IRQ_FPU] >= 0)
