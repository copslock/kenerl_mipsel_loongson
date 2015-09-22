Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 20:13:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48297 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009093AbbIVSNx65YLU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 20:13:53 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id DABA8CB11E530;
        Tue, 22 Sep 2015 19:13:42 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 19:13:46 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 19:13:44 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Andrew Bresticker <abrestic@chromium.org>,
        <linux-kernel@vger.kernel.org>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 04/10] MIPS: CPS: read CM GCR base from cop0
Date:   Tue, 22 Sep 2015 11:12:12 -0700
Message-ID: <1442945538-26141-5-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <1442945538-26141-1-git-send-email-paul.burton@imgtec.com>
References: <1442945538-26141-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49305
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

Rather than patching the start of mips_cps_core_entry to provide the
base address of the CM GCRs, simply read that base address from the cop0
CMGCRBase register, converting from the physical address to an uncached
virtual address.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/kernel/cps-vec.S | 12 ++++++++----
 arch/mips/kernel/smp-cps.c |  2 --
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index a9cc16a..5407ce4 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -66,11 +66,9 @@
 
 LEAF(mips_cps_core_entry)
 	/*
-	 * These first 12 bytes will be patched by cps_smp_setup to load the
-	 * base address of the CM GCRs into register v1 and the CCA to use into
-	 * register s0.
+	 * These first 4 bytes will be patched by cps_smp_setup to load the
+	 * CCA to use into register s0.
 	 */
-	.quad	0
 	.word	0
 
 	/* Check whether we're here due to an NMI */
@@ -170,6 +168,12 @@ dcache_done:
 	mtc0	t0, CP0_CONFIG
 	ehb
 
+	/* Calculate an uncached address for the CM GCRs */
+	MFC0	v1, CP0_CMGCRBASE
+	PTR_SLL	v1, v1, 4
+	PTR_LI	t0, UNCAC_BASE
+	PTR_ADDU v1, v1, t0
+
 	/* Enter the coherent domain */
 	li	t0, 0xff
 	sw	t0, GCR_CL_COHERENCE_OFS(v1)
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index c889377..8b96750 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -133,11 +133,9 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
 	/*
 	 * Patch the start of mips_cps_core_entry to provide:
 	 *
-	 * v1 = CM base address
 	 * s0 = kseg0 CCA
 	 */
 	entry_code = (u32 *)&mips_cps_core_entry;
-	UASM_i_LA(&entry_code, 3, (long)mips_cm_base);
 	uasm_i_addiu(&entry_code, 16, 0, cca);
 	blast_dcache_range((unsigned long)&mips_cps_core_entry,
 			   (unsigned long)entry_code);
-- 
2.5.3
