From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date: Sat, 30 Aug 2014 06:06:25 +0400
Subject: MIPS: MSP71xx: remove odd locking in PCI config space access code
Message-ID: <20140830020625.91EKulgdu7qqvX0pLsbne-FQiDwlfYpqG3lQV2iJDIw@z>

From: Sergey Ryazanov <ryazanov.s.a@gmail.com>

commit c4a305374bbf36414515d2ae00d588c67051e67d upstream.

Caller (generic PCI code) already do proper locking so no need to add
another one here.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Linux MIPS <linux-mips@linux-mips.org>
Patchwork: https://patchwork.linux-mips.org/patch/7601/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/pci/ops-pmcmsp.c |   12 ------------
 1 file changed, 12 deletions(-)

--- a/arch/mips/pci/ops-pmcmsp.c
+++ b/arch/mips/pci/ops-pmcmsp.c
@@ -193,8 +193,6 @@ static void pci_proc_init(void)
 }
 #endif /* CONFIG_PROC_FS && PCI_COUNTERS */
 
-static DEFINE_SPINLOCK(bpci_lock);
-
 /*****************************************************************************
  *
  *  STRUCT: pci_io_resource
@@ -368,7 +366,6 @@ int msp_pcibios_config_access(unsigned c
 	struct msp_pci_regs *preg = (void *)PCI_BASE_REG;
 	unsigned char bus_num = bus->number;
 	unsigned char dev_fn = (unsigned char)devfn;
-	unsigned long flags;
 	unsigned long intr;
 	unsigned long value;
 	static char pciirqflag;
@@ -401,10 +398,7 @@ int msp_pcibios_config_access(unsigned c
 	}
 
 #if defined(CONFIG_PMC_MSP7120_GW) || defined(CONFIG_PMC_MSP7120_EVAL)
-	local_irq_save(flags);
 	vpe_status = dvpe();
-#else
-	spin_lock_irqsave(&bpci_lock, flags);
 #endif
 
 	/*
@@ -457,9 +451,6 @@ int msp_pcibios_config_access(unsigned c
 
 #if defined(CONFIG_PMC_MSP7120_GW) || defined(CONFIG_PMC_MSP7120_EVAL)
 		evpe(vpe_status);
-		local_irq_restore(flags);
-#else
-		spin_unlock_irqrestore(&bpci_lock, flags);
 #endif
 
 		return -1;
@@ -467,9 +458,6 @@ int msp_pcibios_config_access(unsigned c
 
 #if defined(CONFIG_PMC_MSP7120_GW) || defined(CONFIG_PMC_MSP7120_EVAL)
 	evpe(vpe_status);
-	local_irq_restore(flags);
-#else
-	spin_unlock_irqrestore(&bpci_lock, flags);
 #endif
 
 	return PCIBIOS_SUCCESSFUL;


Patches currently in stable-queue which might be from ryazanov.s.a@gmail.com are

queue-3.18/mips-msp71xx-remove-odd-locking-in-pci-config-space-access-code.patch
