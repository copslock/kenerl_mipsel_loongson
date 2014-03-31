Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2014 00:51:34 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:40974 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817387AbaCaWvch2Oai (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Apr 2014 00:51:32 +0200
Date:   Mon, 31 Mar 2014 23:51:30 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH] DEC: Bus error handler <asm/cpu-type.h> fixes
Message-ID: <alpine.LFD.2.11.1403312343350.27402@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39596
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

Commit 69f24d1784b631b81a54eb57c49bf46536dd2382 [MIPS: Optimize 
current_cpu_type() for better code.] missed an update for two DECstation 
bus error support files that now do not build, this is a fix.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-dec-cpu-type.patch
Index: linux-20140329-4maxp64/arch/mips/dec/ecc-berr.c
===================================================================
--- linux-20140329-4maxp64.orig/arch/mips/dec/ecc-berr.c
+++ linux-20140329-4maxp64/arch/mips/dec/ecc-berr.c
@@ -21,6 +21,7 @@
 #include <asm/addrspace.h>
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
+#include <asm/cpu-type.h>
 #include <asm/irq_regs.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
Index: linux-20140329-4maxp64/arch/mips/dec/kn02xa-berr.c
===================================================================
--- linux-20140329-4maxp64.orig/arch/mips/dec/kn02xa-berr.c
+++ linux-20140329-4maxp64/arch/mips/dec/kn02xa-berr.c
@@ -19,6 +19,7 @@
 #include <linux/types.h>
 
 #include <asm/addrspace.h>
+#include <asm/cpu-type.h>
 #include <asm/irq_regs.h>
 #include <asm/ptrace.h>
 #include <asm/traps.h>
