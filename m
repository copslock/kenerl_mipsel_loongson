Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jul 2008 16:58:12 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:44740 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20134230AbYGCP6G (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 3 Jul 2008 16:58:06 +0100
Received: from localhost (p7152-ipad201funabasi.chiba.ocn.ne.jp [222.146.70.152])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id B67E5AA0D; Fri,  4 Jul 2008 00:57:59 +0900 (JST)
Date:	Fri, 04 Jul 2008 00:59:40 +0900 (JST)
Message-Id: <20080704.005940.108121109.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH] Declare some pci variables in header file
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080419.005346.85684007.anemo@mba.ocn.ne.jp>
References: <20080419.005346.85684007.anemo@mba.ocn.ne.jp>
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
X-archive-position: 19715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 19 Apr 2008 00:53:46 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> Declare pci_probe_only, etc. in asm-mips/pci.h file.  This will fix
> some sparse warnings.

Revesed against current linux-queue tree.

------------------------------------------------------
Subject: [PATCH] Declare some pci variables in header file
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Declare pci_probe_only, etc. in asm-mips/pci.h file.  This will fix
some sparse warnings.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/pci/fixup-vr4133.c |    1 -
 arch/mips/pci/pci-bcm1480.c  |    1 -
 arch/mips/pci/pci-ip27.c     |    1 -
 arch/mips/pci/pci-sb1250.c   |    1 -
 include/asm-mips/pci.h       |    3 +++
 5 files changed, 3 insertions(+), 4 deletions(-)

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
index d19d262..a9060c7 100644
--- a/arch/mips/pci/pci-bcm1480.c
+++ b/arch/mips/pci/pci-bcm1480.c
@@ -202,7 +202,6 @@ static int __init bcm1480_pcibios_init(void)
 {
 	uint32_t cmdreg;
 	uint64_t reg;
-	extern int pci_probe_only;
 
 	/* CFE will assign PCI resources */
 	pci_probe_only = 1;
diff --git a/arch/mips/pci/pci-ip27.c b/arch/mips/pci/pci-ip27.c
index a185169..ce92f82 100644
--- a/arch/mips/pci/pci-ip27.c
+++ b/arch/mips/pci/pci-ip27.c
@@ -47,7 +47,6 @@ int __cpuinit bridge_probe(nasid_t nasid, int widget_id, int masterwid)
 	static int num_bridges = 0;
 	bridge_t *bridge;
 	int slot;
-	extern int pci_probe_only;
 
 	pci_probe_only = 1;
 
diff --git a/arch/mips/pci/pci-sb1250.c b/arch/mips/pci/pci-sb1250.c
index 9bc102a..bf63959 100644
--- a/arch/mips/pci/pci-sb1250.c
+++ b/arch/mips/pci/pci-sb1250.c
@@ -210,7 +210,6 @@ static int __init sb1250_pcibios_init(void)
 	void __iomem *io_map_base;
 	uint32_t cmdreg;
 	uint64_t reg;
-	extern int pci_probe_only;
 
 	/* CFE will assign PCI resources */
 	pci_probe_only = 1;
diff --git a/include/asm-mips/pci.h b/include/asm-mips/pci.h
index 301ff2f..d3be834 100644
--- a/include/asm-mips/pci.h
+++ b/include/asm-mips/pci.h
@@ -172,4 +172,7 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 	return channel ? 15 : 14;
 }
 
+extern int pci_probe_only;
+extern unsigned int pcibios_max_latency;
+
 #endif /* _ASM_PCI_H */
