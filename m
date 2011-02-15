Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Feb 2011 12:40:57 +0100 (CET)
Received: from qmta03.emeryville.ca.mail.comcast.net ([76.96.30.32]:56830 "EHLO
        qmta03.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491012Ab1BOLkf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Feb 2011 12:40:35 +0100
Received: from omta15.emeryville.ca.mail.comcast.net ([76.96.30.71])
        by qmta03.emeryville.ca.mail.comcast.net with comcast
        id 8BT51g0031Y3wxoA3BgUhT; Tue, 15 Feb 2011 11:40:28 +0000
Received: from [192.168.1.13] ([69.251.104.163])
        by omta15.emeryville.ca.mail.comcast.net with comcast
        id 8BgS1g00U3XYSBH8bBgTHs; Tue, 15 Feb 2011 11:40:28 +0000
Message-ID: <4D5A65F3.8080107@gentoo.org>
Date:   Tue, 15 Feb 2011 06:39:31 -0500
From:   Kumba <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH 2/2]: Add support for Dallas/Maxim DS1685/1687 RTC
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29181
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Wire SGI O2 (IP32) to use the rtc-ds1685 driver as its RTC.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
  arch/mips/sgi-ip32/ip32-platform.c |   25 ++++++++++-----
  arch/mips/sgi-ip32/ip32-reset.c    |   53 ---------------------------------
  drivers/rtc/Kconfig                |   17 +++++++++-
  include/linux/rtc/ds1685.h         |   58 +++++++++++++++++++++++++++++++++++--
  4 files changed, 88 insertions(+), 65 deletions(-)

diff -Naurp linux-2.6.37.rtc-ds1685/arch/mips/sgi-ip32/ip32-platform.c 
linux-2.6.37.rtc-ds1685.ip32/arch/mips/sgi-ip32/ip32-platform.c
--- linux-2.6.37.rtc-ds1685/arch/mips/sgi-ip32/ip32-platform.c	2011-02-15 
04:19:45.882076002 -0500
+++ linux-2.6.37.rtc-ds1685.ip32/arch/mips/sgi-ip32/ip32-platform.c	2011-02-15 
04:31:46.972076001 -0500
@@ -90,21 +90,30 @@ static __init int sgio2btns_devinit(void

  device_initcall(sgio2btns_devinit);

-static struct resource sgio2_cmos_rsrc[] = {
+#define MACE_RTC_RES_START (MACE_BASE + offsetof(struct sgi_mace, isa.rtc))
+#define MACE_RTC_RES_END (MACE_RTC_RES_START + 32767)
+
+static struct resource ip32_rtc_resources[] = {
  	{
-		.start = 0x70,
-		.end   = 0x71,
-		.flags = IORESOURCE_IO
+		.start	= MACEISA_RTC_IRQ,
+		.end	= MACEISA_RTC_IRQ,
+		.flags	= IORESOURCE_IRQ
+	}, {
+		.start	= MACE_RTC_RES_START,
+		.end	= MACE_RTC_RES_END,
+		.flags	= IORESOURCE_MEM,
  	}
  };

-static __init int sgio2_cmos_devinit(void)
+
+
+static __init int sgio2_rtc_devinit(void)
  {
-	return IS_ERR(platform_device_register_simple("rtc_cmos", -1,
-						      sgio2_cmos_rsrc, 1));
+	return IS_ERR(platform_device_register_simple("rtc-ds1685", -1,
+		      ip32_rtc_resources, ARRAY_SIZE(ip32_rtc_resources)));
  }

-device_initcall(sgio2_cmos_devinit);
+device_initcall(sgio2_rtc_devinit);

  MODULE_AUTHOR("Ralf Baechle <ralf@linux-mips.org>");
  MODULE_LICENSE("GPL");
diff -Naurp linux-2.6.37.rtc-ds1685/arch/mips/sgi-ip32/ip32-reset.c 
linux-2.6.37.rtc-ds1685.ip32/arch/mips/sgi-ip32/ip32-reset.c
--- linux-2.6.37.rtc-ds1685/arch/mips/sgi-ip32/ip32-reset.c	2011-02-15 
04:19:45.882076002 -0500
+++ linux-2.6.37.rtc-ds1685.ip32/arch/mips/sgi-ip32/ip32-reset.c	2011-02-15 
04:58:46.582076001 -0500
@@ -33,7 +33,7 @@
  #define POWERDOWN_FREQ		(HZ / 4)
  #define PANIC_FREQ		(HZ / 8)

-static struct timer_list power_timer, blink_timer, debounce_timer;
+static struct timer_list power_timer, blink_timer;
  static int has_panicked, shuting_down;

  static void ip32_machine_restart(char *command) __attribute__((noreturn));
@@ -89,33 +89,6 @@ static void blink_timeout(unsigned long
  	mod_timer(&blink_timer, jiffies + data);
  }

-static void debounce(unsigned long data)
-{
-	unsigned char reg_a, reg_c, xctrl_a;
-
-	reg_c = CMOS_READ(RTC_INTR_FLAGS);
-	reg_a = CMOS_READ(RTC_REG_A);
-	CMOS_WRITE(reg_a | DS_REGA_DV0, RTC_REG_A);
-	wbflush();
-	xctrl_a = CMOS_READ(DS_B1_XCTRL4A);
-	if ((xctrl_a & DS_XCTRL4A_IFS) || (reg_c & RTC_IRQF )) {
-		/* Interrupt still being sent. */
-		debounce_timer.expires = jiffies + 50;
-		add_timer(&debounce_timer);
-
-		/* clear interrupt source */
-		CMOS_WRITE(xctrl_a & ~DS_XCTRL4A_IFS, DS_B1_XCTRL4A);
-		CMOS_WRITE(reg_a & ~DS_REGA_DV0, RTC_REG_A);
-		return;
-	}
-	CMOS_WRITE(reg_a & ~DS_REGA_DV0, RTC_REG_A);
-
-	if (has_panicked)
-		ip32_machine_restart(NULL);
-
-	enable_irq(MACEISA_RTC_IRQ);
-}
-
  static inline void ip32_power_button(void)
  {
  	if (has_panicked)
@@ -136,27 +109,6 @@ static inline void ip32_power_button(voi
  	add_timer(&power_timer);
  }

-static irqreturn_t ip32_rtc_int(int irq, void *dev_id)
-{
-	unsigned char reg_c;
-
-	reg_c = CMOS_READ(RTC_INTR_FLAGS);
-	if (!(reg_c & RTC_IRQF)) {
-		printk(KERN_WARNING
-			"%s: RTC IRQ without RTC_IRQF\n", __func__);
-	}
-	/* Wait until interrupt goes away */
-	disable_irq_nosync(MACEISA_RTC_IRQ);
-	init_timer(&debounce_timer);
-	debounce_timer.function = debounce;
-	debounce_timer.expires = jiffies + 50;
-	add_timer(&debounce_timer);
-
-	printk(KERN_DEBUG "Power button pressed\n");
-	ip32_power_button();
-	return IRQ_HANDLED;
-}
-
  static int panic_event(struct notifier_block *this, unsigned long event,
  		       void *ptr)
  {
@@ -196,9 +148,6 @@ static __init int ip32_reboot_setup(void
  	blink_timer.function = blink_timeout;
  	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);

-	if (request_irq(MACEISA_RTC_IRQ, ip32_rtc_int, 0, "rtc", NULL))
-		panic("Can't allocate MACEISA RTC IRQ");
-
  	return 0;
  }

diff -Naurp linux-2.6.37.rtc-ds1685/drivers/rtc/Kconfig 
linux-2.6.37.rtc-ds1685.ip32/drivers/rtc/Kconfig
--- linux-2.6.37.rtc-ds1685/drivers/rtc/Kconfig	2011-02-15 04:56:37.322076002 -0500
+++ linux-2.6.37.rtc-ds1685.ip32/drivers/rtc/Kconfig	2011-02-15 
04:36:20.372076000 -0500
@@ -501,17 +501,30 @@ config RTC_DRV_DS1553

  config RTC_DRV_DS1685
  	tristate "Dallas/Maxim DS1685/DS1687"
-	depends on I2C
+	depends on (I2C || SGI_IP32)
  	help
  	  If you say yes here you get support for the Dallas/Maxim
  	  DS1685/DS1687 timekeeping chip.

  	  Systems that use this chip include EPPC-405-UC modules, by
-	  electronic system design GmbH.
+	  electronic system design GmbH, and the SGI O2 (IP32).
+
+	  This module also supports the DS17285/DS17287 timekeeping chips
+	  that are sometimes found in place of the DS1685/DS1687 in some
+	  SGI O2 systems.

  	  This driver can also be built as a module. If so, the module
  	  will be called rtc-ds1685.

+config RTC_DRV_DS17285
+	bool "Enable DS17285/DS17287 Differences"
+	depends on (SGI_IP32 && RTC_DRV_DS1685)
+	help
+	  If your SGI O2 has one of these RTC chips instead of the more
+	  common DS1687-5 chip, say Y here to enable the minor differences
+	  this particular chip has.  For more information, refer to the
+	  Dallas/Maxim datasheet for the DS17285/DS17287 chip.
+
  config RTC_DRV_DS1742
  	tristate "Maxim/Dallas DS1742/1743"
  	help
diff -Naurp linux-2.6.37.rtc-ds1685/include/linux/rtc/ds1685.h 
linux-2.6.37.rtc-ds1685.ip32/include/linux/rtc/ds1685.h
--- linux-2.6.37.rtc-ds1685/include/linux/rtc/ds1685.h	2011-02-15 
04:28:04.582076001 -0500
+++ linux-2.6.37.rtc-ds1685.ip32/include/linux/rtc/ds1685.h	2011-02-15 
04:54:04.612076002 -0500
@@ -16,6 +16,19 @@
  #define _LINUX_RTC_DS1685_H_

  /*
+ * Note: IP32 documentation hints that IP32 systems actually have a DS17287
+ * RTC chip.  Having checked four different O2 systems myself, I have only
+ * observed DS1687-5 chips, same as in SGI Octane systems (IP30).
+ *
+ * That said, the DS17287 has some minor differences, so this driver can be
+ * built to support these small differences if their functionality is really
+ * needed.  Due to the lack of actually seeing one, however, these differences
+ * are not tested, but follow the information provided in the DS17285/DS17287
+ * data sheet.
+ */
+
+
+/*
   * Found in the original RTC driver for SGI IP30 (Octane) systems, it is used
   * in the ds1685_begin_access macro while loop to avoid RTC access lockouts.
   */
@@ -190,7 +203,29 @@ static const char *sqw_freq[16] = {
  #endif /* CONFIG_PROC_FS */


-#define DS1685_REG(r) volatile unsigned char r;
+/*
+ * SGI O2 (IP32) Systems need 1 byte of padding between the registers in
+ * order for the driver to function properly.  O2's should be using DS17287
+ * RTC chips, but most have DS1687-5 modules instead.  The differences
+ * between the two are minor, but accounted for anyways.
+ */
+#ifdef CONFIG_SGI_IP32
+  #define DS1685_PAD                   0xff
+  #define DS1685_REG(r)					\
+       volatile unsigned char r;			\
+       unsigned char r##_pad[DS1685_PAD]
+  #define DS1685_NVRAM1_PAD            0x31ce
+  #define DS1685_NVRAM2_PAD            0x7fbf
+
+  #ifdef CONFIG_RTC_DS17285
+    #define DS17285_RSVRD_PAD          0xa00
+  #else
+    #define DS17285_RSVRD_PAD          0x2c00
+  #endif
+#else
+  #define DS1685_REG(r)					\
+       volatile unsigned char r;
+#endif


  /*
@@ -213,6 +248,9 @@ struct ds1685_time_regs {
  	DS1685_REG(ctrlc);		/* Control Register C		*/
  	DS1685_REG(ctrld);		/* Control Register D		*/
  	volatile unsigned char nvram1[NVRAM_SZ_TIME];
+#ifdef CONFIG_SGI_IP32
+	unsigned char nvram1_pad[DS1685_NVRAM1_PAD];
+#endif
  };


@@ -221,6 +259,9 @@ struct ds1685_time_regs {
   */
  struct ds1685_bank0_regs {
  	volatile unsigned char nvram2[NVRAM_SZ_BANK0];
+#ifdef CONFIG_SGI_IP32
+	unsigned char nvram2_pad[DS1685_NVRAM2_PAD];
+#endif
  };


@@ -247,10 +288,21 @@ struct ds1685_bank1_regs {
  	DS1685_REG(rsvrd2);		/* Recovery Stack.  Holds last	*/
  	DS1685_REG(rtc_addr2);		/* four RTC addresses for the	*/
  	DS1685_REG(rtc_addr3);		/* BIOS to recover from an SMI.	*/
+#ifdef CONFIG_RTC_DS17285
+	DS1685_REG(ext_nvram_addr_lsb);	/* LSB of NVRAM Addr; DS17285/7 */
+	DS1685_REG(ext_nvram_addr_msb);	/* MSB of NVRAM Addr; DS17285/7 */
+#else
  	DS1685_REG(ext_nvram_addr);	/* Ext. NVRAM Addr; DS1685/7	*/
  	DS1685_REG(rsvrd3);		/* Reserved			*/
+#endif
  	DS1685_REG(rsvrd4);		/* Reserved			*/
  	DS1685_REG(ext_nvram_dport);	/* Ext. NVRAM Data Port		*/
+#ifdef CONFIG_SGI_IP32
+	volatile unsigned char rsvrd_pad[DS17285_RSVRD_PAD];
+#endif
+#ifdef CONFIG_RTC_DS17285
+	DS1685_REG(rtc_write_cnt);      /* RTC Write Counter; DS17285/7 */
+#endif
  };


@@ -269,7 +321,7 @@ struct ds1685_rtc_regs {


  /*
- * DS1685/1687 data structure.
+ * DS1685/1687/17285/17287 data structure.
   */
  struct ds1685_priv {
  	struct rtc_device *rtc;			/* RTC device pointer */
@@ -381,7 +433,7 @@ struct ds1685_priv {

  /*
   * This fetches the Silicon Serial Number, a unique ID specific to every
- * DS1685/1687.
+ * DS1685/1687/17285/17287.
   *
   * This number starts at 0x40, and is 8-bytes long, ending at 0x47.
   * The first byte is the model #, the next six bytes are the serial
