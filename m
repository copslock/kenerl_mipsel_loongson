Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Apr 2014 22:46:08 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:32826 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816019AbaDFUqFZcbg8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Apr 2014 22:46:05 +0200
Date:   Sun, 6 Apr 2014 21:46:05 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH] DEC: Only select the R4k clock event/source on R4k systems
Message-ID: <alpine.LFD.2.11.1404062143010.15266@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39670
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

R3k systems have no R4k timer so there's no point in pulling code that's 
going to be dead.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-dec-r3k-clock.patch
Index: linux-20140329-3maxp/arch/mips/Kconfig
===================================================================
--- linux-20140329-3maxp.orig/arch/mips/Kconfig
+++ linux-20140329-3maxp/arch/mips/Kconfig
@@ -168,9 +168,9 @@ config MACH_DECSTATION
 	bool "DECstations"
 	select BOOT_ELF32
 	select CEVT_DS1287
-	select CEVT_R4K
+	select CEVT_R4K if CPU_R4X00
 	select CSRC_IOASIC
-	select CSRC_R4K
+	select CSRC_R4K if CPU_R4X00
 	select CPU_DADDI_WORKAROUNDS if 64BIT
 	select CPU_R4000_WORKAROUNDS if 64BIT
 	select CPU_R4400_WORKAROUNDS if 64BIT
