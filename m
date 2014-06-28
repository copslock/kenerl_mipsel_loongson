Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jun 2014 16:57:06 +0200 (CEST)
Received: from mv-drv-hcb003.ocn.ad.jp ([118.23.109.133]:42498 "EHLO
        mv-drv-hcb003.ocn.ad.jp" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822067AbaF1O5ELUI8- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Jun 2014 16:57:04 +0200
Received: from vcmba.ocn.ne.jp (localhost.localdomain [127.0.0.1])
        by mv-drv-hcb003.ocn.ad.jp (Postfix) with ESMTP id 0C9335642D8;
        Sat, 28 Jun 2014 23:57:01 +0900 (JST)
Received: from anemo-PC-VJ22.flets-east.jp (p16146-ipngn402funabasi.chiba.ocn.ne.jp [180.58.11.146])
        by vcmba.ocn.ne.jp (Postfix) with ESMTP;
        Sat, 28 Jun 2014 23:57:00 +0900 (JST)
From:   Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH] MIPS: TXx9: add __init_refok annotation to quirk_slc90e66_bridge
Date:   Sat, 28 Jun 2014 23:56:57 +0900
Message-Id: <1403967417-4120-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
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

This pci fixup routine calls __init functions.
In general pci fixup routine must not call __init functions,
but this pci/isa bridge device is not hotpluggable anyway.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/generic/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/txx9/generic/pci.c b/arch/mips/txx9/generic/pci.c
index 3c5f180..a77698f 100644
--- a/arch/mips/txx9/generic/pci.c
+++ b/arch/mips/txx9/generic/pci.c
@@ -268,7 +268,7 @@ static int txx9_i8259_irq_setup(int irq)
 	return err;
 }
 
-static void quirk_slc90e66_bridge(struct pci_dev *dev)
+static void __init_refok quirk_slc90e66_bridge(struct pci_dev *dev)
 {
 	int irq;	/* PCI/ISA Bridge interrupt */
 	u8 reg_64;
-- 
1.7.9.5
