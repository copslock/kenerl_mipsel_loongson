Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8KHFUM28833
	for linux-mips-outgoing; Thu, 20 Sep 2001 10:15:30 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8KHFQe28829
	for <linux-mips@oss.sgi.com>; Thu, 20 Sep 2001 10:15:26 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f8KHIlA16959;
	Thu, 20 Sep 2001 10:18:47 -0700
Message-ID: <3BAA2255.BF8F432@mvista.com>
Date: Thu, 20 Sep 2001 10:07:33 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zhang Fuxin <fxzhang@ict.ac.cn>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: 8259 spurious interrupt (IRQ1,IRQ7,IRQ12..)
References: <200109191747.KAA12583@messenger.mvista.com>
Content-Type: text/plain; charset=iso-8859-1
X-MIME-Autoconverted: from 8bit to quoted-printable by hermes.mvista.com id f8KHIlA16959
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f8KHFQe28830
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Zhang Fuxin wrote:
> 
> hi,Jun Sun£¬
> 
> ÔÚ 2001-09-19 12:39:00 you wrote£º
> >
> >> >It is typically much easier to modify PCI device BARS so that they do coincide
> >> >with the same physical address.   You can control that by using the correct
> >> >starting address for PCI MEM space in pci_auto.c resource assignment.
> >> It seems a good way to solve the ioremap problem and X problem.But virt_to_bus
> >> & bus_to_virt problem remains?
> >>
> >
> >What is the virt_to_bus() problem?  Is the address beyond 512MB (phy addr)?
> No,I mean problem caused different cpu & pci address space.from pci's view,
> the main memory is at address 0x80000000-0x90000000 in p6032.But for cpu,
> they are 0x0-0x10000000.So current virt_to_bus & bus_to_virt won't work.
> 

You should make sys memory appears starting from 0x0 in PCI memory as well. 
That was part of what I meant by making PCI memory address and CPU physical
address identical.

> >If PCI mem (BUS) address is identical to phy addr, you should not have problem
> >unless the address is beyond 512MB.
> yes:).When i solve the 8259,i will try to make them same.
> >
> >BTW, virt_to_bus()/bus_to_virt() are deprecicated.  See
> >Documentation/DMA-mapping.txt.
> I think the "depreciated" is only for direct usage: they are used in
> arch/mips/pci-dma.c to implement new interface pci_alloc_consistent.
> And there are still many driver using them(grep tell me).Am i missing
> something?

Hmm, I am not too sure here.  My understanding is any new driver should try
*not* to use it.  pci-dma.c may use it because of lack of other means or just
a quick hack.

Jun
