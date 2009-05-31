Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 May 2009 19:28:17 +0100 (BST)
Received: from mail-ew0-f219.google.com ([209.85.219.219]:39344 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024228AbZEaS2L (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 31 May 2009 19:28:11 +0100
Received: by ewy19 with SMTP id 19so7633111ewy.0
        for <multiple recipients>; Sun, 31 May 2009 11:28:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=IQvyFw90SUlQ7XfsJhx5cwtDccuu+jwd2d7cWAn+FH0=;
        b=kThD/C2R6WFnDMBSe6ZhAU2SE1kEATRl+zEH6bGG6sKuli/OCfSEMd6FvZ3xUcBfl8
         uqAaVAND8x7oGWb17yUD8DYsJGdWYmOtsVgDQisYJERlQ0mAhhtxc4OmKaVfAXozQ7Dx
         CdmDgia/DPmHaNk9a08Oa6VBhY2AayADlDPgk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=vZ2vwmz4CqPwrmgpK7cKVvvOOKiHLNcNFp/VJUPqiRIAo8AX1N47og2bhCV5FConyo
         nDvpSZATysgNi8lm06QCm2ywM5cltBqaG0utJPxd7uAEeDHyRbp1BeDWqDSuPtYBnAST
         TaOW6sAY96qH8lKD8SLZUaVsarIOpfzLVMhGM=
Received: by 10.210.13.17 with SMTP id 17mr5366999ebm.6.1243794485767;
        Sun, 31 May 2009 11:28:05 -0700 (PDT)
Received: from ?192.168.1.20? (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 24sm6235739eyx.13.2009.05.31.11.28.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 May 2009 11:28:05 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Sun, 31 May 2009 20:28:02 +0200
Subject: [PATCH 04/10] bcm63xx: register a fallback SPROM require for b43 to work
MIME-Version: 1.0
X-UID:	136
X-Length: 3459
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Maxime Bizon <mbizon@freebox.fr>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905312028.02939.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

In order to get b43 working, we have to register a SPROM
which provides sane values to calibrate the radio, provide
GPIO settings and country code. The SSB bus is initialized
when the PCI bus is registered and expects to find the
SPROM at init time. Thus we have to move our device
registration from device_initcall to arch_initcall. The rationale
behind this comes from Broadcom not providing on-chip
EEPROM to store such settings, but relying on the main
system Flash to provide them by software means.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 7b93fb8..78a40e7 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -14,6 +14,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
+#include <linux/ssb/ssb.h>
 #include <asm/addrspace.h>
 #include <bcm63xx_board.h>
 #include <bcm63xx_cpu.h>
@@ -459,6 +460,31 @@ static struct platform_device mtd_dev = {
 };
 
 /*
+ * Register a sane SPROMv2 to make the on-board
+ * bcm4318 WLAN work
+ */
+static struct ssb_sprom bcm63xx_sprom = {
+	.revision		= 0x02,
+	.board_rev		= 0x17,
+	.country_code		= 0x0,
+	.ant_available_bg 	= 0x3,
+	.pa0b0			= 0x15ae,
+	.pa0b1			= 0xfa85,
+	.pa0b2			= 0xfe8d,
+	.pa1b0			= 0xffff,
+	.pa1b1			= 0xffff,
+	.pa1b2			= 0xffff,
+	.gpio0			= 0xff,
+	.gpio1			= 0xff,
+	.gpio2			= 0xff,
+	.gpio3			= 0xff,
+	.maxpwr_bg		= 0x004c,
+	.itssi_bg		= 0x00,
+	.boardflags_lo		= 0x2848,
+	.boardflags_hi		= 0x0000,
+};
+
+/*
  * third stage init callback, register all board devices.
  */
 int __init board_register_devices(void)
@@ -484,6 +510,14 @@ int __init board_register_devices(void)
 	if (board.has_ehci0)
 		bcm63xx_ehci_register();
 
+	/* Generate MAC address for WLAN and
+	 * register our SPROM */
+	if (!board_get_mac_address(bcm63xx_sprom.il0mac)) {
+		memcpy(bcm63xx_sprom.et0mac, bcm63xx_sprom.il0mac, ETH_ALEN);
+		memcpy(bcm63xx_sprom.et1mac, bcm63xx_sprom.il0mac, ETH_ALEN);
+		if (ssb_arch_set_fallback_sprom(&bcm63xx_sprom) < 0)
+			printk(KERN_ERR "failed to register fallback SPROM\n");
+	}
 
 	/* read base address of boot chip select (0) */
 	val = bcm_mpi_readl(MPI_CSBASE_REG(0));
diff --git a/arch/mips/bcm63xx/setup.c b/arch/mips/bcm63xx/setup.c
index f3256a8..b18a0ca 100644
--- a/arch/mips/bcm63xx/setup.c
+++ b/arch/mips/bcm63xx/setup.c
@@ -122,4 +122,4 @@ int __init bcm63xx_register_devices(void)
 	return board_register_devices();
 }
 
-device_initcall(bcm63xx_register_devices);
+arch_initcall(bcm63xx_register_devices);
