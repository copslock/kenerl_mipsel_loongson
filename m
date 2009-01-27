Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jan 2009 10:13:13 +0000 (GMT)
Received: from mail.bugwerft.de ([212.112.241.193]:53703 "EHLO
	mail.bugwerft.de") by ftp.linux-mips.org with ESMTP
	id S21102776AbZA0KNL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Jan 2009 10:13:11 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.bugwerft.de (Postfix) with ESMTP id 6554449400C;
	Tue, 27 Jan 2009 11:13:05 +0100 (CET)
Received: from mail.bugwerft.de ([127.0.0.1])
	by localhost (mail.bugwerft.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5PLGHENaW6NQ; Tue, 27 Jan 2009 11:13:05 +0100 (CET)
Received: from [10.1.1.26] (unknown [192.168.22.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bugwerft.de (Postfix) with ESMTP id 9A47C49400B;
	Tue, 27 Jan 2009 11:13:03 +0100 (CET)
Subject: Re: AU1550 Kernel bug detected[#1]  clockevents_register_device
From:	Frank Neuber <linux-mips@kernelport.de>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>,
	Florian Fainelli <florian@openwrt.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
In-Reply-To: <20090127091107.GA15890@roarinelk.homelinux.net>
References: <1233045842.28527.459.camel@t60p>
	 <20090127091107.GA15890@roarinelk.homelinux.net>
Content-Type: text/plain
Date:	Tue, 27 Jan 2009 11:13:01 +0100
Message-Id: <1233051181.28527.485.camel@t60p>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.1 
Content-Transfer-Encoding: 7bit
Return-Path: <linux-mips@kernelport.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux-mips@kernelport.de
Precedence: bulk
X-list: linux-mips

Thank you all,
now the head kernel comes up.
Why is that fix not in the git? Maby I use the wrong git repository for
MIPS kernel. At the moment I use the linus git:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git


Am Dienstag, den 27.01.2009, 10:11 +0100 schrieb Manuel Lauss:
> > I just start with head and found a compile error:
> > arch/mips/alchemy/common/time.c:93: error: incompatible types in
> > initialization
> > I comment this line ".cpumask        = CPU_MASK_ALL,"
> 
> you need to change it to "CPU_MASK_ALL_PTR".  Commenting it is not a very
> good idea ;-)
Yea sure, but it was a try ... ;-)

The PCI and PCMCIA problems are going on in the same way:
I tested the CardBus. As you can see the two CardBus bridges maps the
whole PCI memory into. If I plug in something it is not accessable
because the 
yenta_cardbus 0000:00:0d.0: No cardbus resource!
error ...
I think somting is wrong with PCI resource management here.
I can't believe that nobody is using the PCI or Cardbus on the AU1550
with the current kernel.

I can give you a lspci -vvv of the working system 2.6.16.1
---cut---
00:0d.0 Class 0607: 104c:ac55 (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 1
        Region 0: Memory at 0000000048002000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
        Memory window 0: 40000000-41fff000 (prefetchable)
        Memory window 1: 42000000-43fff000 (prefetchable)
        I/O window 0: 00001000-000010ff
        I/O window 1: 00001400-000014ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt- PostWrite-
        16-bit legacy interface ports at 0001
---cut---
And the 2.6.29-rc2
---cut---
00:0d.0 Class 0607: 104c:ac55 (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 9
        Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
        Memory window 0: 40000000-43fff000 (prefetchable)
        Memory window 1: 44000000-47fff000 (prefetchable)
        I/O window 0: 00001000-000010ff
        I/O window 1: 00001400-000014ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt- PostWrite-
        16-bit legacy interface ports at 0001
---cut---
You can see in the current PCI System the Region 0 is missing and the
Memory windows are much more bigger. Also the IRQ is different.
I don't understand this at the moment.

This is the relevant bootlog:
---cut---
pci 0000:00:0c.0: PME# supported from D1 D3hot D3cold
pci 0000:00:0c.0: PME# disabled
pci 0000:00:0c.1: PME# supported from D1 D3hot D3cold
pci 0000:00:0c.1: PME# disabled
pci 0000:00:0c.2: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:0c.2: PME# disabled
pci 0000:00:0d.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:0d.0: PME# disabled
pci 0000:00:0d.1: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:0d.1: PME# disabled
pci 0000:00:0c.0: BAR 0: can't allocate mem resource
[0x50000000-0x4fffffff]
pci 0000:00:0c.1: BAR 0: can't allocate mem resource
[0x50000000-0x4fffffff]
pci 0000:00:0d.0: BAR 0: can't allocate mem resource
[0x50000000-0x4fffffff]
pci 0000:00:0d.1: BAR 0: can't allocate mem resource
[0x50000000-0x4fffffff]
pci 0000:00:0c.2: BAR 0: can't allocate mem resource [0x50000000-0x4fffffff]
pci 0000:00:0d.0: CardBus bridge, secondary bus 0000:01
pci 0000:00:0d.0:   IO window: 0x001000-0x0010ff
pci 0000:00:0d.0:   IO window: 0x001400-0x0014ff
pci 0000:00:0d.0:   PREFETCH window: 0x40000000-0x43ffffff
pci 0000:00:0d.0:   MEM window: 0x44000000-0x47ffffff
pci 0000:00:0d.1: CardBus bridge, secondary bus 0000:05
pci 0000:00:0d.1:   IO window: 0x001800-0x0018ff
pci 0000:00:0d.1:   IO window: 0x001c00-0x001cff
pci 0000:00:0d.1:   PREFETCH window: 0x48000000-0x4bffffff
pci 0000:00:0d.1:   MEM window: 0x4c000000-0x4fffffff
PCI: Enabling device 0000:00:0d.0 (0000 -> 0003)
PCI: Enabling device 0000:00:0d.1 (0000 -> 0003)
---cut---
