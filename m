Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2017 22:39:06 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:59084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993855AbdJEUippZ7Af (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Oct 2017 22:38:45 +0200
Received: from localhost (unknown [64.22.228.164])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B21C2190B;
        Thu,  5 Oct 2017 20:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B21C2190B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Subject: [PATCH 1/4] PCI: Remove redundant pcibios_set_master() declarations
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Howells <dhowells@redhat.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        linux-am33-list@redhat.com,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Helge Deller <deller@gmx.de>, x86@kernel.org,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Ingo Molnar <mingo@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        linux-xtensa@linux-xtensa.org, Mikael Starvik <starvik@axis.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Henderson <rth@twiddle.net>,
        Chris Zankel <chris@zankel.net>,
        Tony Luck <tony.luck@intel.com>, linux-cris-kernel@axis.com,
        linux-parisc@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>
Date:   Thu, 05 Oct 2017 15:38:42 -0500
Message-ID: <20171005203842.18300.67328.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171005201939.18300.25690.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20171005201939.18300.25690.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <helgaas@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: helgaas@kernel.org
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

From: Bjorn Helgaas <bhelgaas@google.com>

All users of pcibios_set_master() include <linux/pci.h>, which already has
a declaration.  Remove the unnecessary declarations from the <asm/pci.h>
files.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/alpha/include/asm/pci.h   |    2 --
 arch/cris/include/asm/pci.h    |    1 -
 arch/frv/include/asm/pci.h     |    2 --
 arch/mips/include/asm/pci.h    |    2 --
 arch/mn10300/include/asm/pci.h |    2 --
 arch/parisc/include/asm/pci.h  |    1 -
 arch/sh/include/asm/pci.h      |    2 --
 arch/x86/include/asm/pci.h     |    1 -
 8 files changed, 13 deletions(-)

diff --git a/arch/alpha/include/asm/pci.h b/arch/alpha/include/asm/pci.h
index a06c24b3a2e1..777be3114fda 100644
--- a/arch/alpha/include/asm/pci.h
+++ b/arch/alpha/include/asm/pci.h
@@ -56,8 +56,6 @@ struct pci_controller {
 #define PCIBIOS_MIN_IO		alpha_mv.min_io_address
 #define PCIBIOS_MIN_MEM		alpha_mv.min_mem_address
 
-extern void pcibios_set_master(struct pci_dev *dev);
-
 /* IOMMU controls.  */
 
 /* The PCI address space does not equal the physical memory address space.
diff --git a/arch/cris/include/asm/pci.h b/arch/cris/include/asm/pci.h
index 6e505332b3e3..c6ac59d9f815 100644
--- a/arch/cris/include/asm/pci.h
+++ b/arch/cris/include/asm/pci.h
@@ -19,7 +19,6 @@
 void pcibios_config_init(void);
 struct pci_bus * pcibios_scan_root(int bus);
 
-void pcibios_set_master(struct pci_dev *dev);
 struct irq_routing_table *pcibios_get_irq_routing_table(void);
 int pcibios_set_irq_routing(struct pci_dev *dev, int pin, int irq);
 
diff --git a/arch/frv/include/asm/pci.h b/arch/frv/include/asm/pci.h
index 809cfc6707ab..a6957014e74e 100644
--- a/arch/frv/include/asm/pci.h
+++ b/arch/frv/include/asm/pci.h
@@ -21,8 +21,6 @@ struct pci_dev;
 
 #define pcibios_assign_all_busses()	0
 
-extern void pcibios_set_master(struct pci_dev *dev);
-
 #ifdef CONFIG_MMU
 extern void *consistent_alloc(gfp_t gfp, size_t size, dma_addr_t *dma_handle);
 extern void consistent_free(void *vaddr);
diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 52f551ee492d..0f8528c34753 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -106,8 +106,6 @@ extern unsigned long PCIBIOS_MIN_MEM;
 
 #define PCIBIOS_MIN_CARDBUS_IO	0x4000
 
-extern void pcibios_set_master(struct pci_dev *dev);
-
 #define HAVE_PCI_MMAP
 #define ARCH_GENERIC_PCI_MMAP_RESOURCE
 #define HAVE_ARCH_PCI_RESOURCE_TO_USER
diff --git a/arch/mn10300/include/asm/pci.h b/arch/mn10300/include/asm/pci.h
index d27654902f28..bdacb618d6af 100644
--- a/arch/mn10300/include/asm/pci.h
+++ b/arch/mn10300/include/asm/pci.h
@@ -47,8 +47,6 @@ extern void unit_pci_init(void);
 #define PCIBIOS_MIN_IO		0xBE000004
 #define PCIBIOS_MIN_MEM		0xB8000000
 
-void pcibios_set_master(struct pci_dev *dev);
-
 /* Dynamic DMA mapping stuff.
  * i386 has everything mapped statically.
  */
diff --git a/arch/parisc/include/asm/pci.h b/arch/parisc/include/asm/pci.h
index 1de1a3f412ec..b5730f83b941 100644
--- a/arch/parisc/include/asm/pci.h
+++ b/arch/parisc/include/asm/pci.h
@@ -161,7 +161,6 @@ extern struct pci_bios_ops *pci_bios;
 
 #ifdef CONFIG_PCI
 extern void pcibios_register_hba(struct pci_hba_data *);
-extern void pcibios_set_master(struct pci_dev *);
 #else
 static inline void pcibios_register_hba(struct pci_hba_data *x)
 {
diff --git a/arch/sh/include/asm/pci.h b/arch/sh/include/asm/pci.h
index 17fa69bc814d..063c8003b169 100644
--- a/arch/sh/include/asm/pci.h
+++ b/arch/sh/include/asm/pci.h
@@ -68,8 +68,6 @@ struct pci_dev;
 #define HAVE_PCI_MMAP
 #define ARCH_GENERIC_PCI_MMAP_RESOURCE
 
-extern void pcibios_set_master(struct pci_dev *dev);
-
 /* Dynamic DMA mapping stuff.
  * SuperH has everything mapped statically like x86.
  */
diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index 473a7295ab10..645019085bb8 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -91,7 +91,6 @@ extern int pcibios_enabled;
 void pcibios_config_init(void);
 void pcibios_scan_root(int bus);
 
-void pcibios_set_master(struct pci_dev *dev);
 struct irq_routing_table *pcibios_get_irq_routing_table(void);
 int pcibios_set_irq_routing(struct pci_dev *dev, int pin, int irq);
 
