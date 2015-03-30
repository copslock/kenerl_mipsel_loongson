Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Mar 2015 18:01:50 +0200 (CEST)
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:41422 "EHLO
        ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014767AbbC3QBP6TrVf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Mar 2015 18:01:15 +0200
Received: from localhost (localhost [127.0.0.1])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id B235B460BC2
        for <linux-mips@linux-mips.org>; Mon, 30 Mar 2015 17:01:11 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
        by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rRsKAWTAVZNx for <linux-mips@linux-mips.org>;
        Mon, 30 Mar 2015 17:01:10 +0100 (BST)
Received: from pm-laptop.codethink.co.uk (pm-laptop.dyn.ducie.codethink.co.uk [10.24.1.94])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 9DC87460BD6
        for <linux-mips@linux-mips.org>; Mon, 30 Mar 2015 17:01:03 +0100 (BST)
Received: from pm by pm-laptop.codethink.co.uk with local (Exim 4.84)
        (envelope-from <paul.martin@codethink.co.uk>)
        id 1Ycc7b-0007ng-5R
        for linux-mips@linux-mips.org; Mon, 30 Mar 2015 17:01:03 +0100
From:   Paul Martin <paul.martin@codethink.co.uk>
To:     linux-mips@linux-mips.org
Subject: [PATCH 01/10] MIPS: OCTEON: Handle bootloader structures in little-endian mode.
Date:   Mon, 30 Mar 2015 17:00:54 +0100
Message-Id: <1427731263-29950-2-git-send-email-paul.martin@codethink.co.uk>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1427731263-29950-1-git-send-email-paul.martin@codethink.co.uk>
References: <1427731263-29950-1-git-send-email-paul.martin@codethink.co.uk>
Return-Path: <paul.martin@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.martin@codethink.co.uk
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

From: David Daney <david.daney@cavium.com>

Compensate for the differences in the layout of in-memory bootloader
information as seen from little-endian mode.

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
Signed-off-by: Paul Martin <paul.martin@codethink.co.uk>
---
 arch/mips/cavium-octeon/octeon_boot.h        | 23 ++++++++++++
 arch/mips/include/asm/octeon/cvmx-bootinfo.h | 55 ++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/arch/mips/cavium-octeon/octeon_boot.h b/arch/mips/cavium-octeon/octeon_boot.h
index 7b066bb..a6ce7c4 100644
--- a/arch/mips/cavium-octeon/octeon_boot.h
+++ b/arch/mips/cavium-octeon/octeon_boot.h
@@ -37,11 +37,13 @@ struct boot_init_vector {
 
 /* similar to bootloader's linux_app_boot_info but without global data */
 struct linux_app_boot_info {
+#ifdef __BIG_ENDIAN_BITFIELD
 	uint32_t labi_signature;
 	uint32_t start_core0_addr;
 	uint32_t avail_coremask;
 	uint32_t pci_console_active;
 	uint32_t icache_prefetch_disable;
+	uint32_t padding;
 	uint64_t InitTLBStart_addr;
 	uint32_t start_app_addr;
 	uint32_t cur_exception_base;
@@ -49,6 +51,27 @@ struct linux_app_boot_info {
 	uint32_t compact_flash_common_base_addr;
 	uint32_t compact_flash_attribute_base_addr;
 	uint32_t led_display_base_addr;
+#else
+	uint32_t start_core0_addr;
+	uint32_t labi_signature;
+
+	uint32_t pci_console_active;
+	uint32_t avail_coremask;
+
+	uint32_t padding;
+	uint32_t icache_prefetch_disable;
+
+	uint64_t InitTLBStart_addr;
+
+	uint32_t cur_exception_base;
+	uint32_t start_app_addr;
+
+	uint32_t compact_flash_common_base_addr;
+	uint32_t no_mark_private_data;
+
+	uint32_t led_display_base_addr;
+	uint32_t compact_flash_attribute_base_addr;
+#endif
 };
 
 /* If not to copy a lot of bootloader's structures
diff --git a/arch/mips/include/asm/octeon/cvmx-bootinfo.h b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
index 2298199..c373d95 100644
--- a/arch/mips/include/asm/octeon/cvmx-bootinfo.h
+++ b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
@@ -53,6 +53,7 @@
  * to 0.
  */
 struct cvmx_bootinfo {
+#ifdef __BIG_ENDIAN_BITFIELD
 	uint32_t major_version;
 	uint32_t minor_version;
 
@@ -123,6 +124,60 @@ struct cvmx_bootinfo {
 	 */
 	uint64_t fdt_addr;
 #endif
+#else				/* __BIG_ENDIAN */
+	/*
+	 * Little-Endian: When the CPU mode is switched to
+	 * little-endian, the view of the structure has some of the
+	 * fields swapped.
+	 */
+	uint32_t minor_version;
+	uint32_t major_version;
+
+	uint64_t stack_top;
+	uint64_t heap_base;
+	uint64_t heap_end;
+	uint64_t desc_vaddr;
+
+	uint32_t stack_size;
+	uint32_t exception_base_addr;
+
+	uint32_t core_mask;
+	uint32_t flags;
+
+	uint32_t phy_mem_desc_addr;
+	uint32_t dram_size;
+
+	uint32_t eclock_hz;
+	uint32_t debugger_flags_base_addr;
+
+	uint32_t reserved0;
+	uint32_t dclock_hz;
+
+	uint8_t reserved3;
+	uint8_t reserved2;
+	uint16_t reserved1;
+	uint8_t board_rev_minor;
+	uint8_t board_rev_major;
+	uint16_t board_type;
+
+	char board_serial_number[CVMX_BOOTINFO_OCTEON_SERIAL_LEN];
+	uint8_t mac_addr_base[6];
+	uint8_t mac_addr_count;
+	uint8_t pad[5];
+
+#if (CVMX_BOOTINFO_MIN_VER >= 1)
+	uint64_t compact_flash_common_base_addr;
+	uint64_t compact_flash_attribute_base_addr;
+	uint64_t led_display_base_addr;
+#endif
+#if (CVMX_BOOTINFO_MIN_VER >= 2)
+	uint32_t config_flags;
+	uint32_t dfa_ref_clock_hz;
+#endif
+#if (CVMX_BOOTINFO_MIN_VER >= 3)
+	uint64_t fdt_addr;
+#endif
+#endif
 };
 
 #define CVMX_BOOTINFO_CFG_FLAG_PCI_HOST			(1ull << 0)
-- 
2.1.4
