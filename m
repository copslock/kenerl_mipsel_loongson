Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2010 15:51:45 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:41629 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491182Ab0HRNvm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Aug 2010 15:51:42 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o7IDpGOF027188;
        Wed, 18 Aug 2010 14:51:16 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o7IDpFAf027186;
        Wed, 18 Aug 2010 14:51:15 +0100
Date:   Wed, 18 Aug 2010 14:51:15 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: Does Mips Linux rely on Yamon h/w initialization (other than DDR
 memory which is strictly necessary)?
Message-ID: <20100818135115.GC25740@linux-mips.org>
References: <AEA634773855ED4CAD999FBB1A66D076FC3BDF@CORPEXCH1.na.ads.idt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AEA634773855ED4CAD999FBB1A66D076FC3BDF@CORPEXCH1.na.ads.idt.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 18, 2010 at 06:31:42AM -0700, Ardelean, Andrei wrote:

> Malta board has Yamon monitor which initializes the DDR memory and other
> h/w. Does Mips Linux rely on Yamon h/w initialization (except memory)
> like PCI, NET, UART, etc in order to boot? Does Mips Linux re-initialize
> the h/w again? 
> I am booting Linux on Malta with a small monitor which initializes only
> the memory. I pass the environment vars array, command line arguments
> and memory size as Yamon would do. The ASCII display shows "Linux on
> Malta" scrolling text so Linux kernel it seems that at least it started
> but there is no NET activity and no messages on UART.

That's a bit of an ugly topic and some black art is involved here.  We
leave the initialization of CPU, caches and memory controllers entirely
to the firmware.

For the remainder Linux tries to perform the initilization itself but
sometimes by accident not intention a register that was already
initialized by firmware will not be initialized by Linux but the
omission will not be notized because it already has a correct value.

PCI is particularl problem.  On some platforms firmware initializes the
bus and re-initializing the bus would break the firmware or be very
complex.  On such a system Linux will just scan the PCI bus and re-use
the existing configuration.  On most platforms however Linux will do a
better job than the existing firmware and fully reinitialize the entire
PCI bus hierarchy.

  Ralf
