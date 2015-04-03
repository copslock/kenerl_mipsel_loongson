Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:33:13 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025298AbbDCW0chAHdo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:26:32 +0200
Date:   Fri, 3 Apr 2015 23:26:32 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 33/48] MIPS: Fix BREAK code interpretation heuristics
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504031639230.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46750
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

Do not lose the other half of the BREAK code where there is an upper 
half.  This is so that e.g. `BREAK 7, 7' is not interpreted as a divide 
by zero trap, while `BREAK 0, 7' or `BREAK 7, 0' still are.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-do-bp-code.diff
Index: linux/arch/mips/kernel/traps.c
===================================================================
--- linux.orig/arch/mips/kernel/traps.c	2015-04-02 20:27:56.780209000 +0100
+++ linux/arch/mips/kernel/traps.c	2015-04-02 20:27:56.948213000 +0100
@@ -943,7 +943,7 @@ asmlinkage void do_bp(struct pt_regs *re
 	 * We handle both cases with a simple heuristics.  --macro
 	 */
 	if (bcode >= (1 << 10))
-		bcode >>= 10;
+		bcode = ((bcode & ((1 << 10) - 1)) << 10) | (bcode >> 10);
 
 	/*
 	 * notify the kprobe handlers, if instruction is likely to
