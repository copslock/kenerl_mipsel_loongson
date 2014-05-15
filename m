Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 May 2014 10:35:54 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:50648 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816841AbaEOIfv1Tn16 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 May 2014 10:35:51 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 962D328032E;
        Thu, 15 May 2014 10:34:31 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Thu, 15 May 2014 10:34:31 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH] MIPS: RC32434: fix broken PCI resource initialization
Date:   Thu, 15 May 2014 10:35:44 +0200
Message-Id: <1400142944-32147-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

The parent field of the 'rc32434_res_pci_mem1' resource points to
the resource itself which is obviously wrong. Due to the broken
initialitazion, the PCI devices on the Mikrotik RB532 boards are
not working since commit 22283178 (MIPS: avoid possible resource
conflict in register_pci_controller).

Remove the field initialization to fix the issue.

Reported-by: Waldemar Brodkorb <wbx@openadk.org>
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/pci/pci-rc32434.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/pci/pci-rc32434.c b/arch/mips/pci/pci-rc32434.c
index b128cb9..7f6ce6d 100644
--- a/arch/mips/pci/pci-rc32434.c
+++ b/arch/mips/pci/pci-rc32434.c
@@ -53,7 +53,6 @@ static struct resource rc32434_res_pci_mem1 = {
 	.start = 0x50000000,
 	.end = 0x5FFFFFFF,
 	.flags = IORESOURCE_MEM,
-	.parent = &rc32434_res_pci_mem1,
 	.sibling = NULL,
 	.child = &rc32434_res_pci_mem2
 };
-- 
1.7.10
