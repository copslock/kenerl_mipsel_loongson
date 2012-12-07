Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2012 06:31:12 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:60440 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6831907Ab2LGFaehXUyH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Dec 2012 06:30:34 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1TgqW4-0007R1-Jf; Thu, 06 Dec 2012 23:30:28 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 2/2] MIPS: microMIPS: Support dynamic ASID sizing.
Date:   Thu,  6 Dec 2012 23:30:22 -0600
Message-Id: <1354858222-29519-3-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1354858222-29519-1-git-send-email-sjhill@mips.com>
References: <1354858222-29519-1-git-send-email-sjhill@mips.com>
X-archive-position: 35238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Changes for pure microMIPS cores to dynamically determine the ASID
size at boot time.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/mm/tlbex.c |   31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 6983454..5ffec3d 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -267,11 +267,29 @@ static int check_for_high_segbits __cpuinitdata;
 static void __cpuinit insn_fixup(unsigned int **start, unsigned int **stop,
 					unsigned int i_const)
 {
-	unsigned int **p, *ip;
+	unsigned int **p;
 
 	for (p = start; p < stop; p++) {
+#ifndef CONFIG_CPU_MICROMIPS
+		unsigned int *ip;
+
 		ip = *p;
 		*ip = (*ip & 0xffff0000) | i_const;
+#else
+		unsigned short *ip;
+
+		ip = ((unsigned short *)((unsigned int)*p - 1));
+		if ((*ip & 0xf000) == 0x4000) {
+			*ip &= 0xfff1;
+			*ip |= (i_const << 1);
+		} else if ((*ip & 0xf000) == 0x6000) {
+			*ip &= 0xfff1;
+			*ip |= ((i_const >> 2) << 1);
+		} else {
+			ip++;
+			*ip = i_const;
+		}
+#endif
 	}
 }
 
@@ -290,6 +308,14 @@ static void __cpuinit setup_asid(unsigned int inc, unsigned int mask,
 	extern asmlinkage void handle_ri_rdhwr_vivt(void);
 	unsigned long *vivt_exc;
 
+#ifdef CONFIG_CPU_MICROMIPS
+	/*
+	 * Worst case optimised microMIPS addiu instructions support
+	 * only a 3-bit immediate value.
+	 */
+	if(inc > 7)
+		panic("Invalid ASID increment value!");
+#endif
 	asid_insn_fixup(__asid_inc, inc);
 	asid_insn_fixup(__asid_mask, mask);
 	asid_insn_fixup(__asid_version_mask, version_mask);
@@ -297,6 +323,9 @@ static void __cpuinit setup_asid(unsigned int inc, unsigned int mask,
 
 	/* Patch up the 'handle_ri_rdhwr_vivt' handler. */
 	vivt_exc = (unsigned long *) &handle_ri_rdhwr_vivt;
+#ifdef CONFIG_CPU_MICROMIPS
+	vivt_exc = (unsigned long *)((unsigned long) vivt_exc - 1);
+#endif
 	vivt_exc++;
 	*vivt_exc = (*vivt_exc & ~mask) | mask;
 
-- 
1.7.9.5
