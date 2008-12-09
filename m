Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Dec 2008 18:16:14 +0000 (GMT)
Received: from mx1.moondrake.net ([212.85.150.166]:50834 "EHLO
	mx1.mandriva.com") by ftp.linux-mips.org with ESMTP
	id S24207585AbYLISQK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 Dec 2008 18:16:10 +0000
Received: by mx1.mandriva.com (Postfix, from userid 501)
	id 1C1F0274002; Tue,  9 Dec 2008 19:16:06 +0100 (CET)
Received: from office-abk.mandriva.com (office-abk.mandriva.com [84.55.162.90])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.mandriva.com (Postfix) with ESMTP id 1836527400F;
	Tue,  9 Dec 2008 19:16:04 +0100 (CET)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
	by office-abk.mandriva.com (Postfix) with ESMTP id D322E8285F;
	Tue,  9 Dec 2008 19:17:31 +0100 (CET)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
	by anduin.mandriva.com (Postfix) with ESMTP id EB656FF855;
	Tue,  9 Dec 2008 19:17:13 +0100 (CET)
From:	Arnaud Patard <apatard@mandriva.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: xorg-server-1.5.2 doesn't work because of missing sysfs pci resource files
References: <20081205154339.GA14327@adriano.hkcable.com.hk>
	<20081206102030.GA9410@linux-mips.org>
Organization: Mandriva
Date:	Tue, 09 Dec 2008 19:17:13 +0100
In-Reply-To: <20081206102030.GA9410@linux-mips.org> (Ralf Baechle's message of "Sat, 6 Dec 2008 10:20:30 +0000")
Message-ID: <m3k5a9kyc6.fsf@anduin.mandriva.com>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <arnaud.patard@mandriva.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle <ralf@linux-mips.org> writes:

Hi,

> Here is a quick'n'dirty solution which I've not tested beyond just
> compiling.  It should work but performance will be bad.  Either way, I'm
> interested in a test report with X.
>
>   Ralf
>
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

What about things like _CACHE_UNCACHED_ACCELERATED ? Is there a way to
use this flag ?


Arnaud
