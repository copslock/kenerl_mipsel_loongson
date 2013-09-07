Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Sep 2013 14:49:13 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45788 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822754Ab3IGMsybEY1U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Sep 2013 14:48:54 +0200
Date:   Sat, 7 Sep 2013 13:48:54 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: DECstation HRT calibration bug fixes
In-Reply-To: <20130907073450.GE11592@linux-mips.org>
Message-ID: <alpine.LFD.2.03.1309071304090.19552@linux-mips.org>
References: <alpine.LFD.2.03.1309041410160.11570@linux-mips.org> <20130905180825.GB11592@linux-mips.org> <alpine.LFD.2.03.1309052118560.11570@linux-mips.org> <20130907073450.GE11592@linux-mips.org>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37776
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Sat, 7 Sep 2013, Ralf Baechle wrote:

> >  Yeah, any version that's still considered maintained; regrettably I've 
> > lost track of what the current practices are.  What about the R4k timer 
> > erratum workaround fix I sent the other day?  I'll have another small fix 
> > in this area yet, for a hopefully better decision on what to select from 
> > the timers available on various DECstation systems that have small 
> > differences among them.
> 
> It's queued up to go to Linus after the weekend.

 Excellent, thanks!  I should have the third patch mentioned ready on 
Monday too -- I want to make yet another check to make sure it does the 
right thing as I tweaked it a little bit from its original version.

> >  The platform seems to suffer from surprisingly little bitrot, there are 
> > some issues with the system clock as handled with these patches and with 
> > the RTC -- regrettably drivers/char/rtc.c isn't selectable anymore (any 
> > particular reason for that?) and the potential rtclib drivers 
> 
> The old RTC driver is bitrotting, not well integraed into modern kernels'
> time and driver infrastructure.  So I eventually had to switch MIPS to
> RTC_LIB.
> 
> However I actually was assuming DECstation to be just fine with RTC_LIB.

 I'm not sure what's going on, I haven't looked into it in detail.  The 
wiring in the DECstation is a little bit different, there's no separate 
address and data port and the chip is mapped linearly in the memory 
address space -- the chipset does all the magic to split accesses into 
separate cycles on the DS1287A bus.  Also the interrupt is taken for the 
system timer and the handling of the century byte needs special-casing.  
Any of that might be the cause -- except from the latter, that needs to be 
implemented, but does not explain a total failure.  Or maybe something 
else yet.  There isn't much in the kernel log, only:

drivers/rtc/hctosys.c: unable to open rtc device (rtc0)

A major rtc device is installed at 254 according to /proc/devices, but any 
accesses to (254, 0) fail (ENXIO, IIRC).

 BTW, is it normal these days that /proc entries like /proc/iomem, 
/proc/net or /proc/sys are omitted from the /proc directory listing?  They
can still be opened if you know the name.  I've been wondering if it's 
been a change made sometime or an odd effect of a possible compiler bug.

> > (drivers/rtc/rtc-cmos.c or drivers/rtc/rtc-m48t86.c) refuse to cooperate 
> > with hardware.  Also the IRQ handling latency has become high enough now 
> > for the serial driver to lose characters received at 115200bps on the 
> > R3400 system (the R4400 one is fast enough to cope).  Other than these I 
> > haven't noticed any issues with the 32-bit kernel -- that in a proper 
> > classic style netboots smoothly albeit a bit slowly via MOP over FDDI and 
> > fully cooperates with the userland.
> 
> I'm not sure how many people still get to feel the pains of high
> per interrupt overhead on their hardware.  You maybe want to talk to
> Thomas Gleixner about this?
> 
> A *kludgy* solution would be "fast interrupt layer" to handle RX/TX
> interrupts, and maintaining a software FIFO and only infrequently forward
> interrupts through the normal Linux interrupt code.

 Thanks for the hint, but I think there will be no need to resort to 
kludges after all, even though the SCC only has a tiny 3-stage FIFO (the 
first DECstation models had a different, genuine DEC-brand UART coming 
from the VAXen, with a comparatively impressive 64-stage FIFO).  I have 
read through I/O ASIC documentation and IIUC there is a way to utilise its 
DMA engine even for asynchronous reception (DMA would normally be used in 
synchronous modes such as SDLC; the SCC does support them as does the 
wiring in the DECstations).  Also transmits can be DMA'd in a block manner 
if there's more than one character to send available, offloading the CPU 
(there's little sense in arranging DMA for a single character only even 
though, indeed, it appears possible ;) ).

 Sounds like a plan to me and some fun stuff to do -- let's make the old 
gears spin. :)

 Speaking of interrupts -- I've noticed that all handlers are now started 
with interrupts locally disabled (IRQF_DISABLED semantics is in force for 
all handlers now and the flag itself has been scheduled for removal).  So 
what's the practice been these days for the lower priority services that 
can run with interrupts enabled just fine and take a little bit more than 
a poke at MMIO here or there?  Can they simply enable interrupts 
temporarily or is splitting the handler into a bottom half and a top half 
like in the old days, and handling the stuff beyond poking at MMIO in a 
softirq the only way?

> >  Unfortunately that can't be said of the 64-bit kernel that hangs solidly 
> > (reset does not help, need to power-cycle) early on, after:
> > 
> > Linux version 3.11.0-rc2 (macro@tp) (gcc version 4.1.2) #1 Sun Sep 1 18:06:20 BST 2013
> > bootconsole [prom0] enabled
> > 
> > has been printed.  The next line should be:
> > 
> > This is a DECstation 5000/2x0
> 
> No idea why this might be hanging.  You might try git-bisect, if that's
> not too painful?

 Given that printk works and it's just a couple of lines to examine I 
think I'll do it in the old fashion. ;)

> >  I'm not sure what to do about the RTC yet, and the Zilog SCC@115200bps 
> > case is probably lost even though the chip has been wired for DMA in the 
> > DECstation.
> 
> We could switch put a "select RTC_LIB if !MACH_DECSTATION" to buy you some
> time.  But longer term RTC_LIB is really the issue.

 Yeah, although I think it's a bit of a shame a then perfectly working and 
as of now still included driver has been disabled while the alternative 
does not work.  But please don't haste reenabling it as we don't know if 
it still works as it is, and meanwhile I'll try to poke at the rtclib 
drivers instead.

  Maciej
