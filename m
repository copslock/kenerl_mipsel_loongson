Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jul 2004 19:57:50 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:8442 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8224950AbUGUS5q>;
	Wed, 21 Jul 2004 19:57:46 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i6LIvi4O015574;
	Wed, 21 Jul 2004 11:57:44 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i6LIvhJb015573;
	Wed, 21 Jul 2004 11:57:43 -0700
Date: Wed, 21 Jul 2004 11:57:43 -0700
From: Jun Sun <jsun@mvista.com>
To: Wayne Gowcher <wgowcher@yahoo.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: Should pci driver probe behind a cardbus bridge at boot up ?
Message-ID: <20040721115743.C6813@mvista.com>
References: <20040720162349.45167.qmail@web11902.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040720162349.45167.qmail@web11902.mail.yahoo.com>; from wgowcher@yahoo.com on Tue, Jul 20, 2004 at 09:23:49AM -0700
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Jul 20, 2004 at 09:23:49AM -0700, Wayne Gowcher wrote:
> I am having a problem with a Ti cardbus chip and yenta
> on the 2.6.4 mips kernel whereby when yenta tries to
> configure the cardbus chip, it finds all the resources
> busy ( because they have already been allocated in the
> pci driver ) and so starts allocating new ones.
> 
> Here's the output of the PCI driver
> 
> PCI: Bus 1, cardbus bridge: 0000:00:0c.0
>   IO window: 00001000-00001fff
>   IO window: 00002000-00002fff
>   PREFETCH window: 40000000-41ffffff
>   MEM window: 42000000-43ffffff
> PCI: Bus 5, cardbus bridge: 0000:00:0c.1
>   IO window: 00003000-00003fff
>   IO window: 00004000-00004fff
>   PREFETCH window: 44000000-45ffffff
>   MEM window: 46000000-47ffffff
> 
> and here's what yenta reports:
> 
> Yenta: CardBus bridge found at 0000:00:0c.0
> [0000:0000]
> yenta 0000:00:0c.0: Preassigned resource 1 busy,
> reconfiguring...
> Yenta: CardBus bridge found at 0000:00:0c.1
> [0000:0000]
> 
> 
> When I run the same 2.6.4 kernel compiled for x86 on a
> x86 laptop, the x86 kernel finds the bar 0 registers
> of the cardbus chip and adds them to it's resource
> space, but probes no further. So that later when yenta
> probes the cardbus chip, it can allocate the resources
> without conflict.
> 
> I also found the following comment in
> drivers/pci/probe.c pci_scan_bridge :
> 
>  * If it's a bridge, configure it and scan the bus
> behind it.
>  * For CardBus bridges, we don't scan behind as the
> devices will
>  * be handled by the bridge driver itself.
> 
> But the code does scan behind teh cardbus bridge and
> add resources to iomem_resources and ioport_resources.
> 
> So as I wrote in my title, does anyone know if :
> 
> the pci driver should probe behind a cardbus bridge at
> boot up or if it should be left to the yenta cardbus ?
>

It should not - me think anyway.

Maybe you can tell us _why_, given the same code, i386 does
not scan behind yenta.

Jun
