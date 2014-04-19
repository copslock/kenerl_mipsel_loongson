Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Apr 2014 00:58:23 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:54640 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816671AbaDSW6UnAl1S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 20 Apr 2014 00:58:20 +0200
Date:   Sat, 19 Apr 2014 23:58:20 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Ralf Baechle <ralf@linux-mips.org>
cc:     rtc-linux@googlegroups.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] RTC: rtc-cmos: drivers/char/rtc.c features for DECstation
 support
Message-ID: <alpine.LFD.2.11.1404192224250.11598@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

This brings in drivers/char/rtc.c functionality required for DECstation 
and, should the maintainers decide to switch, Alpha systems to use 
rtc-cmos.

Specifically these features are made available:

* RTC iomem rather than x86/PCI port I/O mapping, controlled with the 
  RTC_IOMAPPED macro as with the original driver.  The DS1287A chip in all 
  DECstation systems is mapped in the host bus address space as a 
  contiguous block of 64 32-bit words of which the least significant byte 
  accesses the RTC chip for both reads and writes.  All the address and 
  data window register accesses are made transparently by the chipset glue 
  logic so that the device appears directly mapped on the host bus.

* A way to set the size of the address space explicitly with the 
  newly-added `address_space' member of the platform part of the RTC 
  device structure.  This avoids the unreliable heuristics that does not 
  work in a setup where the RTC is not explicitly accessed with the usual 
  address and data window register pair.

* The ability to use the RTC periodic interrupt as a system clock device,
  which is implemented by arch/mips/kernel/cevt-ds1287.c for DECstation 
  systems and takes the RTC interrupt away from the RTC driver.  
  Eventually hooking back to the clock device's interrupt handler should 
  be possible for the purpose of the alarm clock and possibly also 
  update-in-progress interrupt, but this is not done by this change.

  o To avoid interfering with the clock interrupt all the places where the 
    RTC interrupt mask is fiddled with are only executed if and IRQ has 
    been assigned to the RTC driver.

  o To avoid changing the clock setup Register A is not fiddled with if 
    CMOS_RTC_FLAGS_NOFREQ is set in the newly-added `flags' member of the 
    platform part of the RTC device structure.  Originally, in 
    drivers/char/rtc.c, this was keyed with the absence of the RTC 
    interrupt, just like the interrupt mask, but there only the periodic 
    interrupt frequency is set, whereas rtc-cmos also sets the divider 
    bits.  Therefore a new flag is introduced so that systems where the 
    RTC interrupt is not usable rather than used as a system clock device 
    can fully initialise the RTC.

* A small clean-up is made to the IRQ assignment code that makes the IRQ 
  number hardcoded to -1 rather than arbitrary -ENXIO (or whatever error 
  happens to be returned by platform_get_irq) where no IRQ has been 
  assigned to the RTC driver (NO_IRQ might be another candidate, but it 
  looks like this macro has inconsistent or missing definitions and 
  limited use and might therefore be unsafe).

Verified to work correctly with a DECstation 5000/240 system.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Alessandro,

 Please apply or otherwise let me know if you have any issues with this 
proposal.

 Thanks,

  Maciej

linux-rtc-cmos-dec.patch
Index: linux-20140404-3maxp/drivers/rtc/rtc-cmos.c
===================================================================
--- linux-20140404-3maxp.orig/drivers/rtc/rtc-cmos.c
+++ linux-20140404-3maxp/drivers/rtc/rtc-cmos.c
@@ -647,6 +647,7 @@ cmos_do_probe(struct device *dev, struct
 	int				retval = 0;
 	unsigned char			rtc_control;
 	unsigned			address_space;
+	u32				flags = 0;
 
 	/* there can be only one ... */
 	if (cmos_rtc.dev)
@@ -660,9 +661,12 @@ cmos_do_probe(struct device *dev, struct
 	 * REVISIT non-x86 systems may instead use memory space resources
 	 * (needing ioremap etc), not i/o space resources like this ...
 	 */
-	ports = request_region(ports->start,
-			resource_size(ports),
-			driver_name);
+	if (RTC_IOMAPPED)
+		ports = request_region
+			(ports->start, resource_size(ports), driver_name);
+	else
+		ports = request_mem_region
+			(ports->start, resource_size(ports), driver_name);
 	if (!ports) {
 		dev_dbg(dev, "i/o registers already in use\n");
 		return -EBUSY;
@@ -699,6 +703,11 @@ cmos_do_probe(struct device *dev, struct
 	 * expect CMOS_READ and friends to handle.
 	 */
 	if (info) {
+		if (info->flags)
+			flags = info->flags;
+		if (info->address_space)
+			address_space = info->address_space;
+
 		if (info->rtc_day_alarm && info->rtc_day_alarm < 128)
 			cmos_rtc.day_alrm = info->rtc_day_alarm;
 		if (info->rtc_mon_alarm && info->rtc_mon_alarm < 128)
@@ -726,18 +735,21 @@ cmos_do_probe(struct device *dev, struct
 
 	spin_lock_irq(&rtc_lock);
 
-	/* force periodic irq to CMOS reset default of 1024Hz;
-	 *
-	 * REVISIT it's been reported that at least one x86_64 ALI mobo
-	 * doesn't use 32KHz here ... for portability we might need to
-	 * do something about other clock frequencies.
-	 */
-	cmos_rtc.rtc->irq_freq = 1024;
-	hpet_set_periodic_freq(cmos_rtc.rtc->irq_freq);
-	CMOS_WRITE(RTC_REF_CLCK_32KHZ | 0x06, RTC_FREQ_SELECT);
+	if (!(flags & CMOS_RTC_FLAGS_NOFREQ)) {
+		/* force periodic irq to CMOS reset default of 1024Hz;
+		 *
+		 * REVISIT it's been reported that at least one x86_64 ALI
+		 * mobo doesn't use 32KHz here ... for portability we might
+		 * need to do something about other clock frequencies.
+		 */
+		cmos_rtc.rtc->irq_freq = 1024;
+		hpet_set_periodic_freq(cmos_rtc.rtc->irq_freq);
+		CMOS_WRITE(RTC_REF_CLCK_32KHZ | 0x06, RTC_FREQ_SELECT);
+	}
 
 	/* disable irqs */
-	cmos_irq_disable(&cmos_rtc, RTC_PIE | RTC_AIE | RTC_UIE);
+	if (is_valid_irq(rtc_irq))
+		cmos_irq_disable(&cmos_rtc, RTC_PIE | RTC_AIE | RTC_UIE);
 
 	rtc_control = CMOS_READ(RTC_CONTROL);
 
@@ -802,14 +814,18 @@ cmos_do_probe(struct device *dev, struct
 	cmos_rtc.dev = NULL;
 	rtc_device_unregister(cmos_rtc.rtc);
 cleanup0:
-	release_region(ports->start, resource_size(ports));
+	if (RTC_IOMAPPED)
+		release_region(ports->start, resource_size(ports));
+	else
+		release_mem_region(ports->start, resource_size(ports));
 	return retval;
 }
 
-static void cmos_do_shutdown(void)
+static void cmos_do_shutdown(int rtc_irq)
 {
 	spin_lock_irq(&rtc_lock);
-	cmos_irq_disable(&cmos_rtc, RTC_IRQMASK);
+	if (is_valid_irq(rtc_irq))
+		cmos_irq_disable(&cmos_rtc, RTC_IRQMASK);
 	spin_unlock_irq(&rtc_lock);
 }
 
@@ -818,7 +834,7 @@ static void __exit cmos_do_remove(struct
 	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
 	struct resource *ports;
 
-	cmos_do_shutdown();
+	cmos_do_shutdown(cmos->irq);
 
 	sysfs_remove_bin_file(&dev->kobj, &nvram);
 
@@ -831,7 +847,10 @@ static void __exit cmos_do_remove(struct
 	cmos->rtc = NULL;
 
 	ports = cmos->iomem;
-	release_region(ports->start, resource_size(ports));
+	if (RTC_IOMAPPED)
+		release_region(ports->start, resource_size(ports));
+	else
+		release_mem_region(ports->start, resource_size(ports));
 	cmos->iomem = NULL;
 
 	cmos->dev = NULL;
@@ -1065,10 +1084,13 @@ static void __exit cmos_pnp_remove(struc
 
 static void cmos_pnp_shutdown(struct pnp_dev *pnp)
 {
-	if (system_state == SYSTEM_POWER_OFF && !cmos_poweroff(&pnp->dev))
+	struct device *dev = &pnp->dev;
+	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
+
+	if (system_state == SYSTEM_POWER_OFF && !cmos_poweroff(dev))
 		return;
 
-	cmos_do_shutdown();
+	cmos_do_shutdown(cmos->irq);
 }
 
 static const struct pnp_device_id rtc_ids[] = {
@@ -1145,11 +1167,21 @@ static inline void cmos_of_init(struct p
 
 static int __init cmos_platform_probe(struct platform_device *pdev)
 {
+	struct resource *resource;
+	int irq;
+
 	cmos_of_init(pdev);
 	cmos_wake_setup(&pdev->dev);
-	return cmos_do_probe(&pdev->dev,
-			platform_get_resource(pdev, IORESOURCE_IO, 0),
-			platform_get_irq(pdev, 0));
+
+	if (RTC_IOMAPPED)
+		resource = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	else
+		resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		irq = -1;
+
+	return cmos_do_probe(&pdev->dev, resource, irq);
 }
 
 static int __exit cmos_platform_remove(struct platform_device *pdev)
@@ -1160,10 +1192,13 @@ static int __exit cmos_platform_remove(s
 
 static void cmos_platform_shutdown(struct platform_device *pdev)
 {
-	if (system_state == SYSTEM_POWER_OFF && !cmos_poweroff(&pdev->dev))
+	struct device *dev = &pdev->dev;
+	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
+
+	if (system_state == SYSTEM_POWER_OFF && !cmos_poweroff(dev))
 		return;
 
-	cmos_do_shutdown();
+	cmos_do_shutdown(cmos->irq);
 }
 
 /* work with hotplug and coldplug */
Index: linux-20140404-3maxp/include/linux/mc146818rtc.h
===================================================================
--- linux-20140404-3maxp.orig/include/linux/mc146818rtc.h
+++ linux-20140404-3maxp/include/linux/mc146818rtc.h
@@ -31,6 +31,10 @@ struct cmos_rtc_board_info {
 	void	(*wake_on)(struct device *dev);
 	void	(*wake_off)(struct device *dev);
 
+	u32	flags;
+#define CMOS_RTC_FLAGS_NOFREQ	(1 << 0)
+	int	address_space;
+
 	u8	rtc_day_alarm;		/* zero, or register index */
 	u8	rtc_mon_alarm;		/* zero, or register index */
 	u8	rtc_century;		/* zero, or register index */
