Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Apr 2008 16:53:00 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:36335 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28573768AbYDRPw5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 18 Apr 2008 16:52:57 +0100
Received: from localhost (p1047-ipad304funabasi.chiba.ocn.ne.jp [123.217.155.47])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A162EB175; Sat, 19 Apr 2008 00:52:49 +0900 (JST)
Date:	Sat, 19 Apr 2008 00:53:46 +0900 (JST)
Message-Id: <20080419.005346.85684007.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Declare some pci variables in header file
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
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
X-archive-position: 18959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Declare pci_probe_only, etc. in asm-mips/pci.h file.  This will fix
some sparse warnings.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/pci/fixup-vr4133.c |    1 -
 arch/mips/pci/pci-bcm1480.c  |    1 -
 arch/mips/pci/pci-sb1250.c   |    1 -
 include/asm-mips/pci.h       |    6 ++++++
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/mips/pci/fixup-vr4133.c b/arch/mips/pci/fixup-vr4133.c
index de5e5f6..34e651b 100644
--- a/arch/mips/pci/fixup-vr4133.c
+++ b/arch/mips/pci/fixup-vr4133.c
@@ -171,7 +171,6 @@ void i8259_init(void)
 
 int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-	extern int pci_probe_only;
 	pci_probe_only = 1;
 
 #ifdef CONFIG_ROCKHOPPER
diff --git a/arch/mips/pci/pci-bcm1480.c b/arch/mips/pci/pci-bcm1480.c
index c2a15a1..61b88f9 100644
--- a/arch/mips/pci/pci-bcm1480.c
+++ b/arch/mips/pci/pci-bcm1480.c
@@ -196,7 +196,6 @@ static int __init bcm1480_pcibios_init(void)
 {
 	uint32_t cmdreg;
 	uint64_t reg;
-	extern int pci_probe_only;
 
 	/* CFE will assign PCI resources */
 	pci_probe_only = 1;
diff --git a/arch/mips/pci/pci-sb1250.c b/arch/mips/pci/pci-sb1250.c
index 67a623b..53ee8eb 100644
--- a/arch/mips/pci/pci-sb1250.c
+++ b/arch/mips/pci/pci-sb1250.c
@@ -203,7 +203,6 @@ static int __init sb1250_pcibios_init(void)
 {
 	uint32_t cmdreg;
 	uint64_t reg;
-	extern int pci_probe_only;
 
 	/* CFE will assign PCI resources */
 	pci_probe_only = 1;
diff --git a/include/asm-mips/pci.h b/include/asm-mips/pci.h
index 301ff2f..49a461f 100644
--- a/include/asm-mips/pci.h
+++ b/include/asm-mips/pci.h
@@ -172,4 +172,10 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 	return channel ? 15 : 14;
 }
 
+extern struct pci_controller *hose_head;
+extern struct pci_controller **hose_tail;
+extern struct pci_controller *pci_isa_hose;
+extern int pci_probe_only;
+extern unsigned int pcibios_max_latency;
+
 #endif /* _ASM_PCI_H */
