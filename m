Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Sep 2008 14:23:44 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:16861 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20031239AbYIANWm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Sep 2008 14:22:42 +0100
Received: from localhost.localdomain (p5198-ipad203funabasi.chiba.ocn.ne.jp [222.146.84.198])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 1B8B7B645; Mon,  1 Sep 2008 22:22:38 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 3/6] TXx9: IOC LED support
Date:	Mon,  1 Sep 2008 22:22:38 +0900
Message-Id: <1220275361-5001-3-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Add leds-gpio platform device for controlling LEDs connected to IOC on
RBTX49XX and JMR3927 board.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/generic/setup.c   |  111 ++++++++++++++++++++++++++++++++++++++
 arch/mips/txx9/jmr3927/setup.c   |    5 ++
 arch/mips/txx9/rbtx4927/setup.c  |    1 +
 arch/mips/txx9/rbtx4938/setup.c  |    1 +
 include/asm-mips/txx9/generic.h  |    4 ++
 include/asm-mips/txx9/rbtx4927.h |    1 +
 6 files changed, 123 insertions(+), 0 deletions(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 0f91e83..b25b479 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
 #include <linux/mtd/physmap.h>
+#include <linux/leds.h>
 #include <asm/bootinfo.h>
 #include <asm/time.h>
 #include <asm/reboot.h>
@@ -648,3 +649,113 @@ void __init txx9_physmap_flash_init(int no, unsigned long addr,
 		platform_device_put(pdev);
 #endif
 }
+
+#if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
+static DEFINE_SPINLOCK(txx9_iocled_lock);
+
+#define TXX9_IOCLED_MAXLEDS 8
+
+struct txx9_iocled_data {
+	struct gpio_chip chip;
+	u8 cur_val;
+	void __iomem *mmioaddr;
+	struct gpio_led_platform_data pdata;
+	struct gpio_led leds[TXX9_IOCLED_MAXLEDS];
+	char names[TXX9_IOCLED_MAXLEDS][32];
+};
+
+static int txx9_iocled_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct txx9_iocled_data *data =
+		container_of(chip, struct txx9_iocled_data, chip);
+	return data->cur_val & (1 << offset);
+}
+
+static void txx9_iocled_set(struct gpio_chip *chip, unsigned int offset,
+			    int value)
+{
+	struct txx9_iocled_data *data =
+		container_of(chip, struct txx9_iocled_data, chip);
+	unsigned long flags;
+	spin_lock_irqsave(&txx9_iocled_lock, flags);
+	if (value)
+		data->cur_val |= 1 << offset;
+	else
+		data->cur_val &= ~(1 << offset);
+	writeb(data->cur_val, data->mmioaddr);
+	mmiowb();
+	spin_unlock_irqrestore(&txx9_iocled_lock, flags);
+}
+
+static int txx9_iocled_dir_in(struct gpio_chip *chip, unsigned int offset)
+{
+	return 0;
+}
+
+static int txx9_iocled_dir_out(struct gpio_chip *chip, unsigned int offset,
+			       int value)
+{
+	txx9_iocled_set(chip, offset, value);
+	return 0;
+}
+
+void __init txx9_iocled_init(unsigned long baseaddr,
+			     int basenum, unsigned int num, int lowactive,
+			     const char *color, char **deftriggers)
+{
+	struct txx9_iocled_data *iocled;
+	struct platform_device *pdev;
+	int i;
+	static char *default_triggers[] __initdata = {
+		"heartbeat",
+		"ide-disk",
+		"nand-disk",
+		NULL,
+	};
+
+	if (!deftriggers)
+		deftriggers = default_triggers;
+	iocled = kzalloc(sizeof(*iocled), GFP_KERNEL);
+	if (!iocled)
+		return;
+	iocled->mmioaddr = ioremap(baseaddr, 1);
+	if (!iocled->mmioaddr)
+		return;
+	iocled->chip.get = txx9_iocled_get;
+	iocled->chip.set = txx9_iocled_set;
+	iocled->chip.direction_input = txx9_iocled_dir_in;
+	iocled->chip.direction_output = txx9_iocled_dir_out;
+	iocled->chip.label = "iocled";
+	iocled->chip.base = basenum;
+	iocled->chip.ngpio = num;
+	if (gpiochip_add(&iocled->chip))
+		return;
+	if (basenum < 0)
+		basenum = iocled->chip.base;
+
+	pdev = platform_device_alloc("leds-gpio", basenum);
+	if (!pdev)
+		return;
+	iocled->pdata.num_leds = num;
+	iocled->pdata.leds = iocled->leds;
+	for (i = 0; i < num; i++) {
+		struct gpio_led *led = &iocled->leds[i];
+		snprintf(iocled->names[i], sizeof(iocled->names[i]),
+			 "iocled:%s:%u", color, i);
+		led->name = iocled->names[i];
+		led->gpio = basenum + i;
+		led->active_low = lowactive;
+		if (deftriggers && *deftriggers)
+			led->default_trigger = *deftriggers++;
+	}
+	pdev->dev.platform_data = &iocled->pdata;
+	if (platform_device_add(pdev))
+		platform_device_put(pdev);
+}
+#else /* CONFIG_LEDS_GPIO */
+void __init txx9_iocled_init(unsigned long baseaddr,
+			     int basenum, unsigned int num, int lowactive,
+			     const char *color, char **deftriggers)
+{
+}
+#endif /* CONFIG_LEDS_GPIO */
diff --git a/arch/mips/txx9/jmr3927/setup.c b/arch/mips/txx9/jmr3927/setup.c
index 0f3843c..25e50a7 100644
--- a/arch/mips/txx9/jmr3927/setup.c
+++ b/arch/mips/txx9/jmr3927/setup.c
@@ -200,10 +200,15 @@ static void __init jmr3927_mtd_init(void)
 
 static void __init jmr3927_device_init(void)
 {
+	unsigned long iocled_base = JMR3927_IOC_LED_ADDR - IO_BASE;
+#ifdef __LITTLE_ENDIAN
+	iocled_base |= 1;
+#endif
 	__swizzle_addr_b = jmr3927_swizzle_addr_b;
 	jmr3927_rtc_init();
 	tx3927_wdt_init();
 	jmr3927_mtd_init();
+	txx9_iocled_init(iocled_base, -1, 8, 1, "green", NULL);
 }
 
 struct txx9_board_vec jmr3927_vec __initdata = {
diff --git a/arch/mips/txx9/rbtx4927/setup.c b/arch/mips/txx9/rbtx4927/setup.c
index abe32c1..4a74423 100644
--- a/arch/mips/txx9/rbtx4927/setup.c
+++ b/arch/mips/txx9/rbtx4927/setup.c
@@ -321,6 +321,7 @@ static void __init rbtx4927_device_init(void)
 	rbtx4927_ne_init();
 	tx4927_wdt_init();
 	rbtx4927_mtd_init();
+	txx9_iocled_init(RBTX4927_LED_ADDR - IO_BASE, -1, 3, 1, "green", NULL);
 }
 
 struct txx9_board_vec rbtx4927_vec __initdata = {
diff --git a/arch/mips/txx9/rbtx4938/setup.c b/arch/mips/txx9/rbtx4938/setup.c
index ec6e812..e077cc4 100644
--- a/arch/mips/txx9/rbtx4938/setup.c
+++ b/arch/mips/txx9/rbtx4938/setup.c
@@ -352,6 +352,7 @@ static void __init rbtx4938_device_init(void)
 	rbtx4938_ne_init();
 	tx4938_wdt_init();
 	rbtx4938_mtd_init();
+	txx9_iocled_init(RBTX4938_LED_ADDR - IO_BASE, -1, 8, 1, "green", NULL);
 }
 
 struct txx9_board_vec rbtx4938_vec __initdata = {
diff --git a/include/asm-mips/txx9/generic.h b/include/asm-mips/txx9/generic.h
index dc85515..4316a3e 100644
--- a/include/asm-mips/txx9/generic.h
+++ b/include/asm-mips/txx9/generic.h
@@ -82,4 +82,8 @@ static inline unsigned int __fls8(unsigned char x)
 	return r;
 }
 
+void txx9_iocled_init(unsigned long baseaddr,
+		      int basenum, unsigned int num, int lowactive,
+		      const char *color, char **deftriggers);
+
 #endif /* __ASM_TXX9_GENERIC_H */
diff --git a/include/asm-mips/txx9/rbtx4927.h b/include/asm-mips/txx9/rbtx4927.h
index c601546..b2adab3 100644
--- a/include/asm-mips/txx9/rbtx4927.h
+++ b/include/asm-mips/txx9/rbtx4927.h
@@ -34,6 +34,7 @@
 #define RBTX4927_PCIIO		0x16000000
 #define RBTX4927_PCIIO_SIZE	0x01000000
 
+#define RBTX4927_LED_ADDR	(IO_BASE + TXX9_CE(2) + 0x00001000)
 #define RBTX4927_IMASK_ADDR	(IO_BASE + TXX9_CE(2) + 0x00002000)
 #define RBTX4927_IMSTAT_ADDR	(IO_BASE + TXX9_CE(2) + 0x00002006)
 #define RBTX4927_SOFTINT_ADDR	(IO_BASE + TXX9_CE(2) + 0x00003000)
-- 
1.5.6.3
