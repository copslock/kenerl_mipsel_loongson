Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jun 2014 16:56:09 +0200 (CEST)
Received: from mv-drv-hcb004.ocn.ad.jp ([118.23.109.134]:33583 "EHLO
        mv-drv-hcb004.ocn.ad.jp" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822067AbaF1O4HBU6gi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Jun 2014 16:56:07 +0200
Received: from vcmba.ocn.ne.jp (localhost.localdomain [127.0.0.1])
        by mv-drv-hcb004.ocn.ad.jp (Postfix) with ESMTP id 1375E1B4372;
        Sat, 28 Jun 2014 23:56:04 +0900 (JST)
Received: from anemo-PC-VJ22.flets-east.jp (p16146-ipngn402funabasi.chiba.ocn.ne.jp [180.58.11.146])
        by vcmba.ocn.ne.jp (Postfix) with ESMTP;
        Sat, 28 Jun 2014 23:56:03 +0900 (JST)
From:   Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH] MIPS: TXx9: Fix quirk_slc90e66_ide
Date:   Sat, 28 Jun 2014 23:56:00 +0900
Message-Id: <1403967360-4081-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40903
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

Fix wrong code spotted by -Werror=array-bounds:
	arch/mips/txx9/generic/pci.c:334:23: error: array subscript is above array bounds [-Werror=array-bounds]
	  pci_write_config_byte(dev, regs[i], dat);

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/generic/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/txx9/generic/pci.c b/arch/mips/txx9/generic/pci.c
index 2871327..3c5f180 100644
--- a/arch/mips/txx9/generic/pci.c
+++ b/arch/mips/txx9/generic/pci.c
@@ -331,7 +331,7 @@ static void quirk_slc90e66_ide(struct pci_dev *dev)
 	 * !!! DO NOT REMOVE THIS COMMENT IT IS REQUIRED BY SMSC !!!
 	 */
 	dat |= 0x01;
-	pci_write_config_byte(dev, regs[i], dat);
+	pci_write_config_byte(dev, 0x5c, dat);
 	pci_read_config_byte(dev, 0x5c, &dat);
 	printk(KERN_CONT " REG5C %02x", dat);
 	printk(KERN_CONT "\n");
-- 
1.7.9.5
