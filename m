Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Dec 2003 07:23:03 +0000 (GMT)
Received: from bay7-f118.bay7.hotmail.com ([IPv6:::ffff:64.4.11.118]:47378
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225405AbTLTHW6>; Sat, 20 Dec 2003 07:22:58 +0000
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Fri, 19 Dec 2003 23:22:49 -0800
Received: from 203.196.146.243 by by7fd.bay7.hotmail.msn.com with HTTP;
	Sat, 20 Dec 2003 07:22:49 GMT
X-Originating-IP: [203.196.146.243]
X-Originating-Email: [samavarthy@hotmail.com]
X-Sender: samavarthy@hotmail.com
From: "samavarthy c" <samavarthy@hotmail.com>
To: jsun@mvista.com
Cc: linux-mips@linux-mips.org
Subject: Re: USB on MIPS
Date: Sat, 20 Dec 2003 12:52:49 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY7-F118dxVHYEuZFk0002aaf6@hotmail.com>
X-OriginalArrivalTime: 20 Dec 2003 07:22:49.0746 (UTC) FILETIME=[12CA7F20:01C3C6CA]
Return-Path: <samavarthy@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: samavarthy@hotmail.com
Precedence: bulk
X-list: linux-mips

I have setup the clock properly.

The IRQ number is also setup. I have no PCI card at all. But the kernel has 
support for Rockhopper board.

I tried using the wmb (), but doesn't work.

Thank you all for the suggestions. I have given a brief explanation of what 
I am actually trying to acheive. May be this would help you to help me.

The MediaQ controller chip does not sit on the pci bus. The specification 
says that the chip address space ranges from xxx00000h to xxx80000h.

This address space is broken into three regions.

1. The lower 256 Kbyte region (xxx00000h to xxx40000h) maps to the 256 Kbyte 
internal SRAM and contains the graphics frame buffer.
2. The next region (xxx40000h to xxx42000h) is the 8 Kbyte register space, 
which is located just above the frame buffer.
3. The third region, (xxx42000h to xxx80000h) consisting of the remaining 
248 Kbyte of address space is also mapped to the upper 248 Kbyte of internal 
SRAM. This address space is used to access non-graphics frame buffer memory 
such as buffers for USB.

So The MediaQ is supposed to use the third region for storing the TD's and 
ED's basically its HCCA area. On MIPS VR4131 the start address of the third 
region would be 0xAA042000h. This is what I think I am supposed to fill in 
the HCCA register. Am I right?

Well now coming to the sources. The sources files that I have modified till 
now are usb-ohci.c, usb-ohci-nonpci.c. under the drivers/usb directory.

In "usb-ohci-nonpci.c" a function called "nonpci_ohci_init()" was modified 
as to initialize the MediaQ controller.
The segment of code below was commented in the function as I was getting an 
error "controller already in use". The ohci_base value passed was 0xAA040500 
which is where the Host controllers registers of MediaQ are mapped.
-----------------------------------------------------------------------------------------------------
if (!request_mem_region (ohci_base, ohci_len, "usb-ohci"))
	{
		dbg ("controller already in use");
		return -EBUSY;
	}
	mem_base = ioremap_nocache (ohci_base, ohci_len);

	if (!mem_base) {
		err("Error mapping OHCI memory");
		return -EFAULT;
	}
-------------------------------------------------------------------------------------------------
and so hardcoded mem_base as 0xAA040500.

In "usb-ohci.c" the function "hc_alloc_ohci ()" was modified. The following 
peice of code was commented because the address returned by 
"pci_alloc_consistent" was not in range of 0xAA042000h - 0xAA080000h.
----------------------------------------------------------------------------------------------------------
ohci->hcca = pci_alloc_consistent (dev, sizeof *ohci->hcca,
			&ohci->hcca_dma);

        if (!ohci->hcca)
		{
                kfree (ohci);
                return NULL;
      	}
------------------------------------------------------------------------------------------------------------

The value of "ohci->hcca_dma" is what that is actually written to the HCCA 
register.
And hence I hard coded the values of ohci->hcca and ohci->hcca_dma to 
0xAA042000h.
With these updations I am getting the errors

-----------------------------------------------------------------
hub.c: USB new device connect on bus1/1, assigned device number 2
usb-ohci.c: unlink URB timeout
usb.c: USB device not accepting new address=2 (error=-145)
hub.c: USB new device connect on bus1/1, assigned device number 3
usb_control/bulk_msg: timeout
usb-ohci.c: unlink URB timeout
usb.c: USB device not accepting new address=3 (error=-145)
-------------------------------------------------------------------

Also the file usb-ohci.h uses "pci_pool_create()",  "pci_pool_alloc ()" and 
such functions. Do I need to modify all these functions?. Let me know if I 
am doing something wrong. Are there any workarounds for this?.

Thank again,
aks


>From: Jun Sun <jsun@mvista.com>
>To: samavarthy c <samavarthy@hotmail.com>
>CC: linux-mips@linux-mips.org, jsun@mvista.com
>Subject: Re: USB on MIPS
>Date: Thu, 18 Dec 2003 09:43:21 -0800
>
>On Thu, Dec 18, 2003 at 07:58:36PM +0530, samavarthy c wrote:
> > Hi,
> >
> > I am working on a PDA based board which has a NEC MIPS VR4131
> > processor.
> > The board has a companion chip MediaQ 1132 which has OHCI support
> > builtin.
> > The kernel used is MontaVista HardHat 2.4.18. I am trying to configure
> > MQ1132 for USB Host support. It looks like the Host controller
> > (MQ1132) is initialized properly but not sure. When I plug in a USB
> > stick on to the USB port, I get the following messages.
> > -----------------------------------------------------------------
> > hub.c: USB new device connect on bus1/1, assigned device number 2
> > usb-ohci.c: unlink URB timeout
> > usb.c: USB device not accepting new address=2 (error=-145)
> >
> > hub.c: USB new device connect on bus1/1, assigned device number 3
> > usb_control/bulk_msg: timeout
> > usb-ohci.c: unlink URB timeout
> > usb.c: USB device not accepting new address=3 (error=-145)
> > -------------------------------------------------------------------
> > Has anyone experienced the same out there. Could any one suggest how
> > to debug this error. What could be the problem?.
> >
>
>Another possiblity (which is probably more likely) is the IRQ
>number is not seupt correctly.
>
>Are you using Rokchopper II baseboard?  If so, single-function
>PCI card should work properly w.r.t. IRQ.  If you are using other
>backplan or using multi-function pci card, you need to some IRQ
>fixup.
>
>Jun

_________________________________________________________________
Marriage? http://www.bharatmatrimony.com/cgi-bin/bmclicks1.cgi?74 Join 
BharatMatrimony.com for free.
