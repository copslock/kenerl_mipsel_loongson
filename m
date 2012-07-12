Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2012 22:54:26 +0200 (CEST)
Received: from postler.einfach.org ([86.59.21.13]:49211 "EHLO
        postler.einfach.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903841Ab2GLUyU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Jul 2012 22:54:20 +0200
Received: from localhost.localdomain (82.Red-83-44-208.dynamicIP.rima-tde.net [83.44.208.82])
        by postler.einfach.org (Postfix) with ESMTPSA id C38A521421EB;
        Thu, 12 Jul 2012 22:54:13 +0200 (CEST)
From:   Bruno Randolf <br1@einfach.org>
To:     linux-mips@linux-mips.org
Cc:     manuel.lauss@googlemail.com, ralf@linux-mips.org,
        florian@openwrt.org, br1@einfach.org
Subject: [PATCH] mtx-1: add udelay to mtx1_pci_idsel
Date:   Thu, 12 Jul 2012 21:54:05 +0100
Message-Id: <1342126445-13408-1-git-send-email-br1@einfach.org>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 33896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: br1@einfach.org
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

Without this udelay(1) PCI idsel does not work correctly on the "singleboard"
(T-Mobile Surfbox) for the MiniPCI device. The result is that PCI configuration
fails and the MiniPCI card is not detected correctly. Instead of

PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [mem 0x40000000-0x4fffffff]
pci_bus 0000:00: root bus resource [io  0x1000-0xffff]
pci 0000:00:03.0: BAR 0: assigned [mem 0x40000000-0x4000ffff]
pci 0000:00:00.0: BAR 0: assigned [mem 0x40010000-0x40010fff]
pci 0000:00:00.1: BAR 0: assigned [mem 0x40011000-0x40011fff]

We see only the CardBus device:

PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [mem 0x40000000-0x4fffffff]
pci_bus 0000:00: root bus resource [io  0x1000-0xffff]
pci 0000:00:00.0: BAR 0: assigned [mem 0x40000000-0x40000fff]
pci 0000:00:00.1: BAR 0: assigned [mem 0x40001000-0x40001fff]

Later the device driver shows this error:

ath5k 0000:00:03.0: cannot remap PCI memory region
ath5k: probe of 0000:00:03.0 failed with error -5

I assume that the logic chip which usually supresses the signal to the CardBus
card has some settling time and without the delay it would still let the
Cardbus interfere with the response from the MiniPCI card.

What I cannot explain is why this behaviour shows up now and not in earlier
kernel versions before. Maybe older PCI code was slower?

Signed-off-by: Bruno Randolf <br1@einfach.org>
---
 arch/mips/alchemy/board-mtx1.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/alchemy/board-mtx1.c b/arch/mips/alchemy/board-mtx1.c
index 295f1a9..e107a2f 100644
--- a/arch/mips/alchemy/board-mtx1.c
+++ b/arch/mips/alchemy/board-mtx1.c
@@ -228,6 +228,8 @@ static int mtx1_pci_idsel(unsigned int devsel, int assert)
 	 * adapter on the mtx-1 "singleboard" variant. It triggers a custom
 	 * logic chip connected to EXT_IO3 (GPIO1) to suppress IDSEL signals.
 	 */
+	udelay(1);
+
 	if (assert && devsel != 0)
 		/* Suppress signal to Cardbus */
 		alchemy_gpio_set_value(1, 0);	/* set EXT_IO3 OFF */
-- 
1.7.9.5
