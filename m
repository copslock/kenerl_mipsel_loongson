Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Apr 2012 18:56:07 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15266 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903715Ab2D3Qz7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Apr 2012 18:55:59 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4f9ec46b0000>; Mon, 30 Apr 2012 09:57:20 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 30 Apr 2012 09:55:25 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 30 Apr 2012 09:55:25 -0700
Message-ID: <4F9EC3FD.4010109@cavium.com>
Date:   Mon, 30 Apr 2012 09:55:25 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 02/14] MIPS: pci: parse memory ranges from devicetree
References: <1335785589-32532-1-git-send-email-blogic@openwrt.org> <1335785589-32532-2-git-send-email-blogic@openwrt.org>
In-Reply-To: <1335785589-32532-2-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Apr 2012 16:55:25.0634 (UTC) FILETIME=[0A0F7A20:01CD26F2]
X-archive-position: 33096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 04/30/2012 04:32 AM, John Crispin wrote:
> Implement pci_load_OF_ranges on MIPS. Due to lack of test hardware only 32bit bus
> width is supported. This function is based on the implementation found on powerpc.
>
> Signed-off-by: John Crispin<blogic@openwrt.org>
> ---
>   arch/mips/include/asm/pci.h |   12 +++++++++
>   arch/mips/pci/pci.c         |   57 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 69 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
> index fcd4060..fdc47c5 100644
> --- a/arch/mips/include/asm/pci.h
> +++ b/arch/mips/include/asm/pci.h
> @@ -17,6 +17,9 @@
>    */
>
>   #include<linux/ioport.h>
> +#ifdef CONFIG_OF
> +#include<linux/of.h>
> +#endif
>

No need for the #ifdef here.



>   /*
>    * Each pci channel is a top-level PCI bus seem by CPU.  A machine  with
> @@ -26,6 +29,9 @@
>   struct pci_controller {
>   	struct pci_controller *next;
>   	struct pci_bus *bus;
> +#ifdef CONFIG_OF
> +	struct device_node *of_node;
> +#endif
>

Probably no #ifdef here either.

>   	struct pci_ops *pci_ops;
>   	struct resource *mem_resource;
> @@ -142,4 +148,10 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
>
>   extern char * (*pcibios_plat_setup)(char *str);
>
> +#ifdef CONFIG_OF
> +/* this function parses memory ranges from a device node */
> +extern void __devinit pci_load_OF_ranges(struct pci_controller *hose,
> +					 struct device_node *node);
> +#endif

Again, no #ifdef.

> +
>   #endif /* _ASM_PCI_H */
> diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
> index 0514866..e211819 100644
> --- a/arch/mips/pci/pci.c
> +++ b/arch/mips/pci/pci.c
> @@ -16,6 +16,7 @@
>   #include<linux/init.h>
>   #include<linux/types.h>
>   #include<linux/pci.h>
> +#include<linux/of_address.h>
>
>   #include<asm/cpu-info.h>
>
> @@ -114,8 +115,64 @@ static void __devinit pcibios_scanbus(struct pci_controller *hose)
>   			pci_bus_assign_resources(bus);
>   			pci_enable_bridges(bus);
>   		}
> +#ifdef CONFIG_OF
> +		bus->dev.of_node = hose->of_node;
> +#endif

Same here.

> +	}
> +}
> +
> +#ifdef CONFIG_OF
> +void __devinit pci_load_OF_ranges(struct pci_controller *hose,
> +				struct device_node *node)
> +{

s/load_OF/load_of/


> +	const __be32 *ranges;
> +	int rlen;
> +	int pna = of_n_addr_cells(node);
> +	int np = pna + 5;
> +
> +	pr_info("PCI host bridge %s ranges:\n", node->full_name);
> +	ranges = of_get_property(node, "ranges",&rlen);
> +	if (ranges == NULL)
> +		return;
> +	hose->of_node = node;
> +
> +	while ((rlen -= np * 4)>= 0) {
> +		u32 pci_space;
> +		struct resource *res = 0;
> +		unsigned long long addr, size;
> +
> +		pci_space = ranges[0];
> +		addr = of_translate_address(node, ranges + 3);
> +		size = of_read_number(ranges + pna + 3, 2);

All of this should be able to be replaced with of_get_address();

There is a bunch of of/pci related infrastructure.  Can any of it be 
leveraged?


> +		ranges += np;
> +		switch ((pci_space>>  24)&  0x3) {
> +		case 1:		/* PCI IO space */
> +			pr_info("  IO 0x%016llx..0x%016llx\n",
> +					addr, addr + size - 1);
> +			hose->io_map_base =
> +				(unsigned long)ioremap(addr, size);
> +			res = hose->io_resource;
> +			res->flags = IORESOURCE_IO;
> +			break;
> +		case 2:		/* PCI Memory space */
> +		case 3:		/* PCI 64 bits Memory space */
> +			pr_info(" MEM 0x%016llx..0x%016llx\n",
> +					addr, addr + size - 1);
> +			res = hose->mem_resource;
> +			res->flags = IORESOURCE_MEM;
> +			break;
> +		}
> +		if (res != NULL) {
> +			res->start = addr;
> +			res->name = node->full_name;
> +			res->end = res->start + size - 1;
> +			res->parent = NULL;
> +			res->sibling = NULL;
> +			res->child = NULL;
> +		}
>   	}
>   }
> +#endif
>
>   static DEFINE_MUTEX(pci_scan_mutex);
>
