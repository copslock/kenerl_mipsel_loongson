Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8IHHIa02427
	for linux-mips-outgoing; Tue, 18 Sep 2001 10:17:18 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8IHHFe02423
	for <linux-mips@oss.sgi.com>; Tue, 18 Sep 2001 10:17:15 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f8IHKcA07361;
	Tue, 18 Sep 2001 10:20:38 -0700
Message-ID: <3BA77FC6.C7ECC151@mvista.com>
Date: Tue, 18 Sep 2001 10:09:26 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zhang Fuxin <fxzhang@ict.ac.cn>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: 8259 spurious interrupt (IRQ1,IRQ7,IRQ12..)
References: <200109181034.f8IAYIe27614@oss.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Zhang Fuxin wrote:
> 
> hi,all
>   I have finally been able to get a copy of sgi cvs code:).Now I have
> changed my p6032 code to use new[time,pci,irq] code and it seems a
> lot cleaner.But still problems.

Cool.  Very glad to hear that.

>   I keep seeing spurious interrupt when starting xwindows.And
> sometimes without x. If the machine is doing heavy io(e.g.,unzip &
> untar mozilla source) when I startx,it will probably enter an
> endless loop of spurious interrupt or lead to unaligned instruction
> access shortly after(with epc=0x1,ra=0x1) and die.
>   I have seen spurious IRQ1,IRQ7 and IRQ12,and the endless loop case
> is IRQ12--ps2 mouse interrupt.
>   Can somebody give me a clue? What I know is that 8259 may generate
> spurious IRQ7 & IRQ15. But how can the others happen,buggy hw?And
> what may cause a kernel unaligned instruction access?

Are you using arch/mips/i8259.c file?

One possibility is your irq dispatching code.  If it loops to deliver all
pending interrupts, what you described may happen (assuming there is a real
hardware connecting to those irq sources).

> 
>   My hw is p6032 rev.B eval board with idtRC64474 cpu.
> 
>   BTW,is that current code has no support for different PCI & CPU
> address space?In p6032 default setting,PCI memory address 0 is
> CPU physical address 0x10000000,and main memory is 0-0x10000000
> for CPU,but 0x80000000-0x90000000 for pci. So I have to change
> ioremap,virt_to_bus & bus_to_virt. I think this problem should
> exist in many nonpc hw,could you point me a clean way?
> 

For now, we do assume PCI memeory space is identical to physical address
space.  To remove the restriction cleanly is not a small task.

It is typically much easier to modify PCI device BARS so that they do coincide
with the same physical address.   You can control that by using the correct
starting address for PCI MEM space in pci_auto.c resource assignment.  

Jun
