Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8K1qqL10140
	for linux-mips-outgoing; Wed, 19 Sep 2001 18:52:52 -0700
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8K1qne10137
	for <linux-mips@oss.sgi.com>; Wed, 19 Sep 2001 18:52:49 -0700
Message-Id: <200109200152.f8K1qne10137@oss.sgi.com>
Received: (qmail 11527 invoked from network); 20 Sep 2001 01:47:02 -0000
Received: from unknown (HELO heart1) (159.226.39.162)
  by 159.226.39.4 with SMTP; 20 Sep 2001 01:47:02 -0000
Date: Thu, 20 Sep 2001 9:52:0 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: Jun Sun <jsun@mvista.com>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re: 8259 spurious interrupt (IRQ1,IRQ7,IRQ12..)
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f8K1qoe10138
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,Jun Sun£¬

ÔÚ 2001-09-19 12:39:00 you wrote£º
>
>> >It is typically much easier to modify PCI device BARS so that they do coincide
>> >with the same physical address.   You can control that by using the correct
>> >starting address for PCI MEM space in pci_auto.c resource assignment.
>> It seems a good way to solve the ioremap problem and X problem.But virt_to_bus
>> & bus_to_virt problem remains?
>> 
>
>What is the virt_to_bus() problem?  Is the address beyond 512MB (phy addr)? 
No,I mean problem caused different cpu & pci address space.from pci's view,
the main memory is at address 0x80000000-0x90000000 in p6032.But for cpu,
they are 0x0-0x10000000.So current virt_to_bus & bus_to_virt won't work.

>If PCI mem (BUS) address is identical to phy addr, you should not have problem
>unless the address is beyond 512MB.
yes:).When i solve the 8259,i will try to make them same.
>
>BTW, virt_to_bus()/bus_to_virt() are deprecicated.  See
>Documentation/DMA-mapping.txt.
I think the "depreciated" is only for direct usage: they are used in
arch/mips/pci-dma.c to implement new interface pci_alloc_consistent.
And there are still many driver using them(grep tell me).Am i missing
something?
>
>Jun

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
