Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jun 2008 00:03:27 +0100 (BST)
Received: from outbound-mail-159.bluehost.com ([67.222.39.39]:44476 "HELO
	outbound-mail-159.bluehost.com") by ftp.linux-mips.org with SMTP
	id S28575237AbYFYXDR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jun 2008 00:03:17 +0100
Received: (qmail 8181 invoked by uid 0); 25 Jun 2008 23:03:12 -0000
Received: from unknown (HELO box128.bluehost.com) (69.89.22.128)
  by outboundproxy5.bluehost.com with SMTP; 25 Jun 2008 23:03:12 -0000
Received: from [75.111.27.49] (helo=[192.168.1.157])
	by box128.bluehost.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <jbarnes@virtuousgeek.org>)
	id 1KBe19-0004gC-TV; Wed, 25 Jun 2008 17:03:12 -0600
From:	Jesse Barnes <jbarnes@virtuousgeek.org>
To:	Adrian Bunk <bunk@kernel.org>
Subject: Re: [2.6 patch] remove pcibios_update_resource() functions
Date:	Wed, 25 Jun 2008 16:02:49 -0700
User-Agent: KMail/1.9.9
Cc:	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dhowells@redhat.com, gerg@uclinux.org, ralf@linux-mips.org,
	linux-mips@linux-mips.org, lethal@linux-sh.org,
	linux-sh@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>
References: <20080617223332.GM25911@cs181133002.pp.htv.fi>
In-Reply-To: <20080617223332.GM25911@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200806251602.49856.jbarnes@virtuousgeek.org>
X-Identified-User: {642:box128.bluehost.com:virtuous:virtuousgeek.org} {sentby:smtp auth 75.111.27.49 authed with jbarnes@virtuousgeek.org}
DomainKey-Status: no signature
Return-Path: <jbarnes@virtuousgeek.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbarnes@virtuousgeek.org
Precedence: bulk
X-list: linux-mips

On Tuesday, June 17, 2008 3:33 pm Adrian Bunk wrote:
> Russell King did the following back in 2003:
>
> <--  snip  -->
>
>     [PCI] pci-9: Kill per-architecture pcibios_update_resource()
>
>     Kill pcibios_update_resource(), replacing it with
> pci_update_resource(). pci_update_resource() uses pcibios_resource_to_bus()
> to convert a resource to a device BAR - the transformation should be
> exactly the same as the transformation used for the PCI bridges.

Ralf, I assume you're ok with this?

Thanks,
Jesse

> diff --git a/arch/mips/pmc-sierra/yosemite/ht.c
> b/arch/mips/pmc-sierra/yosemite/ht.c index 6380662..678388f 100644
> --- a/arch/mips/pmc-sierra/yosemite/ht.c
> +++ b/arch/mips/pmc-sierra/yosemite/ht.c
> @@ -345,42 +345,6 @@ int pcibios_enable_device(struct pci_dev *dev, int
> mask) return pcibios_enable_resources(dev);
>  }
>
> -
> -
> -void pcibios_update_resource(struct pci_dev *dev, struct resource *root,
> -                             struct resource *res, int resource)
> -{
> -        u32 new, check;
> -        int reg;
> -
> -        return;
> -
> -        new = res->start | (res->flags & PCI_REGION_FLAG_MASK);
> -        if (resource < 6) {
> -                reg = PCI_BASE_ADDRESS_0 + 4 * resource;
> -        } else if (resource == PCI_ROM_RESOURCE) {
> -		res->flags |= IORESOURCE_ROM_ENABLE;
> -                reg = dev->rom_base_reg;
> -        } else {
> -                /*
> -                 * Somebody might have asked allocation of a non-standard
> -                 * resource
> -                 */
> -                return;
> -        }
> -
> -        pci_write_config_dword(dev, reg, new);
> -        pci_read_config_dword(dev, reg, &check);
> -        if ((new ^ check) &
> -            ((new & PCI_BASE_ADDRESS_SPACE_IO) ? PCI_BASE_ADDRESS_IO_MASK
> : -             PCI_BASE_ADDRESS_MEM_MASK)) {
> -                printk(KERN_ERR "PCI: Error while updating region "
> -                       "%s/%d (%08x != %08x)\n", pci_name(dev), resource,
> -                       new, check);
> -        }
> -}
> -
> -
>  void pcibios_align_resource(void *data, struct resource *res,
>                              resource_size_t size, resource_size_t align)
>  {
