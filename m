Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Dec 2011 11:46:18 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:5772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903562Ab1LDKqJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 4 Dec 2011 11:46:09 +0100
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pB4Ak6V1022564
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sun, 4 Dec 2011 05:46:07 -0500
Received: from redhat.com (vpn-202-5.tlv.redhat.com [10.35.202.5])
        by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id pB4Ak3OF014316;
        Sun, 4 Dec 2011 05:46:05 -0500
Date:   Sun, 4 Dec 2011 12:47:48 +0200
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH-RFC 06/10] mips: switch to GENERIC_PCI_IOMAP
Message-ID: <20111204104748.GH15464@redhat.com>
References: <cover.1322163031.git.mst@redhat.com>
 <66457f7750d7d14229fcf8d0b011aba63185a75d.1322163031.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66457f7750d7d14229fcf8d0b011aba63185a75d.1322163031.git.mst@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
X-archive-position: 32019
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mst@redhat.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 2487

On Thu, Nov 24, 2011 at 10:18:37PM +0200, Michael S. Tsirkin wrote:
> mips copied pci_iomap from generic code, probably to avoid
> pulling the rest of iomap.c in.  Since that's in
> a separate file now, we can reuse the common implementation.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---

Sorry to nag, any ACKs/NACKs on the mips part?
I intend to send this to Linus if there are no
objections. Thanks!

>  arch/mips/Kconfig         |    1 +
>  arch/mips/lib/iomap-pci.c |   26 --------------------------
>  2 files changed, 1 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index d46f1da..b70c96f 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2317,6 +2317,7 @@ config PCI
>  	bool "Support for PCI controller"
>  	depends on HW_HAS_PCI
>  	select PCI_DOMAINS
> +	select GENERIC_PCI_IOMAP
>  	help
>  	  Find out whether you have a PCI motherboard. PCI is the name of a
>  	  bus system, i.e. the way the CPU talks to the other stuff inside
> diff --git a/arch/mips/lib/iomap-pci.c b/arch/mips/lib/iomap-pci.c
> index 2ab899c..2635b1a 100644
> --- a/arch/mips/lib/iomap-pci.c
> +++ b/arch/mips/lib/iomap-pci.c
> @@ -40,32 +40,6 @@ static void __iomem *ioport_map_pci(struct pci_dev *dev,
>  	return (void __iomem *) (ctrl->io_map_base + port);
>  }
>  
> -/*
> - * Create a virtual mapping cookie for a PCI BAR (memory or IO)
> - */
> -void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
> -{
> -	resource_size_t start = pci_resource_start(dev, bar);
> -	resource_size_t len = pci_resource_len(dev, bar);
> -	unsigned long flags = pci_resource_flags(dev, bar);
> -
> -	if (!len || !start)
> -		return NULL;
> -	if (maxlen && len > maxlen)
> -		len = maxlen;
> -	if (flags & IORESOURCE_IO)
> -		return ioport_map_pci(dev, start, len);
> -	if (flags & IORESOURCE_MEM) {
> -		if (flags & IORESOURCE_CACHEABLE)
> -			return ioremap(start, len);
> -		return ioremap_nocache(start, len);
> -	}
> -	/* What? */
> -	return NULL;
> -}
> -
> -EXPORT_SYMBOL(pci_iomap);
> -
>  void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
>  {
>  	iounmap(addr);
> -- 
> 1.7.5.53.gc233e
