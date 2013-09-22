Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Sep 2013 23:04:33 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:36678 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818702Ab3IVVE1h0G8L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 Sep 2013 23:04:27 +0200
Date:   Sun, 22 Sep 2013 22:04:27 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: cpu-features.h: s/MIPS53/MIPS64/
Message-ID: <alpine.LFD.2.03.1309222159150.16797@linux-mips.org>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37914
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

No support for MIPS53 processors yet.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips53.patch
Index: linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/include/asm/cpu-features.h
===================================================================
--- linux-mips-3.12.0-rc1-20130917-4maxp.orig/arch/mips/include/asm/cpu-features.h
+++ linux-mips-3.12.0-rc1-20130917-4maxp/arch/mips/include/asm/cpu-features.h
@@ -193,7 +193,7 @@
 
 /*
  * MIPS32, MIPS64, VR5500, IDT32332, IDT32334 and maybe a few other
- * pre-MIPS32/MIPS53 processors have CLO, CLZ.	The IDT RC64574 is 64-bit and
+ * pre-MIPS32/MIPS64 processors have CLO, CLZ.	The IDT RC64574 is 64-bit and
  * has CLO and CLZ but not DCLO nor DCLZ.  For 64-bit kernels
  * cpu_has_clo_clz also indicates the availability of DCLO and DCLZ.
  */
