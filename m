Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jun 2012 20:02:49 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:44075 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903773Ab2F2SCl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Jun 2012 20:02:41 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SkfWb-0002UH-Kg; Fri, 29 Jun 2012 13:02:33 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH] MIPS: Turn on PCI 2.1 compatability for Malta's PIIX4 controller.
Date:   Fri, 29 Jun 2012 13:02:27 -0500
Message-Id: <1340992947-3445-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.11.1
X-archive-position: 33867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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

From: "Steven J. Hill" <sjhill@mips.com>

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/mti-malta/malta-setup.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index 2e28f65..f3532bf 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -222,3 +222,17 @@ void __init plat_mem_setup(void)
 	board_be_init = malta_be_init;
 	board_be_handler = malta_be_handler;
 }
+
+/* Enable PCI 2.1 compatibility in PIIX4. */
+static void __init quirk_dlcsetup(struct pci_dev *dev)
+{
+	u8 dlc;
+
+	/* Enable passive releases and delayed transactions. */
+	(void) pci_read_config_byte(dev, 0x82, &dlc);
+	dlc |= 7;
+	(void) pci_write_config_byte(dev, 0x82, dlc);
+}
+
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_0,
+			quirk_dlcsetup);
-- 
1.7.11.1
