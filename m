Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 01:05:45 +0200 (CEST)
Received: from mail-lb0-f169.google.com ([209.85.217.169]:59969 "EHLO
        mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012107AbaJUXDsrEheP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 01:03:48 +0200
Received: by mail-lb0-f169.google.com with SMTP id 10so1887709lbg.14
        for <multiple recipients>; Tue, 21 Oct 2014 16:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p2X2K36U8NKNCsfepblFvx2xHOZ1pnVQ87ZF2/288QU=;
        b=JbSPCG0I7rOdqlzz2SNpjCEw0D+Trz9LEUPHjbtYkU6220FpDfKDwtT5vffBxFhZE6
         hFSgfrjTy0j98CUboOy6jOLFAqhgcki+WetuIKd8XlNeIIWbFGtN9V4NNWx5f3ZOM6xd
         Wi77bz21RfBwgHN7g+OTE8fk6nZZRl8cvdvasChgg6mIo+C1qGIXVMbieSSoSQ2+SdMm
         eQrxvjiIj8cYPLDr03GqYoruVTlHBaCbM2lkLcQa+aeB2vqZ6BQssjGXul62hSqL8VwV
         9iCfIQiVSZxsegI2Cj30A7sl9SEXbCyKGE2aMpNyQBt8UCVTIJ0KIZOi2VBmXZQq+7z+
         1zHw==
X-Received: by 10.152.88.1 with SMTP id bc1mr6398172lab.96.1413932623254;
        Tue, 21 Oct 2014 16:03:43 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id lk5sm5077133lac.45.2014.10.21.16.03.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 16:03:42 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [PATCH v2 07/13] MIPS: ath25: add board configuration detection
Date:   Wed, 22 Oct 2014 03:03:45 +0400
Message-Id: <1413932631-12866-8-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1413932631-12866-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1413932631-12866-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

All boards based on AR5312/AR2315 SoC have a special structure located
at the end of flash. This structure contains board-specific data such as
Ethernet and Wireless MAC addresses. The flash is mapped to the memmory
at predefined location.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---

Changes since v1:
  - rename MIPS machine ar231x -> ath25

 arch/mips/ath25/ar2315.c                          |  14 ++
 arch/mips/ath25/ar2315.h                          |   2 +
 arch/mips/ath25/ar5312.c                          |  38 ++++++
 arch/mips/ath25/ar5312.h                          |   2 +
 arch/mips/ath25/board.c                           | 153 ++++++++++++++++++++++
 arch/mips/ath25/devices.c                         |  17 +++
 arch/mips/ath25/devices.h                         |   2 +
 arch/mips/include/asm/mach-ath25/ath25_platform.h |  73 +++++++++++
 8 files changed, 301 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-ath25/ath25_platform.h

diff --git a/arch/mips/ath25/ar2315.c b/arch/mips/ath25/ar2315.c
index 897f538..d3ff812 100644
--- a/arch/mips/ath25/ar2315.c
+++ b/arch/mips/ath25/ar2315.c
@@ -135,6 +135,20 @@ void __init ar2315_arch_init_irq(void)
 	irq_set_chained_handler(AR2315_IRQ_MISC, ar2315_misc_irq_handler);
 }
 
+/*
+ * NB: We use mapping size that is larger than the actual flash size,
+ * but this shouldn't be a problem here, because the flash will simply
+ * be mapped multiple times.
+ */
+static const u8 * const __initconst
+ar2315_flash_limit = (u8 *)KSEG1ADDR(AR2315_SPI_READ + 0x1000000);
+
+void __init ar2315_init_devices(void)
+{
+	/* Find board configuration */
+	ath25_find_config(ar2315_flash_limit);
+}
+
 static void ar2315_restart(char *command)
 {
 	void (*mips_reset_vec)(void) = (void *)0xbfc00000;
diff --git a/arch/mips/ath25/ar2315.h b/arch/mips/ath25/ar2315.h
index 9af22db..308379a 100644
--- a/arch/mips/ath25/ar2315.h
+++ b/arch/mips/ath25/ar2315.h
@@ -4,6 +4,7 @@
 #ifdef CONFIG_SOC_AR2315
 
 void ar2315_arch_init_irq(void);
+void ar2315_init_devices(void);
 void ar2315_plat_time_init(void);
 void ar2315_plat_mem_setup(void);
 void ar2315_prom_init(void);
@@ -12,6 +13,7 @@ void ar2315_arch_init(void);
 #else
 
 static inline void ar2315_arch_init_irq(void) {}
+static inline void ar2315_init_devices(void) {}
 static inline void ar2315_plat_time_init(void) {}
 static inline void ar2315_plat_mem_setup(void) {}
 static inline void ar2315_prom_init(void) {}
diff --git a/arch/mips/ath25/ar5312.c b/arch/mips/ath25/ar5312.c
index ad36aab..2d66665 100644
--- a/arch/mips/ath25/ar5312.c
+++ b/arch/mips/ath25/ar5312.c
@@ -130,6 +130,44 @@ void __init ar5312_arch_init_irq(void)
 	irq_set_chained_handler(AR5312_IRQ_MISC, ar5312_misc_irq_handler);
 }
 
+static void __init ar5312_flash_init(void)
+{
+	u32 ctl;
+
+	/*
+	 * Configure flash bank 0.
+	 * Assume 8M window size. Flash will be aliased if it's smaller
+	 */
+	ctl = ath25_read_reg(AR5312_FLASHCTL0) & AR5312_FLASHCTL_MW;
+	ctl |= AR5312_FLASHCTL_E | AR5312_FLASHCTL_AC_8M | AR5312_FLASHCTL_RBLE;
+	ctl |= 0x01 << AR5312_FLASHCTL_IDCY_S;
+	ctl |= 0x07 << AR5312_FLASHCTL_WST1_S;
+	ctl |= 0x07 << AR5312_FLASHCTL_WST2_S;
+	ath25_write_reg(AR5312_FLASHCTL0, ctl);
+
+	/* Disable other flash banks */
+	ath25_mask_reg(AR5312_FLASHCTL1, AR5312_FLASHCTL_E |
+					  AR5312_FLASHCTL_AC, 0);
+	ath25_mask_reg(AR5312_FLASHCTL2, AR5312_FLASHCTL_E |
+					  AR5312_FLASHCTL_AC, 0);
+}
+
+/*
+ * NB: This mapping size is larger than the actual flash size,
+ * but this shouldn't be a problem here, because the flash
+ * will simply be mapped multiple times.
+ */
+static const u8 * const __initconst
+ar5312_flash_limit = (u8 *)KSEG1ADDR(AR5312_FLASH + 0x800000);
+
+void __init ar5312_init_devices(void)
+{
+	ar5312_flash_init();
+
+	/* Locate board/radio config data */
+	ath25_find_config(ar5312_flash_limit);
+}
+
 static void ar5312_restart(char *command)
 {
 	/* reset the system */
diff --git a/arch/mips/ath25/ar5312.h b/arch/mips/ath25/ar5312.h
index d04a33d..211992f 100644
--- a/arch/mips/ath25/ar5312.h
+++ b/arch/mips/ath25/ar5312.h
@@ -4,6 +4,7 @@
 #ifdef CONFIG_SOC_AR5312
 
 void ar5312_arch_init_irq(void);
+void ar5312_init_devices(void);
 void ar5312_plat_time_init(void);
 void ar5312_plat_mem_setup(void);
 void ar5312_prom_init(void);
@@ -12,6 +13,7 @@ void ar5312_arch_init(void);
 #else
 
 static inline void ar5312_arch_init_irq(void) {}
+static inline void ar5312_init_devices(void) {}
 static inline void ar5312_plat_time_init(void) {}
 static inline void ar5312_plat_mem_setup(void) {}
 static inline void ar5312_prom_init(void) {}
diff --git a/arch/mips/ath25/board.c b/arch/mips/ath25/board.c
index 68447d3..7db5a8e 100644
--- a/arch/mips/ath25/board.c
+++ b/arch/mips/ath25/board.c
@@ -16,12 +16,165 @@
 #include <asm/bootinfo.h>
 #include <asm/time.h>
 
+#include <ath25_platform.h>
 #include "devices.h"
 #include "ar5312.h"
 #include "ar2315.h"
 
 void (*ath25_irq_dispatch)(void);
 
+static inline bool check_radio_magic(const u8 *addr)
+{
+	addr += 0x7a; /* offset for flash magic */
+	return (addr[0] == 0x5a) && (addr[1] == 0xa5);
+}
+
+static inline bool check_notempty(const u8 *addr)
+{
+	return *(u32 *)addr != 0xffffffff;
+}
+
+static inline bool check_board_data(const u8 *flash_limit, const u8 *addr,
+				    bool broken)
+{
+	/* config magic found */
+	if (*((u32 *)addr) == ATH25_BD_MAGIC)
+		return true;
+
+	if (!broken)
+		return false;
+
+	if (check_radio_magic(addr + 0xf8))
+		ath25_board.radio = addr + 0xf8;
+	if ((addr < flash_limit + 0x10000) &&
+	    check_radio_magic(addr + 0x10000))
+		ath25_board.radio = addr + 0x10000;
+
+	if (ath25_board.radio) {
+		/* broken board data detected, use radio data to find the
+		 * offset, user will fix this */
+		return true;
+	}
+
+	return false;
+}
+
+static const u8 * __init find_board_config(const u8 *flash_limit, bool broken)
+{
+	const u8 *addr;
+	const u8 *begin = flash_limit - 0x1000;
+	const u8 *end = flash_limit - 0x30000;
+
+	for (addr = begin; addr >= end; addr -= 0x1000)
+		if (check_board_data(flash_limit, addr, broken))
+			return addr;
+
+	return NULL;
+}
+
+static const u8 * __init find_radio_config(const u8 *flash_limit,
+					   const u8 *bcfg)
+{
+	const u8 *rcfg, *begin, *end;
+
+	/*
+	 * Now find the start of Radio Configuration data, using heuristics:
+	 * Search forward from Board Configuration data by 0x1000 bytes
+	 * at a time until we find non-0xffffffff.
+	 */
+	begin = bcfg + 0x1000;
+	end = flash_limit;
+	for (rcfg = begin; rcfg < end; rcfg += 0x1000)
+		if (check_notempty(rcfg) && check_radio_magic(rcfg))
+			return rcfg;
+
+	/* AR2316 relocates radio config to new location */
+	begin = bcfg + 0xf8;
+	end = flash_limit - 0x1000 + 0xf8;
+	for (rcfg = begin; rcfg < end; rcfg += 0x1000)
+		if (check_notempty(rcfg) && check_radio_magic(rcfg))
+			return rcfg;
+
+	pr_warn("WARNING: Could not find Radio Configuration data\n");
+
+	return NULL;
+}
+
+int __init ath25_find_config(const u8 *flash_limit)
+{
+	struct ath25_boarddata *config;
+	unsigned int rcfg_size;
+	int broken_boarddata = 0;
+	const u8 *bcfg, *rcfg;
+	u8 *board_data;
+	u8 *radio_data;
+	u8 *mac_addr;
+	u32 offset;
+
+	ath25_board.config = NULL;
+	ath25_board.radio = NULL;
+	/* Copy the board and radio data to RAM, because accessing the mapped
+	 * memory of the flash directly after booting is not safe */
+
+	/* Try to find valid board and radio data */
+	bcfg = find_board_config(flash_limit, false);
+
+	/* If that fails, try to at least find valid radio data */
+	if (!bcfg) {
+		bcfg = find_board_config(flash_limit, true);
+		broken_boarddata = 1;
+	}
+
+	if (!bcfg) {
+		pr_warn("WARNING: No board configuration data found!\n");
+		return -ENODEV;
+	}
+
+	board_data = kzalloc(BOARD_CONFIG_BUFSZ, GFP_KERNEL);
+	ath25_board.config = (struct ath25_boarddata *)board_data;
+	memcpy(board_data, bcfg, 0x100);
+	if (broken_boarddata) {
+		pr_warn("WARNING: broken board data detected\n");
+		config = ath25_board.config;
+		if (is_zero_ether_addr(config->enet0_mac)) {
+			pr_info("Fixing up empty mac addresses\n");
+			config->reset_config_gpio = 0xffff;
+			config->sys_led_gpio = 0xffff;
+			random_ether_addr(config->wlan0_mac);
+			config->wlan0_mac[0] &= ~0x06;
+			random_ether_addr(config->enet0_mac);
+			random_ether_addr(config->enet1_mac);
+		}
+	}
+
+	/* Radio config starts 0x100 bytes after board config, regardless
+	 * of what the physical layout on the flash chip looks like */
+
+	if (ath25_board.radio)
+		rcfg = (u8 *)ath25_board.radio;
+	else
+		rcfg = find_radio_config(flash_limit, bcfg);
+
+	if (!rcfg)
+		return -ENODEV;
+
+	radio_data = board_data + 0x100 + ((rcfg - bcfg) & 0xfff);
+	ath25_board.radio = radio_data;
+	offset = radio_data - board_data;
+	pr_info("Radio config found at offset 0x%x (0x%x)\n", rcfg - bcfg,
+		offset);
+	rcfg_size = BOARD_CONFIG_BUFSZ - offset;
+	memcpy(radio_data, rcfg, rcfg_size);
+
+	mac_addr = &radio_data[0x1d * 2];
+	if (is_broadcast_ether_addr(mac_addr)) {
+		pr_info("Radio MAC is blank; using board-data\n");
+		ether_addr_copy(mac_addr, ath25_board.config->wlan0_mac);
+	}
+
+	return 0;
+}
+
 static void ath25_halt(void)
 {
 	local_irq_disable();
diff --git a/arch/mips/ath25/devices.c b/arch/mips/ath25/devices.c
index 0416cd2..d24dbb1 100644
--- a/arch/mips/ath25/devices.c
+++ b/arch/mips/ath25/devices.c
@@ -3,7 +3,12 @@
 #include <linux/serial_8250.h>
 #include <asm/bootinfo.h>
 
+#include <ath25_platform.h>
 #include "devices.h"
+#include "ar5312.h"
+#include "ar2315.h"
+
+struct ar231x_board_config ath25_board;
 
 const char *get_system_type(void)
 {
@@ -26,6 +31,18 @@ void __init ath25_serial_setup(u32 mapbase, int irq, unsigned int uartclk)
 	early_serial_setup(&s);
 }
 
+static int __init ath25_register_devices(void)
+{
+	if (is_ar5312())
+		ar5312_init_devices();
+	else
+		ar2315_init_devices();
+
+	return 0;
+}
+
+device_initcall(ath25_register_devices);
+
 static int __init ath25_arch_init(void)
 {
 	if (is_ar5312())
diff --git a/arch/mips/ath25/devices.h b/arch/mips/ath25/devices.h
index 54fafd3..10f196d 100644
--- a/arch/mips/ath25/devices.h
+++ b/arch/mips/ath25/devices.h
@@ -3,8 +3,10 @@
 
 #include <linux/cpu.h>
 
+extern struct ar231x_board_config ath25_board;
 extern void (*ath25_irq_dispatch)(void);
 
+int ath25_find_config(const u8 *flash_limit);
 void ath25_serial_setup(u32 mapbase, int irq, unsigned int uartclk);
 
 static inline bool is_ar2315(void)
diff --git a/arch/mips/include/asm/mach-ath25/ath25_platform.h b/arch/mips/include/asm/mach-ath25/ath25_platform.h
new file mode 100644
index 0000000..4f4ee4f
--- /dev/null
+++ b/arch/mips/include/asm/mach-ath25/ath25_platform.h
@@ -0,0 +1,73 @@
+#ifndef __ASM_MACH_ATH25_PLATFORM_H
+#define __ASM_MACH_ATH25_PLATFORM_H
+
+#include <linux/etherdevice.h>
+
+/*
+ * This is board-specific data that is stored in a "fixed" location in flash.
+ * It is shared across operating systems, so it should not be changed lightly.
+ * The main reason we need it is in order to extract the ethernet MAC
+ * address(es).
+ */
+struct ath25_boarddata {
+	u32 magic;                   /* board data is valid */
+#define ATH25_BD_MAGIC 0x35333131    /* "5311", for all 531x/231x platforms */
+	u16 cksum;                   /* checksum (starting with BD_REV 2) */
+	u16 rev;                     /* revision of this struct */
+#define BD_REV 4
+	char board_name[64];         /* Name of board */
+	u16 major;                   /* Board major number */
+	u16 minor;                   /* Board minor number */
+	u32 flags;                   /* Board configuration */
+#define BD_ENET0        0x00000001   /* ENET0 is stuffed */
+#define BD_ENET1        0x00000002   /* ENET1 is stuffed */
+#define BD_UART1        0x00000004   /* UART1 is stuffed */
+#define BD_UART0        0x00000008   /* UART0 is stuffed (dma) */
+#define BD_RSTFACTORY   0x00000010   /* Reset factory defaults stuffed */
+#define BD_SYSLED       0x00000020   /* System LED stuffed */
+#define BD_EXTUARTCLK   0x00000040   /* External UART clock */
+#define BD_CPUFREQ      0x00000080   /* cpu freq is valid in nvram */
+#define BD_SYSFREQ      0x00000100   /* sys freq is set in nvram */
+#define BD_WLAN0        0x00000200   /* Enable WLAN0 */
+#define BD_MEMCAP       0x00000400   /* CAP SDRAM @ mem_cap for testing */
+#define BD_DISWATCHDOG  0x00000800   /* disable system watchdog */
+#define BD_WLAN1        0x00001000   /* Enable WLAN1 (ar5212) */
+#define BD_ISCASPER     0x00002000   /* FLAG for AR2312 */
+#define BD_WLAN0_2G_EN  0x00004000   /* FLAG for radio0_2G */
+#define BD_WLAN0_5G_EN  0x00008000   /* FLAG for radio0_2G */
+#define BD_WLAN1_2G_EN  0x00020000   /* FLAG for radio0_2G */
+#define BD_WLAN1_5G_EN  0x00040000   /* FLAG for radio0_2G */
+	u16 reset_config_gpio;       /* Reset factory GPIO pin */
+	u16 sys_led_gpio;            /* System LED GPIO pin */
+
+	u32 cpu_freq;                /* CPU core frequency in Hz */
+	u32 sys_freq;                /* System frequency in Hz */
+	u32 cnt_freq;                /* Calculated C0_COUNT frequency */
+
+	u8  wlan0_mac[ETH_ALEN];
+	u8  enet0_mac[ETH_ALEN];
+	u8  enet1_mac[ETH_ALEN];
+
+	u16 pci_id;                  /* Pseudo PCIID for common code */
+	u16 mem_cap;                 /* cap bank1 in MB */
+
+	/* version 3 */
+	u8  wlan1_mac[ETH_ALEN];     /* (ar5212) */
+};
+
+#define BOARD_CONFIG_BUFSZ		0x1000
+
+/*
+ * Platform device information for the Wireless MAC
+ */
+struct ar231x_board_config {
+	u16 devid;
+
+	/* board config data */
+	struct ath25_boarddata *config;
+
+	/* radio calibration data */
+	const char *radio;
+};
+
+#endif /* __ASM_MACH_ATH25_PLATFORM_H */
-- 
1.8.5.5
