Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Feb 2007 16:14:44 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:20989 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038622AbXBVQOi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Feb 2007 16:14:38 +0000
Received: from localhost (p8012-ipad02funabasi.chiba.ocn.ne.jp [61.214.26.12])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 2D953E60; Fri, 23 Feb 2007 01:13:18 +0900 (JST)
Date:	Fri, 23 Feb 2007 01:13:17 +0900 (JST)
Message-Id: <20070223.011317.75185141.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Mark pcibios_fixup_device_resources() as __devinit
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
X-archive-position: 14206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

pcibios_fixup_device_resources() is called by pcibios_fixup_bus()
which is marked as __devinit.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 77d8c50..f901140 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -243,7 +243,7 @@ int pcibios_enable_device(struct pci_dev
 	return pcibios_plat_dev_init(dev);
 }
 
-static void __init pcibios_fixup_device_resources(struct pci_dev *dev,
+static void __devinit pcibios_fixup_device_resources(struct pci_dev *dev,
 	struct pci_bus *bus)
 {
 	/* Update device resources.  */
