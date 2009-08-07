Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2009 23:49:15 +0200 (CEST)
Received: from ey-out-1920.google.com ([74.125.78.145]:53606 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492977AbZHGVrn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Aug 2009 23:47:43 +0200
Received: by ey-out-1920.google.com with SMTP id 13so537975eye.54
        for <multiple recipients>; Fri, 07 Aug 2009 14:47:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Px22Q6iqwDoHgBJdPMiyxCqR2WKiWyEYIR0VCsjgUvU=;
        b=UjtGTeg+FEyN8+6EKsYWS0iUe+85Vu/tEIIP10TUFjzmHt3S8RtivYKVcKmVPELMnb
         N5A1u7m/SH76hmAJnInaiz/CJVLgvlmgXWdgMxXcqPD1+2pXc29fn9YwMJTRzOSN9Mdm
         xJ5woAm2BoC5R0KJCgfMHIokRhQ/EYX6+Xgwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=nVDiXjdmxzr0JLHJQdIaIAN4Knm0HaC/fF95/CvSQN9G16ssvwAMfDw4Mhj5mFjQfz
         eIXYksYeSoHI8DcUOGoJkVP26wLtCK5KlJf1DO3lwUo3AbdYsjP7lS4ZGjIZ6Y7tWgqS
         Wd6sUOPyvaSsWlK/SShFg1nX73ZE0Bh4p+ViA=
Received: by 10.210.102.9 with SMTP id z9mr1999060ebb.16.1249681661990;
        Fri, 07 Aug 2009 14:47:41 -0700 (PDT)
Received: from lenovo.mimichou.home (home.mimichou.net [82.67.132.19])
        by mx.google.com with ESMTPS id 28sm4262227eyg.52.2009.08.07.14.47.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Aug 2009 14:47:41 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Fri, 7 Aug 2009 23:47:04 +0200
Subject: [PATCH 7/8] bcm63xx: add basic support for bcm96345gw2 design
MIME-Version: 1.0
X-UID:	1184
X-Length: 2925
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Maxime Bizon <mbizon@freebox.fr>, linux-mips@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908072347.04899.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23858
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch adds basic support for the bcm96345gw2 reference
design (e.g: Siemens SE515) and make it boot up to user-space.
Integrated peripherals support needs some more work.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index e639438..17a8636 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -124,6 +124,16 @@ static struct board_info __initdata board_96338w = {
 #endif
 
 /*
+ * known 6345 boards
+ */
+#ifdef CONFIG_BCM63XX_CPU_6345
+static struct board_info __initdata board_96345gw2 = {
+	.name				= "96345GW2",
+	.expected_cpu_id		= 0x6345,
+};
+#endif
+
+/*
  * known 6348 boards
  */
 #ifdef CONFIG_BCM63XX_CPU_6348
@@ -536,6 +546,9 @@ static const struct board_info __initdata *bcm963xx_boards[] = {
 	&board_96338gw,
 	&board_96338w,
 #endif
+#ifdef CONFIG_BCM63XX_CPU_6345
+	&board_96345gw2,
+#endif
 #ifdef CONFIG_BCM63XX_CPU_6348
 	&board_96348r,
 	&board_96348gw,
@@ -562,10 +575,16 @@ void __init board_prom_init(void)
 	u8 *boot_addr, *cfe, *p;
 	char cfe_version[32];
 	u32 val;
-
-	/* read base address of boot chip select (0) */
-	val = bcm_mpi_readl(MPI_CSBASE_REG(0));
-	val &= MPI_CSBASE_BASE_MASK;
+	
+	/* read base address of boot chip select (0) 
+	 * 6345 does not have MPI but boots from standard
+	 * MIPS Flash address */
+	if (BCMCPU_IS_6345())
+		val = 0x1fc00000;
+	else {
+		val = bcm_mpi_readl(MPI_CSBASE_REG(0));
+		val &= MPI_CSBASE_BASE_MASK;
+	}
 	boot_addr = (u8 *)KSEG1ADDR(val);
 
 	/* dump cfe version */
@@ -812,8 +831,12 @@ int __init board_register_devices(void)
 #endif
 
 	/* read base address of boot chip select (0) */
-	val = bcm_mpi_readl(MPI_CSBASE_REG(0));
-	val &= MPI_CSBASE_BASE_MASK;
+	if (BCMCPU_IS_6345())
+		val = 0x1fc00000;
+	else {
+		val = bcm_mpi_readl(MPI_CSBASE_REG(0));
+		val &= MPI_CSBASE_BASE_MASK;
+	}
 	mtd_resources[0].start = val;
 	mtd_resources[0].end = 0x1FFFFFFF;
 
