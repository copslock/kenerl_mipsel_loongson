Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:29:21 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025276AbbDCWZOG-aNz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:25:14 +0200
Date:   Fri, 3 Apr 2015 23:25:14 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 20/48] MIPS: Use `FPU_CSR_ALL_X' in `__build_clear_fpe'
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504030338020.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46737
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

Replace a hardcoded numeric bitmask for FCSR cause bits with 
`FPU_CSR_ALL_X' in `__build_clear_fpe'.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-genex-fpe-all-x.diff
Index: linux/arch/mips/kernel/genex.S
===================================================================
--- linux.orig/arch/mips/kernel/genex.S	2015-04-02 20:18:51.068520000 +0100
+++ linux/arch/mips/kernel/genex.S	2015-04-02 20:27:54.807188000 +0100
@@ -360,7 +360,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	.set	mips1
 	SET_HARDFLOAT
 	cfc1	a1, fcr31
-	li	a2, ~(0x3f << 12)
+	li	a2, ~FPU_CSR_ALL_X
 	and	a2, a1
 	ctc1	a2, fcr31
 	.set	pop
