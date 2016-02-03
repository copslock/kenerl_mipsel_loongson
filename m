Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 04:19:17 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46740 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007574AbcBCDSvC-cY0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 04:18:51 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 7A3909C361DA3;
        Wed,  3 Feb 2016 03:18:43 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 03:18:44 +0000
Received: from localhost (10.100.200.215) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 03:18:43 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/15] MIPS: smp-cps: Pull cache init into a function
Date:   Wed, 3 Feb 2016 03:15:30 +0000
Message-ID: <1454469335-14778-11-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 51638
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

In preparation for further modifications to mips_cps_core_entry, pull
the L1 cache initialisation out into a separate function. This both
makes the code in mips_cps_core_entry read more clearly, particularly
when modifying it, and shortens it which will become important as code
is added that needs to continue to fit within the reset vector.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/kernel/cps-vec.S | 143 ++++++++++++++++++++++++---------------------
 1 file changed, 76 insertions(+), 67 deletions(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index ac81edd..8d5ea4b 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -90,74 +90,9 @@ not_nmi:
 	li	t0, ST0_CU1 | ST0_CU0 | ST0_BEV | STATUS_BITDEPS
 	mtc0	t0, CP0_STATUS
 
-	/*
-	 * Clear the bits used to index the caches. Note that the architecture
-	 * dictates that writing to any of TagLo or TagHi selects 0 or 2 should
-	 * be valid for all MIPS32 CPUs, even those for which said writes are
-	 * unnecessary.
-	 */
-	mtc0	zero, CP0_TAGLO, 0
-	mtc0	zero, CP0_TAGHI, 0
-	mtc0	zero, CP0_TAGLO, 2
-	mtc0	zero, CP0_TAGHI, 2
-	ehb
-
-	/* Primary cache configuration is indicated by Config1 */
-	mfc0	v0, CP0_CONFIG, 1
-
-	/* Detect I-cache line size */
-	_EXT	t0, v0, MIPS_CONF1_IL_SHF, MIPS_CONF1_IL_SZ
-	beqz	t0, icache_done
-	 li	t1, 2
-	sllv	t0, t1, t0
-
-	/* Detect I-cache size */
-	_EXT	t1, v0, MIPS_CONF1_IS_SHF, MIPS_CONF1_IS_SZ
-	xori	t2, t1, 0x7
-	beqz	t2, 1f
-	 li	t3, 32
-	addiu	t1, t1, 1
-	sllv	t1, t3, t1
-1:	/* At this point t1 == I-cache sets per way */
-	_EXT	t2, v0, MIPS_CONF1_IA_SHF, MIPS_CONF1_IA_SZ
-	addiu	t2, t2, 1
-	mul	t1, t1, t0
-	mul	t1, t1, t2
-
-	li	a0, CKSEG0
-	PTR_ADD	a1, a0, t1
-1:	cache	Index_Store_Tag_I, 0(a0)
-	PTR_ADD	a0, a0, t0
-	bne	a0, a1, 1b
+	/* Initialize the L1 caches */
+	jal	mips_cps_cache_init
 	 nop
-icache_done:
-
-	/* Detect D-cache line size */
-	_EXT	t0, v0, MIPS_CONF1_DL_SHF, MIPS_CONF1_DL_SZ
-	beqz	t0, dcache_done
-	 li	t1, 2
-	sllv	t0, t1, t0
-
-	/* Detect D-cache size */
-	_EXT	t1, v0, MIPS_CONF1_DS_SHF, MIPS_CONF1_DS_SZ
-	xori	t2, t1, 0x7
-	beqz	t2, 1f
-	 li	t3, 32
-	addiu	t1, t1, 1
-	sllv	t1, t3, t1
-1:	/* At this point t1 == D-cache sets per way */
-	_EXT	t2, v0, MIPS_CONF1_DA_SHF, MIPS_CONF1_DA_SZ
-	addiu	t2, t2, 1
-	mul	t1, t1, t0
-	mul	t1, t1, t2
-
-	li	a0, CKSEG0
-	PTR_ADDU a1, a0, t1
-	PTR_SUBU a1, a1, t0
-1:	cache	Index_Store_Tag_D, 0(a0)
-	bne	a0, a1, 1b
-	 PTR_ADD a0, a0, t0
-dcache_done:
 
 	/* Set Kseg0 CCA to that in s0 */
 	mfc0	t0, CP0_CONFIG
@@ -486,6 +421,80 @@ LEAF(mips_cps_boot_vpes)
 	 nop
 	END(mips_cps_boot_vpes)
 
+LEAF(mips_cps_cache_init)
+	/*
+	 * Clear the bits used to index the caches. Note that the architecture
+	 * dictates that writing to any of TagLo or TagHi selects 0 or 2 should
+	 * be valid for all MIPS32 CPUs, even those for which said writes are
+	 * unnecessary.
+	 */
+	mtc0	zero, CP0_TAGLO, 0
+	mtc0	zero, CP0_TAGHI, 0
+	mtc0	zero, CP0_TAGLO, 2
+	mtc0	zero, CP0_TAGHI, 2
+	ehb
+
+	/* Primary cache configuration is indicated by Config1 */
+	mfc0	v0, CP0_CONFIG, 1
+
+	/* Detect I-cache line size */
+	_EXT	t0, v0, MIPS_CONF1_IL_SHF, MIPS_CONF1_IL_SZ
+	beqz	t0, icache_done
+	 li	t1, 2
+	sllv	t0, t1, t0
+
+	/* Detect I-cache size */
+	_EXT	t1, v0, MIPS_CONF1_IS_SHF, MIPS_CONF1_IS_SZ
+	xori	t2, t1, 0x7
+	beqz	t2, 1f
+	 li	t3, 32
+	addiu	t1, t1, 1
+	sllv	t1, t3, t1
+1:	/* At this point t1 == I-cache sets per way */
+	_EXT	t2, v0, MIPS_CONF1_IA_SHF, MIPS_CONF1_IA_SZ
+	addiu	t2, t2, 1
+	mul	t1, t1, t0
+	mul	t1, t1, t2
+
+	li	a0, CKSEG0
+	PTR_ADD	a1, a0, t1
+1:	cache	Index_Store_Tag_I, 0(a0)
+	PTR_ADD	a0, a0, t0
+	bne	a0, a1, 1b
+	 nop
+icache_done:
+
+	/* Detect D-cache line size */
+	_EXT	t0, v0, MIPS_CONF1_DL_SHF, MIPS_CONF1_DL_SZ
+	beqz	t0, dcache_done
+	 li	t1, 2
+	sllv	t0, t1, t0
+
+	/* Detect D-cache size */
+	_EXT	t1, v0, MIPS_CONF1_DS_SHF, MIPS_CONF1_DS_SZ
+	xori	t2, t1, 0x7
+	beqz	t2, 1f
+	 li	t3, 32
+	addiu	t1, t1, 1
+	sllv	t1, t3, t1
+1:	/* At this point t1 == D-cache sets per way */
+	_EXT	t2, v0, MIPS_CONF1_DA_SHF, MIPS_CONF1_DA_SZ
+	addiu	t2, t2, 1
+	mul	t1, t1, t0
+	mul	t1, t1, t2
+
+	li	a0, CKSEG0
+	PTR_ADDU a1, a0, t1
+	PTR_SUBU a1, a1, t0
+1:	cache	Index_Store_Tag_D, 0(a0)
+	bne	a0, a1, 1b
+	 PTR_ADD a0, a0, t0
+dcache_done:
+
+	jr	ra
+	 nop
+	END(mips_cps_cache_init)
+
 #if defined(CONFIG_MIPS_CPS_PM) && defined(CONFIG_CPU_PM)
 
 	/* Calculate a pointer to this CPUs struct mips_static_suspend_state */
-- 
2.7.0
