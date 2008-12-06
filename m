Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Dec 2008 10:20:34 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:2762 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S24163313AbYLFKUb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 6 Dec 2008 10:20:31 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id mB6AKURM015300
	for <linux-mips@linux-mips.org>; Sat, 6 Dec 2008 10:20:30 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id mB6AKUf1015299
	for linux-mips@linux-mips.org; Sat, 6 Dec 2008 10:20:30 GMT
Date:	Sat, 6 Dec 2008 10:20:30 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Re: xorg-server-1.5.2 doesn't work because of missing sysfs pci
	resource files
Message-ID: <20081206102030.GA9410@linux-mips.org>
References: <20081205154339.GA14327@adriano.hkcable.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081205154339.GA14327@adriano.hkcable.com.hk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Dec 05, 2008 at 11:43:42PM +0800, Zhang Le wrote:

> I have tried xorg-server-1.5.2 on loongson 2f recently.
> But I found it doesn't work.
> It's mainly because of this change:
> http://www.x.org/wiki/PciReworkProposal
> 
> In short:
> "Rather than duplicating the efforts of kernel developers, X.org needs to use the
> interfaces provided by the kernel as much as possible."
> 
> I have read some code of libpciaccess, the new library utilizing kernel function
> to access pci bus. It will try to mmap this file:
> /sys/bus/pci/devices/0000:0x:xx.x/resource0
> (replace x with any digit appropriate)
> Note there is a 0 at the end of the file name. This file's permission is 600.
> 
> However, I found on my loongson system, there is only 
> /sys/bus/pci/devices/0000:0x:xx.x/resource
> Note there is no 0 at the end.
> 
> Then I tried to read kernel code. I found it seems that for mips linux to have
> this file, HAVE_PCI_MMAP must be defined. However, it is currently not defined.
> 
> Since I am not familiar with PCI, yet.
> So could someone please shed some light on this?
> Why HAVE_PCI_MMAP is not defined?

Here is a quick'n'dirty solution which I've not tested beyond just
compiling.  It should work but performance will be bad.  Either way, I'm
interested in a test report with X.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 5510c53..053e463 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -79,6 +79,11 @@ static inline void pcibios_penalize_isa_irq(int irq, int active)
 	/* We don't do dynamic PCI IRQ allocation */
 }
 
+#define HAVE_PCI_MMAP
+
+extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+	enum pci_mmap_state mmap_state, int write_combine);
+
 /*
  * Dynamic DMA mapping stuff.
  * MIPS has everything mapped statically.
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index a377e9d..9233193 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -354,6 +354,22 @@ EXPORT_SYMBOL(PCIBIOS_MIN_IO);
 EXPORT_SYMBOL(PCIBIOS_MIN_MEM);
 #endif
 
+int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+			enum pci_mmap_state mmap_state, int write_combine)
+{
+	unsigned long prot;
+
+	/*
+	 * Ignore write-combine; for now only return uncached mappings.
+	 */
+	prot = pgprot_val(vma->vm_page_prot);
+	prot = (prot & ~_CACHE_MASK) | _CACHE_UNCACHED;
+	vma->vm_page_prot = __pgprot(prot);
+
+	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+		vma->vm_end - vma->vm_start, vma->vm_page_prot);
+}
+
 char * (*pcibios_plat_setup)(char *str) __devinitdata;
 
 char *__devinit pcibios_setup(char *str)
