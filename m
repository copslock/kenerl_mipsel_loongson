Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jul 2011 19:00:15 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:50918 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491782Ab1GPQ4d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Jul 2011 18:56:33 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 00FF88C62;
        Sat, 16 Jul 2011 18:56:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id L8OHJnVbkOl8; Sat, 16 Jul 2011 18:56:26 +0200 (CEST)
Received: from localhost.localdomain (host-091-097-255-051.ewe-ip-backbone.de [91.97.255.51])
        by hauke-m.de (Postfix) with ESMTPSA id 5E8F68C6B;
        Sat, 16 Jul 2011 18:56:08 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, linux-wireless@vger.kernel.org,
        zajec5@gmail.com, linux-mips@linux-mips.org
Cc:     jonas.gorski@gmail.com, mb@bu3sch.de, george@znau.edu.ua,
        arend@broadcom.com, b43-dev@lists.infradead.org,
        bernhardloos@googlemail.com, arnd@arndb.de,
        julian.calaby@gmail.com, sshtylyov@mvista.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 09/11] bcm47xx: make it possible to build bcm47xx without ssb.
Date:   Sat, 16 Jul 2011 18:55:40 +0200
Message-Id: <1310835342-18877-10-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1310835342-18877-1-git-send-email-hauke@hauke-m.de>
References: <1310835342-18877-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 30640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11711


Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/Kconfig                            |    8 +-------
 arch/mips/bcm47xx/Kconfig                    |   18 ++++++++++++++++++
 arch/mips/bcm47xx/Makefile                   |    3 ++-
 arch/mips/bcm47xx/gpio.c                     |    6 ++++++
 arch/mips/bcm47xx/nvram.c                    |    4 ++++
 arch/mips/bcm47xx/serial.c                   |    4 ++++
 arch/mips/bcm47xx/setup.c                    |    8 ++++++++
 arch/mips/bcm47xx/time.c                     |    2 ++
 arch/mips/include/asm/mach-bcm47xx/bcm47xx.h |    4 ++++
 arch/mips/include/asm/mach-bcm47xx/gpio.h    |   12 ++++++++++++
 arch/mips/pci/pci-bcm47xx.c                  |    6 ++++++
 drivers/watchdog/bcm47xx_wdt.c               |    4 ++++
 12 files changed, 71 insertions(+), 8 deletions(-)
 create mode 100644 arch/mips/bcm47xx/Kconfig

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 653da62..ac6f237 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -91,15 +91,8 @@ config BCM47XX
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select IRQ_CPU
-	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SSB
-	select SSB_DRIVER_MIPS
-	select SSB_DRIVER_EXTIF
-	select SSB_EMBEDDED
-	select SSB_B43_PCI_BRIDGE if PCI
-	select SSB_PCICORE_HOSTMODE if PCI
 	select GENERIC_GPIO
 	select SYS_HAS_EARLY_PRINTK
 	select CFE
@@ -785,6 +778,7 @@ endchoice
 
 source "arch/mips/alchemy/Kconfig"
 source "arch/mips/ath79/Kconfig"
+source "arch/mips/bcm47xx/Kconfig"
 source "arch/mips/bcm63xx/Kconfig"
 source "arch/mips/jazz/Kconfig"
 source "arch/mips/jz4740/Kconfig"
diff --git a/arch/mips/bcm47xx/Kconfig b/arch/mips/bcm47xx/Kconfig
new file mode 100644
index 0000000..0346f92
--- /dev/null
+++ b/arch/mips/bcm47xx/Kconfig
@@ -0,0 +1,18 @@
+if BCM47XX
+
+config BCM47XX_SSB
+	bool "SSB Support for Broadcom BCM47XX"
+	select SYS_HAS_CPU_MIPS32_R1
+	select SSB
+	select SSB_DRIVER_MIPS
+	select SSB_DRIVER_EXTIF
+	select SSB_EMBEDDED
+	select SSB_B43_PCI_BRIDGE if PCI
+	select SSB_PCICORE_HOSTMODE if PCI
+	default y
+	help
+	 Add support for old Broadcom BCM47xx boards with Sonics Silicon Backplane support.
+
+	 This will generate an image with support for SSB and MIPS32 R1 instruction set.
+
+endif
diff --git a/arch/mips/bcm47xx/Makefile b/arch/mips/bcm47xx/Makefile
index 7465e8a..4add173 100644
--- a/arch/mips/bcm47xx/Makefile
+++ b/arch/mips/bcm47xx/Makefile
@@ -3,4 +3,5 @@
 # under Linux.
 #
 
-obj-y := gpio.o irq.o nvram.o prom.o serial.o setup.o time.o wgt634u.o
+obj-y 				+= gpio.o irq.o nvram.o prom.o serial.o setup.o time.o
+obj-$(CONFIG_BCM47XX_SSB)	+= wgt634u.o
diff --git a/arch/mips/bcm47xx/gpio.c b/arch/mips/bcm47xx/gpio.c
index 2f6d2df..3320e91 100644
--- a/arch/mips/bcm47xx/gpio.c
+++ b/arch/mips/bcm47xx/gpio.c
@@ -21,6 +21,7 @@ static DECLARE_BITMAP(gpio_in_use, BCM47XX_EXTIF_GPIO_LINES);
 int gpio_request(unsigned gpio, const char *tag)
 {
 	switch (bcm47xx_active_bus_type) {
+#ifdef CONFIG_BCM47XX_SSB
 	case BCM47XX_BUS_TYPE_SSB:
 		if (ssb_chipco_available(&bcm47xx_bus.ssb.chipco) &&
 		    ((unsigned)gpio >= BCM47XX_CHIPCO_GPIO_LINES))
@@ -34,6 +35,7 @@ int gpio_request(unsigned gpio, const char *tag)
 			return -EBUSY;
 
 		return 0;
+#endif
 	}
 	return -EINVAL;
 }
@@ -42,6 +44,7 @@ EXPORT_SYMBOL(gpio_request);
 void gpio_free(unsigned gpio)
 {
 	switch (bcm47xx_active_bus_type) {
+#ifdef CONFIG_BCM47XX_SSB
 	case BCM47XX_BUS_TYPE_SSB:
 		if (ssb_chipco_available(&bcm47xx_bus.ssb.chipco) &&
 		    ((unsigned)gpio >= BCM47XX_CHIPCO_GPIO_LINES))
@@ -53,6 +56,7 @@ void gpio_free(unsigned gpio)
 
 		clear_bit(gpio, gpio_in_use);
 		return;
+#endif
 	}
 }
 EXPORT_SYMBOL(gpio_free);
@@ -60,6 +64,7 @@ EXPORT_SYMBOL(gpio_free);
 int gpio_to_irq(unsigned gpio)
 {
 	switch (bcm47xx_active_bus_type) {
+#ifdef CONFIG_BCM47XX_SSB
 	case BCM47XX_BUS_TYPE_SSB:
 		if (ssb_chipco_available(&bcm47xx_bus.ssb.chipco))
 			return ssb_mips_irq(bcm47xx_bus.ssb.chipco.dev) + 2;
@@ -67,6 +72,7 @@ int gpio_to_irq(unsigned gpio)
 			return ssb_mips_irq(bcm47xx_bus.ssb.extif.dev) + 2;
 		else
 			return -EINVAL;
+#endif
 	}
 	return -EINVAL;
 }
diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index d2304d0..d223dac 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -26,7 +26,9 @@ static char nvram_buf[NVRAM_SPACE];
 /* Probe for NVRAM header */
 static void early_nvram_init(void)
 {
+#ifdef CONFIG_BCM47XX_SSB
 	struct ssb_mipscore *mcore_ssb;
+#endif
 	struct nvram_header *header;
 	int i;
 	u32 base = 0;
@@ -35,11 +37,13 @@ static void early_nvram_init(void)
 	u32 *src, *dst;
 
 	switch (bcm47xx_active_bus_type) {
+#ifdef CONFIG_BCM47XX_SSB
 	case BCM47XX_BUS_TYPE_SSB:
 		mcore_ssb = &bcm47xx_bus.ssb.mipscore;
 		base = mcore_ssb->flash_window;
 		lim = mcore_ssb->flash_window_size;
 		break;
+#endif
 	}
 
 	off = FLASH_MIN;
diff --git a/arch/mips/bcm47xx/serial.c b/arch/mips/bcm47xx/serial.c
index 87c2c5e..e9258cb 100644
--- a/arch/mips/bcm47xx/serial.c
+++ b/arch/mips/bcm47xx/serial.c
@@ -23,6 +23,7 @@ static struct platform_device uart8250_device = {
 	},
 };
 
+#ifdef CONFIG_BCM47XX_SSB
 static int __init uart8250_init_ssb(void)
 {
 	int i;
@@ -44,12 +45,15 @@ static int __init uart8250_init_ssb(void)
 	}
 	return platform_device_register(&uart8250_device);
 }
+#endif
 
 static int __init uart8250_init(void)
 {
 	switch (bcm47xx_active_bus_type) {
+#ifdef CONFIG_BCM47XX_SSB
 	case BCM47XX_BUS_TYPE_SSB:
 		return uart8250_init_ssb();
+#endif
 	}
 	return -EINVAL;
 }
diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index bff4181..9fc92bd 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -47,9 +47,11 @@ static void bcm47xx_machine_restart(char *command)
 	local_irq_disable();
 	/* Set the watchdog timer to reset immediately */
 	switch (bcm47xx_active_bus_type) {
+#ifdef CONFIG_BCM47XX_SSB
 	case BCM47XX_BUS_TYPE_SSB:
 		ssb_watchdog_timer_set(&bcm47xx_bus.ssb, 1);
 		break;
+#endif
 	}
 	while (1)
 		cpu_relax();
@@ -60,14 +62,17 @@ static void bcm47xx_machine_halt(void)
 	/* Disable interrupts and watchdog and spin forever */
 	local_irq_disable();
 	switch (bcm47xx_active_bus_type) {
+#ifdef CONFIG_BCM47XX_SSB
 	case BCM47XX_BUS_TYPE_SSB:
 		ssb_watchdog_timer_set(&bcm47xx_bus.ssb, 0);
 		break;
+#endif
 	}
 	while (1)
 		cpu_relax();
 }
 
+#ifdef CONFIG_BCM47XX_SSB
 #define READ_FROM_NVRAM(_outvar, name, buf) \
 	if (nvram_getprefix(prefix, name, buf, sizeof(buf)) >= 0)\
 		sprom->_outvar = simple_strtoul(buf, NULL, 0);
@@ -288,13 +293,16 @@ static void __init bcm47xx_register_ssb(void)
 		}
 	}
 }
+#endif
 
 void __init plat_mem_setup(void)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
 
+#ifdef CONFIG_BCM47XX_SSB
 	bcm47xx_active_bus_type = BCM47XX_BUS_TYPE_SSB;
 	bcm47xx_register_ssb();
+#endif
 
 	_machine_restart = bcm47xx_machine_restart;
 	_machine_halt = bcm47xx_machine_halt;
diff --git a/arch/mips/bcm47xx/time.c b/arch/mips/bcm47xx/time.c
index a7be993..02a652a 100644
--- a/arch/mips/bcm47xx/time.c
+++ b/arch/mips/bcm47xx/time.c
@@ -40,9 +40,11 @@ void __init plat_time_init(void)
 	write_c0_compare(0xffff);
 
 	switch (bcm47xx_active_bus_type) {
+#ifdef CONFIG_BCM47XX_SSB
 	case BCM47XX_BUS_TYPE_SSB:
 		hz = ssb_cpu_clock(&bcm47xx_bus.ssb.mipscore) / 2;
 		break;
+#endif
 	}
 
 	if (!hz)
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
index 4be8b95..764afea 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx.h
@@ -22,11 +22,15 @@
 #include <linux/ssb/ssb.h>
 
 enum bcm47xx_bus_type {
+#ifdef CONFIG_BCM47XX_SSB
 	BCM47XX_BUS_TYPE_SSB,
+#endif
 };
 
 union bcm47xx_bus {
+#ifdef CONFIG_BCM47XX_SSB
 	struct ssb_bus ssb;
+#endif
 };
 
 extern union bcm47xx_bus bcm47xx_bus;
diff --git a/arch/mips/include/asm/mach-bcm47xx/gpio.h b/arch/mips/include/asm/mach-bcm47xx/gpio.h
index 976b8aa..0c3bd1f 100644
--- a/arch/mips/include/asm/mach-bcm47xx/gpio.h
+++ b/arch/mips/include/asm/mach-bcm47xx/gpio.h
@@ -22,8 +22,10 @@ extern int gpio_to_irq(unsigned gpio);
 static inline int gpio_get_value(unsigned gpio)
 {
 	switch (bcm47xx_active_bus_type) {
+#ifdef CONFIG_BCM47XX_SSB
 	case BCM47XX_BUS_TYPE_SSB:
 		return ssb_gpio_in(&bcm47xx_bus.ssb, 1 << gpio);
+#endif
 	}
 	return -EINVAL;
 }
@@ -31,18 +33,22 @@ static inline int gpio_get_value(unsigned gpio)
 static inline void gpio_set_value(unsigned gpio, int value)
 {
 	switch (bcm47xx_active_bus_type) {
+#ifdef CONFIG_BCM47XX_SSB
 	case BCM47XX_BUS_TYPE_SSB:
 		ssb_gpio_out(&bcm47xx_bus.ssb, 1 << gpio,
 			     value ? 1 << gpio : 0);
+#endif
 	}
 }
 
 static inline int gpio_direction_input(unsigned gpio)
 {
 	switch (bcm47xx_active_bus_type) {
+#ifdef CONFIG_BCM47XX_SSB
 	case BCM47XX_BUS_TYPE_SSB:
 		ssb_gpio_outen(&bcm47xx_bus.ssb, 1 << gpio, 0);
 		return 0;
+#endif
 	}
 	return -EINVAL;
 }
@@ -50,6 +56,7 @@ static inline int gpio_direction_input(unsigned gpio)
 static inline int gpio_direction_output(unsigned gpio, int value)
 {
 	switch (bcm47xx_active_bus_type) {
+#ifdef CONFIG_BCM47XX_SSB
 	case BCM47XX_BUS_TYPE_SSB:
 		/* first set the gpio out value */
 		ssb_gpio_out(&bcm47xx_bus.ssb, 1 << gpio,
@@ -57,6 +64,7 @@ static inline int gpio_direction_output(unsigned gpio, int value)
 		/* then set the gpio mode */
 		ssb_gpio_outen(&bcm47xx_bus.ssb, 1 << gpio, 1 << gpio);
 		return 0;
+#endif
 	}
 	return -EINVAL;
 }
@@ -64,10 +72,12 @@ static inline int gpio_direction_output(unsigned gpio, int value)
 static inline int gpio_intmask(unsigned gpio, int value)
 {
 	switch (bcm47xx_active_bus_type) {
+#ifdef CONFIG_BCM47XX_SSB
 	case BCM47XX_BUS_TYPE_SSB:
 		ssb_gpio_intmask(&bcm47xx_bus.ssb, 1 << gpio,
 				 value ? 1 << gpio : 0);
 		return 0;
+#endif
 	}
 	return -EINVAL;
 }
@@ -75,10 +85,12 @@ static inline int gpio_intmask(unsigned gpio, int value)
 static inline int gpio_polarity(unsigned gpio, int value)
 {
 	switch (bcm47xx_active_bus_type) {
+#ifdef CONFIG_BCM47XX_SSB
 	case BCM47XX_BUS_TYPE_SSB:
 		ssb_gpio_polarity(&bcm47xx_bus.ssb, 1 << gpio,
 				  value ? 1 << gpio : 0);
 		return 0;
+#endif
 	}
 	return -EINVAL;
 }
diff --git a/arch/mips/pci/pci-bcm47xx.c b/arch/mips/pci/pci-bcm47xx.c
index 455f8e5..924e158 100644
--- a/arch/mips/pci/pci-bcm47xx.c
+++ b/arch/mips/pci/pci-bcm47xx.c
@@ -25,6 +25,7 @@
 #include <linux/types.h>
 #include <linux/pci.h>
 #include <linux/ssb/ssb.h>
+#include <bcm47xx.h>
 
 int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
@@ -33,9 +34,13 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 int pcibios_plat_dev_init(struct pci_dev *dev)
 {
+#ifdef CONFIG_BCM47XX_SSB
 	int res;
 	u8 slot, pin;
 
+	if (bcm47xx_active_bus_type !=  BCM47XX_BUS_TYPE_SSB)
+		return 0;
+
 	res = ssb_pcibios_plat_dev_init(dev);
 	if (res < 0) {
 		printk(KERN_ALERT "PCI: Failed to init device %s\n",
@@ -55,5 +60,6 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 	}
 
 	dev->irq = res;
+#endif
 	return 0;
 }
diff --git a/drivers/watchdog/bcm47xx_wdt.c b/drivers/watchdog/bcm47xx_wdt.c
index 7e4e063..beacd79 100644
--- a/drivers/watchdog/bcm47xx_wdt.c
+++ b/drivers/watchdog/bcm47xx_wdt.c
@@ -55,17 +55,21 @@ static inline void bcm47xx_wdt_hw_start(void)
 {
 	/* this is 2,5s on 100Mhz clock  and 2s on 133 Mhz */
 	switch (bcm47xx_active_bus_type) {
+#ifdef CONFIG_BCM47XX_SSB
 	case BCM47XX_BUS_TYPE_SSB:
 		ssb_watchdog_timer_set(&bcm47xx_bus.ssb, 0xfffffff);
 		break;
+#endif
 	}
 }
 
 static inline int bcm47xx_wdt_hw_stop(void)
 {
 	switch (bcm47xx_active_bus_type) {
+#ifdef CONFIG_BCM47XX_SSB
 	case BCM47XX_BUS_TYPE_SSB:
 		return ssb_watchdog_timer_set(&bcm47xx_bus.ssb, 0);
+#endif
 	}
 	return -EINVAL;
 }
-- 
1.7.4.1
