Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2008 15:00:15 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:50641 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28574229AbYHSNz1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Aug 2008 14:55:27 +0100
Received: from localhost.localdomain (p6195-ipad311funabasi.chiba.ocn.ne.jp [123.217.216.195])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3C6B4B5BB; Tue, 19 Aug 2008 22:55:21 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 13/14] TXx9: Add __init tag for tx4938_pcic1_map_irq.
Date:	Tue, 19 Aug 2008 22:55:17 +0900
Message-Id: <1219154118-21193-13-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/pci/pci-tx4938.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/pci/pci-tx4938.c b/arch/mips/pci/pci-tx4938.c
index 60e2c52..1ea257b 100644
--- a/arch/mips/pci/pci-tx4938.c
+++ b/arch/mips/pci/pci-tx4938.c
@@ -114,7 +114,7 @@ int __init tx4938_pciclk66_setup(void)
 	return pciclk;
 }
 
-int tx4938_pcic1_map_irq(const struct pci_dev *dev, u8 slot)
+int __init tx4938_pcic1_map_irq(const struct pci_dev *dev, u8 slot)
 {
 	if (get_tx4927_pcicptr(dev->bus->sysdata) == tx4938_pcic1ptr) {
 		switch (slot) {
-- 
1.5.6.3
