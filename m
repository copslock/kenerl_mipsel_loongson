Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Oct 2018 14:21:12 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23992066AbeJCMVH6HqjO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Oct 2018 14:21:07 +0200
Date:   Wed, 3 Oct 2018 13:21:07 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] TC: Set DMA masks for devices
Message-ID: <alpine.LFD.2.21.1810030109210.5483@eddie.linux-mips.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

Fix a TURBOchannel support regression with commit 205e1b7f51e4 
("dma-mapping: warn when there is no coherent_dma_mask") that caused 
coherent DMA allocations to produce a warning such as:

defxx: v1.11 2014/07/01  Lawrence V. Stefani and others
tc1: DEFTA at MMIO addr = 0x1e900000, IRQ = 20, Hardware addr = 08-00-2b-a3-a3-29
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516 dfx_dev_register+0x670/0x678
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 4.19.0-rc6 #2
Stack : ffffffff8009ffc0 fffffffffffffec0 0000000000000000 ffffffff80647650
        0000000000000000 0000000000000000 ffffffff806f5f80 ffffffffffffffff
        0000000000000000 0000000000000000 0000000000000001 ffffffff8065d4e8
        98000000031b6300 ffffffff80563478 ffffffff805685b0 ffffffffffffffff
        0000000000000000 ffffffff805d6720 0000000000000204 ffffffff80388df8
        0000000000000000 0000000000000009 ffffffff8053efd0 ffffffff806657d0
        0000000000000000 ffffffff803177f8 0000000000000000 ffffffff806d0000
        9800000003078000 980000000307b9e0 000000001e900000 ffffffff80067940
        0000000000000000 ffffffff805d6720 0000000000000204 ffffffff80388df8
        ffffffff805176c0 ffffffff8004dc78 0000000000000000 ffffffff80067940
        ...
Call Trace:
[<ffffffff8004dc78>] show_stack+0xa0/0x130
[<ffffffff80067940>] __warn+0x128/0x170
---[ end trace b1d1e094f67f3bb2 ]---

This is because the TURBOchannel bus driver fails to set the coherent 
DMA mask for devices enumerated.

Set the regular and coherent DMA masks for TURBOchannel devices then, 
observing that the bus protocol supports a 34-bit (16GiB) DMA address 
space, by interpreting the value presented in the address cycle across 
the 32 `ad' lines as a 32-bit word rather than byte address[1].  The 
architectural size of the TURBOchannel DMA address space exceeds the 
maximum amount of RAM any actual TURBOchannel system in existence may 
have, hence both masks are the same.

This removes the warning shown above.

References:

[1] "TURBOchannel Hardware Specification", EK-369AA-OD-007B, Digital 
    Equipment Corporation, January 1993, Section "DMA", pp. 1-15 -- 1-17

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Fixes: 205e1b7f51e4 ("dma-mapping: warn when there is no coherent_dma_mask")
Cc: stable@vger.kernel.org # 4.16+
---
 drivers/tc/tc.c    |    8 +++++++-
 include/linux/tc.h |    1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

linux-tc-dma-mask.patch
Index: linux-20180930-4maxp64/drivers/tc/tc.c
===================================================================
--- linux-20180930-4maxp64.orig/drivers/tc/tc.c
+++ linux-20180930-4maxp64/drivers/tc/tc.c
@@ -2,7 +2,7 @@
  *	TURBOchannel bus services.
  *
  *	Copyright (c) Harald Koerfgen, 1998
- *	Copyright (c) 2001, 2003, 2005, 2006  Maciej W. Rozycki
+ *	Copyright (c) 2001, 2003, 2005, 2006, 2018  Maciej W. Rozycki
  *	Copyright (c) 2005  James Simmons
  *
  *	This file is subject to the terms and conditions of the GNU
@@ -10,6 +10,7 @@
  *	directory of this archive for more details.
  */
 #include <linux/compiler.h>
+#include <linux/dma-mapping.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
@@ -92,6 +93,11 @@ static void __init tc_bus_add_devices(st
 		tdev->dev.bus = &tc_bus_type;
 		tdev->slot = slot;
 
+		/* TURBOchannel has 34-bit DMA addressing (16GiB space). */
+		tdev->dma_mask = DMA_BIT_MASK(34);
+		tdev->dev.dma_mask = &tdev->dma_mask;
+		tdev->dev.coherent_dma_mask = DMA_BIT_MASK(34);
+
 		for (i = 0; i < 8; i++) {
 			tdev->firmware[i] =
 				readb(module + offset + TC_FIRM_VER + 4 * i);
Index: linux-20180930-4maxp64/include/linux/tc.h
===================================================================
--- linux-20180930-4maxp64.orig/include/linux/tc.h
+++ linux-20180930-4maxp64/include/linux/tc.h
@@ -84,6 +84,7 @@ struct tc_dev {
 					   device. */
 	struct device	dev;		/* Generic device interface. */
 	struct resource	resource;	/* Address space of this device. */
+	u64		dma_mask;	/* DMA addressable range. */
 	char		vendor[9];
 	char		name[9];
 	char		firmware[9];
