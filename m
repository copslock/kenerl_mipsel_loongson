Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2010 01:10:44 +0200 (CEST)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:18319 "EHLO
        smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491760Ab0JGXFJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Oct 2010 01:05:09 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by smtp2.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cae50df0001>; Thu, 07 Oct 2010 18:59:43 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 7 Oct 2010 16:04:22 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 7 Oct 2010 16:04:22 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o97N49gu026972;
        Thu, 7 Oct 2010 16:04:09 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o97N49vH026971;
        Thu, 7 Oct 2010 16:04:09 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 10/14] MIPS: Octeon: Add octeon_get_io_clock_rate() for cn63xx
Date:   Thu,  7 Oct 2010 16:03:49 -0700
Message-Id: <1286492633-26885-11-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
References: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 07 Oct 2010 23:04:22.0574 (UTC) FILETIME=[FAD534E0:01CB6673]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27986
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Starting with cn63xx Octeon I/O blocks are clocked at a different rate
than the CPU.  Add a new function octeon_get_io_clock_rate() that
yields the I/O clock rate.

Also rearrange octeon_get_clock_rate() to get the value from the saved
sysinfo structure.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/setup.c       |   76 +++++++++++++++++++++------------
 arch/mips/include/asm/octeon/octeon.h |    1 +
 2 files changed, 49 insertions(+), 28 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index fc151be..c072b24 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -33,6 +33,7 @@
 
 #include <asm/octeon/octeon.h>
 #include <asm/octeon/pci-octeon.h>
+#include <asm/octeon/cvmx-mio-defs.h>
 
 #ifdef CONFIG_CAVIUM_DECODE_RSL
 extern void cvmx_interrupt_rsl_decode(void);
@@ -96,10 +97,21 @@ int octeon_is_pci_host(void)
  */
 uint64_t octeon_get_clock_rate(void)
 {
-	return octeon_bootinfo->eclock_hz;
+	struct cvmx_sysinfo *sysinfo = cvmx_sysinfo_get();
+
+	return sysinfo->cpu_clock_hz;
 }
 EXPORT_SYMBOL(octeon_get_clock_rate);
 
+static u64 octeon_io_clock_rate;
+
+u64 octeon_get_io_clock_rate(void)
+{
+	return octeon_io_clock_rate;
+}
+EXPORT_SYMBOL(octeon_get_io_clock_rate);
+
+
 /**
  * Write to the LCD display connected to the bootbus. This display
  * exists on most Cavium evaluation boards. If it doesn't exist, then
@@ -414,6 +426,41 @@ void __init prom_init(void)
 		cvmx_phys_to_ptr(octeon_boot_desc_ptr->cvmx_desc_vaddr);
 	cvmx_bootmem_init(cvmx_phys_to_ptr(octeon_bootinfo->phy_mem_desc_addr));
 
+	sysinfo = cvmx_sysinfo_get();
+	memset(sysinfo, 0, sizeof(*sysinfo));
+	sysinfo->system_dram_size = octeon_bootinfo->dram_size << 20;
+	sysinfo->phy_mem_desc_ptr =
+		cvmx_phys_to_ptr(octeon_bootinfo->phy_mem_desc_addr);
+	sysinfo->core_mask = octeon_bootinfo->core_mask;
+	sysinfo->exception_base_addr = octeon_bootinfo->exception_base_addr;
+	sysinfo->cpu_clock_hz = octeon_bootinfo->eclock_hz;
+	sysinfo->dram_data_rate_hz = octeon_bootinfo->dclock_hz * 2;
+	sysinfo->board_type = octeon_bootinfo->board_type;
+	sysinfo->board_rev_major = octeon_bootinfo->board_rev_major;
+	sysinfo->board_rev_minor = octeon_bootinfo->board_rev_minor;
+	memcpy(sysinfo->mac_addr_base, octeon_bootinfo->mac_addr_base,
+	       sizeof(sysinfo->mac_addr_base));
+	sysinfo->mac_addr_count = octeon_bootinfo->mac_addr_count;
+	memcpy(sysinfo->board_serial_number,
+	       octeon_bootinfo->board_serial_number,
+	       sizeof(sysinfo->board_serial_number));
+	sysinfo->compact_flash_common_base_addr =
+		octeon_bootinfo->compact_flash_common_base_addr;
+	sysinfo->compact_flash_attribute_base_addr =
+		octeon_bootinfo->compact_flash_attribute_base_addr;
+	sysinfo->led_display_base_addr = octeon_bootinfo->led_display_base_addr;
+	sysinfo->dfa_ref_clock_hz = octeon_bootinfo->dfa_ref_clock_hz;
+	sysinfo->bootloader_config_flags = octeon_bootinfo->config_flags;
+
+	if (OCTEON_IS_MODEL(OCTEON_CN6XXX)) {
+		/* I/O clock runs at a different rate than the CPU. */
+		union cvmx_mio_rst_boot rst_boot;
+		rst_boot.u64 = cvmx_read_csr(CVMX_MIO_RST_BOOT);
+		octeon_io_clock_rate = 50000000 * rst_boot.s.pnr_mul;
+	} else {
+		octeon_io_clock_rate = sysinfo->cpu_clock_hz;
+	}
+
 	/*
 	 * Only enable the LED controller if we're running on a CN38XX, CN58XX,
 	 * or CN56XX. The CN30XX and CN31XX don't have an LED controller.
@@ -477,33 +524,6 @@ void __init prom_init(void)
 	}
 #endif
 
-	sysinfo = cvmx_sysinfo_get();
-	memset(sysinfo, 0, sizeof(*sysinfo));
-	sysinfo->system_dram_size = octeon_bootinfo->dram_size << 20;
-	sysinfo->phy_mem_desc_ptr =
-		cvmx_phys_to_ptr(octeon_bootinfo->phy_mem_desc_addr);
-	sysinfo->core_mask = octeon_bootinfo->core_mask;
-	sysinfo->exception_base_addr = octeon_bootinfo->exception_base_addr;
-	sysinfo->cpu_clock_hz = octeon_bootinfo->eclock_hz;
-	sysinfo->dram_data_rate_hz = octeon_bootinfo->dclock_hz * 2;
-	sysinfo->board_type = octeon_bootinfo->board_type;
-	sysinfo->board_rev_major = octeon_bootinfo->board_rev_major;
-	sysinfo->board_rev_minor = octeon_bootinfo->board_rev_minor;
-	memcpy(sysinfo->mac_addr_base, octeon_bootinfo->mac_addr_base,
-	       sizeof(sysinfo->mac_addr_base));
-	sysinfo->mac_addr_count = octeon_bootinfo->mac_addr_count;
-	memcpy(sysinfo->board_serial_number,
-	       octeon_bootinfo->board_serial_number,
-	       sizeof(sysinfo->board_serial_number));
-	sysinfo->compact_flash_common_base_addr =
-		octeon_bootinfo->compact_flash_common_base_addr;
-	sysinfo->compact_flash_attribute_base_addr =
-		octeon_bootinfo->compact_flash_attribute_base_addr;
-	sysinfo->led_display_base_addr = octeon_bootinfo->led_display_base_addr;
-	sysinfo->dfa_ref_clock_hz = octeon_bootinfo->dfa_ref_clock_hz;
-	sysinfo->bootloader_config_flags = octeon_bootinfo->config_flags;
-
-
 	octeon_check_cpu_bist();
 
 	octeon_uart = octeon_get_boot_uart();
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index 917a6c4..6b34afd0 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -35,6 +35,7 @@ extern int octeon_is_simulation(void);
 extern int octeon_is_pci_host(void);
 extern int octeon_usb_is_ref_clk(void);
 extern uint64_t octeon_get_clock_rate(void);
+extern u64 octeon_get_io_clock_rate(void);
 extern const char *octeon_board_type_string(void);
 extern const char *octeon_get_pci_interrupts(void);
 extern int octeon_get_southbridge_interrupt(void);
-- 
1.7.2.3
