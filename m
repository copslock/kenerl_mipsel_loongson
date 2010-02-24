Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2010 17:39:38 +0100 (CET)
Received: from mail-fx0-f225.google.com ([209.85.220.225]:38948 "EHLO
        mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492457Ab0BXQje (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Feb 2010 17:39:34 +0100
Received: by fxm25 with SMTP id 25so500480fxm.27
        for <linux-mips@linux-mips.org>; Wed, 24 Feb 2010 08:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=PuOoGWcjj2WrPNN5q9jGg+UE5RkLQJdvndSYhWZrK1s=;
        b=WZu+s687zkgPRY8SwYqV2RyRMnEvh5yhqr1ui9ezSMAj6FK4yoPOqW6cDY5ROKIHCJ
         ayGgNhv+o/4EPeFKACU0wc67OyXDpArVekPxPOzm7+x+NGT3YR9EurIvEqwMo249Im6n
         NJyHjKEnBLspzlFmeTghTSwyZGqbv1inZvpN8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=M9MbD/KtcC7TaShhO/89SwIdlXlDLyx/nsQnjrX6pdGvV9CpI1U5ZjV7OHCkJN4QaV
         hCUcWPSHwg0plGlBVR7erRoC1/Kn9daISeKXidhFMlzXiv3DWPqBBaV6J5Xk+99bjH8s
         ncvF+8AM7OVK3z867GyxgSmHmdhdOkTqnNUks=
Received: by 10.87.44.4 with SMTP id w4mr313425fgj.73.1267029566922;
        Wed, 24 Feb 2010 08:39:26 -0800 (PST)
Received: from localhost.localdomain (p5496C63A.dip.t-dialin.net [84.150.198.58])
        by mx.google.com with ESMTPS id 3sm541357fge.21.2010.02.24.08.39.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 08:39:25 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH -queue v3] MIPS: Alchemy: use 36bit addresses for PCMCIA resources.
Date:   Wed, 24 Feb 2010 17:40:21 +0100
Message-Id: <1267029621-17862-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.7.0
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Alchemy the PCMCIA area lies at the end of the chips 36bit system
bus area.  Currently, addresses at the far end of the 32bit area
are assumed to belong to the PCMCIA area and fixed up to the real
36bit address before being passed to ioremap().

A previous commit enabled 64 bit physical size for the resource
datatype on Alchemy and this allows to use the correct
36bit addresses when registering the PCMCIA sockets.

This patch removes the 32-to-36bit address fixup and registers the
Alchemy demoboard pcmcia socket with the correct 36bit physical
addresses.

Tested on DB1200, with a CF card (ide-cs driver) and a 3c589 pcmcia
ethernet card.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
v3: also fixup xxs1500 and old au1000_generic socket driver code
v2: __fixup_bigphys_addr() is now only required for PCI

 arch/mips/alchemy/common/setup.c              |   32 +++++------------------
 arch/mips/alchemy/devboards/db1200/platform.c |   24 +++++++++---------
 arch/mips/alchemy/devboards/db1x00/platform.c |   24 +++++++++---------
 arch/mips/alchemy/devboards/pb1100/platform.c |   12 ++++----
 arch/mips/alchemy/devboards/pb1200/platform.c |   24 +++++++++---------
 arch/mips/alchemy/devboards/pb1500/platform.c |   12 ++++----
 arch/mips/alchemy/devboards/pb1550/platform.c |   24 +++++++++---------
 arch/mips/alchemy/devboards/platform.c        |   34 ++++++++++++------------
 arch/mips/alchemy/devboards/platform.h        |   12 ++++----
 arch/mips/alchemy/xxs1500/platform.c          |   18 ++++++------
 arch/mips/include/asm/mach-au1x00/au1000.h    |   14 ----------
 arch/mips/include/asm/mach-au1x00/ioremap.h   |    2 +-
 drivers/pcmcia/au1000_generic.c               |   10 +++----
 drivers/pcmcia/au1000_generic.h               |    6 ----
 drivers/pcmcia/db1xxx_ss.c                    |   25 ++++++-----------
 drivers/pcmcia/xxs1500_ss.c                   |   27 +++++++------------
 16 files changed, 123 insertions(+), 177 deletions(-)

diff --git a/arch/mips/alchemy/common/setup.c b/arch/mips/alchemy/common/setup.c
index 193ba16..561e5da 100644
--- a/arch/mips/alchemy/common/setup.c
+++ b/arch/mips/alchemy/common/setup.c
@@ -69,38 +69,20 @@ void __init plat_mem_setup(void)
 	iomem_resource.end = IOMEM_RESOURCE_END;
 }
 
-#if defined(CONFIG_64BIT_PHYS_ADDR)
+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_PCI)
 /* This routine should be valid for all Au1x based boards */
 phys_t __fixup_bigphys_addr(phys_t phys_addr, phys_t size)
 {
+	u32 start = (u32)Au1500_PCI_MEM_START;
+	u32 end   = (u32)Au1500_PCI_MEM_END;
+
 	/* Don't fixup 36-bit addresses */
 	if ((phys_addr >> 32) != 0)
 		return phys_addr;
 
-#ifdef CONFIG_PCI
-	{
-		u32 start = (u32)Au1500_PCI_MEM_START;
-		u32 end   = (u32)Au1500_PCI_MEM_END;
-
-		/* Check for PCI memory window */
-		if (phys_addr >= start && (phys_addr + size - 1) <= end)
-			return (phys_t)
-			       ((phys_addr - start) + Au1500_PCI_MEM_START);
-	}
-#endif
-
-	/*
-	 * All Au1xx0 SOCs have a PCMCIA controller.
-	 * We setup our 32-bit pseudo addresses to be equal to the
-	 * 36-bit addr >> 4, to make it easier to check the address
-	 * and fix it.
-	 * The PCMCIA socket 0 physical attribute address is 0xF 4000 0000.
-	 * The pseudo address we use is 0xF400 0000. Any address over
-	 * 0xF400 0000 is a PCMCIA pseudo address.
-	 */
-	if ((phys_addr >= PCMCIA_ATTR_PSEUDO_PHYS) &&
-	    (phys_addr < PCMCIA_PSEUDO_END))
-		return (phys_t)(phys_addr << 4);
+	/* Check for PCI memory window */
+	if (phys_addr >= start && (phys_addr + size - 1) <= end)
+		return (phys_t)((phys_addr - start) + Au1500_PCI_MEM_START);
 
 	/* default nop */
 	return phys_addr;
diff --git a/arch/mips/alchemy/devboards/db1200/platform.c b/arch/mips/alchemy/devboards/db1200/platform.c
index d6b3e64..3cb95a9 100644
--- a/arch/mips/alchemy/devboards/db1200/platform.c
+++ b/arch/mips/alchemy/devboards/db1200/platform.c
@@ -507,24 +507,24 @@ static int __init db1200_dev_init(void)
 		(void __iomem *)KSEG1ADDR(PSC1_PHYS_ADDR) + PSC_SEL_OFFSET);
 	wmb();
 
-	db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS,
-				    PCMCIA_ATTR_PSEUDO_PHYS + 0x00040000 - 1,
-				    PCMCIA_MEM_PSEUDO_PHYS,
-				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00040000 - 1,
-				    PCMCIA_IO_PSEUDO_PHYS,
-				    PCMCIA_IO_PSEUDO_PHYS   + 0x00001000 - 1,
+	db1x_register_pcmcia_socket(PCMCIA_ATTR_PHYS_ADDR,
+				    PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
+				    PCMCIA_MEM_PHYS_ADDR,
+				    PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
+				    PCMCIA_IO_PHYS_ADDR,
+				    PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
 				    DB1200_PC0_INT,
 				    DB1200_PC0_INSERT_INT,
 				    /*DB1200_PC0_STSCHG_INT*/0,
 				    DB1200_PC0_EJECT_INT,
 				    0);
 
-	db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS + 0x00400000,
-				    PCMCIA_ATTR_PSEUDO_PHYS + 0x00440000 - 1,
-				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00400000,
-				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00440000 - 1,
-				    PCMCIA_IO_PSEUDO_PHYS   + 0x00400000,
-				    PCMCIA_IO_PSEUDO_PHYS   + 0x00401000 - 1,
+	db1x_register_pcmcia_socket(PCMCIA_ATTR_PHYS_ADDR + 0x004000000,
+				    PCMCIA_ATTR_PHYS_ADDR + 0x004400000 - 1,
+				    PCMCIA_MEM_PHYS_ADDR  + 0x004000000,
+				    PCMCIA_MEM_PHYS_ADDR  + 0x004400000 - 1,
+				    PCMCIA_IO_PHYS_ADDR   + 0x004000000,
+				    PCMCIA_IO_PHYS_ADDR   + 0x004010000 - 1,
 				    DB1200_PC1_INT,
 				    DB1200_PC1_INSERT_INT,
 				    /*DB1200_PC1_STSCHG_INT*/0,
diff --git a/arch/mips/alchemy/devboards/db1x00/platform.c b/arch/mips/alchemy/devboards/db1x00/platform.c
index 62e2a96..978d5ab 100644
--- a/arch/mips/alchemy/devboards/db1x00/platform.c
+++ b/arch/mips/alchemy/devboards/db1x00/platform.c
@@ -88,24 +88,24 @@
 static int __init db1xxx_dev_init(void)
 {
 #ifdef DB1XXX_HAS_PCMCIA
-	db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS,
-				    PCMCIA_ATTR_PSEUDO_PHYS + 0x00040000 - 1,
-				    PCMCIA_MEM_PSEUDO_PHYS,
-				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00040000 - 1,
-				    PCMCIA_IO_PSEUDO_PHYS,
-				    PCMCIA_IO_PSEUDO_PHYS   + 0x00001000 - 1,
+	db1x_register_pcmcia_socket(PCMCIA_ATTR_PHYS_ADDR,
+				    PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
+				    PCMCIA_MEM_PHYS_ADDR,
+				    PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
+				    PCMCIA_IO_PHYS_ADDR,
+				    PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
 				    DB1XXX_PCMCIA_CARD0,
 				    DB1XXX_PCMCIA_CD0,
 				    /*DB1XXX_PCMCIA_STSCHG0*/0,
 				    0,
 				    0);
 
-	db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS + 0x00400000,
-				    PCMCIA_ATTR_PSEUDO_PHYS + 0x00440000 - 1,
-				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00400000,
-				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00440000 - 1,
-				    PCMCIA_IO_PSEUDO_PHYS   + 0x00400000,
-				    PCMCIA_IO_PSEUDO_PHYS   + 0x00401000 - 1,
+	db1x_register_pcmcia_socket(PCMCIA_ATTR_PHYS_ADDR + 0x004000000,
+				    PCMCIA_ATTR_PHYS_ADDR + 0x004400000 - 1,
+				    PCMCIA_MEM_PHYS_ADDR  + 0x004000000,
+				    PCMCIA_MEM_PHYS_ADDR  + 0x004400000 - 1,
+				    PCMCIA_IO_PHYS_ADDR   + 0x004000000,
+				    PCMCIA_IO_PHYS_ADDR   + 0x004010000 - 1,
 				    DB1XXX_PCMCIA_CARD1,
 				    DB1XXX_PCMCIA_CD1,
 				    /*DB1XXX_PCMCIA_STSCHG1*/0,
diff --git a/arch/mips/alchemy/devboards/pb1100/platform.c b/arch/mips/alchemy/devboards/pb1100/platform.c
index bfc5ab6..2c8dc29 100644
--- a/arch/mips/alchemy/devboards/pb1100/platform.c
+++ b/arch/mips/alchemy/devboards/pb1100/platform.c
@@ -30,12 +30,12 @@ static int __init pb1100_dev_init(void)
 	int swapped;
 
 	/* PCMCIA. single socket, identical to Pb1500 */
-	db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS,
-				    PCMCIA_ATTR_PSEUDO_PHYS + 0x00040000 - 1,
-				    PCMCIA_MEM_PSEUDO_PHYS,
-				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00040000 - 1,
-				    PCMCIA_IO_PSEUDO_PHYS,
-				    PCMCIA_IO_PSEUDO_PHYS   + 0x00001000 - 1,
+	db1x_register_pcmcia_socket(PCMCIA_ATTR_PHYS_ADDR,
+				    PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
+				    PCMCIA_MEM_PHYS_ADDR,
+				    PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
+				    PCMCIA_IO_PHYS_ADDR,
+				    PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
 				    AU1100_GPIO11_INT,	 /* card */
 				    AU1100_GPIO9_INT,	 /* insert */
 				    /*AU1100_GPIO10_INT*/0, /* stschg */
diff --git a/arch/mips/alchemy/devboards/pb1200/platform.c b/arch/mips/alchemy/devboards/pb1200/platform.c
index 14e889f..3ef2dce 100644
--- a/arch/mips/alchemy/devboards/pb1200/platform.c
+++ b/arch/mips/alchemy/devboards/pb1200/platform.c
@@ -170,24 +170,24 @@ static int __init board_register_devices(void)
 {
 	int swapped;
 
-	db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS,
-				    PCMCIA_ATTR_PSEUDO_PHYS + 0x00040000 - 1,
-				    PCMCIA_MEM_PSEUDO_PHYS,
-				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00040000 - 1,
-				    PCMCIA_IO_PSEUDO_PHYS,
-				    PCMCIA_IO_PSEUDO_PHYS   + 0x00001000 - 1,
+	db1x_register_pcmcia_socket(PCMCIA_ATTR_PHYS_ADDR,
+				    PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
+				    PCMCIA_MEM_PHYS_ADDR,
+				    PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
+				    PCMCIA_IO_PHYS_ADDR,
+				    PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
 				    PB1200_PC0_INT,
 				    PB1200_PC0_INSERT_INT,
 				    /*PB1200_PC0_STSCHG_INT*/0,
 				    PB1200_PC0_EJECT_INT,
 				    0);
 
-	db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS + 0x00800000,
-				    PCMCIA_ATTR_PSEUDO_PHYS + 0x00840000 - 1,
-				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00800000,
-				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00840000 - 1,
-				    PCMCIA_IO_PSEUDO_PHYS   + 0x00800000,
-				    PCMCIA_IO_PSEUDO_PHYS   + 0x00801000 - 1,
+	db1x_register_pcmcia_socket(PCMCIA_ATTR_PHYS_ADDR + 0x008000000,
+				    PCMCIA_ATTR_PHYS_ADDR + 0x008400000 - 1,
+				    PCMCIA_MEM_PHYS_ADDR  + 0x008000000,
+				    PCMCIA_MEM_PHYS_ADDR  + 0x008400000 - 1,
+				    PCMCIA_IO_PHYS_ADDR   + 0x008000000,
+				    PCMCIA_IO_PHYS_ADDR   + 0x008010000 - 1,
 				    PB1200_PC1_INT,
 				    PB1200_PC1_INSERT_INT,
 				    /*PB1200_PC1_STSCHG_INT*/0,
diff --git a/arch/mips/alchemy/devboards/pb1500/platform.c b/arch/mips/alchemy/devboards/pb1500/platform.c
index 529acb7..d443bc7 100644
--- a/arch/mips/alchemy/devboards/pb1500/platform.c
+++ b/arch/mips/alchemy/devboards/pb1500/platform.c
@@ -29,12 +29,12 @@ static int __init pb1500_dev_init(void)
 	int swapped;
 
 	/* PCMCIA. single socket, identical to Pb1500 */
-	db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS,
-				    PCMCIA_ATTR_PSEUDO_PHYS + 0x00040000 - 1,
-				    PCMCIA_MEM_PSEUDO_PHYS,
-				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00040000 - 1,
-				    PCMCIA_IO_PSEUDO_PHYS,
-				    PCMCIA_IO_PSEUDO_PHYS   + 0x00001000 - 1,
+	db1x_register_pcmcia_socket(PCMCIA_ATTR_PHYS_ADDR,
+				    PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
+				    PCMCIA_MEM_PHYS_ADDR,
+				    PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
+				    PCMCIA_IO_PHYS_ADDR,
+				    PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
 				    AU1500_GPIO11_INT,	 /* card */
 				    AU1500_GPIO9_INT,	 /* insert */
 				    /*AU1500_GPIO10_INT*/0, /* stschg */
diff --git a/arch/mips/alchemy/devboards/pb1550/platform.c b/arch/mips/alchemy/devboards/pb1550/platform.c
index 4613391..d7150d0 100644
--- a/arch/mips/alchemy/devboards/pb1550/platform.c
+++ b/arch/mips/alchemy/devboards/pb1550/platform.c
@@ -37,24 +37,24 @@ static int __init pb1550_dev_init(void)
 	* drivers are used to shared irqs and b) statuschange isn't really use-
 	* ful anyway.
 	*/
-	db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS,
-				    PCMCIA_ATTR_PSEUDO_PHYS + 0x00040000 - 1,
-				    PCMCIA_MEM_PSEUDO_PHYS,
-				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00040000 - 1,
-				    PCMCIA_IO_PSEUDO_PHYS,
-				    PCMCIA_IO_PSEUDO_PHYS   + 0x00001000 - 1,
+	db1x_register_pcmcia_socket(PCMCIA_ATTR_PHYS_ADDR,
+				    PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
+				    PCMCIA_MEM_PHYS_ADDR,
+				    PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
+				    PCMCIA_IO_PHYS_ADDR,
+				    PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
 				    AU1550_GPIO201_205_INT,
 				    AU1550_GPIO0_INT,
 				    0,
 				    0,
 				    0);
 
-	db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS + 0x00800000,
-				    PCMCIA_ATTR_PSEUDO_PHYS + 0x00840000 - 1,
-				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00800000,
-				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00840000 - 1,
-				    PCMCIA_IO_PSEUDO_PHYS   + 0x00800000,
-				    PCMCIA_IO_PSEUDO_PHYS   + 0x00801000 - 1,
+	db1x_register_pcmcia_socket(PCMCIA_ATTR_PHYS_ADDR + 0x008000000,
+				    PCMCIA_ATTR_PHYS_ADDR + 0x008400000 - 1,
+				    PCMCIA_MEM_PHYS_ADDR  + 0x008000000,
+				    PCMCIA_MEM_PHYS_ADDR  + 0x008400000 - 1,
+				    PCMCIA_IO_PHYS_ADDR   + 0x008000000,
+				    PCMCIA_IO_PHYS_ADDR   + 0x008010000 - 1,
 				    AU1550_GPIO201_205_INT,
 				    AU1550_GPIO1_INT,
 				    0,
diff --git a/arch/mips/alchemy/devboards/platform.c b/arch/mips/alchemy/devboards/platform.c
index febf4e0..49a4b32 100644
--- a/arch/mips/alchemy/devboards/platform.c
+++ b/arch/mips/alchemy/devboards/platform.c
@@ -39,12 +39,12 @@ static int __init db1x_poweroff_setup(void)
 late_initcall(db1x_poweroff_setup);
 
 /* register a pcmcia socket */
-int __init db1x_register_pcmcia_socket(unsigned long pseudo_attr_start,
-				       unsigned long pseudo_attr_end,
-				       unsigned long pseudo_mem_start,
-				       unsigned long pseudo_mem_end,
-				       unsigned long pseudo_io_start,
-				       unsigned long pseudo_io_end,
+int __init db1x_register_pcmcia_socket(phys_addr_t pcmcia_attr_start,
+				       phys_addr_t pcmcia_attr_end,
+				       phys_addr_t pcmcia_mem_start,
+				       phys_addr_t pcmcia_mem_end,
+				       phys_addr_t pcmcia_io_start,
+				       phys_addr_t pcmcia_io_end,
 				       int card_irq,
 				       int cd_irq,
 				       int stschg_irq,
@@ -71,20 +71,20 @@ int __init db1x_register_pcmcia_socket(unsigned long pseudo_attr_start,
 		goto out;
 	}
 
-	sr[0].name	= "pseudo-attr";
+	sr[0].name	= "pcmcia-attr";
 	sr[0].flags	= IORESOURCE_MEM;
-	sr[0].start	= pseudo_attr_start;
-	sr[0].end	= pseudo_attr_end;
+	sr[0].start	= pcmcia_attr_start;
+	sr[0].end	= pcmcia_attr_end;
 
-	sr[1].name	= "pseudo-mem";
+	sr[1].name	= "pcmcia-mem";
 	sr[1].flags	= IORESOURCE_MEM;
-	sr[1].start	= pseudo_mem_start;
-	sr[1].end	= pseudo_mem_end;
+	sr[1].start	= pcmcia_mem_start;
+	sr[1].end	= pcmcia_mem_end;
 
-	sr[2].name	= "pseudo-io";
+	sr[2].name	= "pcmcia-io";
 	sr[2].flags	= IORESOURCE_MEM;
-	sr[2].start	= pseudo_io_start;
-	sr[2].end	= pseudo_io_end;
+	sr[2].start	= pcmcia_io_start;
+	sr[2].end	= pcmcia_io_end;
 
 	sr[3].name	= "insert";
 	sr[3].flags	= IORESOURCE_IRQ;
@@ -96,9 +96,9 @@ int __init db1x_register_pcmcia_socket(unsigned long pseudo_attr_start,
 
 	i = 5;
 	if (stschg_irq) {
-		sr[i].name	= "insert";
+		sr[i].name	= "stschg";
 		sr[i].flags	= IORESOURCE_IRQ;
-		sr[i].start = sr[i].end = cd_irq;
+		sr[i].start = sr[i].end = stschg_irq;
 		i++;
 	}
 	if (eject_irq) {
diff --git a/arch/mips/alchemy/devboards/platform.h b/arch/mips/alchemy/devboards/platform.h
index 828c54e..5ac055d 100644
--- a/arch/mips/alchemy/devboards/platform.h
+++ b/arch/mips/alchemy/devboards/platform.h
@@ -3,12 +3,12 @@
 
 #include <linux/init.h>
 
-int __init db1x_register_pcmcia_socket(unsigned long pseudo_attr_start,
-				       unsigned long pseudo_attr_len,
-				       unsigned long pseudo_mem_start,
-				       unsigned long pseudo_mem_end,
-				       unsigned long pseudo_io_start,
-				       unsigned long pseudo_io_end,
+int __init db1x_register_pcmcia_socket(phys_addr_t pcmcia_attr_start,
+				       phys_addr_t pcmcia_attr_len,
+				       phys_addr_t pcmcia_mem_start,
+				       phys_addr_t pcmcia_mem_end,
+				       phys_addr_t pcmcia_io_start,
+				       phys_addr_t pcmcia_io_end,
 				       int card_irq,
 				       int cd_irq,
 				       int stschg_irq,
diff --git a/arch/mips/alchemy/xxs1500/platform.c b/arch/mips/alchemy/xxs1500/platform.c
index c14dcaa..e87c45c 100644
--- a/arch/mips/alchemy/xxs1500/platform.c
+++ b/arch/mips/alchemy/xxs1500/platform.c
@@ -25,22 +25,22 @@
 
 static struct resource xxs1500_pcmcia_res[] = {
 	{
-		.name	= "pseudo-io",
+		.name	= "pcmcia-io",
 		.flags	= IORESOURCE_MEM,
-		.start	= PCMCIA_IO_PSEUDO_PHYS,
-		.end	= PCMCIA_IO_PSEUDO_PHYS + 0x00040000 - 1,
+		.start	= PCMCIA_IO_PHYS_ADDR,
+		.end	= PCMCIA_IO_PHYS_ADDR + 0x000400000 - 1,
 	},
 	{
-		.name	= "pseudo-attr",
+		.name	= "pcmcia-attr",
 		.flags	= IORESOURCE_MEM,
-		.start	= PCMCIA_ATTR_PSEUDO_PHYS,
-		.end	= PCMCIA_ATTR_PSEUDO_PHYS + 0x00040000 - 1,
+		.start	= PCMCIA_ATTR_PHYS_ADDR,
+		.end	= PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
 	},
 	{
-		.name	= "pseudo-mem",
+		.name	= "pcmcia-mem",
 		.flags	= IORESOURCE_MEM,
-		.start	= PCMCIA_IO_PSEUDO_PHYS,
-		.end	= PCMCIA_IO_PSEUDO_PHYS + 0x00040000 - 1,
+		.start	= PCMCIA_MEM_PHYS_ADDR,
+		.end	= PCMCIA_MEM_PHYS_ADDR + 0x000400000 - 1,
 	},
 };
 
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index 2805fc5..ae07423 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -1678,18 +1678,4 @@ enum soc_au1200_ints {
 
 #endif
 
-/*
- * All Au1xx0 SOCs have a PCMCIA controller.
- * We setup our 32-bit pseudo addresses to be equal to the
- * 36-bit addr >> 4, to make it easier to check the address
- * and fix it.
- * The PCMCIA socket 0 physical attribute address is 0xF 4000 0000.
- * The pseudo address we use is 0xF400 0000. Any address over
- * 0xF400 0000 is a PCMCIA pseudo address.
- */
-#define PCMCIA_IO_PSEUDO_PHYS	(PCMCIA_IO_PHYS_ADDR >> 4)
-#define PCMCIA_ATTR_PSEUDO_PHYS	(PCMCIA_ATTR_PHYS_ADDR >> 4)
-#define PCMCIA_MEM_PSEUDO_PHYS	(PCMCIA_MEM_PHYS_ADDR >> 4)
-#define PCMCIA_PSEUDO_END	(0xffffffff)
-
 #endif
diff --git a/arch/mips/include/asm/mach-au1x00/ioremap.h b/arch/mips/include/asm/mach-au1x00/ioremap.h
index 364cea2..75a94ad 100644
--- a/arch/mips/include/asm/mach-au1x00/ioremap.h
+++ b/arch/mips/include/asm/mach-au1x00/ioremap.h
@@ -11,7 +11,7 @@
 
 #include <linux/types.h>
 
-#ifdef CONFIG_64BIT_PHYS_ADDR
+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_PCI)
 extern phys_t __fixup_bigphys_addr(phys_t, phys_t);
 #else
 static inline phys_t __fixup_bigphys_addr(phys_t phys_addr, phys_t size)
diff --git a/drivers/pcmcia/au1000_generic.c b/drivers/pcmcia/au1000_generic.c
index 0208870..171c8a6 100644
--- a/drivers/pcmcia/au1000_generic.c
+++ b/drivers/pcmcia/au1000_generic.c
@@ -405,18 +405,16 @@ int au1x00_pcmcia_socket_probe(struct device *dev, struct pcmcia_low_level *ops,
 			skt->virt_io = (void *)
 				(ioremap((phys_t)AU1X_SOCK0_IO, 0x1000) -
 				(u32)mips_io_port_base);
-			skt->phys_attr = AU1X_SOCK0_PSEUDO_PHYS_ATTR;
-			skt->phys_mem = AU1X_SOCK0_PSEUDO_PHYS_MEM;
+			skt->phys_attr = AU1X_SOCK0_PHYS_ATTR;
+			skt->phys_mem = AU1X_SOCK0_PHYS_MEM;
 		}
-#ifndef CONFIG_MIPS_XXS1500
 		else  {
 			skt->virt_io = (void *)
 				(ioremap((phys_t)AU1X_SOCK1_IO, 0x1000) -
 				(u32)mips_io_port_base);
-			skt->phys_attr = AU1X_SOCK1_PSEUDO_PHYS_ATTR;
-			skt->phys_mem = AU1X_SOCK1_PSEUDO_PHYS_MEM;
+			skt->phys_attr = AU1X_SOCK1_PHYS_ATTR;
+			skt->phys_mem = AU1X_SOCK1_PHYS_MEM;
 		}
-#endif
 		pcmcia_base_vaddrs[i] = (u32 *)skt->virt_io;
 		ret = ops->hw_init(skt);
 
diff --git a/drivers/pcmcia/au1000_generic.h b/drivers/pcmcia/au1000_generic.h
index aa743f6..a324d32 100644
--- a/drivers/pcmcia/au1000_generic.h
+++ b/drivers/pcmcia/au1000_generic.h
@@ -36,10 +36,6 @@
 #define AU1X_SOCK0_IO        0xF00000000ULL
 #define AU1X_SOCK0_PHYS_ATTR 0xF40000000ULL
 #define AU1X_SOCK0_PHYS_MEM  0xF80000000ULL
-/* pseudo 32 bit phys addresses, which get fixed up to the
- * real 36 bit address in fixup_bigphys_addr() */
-#define AU1X_SOCK0_PSEUDO_PHYS_ATTR 0xF4000000
-#define AU1X_SOCK0_PSEUDO_PHYS_MEM  0xF8000000
 
 /* pcmcia socket 1 needs external glue logic so the memory map
  * differs from board to board.
@@ -48,8 +44,6 @@
 #define AU1X_SOCK1_IO        0xF08000000ULL
 #define AU1X_SOCK1_PHYS_ATTR 0xF48000000ULL
 #define AU1X_SOCK1_PHYS_MEM  0xF88000000ULL
-#define AU1X_SOCK1_PSEUDO_PHYS_ATTR 0xF4800000
-#define AU1X_SOCK1_PSEUDO_PHYS_MEM  0xF8800000
 #endif
 
 struct pcmcia_state {
diff --git a/drivers/pcmcia/db1xxx_ss.c b/drivers/pcmcia/db1xxx_ss.c
index b35b72b..3889cf0 100644
--- a/drivers/pcmcia/db1xxx_ss.c
+++ b/drivers/pcmcia/db1xxx_ss.c
@@ -43,9 +43,9 @@ struct db1x_pcmcia_sock {
 	void		*virt_io;
 
 	/* the "pseudo" addresses of the PCMCIA space. */
-	unsigned long	phys_io;
-	unsigned long	phys_attr;
-	unsigned long	phys_mem;
+	phys_addr_t	phys_io;
+	phys_addr_t	phys_attr;
+	phys_addr_t	phys_mem;
 
 	/* previous flags for set_socket() */
 	unsigned int old_flags;
@@ -404,7 +404,6 @@ static int __devinit db1x_pcmcia_socket_probe(struct platform_device *pdev)
 {
 	struct db1x_pcmcia_sock *sock;
 	struct resource *r;
-	phys_t physio;
 	int ret, bid;
 
 	sock = kzalloc(sizeof(struct db1x_pcmcia_sock), GFP_KERNEL);
@@ -465,7 +464,7 @@ static int __devinit db1x_pcmcia_socket_probe(struct platform_device *pdev)
 	 * for this socket (usually the 36bit address shifted 4 to the
 	 * right).
 	 */
-	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pseudo-attr");
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcmcia-attr");
 	if (!r) {
 		printk(KERN_ERR "pcmcia%d has no 'pseudo-attr' resource!\n",
 			sock->nr);
@@ -477,7 +476,7 @@ static int __devinit db1x_pcmcia_socket_probe(struct platform_device *pdev)
 	 * pseudo-mem:  The 32bit address of the PCMCIA memory space for
 	 * this socket (usually the 36bit address shifted 4 to the right)
 	 */
-	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pseudo-mem");
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcmcia-mem");
 	if (!r) {
 		printk(KERN_ERR "pcmcia%d has no 'pseudo-mem' resource!\n",
 			sock->nr);
@@ -489,7 +488,7 @@ static int __devinit db1x_pcmcia_socket_probe(struct platform_device *pdev)
 	 * pseudo-io:  The 32bit address of the PCMCIA IO space for this
 	 * socket (usually the 36bit address shifted 4 to the right).
 	 */
-	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pseudo-io");
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcmcia-io");
 	if (!r) {
 		printk(KERN_ERR "pcmcia%d has no 'pseudo-io' resource!\n",
 			sock->nr);
@@ -497,12 +496,6 @@ static int __devinit db1x_pcmcia_socket_probe(struct platform_device *pdev)
 	}
 	sock->phys_io = r->start;
 
-
-	/* IO: we must remap the full 36bit address (for reference see
-	 * alchemy/common/setup.c::__fixup_bigphys_addr())
-	 */
-	physio = ((phys_t)sock->phys_io) << 4;
-
 	/*
 	 * PCMCIA client drivers use the inb/outb macros to access
 	 * the IO registers.  Since mips_io_port_base is added
@@ -511,7 +504,7 @@ static int __devinit db1x_pcmcia_socket_probe(struct platform_device *pdev)
 	 * to access the I/O or MEM address directly, without
 	 * going through this "mips_io_port_base" mechanism.
 	 */
-	sock->virt_io = (void *)(ioremap(physio, IO_MAP_SIZE) -
+	sock->virt_io = (void *)(ioremap(sock->phys_io, IO_MAP_SIZE) -
 				 mips_io_port_base);
 
 	if (!sock->virt_io) {
@@ -547,8 +540,8 @@ static int __devinit db1x_pcmcia_socket_probe(struct platform_device *pdev)
 		goto out2;
 	}
 
-	printk(KERN_INFO "Alchemy Db/Pb1xxx pcmcia%d @ io/attr/mem %08lx"
-		"(%p) %08lx %08lx  card/insert/stschg/eject irqs @ %d "
+	printk(KERN_INFO "Alchemy Db/Pb1xxx pcmcia%d @ io/attr/mem %09llx"
+		"(%p) %09llx %09llx  card/insert/stschg/eject irqs @ %d "
 		"%d %d %d\n", sock->nr, sock->phys_io, sock->virt_io,
 		sock->phys_attr, sock->phys_mem, sock->card_irq,
 		sock->insert_irq, sock->stschg_irq, sock->eject_irq);
diff --git a/drivers/pcmcia/xxs1500_ss.c b/drivers/pcmcia/xxs1500_ss.c
index 4e36930..61560cd 100644
--- a/drivers/pcmcia/xxs1500_ss.c
+++ b/drivers/pcmcia/xxs1500_ss.c
@@ -56,10 +56,9 @@ struct xxs1500_pcmcia_sock {
 	struct pcmcia_socket	socket;
 	void		*virt_io;
 
-	/* the "pseudo" addresses of the PCMCIA space. */
-	unsigned long	phys_io;
-	unsigned long	phys_attr;
-	unsigned long	phys_mem;
+	phys_addr_t	phys_io;
+	phys_addr_t	phys_attr;
+	phys_addr_t	phys_mem;
 
 	/* previous flags for set_socket() */
 	unsigned int old_flags;
@@ -211,7 +210,6 @@ static int __devinit xxs1500_pcmcia_probe(struct platform_device *pdev)
 {
 	struct xxs1500_pcmcia_sock *sock;
 	struct resource *r;
-	phys_t physio;
 	int ret, irq;
 
 	sock = kzalloc(sizeof(struct xxs1500_pcmcia_sock), GFP_KERNEL);
@@ -225,9 +223,9 @@ static int __devinit xxs1500_pcmcia_probe(struct platform_device *pdev)
 	 * for this socket (usually the 36bit address shifted 4 to the
 	 * right).
 	 */
-	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pseudo-attr");
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcmcia-attr");
 	if (!r) {
-		dev_err(&pdev->dev, "missing 'pseudo-attr' resource!\n");
+		dev_err(&pdev->dev, "missing 'pcmcia-attr' resource!\n");
 		goto out0;
 	}
 	sock->phys_attr = r->start;
@@ -236,9 +234,9 @@ static int __devinit xxs1500_pcmcia_probe(struct platform_device *pdev)
 	 * pseudo-mem:  The 32bit address of the PCMCIA memory space for
 	 * this socket (usually the 36bit address shifted 4 to the right)
 	 */
-	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pseudo-mem");
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcmcia-mem");
 	if (!r) {
-		dev_err(&pdev->dev, "missing 'pseudo-mem' resource!\n");
+		dev_err(&pdev->dev, "missing 'pcmcia-mem' resource!\n");
 		goto out0;
 	}
 	sock->phys_mem = r->start;
@@ -247,19 +245,14 @@ static int __devinit xxs1500_pcmcia_probe(struct platform_device *pdev)
 	 * pseudo-io:  The 32bit address of the PCMCIA IO space for this
 	 * socket (usually the 36bit address shifted 4 to the right).
 	 */
-	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pseudo-io");
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcmcia-io");
 	if (!r) {
-		dev_err(&pdev->dev, "missing 'pseudo-io' resource!\n");
+		dev_err(&pdev->dev, "missing 'pcmcia-io' resource!\n");
 		goto out0;
 	}
 	sock->phys_io = r->start;
 
 
-	/* for io must remap the full 36bit address (for reference see
-	 * alchemy/common/setup.c::__fixup_bigphys_addr)
-	 */
-	physio = ((phys_t)sock->phys_io) << 4;
-
 	/*
 	 * PCMCIA client drivers use the inb/outb macros to access
 	 * the IO registers.  Since mips_io_port_base is added
@@ -268,7 +261,7 @@ static int __devinit xxs1500_pcmcia_probe(struct platform_device *pdev)
 	 * to access the I/O or MEM address directly, without
 	 * going through this "mips_io_port_base" mechanism.
 	 */
-	sock->virt_io = (void *)(ioremap(physio, IO_MAP_SIZE) -
+	sock->virt_io = (void *)(ioremap(sock->phys_io, IO_MAP_SIZE) -
 				 mips_io_port_base);
 
 	if (!sock->virt_io) {
-- 
1.7.0
