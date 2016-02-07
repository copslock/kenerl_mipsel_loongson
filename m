Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Feb 2016 12:06:01 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27010158AbcBGLF6wYikb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 7 Feb 2016 12:05:58 +0100
Date:   Sun, 7 Feb 2016 11:05:58 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: memset.S: Disable code unused with non-R6 MIPS
 configs
Message-ID: <alpine.LFD.2.20.1602071034250.2715@eddie.linux-mips.org>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51820
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

This complements commit 8c56208aff77 ("MIPS: lib: memset: Add MIPS R6 
support").

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 Noticed with a CPU_DADDI_WORKAROUNDS build triggering:

arch/mips/lib/memset.S: Assembler messages:
arch/mips/lib/memset.S:210: Warning: Macro instruction expanded into multiple instructions in a branch delay slot

-- a harmless warning however, as this code is never reached, not even
referred.

 Please apply.

  Maciej

linux-mips-memset-r6-fix.patch
Index: linux-4maxp64/arch/mips/lib/memset.S
===================================================================
--- linux-4maxp64.orig/arch/mips/lib/memset.S
+++ linux-4maxp64/arch/mips/lib/memset.S
@@ -228,10 +228,12 @@
 	.hidden __memset
 	.endif
 
+#ifdef CONFIG_CPU_MIPSR6
 .Lbyte_fixup\@:
 	PTR_SUBU	a2, $0, t0
 	jr		ra
 	 PTR_ADDIU	a2, 1
+#endif /* CONFIG_CPU_MIPSR6 */
 
 .Lfirst_fixup\@:
 	jr	ra
