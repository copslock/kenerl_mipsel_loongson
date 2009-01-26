Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jan 2009 10:21:49 +0000 (GMT)
Received: from mail.bugwerft.de ([212.112.241.193]:18890 "EHLO
	mail.bugwerft.de") by ftp.linux-mips.org with ESMTP
	id S21189190AbZAZKVq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Jan 2009 10:21:46 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.bugwerft.de (Postfix) with ESMTP id 961958F849D
	for <linux-mips@linux-mips.org>; Mon, 26 Jan 2009 11:21:40 +0100 (CET)
Received: from mail.bugwerft.de ([127.0.0.1])
	by localhost (mail.bugwerft.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bDL3AU3bYx6T for <linux-mips@linux-mips.org>;
	Mon, 26 Jan 2009 11:21:40 +0100 (CET)
Received: from [10.1.1.26] (unknown [192.168.22.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bugwerft.de (Postfix) with ESMTP id AA9788F849C
	for <linux-mips@linux-mips.org>; Mon, 26 Jan 2009 11:21:38 +0100 (CET)
Subject: Au1550 with kernel linux-2.6.28.1 PCI Cardbus mappings too large
From:	Frank Neuber <linux-mips@kernelport.de>
To:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <1232871616.28527.347.camel@t60p>
References: <1232739600.28527.289.camel@t60p>
	 <20090124085734.5b6b5c66@scarran.roarinelk.net>
	 <1232787448.28527.302.camel@t60p>  <1232839224.28527.336.camel@t60p>
	 <1232871616.28527.347.camel@t60p>
Content-Type: text/plain
Date:	Mon, 26 Jan 2009 11:21:36 +0100
Message-Id: <1232965296.28527.427.camel@t60p>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.1 
Content-Transfer-Encoding: 7bit
Return-Path: <linux-mips@kernelport.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux-mips@kernelport.de
Precedence: bulk
X-list: linux-mips

Hello again,
as I sad I want to use a USB controller wired on the pci bus.
The EHCI Probe (usb_hcd_pci_probe) fails with "controller already in
use" error because the request_mem_region gives an error.

I think the Problem is that the CardBus bridge eat the mem.
As a refence you can compare the CadrBus mem window on 2.6.28.1 with
2.6.16.11.
At the moment I have no idea how can I fix this resource conflict ...

I found a pcibios_fixup_bus fuction that reorganize the dev->resource[i]
values but I'm not sure if this is called during pci init. I'll check
this now.
Is there a PCI guru for mips on the list?

Kind regards,
 Frank
 
Kernel 2.6.28.1 output
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
pci 0000:00:0c.2: BAR 0: can't allocate mem resource
[0x50000000-0x4fffffff]
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


Kernel 2.6.16.11 output
PCI: Bus 1, cardbus bridge: 0000:00:0d.0
  IO window: 00001000-000010ff
  IO window: 00001400-000014ff
  PREFETCH window: 40000000-41ffffff
  MEM window: 42000000-43ffffff
PCI: Bus 5, cardbus bridge: 0000:00:0d.1
  IO window: 00001800-000018ff
  IO window: 00001c00-00001cff
  PREFETCH window: 44000000-45ffffff
  MEM window: 46000000-47ffffff
PCI: Enabling device 0000:00:0d.0 (0000 -> 0003)
PCI: Setting latency timer of device 0000:00:0d.0 to 64
PCI: Enabling device 0000:00:0d.1 (0000 -> 0003)
PCI: Setting latency timer of device 0000:00:0d.1 to 64
