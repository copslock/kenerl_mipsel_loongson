Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jul 2008 17:13:04 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:22261 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28588454AbYGGQMs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 7 Jul 2008 17:12:48 +0100
Received: from localhost (p7140-ipad206funabasi.chiba.ocn.ne.jp [222.145.81.140])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id EB4F7A6F4; Tue,  8 Jul 2008 01:12:42 +0900 (JST)
Date:	Tue, 08 Jul 2008 01:14:26 +0900 (JST)
Message-Id: <20080708.011426.08077033.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH] Remove never used pci_probe variable
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080419.003435.26096353.anemo@mba.ocn.ne.jp>
References: <20080419.003435.26096353.anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Nobody overwrite pci_probe.  Remove it.  Also make
pcibios_assign_all_busses weak so that platform code can overwrite it.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
Revised against current linux-queue tree.

 arch/mips/pci/pci.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 9dd6e01..a3dcfd4 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -21,10 +21,6 @@
  */
 int pci_probe_only;
 
-#define PCI_ASSIGN_ALL_BUSSES	1
-
-unsigned int pci_probe = PCI_ASSIGN_ALL_BUSSES;
-
 /*
  * The PCI controller list.
  */
@@ -221,9 +217,9 @@ void pcibios_set_master(struct pci_dev *dev)
 	pci_write_config_byte(dev, PCI_LATENCY_TIMER, lat);
 }
 
-unsigned int pcibios_assign_all_busses(void)
+unsigned int __weak pcibios_assign_all_busses(void)
 {
-	return (pci_probe & PCI_ASSIGN_ALL_BUSSES) ? 1 : 0;
+	return 1;
 }
 
 int __weak pcibios_plat_dev_init(struct pci_dev *dev)
