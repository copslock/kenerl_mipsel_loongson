Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Aug 2013 11:13:40 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:1123 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822682Ab3HKJN37VLqY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 11 Aug 2013 11:13:29 +0200
Received: from [10.9.208.57] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sun, 11 Aug 2013 02:09:23 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Sun, 11 Aug 2013 02:13:14 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Sun, 11 Aug 2013 02:13:14 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 1C70EF2D73; Sun, 11
 Aug 2013 02:13:12 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 04/10] MIPS: Netlogic: Add support for XLP2XX
Date:   Sun, 11 Aug 2013 14:43:54 +0530
Message-ID: <1376212440-21038-5-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1376212440-21038-1-git-send-email-jchandra@broadcom.com>
References: <1376212440-21038-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7E198B4931W83115094-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37512
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

XLP2XX is first in the series of 28nm XLPII processors.

The changes are to:
* Add processor ID for XLP2XX to asm/cpu.h and kernel/cpu-probe.c.
* Add a cpu_is_xlpii() function to check for XLPII processors.
* Update xlp_mmu_init() to use config4 to enable extended TLB.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/cpu.h                  |    1 +
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h |    7 +++++++
 arch/mips/kernel/cpu-probe.c                 |    5 +++++
 arch/mips/netlogic/xlp/setup.c               |   27 +++++++++++++++++++-------
 4 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 632bbe5..7c8d15d 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -176,6 +176,7 @@
 
 #define PRID_IMP_NETLOGIC_XLP8XX	0x1000
 #define PRID_IMP_NETLOGIC_XLP3XX	0x1100
+#define PRID_IMP_NETLOGIC_XLP2XX	0x1200
 
 /*
  * Definitions for 7:0 on legacy processors
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
index d59cdd6..7a4a514 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
@@ -64,5 +64,12 @@ int xlp_get_dram_map(int n, uint64_t *dram_map);
 /* Device tree related */
 void *xlp_dt_init(void *fdtp);
 
+static inline int cpu_is_xlpii(void)
+{
+	int chip = read_c0_prid() & 0xff00;
+
+	return chip == PRID_IMP_NETLOGIC_XLP2XX;
+}
+
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASM_NLM_XLP_H */
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 4c6167a..bfd5acb 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -899,6 +899,11 @@ static inline void cpu_probe_netlogic(struct cpuinfo_mips *c, int cpu)
 			MIPS_CPU_LLSC);
 
 	switch (c->processor_id & 0xff00) {
+	case PRID_IMP_NETLOGIC_XLP2XX:
+		c->cputype = CPU_XLP;
+		__cpu_name[cpu] = "Broadcom XLPII";
+		break;
+
 	case PRID_IMP_NETLOGIC_XLP8XX:
 	case PRID_IMP_NETLOGIC_XLP3XX:
 		c->cputype = CPU_XLP;
diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index 0c6e300..0a99cd5 100644
--- a/arch/mips/netlogic/xlp/setup.c
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -110,7 +110,12 @@ void __init plat_mem_setup(void)
 
 const char *get_system_type(void)
 {
-	return "Netlogic XLP Series";
+	switch (read_c0_prid() & 0xff00) {
+	case PRID_IMP_NETLOGIC_XLP2XX:
+		return "Broadcom XLPII Series";
+	default:
+		return "Netlogic XLP Series";
+	}
 }
 
 void __init prom_free_prom_memory(void)
@@ -120,12 +125,20 @@ void __init prom_free_prom_memory(void)
 
 void xlp_mmu_init(void)
 {
-	/* enable extended TLB and Large Fixed TLB */
-	write_c0_config6(read_c0_config6() | 0x24);
-
-	/* set page mask of Fixed TLB in config7 */
-	write_c0_config7(PM_DEFAULT_MASK >>
-		(13 + (ffz(PM_DEFAULT_MASK >> 13) / 2)));
+	u32 conf4;
+
+	if (cpu_is_xlpii()) {
+		/* XLPII series has extended pagesize in config 4 */
+		conf4 = read_c0_config4() & ~0x1f00u;
+		write_c0_config4(conf4 | ((PAGE_SHIFT - 10) / 2 << 8));
+	} else {
+		/* enable extended TLB and Large Fixed TLB */
+		write_c0_config6(read_c0_config6() | 0x24);
+
+		/* set page mask of extended Fixed TLB in config7 */
+		write_c0_config7(PM_DEFAULT_MASK >>
+			(13 + (ffz(PM_DEFAULT_MASK >> 13) / 2)));
+	}
 }
 
 void nlm_percpu_init(int hwcpuid)
-- 
1.7.9.5
