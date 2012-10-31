Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2012 13:59:26 +0100 (CET)
Received: from mms2.broadcom.com ([216.31.210.18]:2705 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825656Ab2JaM6pfPMBp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 31 Oct 2012 13:58:45 +0100
Received: from [10.9.200.133] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 31 Oct 2012 05:56:50 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Wed, 31 Oct 2012 05:58:07 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 1A93140FE5; Wed, 31
 Oct 2012 05:58:35 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 09/15] MIPS: Netlogic: Pass cpuid to
 early_init_secondary
Date:   Wed, 31 Oct 2012 18:31:35 +0530
Message-ID: <14cdefd2b41367658ed14770b708a2695366f0ef.1351688140.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1351688140.git.jchandra@broadcom.com>
References: <cover.1351688140.git.jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7C8FFF983QC1968432-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 34797
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

The cpuid was not passed into early_init_secondary even though the
comment indicated that it will be. Fix this.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/common/smp.c     |    2 +-
 arch/mips/netlogic/common/smpboot.S |    4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/netlogic/common/smp.c b/arch/mips/netlogic/common/smp.c
index fab316d..cd39f54 100644
--- a/arch/mips/netlogic/common/smp.c
+++ b/arch/mips/netlogic/common/smp.c
@@ -98,7 +98,7 @@ void nlm_early_init_secondary(int cpu)
 	change_c0_config(CONF_CM_CMASK, 0x3);
 	write_c0_ebase((uint32_t)nlm_common_ebase);
 #ifdef CONFIG_CPU_XLP
-	if (hard_smp_processor_id() % 4 == 0)
+	if (cpu % 4 == 0)
 		xlp_mmu_init();
 #endif
 }
diff --git a/arch/mips/netlogic/common/smpboot.S b/arch/mips/netlogic/common/smpboot.S
index 25c1825..a0b7487 100644
--- a/arch/mips/netlogic/common/smpboot.S
+++ b/arch/mips/netlogic/common/smpboot.S
@@ -186,7 +186,7 @@ EXPORT(nlm_boot_siblings)
 	* jump to the secondary wait function.
 	*/
 	mfc0	v0, CP0_EBASE, 1
-	andi	v0, 0x7f		/* v0 <- node/core */
+	andi	v0, 0x3ff		/* v0 <- node/core */
 
 	/* Init MMU in the first thread after changing THREAD_MODE
 	 * register (Ax Errata?)
@@ -263,6 +263,8 @@ NESTED(nlm_boot_secondary_cpus, 16, sp)
 	PTR_L	gp, 0(t1)
 
 	/* a0 has the processor id */
+	mfc0	a0, CP0_EBASE, 1
+	andi	a0, 0x3ff		/* a0 <- node/core */
 	PTR_LA	t0, nlm_early_init_secondary
 	jalr	t0
 	nop
-- 
1.7.9.5
