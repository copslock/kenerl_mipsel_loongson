Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 14:00:37 +0100 (WEST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:41739 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022574AbZFDNAR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2009 14:00:17 +0100
Received: by mail-pz0-f202.google.com with SMTP id 40so735719pzk.22
        for <multiple recipients>; Thu, 04 Jun 2009 06:00:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ZJwrRb8S/y+Zc02i8yW6T8PKOr2idXTX/2vGMdzfG0k=;
        b=pMB4ZagOuXeEfEw1hK+VEMx4fOvsekc4EFrNEYEROeD4pF04Fnr9QwNY/0vZXVSGl1
         EwjSX5mHPUJlQQgA7KyWxq/kxbIfjIBXkJRXcuwbGpVditFcwfqigEin9qcnQXoQxF6T
         Ba/uDhNnuCZh9gVNMdSIBzh3l//DNO05w1Iac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=YffHOTgmNncJaiB2w5jJz7VPrE0lrWGsxfyLcd7ISPJaiEiunFOJePWWhmtjYtwsHO
         2902F3q/d8laskImn6mwotG4ehgWM6oH0OaidyEyArjmXC2Na5iG/2aTszQhyrmNCmet
         /jGfCpr73D79nekF0s1BugVhGycqx5J9aWy+8=
Received: by 10.114.185.12 with SMTP id i12mr2506120waf.178.1244120415052;
        Thu, 04 Jun 2009 06:00:15 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id l27sm10687982waf.55.2009.06.04.06.00.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 06:00:13 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [loongson-PATCH-v3 02/25] fix-warning: incompatible argument type of pci_fixup_irqs
Date:	Thu,  4 Jun 2009 21:00:01 +0800
Message-Id: <d8c4ecf441d6bf6e26c99f945f3e6aad1b742c6a.1244120172.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <cover.1244120172.git.wuzj@lemote.com>
References: <cover.1244120172.git.wuzj@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

arch/mips/pci/pci.c:160: warning: passing argument 2 of ‘pci_fixup_irqs’
from incompatible pointer type

include/linux/pci.h:

	void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
            int (*)(struct pci_dev *, u8, u8));

arch/mips/pci/pci.c:160:

	pci_fixup_irqs(pci_common_swizzle, pcibios_map_irq);

arch/mips/include/asm/pci.h:

	extern int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);

arch/mips/pci/fixup-malta.c

	int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)

Reviewed-by: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/pci.h           |    2 +-
 arch/mips/include/asm/txx9/generic.h  |    2 +-
 arch/mips/include/asm/txx9/jmr3927.h  |    2 +-
 arch/mips/include/asm/txx9/rbtx4927.h |    2 +-
 arch/mips/include/asm/txx9/rbtx4938.h |    2 +-
 arch/mips/include/asm/txx9/tx4938.h   |    2 +-
 arch/mips/include/asm/txx9/tx4939.h   |    4 ++--
 arch/mips/pci/fixup-au1000.c          |    2 +-
 arch/mips/pci/fixup-capcella.c        |    2 +-
 arch/mips/pci/fixup-cobalt.c          |    2 +-
 arch/mips/pci/fixup-emma2rh.c         |    2 +-
 arch/mips/pci/fixup-excite.c          |    2 +-
 arch/mips/pci/fixup-ip32.c            |    2 +-
 arch/mips/pci/fixup-jmr3927.c         |    2 +-
 arch/mips/pci/fixup-lm2e.c            |    2 +-
 arch/mips/pci/fixup-malta.c           |    2 +-
 arch/mips/pci/fixup-mpc30x.c          |    2 +-
 arch/mips/pci/fixup-pmcmsp.c          |    2 +-
 arch/mips/pci/fixup-pnx8550.c         |    2 +-
 arch/mips/pci/fixup-rbtx4927.c        |    2 +-
 arch/mips/pci/fixup-rbtx4938.c        |    2 +-
 arch/mips/pci/fixup-rc32434.c         |    2 +-
 arch/mips/pci/fixup-sni.c             |    2 +-
 arch/mips/pci/fixup-tb0219.c          |    2 +-
 arch/mips/pci/fixup-tb0226.c          |    2 +-
 arch/mips/pci/fixup-tb0287.c          |    2 +-
 arch/mips/pci/fixup-wrppmc.c          |    2 +-
 arch/mips/pci/fixup-yosemite.c        |    2 +-
 arch/mips/pci/pci-bcm1480.c           |    2 +-
 arch/mips/pci/pci-bcm47xx.c           |    2 +-
 arch/mips/pci/pci-ip27.c              |    2 +-
 arch/mips/pci/pci-lasat.c             |    2 +-
 arch/mips/pci/pci-sb1250.c            |    2 +-
 arch/mips/pci/pci-tx4938.c            |    2 +-
 arch/mips/pci/pci-tx4939.c            |    4 ++--
 arch/mips/txx9/generic/pci.c          |    2 +-
 36 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 053e463..42b895b 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -56,7 +56,7 @@ extern void register_pci_controller(struct pci_controller *hose);
 /*
  * board supplied pci irq fixup routine
  */
-extern int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);
+extern int pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin);
 
 
 /* Can be used to override the logic in pci_scan_bus for skipping
diff --git a/arch/mips/include/asm/txx9/generic.h b/arch/mips/include/asm/txx9/generic.h
index 9cde009..166da5a 100644
--- a/arch/mips/include/asm/txx9/generic.h
+++ b/arch/mips/include/asm/txx9/generic.h
@@ -37,7 +37,7 @@ struct txx9_board_vec {
 	void (*arch_init)(void);
 	void (*device_init)(void);
 #ifdef CONFIG_PCI
-	int (*pci_map_irq)(const struct pci_dev *dev, u8 slot, u8 pin);
+	int (*pci_map_irq)(struct pci_dev *dev, u8 slot, u8 pin);
 #endif
 };
 extern struct txx9_board_vec *txx9_board_vec;
diff --git a/arch/mips/include/asm/txx9/jmr3927.h b/arch/mips/include/asm/txx9/jmr3927.h
index a409c44..8f37def 100644
--- a/arch/mips/include/asm/txx9/jmr3927.h
+++ b/arch/mips/include/asm/txx9/jmr3927.h
@@ -175,6 +175,6 @@
 void jmr3927_prom_init(void);
 void jmr3927_irq_setup(void);
 struct pci_dev;
-int jmr3927_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);
+int jmr3927_pci_map_irq(struct pci_dev *dev, u8 slot, u8 pin);
 
 #endif /* __ASM_TXX9_JMR3927_H */
diff --git a/arch/mips/include/asm/txx9/rbtx4927.h b/arch/mips/include/asm/txx9/rbtx4927.h
index b2adab3..0168a87 100644
--- a/arch/mips/include/asm/txx9/rbtx4927.h
+++ b/arch/mips/include/asm/txx9/rbtx4927.h
@@ -87,6 +87,6 @@
 void rbtx4927_prom_init(void);
 void rbtx4927_irq_setup(void);
 struct pci_dev;
-int rbtx4927_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);
+int rbtx4927_pci_map_irq(struct pci_dev *dev, u8 slot, u8 pin);
 
 #endif /* __ASM_TXX9_RBTX4927_H */
diff --git a/arch/mips/include/asm/txx9/rbtx4938.h b/arch/mips/include/asm/txx9/rbtx4938.h
index 9f0441a..705435b 100644
--- a/arch/mips/include/asm/txx9/rbtx4938.h
+++ b/arch/mips/include/asm/txx9/rbtx4938.h
@@ -140,6 +140,6 @@
 void rbtx4938_prom_init(void);
 void rbtx4938_irq_setup(void);
 struct pci_dev;
-int rbtx4938_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);
+int rbtx4938_pci_map_irq(struct pci_dev *dev, u8 slot, u8 pin);
 
 #endif /* __ASM_TXX9_RBTX4938_H */
diff --git a/arch/mips/include/asm/txx9/tx4938.h b/arch/mips/include/asm/txx9/tx4938.h
index cd8bc20..e104c95 100644
--- a/arch/mips/include/asm/txx9/tx4938.h
+++ b/arch/mips/include/asm/txx9/tx4938.h
@@ -287,7 +287,7 @@ int tx4938_report_pciclk(void);
 void tx4938_report_pci1clk(void);
 int tx4938_pciclk66_setup(void);
 struct pci_dev;
-int tx4938_pcic1_map_irq(const struct pci_dev *dev, u8 slot);
+int tx4938_pcic1_map_irq(struct pci_dev *dev, u8 slot);
 void tx4938_setup_pcierr_irq(void);
 void tx4938_irq_init(void);
 void tx4938_mtd_init(int ch);
diff --git a/arch/mips/include/asm/txx9/tx4939.h b/arch/mips/include/asm/txx9/tx4939.h
index f02c50b..b7af10e 100644
--- a/arch/mips/include/asm/txx9/tx4939.h
+++ b/arch/mips/include/asm/txx9/tx4939.h
@@ -534,8 +534,8 @@ void tx4939_ethaddr_init(unsigned char *addr0, unsigned char *addr1);
 int tx4939_report_pciclk(void);
 void tx4939_report_pci1clk(void);
 struct pci_dev;
-int tx4939_pcic1_map_irq(const struct pci_dev *dev, u8 slot);
-int tx4939_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);
+int tx4939_pcic1_map_irq(struct pci_dev *dev, u8 slot);
+int tx4939_pci_map_irq(struct pci_dev *dev, u8 slot, u8 pin);
 void tx4939_setup_pcierr_irq(void);
 void tx4939_irq_init(void);
 int tx4939_irq(void);
diff --git a/arch/mips/pci/fixup-au1000.c b/arch/mips/pci/fixup-au1000.c
index e2ddfc4..15b8ecc 100644
--- a/arch/mips/pci/fixup-au1000.c
+++ b/arch/mips/pci/fixup-au1000.c
@@ -31,7 +31,7 @@
 
 extern char irq_tab_alchemy[][5];
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return irq_tab_alchemy[slot][pin];
 }
diff --git a/arch/mips/pci/fixup-capcella.c b/arch/mips/pci/fixup-capcella.c
index 1416bca..1e53075 100644
--- a/arch/mips/pci/fixup-capcella.c
+++ b/arch/mips/pci/fixup-capcella.c
@@ -38,7 +38,7 @@ static char irq_tab_capcella[][5] __initdata = {
  [14] = { -1, INTA, INTB, INTC, INTD }
 };
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return irq_tab_capcella[slot][pin];
 }
diff --git a/arch/mips/pci/fixup-cobalt.c b/arch/mips/pci/fixup-cobalt.c
index 9553b14..63d1af3 100644
--- a/arch/mips/pci/fixup-cobalt.c
+++ b/arch/mips/pci/fixup-cobalt.c
@@ -175,7 +175,7 @@ static char irq_tab_raq2[] __initdata = {
   [COBALT_PCICONF_ETH1]    = ETH1_IRQ
 };
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	if (cobalt_board_id <= COBALT_BRD_ID_QUBE1)
 		return irq_tab_qube1[slot];
diff --git a/arch/mips/pci/fixup-emma2rh.c b/arch/mips/pci/fixup-emma2rh.c
index fba5aad..04c28f3 100644
--- a/arch/mips/pci/fixup-emma2rh.c
+++ b/arch/mips/pci/fixup-emma2rh.c
@@ -88,7 +88,7 @@ static void __devinit emma2rh_pci_host_fixup(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_EMMA2RH,
 			 emma2rh_pci_host_fixup);
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return irq_map[slot][pin];
 }
diff --git a/arch/mips/pci/fixup-excite.c b/arch/mips/pci/fixup-excite.c
index cd64d9f..1da696d 100644
--- a/arch/mips/pci/fixup-excite.c
+++ b/arch/mips/pci/fixup-excite.c
@@ -21,7 +21,7 @@
 #include <linux/pci.h>
 #include <excite.h>
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	if (pin == 0)
 		return -1;
diff --git a/arch/mips/pci/fixup-ip32.c b/arch/mips/pci/fixup-ip32.c
index 190fffd..3e66b0a 100644
--- a/arch/mips/pci/fixup-ip32.c
+++ b/arch/mips/pci/fixup-ip32.c
@@ -39,7 +39,7 @@ static char irq_tab_mace[][5] __initdata = {
  * irqs.  I suppose a device without a pin A will thank us for doing it
  * right if there exists such a broken piece of crap.
  */
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return irq_tab_mace[slot][pin];
 }
diff --git a/arch/mips/pci/fixup-jmr3927.c b/arch/mips/pci/fixup-jmr3927.c
index 0f10695..e6ff40e 100644
--- a/arch/mips/pci/fixup-jmr3927.c
+++ b/arch/mips/pci/fixup-jmr3927.c
@@ -31,7 +31,7 @@
 #include <asm/txx9/pci.h>
 #include <asm/txx9/jmr3927.h>
 
-int __init jmr3927_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int __init jmr3927_pci_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	unsigned char irq = pin;
 
diff --git a/arch/mips/pci/fixup-lm2e.c b/arch/mips/pci/fixup-lm2e.c
index e18ae4f..08de000 100644
--- a/arch/mips/pci/fixup-lm2e.c
+++ b/arch/mips/pci/fixup-lm2e.c
@@ -36,7 +36,7 @@
 /* South bridge slot number is set by the pci probe process */
 static u8 sb_slot = 5;
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int irq = 0;
 
diff --git a/arch/mips/pci/fixup-malta.c b/arch/mips/pci/fixup-malta.c
index 0f48498..bf2c41d 100644
--- a/arch/mips/pci/fixup-malta.c
+++ b/arch/mips/pci/fixup-malta.c
@@ -36,7 +36,7 @@ static char irq_tab[][5] __initdata = {
 	{0,	PCID,	PCIA,	PCIB,	PCIC }	/* 21: PCI Slot 4 */
 };
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int virq;
 	virq = irq_tab[slot][pin];
diff --git a/arch/mips/pci/fixup-mpc30x.c b/arch/mips/pci/fixup-mpc30x.c
index 5911596..3c9ae41 100644
--- a/arch/mips/pci/fixup-mpc30x.c
+++ b/arch/mips/pci/fixup-mpc30x.c
@@ -34,7 +34,7 @@ static const int irq_tab_mpc30x[] __initdata = {
  [29] = MQ200_IRQ,
 };
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	if (slot == 30)
 		return internal_func_irqs[PCI_FUNC(dev->devfn)];
diff --git a/arch/mips/pci/fixup-pmcmsp.c b/arch/mips/pci/fixup-pmcmsp.c
index 65735b1..0026121 100644
--- a/arch/mips/pci/fixup-pmcmsp.c
+++ b/arch/mips/pci/fixup-pmcmsp.c
@@ -202,7 +202,7 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
  *  RETURNS:     IRQ number
  *
  ****************************************************************************/
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 #if !defined(CONFIG_PMC_MSP7120_GW) && !defined(CONFIG_PMC_MSP7120_EVAL)
 	printk(KERN_WARNING "PCI: unknown board, no PCI IRQs assigned.\n");
diff --git a/arch/mips/pci/fixup-pnx8550.c b/arch/mips/pci/fixup-pnx8550.c
index 96857ac..50546da 100644
--- a/arch/mips/pci/fixup-pnx8550.c
+++ b/arch/mips/pci/fixup-pnx8550.c
@@ -45,7 +45,7 @@ void __init pcibios_fixup(void)
 	/* nothing to do here */
 }
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return pnx8550_irq_tab[slot][pin];
 }
diff --git a/arch/mips/pci/fixup-rbtx4927.c b/arch/mips/pci/fixup-rbtx4927.c
index 321db26..3f1df0e 100644
--- a/arch/mips/pci/fixup-rbtx4927.c
+++ b/arch/mips/pci/fixup-rbtx4927.c
@@ -36,7 +36,7 @@
 #include <asm/txx9/pci.h>
 #include <asm/txx9/rbtx4927.h>
 
-int __init rbtx4927_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int __init rbtx4927_pci_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	unsigned char irq = pin;
 
diff --git a/arch/mips/pci/fixup-rbtx4938.c b/arch/mips/pci/fixup-rbtx4938.c
index a80579a..a5e0a41 100644
--- a/arch/mips/pci/fixup-rbtx4938.c
+++ b/arch/mips/pci/fixup-rbtx4938.c
@@ -13,7 +13,7 @@
 #include <asm/txx9/pci.h>
 #include <asm/txx9/rbtx4938.h>
 
-int __init rbtx4938_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int __init rbtx4938_pci_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int irq = tx4938_pcic1_map_irq(dev, slot);
 
diff --git a/arch/mips/pci/fixup-rc32434.c b/arch/mips/pci/fixup-rc32434.c
index 3d86823..68f8537 100644
--- a/arch/mips/pci/fixup-rc32434.c
+++ b/arch/mips/pci/fixup-rc32434.c
@@ -37,7 +37,7 @@ static int __devinitdata irq_map[2][12] = {
 	{0, 0, 1, 3, 0, 2, 1, 3, 0, 2, 1, 3}
 };
 
-int __devinit pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int __devinit pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int irq = 0;
 
diff --git a/arch/mips/pci/fixup-sni.c b/arch/mips/pci/fixup-sni.c
index 5c8a79b..4ce73be 100644
--- a/arch/mips/pci/fixup-sni.c
+++ b/arch/mips/pci/fixup-sni.c
@@ -130,7 +130,7 @@ static inline int is_rm300_revd(void)
 	return (csmsr & 0xa0) == 0x20;
 }
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	switch (sni_brd_type) {
 	case SNI_BRD_PCI_TOWER_CPLUS:
diff --git a/arch/mips/pci/fixup-tb0219.c b/arch/mips/pci/fixup-tb0219.c
index ed87733..0f8d31b 100644
--- a/arch/mips/pci/fixup-tb0219.c
+++ b/arch/mips/pci/fixup-tb0219.c
@@ -23,7 +23,7 @@
 
 #include <asm/vr41xx/tb0219.h>
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int irq = -1;
 
diff --git a/arch/mips/pci/fixup-tb0226.c b/arch/mips/pci/fixup-tb0226.c
index e3eedf4..c9e7cb4 100644
--- a/arch/mips/pci/fixup-tb0226.c
+++ b/arch/mips/pci/fixup-tb0226.c
@@ -23,7 +23,7 @@
 #include <asm/vr41xx/giu.h>
 #include <asm/vr41xx/tb0226.h>
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int irq = -1;
 
diff --git a/arch/mips/pci/fixup-tb0287.c b/arch/mips/pci/fixup-tb0287.c
index 267ab3d..fbe6bcb 100644
--- a/arch/mips/pci/fixup-tb0287.c
+++ b/arch/mips/pci/fixup-tb0287.c
@@ -22,7 +22,7 @@
 
 #include <asm/vr41xx/tb0287.h>
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	unsigned char bus;
 	int irq = -1;
diff --git a/arch/mips/pci/fixup-wrppmc.c b/arch/mips/pci/fixup-wrppmc.c
index 3d27754..3357c13 100644
--- a/arch/mips/pci/fixup-wrppmc.c
+++ b/arch/mips/pci/fixup-wrppmc.c
@@ -25,7 +25,7 @@ static char pci_irq_tab[PCI_SLOT_MAXNR][5] __initdata = {
 	[6] = {0, WRPPMC_PCI_INTA_IRQ, 0, 0, 0},
 };
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return pci_irq_tab[slot][pin];
 }
diff --git a/arch/mips/pci/fixup-yosemite.c b/arch/mips/pci/fixup-yosemite.c
index fdafb13..81d77a5 100644
--- a/arch/mips/pci/fixup-yosemite.c
+++ b/arch/mips/pci/fixup-yosemite.c
@@ -26,7 +26,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	if (pin == 0)
 		return -1;
diff --git a/arch/mips/pci/pci-bcm1480.c b/arch/mips/pci/pci-bcm1480.c
index a9060c7..41e691a 100644
--- a/arch/mips/pci/pci-bcm1480.c
+++ b/arch/mips/pci/pci-bcm1480.c
@@ -74,7 +74,7 @@ static inline void WRITECFG32(u32 addr, u32 data)
 	*(u32 *)(cfg_space + (addr & ~3)) = data;
 }
 
-int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	if (pin == 0)
 		return -1;
diff --git a/arch/mips/pci/pci-bcm47xx.c b/arch/mips/pci/pci-bcm47xx.c
index bea9b6c..1f3721d 100644
--- a/arch/mips/pci/pci-bcm47xx.c
+++ b/arch/mips/pci/pci-bcm47xx.c
@@ -26,7 +26,7 @@
 #include <linux/pci.h>
 #include <linux/ssb/ssb.h>
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return 0;
 }
diff --git a/arch/mips/pci/pci-ip27.c b/arch/mips/pci/pci-ip27.c
index dda6f20..a2a5b5d 100644
--- a/arch/mips/pci/pci-ip27.c
+++ b/arch/mips/pci/pci-ip27.c
@@ -141,7 +141,7 @@ int __cpuinit bridge_probe(nasid_t nasid, int widget_id, int masterwid)
  * A given PCI device, in general, should be able to intr any of the cpus
  * on any one of the hubs connected to its xbow.
  */
-int __devinit pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int __devinit pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return 0;
 }
diff --git a/arch/mips/pci/pci-lasat.c b/arch/mips/pci/pci-lasat.c
index a98e543..149d503 100644
--- a/arch/mips/pci/pci-lasat.c
+++ b/arch/mips/pci/pci-lasat.c
@@ -61,7 +61,7 @@ arch_initcall(lasat_pci_setup);
 #define LASAT_IRQ_PCIC   (LASAT_IRQ_BASE + 7)
 #define LASAT_IRQ_PCID   (LASAT_IRQ_BASE + 8)
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	switch (slot) {
 	case 1:
diff --git a/arch/mips/pci/pci-sb1250.c b/arch/mips/pci/pci-sb1250.c
index bf63959..bd26d4a 100644
--- a/arch/mips/pci/pci-sb1250.c
+++ b/arch/mips/pci/pci-sb1250.c
@@ -84,7 +84,7 @@ static inline void WRITECFG32(u32 addr, u32 data)
 	*(u32 *) (cfg_space + (addr & ~3)) = data;
 }
 
-int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return dev->irq;
 }
diff --git a/arch/mips/pci/pci-tx4938.c b/arch/mips/pci/pci-tx4938.c
index 1ea257b..0a2467d 100644
--- a/arch/mips/pci/pci-tx4938.c
+++ b/arch/mips/pci/pci-tx4938.c
@@ -114,7 +114,7 @@ int __init tx4938_pciclk66_setup(void)
 	return pciclk;
 }
 
-int __init tx4938_pcic1_map_irq(const struct pci_dev *dev, u8 slot)
+int __init tx4938_pcic1_map_irq(struct pci_dev *dev, u8 slot)
 {
 	if (get_tx4927_pcicptr(dev->bus->sysdata) == tx4938_pcic1ptr) {
 		switch (slot) {
diff --git a/arch/mips/pci/pci-tx4939.c b/arch/mips/pci/pci-tx4939.c
index 5fecf1c..b39f9a5 100644
--- a/arch/mips/pci/pci-tx4939.c
+++ b/arch/mips/pci/pci-tx4939.c
@@ -50,7 +50,7 @@ void __init tx4939_report_pci1clk(void)
 		((pciclk + 50000) / 100000) % 10);
 }
 
-int __init tx4939_pcic1_map_irq(const struct pci_dev *dev, u8 slot)
+int __init tx4939_pcic1_map_irq(struct pci_dev *dev, u8 slot)
 {
 	if (get_tx4927_pcicptr(dev->bus->sysdata) == tx4939_pcic1ptr) {
 		switch (slot) {
@@ -70,7 +70,7 @@ int __init tx4939_pcic1_map_irq(const struct pci_dev *dev, u8 slot)
 	return -1;
 }
 
-int __init tx4939_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int __init tx4939_pci_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int irq = tx4939_pcic1_map_irq(dev, slot);
 
diff --git a/arch/mips/txx9/generic/pci.c b/arch/mips/txx9/generic/pci.c
index 7b637a7..27104f7 100644
--- a/arch/mips/txx9/generic/pci.c
+++ b/arch/mips/txx9/generic/pci.c
@@ -382,7 +382,7 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 	return 0;
 }
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return txx9_board_vec->pci_map_irq(dev, slot, pin);
 }
-- 
1.6.0.4
