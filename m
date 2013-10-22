Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Oct 2013 13:14:24 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:4074 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6815858Ab3JVLOVb-Rqh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Oct 2013 13:14:21 +0200
Received: from [10.9.208.55] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 22 Oct 2013 04:13:49 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Tue, 22 Oct 2013 04:14:07 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Tue, 22 Oct 2013 04:14:07 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 22C1E246A3; Tue, 22
 Oct 2013 04:14:05 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>, ralf@linux-mips.org
Subject: [PATCH 11/18 UPDATED] MIPS: Netlogic: SYS block updates of
 XLP9XX
Date:   Tue, 22 Oct 2013 16:50:58 +0530
Message-ID: <1382440858-10905-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1381756874-22616-12-git-send-email-jchandra@broadcom.com>
References: <1381756874-22616-12-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7E7882671SC177385-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38380
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

Add the SYS block registers for XLP9XX, most of them have changed.
The wakeup sequence has been updated to set the coherent mode from
the main thread rather than the woken up thread.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
Updated to apply cleanly after change to 06/18 in this patchset

 arch/mips/include/asm/netlogic/xlp-hal/sys.h |   18 ++++++-
 arch/mips/netlogic/common/reset.S            |    8 +++
 arch/mips/netlogic/xlp/nlm_hal.c             |    5 +-
 arch/mips/netlogic/xlp/setup.c               |    5 +-
 arch/mips/netlogic/xlp/wakeup.c              |   74 ++++++++++++++++++--------
 5 files changed, 84 insertions(+), 26 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/sys.h b/arch/mips/include/asm/netlogic/xlp-hal/sys.h
index fcf2833..d9b107f 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/sys.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/sys.h
@@ -147,13 +147,29 @@
 #define SYS_SYS_PLL_MEM_REQ			0x2a3
 #define SYS_PLL_MEM_STAT			0x2a4
 
+/* Registers changed on 9XX */
+#define SYS_9XX_POWER_ON_RESET_CFG		0x00
+#define SYS_9XX_CHIP_RESET			0x01
+#define SYS_9XX_CPU_RESET			0x02
+#define SYS_9XX_CPU_NONCOHERENT_MODE		0x03
+
+/* XLP 9XX fuse block registers */
+#define FUSE_9XX_DEVCFG6			0xc6
+
 #ifndef __ASSEMBLY__
 
 #define nlm_read_sys_reg(b, r)		nlm_read_reg(b, r)
 #define nlm_write_sys_reg(b, r, v)	nlm_write_reg(b, r, v)
-#define nlm_get_sys_pcibase(node) nlm_pcicfg_base(XLP_IO_SYS_OFFSET(node))
+#define nlm_get_sys_pcibase(node)	nlm_pcicfg_base(cpu_is_xlp9xx() ? \
+		XLP9XX_IO_SYS_OFFSET(node) : XLP_IO_SYS_OFFSET(node))
 #define nlm_get_sys_regbase(node) (nlm_get_sys_pcibase(node) + XLP_IO_PCI_HDRSZ)
 
+/* XLP9XX fuse block */
+#define nlm_get_fuse_pcibase(node)	\
+			nlm_pcicfg_base(XLP9XX_IO_FUSE_OFFSET(node))
+#define nlm_get_fuse_regbase(node)	\
+			(nlm_get_fuse_pcibase(node) + XLP_IO_PCI_HDRSZ)
+
 unsigned int nlm_get_pic_frequency(int node);
 #endif
 #endif
diff --git a/arch/mips/netlogic/common/reset.S b/arch/mips/netlogic/common/reset.S
index 57eb7a1..dfbf94d 100644
--- a/arch/mips/netlogic/common/reset.S
+++ b/arch/mips/netlogic/common/reset.S
@@ -159,6 +159,13 @@ FEXPORT(nlm_reset_entry)
 	nop
 
 1:	/* Entry point on core wakeup */
+	mfc0	t0, CP0_EBASE, 0	/* processor ID */
+	andi	t0, 0xff00
+	li	t1, 0x1500		/* XLP 9xx */
+	beq	t0, t1, 2f		/* does not need to set coherent */
+	nop
+
+	/* set bit in SYS coherent register for the core */
 	mfc0	t0, CP0_EBASE, 1
 	mfc0	t1, CP0_EBASE, 1
 	srl	t1, 5
@@ -180,6 +187,7 @@ FEXPORT(nlm_reset_entry)
 	lw	t1, 0(t2)
 	sync
 
+2:
 	/* Configure LSU on Non-0 Cores. */
 	xlp_config_lsu
 	/* FALL THROUGH */
diff --git a/arch/mips/netlogic/xlp/nlm_hal.c b/arch/mips/netlogic/xlp/nlm_hal.c
index 2d31cf1..61f325d 100644
--- a/arch/mips/netlogic/xlp/nlm_hal.c
+++ b/arch/mips/netlogic/xlp/nlm_hal.c
@@ -174,7 +174,10 @@ unsigned int nlm_get_core_frequency(int node, int core)
 	uint64_t num, sysbase;
 
 	sysbase = nlm_get_node(node)->sysbase;
-	rstval = nlm_read_sys_reg(sysbase, SYS_POWER_ON_RESET_CFG);
+	if (cpu_is_xlp9xx())
+		rstval = nlm_read_sys_reg(sysbase, SYS_9XX_POWER_ON_RESET_CFG);
+	else
+		rstval = nlm_read_sys_reg(sysbase, SYS_POWER_ON_RESET_CFG);
 	if (cpu_is_xlpii()) {
 		num = 1000000ULL * (400 * 3 + 100 * (rstval >> 26));
 		denom = 3;
diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index fb4dd71..a3c1a95 100644
--- a/arch/mips/netlogic/xlp/setup.c
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -56,7 +56,10 @@ static void nlm_linux_exit(void)
 {
 	uint64_t sysbase = nlm_get_node(0)->sysbase;
 
-	nlm_write_sys_reg(sysbase, SYS_CHIP_RESET, 1);
+	if (cpu_is_xlp9xx())
+		nlm_write_sys_reg(sysbase, SYS_9XX_CHIP_RESET, 1);
+	else
+		nlm_write_sys_reg(sysbase, SYS_CHIP_RESET, 1);
 	for ( ; ; )
 		cpu_wait();
 }
diff --git a/arch/mips/netlogic/xlp/wakeup.c b/arch/mips/netlogic/xlp/wakeup.c
index 598b4c3..7e3c5b9 100644
--- a/arch/mips/netlogic/xlp/wakeup.c
+++ b/arch/mips/netlogic/xlp/wakeup.c
@@ -54,7 +54,7 @@
 static int xlp_wakeup_core(uint64_t sysbase, int node, int core)
 {
 	uint32_t coremask, value;
-	int count;
+	int count, resetreg;
 
 	coremask = (1 << core);
 
@@ -65,12 +65,24 @@ static int xlp_wakeup_core(uint64_t sysbase, int node, int core)
 		nlm_write_sys_reg(sysbase, SYS_CORE_DFS_DIS_CTRL, value);
 	}
 
+	/* On 9XX, mark coherent first */
+	if (cpu_is_xlp9xx()) {
+		value = nlm_read_sys_reg(sysbase, SYS_9XX_CPU_NONCOHERENT_MODE);
+		value &= ~coremask;
+		nlm_write_sys_reg(sysbase, SYS_9XX_CPU_NONCOHERENT_MODE, value);
+	}
+
 	/* Remove CPU Reset */
-	value = nlm_read_sys_reg(sysbase, SYS_CPU_RESET);
+	resetreg = cpu_is_xlp9xx() ? SYS_9XX_CPU_RESET : SYS_CPU_RESET;
+	value = nlm_read_sys_reg(sysbase, resetreg);
 	value &= ~coremask;
-	nlm_write_sys_reg(sysbase, SYS_CPU_RESET, value);
+	nlm_write_sys_reg(sysbase, resetreg, value);
+
+	/* We are done on 9XX */
+	if (cpu_is_xlp9xx())
+		return 1;
 
-	/* Poll for CPU to mark itself coherent */
+	/* Poll for CPU to mark itself coherent on other type of XLP */
 	count = 100000;
 	do {
 		value = nlm_read_sys_reg(sysbase, SYS_CPU_NONCOHERENT_MODE);
@@ -98,33 +110,48 @@ static int wait_for_cpus(int cpu, int bootcpu)
 static void xlp_enable_secondary_cores(const cpumask_t *wakeup_mask)
 {
 	struct nlm_soc_info *nodep;
-	uint64_t syspcibase;
+	uint64_t syspcibase, fusebase;
 	uint32_t syscoremask, mask, fusemask;
 	int core, n, cpu;
 
 	for (n = 0; n < NLM_NR_NODES; n++) {
-		syspcibase = nlm_get_sys_pcibase(n);
-		if (nlm_read_reg(syspcibase, 0) == 0xffffffff)
-			break;
+		if (n != 0) {
+			/* check if node exists and is online */
+			if (cpu_is_xlp9xx()) {
+				int b = xlp9xx_get_socbus(n);
+				pr_info("Node %d SoC PCI bus %d.\n", n, b);
+				if (b == 0)
+					break;
+			} else {
+				syspcibase = nlm_get_sys_pcibase(n);
+				if (nlm_read_reg(syspcibase, 0) == 0xffffffff)
+					break;
+			}
+			nlm_node_init(n);
+		}
 
 		/* read cores in reset from SYS */
-		if (n != 0)
-			nlm_node_init(n);
 		nodep = nlm_get_node(n);
 
-		fusemask = nlm_read_sys_reg(nodep->sysbase,
-					SYS_EFUSE_DEVICE_CFG_STATUS0);
-		switch (read_c0_prid() & 0xff00) {
-		case PRID_IMP_NETLOGIC_XLP3XX:
-			mask = 0xf;
-			break;
-		case PRID_IMP_NETLOGIC_XLP2XX:
-			mask = 0x3;
-			break;
-		case PRID_IMP_NETLOGIC_XLP8XX:
-		default:
-			mask = 0xff;
-			break;
+		if (cpu_is_xlp9xx()) {
+			fusebase = nlm_get_fuse_regbase(n);
+			fusemask = nlm_read_reg(fusebase, FUSE_9XX_DEVCFG6);
+			mask = 0xfffff;
+		} else {
+			fusemask = nlm_read_sys_reg(nodep->sysbase,
+						SYS_EFUSE_DEVICE_CFG_STATUS0);
+			switch (read_c0_prid() & 0xff00) {
+			case PRID_IMP_NETLOGIC_XLP3XX:
+				mask = 0xf;
+				break;
+			case PRID_IMP_NETLOGIC_XLP2XX:
+				mask = 0x3;
+				break;
+			case PRID_IMP_NETLOGIC_XLP8XX:
+			default:
+				mask = 0xff;
+				break;
+			}
 		}
 
 		/*
@@ -137,6 +164,7 @@ static void xlp_enable_secondary_cores(const cpumask_t *wakeup_mask)
 		if (n == 0)
 			nodep->coremask = 1;
 
+		pr_info("Node %d - SYS/FUSE coremask %x\n", n, syscoremask);
 		for (core = 0; core < NLM_CORES_PER_NODE; core++) {
 			/* we will be on node 0 core 0 */
 			if (n == 0 && core == 0)
-- 
1.7.9.5
