Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2012 19:44:07 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:38225 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903681Ab2ENRnb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2012 19:43:31 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [RESEND PATCH V2 04/17] MIPS: lantiq: drop ltq_gpio_request() and gpio_to_irq()
Date:   Mon, 14 May 2012 19:42:30 +0200
Message-Id: <1337017363-14424-4-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1337017363-14424-1-git-send-email-blogic@openwrt.org>
References: <1337017363-14424-1-git-send-email-blogic@openwrt.org>
X-archive-position: 33292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

As part of the conversion to OF we also implement pinctrl drivers. Previously
we used ltq_gpio_request() to set pinmuxing. This is now obselete and we can
hence drop the function.

Additionally we remove gpio_to_irq() from the gpio driver and move it to a
header file.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/mach-lantiq/gpio.h           |   16 +++++++
 .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |    2 -
 arch/mips/lantiq/xway/gpio.c                       |   12 -----
 arch/mips/lantiq/xway/gpio_stp.c                   |    5 --
 arch/mips/pci/pci-lantiq.c                         |   44 +-------------------
 5 files changed, 17 insertions(+), 62 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-lantiq/gpio.h

diff --git a/arch/mips/include/asm/mach-lantiq/gpio.h b/arch/mips/include/asm/mach-lantiq/gpio.h
new file mode 100644
index 0000000..f79505b
--- /dev/null
+++ b/arch/mips/include/asm/mach-lantiq/gpio.h
@@ -0,0 +1,16 @@
+#ifndef __ASM_MIPS_MACH_LANTIQ_GPIO_H
+#define __ASM_MIPS_MACH_LANTIQ_GPIO_H
+
+static inline int gpio_to_irq(unsigned int gpio)
+{
+	return -1;
+}
+
+#define gpio_get_value __gpio_get_value
+#define gpio_set_value __gpio_set_value
+
+#define gpio_cansleep __gpio_cansleep
+
+#include <asm-generic/gpio.h>
+
+#endif
diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
index 15eb4dc..150c7be 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
@@ -153,8 +153,6 @@
 #define LTQ_MPS_CHIPID		((u32 *)(LTQ_MPS_BASE_ADDR + 0x0344))
 
 /* request a non-gpio and set the PIO config */
-extern int  ltq_gpio_request(unsigned int pin, unsigned int alt0,
-	unsigned int alt1, unsigned int dir, const char *name);
 extern void ltq_pmu_enable(unsigned int module);
 extern void ltq_pmu_disable(unsigned int module);
 
diff --git a/arch/mips/lantiq/xway/gpio.c b/arch/mips/lantiq/xway/gpio.c
index d2fa98f..a8b2edc 100644
--- a/arch/mips/lantiq/xway/gpio.c
+++ b/arch/mips/lantiq/xway/gpio.c
@@ -36,18 +36,6 @@ struct ltq_gpio {
 
 static struct ltq_gpio ltq_gpio_port[MAX_PORTS];
 
-int gpio_to_irq(unsigned int gpio)
-{
-	return -EINVAL;
-}
-EXPORT_SYMBOL(gpio_to_irq);
-
-int irq_to_gpio(unsigned int gpio)
-{
-	return -EINVAL;
-}
-EXPORT_SYMBOL(irq_to_gpio);
-
 int ltq_gpio_request(unsigned int pin, unsigned int alt0,
 	unsigned int alt1, unsigned int dir, const char *name)
 {
diff --git a/arch/mips/lantiq/xway/gpio_stp.c b/arch/mips/lantiq/xway/gpio_stp.c
index ff9991c..d674f1b 100644
--- a/arch/mips/lantiq/xway/gpio_stp.c
+++ b/arch/mips/lantiq/xway/gpio_stp.c
@@ -78,11 +78,6 @@ static struct gpio_chip ltq_stp_chip = {
 
 static int ltq_stp_hw_init(void)
 {
-	/* the 3 pins used to control the external stp */
-	ltq_gpio_request(4, 1, 0, 1, "stp-st");
-	ltq_gpio_request(5, 1, 0, 1, "stp-d");
-	ltq_gpio_request(6, 1, 0, 1, "stp-sh");
-
 	/* sane defaults */
 	ltq_stp_w32(0, LTQ_STP_AR);
 	ltq_stp_w32(0, LTQ_STP_CPU0);
diff --git a/arch/mips/pci/pci-lantiq.c b/arch/mips/pci/pci-lantiq.c
index 030c77e..4d8c49b 100644
--- a/arch/mips/pci/pci-lantiq.c
+++ b/arch/mips/pci/pci-lantiq.c
@@ -68,32 +68,6 @@
 #define ltq_pci_cfg_w32(x, y)	ltq_w32((x), ltq_pci_mapped_cfg + (y))
 #define ltq_pci_cfg_r32(x)	ltq_r32(ltq_pci_mapped_cfg + (x))
 
-struct ltq_pci_gpio_map {
-	int pin;
-	int alt0;
-	int alt1;
-	int dir;
-	char *name;
-};
-
-/* the pci core can make use of the following gpios */
-static struct ltq_pci_gpio_map ltq_pci_gpio_map[] = {
-	{ 0, 1, 0, 0, "pci-exin0" },
-	{ 1, 1, 0, 0, "pci-exin1" },
-	{ 2, 1, 0, 0, "pci-exin2" },
-	{ 39, 1, 0, 0, "pci-exin3" },
-	{ 10, 1, 0, 0, "pci-exin4" },
-	{ 9, 1, 0, 0, "pci-exin5" },
-	{ 30, 1, 0, 1, "pci-gnt1" },
-	{ 23, 1, 0, 1, "pci-gnt2" },
-	{ 19, 1, 0, 1, "pci-gnt3" },
-	{ 38, 1, 0, 1, "pci-gnt4" },
-	{ 29, 1, 0, 0, "pci-req1" },
-	{ 31, 1, 0, 0, "pci-req2" },
-	{ 3, 1, 0, 0, "pci-req3" },
-	{ 37, 1, 0, 0, "pci-req4" },
-};
-
 __iomem void *ltq_pci_mapped_cfg;
 static __iomem void *ltq_pci_membase;
 
@@ -151,22 +125,6 @@ static u32 ltq_calc_bar11mask(void)
 	return bar11mask;
 }
 
-static void ltq_pci_setup_gpio(int gpio)
-{
-	int i;
-	for (i = 0; i < ARRAY_SIZE(ltq_pci_gpio_map); i++) {
-		if (gpio & (1 << i)) {
-			ltq_gpio_request(ltq_pci_gpio_map[i].pin,
-				ltq_pci_gpio_map[i].alt0,
-				ltq_pci_gpio_map[i].alt1,
-				ltq_pci_gpio_map[i].dir,
-				ltq_pci_gpio_map[i].name);
-		}
-	}
-	ltq_gpio_request(21, 0, 0, 1, "pci-reset");
-	ltq_pci_req_mask = (gpio >> PCI_REQ_SHIFT) & PCI_REQ_MASK;
-}
-
 static int __devinit ltq_pci_startup(struct ltq_pci_data *conf)
 {
 	u32 temp_buffer;
@@ -192,7 +150,7 @@ static int __devinit ltq_pci_startup(struct ltq_pci_data *conf)
 	}
 
 	/* setup pci clock and gpis used by pci */
-	ltq_pci_setup_gpio(conf->gpio);
+	gpio_request(21, "pci-reset");
 
 	/* enable auto-switching between PCI and EBU */
 	ltq_pci_w32(0xa, PCI_CR_CLK_CTRL);
-- 
1.7.9.1
