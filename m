Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 04:19:54 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13751 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010043AbcBCDTUVhoQ0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 04:19:20 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 6B67CCB763442;
        Wed,  3 Feb 2016 03:19:13 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 03:19:13 +0000
Received: from localhost (10.100.200.215) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 03:19:12 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 12/15] MIPS: smp-cps: Skip core setup if coherent
Date:   Wed, 3 Feb 2016 03:15:32 +0000
Message-ID: <1454469335-14778-13-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454469335-14778-1-git-send-email-paul.burton@imgtec.com>
References: <1454469335-14778-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.215]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

In preparation for supporting MIPSr6 multithreading (ie. VPs) which will
begin execution from the core reset vector, skip core level setup if the
core is already coherent. This is never the case when a core is first
started, since boot_core explicitly clears the cores GCR_Cx_COH_EN
register, and always the case when secondary VPs start since the first
VP to start will have enabled coherence after initialising the core &
its caches.

One notable side effect of this patch is that eva_init gets called
slightly earlier, prior to mips_cps_core_init rather than after it.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/kernel/cps-vec.S | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index 2613de9..4849cbd 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -101,43 +101,52 @@ not_nmi:
 	li	t0, ST0_CU1 | ST0_CU0 | ST0_BEV | STATUS_BITDEPS
 	mtc0	t0, CP0_STATUS
 
+	/* Skip cache & coherence setup if we're already coherent */
+	cmgcrb	v1
+	lw	s7, GCR_CL_COHERENCE_OFS(v1)
+	bnez	s7, 1f
+	 nop
+
 	/* Initialize the L1 caches */
 	jal	mips_cps_cache_init
 	 nop
 
+	/* Enter the coherent domain */
+	li	t0, 0xff
+	sw	t0, GCR_CL_COHERENCE_OFS(v1)
+	ehb
+
 	/* Set Kseg0 CCA to that in s0 */
-	mfc0	t0, CP0_CONFIG
+1:	mfc0	t0, CP0_CONFIG
 	ori	t0, 0x7
 	xori	t0, 0x7
 	or	t0, t0, s0
 	mtc0	t0, CP0_CONFIG
 	ehb
 
-	/* Enter the coherent domain */
-	cmgcrb	v1
-	li	t0, 0xff
-	sw	t0, GCR_CL_COHERENCE_OFS(v1)
-	ehb
-
 	/* Jump to kseg0 */
 	PTR_LA	t0, 1f
 	jr	t0
 	 nop
 
 	/*
-	 * We're up, cached & coherent. Perform any further required core-level
-	 * initialisation.
+	 * We're up, cached & coherent. Perform any EVA initialization necessary
+	 * before we access memory.
 	 */
-1:	jal	mips_cps_core_init
-	 nop
-
-	/* Do any EVA initialization if necessary */
-	eva_init
+1:	eva_init
 
 	/* Retrieve boot configuration pointers */
 	jal	mips_cps_get_bootcfg
 	 nop
 
+	/* Skip core-level init if we started up coherent */
+	bnez	s7, 1f
+	 nop
+
+	/* Perform any further required core-level initialisation */
+	jal	mips_cps_core_init
+	 nop
+
 	/*
 	 * Boot any other VPEs within this core that should be online, and
 	 * deactivate this VPE if it should be offline.
@@ -147,7 +156,7 @@ not_nmi:
 	 move	a0, v0
 
 	/* Off we go! */
-	PTR_L	t1, VPEBOOTCFG_PC(v1)
+1:	PTR_L	t1, VPEBOOTCFG_PC(v1)
 	PTR_L	gp, VPEBOOTCFG_GP(v1)
 	PTR_L	sp, VPEBOOTCFG_SP(v1)
 	jr	t1
-- 
2.7.0
