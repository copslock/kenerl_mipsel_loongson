Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2010 23:08:35 +0100 (CET)
Received: from lo.gmane.org ([80.91.229.12]:33095 "EHLO lo.gmane.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493007Ab0ACWIc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 3 Jan 2010 23:08:32 +0100
Received: from list by lo.gmane.org with local (Exim 4.50)
        id 1NRYcf-0004q9-Tm
        for linux-mips@linux-mips.org; Sun, 03 Jan 2010 23:08:29 +0100
Received: from chipmunk.wormnet.eu ([195.195.131.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Sun, 03 Jan 2010 23:08:29 +0100
Received: from alex by chipmunk.wormnet.eu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Sun, 03 Jan 2010 23:08:29 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-mips@linux-mips.org
From:   Alexander Clouter <alex@digriz.org.uk>
Subject:  Re: [PATCH 4/4] MTD: include ar7part in the list of partitions parsers
Date:   Sun, 3 Jan 2010 21:31:46 +0000
Message-ID:  <2ve717-7pt.ln1@chipmunk.wormnet.eu>
References:  <201001032117.37459.florian@openwrt.org> <1262552177.3181.5891.camel@macbook.infradead.org>
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: chipmunk.wormnet.eu
User-Agent: tin/1.9.3-20080506 ("Dalintober") (UNIX) (Linux/2.6.26-2-sparc64-smp (sparc64))
Cc:     linux-mtd@lists.infradead.org
X-archive-position: 25491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2019

In gmane.linux.drivers.mtd David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Sun, 2010-01-03 at 21:17 +0100, Florian Fainelli wrote:
>> This patch modifies the physmap-flash driver to include
>> the ar7part partition parser in the list of parsers to
>> use when a physmap-flash driver is registered. This is
>> required for AR7 to create partitions correctly.
> 
> Hrm, perhaps we'd do better to allow the probe types to be specified in
> the platform physmap_flash_data?
> 
I am not completely convinced the ar7part approach is the best way as 
you are:
 1) not actually reading a partition table and instead using a bunch of 
	'magic' values to try to work out the partition layout
 2) it bears no resemble to what is seen by the ADAM2 bootloader
 3) regardless of whether you would actually want to, the user is unable 
	to amend the partition table and have Linux automagically set 
	the table apprioately

I chatted with Florian a while back about this but we never continued 
with it (Real Life[tm] seemed to get in the way) but I had cobbled the 
following together:
----
diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index e2278c0..df33fea 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -24,6 +24,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/physmap.h>
+#include <linux/mtd/partitions.h>
 #include <linux/serial.h>
 #include <linux/serial_8250.h>
 #include <linux/ioport.h>
@@ -467,6 +468,60 @@ static void cpmac_get_mac(int instance, unsigned char *dev_addr)
 			char2hex(mac[i * 3 + 1]);
 }
 
+static void __init detect_partitions(void)
+{
+	unsigned int i, start, end;
+	int ret;
+	char mtdenv[5], *buf;
+
+	for (physmap_flash_data.nr_parts = 0;
+			physmap_flash_data.nr_parts < 10;
+			physmap_flash_data.nr_parts++) {
+		sprintf(mtdenv, "mtd%d", physmap_flash_data.nr_parts);
+		if (!prom_getenv(mtdenv))
+			break;
+	}
+
+	if (physmap_flash_data.nr_parts == 0) {
+		printk(KERN_INFO "No partitions found for physmap MTD\n");
+		return;
+	}
+	if (physmap_flash_data.nr_parts == 10)
+		printk(KERN_INFO "Reached nr_parts limit for physmap MTD\n");
+
+	physmap_flash_data.parts = kzalloc(
+			sizeof(struct mtd_partition)*physmap_flash_data.nr_parts,
+			GFP_KERNEL);
+	if (!physmap_flash_data.parts) {
+		printk(KERN_ERR "Unable to alloc physmap MTD parts struct\n");
+		return;
+	}
+
+	for (i = 0; i < physmap_flash_data.nr_parts; i++) {
+		sprintf(mtdenv, "mtd%d", i);
+		buf = prom_getenv(mtdenv);
+
+		ret = sscanf(buf, "%x,%x", &start, &end);
+		if (ret != 2 || start < 0x90000000 || start > 0x90400000
+				|| end < 0x90000000 || end > 0x90400000
+				|| start > end) {
+			printk(KERN_WARNING "broken partition table for physmap\n");
+			kfree(physmap_flash_data.parts);
+			physmap_flash_data.parts = NULL;
+			physmap_flash_data.nr_parts = 0;
+			return;
+		}
+
+		start -= 0x90000000;
+		end -= 0x90000000;
+
+		physmap_flash_data.parts[i].name	= NULL;
+		physmap_flash_data.parts[i].size	= end - start;
+		physmap_flash_data.parts[i].offset	= start;
+		physmap_flash_data.parts[i].mask_flags	= MTD_WRITEABLE;
+	}
+}
+
 static void __init detect_leds(void)
 {
 	char *prid, *usb_prod;
@@ -536,6 +591,7 @@ static int __init ar7_register_devices(void)
 			return res;
 	}
 #endif /* CONFIG_SERIAL_8250 */
+	detect_partitions();
 	res = platform_device_register(&physmap_flash);
 	if (res)
 		return res;
----

It simply pulls apart the 'PROM' (aka ADAM2) config and uses that to 
build the partition table.

Work's For Me[tm].

Just my thoughts.

Cheers

-- 
Alexander Clouter
.sigmonster says: BOFH excuse #12:
                  dry joints on cable plug
