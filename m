Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Dec 2008 16:47:36 +0000 (GMT)
Received: from xylophone.i-cable.com ([203.83.115.99]:46816 "HELO
	xylophone.i-cable.com") by ftp.linux-mips.org with SMTP
	id S24173827AbYLFQra (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 6 Dec 2008 16:47:30 +0000
Received: (qmail 17732 invoked by uid 508); 6 Dec 2008 16:47:21 -0000
Received: from 203.83.114.121 by xylophone (envelope-from <robert.zhangle@gmail.com>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/7737.  
 Clear:RC:1(203.83.114.121):. 
 Processed in 0.194797 secs); 06 Dec 2008 16:47:21 -0000
Received: from ip114121.hkicable.com (HELO silicon.i-cable.com) (203.83.114.121)
  by 0 with SMTP; 6 Dec 2008 16:47:21 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by silicon.i-cable.com (8.13.5/8.13.5) with ESMTP id mB6GlJ3s026490;
	Sun, 7 Dec 2008 00:47:21 +0800 (HKT)
Date:	Sun, 7 Dec 2008 00:47:06 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: xorg-server-1.5.2 doesn't work because of missing sysfs pci
	resource files
Message-ID: <20081206164706.GB14327@adriano.hkcable.com.hk>
Mail-Followup-To: Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
References: <20081205154339.GA14327@adriano.hkcable.com.hk> <20081206102030.GA9410@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081206102030.GA9410@linux-mips.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

On 10:20 Sat 06 Dec     , Ralf Baechle wrote:
> On Fri, Dec 05, 2008 at 11:43:42PM +0800, Zhang Le wrote:
> 
> > I have tried xorg-server-1.5.2 on loongson 2f recently.
> > But I found it doesn't work.
> > It's mainly because of this change:
> > http://www.x.org/wiki/PciReworkProposal
> > 
> > In short:
> > "Rather than duplicating the efforts of kernel developers, X.org needs to use the
> > interfaces provided by the kernel as much as possible."
> > 
> > I have read some code of libpciaccess, the new library utilizing kernel function
> > to access pci bus. It will try to mmap this file:
> > /sys/bus/pci/devices/0000:0x:xx.x/resource0
> > (replace x with any digit appropriate)
> > Note there is a 0 at the end of the file name. This file's permission is 600.
> > 
> > However, I found on my loongson system, there is only 
> > /sys/bus/pci/devices/0000:0x:xx.x/resource
> > Note there is no 0 at the end.
> > 
> > Then I tried to read kernel code. I found it seems that for mips linux to have
> > this file, HAVE_PCI_MMAP must be defined. However, it is currently not defined.
> > 
> > Since I am not familiar with PCI, yet.
> > So could someone please shed some light on this?
> > Why HAVE_PCI_MMAP is not defined?
> 
> Here is a quick'n'dirty solution which I've not tested beyond just
> compiling.  It should work but performance will be bad.  Either way, I'm
> interested in a test report with X.

Thanks, Ralf.
I will test it.

> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
> index 5510c53..053e463 100644
> --- a/arch/mips/include/asm/pci.h
> +++ b/arch/mips/include/asm/pci.h
> @@ -79,6 +79,11 @@ static inline void pcibios_penalize_isa_irq(int irq, int active)
>  	/* We don't do dynamic PCI IRQ allocation */
>  }
>  
> +#define HAVE_PCI_MMAP
> +
> +extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
> +	enum pci_mmap_state mmap_state, int write_combine);
> +
>  /*
>   * Dynamic DMA mapping stuff.
>   * MIPS has everything mapped statically.
> diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
> index a377e9d..9233193 100644
> --- a/arch/mips/pci/pci.c
> +++ b/arch/mips/pci/pci.c
> @@ -354,6 +354,22 @@ EXPORT_SYMBOL(PCIBIOS_MIN_IO);
>  EXPORT_SYMBOL(PCIBIOS_MIN_MEM);
>  #endif
>  
> +int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
> +			enum pci_mmap_state mmap_state, int write_combine)
> +{
> +	unsigned long prot;
> +
> +	/*
> +	 * Ignore write-combine; for now only return uncached mappings.
> +	 */
> +	prot = pgprot_val(vma->vm_page_prot);
> +	prot = (prot & ~_CACHE_MASK) | _CACHE_UNCACHED;
> +	vma->vm_page_prot = __pgprot(prot);
> +
> +	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> +		vma->vm_end - vma->vm_start, vma->vm_page_prot);
> +}
> +
>  char * (*pcibios_plat_setup)(char *str) __devinitdata;
>  
>  char *__devinit pcibios_setup(char *str)
> 

Zhang, Le
