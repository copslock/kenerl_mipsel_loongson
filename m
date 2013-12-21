Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Dec 2013 12:12:39 +0100 (CET)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:23520 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823991Ab3LULK5WUENd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Dec 2013 12:10:57 +0100
X-IronPort-AV: E=Sophos;i="4.95,527,1384329600"; 
   d="scan'208";a="4638689"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw1-out.broadcom.com with ESMTP; 21 Dec 2013 03:17:03 -0800
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.1.438.0; Sat, 21 Dec 2013 03:10:55 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP Server id
 14.1.438.0; Sat, 21 Dec 2013 03:10:55 -0800
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 EF0E3246A5;    Sat, 21 Dec 2013 03:10:54 -0800 (PST)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>, <ralf@linux-mips.org>
Subject: [PATCH 08/18] MIPS: Netlogic: Identify XLP 9XX chip
Date:   Sat, 21 Dec 2013 16:52:20 +0530
Message-ID: <1387624950-31297-9-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1387624950-31297-1-git-send-email-jchandra@broadcom.com>
References: <1387624950-31297-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38778
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

Adds processor ID of XLP 9XX to asm/cpu.h.  Update netlogic/xlp-hal/xlp.h
to add cpu_is_xlp9xx() and to update cpu_is_xlpii() to support XLP 9XX.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/cpu.h                  |    1 +
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h |    9 ++++++++-
 arch/mips/kernel/cpu-probe.c                 |    1 +
 arch/mips/netlogic/xlp/setup.c               |    1 +
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index d2035e1..40727e2 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -194,6 +194,7 @@
 #define PRID_IMP_NETLOGIC_XLP8XX	0x1000
 #define PRID_IMP_NETLOGIC_XLP3XX	0x1100
 #define PRID_IMP_NETLOGIC_XLP2XX	0x1200
+#define PRID_IMP_NETLOGIC_XLP9XX	0x1500
 
 /*
  * Particular Revision values for bits 7:0 of the PRId register.
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
index e62e7be..9ccdb7d 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
@@ -92,8 +92,15 @@ static inline int cpu_is_xlpii(void)
 {
 	int chip = read_c0_prid() & 0xff00;
 
-	return chip == PRID_IMP_NETLOGIC_XLP2XX;
+	return chip == PRID_IMP_NETLOGIC_XLP2XX ||
+		chip == PRID_IMP_NETLOGIC_XLP9XX;
 }
 
+static inline int cpu_is_xlp9xx(void)
+{
+	int chip = read_c0_prid() & 0xff00;
+
+	return chip == PRID_IMP_NETLOGIC_XLP9XX;
+}
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASM_NLM_XLP_H */
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index c814287..7adffbf 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -943,6 +943,7 @@ static inline void cpu_probe_netlogic(struct cpuinfo_mips *c, int cpu)
 
 	switch (c->processor_id & PRID_IMP_MASK) {
 	case PRID_IMP_NETLOGIC_XLP2XX:
+	case PRID_IMP_NETLOGIC_XLP9XX:
 		c->cputype = CPU_XLP;
 		__cpu_name[cpu] = "Broadcom XLPII";
 		break;
diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index a31296f..d1057bd 100644
--- a/arch/mips/netlogic/xlp/setup.c
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -119,6 +119,7 @@ void __init plat_mem_setup(void)
 const char *get_system_type(void)
 {
 	switch (read_c0_prid() & 0xff00) {
+	case PRID_IMP_NETLOGIC_XLP9XX:
 	case PRID_IMP_NETLOGIC_XLP2XX:
 		return "Broadcom XLPII Series";
 	default:
-- 
1.7.9.5
