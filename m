Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jul 2015 10:15:03 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61269 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009537AbbGAIOQHBgE4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Jul 2015 10:14:16 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id BDAF5651D2F99;
        Wed,  1 Jul 2015 09:14:08 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 1 Jul 2015 09:14:09 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.48) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 1 Jul 2015 09:14:09 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <stable@vger.kernel.org>
Subject: [PATCH 4/7] MIPS: kernel: cps-vec: Use ta0-ta3 pseudo-registers for 64-bit
Date:   Wed, 1 Jul 2015 09:13:31 +0100
Message-ID: <1435738414-30944-5-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 48050
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

The cps-vec code assumes O32 ABI and uses t4-t7 in quite a few places. This
breaks the build on 64-bit. As a result of which, use the pseudo-registers
ta0-ta3 to make the code compatible with 64-bit.

Cc: <stable@vger.kernel.org> # 3.16+
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/cps-vec.S | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index bbbd88e994f0..21f714a81ebd 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -250,25 +250,25 @@ LEAF(mips_cps_core_init)
 	mfc0	t0, CP0_MVPCONF0
 	srl	t0, t0, MVPCONF0_PVPE_SHIFT
 	andi	t0, t0, (MVPCONF0_PVPE >> MVPCONF0_PVPE_SHIFT)
-	addiu	t7, t0, 1
+	addiu	ta3, t0, 1
 
 	/* If there's only 1, we're done */
 	beqz	t0, 2f
 	 nop
 
 	/* Loop through each VPE within this core */
-	li	t5, 1
+	li	ta1, 1
 
 1:	/* Operate on the appropriate TC */
-	mtc0	t5, CP0_VPECONTROL
+	mtc0	ta1, CP0_VPECONTROL
 	ehb
 
 	/* Bind TC to VPE (1:1 TC:VPE mapping) */
-	mttc0	t5, CP0_TCBIND
+	mttc0	ta1, CP0_TCBIND
 
 	/* Set exclusive TC, non-active, master */
 	li	t0, VPECONF0_MVP
-	sll	t1, t5, VPECONF0_XTC_SHIFT
+	sll	t1, ta1, VPECONF0_XTC_SHIFT
 	or	t0, t0, t1
 	mttc0	t0, CP0_VPECONF0
 
@@ -280,8 +280,8 @@ LEAF(mips_cps_core_init)
 	mttc0	t0, CP0_TCHALT
 
 	/* Next VPE */
-	addiu	t5, t5, 1
-	slt	t0, t5, t7
+	addiu	ta1, ta1, 1
+	slt	t0, ta1, ta3
 	bnez	t0, 1b
 	 nop
 
@@ -310,7 +310,7 @@ LEAF(mips_cps_boot_vpes)
 	addu	t0, t0, t1
 
 	/* Calculate this VPEs ID. If the core doesn't support MT use 0 */
-	has_mt	t6, 1f
+	has_mt	ta2, 1f
 	 li	t9, 0
 
 	/* Find the number of VPEs present in the core */
@@ -334,13 +334,13 @@ LEAF(mips_cps_boot_vpes)
 1:	/* Calculate a pointer to this VPEs struct vpe_boot_config */
 	li	t1, VPEBOOTCFG_SIZE
 	mul	v0, t9, t1
-	lw	t7, COREBOOTCFG_VPECONFIG(t0)
-	addu	v0, v0, t7
+	lw	ta3, COREBOOTCFG_VPECONFIG(t0)
+	addu	v0, v0, ta3
 
 #ifdef CONFIG_MIPS_MT
 
 	/* If the core doesn't support MT then return */
-	bnez	t6, 1f
+	bnez	ta2, 1f
 	 nop
 	jr	ra
 	 nop
@@ -360,12 +360,12 @@ LEAF(mips_cps_boot_vpes)
 	ehb
 
 	/* Loop through each VPE */
-	lw	t6, COREBOOTCFG_VPEMASK(t0)
-	move	t8, t6
-	li	t5, 0
+	lw	ta2, COREBOOTCFG_VPEMASK(t0)
+	move	t8, ta2
+	li	ta1, 0
 
 	/* Check whether the VPE should be running. If not, skip it */
-1:	andi	t0, t6, 1
+1:	andi	t0, ta2, 1
 	beqz	t0, 2f
 	 nop
 
@@ -373,7 +373,7 @@ LEAF(mips_cps_boot_vpes)
 	mfc0	t0, CP0_VPECONTROL
 	ori	t0, t0, VPECONTROL_TARGTC
 	xori	t0, t0, VPECONTROL_TARGTC
-	or	t0, t0, t5
+	or	t0, t0, ta1
 	mtc0	t0, CP0_VPECONTROL
 	ehb
 
@@ -384,8 +384,8 @@ LEAF(mips_cps_boot_vpes)
 
 	/* Calculate a pointer to the VPEs struct vpe_boot_config */
 	li	t0, VPEBOOTCFG_SIZE
-	mul	t0, t0, t5
-	addu	t0, t0, t7
+	mul	t0, t0, ta1
+	addu	t0, t0, ta3
 
 	/* Set the TC restart PC */
 	lw	t1, VPEBOOTCFG_PC(t0)
@@ -423,9 +423,9 @@ LEAF(mips_cps_boot_vpes)
 	mttc0	t0, CP0_VPECONF0
 
 	/* Next VPE */
-2:	srl	t6, t6, 1
-	addiu	t5, t5, 1
-	bnez	t6, 1b
+2:	srl	ta2, ta2, 1
+	addiu	ta1, ta1, 1
+	bnez	ta2, 1b
 	 nop
 
 	/* Leave VPE configuration state */
-- 
2.4.5
