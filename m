Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Jul 2013 22:20:29 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47587 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826888Ab3G1UUZnwx9Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Jul 2013 22:20:25 +0200
Date:   Sun, 28 Jul 2013 21:20:25 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     linux-mips@linux-mips.org
cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: uapi/asm/siginfo.h: Fix GCC 4.1.2 compilation
Message-ID: <alpine.LFD.2.03.1307282107060.9486@linux-mips.org>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37383
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

 It wasn't until GCC 4.3 I believe that the __SIZEOF_*__ predefined macros 
were added.  The change below switches <uapi/asm/siginfo.h> to the 
_MIPS_SZLONG macro so that compilation with e.g. GCC 4.1.2 succeeds.  
This is a user API header so I think this is even more important, for 
older userland support.  The change adds an unsuccessful default too, to 
catch any compiler configuration oddities.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Ralf, please apply.

  Maciej

linux-mips-sizeof.patch
Index: linux/arch/mips/include/uapi/asm/siginfo.h
===================================================================
--- linux.orig/arch/mips/include/uapi/asm/siginfo.h
+++ linux/arch/mips/include/uapi/asm/siginfo.h
@@ -25,11 +25,12 @@ struct siginfo;
 /*
  * Careful to keep union _sifields from shifting ...
  */
-#if __SIZEOF_LONG__ == 4
+#if _MIPS_SZLONG == 32
 #define __ARCH_SI_PREAMBLE_SIZE (3 * sizeof(int))
-#endif
-#if __SIZEOF_LONG__ == 8
+#elif _MIPS_SZLONG == 64
 #define __ARCH_SI_PREAMBLE_SIZE (4 * sizeof(int))
+#else
+#error _MIPS_SZLONG neither 32 nor 64
 #endif
 
 #include <asm-generic/siginfo.h>
