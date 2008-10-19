Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Oct 2008 03:07:28 +0100 (BST)
Received: from sakura.staff.proxad.net ([213.228.1.107]:37844 "EHLO
	sakura.staff.proxad.net") by ftp.linux-mips.org with ESMTP
	id S21816156AbYJSCHD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 19 Oct 2008 03:07:03 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
	id 80D64112404F; Sun, 19 Oct 2008 04:07:02 +0200 (CEST)
From:	Maxime Bizon <mbizon@freebox.fr>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH/RFC v1 01/12] [MIPS] BCM63XX: Add Broadcom 63xx CPU definitions.
Date:	Sun, 19 Oct 2008 04:07:02 +0200
Message-Id: <1224382022-24196-1-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.5.4.3
Return-Path: <max@sakura.staff.proxad.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20797
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 arch/mips/include/asm/cpu.h  |    7 +++++++
 arch/mips/kernel/cpu-probe.c |   25 +++++++++++++++++++++++++
 arch/mips/mm/tlbex.c         |    4 ++++
 3 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 229a786..538bcde 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -112,6 +112,12 @@
 
 #define PRID_IMP_BCM4710	0x4000
 #define PRID_IMP_BCM3302	0x9000
+#define PRID_IMP_BCM6338	0x9000
+#define PRID_IMP_BCM6345	0x8000
+#define PRID_IMP_BCM6348	0x9100
+#define PRID_IMP_BCM4350	0xA000
+#define PRID_REV_BCM6358	0x0010
+#define PRID_REV_BCM6368	0x0030
 
 /*
  * Definitions for 7:0 on legacy processors
@@ -198,6 +204,7 @@ enum cpu_type_enum {
 	CPU_4KC, CPU_4KEC, CPU_4KSC, CPU_24K, CPU_34K, CPU_1004K, CPU_74K,
 	CPU_AU1000, CPU_AU1100, CPU_AU1200, CPU_AU1210, CPU_AU1250, CPU_AU1500,
 	CPU_AU1550, CPU_PR4450, CPU_BCM3302, CPU_BCM4710,
+	CPU_BCM6338, CPU_BCM6345, CPU_BCM6348, CPU_BCM6358,
 
 	/*
 	 * MIPS64 class processors
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 0cf1545..6dd396c 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -154,6 +154,10 @@ void __init check_wait(void)
 	case CPU_25KF:
 	case CPU_PR4450:
 	case CPU_BCM3302:
+	case CPU_BCM6338:
+	case CPU_BCM6345:
+	case CPU_BCM6348:
+	case CPU_BCM6358:
 		cpu_wait = r4k_wait;
 		break;
 
@@ -804,11 +808,28 @@ static inline void cpu_probe_broadcom(struct cpuinfo_mips *c)
 	decode_configs(c);
 	switch (c->processor_id & 0xff00) {
 	case PRID_IMP_BCM3302:
+	/* same as PRID_IMP_BCM6338 */
 		c->cputype = CPU_BCM3302;
 		break;
 	case PRID_IMP_BCM4710:
 		c->cputype = CPU_BCM4710;
 		break;
+	case PRID_IMP_BCM6345:
+		c->cputype = CPU_BCM6345;
+		break;
+	case PRID_IMP_BCM6348:
+		c->cputype = CPU_BCM6348;
+		break;
+	case PRID_IMP_BCM4350:
+		switch (c->processor_id & 0xf0) {
+		case PRID_REV_BCM6358:
+			c->cputype = CPU_BCM6358;
+			break;
+		default:
+			c->cputype = CPU_UNKNOWN;
+			break;
+		}
+		break;
 	default:
 		c->cputype = CPU_UNKNOWN;
 		break;
@@ -894,6 +915,10 @@ static __cpuinit const char *cpu_to_name(struct cpuinfo_mips *c)
 	case CPU_SR71000:	name = "Sandcraft SR71000"; break;
 	case CPU_BCM3302:	name = "Broadcom BCM3302"; break;
 	case CPU_BCM4710:	name = "Broadcom BCM4710"; break;
+	case CPU_BCM6338:	name = "Broadcom BCM6338"; break;
+	case CPU_BCM6345:	name = "Broadcom BCM6345"; break;
+	case CPU_BCM6348:	name = "Broadcom BCM6348"; break;
+	case CPU_BCM6358:	name = "Broadcom BCM6358"; break;
 	case CPU_PR4450:	name = "Philips PR4450"; break;
 	case CPU_LOONGSON2:	name = "ICT Loongson-2"; break;
 	default:
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 979cf91..f6deda3 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -317,6 +317,10 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case CPU_BCM3302:
 	case CPU_BCM4710:
 	case CPU_LOONGSON2:
+	case CPU_BCM6338:
+	case CPU_BCM6345:
+	case CPU_BCM6348:
+	case CPU_BCM6358:
 		if (m4kc_tlbp_war())
 			uasm_i_nop(p);
 		tlbw(p);
-- 
1.5.4.3
