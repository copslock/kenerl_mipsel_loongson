From: Gabor Juhos <juhosg@openwrt.org>
Date: Mon, 12 May 2014 11:15:22 +0200
Subject: [PATCH] MIPS: RC32434: fix broken PCI resource initialization
Message-ID: <20140512091522.zW7IKmeS803jcC7shs1KJi8a1-4QKHmvfdrWppMKTc4@z>

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


--------------090309060908060203070607--
