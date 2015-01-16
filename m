Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 12:01:15 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63332 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010682AbbAPKxJm3fiE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 11:53:09 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 4FDC9A28D6939
        for <linux-mips@linux-mips.org>; Fri, 16 Jan 2015 10:53:01 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Jan 2015 10:53:03 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 16 Jan 2015 10:53:02 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH RFC v2 35/70] MIPS: kernel: cps-vec: Replace addi with addiu
Date:   Fri, 16 Jan 2015 10:49:14 +0000
Message-ID: <1421405389-15512-36-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45179
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

MIPS R6 removed the addi instruction so we replace it with addiu.

Cc: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/cps-vec.S | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index 0384b05ab5a0..55b759a0019e 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -99,11 +99,11 @@ not_nmi:
 	xori	t2, t1, 0x7
 	beqz	t2, 1f
 	 li	t3, 32
-	addi	t1, t1, 1
+	addiu	t1, t1, 1
 	sllv	t1, t3, t1
 1:	/* At this point t1 == I-cache sets per way */
 	_EXT	t2, v0, MIPS_CONF1_IA_SHF, MIPS_CONF1_IA_SZ
-	addi	t2, t2, 1
+	addiu	t2, t2, 1
 	mul	t1, t1, t0
 	mul	t1, t1, t2
 
@@ -126,11 +126,11 @@ icache_done:
 	xori	t2, t1, 0x7
 	beqz	t2, 1f
 	 li	t3, 32
-	addi	t1, t1, 1
+	addiu	t1, t1, 1
 	sllv	t1, t3, t1
 1:	/* At this point t1 == D-cache sets per way */
 	_EXT	t2, v0, MIPS_CONF1_DA_SHF, MIPS_CONF1_DA_SZ
-	addi	t2, t2, 1
+	addiu	t2, t2, 1
 	mul	t1, t1, t0
 	mul	t1, t1, t2
 
@@ -250,7 +250,7 @@ LEAF(mips_cps_core_init)
 	mfc0	t0, CP0_MVPCONF0
 	srl	t0, t0, MVPCONF0_PVPE_SHIFT
 	andi	t0, t0, (MVPCONF0_PVPE >> MVPCONF0_PVPE_SHIFT)
-	addi	t7, t0, 1
+	addiu	t7, t0, 1
 
 	/* If there's only 1, we're done */
 	beqz	t0, 2f
@@ -280,7 +280,7 @@ LEAF(mips_cps_core_init)
 	mttc0	t0, CP0_TCHALT
 
 	/* Next VPE */
-	addi	t5, t5, 1
+	addiu	t5, t5, 1
 	slt	t0, t5, t7
 	bnez	t0, 1b
 	 nop
@@ -317,7 +317,7 @@ LEAF(mips_cps_boot_vpes)
 	mfc0	t1, CP0_MVPCONF0
 	srl	t1, t1, MVPCONF0_PVPE_SHIFT
 	andi	t1, t1, MVPCONF0_PVPE >> MVPCONF0_PVPE_SHIFT
-	addi	t1, t1, 1
+	addiu	t1, t1, 1
 
 	/* Calculate a mask for the VPE ID from EBase.CPUNum */
 	clz	t1, t1
@@ -424,7 +424,7 @@ LEAF(mips_cps_boot_vpes)
 
 	/* Next VPE */
 2:	srl	t6, t6, 1
-	addi	t5, t5, 1
+	addiu	t5, t5, 1
 	bnez	t6, 1b
 	 nop
 
-- 
2.2.1
