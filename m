Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Feb 2007 02:43:30 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.173]:35935 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20038990AbXBECnZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Feb 2007 02:43:25 +0000
Received: by ug-out-1314.google.com with SMTP id 40so1300409uga
        for <linux-mips@linux-mips.org>; Sun, 04 Feb 2007 18:42:25 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=OJ+OxNmTatvZWwK17A32rzOGV56gXhAcOHrCLIWPDpHzgqUpHCFMdylN5riApFX/Ej7HE+VTfgTMFvAQ95cFnYgDLmyHyywzLJFlqiAR9m3EcOk7Zkaygl5aYaNlDHD3ocBItIjsCtkjpVluDeF3aI18dcJlRdw+UKMYE14C82k=
Received: by 10.67.20.3 with SMTP id x3mr8108577ugi.1170643345058;
        Sun, 04 Feb 2007 18:42:25 -0800 (PST)
Received: from darwish-laptop ( [196.218.207.19])
        by mx.google.com with ESMTP id l33sm7666281ugc.2007.02.04.18.42.22;
        Sun, 04 Feb 2007 18:42:24 -0800 (PST)
Received: by darwish-laptop (sSMTP sendmail emulation); Mon,  5 Feb 2007 04:42:11 +0200
Date:	Mon, 5 Feb 2007 04:42:11 +0200
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:	linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.20] arch MIPS: user ARRAY_SIZE macro when appropriate
Message-ID: <20070205024211.GK18118@Ahmed>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070205023935.GG18118@Ahmed>
User-Agent: Mutt/1.5.11
From:	"Ahmed S. Darwish" <darwish.07@gmail.com>
Return-Path: <darwish.07@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: darwish.07@gmail.com
Precedence: bulk
X-list: linux-mips

Hi all,

A patch to use ARRAY_SIZE macro already defined in linux/kernel.h

Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
---
Patch isn't compile checked cause I have no MIPS board at hand.
Thanks,

diff --git a/arch/mips/jmr3927/rbhma3100/setup.c b/arch/mips/jmr3927/rbhma3100/setup.c
index 138f25e..7ca3d6d 100644
--- a/arch/mips/jmr3927/rbhma3100/setup.c
+++ b/arch/mips/jmr3927/rbhma3100/setup.c
@@ -434,7 +434,7 @@ void __init tx3927_setup(void)
 
 	/* DMA */
 	tx3927_dmaptr->mcr = 0;
-	for (i = 0; i < sizeof(tx3927_dmaptr->ch) / sizeof(tx3927_dmaptr->ch[0]); i++) {
+	for (i = 0; i < ARRAY_SIZE(tx3927_dmaptr->ch); i++) {
 		/* reset channel */
 		tx3927_dmaptr->ch[i].ccr = TX3927_DMA_CCR_CHRST;
 		tx3927_dmaptr->ch[i].ccr = 0;
diff --git a/arch/mips/arc/identify.c b/arch/mips/arc/identify.c
index 3ba7c47..4b90736 100644
--- a/arch/mips/arc/identify.c
+++ b/arch/mips/arc/identify.c
@@ -77,7 +77,7 @@ static struct smatch * __init string_to_mach(const char *s)
 {
 	int i;
 
-	for (i = 0; i < (sizeof(mach_table) / sizeof (mach_table[0])); i++) {
+	for (i = 0; i < ARRAY_SIZE(mach_table); i++) {
 		if (!strcmp(s, mach_table[i].arcname))
 			return &mach_table[i];
 	}
diff --git a/arch/mips/mips-boards/atlas/atlas_int.c b/arch/mips/mips-boards/atlas/atlas_int.c
index 43dba6c..4929f4d 100644
--- a/arch/mips/mips-boards/atlas/atlas_int.c
+++ b/arch/mips/mips-boards/atlas/atlas_int.c
@@ -32,6 +32,7 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
+#include <linux/kernel.h>
 
 #include <asm/gdb-stub.h>
 #include <asm/io.h>
@@ -220,7 +221,7 @@ msc_irqmap_t __initdata msc_irqmap[] = {
 	{MSC01C_INT_TMR,		MSC01_IRQ_EDGE, 0},
 	{MSC01C_INT_PCI,		MSC01_IRQ_LEVEL, 0},
 };
-int __initdata msc_nr_irqs = sizeof(msc_irqmap) / sizeof(*msc_irqmap);
+int __initdata msc_nr_irqs = ARRAY_SIZE(msc_irqmap);
 
 msc_irqmap_t __initdata msc_eicirqmap[] = {
 	{MSC01E_INT_SW0,		MSC01_IRQ_LEVEL, 0},
@@ -231,7 +232,7 @@ msc_irqmap_t __initdata msc_eicirqmap[] = {
 	{MSC01E_INT_PERFCTR,		MSC01_IRQ_LEVEL, 0},
 	{MSC01E_INT_CPUCTR,		MSC01_IRQ_LEVEL, 0}
 };
-int __initdata msc_nr_eicirqs = sizeof(msc_eicirqmap) / sizeof(*msc_eicirqmap);
+int __initdata msc_nr_eicirqs = ARRAY_SIZE(msc_eicirqmap);
 
 void __init arch_init_irq(void)
 {
diff --git a/arch/mips/mips-boards/malta/malta_int.c b/arch/mips/mips-boards/malta/malta_int.c
index 90ad5bf..b28edf5 100644
--- a/arch/mips/mips-boards/malta/malta_int.c
+++ b/arch/mips/mips-boards/malta/malta_int.c
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
+#include <linux/kernel.h>
 #include <linux/random.h>
 
 #include <asm/i8259.h>
@@ -289,7 +290,7 @@ msc_irqmap_t __initdata msc_irqmap[] = {
 	{MSC01C_INT_TMR,		MSC01_IRQ_EDGE, 0},
 	{MSC01C_INT_PCI,		MSC01_IRQ_LEVEL, 0},
 };
-int __initdata msc_nr_irqs = sizeof(msc_irqmap)/sizeof(msc_irqmap_t);
+int __initdata msc_nr_irqs = ARRAY_SIZE(msc_irqmap);
 
 msc_irqmap_t __initdata msc_eicirqmap[] = {
 	{MSC01E_INT_SW0,		MSC01_IRQ_LEVEL, 0},
@@ -303,7 +304,7 @@ msc_irqmap_t __initdata msc_eicirqmap[] = {
 	{MSC01E_INT_PERFCTR,		MSC01_IRQ_LEVEL, 0},
 	{MSC01E_INT_CPUCTR,		MSC01_IRQ_LEVEL, 0}
 };
-int __initdata msc_nr_eicirqs = sizeof(msc_eicirqmap)/sizeof(msc_irqmap_t);
+int __initdata msc_nr_eicirqs = ARRAY_SIZE(msc_eicirqmap);
 
 void __init arch_init_irq(void)
 {
diff --git a/arch/mips/pci/fixup-vr4133.c b/arch/mips/pci/fixup-vr4133.c
index 597b897..6e09f38 100644
--- a/arch/mips/pci/fixup-vr4133.c
+++ b/arch/mips/pci/fixup-vr4133.c
@@ -17,6 +17,7 @@
  */
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/kernel.h>
 
 #include <asm/io.h>
 #include <asm/vr41xx/cmbvr4133.h>
@@ -142,7 +143,7 @@ int rockhopper_get_irq(struct pci_dev *dev, u8 pin, u8 slot)
 	if (bus == NULL)
 		return -1;
 
-	for (i = 0; i < sizeof (int_map) / sizeof (int_map[0]); i++) {
+	for (i = 0; i < ARRAY_SIZE(int_map); i++) {
 		if (int_map[i].bus == bus->number && int_map[i].slot == slot) {
 			int line;
 			for (line = 0; line < 4; line++)

-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
