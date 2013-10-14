Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Oct 2013 15:21:24 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:4114 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6831299Ab3JNNP7GgJm9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Oct 2013 15:15:59 +0200
Received: from [10.9.208.53] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 14 Oct 2013 06:15:16 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 14 Oct 2013 06:15:20 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 14 Oct 2013 06:15:20 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id ECFA9246A3; Mon, 14
 Oct 2013 06:15:19 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>, ralf@linux-mips.org
Subject: [PATCH 08/18] MIPS: Netlogic: Identify XLP 9XX chip
Date:   Mon, 14 Oct 2013 18:51:04 +0530
Message-ID: <1381756874-22616-9-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1381756874-22616-1-git-send-email-jchandra@broadcom.com>
References: <1381756874-22616-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7E4531EE1R0100350015-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38337
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
index 3ab1290..c29f222 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
@@ -91,8 +91,15 @@ static inline int cpu_is_xlpii(void)
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
index 5465dc1..e526ca0 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -923,6 +923,7 @@ static inline void cpu_probe_netlogic(struct cpuinfo_mips *c, int cpu)
 
 	switch (c->processor_id & PRID_IMP_MASK) {
 	case PRID_IMP_NETLOGIC_XLP2XX:
+	case PRID_IMP_NETLOGIC_XLP9XX:
 		c->cputype = CPU_XLP;
 		__cpu_name[cpu] = "Broadcom XLPII";
 		break;
diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index bf3fdef..fb4dd71 100644
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
