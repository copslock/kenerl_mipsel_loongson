Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 May 2013 07:48:39 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:33298 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6825879Ab3ESFsCTScse (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 19 May 2013 07:48:02 +0200
Received: from agni.kymasys.com ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Sat, 18 May 2013 22:47:51 -0700
Received: by agni.kymasys.com (Postfix, from userid 500)
        id 29F2A630051; Sat, 18 May 2013 22:47:43 -0700 (PDT)
From:   Sanjay Lal <sanjayl@kymasys.com>
To:     kvm@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH 01/18] Revert "MIPS: microMIPS: Support dynamic ASID sizing."
Date:   Sat, 18 May 2013 22:47:23 -0700
Message-Id: <1368942460-15577-2-git-send-email-sanjayl@kymasys.com>
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1368942460-15577-1-git-send-email-sanjayl@kymasys.com>
References: <n>
 <1368942460-15577-1-git-send-email-sanjayl@kymasys.com>
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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

This reverts commit f6b06d9361a008afb93b97fb3683a6e92d69d0f4.

Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/mm/tlbex.c | 34 ++--------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 4d46d37..2ad41e9 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -309,32 +309,13 @@ static int check_for_high_segbits __cpuinitdata;
 static void __cpuinit insn_fixup(unsigned int **start, unsigned int **stop,
 					unsigned int i_const)
 {
-	unsigned int **p;
+	unsigned int **p, *ip;
 
 	for (p = start; p < stop; p++) {
-#ifndef CONFIG_CPU_MICROMIPS
-		unsigned int *ip;
-
 		ip = *p;
 		*ip = (*ip & 0xffff0000) | i_const;
-#else
-		unsigned short *ip;
-
-		ip = ((unsigned short *)((unsigned int)*p - 1));
-		if ((*ip & 0xf000) == 0x4000) {
-			*ip &= 0xfff1;
-			*ip |= (i_const << 1);
-		} else if ((*ip & 0xf000) == 0x6000) {
-			*ip &= 0xfff1;
-			*ip |= ((i_const >> 2) << 1);
-		} else {
-			ip++;
-			*ip = i_const;
-		}
-#endif
-		local_flush_icache_range((unsigned long)ip,
-					 (unsigned long)ip + sizeof(*ip));
 	}
+	local_flush_icache_range((unsigned long)*p, (unsigned long)((*p) + 1));
 }
 
 #define asid_insn_fixup(section, const)					\
@@ -354,14 +335,6 @@ static void __cpuinit setup_asid(unsigned int inc, unsigned int mask,
 	extern asmlinkage void handle_ri_rdhwr_vivt(void);
 	unsigned long *vivt_exc;
 
-#ifdef CONFIG_CPU_MICROMIPS
-	/*
-	 * Worst case optimised microMIPS addiu instructions support
-	 * only a 3-bit immediate value.
-	 */
-	if(inc > 7)
-		panic("Invalid ASID increment value!");
-#endif
 	asid_insn_fixup(__asid_inc, inc);
 	asid_insn_fixup(__asid_mask, mask);
 	asid_insn_fixup(__asid_version_mask, version_mask);
@@ -369,9 +342,6 @@ static void __cpuinit setup_asid(unsigned int inc, unsigned int mask,
 
 	/* Patch up the 'handle_ri_rdhwr_vivt' handler. */
 	vivt_exc = (unsigned long *) &handle_ri_rdhwr_vivt;
-#ifdef CONFIG_CPU_MICROMIPS
-	vivt_exc = (unsigned long *)((unsigned long) vivt_exc - 1);
-#endif
 	vivt_exc++;
 	*vivt_exc = (*vivt_exc & ~mask) | mask;
 
-- 
1.7.11.3
