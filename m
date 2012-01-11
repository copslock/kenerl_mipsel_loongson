Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2012 21:45:19 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:47502 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904052Ab2AKUop (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Jan 2012 21:44:45 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        Thomas Langer <thomas.langer@lantiq.com>
Subject: [PATCH RESEND 02/17] MIPS: lantiq: change ltq_request_gpio() call signature
Date:   Wed, 11 Jan 2012 21:44:19 +0100
Message-Id: <1326314674-9899-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1326314674-9899-1-git-send-email-blogic@openwrt.org>
References: <1326314674-9899-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

ltq_request_gpio() was using alt0/1 to multiplex the function of GPIO pins.
This was XWAY specific. In order to also accomodate SoCs that require more bits
we use a 32bit mask instead. This way the call signature is consistent between
XWAY and FALC-ON.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
---
 .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |    4 +-
 arch/mips/lantiq/xway/gpio.c                       |    8 ++--
 arch/mips/lantiq/xway/gpio_stp.c                   |    6 +-
 arch/mips/pci/pci-lantiq.c                         |   40 +++++++++----------
 4 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
index 9ea7043..a6521ec 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
@@ -151,8 +151,8 @@ static inline void ltq_cgu_w32_mask(u32 c, u32 s, u32 r) {
 }
 
 /* request a non-gpio and set the PIO config */
-extern int  ltq_gpio_request(unsigned int pin, unsigned int alt0,
-	unsigned int alt1, unsigned int dir, const char *name);
+extern int  ltq_gpio_request(unsigned int pin, unsigned int mux,
+				unsigned int dir, const char *name);
 extern void ltq_pmu_enable(unsigned int module);
 extern void ltq_pmu_disable(unsigned int module);
 extern void ltq_cgu_enable(unsigned int clk);
diff --git a/arch/mips/lantiq/xway/gpio.c b/arch/mips/lantiq/xway/gpio.c
index d2fa98f..f204f6c 100644
--- a/arch/mips/lantiq/xway/gpio.c
+++ b/arch/mips/lantiq/xway/gpio.c
@@ -48,8 +48,8 @@ int irq_to_gpio(unsigned int gpio)
 }
 EXPORT_SYMBOL(irq_to_gpio);
 
-int ltq_gpio_request(unsigned int pin, unsigned int alt0,
-	unsigned int alt1, unsigned int dir, const char *name)
+int ltq_gpio_request(unsigned int pin, unsigned int mux,
+			unsigned int dir, const char *name)
 {
 	int id = 0;
 
@@ -67,13 +67,13 @@ int ltq_gpio_request(unsigned int pin, unsigned int alt0,
 		pin -= PINS_PER_PORT;
 		id++;
 	}
-	if (alt0)
+	if (mux & 0x2)
 		ltq_gpio_setbit(ltq_gpio_port[id].membase,
 			LTQ_GPIO_ALTSEL0, pin);
 	else
 		ltq_gpio_clearbit(ltq_gpio_port[id].membase,
 			LTQ_GPIO_ALTSEL0, pin);
-	if (alt1)
+	if (mux & 0x1)
 		ltq_gpio_setbit(ltq_gpio_port[id].membase,
 			LTQ_GPIO_ALTSEL1, pin);
 	else
diff --git a/arch/mips/lantiq/xway/gpio_stp.c b/arch/mips/lantiq/xway/gpio_stp.c
index ff9991c..2c78660 100644
--- a/arch/mips/lantiq/xway/gpio_stp.c
+++ b/arch/mips/lantiq/xway/gpio_stp.c
@@ -79,9 +79,9 @@ static struct gpio_chip ltq_stp_chip = {
 static int ltq_stp_hw_init(void)
 {
 	/* the 3 pins used to control the external stp */
-	ltq_gpio_request(4, 1, 0, 1, "stp-st");
-	ltq_gpio_request(5, 1, 0, 1, "stp-d");
-	ltq_gpio_request(6, 1, 0, 1, "stp-sh");
+	ltq_gpio_request(4, 2, 1, "stp-st");
+	ltq_gpio_request(5, 2, 1, "stp-d");
+	ltq_gpio_request(6, 2, 1, "stp-sh");
 
 	/* sane defaults */
 	ltq_stp_w32(0, LTQ_STP_AR);
diff --git a/arch/mips/pci/pci-lantiq.c b/arch/mips/pci/pci-lantiq.c
index be1e1af..3bf42c8 100644
--- a/arch/mips/pci/pci-lantiq.c
+++ b/arch/mips/pci/pci-lantiq.c
@@ -69,29 +69,28 @@
 #define ltq_pci_cfg_r32(x)	ltq_r32(ltq_pci_mapped_cfg + (x))
 
 struct ltq_pci_gpio_map {
-	int pin;
-	int alt0;
-	int alt1;
-	int dir;
+	unsigned int pin;
+	unsigned int mux;
+	unsigned char dir;
 	char *name;
 };
 
 /* the pci core can make use of the following gpios */
 static struct ltq_pci_gpio_map ltq_pci_gpio_map[] = {
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
+	{ .pin = 0, .mux = 2, .dir = 0, .name = "pci-exin0" },
+	{ .pin = 1, .mux = 2, .dir = 0, .name = "pci-exin1" },
+	{ .pin = 2, .mux = 2, .dir = 0, .name = "pci-exin2" },
+	{ .pin = 39, .mux = 2, .dir = 0, .name = "pci-exin3" },
+	{ .pin = 10, .mux = 2, .dir = 0, .name = "pci-exin4" },
+	{ .pin = 9, .mux = 2, .dir = 0, .name = "pci-exin5" },
+	{ .pin = 30, .mux = 2, .dir = 1, .name = "pci-gnt1" },
+	{ .pin = 23, .mux = 2, .dir = 1, .name = "pci-gnt2" },
+	{ .pin = 19, .mux = 2, .dir = 1, .name = "pci-gnt3" },
+	{ .pin = 38, .mux = 2, .dir = 1, .name = "pci-gnt4" },
+	{ .pin = 29, .mux = 2, .dir = 0, .name = "pci-req1" },
+	{ .pin = 31, .mux = 2, .dir = 0, .name = "pci-req2" },
+	{ .pin = 3, .mux = 2, .dir = 0, .name = "pci-req3" },
+	{ .pin = 37, .mux = 2, .dir = 0, .name = "pci-req4" },
 };
 
 __iomem void *ltq_pci_mapped_cfg;
@@ -157,13 +156,12 @@ static void ltq_pci_setup_gpio(int gpio)
 	for (i = 0; i < ARRAY_SIZE(ltq_pci_gpio_map); i++) {
 		if (gpio & (1 << i)) {
 			ltq_gpio_request(ltq_pci_gpio_map[i].pin,
-				ltq_pci_gpio_map[i].alt0,
-				ltq_pci_gpio_map[i].alt1,
+				ltq_pci_gpio_map[i].mux,
 				ltq_pci_gpio_map[i].dir,
 				ltq_pci_gpio_map[i].name);
 		}
 	}
-	ltq_gpio_request(21, 0, 0, 1, "pci-reset");
+	ltq_gpio_request(21, 0, 1, "pci-reset");
 	ltq_pci_req_mask = (gpio >> PCI_REQ_SHIFT) & PCI_REQ_MASK;
 }
 
-- 
1.7.7.1
