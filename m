Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Mar 2013 22:23:50 +0100 (CET)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:47384 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823463Ab3CDVXtZ9fsl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Mar 2013 22:23:49 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id 8710221B629;
        Mon,  4 Mar 2013 23:23:48 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id GdM5BBehNt1n; Mon,  4 Mar 2013 23:23:48 +0200 (EET)
Received: from blackmetal.pp.htv.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp6.welho.com (Postfix) with ESMTP id 140795BC004;
        Mon,  4 Mar 2013 23:23:48 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>, stable@vger.kernel.org
Subject: [PATCH RESEND] MIPS: loongson: fix random early boot hang
Date:   Mon,  4 Mar 2013 23:23:29 +0200
Message-Id: <1362432209-25673-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 35844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Some Loongson boards (e.g. Lemote FuLoong mini-PC) use ISA/southbridge
device (CS5536 general purpose timer) for the timer interrupt. It starts
running early and is already enabled during the PCI configuration,
during which there is a small window in pci_read_base() when the register
access is temporarily disabled. If the timer interrupts at this point,
the system will hang. Fix this by adding a fixup that keeps the register
access always enabled.

The hang the patch fixes usually looks like this:

[    0.844000] pci 0000:00:0e.0: [1022:2090] type 00 class 0x060100
[    0.848000] pci 0000:00:0e.0: reg 10: [io  0xb410-0xb417]
[    0.852000] pci 0000:00:0e.0: reg 14: [io  0xb000-0xb0ff]
[    0.856000] pci 0000:00:0e.0: reg 18: [io  0xb380-0xb3bf]
[   28.140000] BUG: soft lockup - CPU#0 stuck for 23s! [swapper:1]
[   28.140000] Modules linked in:
[   28.140000] irq event stamp: 37965
[   28.140000] hardirqs last  enabled at (37964): [<ffffffff80204c0c>] restore_partial+0x6c/0x13c
[   28.140000] hardirqs last disabled at (37965): [<ffffffff80204f8c>] handle_int+0x144/0x15c
[   28.140000] softirqs last  enabled at (24316): [<ffffffff802381f4>] __do_softirq+0x1cc/0x258
[   28.140000] softirqs last disabled at (24327): [<ffffffff80238420>] do_softirq+0xc8/0xd0
[   28.140000] Cpu 0
[   28.140000] $ 0   : 0000000000000000 00000000140044e1 980000009f090000 0000000000000001
[   28.140000] $ 4   : 980000009f090000 0000000000000000 0000000000000100 03b7fff87fbde011
[   28.140000] $ 8   : ffffffff812b1928 000000000001e000 043ffff87fbde011 fffffff87fbde011
[   28.140000] $12   : 000000000000000e ffffffff807a0000 0000000000000698 0000000000000000
[   28.140000] $16   : 0000000000000002 ffffffff81055e20 ffffffff80786810 0000000000000000
[   28.140000] $20   : 000000000000000a ffffffff807bc244 ffffffff807e6350 ffffffff80770000
[   28.140000] $24   : 0000000000000d80 00000000fffedbe0
[   28.140000] $28   : 980000009f07c000 980000009f07fa10 ffffffff81050000 ffffffff802380f8
[   28.140000] Hi    : 0000000000d0fc00
[   28.140000] Lo    : 0000000000f82b40
[   28.140000] epc   : ffffffff8023810c __do_softirq+0xe4/0x258
[   28.140000]     Not tainted
[   28.140000] ra    : ffffffff802380f8 __do_softirq+0xd0/0x258
[   28.140000] Status: 140044e3    KX SX UX KERNEL EXL IE
[   28.140000] Cause : 10008400
[   28.140000] PrId  : 00006303 (ICT Loongson-2)

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: stable@vger.kernel.org
---
 arch/mips/loongson/common/cs5536/cs5536_isa.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/mips/loongson/common/cs5536/cs5536_isa.c b/arch/mips/loongson/common/cs5536/cs5536_isa.c
index a6eb2e8..924be39 100644
--- a/arch/mips/loongson/common/cs5536/cs5536_isa.c
+++ b/arch/mips/loongson/common/cs5536/cs5536_isa.c
@@ -13,6 +13,7 @@
  * option) any later version.
  */
 
+#include <linux/pci.h>
 #include <cs5536/cs5536.h>
 #include <cs5536/cs5536_pci.h>
 
@@ -314,3 +315,16 @@ u32 pci_isa_read_reg(int reg)
 
 	return conf_data;
 }
+
+/*
+ * The mfgpt timer interrupt is running early, so we must keep the south bridge
+ * mmio always enabled. Otherwise we may race with the PCI configuration which
+ * may temporarily disable it. When that happens and the timer interrupt fires,
+ * we are not able to clear it and the system will hang.
+ */
+static void cs5536_isa_mmio_always_on(struct pci_dev *dev)
+{
+	dev->mmio_always_on = 1;
+}
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_ISA,
+	PCI_CLASS_BRIDGE_ISA, 8, cs5536_isa_mmio_always_on);
-- 
1.7.10.4
