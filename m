Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:26:07 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025257AbbDCWYSp6qfh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:24:18 +0200
Date:   Fri, 3 Apr 2015 23:24:18 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 09/48] MIPS: Clarify the comment for `__cpu_has_fpu'
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504030220570.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46726
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

Reword the comment for `__cpu_has_fpu' to make it unambiguous this code 
is for external floating-point units only, generally MIPS I processors 
using the original CP1 hardware interface.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-cpu-has-fpu-comment.diff
Index: linux/arch/mips/kernel/cpu-probe.c
===================================================================
--- linux.orig/arch/mips/kernel/cpu-probe.c	2015-04-02 20:18:52.108532000 +0100
+++ linux/arch/mips/kernel/cpu-probe.c	2015-04-02 20:27:52.971189000 +0100
@@ -193,7 +193,7 @@ static inline unsigned long cpu_get_fpu_
 }
 
 /*
- * Check the CPU has an FPU the official way.
+ * Check if the CPU has an external FPU.
  */
 static inline int __cpu_has_fpu(void)
 {
