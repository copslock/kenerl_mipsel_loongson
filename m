Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2007 15:23:57 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:30403 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28573739AbXARPXw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 18 Jan 2007 15:23:52 +0000
Received: from localhost (p1212-ipad02funabasi.chiba.ocn.ne.jp [61.214.21.212])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 04C09B614; Fri, 19 Jan 2007 00:23:47 +0900 (JST)
Date:	Fri, 19 Jan 2007 00:23:46 +0900 (JST)
Message-Id: <20070119.002346.74752797.anemo@mba.ocn.ne.jp>
To:	linux-kernel@vger.kernel.org
Cc:	linux-mips@linux-mips.org, akpm@osdl.org, ralf@linux-mips.org
Subject: [PATCH] Make CARDBUS_MEM_SIZE and CARDBUS_IO_SIZE customizable
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

CARDBUS_MEM_SIZE was increased to 64MB on 2.6.20-rc2, but larger size
might result in allocation failure for the reserving itself on some
platforms (for example typical 32bit MIPS).  Make it (and
CARDBUS_IO_SIZE too) customizable for such platforms.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 3cfb0a3..6085d3d 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -60,3 +60,19 @@ config HT_IRQ
 	   This allows native hypertransport devices to use interrupts.
 
 	   If unsure say Y.
+
+config PCI_CARDBUS_IO_SIZE
+	int "CardBus IO window size (bytes)"
+	depends on PCI
+	default "256"
+	help
+	  A fixed amount of bus space is reserved for CardBus bridges.
+	  The default value is 256 bytes.
+
+config PCI_CARDBUS_MEM_SIZE
+	int "CardBus Memory window size (megabytes)"
+	depends on PCI
+	default "64"
+	help
+	  A fixed amount of bus space is reserved for CardBus bridges.
+	  The default value is 64 megabytes.
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 89f3036..046c87b 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -40,8 +40,8 @@
  * FIXME: IO should be max 256 bytes.  However, since we may
  * have a P2P bridge below a cardbus bridge, we need 4K.
  */
-#define CARDBUS_IO_SIZE		(256)
-#define CARDBUS_MEM_SIZE	(64*1024*1024)
+#define CARDBUS_IO_SIZE		CONFIG_PCI_CARDBUS_IO_SIZE
+#define CARDBUS_MEM_SIZE	(CONFIG_PCI_CARDBUS_MEM_SIZE * 1024 * 1024)
 
 static void __devinit
 pbus_assign_resources_sorted(struct pci_bus *bus)
