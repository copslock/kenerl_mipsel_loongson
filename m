Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Jun 2013 13:12:59 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:44355 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816553Ab3FOLM6AWws7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 15 Jun 2013 13:12:58 +0200
Received: from ixxyvirt.fritz.box (p508AEB32.dip0.t-ipconnect.de [80.138.235.50])
        by mail.nanl.de (Postfix) with ESMTPSA id E63FB40096;
        Sat, 15 Jun 2013 11:12:09 +0000 (UTC)
From:   Jonas Gorski <jogo@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: remove alloc_pci_controller prototype
Date:   Sat, 15 Jun 2013 13:12:46 +0200
Message-Id: <1371294766-14887-1-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Commit 610019baddcb4c4c323c12cd44ca7f73d7145d6f ("[MIPS] Remove unused
function alloc_pci_controller.") removed the function, but left the
prototype in the header file.

Remove it as well so people don't get tempted to use it and wonder why
it doesn't work.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
The commit is from 2005(!) and ended up in 2.6.18.

 arch/mips/include/asm/pci.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index b8e24fd..fa8e0aa 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -52,7 +52,6 @@ struct pci_controller {
 /*
  * Used by boards to register their PCI busses before the actual scanning.
  */
-extern struct pci_controller * alloc_pci_controller(void);
 extern void register_pci_controller(struct pci_controller *hose);
 
 /*
-- 
1.7.10.4
