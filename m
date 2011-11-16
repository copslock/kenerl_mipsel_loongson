Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 20:11:34 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:38604 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903844Ab1KPTLF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Nov 2011 20:11:05 +0100
Received: by mail-wy0-f177.google.com with SMTP id 21so1101328wyh.36
        for <multiple recipients>; Wed, 16 Nov 2011 11:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=TEd6S5VxNgbZAnO0EvVIQe78Fj0JE5zjfrXH5vlHNME=;
        b=erWDqOloDEPi+9PeNEEuczX1aBmDkMlgcEuvY5PpZiaks7OVGmCfWZh3OC601HMb6J
         Ys/ug10NQykmT2qxV1WreXB36xMXVtqi0g8i7+eR6VZQ7/TX1PROBPKeYchklbyHQbVX
         1zV/4dTjuakf1c5xfLI23E97s0qPivOqMZ8pg=
Received: by 10.227.199.147 with SMTP id es19mr9487642wbb.15.1321470665656;
        Wed, 16 Nov 2011 11:11:05 -0800 (PST)
Received: from lenovo.localnet ([2a01:e35:2f70:4010:21d:7dff:fe45:5399])
        by mx.google.com with ESMTPS id et20sm33789986wbb.15.2011.11.16.11.11.03
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Nov 2011 11:11:04 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 2/3 v2] MIPS: BCM63xx: remove BCM6345 hacks to read base boot address
Date:   Wed, 16 Nov 2011 20:11:12 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.0-rc7-amd64; KDE/4.6.5; x86_64; ; )
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201111162011.12218.florian@openwrt.org>
X-archive-position: 31683
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13734

Though BCM6345 does not technically have the same MPI register layout
than the other SoCs, reading the chip-select registers is done the same
way, and particularly for chip-select 0, which is the boot flash.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes since v1:
- rebase against mips-for-linux-next
- folded patch 3 and 4 together

diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 40b223b..ac948c2 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -709,15 +709,9 @@ void __init board_prom_init(void)
 	char cfe_version[32];
 	u32 val;
 
-	/* read base address of boot chip select (0)
-	 * 6345 does not have MPI but boots from standard
-	 * MIPS Flash address */
-	if (BCMCPU_IS_6345())
-		val = 0x1fc00000;
-	else {
-		val = bcm_mpi_readl(MPI_CSBASE_REG(0));
-		val &= MPI_CSBASE_BASE_MASK;
-	}
+	/* read base address of boot chip select (0) */
+	val = bcm_mpi_readl(MPI_CSBASE_REG(0));
+	val &= MPI_CSBASE_BASE_MASK;
 	boot_addr = (u8 *)KSEG1ADDR(val);
 
 	/* dump cfe version */
@@ -893,12 +887,9 @@ int __init board_register_devices(void)
 		bcm63xx_dsp_register(&board.dsp);
 
 	/* read base address of boot chip select (0) */
-	if (BCMCPU_IS_6345())
-		val = 0x1fc00000;
-	else {
-		val = bcm_mpi_readl(MPI_CSBASE_REG(0));
-		val &= MPI_CSBASE_BASE_MASK;
-	}
+	val = bcm_mpi_readl(MPI_CSBASE_REG(0));
+	val &= MPI_CSBASE_BASE_MASK;
+
 	mtd_resources[0].start = val;
 	mtd_resources[0].end = 0x1FFFFFFF;
 
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index 23403a3..5b8d15b 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -215,7 +215,7 @@ enum bcm63xx_regs_set {
 #define BCM_6345_ENETDMAS_BASE		(0xfffe2a00)
 #define BCM_6345_ENETSW_BASE		(0xdeadbeef)
 #define BCM_6345_PCMCIA_BASE		(0xfffe2028)
-#define BCM_6345_MPI_BASE		(0xdeadbeef)
+#define BCM_6345_MPI_BASE		(0xfffe2000)
 #define BCM_6345_OHCI0_BASE		(0xfffe2100)
 #define BCM_6345_OHCI_PRIV_BASE		(0xfffe2200)
 #define BCM_6345_USBH_PRIV_BASE		(0xdeadbeef)
-- 
1.7.5.4
