Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Mar 2003 18:09:04 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:52208 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8224847AbTCXSJD>;
	Mon, 24 Mar 2003 18:09:03 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h2OI8tV29471;
	Mon, 24 Mar 2003 10:08:55 -0800
Date: Mon, 24 Mar 2003 10:08:55 -0800
From: Jun Sun <jsun@mvista.com>
To: "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: Proposed patch for MIPS PCI autoscanning code...
Message-ID: <20030324100855.M1926@mvista.com>
References: <3E7F2BB4.8060108@realitydiluted.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E7F2BB4.8060108@realitydiluted.com>; from sjhill@realitydiluted.com on Mon, Mar 24, 2003 at 11:00:52AM -0500
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1800
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Mon, Mar 24, 2003 at 11:00:52AM -0500, Steven J. Hill wrote:
> In the PCI autoscanning code for MIPS the assumption is made that the
> generic 'pci_read_XXX' and 'pci_write_XXX' will suffice when initially
> autoscanning the bus. These functions are defined in the main top-level
> PCI code. For one of my platforms, this simply does not hold since the
> platform specific PCI functions defined in the 'pci_ops' structure for
> the 'mips_pci_channel' need to be used. I propose the following patch
> to fix this. Comments before I apply this?
>

Can you illustrate more why the generic PCI functions won't work in your
case?

Also, if you do check in the patch, please also update all the boards
that uses pci_channel so that they will still compile. 

Jun


> --- pci_channel.h	2001-08-18 10:19:34.000000000 -0400
> +++ pci_channel.h.new	2003-03-24 10:54:29.000000000 -0500
> @@ -11,12 +11,13 @@
>  #include <linux/pci.h>
>  
>  /*
> - * Each pci channel is a top-level PCI bus seem by CPU.  A machine  with
> + * Each pci channel is a top-level PCI bus seen by CPU.  A machine  with
>   * multiple PCI channels may have multiple PCI host controllers or a
>   * single controller supporting multiple channels.
>   */
>  struct pci_channel {
>  	struct pci_ops *pci_ops;
> +	struct pci_ops *early_pci_ops;
>  	struct resource *io_resource;
>  	struct resource *mem_resource;
>  	int first_devfn;

> --- pci_auto.c	2001-11-26 20:07:06.000000000 -0500
> +++ pci_auto.c.new	2003-03-24 10:54:14.000000000 -0500
> @@ -74,9 +74,14 @@
>  int early_##rw##_config_##size(struct pci_channel *hose,		\
>  	int top_bus, int bus, int devfn, int offset, type value)	\
>  {									\
> -	return pci_##rw##_config_##size(				\
> -		fake_pci_dev(hose, top_bus, bus, devfn),		\
> -		offset, value);						\
> +	if (hose->early_pci_ops->rw##_##size != NULL)			\
> +		return hose->early_pci_ops->rw##_##size(		\
> +			fake_pci_dev(hose, top_bus, bus, devfn),	\
> +			offset, value);					\
> +	else								\
> +		return pci_##rw##_config_##size(			\
> +			fake_pci_dev(hose, top_bus, bus, devfn),	\
> +			offset, value);					\
>  }
>  
>  EARLY_PCI_OP(read, byte, u8 *)
