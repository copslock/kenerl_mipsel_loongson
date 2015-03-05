Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2015 14:01:29 +0100 (CET)
Received: from mail-we0-f171.google.com ([74.125.82.171]:35633 "EHLO
        mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007189AbbCENB1czCYI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Mar 2015 14:01:27 +0100
Received: by wevl61 with SMTP id l61so52808227wev.2;
        Thu, 05 Mar 2015 05:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=35EVq9xTLqIN3U8Dp5C6MlcscPK7cjr3vCLzyynnIH0=;
        b=nl7mTLCoYiBJqr0znxuhjcb/B9R8c3fVsGM9KOfuqCjjLEpGB6Bn8o1R04S8cJHqEF
         S5TjBqkcmn1+8OGHBWO7P4FLjmyiG5MyCVuQPy6HjqGPXYM2lwFA5RsWgcs6NfxnIr0R
         kGqIGTVPavzQFaEcWNfFGiZgGt2dyZxI9Rt+ae1thPga7tlt+02OaTMzdEfxWCVmWrMp
         bm79YNOhwOvfBaqRkrAbmGa5zYs/ZHcTOaXMpnm1jeDQBNFYH/1dnv2xJJ37X++k/q5X
         +Jzh7xGfxMNsejfrNh67muACDsy5ZAx9Fnx7Tna0CDXYkmHHFSDjN3+8QPGDhJ+Ac4Jp
         /f3A==
X-Received: by 10.180.90.138 with SMTP id bw10mr5727358wib.73.1425560482746;
        Thu, 05 Mar 2015 05:01:22 -0800 (PST)
Received: from r2d2.rsr.lip6.fr (hp-valentin.rsr.lip6.fr. [132.227.64.74])
        by mx.google.com with ESMTPSA id v9sm28714291wib.0.2015.03.05.05.01.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Mar 2015 05:01:21 -0800 (PST)
From:   Valentin Rothberg <valentinrothberg@gmail.com>
To:     akpm@linux-foundation.org
Cc:     Valentin Rothberg <valentinrothberg@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Bolle <pebolle@tiscali.nl>, Jiri Kosina <jkosina@suse.cz>,
        Ewan Milne <emilne@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Rajendra Nayak <rnayak@ti.com>,
        Sricharan R <r.sricharan@ti.com>,
        Afzal Mohammed <afzal@ti.com>, Keerthy <j-keerthy@ti.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Felipe Balbi <balbi@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kukjin Kim <kgene.kim@samsung.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Quentin Lambert <lambert.quentin@gmail.com>,
        Eyal Perry <eyalpe@mellanox.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, iss_storagedev@hp.com,
        linux-mtd@lists.infradead.org, linux-usb@vger.kernel.org
Subject: [PATCH] Remove deprecated IRQF_DISABLED flag entirely
Date:   Thu,  5 Mar 2015 13:59:39 +0100
Message-Id: <1425560442-13367-1-git-send-email-valentinrothberg@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <valentinrothberg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: valentinrothberg@gmail.com
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

The IRQF_DISABLED is a NOOP and has been scheduled for removal since
Linux v2.6.36 by commit 6932bf37bed4 ("genirq: Remove IRQF_DISABLED from
core code").

According to commit e58aa3d2d0cc ("genirq: Run irq handlers with
interrupts disabled") running IRQ handlers with interrupts enabled can
cause stack overflows when the interrupt line of the issuing device is
still active.

This patch ends the grace period for IRQF_DISABLED (i.e., SA_INTERRUPT
in older versions of Linux) and removes the definition and all remaining
usages of this flag.

Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
---
The bigger hunk in Documentation/scsi/ncr53c8xx.txt is removed entirely
as IRQF_DISABLED is gone now; the usage in older kernel versions
(including the old SA_INTERRUPT flag) should be discouraged.  The
trouble of using IRQF_SHARED is a general problem and not specific to
any driver.

I left the reference in Documentation/PCI/MSI-HOWTO.txt untouched since
it has already been removed in linux-next by commit b0e1ee8e1405
("MSI-HOWTO.txt: remove reference on IRQF_DISABLED").

All remaining references are changelogs that I suggest to keep.
---
 Documentation/scsi/ncr53c8xx.txt     | 25 -------------------------
 Documentation/scsi/tmscsim.txt       |  4 ----
 arch/mips/loongson/loongson-3/hpet.c |  2 +-
 drivers/block/cpqarray.c             |  4 ++--
 drivers/bus/omap_l3_noc.c            |  4 ++--
 drivers/bus/omap_l3_smx.c            | 10 ++++------
 drivers/mtd/nand/hisi504_nand.c      |  3 +--
 drivers/usb/isp1760/isp1760-core.c   |  3 +--
 drivers/usb/isp1760/isp1760-udc.c    |  4 ++--
 include/linux/interrupt.h            |  3 ---
 10 files changed, 13 insertions(+), 49 deletions(-)

diff --git a/Documentation/scsi/ncr53c8xx.txt b/Documentation/scsi/ncr53c8xx.txt
index 1d508dcbf859..8586efff1e99 100644
--- a/Documentation/scsi/ncr53c8xx.txt
+++ b/Documentation/scsi/ncr53c8xx.txt
@@ -786,7 +786,6 @@ port address 0x1400.
         irqm:1     same as initial settings (assumed BIOS settings)
         irqm:2     always totem pole
         irqm:0x10  driver will not use IRQF_SHARED flag when requesting irq
-        irqm:0x20  driver will not use IRQF_DISABLED flag when requesting irq
 
     (Bits 0x10 and 0x20 can be combined with hardware irq mode option)
 
@@ -1231,30 +1230,6 @@ they only refer to system buffers that are well aligned. So, a work around
 may only be needed under Linux when a scatter/gather list is not used and 
 when the SCSI DATA IN phase is reentered after a phase mismatch.
 
-14.5 IRQ sharing problems
-
-When an IRQ is shared by devices that are handled by different drivers, it 
-may happen that one driver complains about the request of the IRQ having 
-failed. Inder Linux-2.0, this may be due to one driver having requested the 
-IRQ using the IRQF_DISABLED flag but some other having requested the same IRQ
-without this flag. Under both Linux-2.0 and linux-2.2, this may be caused by 
-one driver not having requested the IRQ with the IRQF_SHARED flag.
-
-By default, the ncr53c8xx and sym53c8xx drivers request IRQs with both the 
-IRQF_DISABLED and the IRQF_SHARED flag under Linux-2.0 and with only the IRQF_SHARED
-flag under Linux-2.2.
-
-Under Linux-2.0, you can disable use of IRQF_DISABLED flag from the boot
-command line by using the following option:
-
-     ncr53c8xx=irqm:0x20   (for the generic ncr53c8xx driver)
-     sym53c8xx=irqm:0x20   (for the sym53c8xx driver)
-
-If this does not fix the problem, then you may want to check how all other 
-drivers are requesting the IRQ and report the problem. Note that if at least 
-a single driver does not request the IRQ with the IRQF_SHARED flag (share IRQ),
-then the request of the IRQ obviously will not succeed for all the drivers.
-
 15. SCSI problem troubleshooting
 
 15.1 Problem tracking
diff --git a/Documentation/scsi/tmscsim.txt b/Documentation/scsi/tmscsim.txt
index 0810132772a8..0e0322bf0020 100644
--- a/Documentation/scsi/tmscsim.txt
+++ b/Documentation/scsi/tmscsim.txt
@@ -107,10 +107,6 @@ produced errors and started to corrupt my disks. So don't do that! A 37.50
 MHz PCI bus works for me, though, but I don't recommend using higher clocks
 than the 33.33 MHz being in the PCI spec.
 
-If you want to share the IRQ with another device and the driver refuses to
-do so, you might succeed with changing the DC390_IRQ type in tmscsim.c to 
-IRQF_SHARED | IRQF_DISABLED.
-
 
 3.Features
 ----------
diff --git a/arch/mips/loongson/loongson-3/hpet.c b/arch/mips/loongson/loongson-3/hpet.c
index e898d68668a9..5c21cd3bd339 100644
--- a/arch/mips/loongson/loongson-3/hpet.c
+++ b/arch/mips/loongson/loongson-3/hpet.c
@@ -162,7 +162,7 @@ static irqreturn_t hpet_irq_handler(int irq, void *data)
 
 static struct irqaction hpet_irq = {
 	.handler = hpet_irq_handler,
-	.flags = IRQF_DISABLED | IRQF_NOBALANCING | IRQF_TIMER,
+	.flags = IRQF_NOBALANCING | IRQF_TIMER,
 	.name = "hpet",
 };
 
diff --git a/drivers/block/cpqarray.c b/drivers/block/cpqarray.c
index 2b9440384536..f749df9e15cd 100644
--- a/drivers/block/cpqarray.c
+++ b/drivers/block/cpqarray.c
@@ -405,8 +405,8 @@ static int cpqarray_register_ctlr(int i, struct pci_dev *pdev)
 		goto Enomem4;
 	}
 	hba[i]->access.set_intr_mask(hba[i], 0);
-	if (request_irq(hba[i]->intr, do_ida_intr,
-		IRQF_DISABLED|IRQF_SHARED, hba[i]->devname, hba[i]))
+	if (request_irq(hba[i]->intr, do_ida_intr, IRQF_SHARED,
+			hba[i]->devname, hba[i]))
 	{
 		printk(KERN_ERR "cpqarray: Unable to get irq %d for %s\n",
 				hba[i]->intr, hba[i]->devname);
diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
index 029bc73de001..11f7982cbdb3 100644
--- a/drivers/bus/omap_l3_noc.c
+++ b/drivers/bus/omap_l3_noc.c
@@ -284,7 +284,7 @@ static int omap_l3_probe(struct platform_device *pdev)
 	 */
 	l3->debug_irq = platform_get_irq(pdev, 0);
 	ret = devm_request_irq(l3->dev, l3->debug_irq, l3_interrupt_handler,
-			       IRQF_DISABLED, "l3-dbg-irq", l3);
+			       0x0, "l3-dbg-irq", l3);
 	if (ret) {
 		dev_err(l3->dev, "request_irq failed for %d\n",
 			l3->debug_irq);
@@ -293,7 +293,7 @@ static int omap_l3_probe(struct platform_device *pdev)
 
 	l3->app_irq = platform_get_irq(pdev, 1);
 	ret = devm_request_irq(l3->dev, l3->app_irq, l3_interrupt_handler,
-			       IRQF_DISABLED, "l3-app-irq", l3);
+			       0x0, "l3-app-irq", l3);
 	if (ret)
 		dev_err(l3->dev, "request_irq failed for %d\n", l3->app_irq);
 
diff --git a/drivers/bus/omap_l3_smx.c b/drivers/bus/omap_l3_smx.c
index 597fdaee7315..360a5c0a4ee0 100644
--- a/drivers/bus/omap_l3_smx.c
+++ b/drivers/bus/omap_l3_smx.c
@@ -251,18 +251,16 @@ static int omap3_l3_probe(struct platform_device *pdev)
 	}
 
 	l3->debug_irq = platform_get_irq(pdev, 0);
-	ret = request_irq(l3->debug_irq, omap3_l3_app_irq,
-		IRQF_DISABLED | IRQF_TRIGGER_RISING,
-		"l3-debug-irq", l3);
+	ret = request_irq(l3->debug_irq, omap3_l3_app_irq, IRQF_TRIGGER_RISING,
+			  "l3-debug-irq", l3);
 	if (ret) {
 		dev_err(&pdev->dev, "couldn't request debug irq\n");
 		goto err1;
 	}
 
 	l3->app_irq = platform_get_irq(pdev, 1);
-	ret = request_irq(l3->app_irq, omap3_l3_app_irq,
-		IRQF_DISABLED | IRQF_TRIGGER_RISING,
-		"l3-app-irq", l3);
+	ret = request_irq(l3->app_irq, omap3_l3_app_irq, IRQF_TRIGGER_RISING,
+			  "l3-app-irq", l3);
 	if (ret) {
 		dev_err(&pdev->dev, "couldn't request app irq\n");
 		goto err2;
diff --git a/drivers/mtd/nand/hisi504_nand.c b/drivers/mtd/nand/hisi504_nand.c
index 289ad3ac3e80..7f9f9c827c1d 100644
--- a/drivers/mtd/nand/hisi504_nand.c
+++ b/drivers/mtd/nand/hisi504_nand.c
@@ -758,8 +758,7 @@ static int hisi_nfc_probe(struct platform_device *pdev)
 
 	hisi_nfc_host_init(host);
 
-	ret = devm_request_irq(dev, irq, hinfc_irq_handle, IRQF_DISABLED,
-				"nandc", host);
+	ret = devm_request_irq(dev, irq, hinfc_irq_handle, "nandc", host);
 	if (ret) {
 		dev_err(dev, "failed to request IRQ\n");
 		goto err_res;
diff --git a/drivers/usb/isp1760/isp1760-core.c b/drivers/usb/isp1760/isp1760-core.c
index b9827556455f..5c37f40f6122 100644
--- a/drivers/usb/isp1760/isp1760-core.c
+++ b/drivers/usb/isp1760/isp1760-core.c
@@ -151,8 +151,7 @@ int isp1760_register(struct resource *mem, int irq, unsigned long irqflags,
 	}
 
 	if (IS_ENABLED(CONFIG_USB_ISP1761_UDC) && !udc_disabled) {
-		ret = isp1760_udc_register(isp, irq, irqflags | IRQF_SHARED |
-					   IRQF_DISABLED);
+		ret = isp1760_udc_register(isp, irq, irqflags | IRQF_SHARED);
 		if (ret < 0) {
 			isp1760_hcd_unregister(&isp->hcd);
 			return ret;
diff --git a/drivers/usb/isp1760/isp1760-udc.c b/drivers/usb/isp1760/isp1760-udc.c
index 9612d7990565..0b46ff01299f 100644
--- a/drivers/usb/isp1760/isp1760-udc.c
+++ b/drivers/usb/isp1760/isp1760-udc.c
@@ -1451,8 +1451,8 @@ int isp1760_udc_register(struct isp1760_device *isp, int irq,
 
 	sprintf(udc->irqname, "%s (udc)", devname);
 
-	ret = request_irq(irq, isp1760_udc_irq, IRQF_SHARED | IRQF_DISABLED |
-			  irqflags, udc->irqname, udc);
+	ret = request_irq(irq, isp1760_udc_irq, IRQF_SHARED | irqflags,
+			  udc->irqname, udc);
 	if (ret < 0)
 		goto error;
 
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index d9b05b5bf8c7..bb4ecaeb4a14 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -39,8 +39,6 @@
  * These flags used only by the kernel as part of the
  * irq handling routines.
  *
- * IRQF_DISABLED - keep irqs disabled when calling the action handler.
- *                 DEPRECATED. This flag is a NOOP and scheduled to be removed
  * IRQF_SHARED - allow sharing the irq among several devices
  * IRQF_PROBE_SHARED - set by callers when they expect sharing mismatches to occur
  * IRQF_TIMER - Flag to mark this interrupt as timer interrupt
@@ -58,7 +56,6 @@
  * IRQF_EARLY_RESUME - Resume IRQ early during syscore instead of at device
  *                resume time.
  */
-#define IRQF_DISABLED		0x00000020
 #define IRQF_SHARED		0x00000080
 #define IRQF_PROBE_SHARED	0x00000100
 #define __IRQF_TIMER		0x00000200
-- 
1.9.1
