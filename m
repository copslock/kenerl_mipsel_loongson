Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jul 2004 17:24:00 +0100 (BST)
Received: from web11902.mail.yahoo.com ([IPv6:::ffff:216.136.172.186]:8792
	"HELO web11902.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225219AbUGTQXz>; Tue, 20 Jul 2004 17:23:55 +0100
Message-ID: <20040720162349.45167.qmail@web11902.mail.yahoo.com>
Received: from [65.204.143.11] by web11902.mail.yahoo.com via HTTP; Tue, 20 Jul 2004 09:23:49 PDT
Date: Tue, 20 Jul 2004 09:23:49 -0700 (PDT)
From: Wayne Gowcher <wgowcher@yahoo.com>
Subject: Should pci driver probe behind a cardbus bridge at boot up ?
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <wgowcher@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5524
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wgowcher@yahoo.com
Precedence: bulk
X-list: linux-mips

I am having a problem with a Ti cardbus chip and yenta
on the 2.6.4 mips kernel whereby when yenta tries to
configure the cardbus chip, it finds all the resources
busy ( because they have already been allocated in the
pci driver ) and so starts allocating new ones.

Here's the output of the PCI driver

PCI: Bus 1, cardbus bridge: 0000:00:0c.0
  IO window: 00001000-00001fff
  IO window: 00002000-00002fff
  PREFETCH window: 40000000-41ffffff
  MEM window: 42000000-43ffffff
PCI: Bus 5, cardbus bridge: 0000:00:0c.1
  IO window: 00003000-00003fff
  IO window: 00004000-00004fff
  PREFETCH window: 44000000-45ffffff
  MEM window: 46000000-47ffffff

and here's what yenta reports:

Yenta: CardBus bridge found at 0000:00:0c.0
[0000:0000]
yenta 0000:00:0c.0: Preassigned resource 1 busy,
reconfiguring...
Yenta: CardBus bridge found at 0000:00:0c.1
[0000:0000]


When I run the same 2.6.4 kernel compiled for x86 on a
x86 laptop, the x86 kernel finds the bar 0 registers
of the cardbus chip and adds them to it's resource
space, but probes no further. So that later when yenta
probes the cardbus chip, it can allocate the resources
without conflict.

I also found the following comment in
drivers/pci/probe.c pci_scan_bridge :

 * If it's a bridge, configure it and scan the bus
behind it.
 * For CardBus bridges, we don't scan behind as the
devices will
 * be handled by the bridge driver itself.

But the code does scan behind teh cardbus bridge and
add resources to iomem_resources and ioport_resources.

So as I wrote in my title, does anyone know if :

the pci driver should probe behind a cardbus bridge at
boot up or if it should be left to the yenta cardbus ?


	
		
__________________________________
Do you Yahoo!?
Vote for the stars of Yahoo!'s next ad campaign!
http://advision.webevents.yahoo.com/yahoo/votelifeengine/
