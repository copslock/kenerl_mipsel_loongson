Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:24:08 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025226AbbDCWXl0OvwD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:23:41 +0200
Date:   Fri, 3 Apr 2015 23:23:41 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 02/48] MIPS: mipsregs.h: Remove broken comments
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504030105200.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46719
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

Remove a duplicate FPU Status Register reference that has been there 
since forever and a mistakenly copied and pasted R4xx0 manual reference.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-regs-fcsr-comment.diff
Index: linux/arch/mips/include/asm/mipsregs.h
===================================================================
--- linux.orig/arch/mips/include/asm/mipsregs.h	2015-04-02 20:18:53.073537000 +0100
+++ linux/arch/mips/include/asm/mipsregs.h	2015-04-02 20:27:51.667161000 +0100
@@ -120,10 +120,6 @@
 /*
  * FPU Status Register Values
  */
-/*
- * Status Register Values
- */
-
 #define FPU_CSR_FLUSH	0x01000000	/* flush denormalised results to 0 */
 #define FPU_CSR_COND	0x00800000	/* $fcc0 */
 #define FPU_CSR_COND0	0x00800000	/* $fcc0 */
@@ -425,8 +421,6 @@
 
 /*
  * Bitfields and bit numbers in the coprocessor 0 IntCtl register. (MIPSR2)
- *
- * Refer to your MIPS R4xx0 manual, chapter 5 for explanation.
  */
 #define INTCTLB_IPPCI		26
 #define INTCTLF_IPPCI		(_ULCAST_(7) << INTCTLB_IPPCI)
