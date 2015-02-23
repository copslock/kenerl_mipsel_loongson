Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Feb 2015 17:36:26 +0100 (CET)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:43849
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27006773AbbBWQgZaJsqe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Feb 2015 17:36:25 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH 1/2] MIPS: ralink: fix bad config symbol in pci makefile
Date:   Mon, 23 Feb 2015 06:17:32 +0100
Message-Id: <1424668653-60990-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

A wrong symbol is referenced by commit 187c26ddf0b2 ("MIPS: ralink: add rt2880
pci driver"). Fix this by changing it to the correct symbol.

Signed-off-by: John Crispin <blogic@openwrt.org>
Reported-by: Paul Bolle <pebolle@tiscali.nl>
Cc: linux-mips@linux-mips.org
---
 arch/mips/pci/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index 300591c..2eda01e 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -43,7 +43,7 @@ obj-$(CONFIG_SIBYTE_BCM1x80)	+= pci-bcm1480.o pci-bcm1480ht.o
 obj-$(CONFIG_SNI_RM)		+= fixup-sni.o ops-sni.o
 obj-$(CONFIG_LANTIQ)		+= fixup-lantiq.o
 obj-$(CONFIG_PCI_LANTIQ)	+= pci-lantiq.o ops-lantiq.o
-obj-$(CONFIG_SOC_RT2880)	+= pci-rt2880.o
+obj-$(CONFIG_SOC_RT288X)	+= pci-rt2880.o
 obj-$(CONFIG_SOC_RT3883)	+= pci-rt3883.o
 obj-$(CONFIG_TANBAC_TB0219)	+= fixup-tb0219.o
 obj-$(CONFIG_TANBAC_TB0226)	+= fixup-tb0226.o
-- 
1.7.10.4
