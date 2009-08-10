Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Aug 2009 21:43:11 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:43230 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493404AbZHJTnF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 10 Aug 2009 21:43:05 +0200
Received: by ewy12 with SMTP id 12so3914001ewy.0
        for <multiple recipients>; Mon, 10 Aug 2009 12:43:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=cw3xRnjTmFmgNUYqydMzXzY1c+waWOJI+0an7fNi2fM=;
        b=M6rzJGlIY6pUcxY5vGUBxnBhjZZHyvXgtMDOLYBPXb4/nBa3yduufPDUDzlXPiu0ml
         RRpEQEap7G7DKPn7dlj9+1afVE/IiDpwPCIT3jDhPcQyvjXxE//C6scggt8vhVwd0lk4
         zooBZRicLMOimbV/KdxEoH34f6fPTGMNJNwkk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=QmosTIUgr+1JrwpJh9Y6u1IhIW3Z2VTpMo3Frp3rCLLa94trYN4Leg2ry8xc8Reeeb
         AIreAulOyq2qESio7dXWXSruWToJEjE8kivgyNbMqn5w2kSgRSf7dAiuCs7hOlKbAoVP
         pdL35noCVQ5NvzIFVlIgcLvkj0Exa6PuwVIw0=
Received: by 10.210.86.1 with SMTP id j1mr5417239ebb.27.1249933380035;
        Mon, 10 Aug 2009 12:43:00 -0700 (PDT)
Received: from lenovo.mimichou.home (florian.mimichou.net [82.241.112.26])
        by mx.google.com with ESMTPS id 28sm199482eye.54.2009.08.10.12.42.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Aug 2009 12:42:58 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Mon, 10 Aug 2009 21:42:54 +0200
Subject: [PATCH 1/2] bcm63xx: make bcm63xx_uart_register an initfunc
MIME-Version: 1.0
X-UID:	1206
X-Length: 2926
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908102142.56610.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23884
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch removes the calls to bcm63xx_uart_register in
board_bcm963xx.c and make bcm63xx_uart_register an initfunc.
Allows us to remove bcm63xx_dev_uart.h which was there to
make checkpatch.pl happy. Tested on my Tecom GW6x00.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 17a8636..1d56ef6 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -22,7 +22,6 @@
 #include <bcm63xx_io.h>
 #include <bcm63xx_board.h>
 #include <bcm63xx_dev_pci.h>
-#include <bcm63xx_dev_uart.h>
 #include <bcm63xx_dev_enet.h>
 #include <bcm63xx_dev_pcmcia.h>
 #include <bcm63xx_dev_usb_ohci.h>
@@ -797,8 +796,6 @@ int __init board_register_devices(void)
 {
 	u32 val;
 
-	bcm63xx_uart_register();
-
 	if (board.has_pccard)
 		bcm63xx_pcmcia_register();
 
diff --git a/arch/mips/bcm63xx/dev-uart.c b/arch/mips/bcm63xx/dev-uart.c
index 5f3d89c..b051946 100644
--- a/arch/mips/bcm63xx/dev-uart.c
+++ b/arch/mips/bcm63xx/dev-uart.c
@@ -10,7 +10,6 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <bcm63xx_cpu.h>
-#include <bcm63xx_dev_uart.h>
 
 static struct resource uart_resources[] = {
 	{
@@ -39,3 +38,4 @@ int __init bcm63xx_uart_register(void)
 	uart_resources[1].start = bcm63xx_get_irq_number(IRQ_UART0);
 	return platform_device_register(&bcm63xx_uart_device);
 }
+arch_initcall(bcm63xx_uart_register);
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_uart.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_uart.h
deleted file mode 100644
index bf348f5..0000000
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_uart.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef BCM63XX_DEV_UART_H_
-#define BCM63XX_DEV_UART_H_
-
-int bcm63xx_uart_register(void);
-
-#endif /* BCM63XX_DEV_UART_H_ */
