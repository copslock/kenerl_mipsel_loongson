Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 15:12:43 +0200 (CEST)
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:45800 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011915AbaJTNMlcQdk0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 15:12:41 +0200
Received: from faui48e.informatik.uni-erlangen.de (faui48e.informatik.uni-erlangen.de [131.188.34.51])
        by faui40.informatik.uni-erlangen.de (Postfix) with ESMTP id F38EB58C4C1;
        Mon, 20 Oct 2014 15:12:40 +0200 (CEST)
Received: by faui48e.informatik.uni-erlangen.de (Postfix, from userid 31112)
        id E03114E0CD8; Mon, 20 Oct 2014 15:12:40 +0200 (CEST)
From:   Stefan Hengelein <stefan.hengelein@fau.de>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, ralf@linux-mips.org,
        geert@linux-m68k.org, Stefan Hengelein <stefan.hengelein@fau.de>
Subject: [PATCH] MIPS: ath79: fix compilation error when CONFIG_PCI is disabled
Date:   Mon, 20 Oct 2014 15:11:39 +0200
Message-Id: <1413810699-44465-1-git-send-email-stefan.hengelein@fau.de>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <CAMuHMdV3cGsW3iONgHHsMgVcoOqjLDoiE5u-+62M=6+fOYsj4Q@mail.gmail.com>
References: <CAMuHMdV3cGsW3iONgHHsMgVcoOqjLDoiE5u-+62M=6+fOYsj4Q@mail.gmail.com>
Return-Path: <sistheng@faui48e.informatik.uni-erlangen.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43351
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

This error was found with vampyr.

Signed-off-by: Stefan Hengelein <stefan.hengelein@fau.de>

---
Changelog:
v2: fix prototype instead of removing the caller
---
 arch/mips/ath79/mach-db120.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ath79/mach-db120.c b/arch/mips/ath79/mach-db120.c
index 4d661a1..9423f5a 100644
--- a/arch/mips/ath79/mach-db120.c
+++ b/arch/mips/ath79/mach-db120.c
@@ -113,7 +113,7 @@ static void __init db120_pci_init(u8 *eeprom)
 	ath79_register_pci();
 }
 #else
-static inline void db120_pci_init(void) {}
+static inline void db120_pci_init(u8 *eeprom) {}
 #endif /* CONFIG_PCI */
 
 static void __init db120_setup(void)
-- 
1.9.1
