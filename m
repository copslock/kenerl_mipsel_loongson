Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Aug 2009 22:14:55 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:34758 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493219AbZHDUOs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Aug 2009 22:14:48 +0200
Received: by ewy12 with SMTP id 12so5329413ewy.0
        for <multiple recipients>; Tue, 04 Aug 2009 13:14:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ZCiccbw7UyLTYrhvCl/Kv9USpi6cQ5rZ44Hk2b8R2QY=;
        b=c7BLSqMC9zEoYI091fpEY+v5vemvV/OlBR3XkTBE4fTA2doo1NvoXnqeCoCMcQwCOJ
         H3lF5VR9P3TYAuCaZ8z7tsZPbmNwIjlrEsW1FlST7nO7jbNdyJKrV9n/SX7bxiTwYKcg
         km9QtS0imSv90S9hmrDzldjOMkd7CVCm+PjNw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=eViOqueMecAqgmqCUCs1wz51Tpw1o5i1QZzQLeD8xWoqeeOBqdHpAgY2CMgYNFzJpi
         0sx+PNn5CL4+9hLFYFk0X4rKRlQYZOE4nxNzpyuGlkCGWhcL9I3+4/dtNEXtTTeH2+Dq
         +daoglAugWPM9Ieq8bTi1R3apwzvANS2UI7VE=
Received: by 10.210.65.16 with SMTP id n16mr7142980eba.78.1249416882553;
        Tue, 04 Aug 2009 13:14:42 -0700 (PDT)
Received: from florian (135.87.196-77.rev.gaoland.net [77.196.87.135])
        by mx.google.com with ESMTPS id 28sm3074920eye.44.2009.08.04.13.14.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Aug 2009 13:14:41 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Tue, 4 Aug 2009 22:14:39 +0200
Subject: [PATCH] bcm63xx: fix build failures when CONFIG_PCI is disabled
MIME-Version: 1.0
X-UID:	1112
X-Length: 3103
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908042214.39866.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch fixes multiple build failures when CONFIG_PCI
is disabled. Since bcm63xx_sprom depends on CONFIG_SSB_PCIHOST
to be set, which depends on CONFIG_PCI, bcm63xx_sprom
would be unused thus causing this direct warning treated
as an error:

cc1: warnings being treated as errors
arch/mips/bcm63xx/boards/board_bcm963xx.c:466: warning: 'bcm63xx_sprom' defined but not used

Then bcm63xx_pci_enabled would not be resolved since it
is declared in arch/mips/pci/pci-bcm63xx.c which is not
compiled due to CONFIG_PCI being disabled. Finally,
ssb_set_arch_fallback would not be resolved too, since
CONFIG_SSB_PCIHOST is disabled.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 5add08b..683873d 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -344,11 +344,13 @@ void __init board_prom_init(void)
 	 * inside arch_initcall */
 	val = 0;
 
+#ifdef CONFIG_PCI
 	if (board.has_pci) {
 		bcm63xx_pci_enabled = 1;
 		if (BCMCPU_IS_6348())
 			val |= GPIO_MODE_6348_G2_PCI;
 	}
+#endif
 
 	if (board.has_pccard) {
 		if (BCMCPU_IS_6348())
@@ -463,6 +465,7 @@ static struct platform_device mtd_dev = {
  * Register a sane SPROMv2 to make the on-board
  * bcm4318 WLAN work
  */
+#ifdef CONFIG_SSB_PCIHOST
 static struct ssb_sprom bcm63xx_sprom = {
 	.revision		= 0x02,
 	.board_rev		= 0x17,
@@ -483,6 +486,7 @@ static struct ssb_sprom bcm63xx_sprom = {
 	.boardflags_lo		= 0x2848,
 	.boardflags_hi		= 0x0000,
 };
+#endif
 
 /*
  * third stage init callback, register all board devices.
@@ -512,12 +516,14 @@ int __init board_register_devices(void)
 
 	/* Generate MAC address for WLAN and
 	 * register our SPROM */
+#ifdef CONFIG_SSB_PCIHOST
 	if (!board_get_mac_address(bcm63xx_sprom.il0mac)) {
 		memcpy(bcm63xx_sprom.et0mac, bcm63xx_sprom.il0mac, ETH_ALEN);
 		memcpy(bcm63xx_sprom.et1mac, bcm63xx_sprom.il0mac, ETH_ALEN);
 		if (ssb_arch_set_fallback_sprom(&bcm63xx_sprom) < 0)
 			printk(KERN_ERR "failed to register fallback SPROM\n");
 	}
+#endif
 
 	/* read base address of boot chip select (0) */
 	val = bcm_mpi_readl(MPI_CSBASE_REG(0));
