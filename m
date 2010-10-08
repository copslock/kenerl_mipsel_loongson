Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2010 17:49:09 +0200 (CEST)
Received: (from localhost user: 'ralf' uid#500 fake: STDIN
        (ralf@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S1491201Ab0JHPtG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 8 Oct 2010 17:49:06 +0200
Date:   Fri, 8 Oct 2010 16:49:04 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: How to add Ethernet and USB drivers to the Linux Kernel?
Message-ID: <20101008154904.GB12107@linux-mips.org>
References: <AEA634773855ED4CAD999FBB1A66D076011E62CF@CORPEXCH1.na.ads.idt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AEA634773855ED4CAD999FBB1A66D076011E62CF@CORPEXCH1.na.ads.idt.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 08, 2010 at 08:25:43AM -0700, Ardelean, Andrei wrote:

> I am porting MIPS Linux from Malta board to a new board. On Malta board
> network and USB devices reside on PCI bus. In my case the new video
> processor contains MIPS core, network and USB controllers, and those
> controllers registers are in the direct memory map of MIPS core, there
> is no PCI bus. Give me some advice how to add Ethernet and USB drivers
> to the Kernel. Do I need to create a new virtual platform bus/device or
> the Kernel has already what I need? If all the peripheral h/w blocks are
> memory mapped directly in MIPS processor core space, can I have a single
> bus for all of them?  

Sounds like platform_device is what you're looking for.  The MIPSnet
driver in drivers/net/mipsnet.c is a very simple example.  The devices
are registered in arch/mips/mipssim/sim_platform.c.

  Ralf
