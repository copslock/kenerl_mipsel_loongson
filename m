Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Mar 2015 17:15:52 +0100 (CET)
Received: from nivc-ms1.auriga.com ([80.240.102.146]:54535 "EHLO
        nivc-ms1.auriga.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014325AbbCTQPmv6PnE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Mar 2015 17:15:42 +0100
Received: from localhost (80.240.102.213) by NIVC-MS1.auriga.ru
 (80.240.102.146) with Microsoft SMTP Server (TLS) id 14.3.224.2; Fri, 20 Mar
 2015 19:15:38 +0300
From:   Aleksey Makarov <aleksey.makarov@auriga.com>
To:     <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 1/3] MIPS: OCTEON: Handle bootloader structures in little-endian mode.
Date:   Fri, 20 Mar 2015 19:11:56 +0300
Message-ID: <1426867920-7907-2-git-send-email-aleksey.makarov@auriga.com>
X-Mailer: git-send-email 2.3.3
In-Reply-To: <1426867920-7907-1-git-send-email-aleksey.makarov@auriga.com>
References: <1426867920-7907-1-git-send-email-aleksey.makarov@auriga.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [80.240.102.213]
Return-Path: <aleksey.makarov@auriga.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksey.makarov@auriga.com
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
2.3.3
