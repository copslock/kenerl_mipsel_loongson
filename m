Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Feb 2018 09:47:56 +0100 (CET)
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:51426 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992828AbeBRIrrLaAbC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Feb 2018 09:47:47 +0100
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 2EC263F45D;
        Sun, 18 Feb 2018 09:47:44 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Hsga-z8WbUwv; Sun, 18 Feb 2018 09:47:35 +0100 (CET)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 9F30C3F2E5;
        Sun, 18 Feb 2018 09:47:25 +0100 (CET)
Date:   Sun, 18 Feb 2018 09:47:24 +0100
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>,
        linux-mips@linux-mips.org
Subject: Re: [RFC v2] MIPS: R5900: Workaround exception NOP execution bug
 (FLX05)
Message-ID: <20180218084723.GA2577@localhost.localdomain>
References: <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
 <20171029172016.GA2600@localhost.localdomain>
 <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk>
 <20171111160422.GA2332@localhost.localdomain>
 <20180129202715.GA4817@localhost.localdomain>
 <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
 <20180211075608.GC2222@localhost.localdomain>
 <alpine.DEB.2.00.1802111239380.3553@tp.orcam.me.uk>
 <20180215191502.GA2736@localhost.localdomain>
 <alpine.DEB.2.00.1802151934180.3553@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.00.1802151934180.3553@tp.orcam.me.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Maciej,

>  I didn't comment on the erratum workaround addressing speculative 
> execution beyond ERET, because I haven't made final conclusions as to code 
> will have to exactly look like.

OK.

>  However please note that in reality 5 NOPs are not required in these 
> generated handlers (except perhaps from the interrupt handler, which will 
> have to be double-checked, due to being set up differently), because the 
> lone reason for them to be inserted is to prevent from data interpreted as 
> ill-formed code being speculatively executed.  But any handler that 
> follows does not contain ill-formed code and the `tlb_handler' buffer is 
> cleared before any generated machine code is built within, so any trailing 
> padding uses the encoding of NOP.  Which means you can exclude these 5 
> NOPs from calculation.

Sure, makes sense.

> Substitute `mips:5900' for `mips:isa32r2' to get R5900 disassembly.  If 
> you want to see raw machine code too, use `disassemble -r', but watch out 
> for the syntax, which is different.  As you can see the trailing NOPs 
> required are already there. :)

Due to trailing zeroes, I suppose. :)

> You can supply `vmlinux' as the executable to debug too for symbolic
> access.
> 
>  You can also ask the kernel to dump generated handlers to the kernel log 
> (and the console, if `debug' has been specified as a kernel parameter) at 
> bootstrap by building tlbex.c and/or page.c with -DDEBUG, e.g.:
> 
> $ make CFLAGS_tlbex.o=-DDEBUG vmlinux
> 
> It can help if a bug in a generated handler prevents the kernel from 
> starting userland.

Thank you for these tips. Eventually I'd like to make use of kernel tracing
features, BPF (MIPS JIT seems to require a 64 bit kernel though), dynamic
debug, etc.

>  A handler for SIO is needed if SIOInt can be asserted without kernel 
> control by PS/2 hardware.  Otherwise handlers will only be needed once the 
> kernel has means to enable the respective exceptions.

Serial I/O requires soldering for the PS2. Jürgen Urban, Rick Gaiser, and
others have it and they can more easily debug the early boot stages. The
proposed PS2 serial driver uses a 20 ms timer and polling instead of SIOInt:

https://github.com/frno7/linux/blob/ps2-v4.15-n7/drivers/tty/serial/ps2-uart.c

I don't have a serial port. My setup consists of ssh over a wireless RT3070*
USB device. Obviously a great number of things could potentially fail in
that chain but it is surprisingly reliable. :)

* A few hardcoded DMA buffer sizes in the RT3070 driver have to be made
  smaller since PS2 IOP DMA memory is limited to 256 KiB. It would be nice
  if USB drivers could adjust themselves to the amount of available memory,
  or make it configurable.

Fredrik
