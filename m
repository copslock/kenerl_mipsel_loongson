Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jul 2015 10:15:40 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:36652 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009635AbbGAIOUjCDh4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Jul 2015 10:14:20 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D326E6A52BDE9;
        Wed,  1 Jul 2015 09:14:12 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 1 Jul 2015 09:14:14 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.48) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 1 Jul 2015 09:14:14 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <stable@vger.kernel.org>
Subject: [PATCH 6/7] MIPS: kernel: cps-vec: Use macros for various arithmetics and memory operations
Date:   Wed, 1 Jul 2015 09:13:33 +0100
Message-ID: <1435738414-30944-7-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1435738414-30944-1-git-send-email-markos.chandras@imgtec.com>
References: <1435738414-30944-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Replace lw/sw and various arithmetic instructions with macros so the
code can work on 64-bit kernels as well.

Cc: <stable@vger.kernel.org> # 3.16+
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/cps-vec.S | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index 2f95568e0da5..1b6ca634e646 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -108,9 +108,9 @@ not_nmi:
 	mul	t1, t1, t2
 
 	li	a0, CKSEG0
-	add	a1, a0, t1
+	PTR_ADD	a1, a0, t1
 1:	cache	Index_Store_Tag_I, 0(a0)
-	add	a0, a0, t0
+	PTR_ADD	a0, a0, t0
 	bne	a0, a1, 1b
 	 nop
 icache_done:
@@ -135,11 +135,11 @@ icache_done:
 	mul	t1, t1, t2
 
 	li	a0, CKSEG0
-	addu	a1, a0, t1
-	subu	a1, a1, t0
+	PTR_ADDU a1, a0, t1
+	PTR_SUBU a1, a1, t0
 1:	cache	Index_Store_Tag_D, 0(a0)
 	bne	a0, a1, 1b
-	 add	a0, a0, t0
+	 PTR_ADD a0, a0, t0
 dcache_done:
 
 	/* Set Kseg0 CCA to that in s0 */
@@ -152,7 +152,7 @@ dcache_done:
 
 	/* Enter the coherent domain */
 	li	t0, 0xff
-	sw	t0, GCR_CL_COHERENCE_OFS(v1)
+	PTR_S	t0, GCR_CL_COHERENCE_OFS(v1)
 	ehb
 
 	/* Jump to kseg0 */
@@ -178,9 +178,9 @@ dcache_done:
 	 nop
 
 	/* Off we go! */
-	lw	t1, VPEBOOTCFG_PC(v0)
-	lw	gp, VPEBOOTCFG_GP(v0)
-	lw	sp, VPEBOOTCFG_SP(v0)
+	PTR_L	t1, VPEBOOTCFG_PC(v0)
+	PTR_L	gp, VPEBOOTCFG_GP(v0)
+	PTR_L	sp, VPEBOOTCFG_SP(v0)
 	jr	t1
 	 nop
 	END(mips_cps_core_entry)
@@ -299,15 +299,15 @@ LEAF(mips_cps_core_init)
 LEAF(mips_cps_boot_vpes)
 	/* Retrieve CM base address */
 	PTR_LA	t0, mips_cm_base
-	lw	t0, 0(t0)
+	PTR_L	t0, 0(t0)
 
 	/* Calculate a pointer to this cores struct core_boot_config */
-	lw	t0, GCR_CL_ID_OFS(t0)
+	PTR_L	t0, GCR_CL_ID_OFS(t0)
 	li	t1, COREBOOTCFG_SIZE
 	mul	t0, t0, t1
 	PTR_LA	t1, mips_cps_core_bootcfg
-	lw	t1, 0(t1)
-	addu	t0, t0, t1
+	PTR_L	t1, 0(t1)
+	PTR_ADDU t0, t0, t1
 
 	/* Calculate this VPEs ID. If the core doesn't support MT use 0 */
 	has_mt	ta2, 1f
@@ -334,8 +334,8 @@ LEAF(mips_cps_boot_vpes)
 1:	/* Calculate a pointer to this VPEs struct vpe_boot_config */
 	li	t1, VPEBOOTCFG_SIZE
 	mul	v0, t9, t1
-	lw	ta3, COREBOOTCFG_VPECONFIG(t0)
-	addu	v0, v0, ta3
+	PTR_L	ta3, COREBOOTCFG_VPECONFIG(t0)
+	PTR_ADDU v0, v0, ta3
 
 #ifdef CONFIG_MIPS_MT
 
@@ -360,7 +360,7 @@ LEAF(mips_cps_boot_vpes)
 	ehb
 
 	/* Loop through each VPE */
-	lw	ta2, COREBOOTCFG_VPEMASK(t0)
+	PTR_L	ta2, COREBOOTCFG_VPEMASK(t0)
 	move	t8, ta2
 	li	ta1, 0
 
-- 
2.4.5
