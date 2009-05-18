Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 May 2009 23:06:27 +0100 (BST)
Received: from smtp2-g21.free.fr ([212.27.42.2]:47771 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20024426AbZERWGV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 18 May 2009 23:06:21 +0100
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 124C34B00AC;
	Tue, 19 May 2009 00:06:15 +0200 (CEST)
Received: from [192.168.1.189] (cac94-1-81-57-151-96.fbx.proxad.net [81.57.151.96])
	by smtp2-g21.free.fr (Postfix) with ESMTP id BFFEF4B005A;
	Tue, 19 May 2009 00:06:12 +0200 (CEST)
Message-ID: <4A11DBD4.7070706@free.fr>
Date:	Tue, 19 May 2009 00:06:12 +0200
From:	matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.19) Gecko/20081204 Iceape/1.1.14 (Debian-1.1.14-1)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org, Michael Buesch <mb@bu3sch.de>,
	netdev@vger.kernel.org
CC:	Daniel Mueller <daniel@danm.de>
Subject: [PATCH] bc47xx : fix ssb irq setup
Content-Type: multipart/mixed;
 boundary="------------070905000205050605070600"
Return-Path: <castet.matthieu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: castet.matthieu@free.fr
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------070905000205050605070600
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

the current ssb irq setup (in ssb_mipscore_init) have some problem :
it configure some device on some irq without checking that the irq is 
not taken by an other device.

For example in my case PCI host is on irq 0 and IPSEC on irq 3.
The current code :
- store in dev->irq that IPSEC irq is 3+2
- do a set_irq 0->3 on PCI host

But now IPSEC irq is not routed anymore to the mips code and dev->irq is 
wrong. This cause problem described in [1].

This patch try to solve the problem by making set_irq configure the 
device we want to take the irq on the shared irq0.
The previous example become :
- store in dev->irq that IPSEC irq is 3+2
- do a set_irq 0->3 on PCI host :
   - irq 3 is already taken by IPSEC. do a set_irq 3->0 on IPSEC


I also added some code to print the irq configuration before and after 
irq setup to allow easier debugging. And I add extra checking in 
ssb_mips_irq to report device without irq or device with not routed irq.


[1] http://www.danm.de/files/src/bcm5365p/REPORTED_DEVICES

Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>

--------------070905000205050605070600
Content-Type: text/x-diff;
 name="bcm47xx_fix_irq_setup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bcm47xx_fix_irq_setup.diff"

diff --git a/drivers/ssb/driver_mipscore.c b/drivers/ssb/driver_mipscore.c
index 3fd3e3b..6acf43f 100644
--- a/drivers/ssb/driver_mipscore.c
+++ b/drivers/ssb/driver_mipscore.c
@@ -49,29 +49,54 @@ static const u32 ipsflag_irq_shift[] = {
 
 static inline u32 ssb_irqflag(struct ssb_device *dev)
 {
-	return ssb_read32(dev, SSB_TPSFLAG) & SSB_TPSFLAG_BPFLAG;
+	u32 tpsflag = ssb_read32(dev, SSB_TPSFLAG);
+	if (tpsflag)
+		return ssb_read32(dev, SSB_TPSFLAG) & SSB_TPSFLAG_BPFLAG;
+	else
+		/* not irq supported */
+		return 0x3f;
+}
+
+static struct ssb_device *find_device(struct ssb_device *rdev, int irqflag)
+{
+	struct ssb_bus *bus = rdev->bus;
+	int i;
+	for (i = 0; i < bus->nr_devices; i++) {
+		struct ssb_device *dev;
+		dev = &(bus->devices[i]);
+		if (ssb_irqflag(dev) == irqflag)
+			return dev;
+	}
+	return NULL;
 }
 
 /* Get the MIPS IRQ assignment for a specified device.
  * If unassigned, 0 is returned.
+ * If disabled, 5 is returned.
+ * If not supported, 6 is returned.
  */
 unsigned int ssb_mips_irq(struct ssb_device *dev)
 {
 	struct ssb_bus *bus = dev->bus;
+	struct ssb_device *mdev = bus->mipscore.dev;
 	u32 irqflag;
 	u32 ipsflag;
 	u32 tmp;
 	unsigned int irq;
 
 	irqflag = ssb_irqflag(dev);
+	if (irqflag == 0x3f)
+		return 6;
 	ipsflag = ssb_read32(bus->mipscore.dev, SSB_IPSFLAG);
 	for (irq = 1; irq <= 4; irq++) {
 		tmp = ((ipsflag & ipsflag_irq_mask[irq]) >> ipsflag_irq_shift[irq]);
 		if (tmp == irqflag)
 			break;
 	}
-	if (irq	== 5)
-		irq = 0;
+	if (irq	== 5) {
+		if ((1 << irqflag) & ssb_read32(mdev, SSB_INTVEC))
+			irq = 0;
+	}
 
 	return irq;
 }
@@ -97,25 +122,56 @@ static void set_irq(struct ssb_device *dev, unsigned int irq)
 	struct ssb_device *mdev = bus->mipscore.dev;
 	u32 irqflag = ssb_irqflag(dev);
 
+	BUG_ON(oldirq == 6);
+
 	dev->irq = irq + 2;
 
-	ssb_dprintk(KERN_INFO PFX
-		    "set_irq: core 0x%04x, irq %d => %d\n",
-		    dev->id.coreid, oldirq, irq);
 	/* clear the old irq */
 	if (oldirq == 0)
 		ssb_write32(mdev, SSB_INTVEC, (~(1 << irqflag) & ssb_read32(mdev, SSB_INTVEC)));
-	else
+	else if (oldirq != 5)
 		clear_irq(bus, oldirq);
 
 	/* assign the new one */
 	if (irq == 0) {
 		ssb_write32(mdev, SSB_INTVEC, ((1 << irqflag) | ssb_read32(mdev, SSB_INTVEC)));
 	} else {
+		u32 ipsflag = ssb_read32(mdev, SSB_IPSFLAG);
+		if ((ipsflag & ipsflag_irq_mask[irq]) != ipsflag_irq_mask[irq]) {
+			u32 oldipsflag = (ipsflag & ipsflag_irq_mask[irq]) >> ipsflag_irq_shift[irq];
+			struct ssb_device *olddev = find_device(dev, oldipsflag);
+			if (olddev)
+				set_irq(olddev, 0);
+		}
 		irqflag <<= ipsflag_irq_shift[irq];
-		irqflag |= (ssb_read32(mdev, SSB_IPSFLAG) & ~ipsflag_irq_mask[irq]);
+		irqflag |= (ipsflag & ~ipsflag_irq_mask[irq]);
 		ssb_write32(mdev, SSB_IPSFLAG, irqflag);
 	}
+	ssb_dprintk(KERN_INFO PFX
+		    "set_irq: core 0x%04x, irq %d => %d\n",
+		    dev->id.coreid, oldirq+2, irq+2);
+}
+
+static void print_irq(struct ssb_device *dev, unsigned int irq)
+{
+	int i;
+	static const char *irq_name[] = {"2(S)", "3", "4", "5", "6", "D", "I"};
+	ssb_dprintk(KERN_INFO PFX
+		"core 0x%04x, irq :", dev->id.coreid);
+	for (i = 0; i <= 6; i++) {
+		ssb_dprintk(" %s%s", irq_name[i], i==irq?"*":" ");
+	}
+	ssb_dprintk("\n");
+}
+
+static void dump_irq(struct ssb_bus *bus)
+{
+	int i;
+	for (i = 0; i < bus->nr_devices; i++) {
+		struct ssb_device *dev;
+		dev = &(bus->devices[i]);
+		print_irq(dev, ssb_mips_irq(dev));
+	}
 }
 
 static void ssb_mips_serial_init(struct ssb_mipscore *mcore)
@@ -195,18 +251,26 @@ void ssb_mipscore_init(struct ssb_mipscore *mcore)
 	else if (bus->chipco.dev)
 		ssb_chipco_timing_init(&bus->chipco, ns);
 
+	dump_irq(bus);
 	/* Assign IRQs to all cores on the bus, start with irq line 2, because serial usually takes 1 */
 	for (irq = 2, i = 0; i < bus->nr_devices; i++) {
+		int mips_irq;
 		dev = &(bus->devices[i]);
-		dev->irq = ssb_mips_irq(dev) + 2;
+		mips_irq = ssb_mips_irq(dev);
+		if (mips_irq > 4)
+			dev->irq = 0;
+		else
+			dev->irq = mips_irq + 2;
+		if (dev->irq > 5)
+			continue;
 		switch (dev->id.coreid) {
 		case SSB_DEV_USB11_HOST:
 			/* shouldn't need a separate irq line for non-4710, most of them have a proper
 			 * external usb controller on the pci */
 			if ((bus->chip_id == 0x4710) && (irq <= 4)) {
 				set_irq(dev, irq++);
-				break;
 			}
+			break;
 			/* fallthrough */
 		case SSB_DEV_PCI:
 		case SSB_DEV_ETHERNET:
@@ -220,6 +284,8 @@ void ssb_mipscore_init(struct ssb_mipscore *mcore)
 			}
 		}
 	}
+	ssb_dprintk(KERN_INFO PFX "after irq reconfiguration\n");
+	dump_irq(bus);
 
 	ssb_mips_serial_init(mcore);
 	ssb_mips_flash_detect(mcore);

--------------070905000205050605070600--
