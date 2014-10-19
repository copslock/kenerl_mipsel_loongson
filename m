Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Oct 2014 19:43:28 +0200 (CEST)
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:38158 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011806AbaJSRn0tM3aB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Oct 2014 19:43:26 +0200
Received: from faui48e.informatik.uni-erlangen.de (faui48e.informatik.uni-erlangen.de [131.188.34.51])
        by faui40.informatik.uni-erlangen.de (Postfix) with ESMTP id 439C458C4C8;
        Sun, 19 Oct 2014 19:43:24 +0200 (CEST)
Received: by faui48e.informatik.uni-erlangen.de (Postfix, from userid 31112)
        id BA33F4E0CD8; Sun, 19 Oct 2014 19:43:22 +0200 (CEST)
From:   Stefan Hengelein <stefan.hengelein@fau.de>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, ralf@linux-mips.org,
        Stefan Hengelein <stefan.hengelein@fau.de>
Subject: [PATCH] MIPS: ath79: fix compilation error when CONFIG_PCI is disabled
Date:   Sun, 19 Oct 2014 19:43:14 +0200
Message-Id: <1413740594-15579-1-git-send-email-stefan.hengelein@fau.de>
X-Mailer: git-send-email 1.9.1
Return-Path: <sistheng@faui48e.informatik.uni-erlangen.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stefan.hengelein@fau.de
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

When CONFIG_PCI is disabled, 'db120_pci_init()' had a different
signature than when was enabled. Therefore, compilation failed when
CONFIG_PCI was not present.

arch/mips/ath79/mach-db120.c:132: error: too many arguments to function 'db120_pci_init'

Signed-off-by: Stefan Hengelein <stefan.hengelein@fau.de>
---
 arch/mips/ath79/mach-db120.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/ath79/mach-db120.c b/arch/mips/ath79/mach-db120.c
index 4d661a1..d1a783d 100644
--- a/arch/mips/ath79/mach-db120.c
+++ b/arch/mips/ath79/mach-db120.c
@@ -112,8 +112,6 @@ static void __init db120_pci_init(u8 *eeprom)
 	ath79_pci_set_plat_dev_init(db120_pci_plat_dev_init);
 	ath79_register_pci();
 }
-#else
-static inline void db120_pci_init(void) {}
 #endif /* CONFIG_PCI */
 
 static void __init db120_setup(void)
@@ -129,7 +127,9 @@ static void __init db120_setup(void)
 			   ARRAY_SIZE(db120_spi_info));
 	ath79_register_usb();
 	ath79_register_wmac(art + DB120_WMAC_CALDATA_OFFSET);
+#ifdef CONFIG_PCI
 	db120_pci_init(art + DB120_PCIE_CALDATA_OFFSET);
+#endif
 }
 
 MIPS_MACHINE(ATH79_MACH_DB120, "DB120", "Atheros DB120 reference board",
-- 
1.9.1
