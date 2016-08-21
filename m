Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Aug 2016 22:00:23 +0200 (CEST)
Received: from mail1.windriver.com ([147.11.146.13]:41945 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992318AbcHUT6yQdW0n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Aug 2016 21:58:54 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id u7LJwlVD020526
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 21 Aug 2016 12:58:47 -0700 (PDT)
Received: from yow-lpgnfs-02.wrs.com (128.224.149.8) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.248.2; Sun, 21 Aug 2016 12:58:47 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4/5] mips/pci: Audit and remove any unnecessary uses of module.h
Date:   Sun, 21 Aug 2016 15:58:16 -0400
Message-ID: <20160821195817.5802-5-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.8.4
In-Reply-To: <20160821195817.5802-1-paul.gortmaker@windriver.com>
References: <20160821195817.5802-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

Historically a lot of these existed because we did not have
a distinction between what was modular code and what was providing
support to modules via EXPORT_SYMBOL and friends.  That changed
when we forked out support for the latter into the export.h file.

This means we should be able to reduce the usage of module.h
in code that is obj-y Makefile or bool Kconfig.  The advantage
in doing so is that module.h itself sources about 15 other headers;
adding significantly to what we feed cpp, and it can obscure what
headers we are effectively using.

Since module.h was the source for init.h (for __init) and for
export.h (for EXPORT_SYMBOL) we consider each obj-y/bool instance
for the presence of either and replace as needed.

We also needed to remove the no-op MODULE_DEVICE_TABLE usage in
several instances to permit removal of the module.h include.  The
files in these instances were all controlled by bool Kconfig.

In one instance, module_param was being used so we transition the
module.h include onto a moduleparam.h include.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/mips/pci/pci-ar71xx.c  | 2 +-
 arch/mips/pci/pci-ar724x.c  | 2 +-
 arch/mips/pci/pci-lantiq.c  | 2 --
 arch/mips/pci/pci-mt7620.c  | 2 --
 arch/mips/pci/pci-rt2880.c  | 2 --
 arch/mips/pci/pci-rt3883.c  | 2 --
 arch/mips/pci/pcie-octeon.c | 2 +-
 7 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/mips/pci/pci-ar71xx.c b/arch/mips/pci/pci-ar71xx.c
index 7db963deec73..bdf87b43633f 100644
--- a/arch/mips/pci/pci-ar71xx.c
+++ b/arch/mips/pci/pci-ar71xx.c
@@ -18,7 +18,7 @@
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
 #include <linux/interrupt.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/platform_device.h>
 
 #include <asm/mach-ath79/ar71xx_regs.h>
diff --git a/arch/mips/pci/pci-ar724x.c b/arch/mips/pci/pci-ar724x.c
index 2013dad700df..1e23c8d587bd 100644
--- a/arch/mips/pci/pci-ar724x.c
+++ b/arch/mips/pci/pci-ar724x.c
@@ -11,7 +11,7 @@
 
 #include <linux/irq.h>
 #include <linux/pci.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/platform_device.h>
 #include <asm/mach-ath79/ath79.h>
 #include <asm/mach-ath79/ar71xx_regs.h>
diff --git a/arch/mips/pci/pci-lantiq.c b/arch/mips/pci/pci-lantiq.c
index b9deab17ccf2..f18f887f481d 100644
--- a/arch/mips/pci/pci-lantiq.c
+++ b/arch/mips/pci/pci-lantiq.c
@@ -13,7 +13,6 @@
 #include <linux/delay.h>
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
-#include <linux/module.h>
 #include <linux/clk.h>
 #include <linux/of_platform.h>
 #include <linux/of_gpio.h>
@@ -234,7 +233,6 @@ static const struct of_device_id ltq_pci_match[] = {
 	{ .compatible = "lantiq,pci-xway" },
 	{},
 };
-MODULE_DEVICE_TABLE(of, ltq_pci_match);
 
 static struct platform_driver ltq_pci_driver = {
 	.probe = ltq_pci_probe,
diff --git a/arch/mips/pci/pci-mt7620.c b/arch/mips/pci/pci-mt7620.c
index eb39826a62c3..628c5132b3d8 100644
--- a/arch/mips/pci/pci-mt7620.c
+++ b/arch/mips/pci/pci-mt7620.c
@@ -15,7 +15,6 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
@@ -407,7 +406,6 @@ static const struct of_device_id mt7620_pci_ids[] = {
 	{ .compatible = "mediatek,mt7620-pci" },
 	{},
 };
-MODULE_DEVICE_TABLE(of, mt7620_pci_ids);
 
 static struct platform_driver mt7620_pci_driver = {
 	.probe = mt7620_pci_probe,
diff --git a/arch/mips/pci/pci-rt2880.c b/arch/mips/pci/pci-rt2880.c
index f2a1050168d9..d6360fe73d05 100644
--- a/arch/mips/pci/pci-rt2880.c
+++ b/arch/mips/pci/pci-rt2880.c
@@ -16,7 +16,6 @@
 #include <linux/pci.h>
 #include <linux/io.h>
 #include <linux/init.h>
-#include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
@@ -260,7 +259,6 @@ static const struct of_device_id rt288x_pci_match[] = {
 	{ .compatible = "ralink,rt288x-pci" },
 	{},
 };
-MODULE_DEVICE_TABLE(of, rt288x_pci_match);
 
 static struct platform_driver rt288x_pci_driver = {
 	.probe = rt288x_pci_probe,
diff --git a/arch/mips/pci/pci-rt3883.c b/arch/mips/pci/pci-rt3883.c
index 53a42b07008b..3520e9b414e7 100644
--- a/arch/mips/pci/pci-rt3883.c
+++ b/arch/mips/pci/pci-rt3883.c
@@ -16,7 +16,6 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
@@ -580,7 +579,6 @@ static const struct of_device_id rt3883_pci_ids[] = {
 	{ .compatible = "ralink,rt3883-pci" },
 	{},
 };
-MODULE_DEVICE_TABLE(of, rt3883_pci_ids);
 
 static struct platform_driver rt3883_pci_driver = {
 	.probe = rt3883_pci_probe,
diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
index 99f3db4f0a9b..9f672ceb089b 100644
--- a/arch/mips/pci/pcie-octeon.c
+++ b/arch/mips/pci/pcie-octeon.c
@@ -11,7 +11,7 @@
 #include <linux/interrupt.h>
 #include <linux/time.h>
 #include <linux/delay.h>
-#include <linux/module.h>
+#include <linux/moduleparam.h>
 
 #include <asm/octeon/octeon.h>
 #include <asm/octeon/cvmx-npei-defs.h>
-- 
2.8.4
