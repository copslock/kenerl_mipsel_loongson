Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 09:45:14 +0100 (CET)
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36526 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010778AbcBYIpJrEkE6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Feb 2016 09:45:09 +0100
Received: by mail-pf0-f171.google.com with SMTP id e127so29255886pfe.3
        for <linux-mips@linux-mips.org>; Thu, 25 Feb 2016 00:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=xHxRtYLhNAxcpu38FOmPY+IMIL7oQ7v5zl6nrkRKAjI=;
        b=eHbfcdoI4ePipTKpyyHdXW8XSHDHHvszV4houTvFNAMrGtKmDL9rDJGecKRXSXTsbE
         zfKf5wRLG8ZjsPsPr7Uq6SZ5N0P72da3Xweup42ETzoemd7GiqXSmqza6HIpi2yDpK5y
         qILLIKxnhjTPidNi7cbfFKvO8yY1zHw5IK4ti6D1JLmzOcAKlkjGbn2KTp5DzIg/pVbB
         BhGFhx49/asohHZ+JMK+hufg2SDRHMpZAthHsjI/3XwvYt+umPanzLSPH0kbCgkM03h6
         +/quQ8wJDY1XccYn/m9dDTbKQO0ZBoqoK2I1jJqolnY/9tW54ZWIerWZZvjlkls2ZlaL
         8aaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xHxRtYLhNAxcpu38FOmPY+IMIL7oQ7v5zl6nrkRKAjI=;
        b=ExchVX4jKbrQbmEu8C49QSWawu83yTM6eu/BRic857RmrxVI5UBrP/pswGhqNJTIA1
         5pkQvRWFGiXiax89C1jgFgEm9dl305O6cHOHzF1UpJLjP3e/zYIzr5MSz3xYeHS38ik6
         muh2grTH6ss4x5mhOrQ6a6VJ4/6jahC1TEvQ5o95eXxCnQSwzStIWU08oDxvUKRkAZ/U
         2WS3t0anrTceq/4augK4AyFOBhquQmnccV3Dl2xOacuecEp/RO7rPDAvzb9+V1B4reas
         EYPaKl7NYeNogCjsahKRSgkKY71p/j7wCtmwOpD7aipn/RScreHQ43oMJgyqOKrlEWdR
         6hlQ==
X-Gm-Message-State: AG10YOSVhzSJ7DWDNDiBcobQsP0UcO2C8CV/mZbM/+N9jH+meYjlCaPaB5o8KskID3sFRA==
X-Received: by 10.98.12.29 with SMTP id u29mr60531314pfi.116.1456389903700;
        Thu, 25 Feb 2016 00:45:03 -0800 (PST)
Received: from abuchbinder-glaptop.roam.corp.google.com (c-67-188-140-169.hsd1.ca.comcast.net. [67.188.140.169])
        by smtp.gmail.com with ESMTPSA id qh8sm10351276pac.40.2016.02.25.00.45.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Feb 2016 00:45:03 -0800 (PST)
From:   Adam Buchbinder <adam.buchbinder@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     trivial@kernel.org, Adam Buchbinder <adam.buchbinder@gmail.com>
Subject: [PATCH] mips: Fix misspellings in comments.
Date:   Thu, 25 Feb 2016 00:44:58 -0800
Message-Id: <1456389898-14695-1-git-send-email-adam.buchbinder@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
Return-Path: <adam.buchbinder@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adam.buchbinder@gmail.com
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

Signed-off-by: Adam Buchbinder <adam.buchbinder@gmail.com>
---
 arch/mips/alchemy/common/dbdma.c                       |  4 ++--
 .../cavium-octeon/executive/cvmx-interrupt-decodes.c   | 14 +++++++-------
 arch/mips/cavium-octeon/executive/cvmx-pko.c           |  2 +-
 arch/mips/cavium-octeon/smp.c                          |  2 +-
 arch/mips/dec/int-handler.S                            |  2 +-
 arch/mips/fw/arc/memory.c                              |  2 +-
 .../include/asm/mach-cavium-octeon/kernel-entry-init.h |  2 +-
 arch/mips/include/asm/mach-generic/kernel-entry-init.h |  2 +-
 arch/mips/include/asm/mach-ip27/irq.h                  |  2 +-
 arch/mips/include/asm/mach-ip27/kernel-entry-init.h    |  2 +-
 arch/mips/include/asm/mach-jz4740/gpio.h               |  2 +-
 arch/mips/include/asm/mips-cm.h                        |  2 +-
 arch/mips/include/asm/octeon/cvmx-config.h             |  2 +-
 arch/mips/include/asm/octeon/cvmx.h                    |  2 +-
 arch/mips/include/asm/pci/bridge.h                     | 18 +++++++++---------
 arch/mips/include/asm/sgi/hpc3.h                       |  2 +-
 arch/mips/include/asm/sgiarcs.h                        |  4 ++--
 arch/mips/include/asm/sn/ioc3.h                        |  2 +-
 arch/mips/include/asm/sn/sn0/hubio.h                   |  2 +-
 arch/mips/include/asm/uaccess.h                        |  2 +-
 arch/mips/kernel/mips-cm.c                             |  2 +-
 arch/mips/kernel/perf_event_mipsxx.c                   |  2 +-
 arch/mips/kernel/pm-cps.c                              |  2 +-
 arch/mips/kernel/process.c                             |  2 +-
 arch/mips/kernel/traps.c                               |  2 +-
 arch/mips/kvm/tlb.c                                    |  2 +-
 arch/mips/kvm/trap_emul.c                              |  2 +-
 arch/mips/math-emu/ieee754dp.c                         |  6 +++---
 arch/mips/math-emu/ieee754sp.c                         |  6 +++---
 arch/mips/mm/sc-ip22.c                                 |  2 +-
 arch/mips/mm/tlbex.c                                   |  2 +-
 arch/mips/sgi-ip27/ip27-memory.c                       |  2 +-
 32 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/arch/mips/alchemy/common/dbdma.c b/arch/mips/alchemy/common/dbdma.c
index 745695d..f2f264b 100644
--- a/arch/mips/alchemy/common/dbdma.c
+++ b/arch/mips/alchemy/common/dbdma.c
@@ -261,7 +261,7 @@ u32 au1xxx_dbdma_chan_alloc(u32 srcid, u32 destid,
 	au1x_dma_chan_t *cp;
 
 	/*
-	 * We do the intialization on the first channel allocation.
+	 * We do the initialization on the first channel allocation.
 	 * We have to wait because of the interrupt handler initialization
 	 * which can't be done successfully during board set up.
 	 */
@@ -964,7 +964,7 @@ u32 au1xxx_dbdma_put_dscr(u32 chanid, au1x_ddma_desc_t *dscr)
 	dp->dscr_source1 = dscr->dscr_source1;
 	dp->dscr_cmd1 = dscr->dscr_cmd1;
 	nbytes = dscr->dscr_cmd1;
-	/* Allow the caller to specifiy if an interrupt is generated */
+	/* Allow the caller to specify if an interrupt is generated */
 	dp->dscr_cmd0 &= ~DSCR_CMD0_IE;
 	dp->dscr_cmd0 |= dscr->dscr_cmd0 | DSCR_CMD0_V;
 	ctp->chan_ptr->ddma_dbell = 0;
diff --git a/arch/mips/cavium-octeon/executive/cvmx-interrupt-decodes.c b/arch/mips/cavium-octeon/executive/cvmx-interrupt-decodes.c
index e59d1b7..2f415d9 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-interrupt-decodes.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-interrupt-decodes.c
@@ -68,7 +68,7 @@ void __cvmx_interrupt_gmxx_rxx_int_en_enable(int index, int block)
 		gmx_rx_int_en.s.pause_drp = 1;
 		/* Skipping gmx_rx_int_en.s.reserved_16_18 */
 		/*gmx_rx_int_en.s.ifgerr = 1; */
-		/*gmx_rx_int_en.s.coldet = 1; // Collsion detect */
+		/*gmx_rx_int_en.s.coldet = 1; // Collision detect */
 		/*gmx_rx_int_en.s.falerr = 1; // False carrier error or extend error after slottime */
 		/*gmx_rx_int_en.s.rsverr = 1; // RGMII reserved opcodes */
 		/*gmx_rx_int_en.s.pcterr = 1; // Bad Preamble / Protocol */
@@ -89,7 +89,7 @@ void __cvmx_interrupt_gmxx_rxx_int_en_enable(int index, int block)
 		/*gmx_rx_int_en.s.phy_spd = 1; */
 		/*gmx_rx_int_en.s.phy_link = 1; */
 		/*gmx_rx_int_en.s.ifgerr = 1; */
-		/*gmx_rx_int_en.s.coldet = 1; // Collsion detect */
+		/*gmx_rx_int_en.s.coldet = 1; // Collision detect */
 		/*gmx_rx_int_en.s.falerr = 1; // False carrier error or extend error after slottime */
 		/*gmx_rx_int_en.s.rsverr = 1; // RGMII reserved opcodes */
 		/*gmx_rx_int_en.s.pcterr = 1; // Bad Preamble / Protocol */
@@ -112,7 +112,7 @@ void __cvmx_interrupt_gmxx_rxx_int_en_enable(int index, int block)
 		/*gmx_rx_int_en.s.phy_spd = 1; */
 		/*gmx_rx_int_en.s.phy_link = 1; */
 		/*gmx_rx_int_en.s.ifgerr = 1; */
-		/*gmx_rx_int_en.s.coldet = 1; // Collsion detect */
+		/*gmx_rx_int_en.s.coldet = 1; // Collision detect */
 		/*gmx_rx_int_en.s.falerr = 1; // False carrier error or extend error after slottime */
 		/*gmx_rx_int_en.s.rsverr = 1; // RGMII reserved opcodes */
 		/*gmx_rx_int_en.s.pcterr = 1; // Bad Preamble / Protocol */
@@ -134,7 +134,7 @@ void __cvmx_interrupt_gmxx_rxx_int_en_enable(int index, int block)
 		/*gmx_rx_int_en.s.phy_spd = 1; */
 		/*gmx_rx_int_en.s.phy_link = 1; */
 		/*gmx_rx_int_en.s.ifgerr = 1; */
-		/*gmx_rx_int_en.s.coldet = 1; // Collsion detect */
+		/*gmx_rx_int_en.s.coldet = 1; // Collision detect */
 		/*gmx_rx_int_en.s.falerr = 1; // False carrier error or extend error after slottime */
 		/*gmx_rx_int_en.s.rsverr = 1; // RGMII reserved opcodes */
 		/*gmx_rx_int_en.s.pcterr = 1; // Bad Preamble / Protocol */
@@ -156,7 +156,7 @@ void __cvmx_interrupt_gmxx_rxx_int_en_enable(int index, int block)
 		/*gmx_rx_int_en.s.phy_spd = 1; */
 		/*gmx_rx_int_en.s.phy_link = 1; */
 		/*gmx_rx_int_en.s.ifgerr = 1; */
-		/*gmx_rx_int_en.s.coldet = 1; // Collsion detect */
+		/*gmx_rx_int_en.s.coldet = 1; // Collision detect */
 		/*gmx_rx_int_en.s.falerr = 1; // False carrier error or extend error after slottime */
 		/*gmx_rx_int_en.s.rsverr = 1; // RGMII reserved opcodes */
 		/*gmx_rx_int_en.s.pcterr = 1; // Bad Preamble / Protocol */
@@ -179,7 +179,7 @@ void __cvmx_interrupt_gmxx_rxx_int_en_enable(int index, int block)
 		/*gmx_rx_int_en.s.phy_spd = 1; */
 		/*gmx_rx_int_en.s.phy_link = 1; */
 		/*gmx_rx_int_en.s.ifgerr = 1; */
-		/*gmx_rx_int_en.s.coldet = 1; // Collsion detect */
+		/*gmx_rx_int_en.s.coldet = 1; // Collision detect */
 		/*gmx_rx_int_en.s.falerr = 1; // False carrier error or extend error after slottime */
 		/*gmx_rx_int_en.s.rsverr = 1; // RGMII reserved opcodes */
 		/*gmx_rx_int_en.s.pcterr = 1; // Bad Preamble / Protocol */
@@ -209,7 +209,7 @@ void __cvmx_interrupt_gmxx_rxx_int_en_enable(int index, int block)
 		gmx_rx_int_en.s.pause_drp = 1;
 		/* Skipping gmx_rx_int_en.s.reserved_16_18 */
 		/*gmx_rx_int_en.s.ifgerr = 1; */
-		/*gmx_rx_int_en.s.coldet = 1; // Collsion detect */
+		/*gmx_rx_int_en.s.coldet = 1; // Collision detect */
 		/*gmx_rx_int_en.s.falerr = 1; // False carrier error or extend error after slottime */
 		/*gmx_rx_int_en.s.rsverr = 1; // RGMII reserved opcodes */
 		/*gmx_rx_int_en.s.pcterr = 1; // Bad Preamble / Protocol */
diff --git a/arch/mips/cavium-octeon/executive/cvmx-pko.c b/arch/mips/cavium-octeon/executive/cvmx-pko.c
index 87be167..676fab5 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-pko.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-pko.c
@@ -189,7 +189,7 @@ void cvmx_pko_initialize_global(void)
 	/*
 	 * Set the size of the PKO command buffers to an odd number of
 	 * 64bit words. This allows the normal two word send to stay
-	 * aligned and never span a comamnd word buffer.
+	 * aligned and never span a command word buffer.
 	 */
 	config.u64 = 0;
 	config.s.pool = CVMX_FPA_OUTPUT_BUFFER_POOL;
diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index b7fa9ae..42412ba 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -331,7 +331,7 @@ static int octeon_update_boot_vector(unsigned int cpu)
 	}
 
 	if (!(avail_coremask & (1 << coreid))) {
-		/* core not available, assume, that catched by simple-executive */
+		/* core not available, assume, that caught by simple-executive */
 		cvmx_write_csr(CVMX_CIU_PP_RST, 1 << coreid);
 		cvmx_write_csr(CVMX_CIU_PP_RST, 0);
 	}
diff --git a/arch/mips/dec/int-handler.S b/arch/mips/dec/int-handler.S
index 8c6f508..d7b9918 100644
--- a/arch/mips/dec/int-handler.S
+++ b/arch/mips/dec/int-handler.S
@@ -5,7 +5,7 @@
  * Written by Ralf Baechle and Andreas Busse, modified for DECstation
  * support by Paul Antoine and Harald Koerfgen.
  *
- * completly rewritten:
+ * completely rewritten:
  * Copyright (C) 1998 Harald Koerfgen
  *
  * Rewritten extensively for controller-driven IRQ support
diff --git a/arch/mips/fw/arc/memory.c b/arch/mips/fw/arc/memory.c
index 5537b94..0d75b5a 100644
--- a/arch/mips/fw/arc/memory.c
+++ b/arch/mips/fw/arc/memory.c
@@ -9,7 +9,7 @@
  * PROM library functions for acquiring/using memory descriptors given to us
  * from the ARCS firmware.  This is only used when CONFIG_ARC_MEMORY is set
  * because on some machines like SGI IP27 the ARC memory configuration data
- * completly bogus and alternate easier to use mechanisms are available.
+ * completely bogus and alternate easier to use mechanisms are available.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
index cf92fe7..c4873e8 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
@@ -141,7 +141,7 @@ octeon_main_processor:
 .endm
 
 /*
- * Do SMP slave processor setup necessary before we can savely execute C code.
+ * Do SMP slave processor setup necessary before we can safely execute C code.
  */
 	.macro	smp_slave_setup
 	.endm
diff --git a/arch/mips/include/asm/mach-generic/kernel-entry-init.h b/arch/mips/include/asm/mach-generic/kernel-entry-init.h
index 13b0751..a229297 100644
--- a/arch/mips/include/asm/mach-generic/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-generic/kernel-entry-init.h
@@ -16,7 +16,7 @@
 	.endm
 
 /*
- * Do SMP slave processor setup necessary before we can savely execute C code.
+ * Do SMP slave processor setup necessary before we can safely execute C code.
  */
 	.macro	smp_slave_setup
 	.endm
diff --git a/arch/mips/include/asm/mach-ip27/irq.h b/arch/mips/include/asm/mach-ip27/irq.h
index cf4384b..b0b7261 100644
--- a/arch/mips/include/asm/mach-ip27/irq.h
+++ b/arch/mips/include/asm/mach-ip27/irq.h
@@ -11,7 +11,7 @@
 #define __ASM_MACH_IP27_IRQ_H
 
 /*
- * A hardwired interrupt number is completly stupid for this system - a
+ * A hardwired interrupt number is completely stupid for this system - a
  * large configuration might have thousands if not tenthousands of
  * interrupts.
  */
diff --git a/arch/mips/include/asm/mach-ip27/kernel-entry-init.h b/arch/mips/include/asm/mach-ip27/kernel-entry-init.h
index b087cb8..f992c1d 100644
--- a/arch/mips/include/asm/mach-ip27/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-ip27/kernel-entry-init.h
@@ -81,7 +81,7 @@
 	.endm
 
 /*
- * Do SMP slave processor setup necessary before we can savely execute C code.
+ * Do SMP slave processor setup necessary before we can safely execute C code.
  */
 	.macro	smp_slave_setup
 	GET_NASID_ASM	t1
diff --git a/arch/mips/include/asm/mach-jz4740/gpio.h b/arch/mips/include/asm/mach-jz4740/gpio.h
index bf8c3e1..7c7708a 100644
--- a/arch/mips/include/asm/mach-jz4740/gpio.h
+++ b/arch/mips/include/asm/mach-jz4740/gpio.h
@@ -27,7 +27,7 @@ enum jz_gpio_function {
 
 /*
  Usually a driver for a SoC component has to request several gpio pins and
- configure them as funcion pins.
+ configure them as function pins.
  jz_gpio_bulk_request can be used to ease this process.
  Usually one would do something like:
 
diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index b196825..d463539 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -28,7 +28,7 @@ extern void __iomem *mips_cm_l2sync_base;
  * This function returns the physical base address of the Coherence Manager
  * global control block, or 0 if no Coherence Manager is present. It provides
  * a default implementation which reads the CMGCRBase register where available,
- * and may be overriden by platforms which determine this address in a
+ * and may be overridden by platforms which determine this address in a
  * different way by defining a function with the same prototype except for the
  * name mips_cm_phys_base (without underscores).
  */
diff --git a/arch/mips/include/asm/octeon/cvmx-config.h b/arch/mips/include/asm/octeon/cvmx-config.h
index f7dd17d..f4f1996 100644
--- a/arch/mips/include/asm/octeon/cvmx-config.h
+++ b/arch/mips/include/asm/octeon/cvmx-config.h
@@ -33,7 +33,7 @@
 /* Packet buffers */
 #define CVMX_FPA_PACKET_POOL		    (0)
 #define CVMX_FPA_PACKET_POOL_SIZE	    CVMX_FPA_POOL_0_SIZE
-/* Work queue entrys */
+/* Work queue entries */
 #define CVMX_FPA_WQE_POOL		    (1)
 #define CVMX_FPA_WQE_POOL_SIZE		    CVMX_FPA_POOL_1_SIZE
 /* PKO queue command buffers */
diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
index 774bb45..56e3436 100644
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -189,7 +189,7 @@ static inline uint64_t cvmx_ptr_to_phys(void *ptr)
 static inline void *cvmx_phys_to_ptr(uint64_t physical_address)
 {
 	if (sizeof(void *) == 8) {
-		/* Just set the top bit, avoiding any TLB uglyness */
+		/* Just set the top bit, avoiding any TLB ugliness */
 		return CASTPTR(void,
 			       CVMX_ADD_SEG(CVMX_MIPS_SPACE_XKPHYS,
 					    physical_address));
diff --git a/arch/mips/include/asm/pci/bridge.h b/arch/mips/include/asm/pci/bridge.h
index 8d7a63b..3206245 100644
--- a/arch/mips/include/asm/pci/bridge.h
+++ b/arch/mips/include/asm/pci/bridge.h
@@ -269,16 +269,16 @@ typedef struct bridge_err_cmdword_s {
 	union {
 		u32		cmd_word;
 		struct {
-			u32	didn:4,		/* Destination ID */
-				sidn:4,		/* Source ID	  */
-				pactyp:4,	/* Packet type	  */
-				tnum:5,		/* Trans Number	  */
-				coh:1,		/* Coh Transacti  */
-				ds:2,		/* Data size	  */
-				gbr:1,		/* GBR enable	  */
-				vbpm:1,		/* VBPM message	  */
+			u32	didn:4,		/* Destination ID  */
+				sidn:4,		/* Source ID	   */
+				pactyp:4,	/* Packet type	   */
+				tnum:5,		/* Trans Number	   */
+				coh:1,		/* Coh Transaction */
+				ds:2,		/* Data size	   */
+				gbr:1,		/* GBR enable	   */
+				vbpm:1,		/* VBPM message	   */
 				error:1,	/* Error occurred  */
-				barr:1,		/* Barrier op	  */
+				barr:1,		/* Barrier op	   */
 				rsvd:8;
 		} berr_st;
 	} berr_un;
diff --git a/arch/mips/include/asm/sgi/hpc3.h b/arch/mips/include/asm/sgi/hpc3.h
index 59920b3..4a9c990 100644
--- a/arch/mips/include/asm/sgi/hpc3.h
+++ b/arch/mips/include/asm/sgi/hpc3.h
@@ -147,7 +147,7 @@ struct hpc3_ethregs {
 #define HPC3_EPCFG_P1	 0x000f /* Cycles to spend in P1 state for PIO */
 #define HPC3_EPCFG_P2	 0x00f0 /* Cycles to spend in P2 state for PIO */
 #define HPC3_EPCFG_P3	 0x0f00 /* Cycles to spend in P3 state for PIO */
-#define HPC3_EPCFG_TST	 0x1000 /* Diagnistic ram test feature bit */
+#define HPC3_EPCFG_TST	 0x1000 /* Diagnostic ram test feature bit */
 
 	u32 _unused2[0x1000/4 - 8];	/* padding */
 
diff --git a/arch/mips/include/asm/sgiarcs.h b/arch/mips/include/asm/sgiarcs.h
index 26ddfff..105a947 100644
--- a/arch/mips/include/asm/sgiarcs.h
+++ b/arch/mips/include/asm/sgiarcs.h
@@ -144,7 +144,7 @@ struct linux_tinfo {
 struct linux_vdirent {
 	ULONG namelen;
 	unsigned char attr;
-	char fname[32]; /* XXX imperical, should be a define */
+	char fname[32]; /* XXX empirical, should be a define */
 };
 
 /* Other stuff for files. */
@@ -179,7 +179,7 @@ struct linux_finfo {
 	enum linux_devtypes   dtype;
 	unsigned long	      namelen;
 	unsigned char	      attr;
-	char		      name[32]; /* XXX imperical, should be define */
+	char		      name[32]; /* XXX empirical, should be define */
 };
 
 /* This describes the vector containing function pointers to the ARC
diff --git a/arch/mips/include/asm/sn/ioc3.h b/arch/mips/include/asm/sn/ioc3.h
index e33f036..feb3851 100644
--- a/arch/mips/include/asm/sn/ioc3.h
+++ b/arch/mips/include/asm/sn/ioc3.h
@@ -355,7 +355,7 @@ struct ioc3_etxd {
 #define SSCR_PAUSE_STATE 0x40000000	/* sets when PAUSE takes effect */
 #define SSCR_RESET	0x80000000	/* reset DMA channels */
 
-/* all producer/comsumer pointers are the same bitfield */
+/* all producer/consumer pointers are the same bitfield */
 #define PROD_CONS_PTR_4K 0x00000ff8	/* for 4K buffers */
 #define PROD_CONS_PTR_1K 0x000003f8	/* for 1K buffers */
 #define PROD_CONS_PTR_OFF 3
diff --git a/arch/mips/include/asm/sn/sn0/hubio.h b/arch/mips/include/asm/sn/sn0/hubio.h
index 5998b13..57ece90 100644
--- a/arch/mips/include/asm/sn/sn0/hubio.h
+++ b/arch/mips/include/asm/sn/sn0/hubio.h
@@ -628,7 +628,7 @@ typedef union h1_icrbb_u {
 /*
  * Values for field imsgtype
  */
-#define IIO_ICRB_IMSGT_XTALK	0	/* Incoming Meessage from Xtalk */
+#define IIO_ICRB_IMSGT_XTALK	0	/* Incoming Message from Xtalk */
 #define IIO_ICRB_IMSGT_BTE	1	/* Incoming message from BTE	*/
 #define IIO_ICRB_IMSGT_SN0NET	2	/* Incoming message from SN0 net */
 #define IIO_ICRB_IMSGT_CRB	3	/* Incoming message from CRB ???  */
diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index 095ecaf..7f109d4 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -95,7 +95,7 @@ static inline bool eva_kernel_access(void)
 }
 
 /*
- * Is a address valid? This does a straighforward calculation rather
+ * Is a address valid? This does a straightforward calculation rather
  * than tests.
  *
  * Address valid if:
diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index 1448c1f..760217b 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -24,7 +24,7 @@ static char *cm2_tr[8] = {
 	"0x04", "cpc", "0x06", "0x07"
 };
 
-/* CM3 Tag ECC transation type */
+/* CM3 Tag ECC transaction type */
 static char *cm3_tr[16] = {
 	[0x0] = "ReqNoData",
 	[0x1] = "0x1",
diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index d7b8dd4..9bc1191 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -530,7 +530,7 @@ static void mipspmu_enable(struct pmu *pmu)
 
 /*
  * MIPS performance counters can be per-TC. The control registers can
- * not be directly accessed accross CPUs. Hence if we want to do global
+ * not be directly accessed across CPUs. Hence if we want to do global
  * control, we need cross CPU calls. on_each_cpu() can help us, but we
  * can not make sure this function is called with interrupts enabled. So
  * here we pause local counters and then grab a rwlock and leave the
diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index f63a289..fa3f9eb 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -472,7 +472,7 @@ static void * __init cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 	/*
 	 * Disable all but self interventions. The load from COHCTL is defined
 	 * by the interAptiv & proAptiv SUMs as ensuring that the operation
-	 * resulting from the preceeding store is complete.
+	 * resulting from the preceding store is complete.
 	 */
 	uasm_i_addiu(&p, t0, zero, 1 << cpu_data[cpu].core);
 	uasm_i_sw(&p, t0, 0, r_pcohctl);
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index eddd5fd..92880ce 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -615,7 +615,7 @@ int mips_set_process_fp_mode(struct task_struct *task, unsigned int value)
 	 * allows us to only worry about whether an FP mode switch is in
 	 * progress when FP is first used in a tasks time slice. Pretty much all
 	 * of the mode switch overhead can thus be confined to cases where mode
-	 * switches are actually occuring. That is, to here. However for the
+	 * switches are actually occurring. That is, to here. However for the
 	 * thread performing the mode switch it may take a while...
 	 */
 	if (num_online_cpus() > 1) {
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index ae790c5..c01f615 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2215,7 +2215,7 @@ void __init trap_init(void)
 
 	/*
 	 * Copy the generic exception handlers to their final destination.
-	 * This will be overriden later as suitable for a particular
+	 * This will be overridden later as suitable for a particular
 	 * configuration.
 	 */
 	set_handler(0x180, &except_vec3_generic, 0x80);
diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index a08c439..e0e1d0a 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -632,7 +632,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	kvm_debug("%s: vcpu %p, cpu: %d\n", __func__, vcpu, cpu);
 
-	/* Alocate new kernel and user ASIDs if needed */
+	/* Allocate new kernel and user ASIDs if needed */
 
 	local_irq_save(flags);
 
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index ad98800..c4038d2 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -500,7 +500,7 @@ static int kvm_trap_emul_vcpu_setup(struct kvm_vcpu *vcpu)
 	kvm_write_c0_guest_config7(cop0, (MIPS_CONF7_WII) | (1 << 10));
 
 	/*
-	 * Setup IntCtl defaults, compatibilty mode for timer interrupts (HW5)
+	 * Setup IntCtl defaults, compatibility mode for timer interrupts (HW5)
 	 */
 	kvm_write_c0_guest_intctl(cop0, 0xFC000000);
 
diff --git a/arch/mips/math-emu/ieee754dp.c b/arch/mips/math-emu/ieee754dp.c
index ad3c734..47d26c8 100644
--- a/arch/mips/math-emu/ieee754dp.c
+++ b/arch/mips/math-emu/ieee754dp.c
@@ -97,7 +97,7 @@ union ieee754dp ieee754dp_format(int sn, int xe, u64 xm)
 {
 	assert(xm);		/* we don't gen exact zeros (probably should) */
 
-	assert((xm >> (DP_FBITS + 1 + 3)) == 0);	/* no execess */
+	assert((xm >> (DP_FBITS + 1 + 3)) == 0);	/* no excess */
 	assert(xm & (DP_HIDDEN_BIT << 3));
 
 	if (xe < DP_EMIN) {
@@ -165,7 +165,7 @@ union ieee754dp ieee754dp_format(int sn, int xe, u64 xm)
 	/* strip grs bits */
 	xm >>= 3;
 
-	assert((xm >> (DP_FBITS + 1)) == 0);	/* no execess */
+	assert((xm >> (DP_FBITS + 1)) == 0);	/* no excess */
 	assert(xe >= DP_EMIN);
 
 	if (xe > DP_EMAX) {
@@ -198,7 +198,7 @@ union ieee754dp ieee754dp_format(int sn, int xe, u64 xm)
 			ieee754_setcx(IEEE754_UNDERFLOW);
 		return builddp(sn, DP_EMIN - 1 + DP_EBIAS, xm);
 	} else {
-		assert((xm >> (DP_FBITS + 1)) == 0);	/* no execess */
+		assert((xm >> (DP_FBITS + 1)) == 0);	/* no excess */
 		assert(xm & DP_HIDDEN_BIT);
 
 		return builddp(sn, xe + DP_EBIAS, xm & ~DP_HIDDEN_BIT);
diff --git a/arch/mips/math-emu/ieee754sp.c b/arch/mips/math-emu/ieee754sp.c
index def00ff..e0b2c45 100644
--- a/arch/mips/math-emu/ieee754sp.c
+++ b/arch/mips/math-emu/ieee754sp.c
@@ -97,7 +97,7 @@ union ieee754sp ieee754sp_format(int sn, int xe, unsigned xm)
 {
 	assert(xm);		/* we don't gen exact zeros (probably should) */
 
-	assert((xm >> (SP_FBITS + 1 + 3)) == 0);	/* no execess */
+	assert((xm >> (SP_FBITS + 1 + 3)) == 0);	/* no excess */
 	assert(xm & (SP_HIDDEN_BIT << 3));
 
 	if (xe < SP_EMIN) {
@@ -163,7 +163,7 @@ union ieee754sp ieee754sp_format(int sn, int xe, unsigned xm)
 	/* strip grs bits */
 	xm >>= 3;
 
-	assert((xm >> (SP_FBITS + 1)) == 0);	/* no execess */
+	assert((xm >> (SP_FBITS + 1)) == 0);	/* no excess */
 	assert(xe >= SP_EMIN);
 
 	if (xe > SP_EMAX) {
@@ -196,7 +196,7 @@ union ieee754sp ieee754sp_format(int sn, int xe, unsigned xm)
 			ieee754_setcx(IEEE754_UNDERFLOW);
 		return buildsp(sn, SP_EMIN - 1 + SP_EBIAS, xm);
 	} else {
-		assert((xm >> (SP_FBITS + 1)) == 0);	/* no execess */
+		assert((xm >> (SP_FBITS + 1)) == 0);	/* no excess */
 		assert(xm & SP_HIDDEN_BIT);
 
 		return buildsp(sn, xe + SP_EBIAS, xm & ~SP_HIDDEN_BIT);
diff --git a/arch/mips/mm/sc-ip22.c b/arch/mips/mm/sc-ip22.c
index dc7c5a5..026cb59 100644
--- a/arch/mips/mm/sc-ip22.c
+++ b/arch/mips/mm/sc-ip22.c
@@ -158,7 +158,7 @@ static inline int __init indy_sc_probe(void)
 	return 1;
 }
 
-/* XXX Check with wje if the Indy caches can differenciate between
+/* XXX Check with wje if the Indy caches can differentiate between
    writeback + invalidate and just invalidate.	*/
 static struct bcache_ops indy_sc_ops = {
 	.bc_enable = indy_sc_enable,
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 5a04b6f..84c6e3f 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -12,7 +12,7 @@
  * Copyright (C) 2011  MIPS Technologies, Inc.
  *
  * ... and the days got worse and worse and now you see
- * I've gone completly out of my mind.
+ * I've gone completely out of my mind.
  *
  * They're coming to take me a away haha
  * they're coming to take me a away hoho hihi haha
diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index 8d0eb26..f1f8829 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -7,7 +7,7 @@
  * Copyright (C) 2000 by Silicon Graphics, Inc.
  * Copyright (C) 2004 by Christoph Hellwig
  *
- * On SGI IP27 the ARC memory configuration data is completly bogus but
+ * On SGI IP27 the ARC memory configuration data is completely bogus but
  * alternate easier to use mechanisms are available.
  */
 #include <linux/init.h>
-- 
2.7.0.rc3.207.g0ac5344
