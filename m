Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Feb 2011 14:52:09 +0100 (CET)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:50684 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491009Ab1BONwF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Feb 2011 14:52:05 +0100
Received: by ewy20 with SMTP id 20so57772ewy.36
        for <multiple recipients>; Tue, 15 Feb 2011 05:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=X799rDE5s2XFj1GOPajH9WnN2M41fDbmEhF3iC0H1WA=;
        b=iNt8SSyAN+q3+SywuKYjQffIQs8GkQKum51mSVVJoiD72ejI2qK66cN711tvSp3QAJ
         rbTSU2IjapPU91Nik50XbTgHIH2ZWZKH+iVyUcZlCnyo5272ZsdmV8ubkcGF/k1ck1hy
         wfRDTNX7UZfiE0xA0MZEUXVbi8pylORdng384=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Lo0UgbNB6359LM69mPq+n8nmzuOmFO22YVAHo3fMH70p8ohacVM3ePpE48NRtiW5Ph
         1NMCtgz7U6X+3SsAkPNkhhbWaee5RwiKqL2W5xpDpkds93/8hU7aINKvdyNlZP/GbYhw
         6Oydu3DjxjmKj/Zl2qR5ponAbV8mRMoUGW9WU=
Received: by 10.223.101.136 with SMTP id c8mr6311911fao.100.1297777919679;
        Tue, 15 Feb 2011 05:51:59 -0800 (PST)
Received: from localhost.localdomain ([59.160.135.215])
        by mx.google.com with ESMTPS id n26sm1651004fam.37.2011.02.15.05.51.56
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Feb 2011 05:51:58 -0800 (PST)
From:   "Anoop P.A" <anoop.pa@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Anoop P A <anoop.pa@gmail.com>
Subject: [PATCH 1/2] Introduce MSP_HAS_PCI config option.
Date:   Tue, 15 Feb 2011 19:43:17 +0530
Message-Id: <1297779197-26710-1-git-send-email-anoop.pa@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1297779151-26595-1-git-send-email-anoop.pa@gmail.com>
References: <1297779151-26595-1-git-send-email-anoop.pa@gmail.com>
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

From: Anoop P A <anoop.pa@gmail.com>

Various chips in MSP family shares PCI block. Following patch introduce MSP_HAS_PCI config option
so that we can avoid adding seperate entries in arch/mips/pci/Makefile. Also getrid off SoC specific
flags from ops-pmcmsp.c

Signed-off-by: Anoop P A <anoop.pa@gmail.com>
---
 arch/mips/pci/Makefile       |    4 +---
 arch/mips/pci/ops-pmcmsp.c   |   12 +++++++-----
 arch/mips/pmc-sierra/Kconfig |   12 +++++++++---
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index c9209ca..2dd8845 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -30,9 +30,7 @@ obj-$(CONFIG_SOC_PNX8550)	+= fixup-pnx8550.o ops-pnx8550.o
 obj-$(CONFIG_LEMOTE_FULOONG2E)	+= fixup-fuloong2e.o ops-loongson2.o
 obj-$(CONFIG_LEMOTE_MACH2F)	+= fixup-lemote2f.o ops-loongson2.o
 obj-$(CONFIG_MIPS_MALTA)	+= fixup-malta.o
-obj-$(CONFIG_PMC_MSP7120_GW)	+= fixup-pmcmsp.o ops-pmcmsp.o
-obj-$(CONFIG_PMC_MSP7120_EVAL)	+= fixup-pmcmsp.o ops-pmcmsp.o
-obj-$(CONFIG_PMC_MSP7120_FPGA)	+= fixup-pmcmsp.o ops-pmcmsp.o
+obj-$(CONFIG_MSP_HAS_PCI)	+= fixup-pmcmsp.o ops-pmcmsp.o
 obj-$(CONFIG_PMC_YOSEMITE)	+= fixup-yosemite.o ops-titan.o ops-titan-ht.o \
 				   pci-yosemite.o
 obj-$(CONFIG_SGI_IP27)		+= ops-bridge.o pci-ip27.o
diff --git a/arch/mips/pci/ops-pmcmsp.c b/arch/mips/pci/ops-pmcmsp.c
index 68798f8..caedf9a 100644
--- a/arch/mips/pci/ops-pmcmsp.c
+++ b/arch/mips/pci/ops-pmcmsp.c
@@ -31,7 +31,7 @@
 #include <linux/init.h>
 
 #include <asm/byteorder.h>
-#if defined(CONFIG_PMC_MSP7120_GW) || defined(CONFIG_PMC_MSP7120_EVAL)
+#ifdef CONFIG_MIPS_MT
 #include <asm/mipsmtregs.h>
 #endif
 
@@ -206,7 +206,9 @@ static void pci_proc_init(void)
 }
 #endif /* CONFIG_PROC_FS && PCI_COUNTERS */
 
+#ifndef CONFIG_MIPS_MT
 static DEFINE_SPINLOCK(bpci_lock);
+#endif
 
 /*****************************************************************************
  *
@@ -386,7 +388,7 @@ int msp_pcibios_config_access(unsigned char access_type,
 	unsigned long value;
 	static char pciirqflag;
 	int ret;
-#if defined(CONFIG_PMC_MSP7120_GW) || defined(CONFIG_PMC_MSP7120_EVAL)
+#ifdef CONFIG_MIPS_MT
 	unsigned int	vpe_status;
 #endif
 
@@ -413,7 +415,7 @@ int msp_pcibios_config_access(unsigned char access_type,
 		pciirqflag = ~0;
 	}
 
-#if defined(CONFIG_PMC_MSP7120_GW) || defined(CONFIG_PMC_MSP7120_EVAL)
+#ifdef CONFIG_MIPS_MT
 	local_irq_save(flags);
 	vpe_status = dvpe();
 #else
@@ -468,7 +470,7 @@ int msp_pcibios_config_access(unsigned char access_type,
 		/* Clear status bits */
 		preg->if_status = ~(BPCI_IFSTATUS_BC0F | BPCI_IFSTATUS_BC1F);
 
-#if defined(CONFIG_PMC_MSP7120_GW) || defined(CONFIG_PMC_MSP7120_EVAL)
+#ifdef CONFIG_MIPS_MT
 		evpe(vpe_status);
 		local_irq_restore(flags);
 #else
@@ -478,7 +480,7 @@ int msp_pcibios_config_access(unsigned char access_type,
 		return -1;
 	}
 
-#if defined(CONFIG_PMC_MSP7120_GW) || defined(CONFIG_PMC_MSP7120_EVAL)
+#ifdef CONFIG_MIPS_MT
 	evpe(vpe_status);
 	local_irq_restore(flags);
 #else
diff --git a/arch/mips/pmc-sierra/Kconfig b/arch/mips/pmc-sierra/Kconfig
index bbd7608..d4984c3 100644
--- a/arch/mips/pmc-sierra/Kconfig
+++ b/arch/mips/pmc-sierra/Kconfig
@@ -16,13 +16,13 @@ config PMC_MSP7120_EVAL
 	bool "PMC-Sierra MSP7120 Eval Board"
 	select SYS_SUPPORTS_MULTITHREADING
 	select IRQ_MSP_CIC
-	select HW_HAS_PCI
+	select MSP_HAS_PCI
 
 config PMC_MSP7120_GW
 	bool "PMC-Sierra MSP7120 Residential Gateway"
 	select SYS_SUPPORTS_MULTITHREADING
 	select IRQ_MSP_CIC
-	select HW_HAS_PCI
+	select MSP_HAS_PCI
 	select MSP_HAS_USB
 	select MSP_ETH
 
@@ -30,7 +30,7 @@ config PMC_MSP7120_FPGA
 	bool "PMC-Sierra MSP7120 FPGA"
 	select SYS_SUPPORTS_MULTITHREADING
 	select IRQ_MSP_CIC
-	select HW_HAS_PCI
+	select MSP_HAS_PCI
 
 endchoice
 
@@ -50,3 +50,9 @@ config MSP_ETH
 config MSP_HAS_MAC
 	boolean
 	depends on PMC_MSP
+
+config MSP_HAS_PCI
+	boolean
+	select HW_HAS_PCI
+	depends on PMC_MSP
+
-- 
1.7.0.4
