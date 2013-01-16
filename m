Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jan 2013 08:07:26 +0100 (CET)
Received: from moutng.kundenserver.de ([212.227.17.10]:56405 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6832221Ab3APHHVYFFg3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jan 2013 08:07:21 +0100
Received: from mailbox.adnet.avionic-design.de (mailbox.avionic-design.de [109.75.18.3])
        by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
        id 0Lr4CZ-1THcUi3Q5D-00eRwP; Wed, 16 Jan 2013 08:07:15 +0100
Received: from localhost (localhost [127.0.0.1])
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTP id E762D2A2815F;
        Wed, 16 Jan 2013 08:07:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at avionic-design.de
Received: from mailbox.adnet.avionic-design.de ([127.0.0.1])
        by localhost (mailbox.avionic-design.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AYJp9or6CKSl; Wed, 16 Jan 2013 08:07:13 +0100 (CET)
Received: from mailman.adnet.avionic-design.de (mailman.adnet.avionic-design.de [172.20.31.172])
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTP id A70E52A28066;
        Wed, 16 Jan 2013 08:07:13 +0100 (CET)
Received: from localhost (avionic-0098.adnet.avionic-design.de [172.20.31.233])
        by mailman.adnet.avionic-design.de (Postfix) with ESMTP id C2E73100424;
        Wed, 16 Jan 2013 08:07:09 +0100 (CET)
From:   Thierry Reding <thierry.reding@avionic-design.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Florian Fainelli <florian@openwrt.org>, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: PNX8550: Fix build failures
Date:   Wed, 16 Jan 2013 08:07:13 +0100
Message-Id: <1358320033-30032-1-git-send-email-thierry.reding@avionic-design.de>
X-Mailer: git-send-email 1.8.1
X-Provags-ID: V02:K0:kD7qVj8EQieDcDxTc/HJam3wEEW03PNeg4RjgMaqiwS
 EvtjNl4leRxZoByrfKqSCS0aBpAY/IDJI2hBPUodZyGXci3c7y
 K4/cWKN2OeYC/lRtkVCK7Lpdb7xFUYTjVRqkhJo4B/FpWfTJ6R
 ycNduMMVPNuvQt3gH6KokLVOAcRNEaArftOp+QKMC5gQLbD8IX
 DDToYrcG4bkJU0NicPVTLFoyHl9Yl+C0x02o67Vd1+OZ/R6JD8
 Wt7W7DXgDit+jTWJHM3KiMaalIYqLEomgwT6MF/ncIaLi9ArJW
 w+NEFBQPXi6r1LAbAmSgrmlUsuWNB+mT9+4fCLNvrvdmnsUHK6
 UaGpebHrjgYPDIFPu6Th1QiDJR2vTgGgEwmBvhmk5Nk3gFB2gS
 l3RK/sbb2OZQQCHs1BkdKH06RmRGXKreu7lSL+1xqzJbw5NyWt
 1VOdp
X-archive-position: 35456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thierry.reding@avionic-design.de
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

The OHCI support code fails to build because the PCI_BASE and udelay()
macros which are defined in pci.h and linux/time.h respectively. Adding
corresponding includes fixes these build failures.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 arch/mips/pnx8550/common/platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/pnx8550/common/platform.c b/arch/mips/pnx8550/common/platform.c
index 0a8faea..9782fde 100644
--- a/arch/mips/pnx8550/common/platform.c
+++ b/arch/mips/pnx8550/common/platform.c
@@ -19,10 +19,12 @@
 #include <linux/resource.h>
 #include <linux/serial.h>
 #include <linux/serial_pnx8xxx.h>
+#include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/usb/ohci_pdriver.h>
 
 #include <int.h>
+#include <pci.h>
 #include <usb.h>
 #include <uart.h>
 
-- 
1.8.1
