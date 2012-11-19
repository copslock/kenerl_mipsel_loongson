Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Nov 2012 19:30:05 +0100 (CET)
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:32833 "EHLO
        viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825890Ab2KSS2YBBRmK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Nov 2012 19:28:24 +0100
Received: by viridian.itc.virginia.edu (Postfix, from userid 1249)
        id 03182803CA; Mon, 19 Nov 2012 13:27:42 -0500 (EST)
From:   Bill Pemberton <wfp5p@virginia.edu>
To:     gregkh@linuxfoundation.org
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 342/493] mips: remove use of __devinitdata
Date:   Mon, 19 Nov 2012 13:24:51 -0500
Message-Id: <1353349642-3677-342-git-send-email-wfp5p@virginia.edu>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
X-archive-position: 35041
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wfp5p@virginia.edu
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

CONFIG_HOTPLUG is going away as an option so __devinitdata is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: linux-mips@linux-mips.org 
---
 arch/mips/pci/fixup-malta.c   | 4 ++--
 arch/mips/pci/fixup-rc32434.c | 2 +-
 arch/mips/pci/ops-tx4927.c    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/pci/fixup-malta.c b/arch/mips/pci/fixup-malta.c
index 1c1e20d..75d03f6 100644
--- a/arch/mips/pci/fixup-malta.c
+++ b/arch/mips/pci/fixup-malta.c
@@ -8,7 +8,7 @@
 #define PCID		4
 
 /* This table is filled in by interrogating the PIIX4 chip */
-static char pci_irq[5] __devinitdata = {
+static char pci_irq[5] = {
 };
 
 static char irq_tab[][5] __initdata = {
@@ -53,7 +53,7 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 static void malta_piix_func0_fixup(struct pci_dev *pdev)
 {
 	unsigned char reg_val;
-	static int piixirqmap[16] __devinitdata = {  /* PIIX PIRQC[A:D] irq mappings */
+	static int piixirqmap[16] = {  /* PIIX PIRQC[A:D] irq mappings */
 		0,  0, 	0,  3,
 		4,  5,  6,  7,
 		0,  9, 10, 11,
diff --git a/arch/mips/pci/fixup-rc32434.c b/arch/mips/pci/fixup-rc32434.c
index 34a0b91..d0f6ecb 100644
--- a/arch/mips/pci/fixup-rc32434.c
+++ b/arch/mips/pci/fixup-rc32434.c
@@ -32,7 +32,7 @@
 #include <asm/mach-rc32434/rc32434.h>
 #include <asm/mach-rc32434/irq.h>
 
-static int __devinitdata irq_map[2][12] = {
+static int irq_map[2][12] = {
 	{0, 0, 2, 3, 2, 3, 0, 0, 0, 0, 0, 1},
 	{0, 0, 1, 3, 0, 2, 1, 3, 0, 2, 1, 3}
 };
diff --git a/arch/mips/pci/ops-tx4927.c b/arch/mips/pci/ops-tx4927.c
index 9489fa4..0d69d6f 100644
--- a/arch/mips/pci/ops-tx4927.c
+++ b/arch/mips/pci/ops-tx4927.c
@@ -191,7 +191,7 @@ static struct {
 	u8 trdyto;
 	u8 retryto;
 	u16 gbwc;
-} tx4927_pci_opts __devinitdata = {
+} tx4927_pci_opts = {
 	.trdyto = 0,
 	.retryto = 0,
 	.gbwc = 0xfe0,	/* 4064 GBUSCLK for CCFG.GTOT=0b11 */
-- 
1.8.0
