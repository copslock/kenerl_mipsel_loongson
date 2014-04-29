Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Apr 2014 16:36:15 +0200 (CEST)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:30646 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6843091AbaD2OcHuHdzZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Apr 2014 16:32:07 +0200
X-IronPort-AV: E=Sophos;i="4.97,951,1389772800"; 
   d="scan'208";a="27211046"
Received: from irvexchcas07.broadcom.com (HELO IRVEXCHCAS07.corp.ad.broadcom.com) ([10.9.208.55])
  by mail-gw1-out.broadcom.com with ESMTP; 29 Apr 2014 08:42:33 -0700
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Tue, 29 Apr 2014 07:32:05 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP Server id
 14.3.174.1; Tue, 29 Apr 2014 07:32:06 -0700
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 E41EC51E7D;    Tue, 29 Apr 2014 07:32:04 -0700 (PDT)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Yonghong Song <ysong@broadcom.com>, <ralf@linux-mips.org>,
        Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH 14/17] MIPS: Netlogic: Add support for XLP5XX
Date:   Tue, 29 Apr 2014 20:07:53 +0530
Message-ID: <22f7fc909d99e1bbef60a7ca6dc3a7f947849b3e.1398780013.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1398780013.git.jchandra@broadcom.com>
References: <cover.1398780013.git.jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39980
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

From: Yonghong Song <ysong@broadcom.com>

Add support for the XLP5XX processor which is an 8 core variant of the
XLP9XX. Add XLP5XX cases to code which earlier handled XLP9XX.

Signed-off-by: Yonghong Song <ysong@broadcom.com>
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/cpu.h                  |    1 +
 arch/mips/include/asm/netlogic/mips-extns.h  |    3 ++-
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h |    6 ++++--
 arch/mips/kernel/cpu-probe.c                 |    1 +
 arch/mips/netlogic/common/reset.S            |    4 ++++
 arch/mips/netlogic/xlp/dt.c                  |    1 +
 arch/mips/netlogic/xlp/setup.c               |    1 +
 arch/mips/netlogic/xlp/wakeup.c              |   10 +++++++++-
 8 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 530eb8b..fd18e86 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -201,6 +201,7 @@
 #define PRID_IMP_NETLOGIC_XLP3XX	0x1100
 #define PRID_IMP_NETLOGIC_XLP2XX	0x1200
 #define PRID_IMP_NETLOGIC_XLP9XX	0x1500
+#define PRID_IMP_NETLOGIC_XLP5XX	0x1300
 
 /*
  * Particular Revision values for bits 7:0 of the PRId register.
diff --git a/arch/mips/include/asm/netlogic/mips-extns.h b/arch/mips/include/asm/netlogic/mips-extns.h
index 38af905..06f1f75 100644
--- a/arch/mips/include/asm/netlogic/mips-extns.h
+++ b/arch/mips/include/asm/netlogic/mips-extns.h
@@ -148,7 +148,8 @@ static inline int nlm_nodeid(void)
 {
 	uint32_t prid = read_c0_prid() & PRID_IMP_MASK;
 
-	if (prid == PRID_IMP_NETLOGIC_XLP9XX)
+	if ((prid == PRID_IMP_NETLOGIC_XLP9XX) ||
+			(prid == PRID_IMP_NETLOGIC_XLP5XX))
 		return (__read_32bit_c0_register($15, 1) >> 7) & 0x7;
 	else
 		return (__read_32bit_c0_register($15, 1) >> 5) & 0x3;
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
index f75014c..8f8afe0 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
@@ -102,14 +102,16 @@ static inline int cpu_is_xlpii(void)
 	int chip = read_c0_prid() & PRID_IMP_MASK;
 
 	return chip == PRID_IMP_NETLOGIC_XLP2XX ||
-		chip == PRID_IMP_NETLOGIC_XLP9XX;
+		chip == PRID_IMP_NETLOGIC_XLP9XX ||
+		chip == PRID_IMP_NETLOGIC_XLP5XX;
 }
 
 static inline int cpu_is_xlp9xx(void)
 {
 	int chip = read_c0_prid() & PRID_IMP_MASK;
 
-	return chip == PRID_IMP_NETLOGIC_XLP9XX;
+	return chip == PRID_IMP_NETLOGIC_XLP9XX ||
+		chip == PRID_IMP_NETLOGIC_XLP5XX;
 }
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASM_NLM_XLP_H */
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 6e8fb85..5114beb 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1074,6 +1074,7 @@ static inline void cpu_probe_netlogic(struct cpuinfo_mips *c, int cpu)
 	switch (c->processor_id & PRID_IMP_MASK) {
 	case PRID_IMP_NETLOGIC_XLP2XX:
 	case PRID_IMP_NETLOGIC_XLP9XX:
+	case PRID_IMP_NETLOGIC_XLP5XX:
 		c->cputype = CPU_XLP;
 		__cpu_name[cpu] = "Broadcom XLPII";
 		break;
diff --git a/arch/mips/netlogic/common/reset.S b/arch/mips/netlogic/common/reset.S
index 5b60b46..701c4bc 100644
--- a/arch/mips/netlogic/common/reset.S
+++ b/arch/mips/netlogic/common/reset.S
@@ -177,6 +177,10 @@ FEXPORT(nlm_reset_entry)
 	beq	t0, t1, 2f		/* does not need to set coherent */
 	nop
 
+	li	t1, 0x1300		/* XLP 5xx */
+	beq	t0, t1, 2f		/* does not need to set coherent */
+	nop
+
 	/* set bit in SYS coherent register for the core */
 	mfc0	t0, CP0_EBASE, 1
 	mfc0	t1, CP0_EBASE, 1
diff --git a/arch/mips/netlogic/xlp/dt.c b/arch/mips/netlogic/xlp/dt.c
index 0b36ac8..bba993a 100644
--- a/arch/mips/netlogic/xlp/dt.c
+++ b/arch/mips/netlogic/xlp/dt.c
@@ -51,6 +51,7 @@ void __init *xlp_dt_init(void *fdtp)
 		switch (current_cpu_data.processor_id & PRID_IMP_MASK) {
 #ifdef CONFIG_DT_XLP_GVP
 		case PRID_IMP_NETLOGIC_XLP9XX:
+		case PRID_IMP_NETLOGIC_XLP5XX:
 			fdtp = __dtb_xlp_gvp_begin;
 			break;
 #endif
diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index 3455e9f..135a38f 100644
--- a/arch/mips/netlogic/xlp/setup.c
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -123,6 +123,7 @@ const char *get_system_type(void)
 {
 	switch (read_c0_prid() & PRID_IMP_MASK) {
 	case PRID_IMP_NETLOGIC_XLP9XX:
+	case PRID_IMP_NETLOGIC_XLP5XX:
 	case PRID_IMP_NETLOGIC_XLP2XX:
 		return "Broadcom XLPII Series";
 	default:
diff --git a/arch/mips/netlogic/xlp/wakeup.c b/arch/mips/netlogic/xlp/wakeup.c
index f4823ad..e5f44d2 100644
--- a/arch/mips/netlogic/xlp/wakeup.c
+++ b/arch/mips/netlogic/xlp/wakeup.c
@@ -135,7 +135,15 @@ static void xlp_enable_secondary_cores(const cpumask_t *wakeup_mask)
 		if (cpu_is_xlp9xx()) {
 			fusebase = nlm_get_fuse_regbase(n);
 			fusemask = nlm_read_reg(fusebase, FUSE_9XX_DEVCFG6);
-			mask = 0xfffff;
+			switch (read_c0_prid() & PRID_IMP_MASK) {
+			case PRID_IMP_NETLOGIC_XLP5XX:
+				mask = 0xff;
+				break;
+			case PRID_IMP_NETLOGIC_XLP9XX:
+			default:
+				mask = 0xfffff;
+				break;
+			}
 		} else {
 			fusemask = nlm_read_sys_reg(nodep->sysbase,
 						SYS_EFUSE_DEVICE_CFG_STATUS0);
-- 
1.7.9.5
