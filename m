Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Sep 2013 09:35:02 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45227 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6819473Ab3IGHezvq94E (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 7 Sep 2013 09:34:55 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r877Yrfs030289;
        Sat, 7 Sep 2013 09:34:53 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r877YoA8030288;
        Sat, 7 Sep 2013 09:34:50 +0200
Date:   Sat, 7 Sep 2013 09:34:50 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: DECstation HRT calibration bug fixes
Message-ID: <20130907073450.GE11592@linux-mips.org>
References: <alpine.LFD.2.03.1309041410160.11570@linux-mips.org>
 <20130905180825.GB11592@linux-mips.org>
 <alpine.LFD.2.03.1309052118560.11570@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.03.1309052118560.11570@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Fri, Sep 06, 2013 at 10:47:39PM +0100, Maciej W. Rozycki wrote:

> > > bugs:
> > 
> > Hmm...  Seems this needs to be applied to virtually every older kernel
> > as well almost back to the dawn?
> 
>  Yeah, any version that's still considered maintained; regrettably I've 
> lost track of what the current practices are.  What about the R4k timer 
> erratum workaround fix I sent the other day?  I'll have another small fix 
> in this area yet, for a hopefully better decision on what to select from 
> the timers available on various DECstation systems that have small 
> differences among them.

It's queued up to go to Linus after the weekend.

> > Great to see you backon the DECstations!
> 
>  I'm glad to have some time to have a look.
> 
>  The platform seems to suffer from surprisingly little bitrot, there are 
> some issues with the system clock as handled with these patches and with 
> the RTC -- regrettably drivers/char/rtc.c isn't selectable anymore (any 
> particular reason for that?) and the potential rtclib drivers 

The old RTC driver is bitrotting, not well integraed into modern kernels'
time and driver infrastructure.  So I eventually had to switch MIPS to
RTC_LIB.

However I actually was assuming DECstation to be just fine with RTC_LIB.

> (drivers/rtc/rtc-cmos.c or drivers/rtc/rtc-m48t86.c) refuse to cooperate 
> with hardware.  Also the IRQ handling latency has become high enough now 
> for the serial driver to lose characters received at 115200bps on the 
> R3400 system (the R4400 one is fast enough to cope).  Other than these I 
> haven't noticed any issues with the 32-bit kernel -- that in a proper 
> classic style netboots smoothly albeit a bit slowly via MOP over FDDI and 
> fully cooperates with the userland.

I'm not sure how many people still get to feel the pains of high
per interrupt overhead on their hardware.  You maybe want to talk to
Thomas Gleixner about this?

A *kludgy* solution would be "fast interrupt layer" to handle RX/TX
interrupts, and maintaining a software FIFO and only infrequently forward
interrupts through the normal Linux interrupt code.

>  Unfortunately that can't be said of the 64-bit kernel that hangs solidly 
> (reset does not help, need to power-cycle) early on, after:
> 
> Linux version 3.11.0-rc2 (macro@tp) (gcc version 4.1.2) #1 Sun Sep 1 18:06:20 BST 2013
> bootconsole [prom0] enabled
> 
> has been printed.  The next line should be:
> 
> This is a DECstation 5000/2x0

No idea why this might be hanging.  You might try git-bisect, if that's
not too painful?

> So the hang happens somewhere between register_prom_console and 
> prom_identify_arch, both called from prom_init, very early indeed.  I'll 
> have a look into it next; hopefully it's something silly rather than my 
> old trusty compiler getting confused with something added somewhere 
> meanwhile.  This is an R4400SC BTW, initial revision (PRId: 00000440).
> 
>  I'm not sure what to do about the RTC yet, and the Zilog SCC@115200bps 
> case is probably lost even though the chip has been wired for DMA in the 
> DECstation.

We could switch put a "select RTC_LIB if !MACH_DECSTATION" to buy you some
time.  But longer term RTC_LIB is really the issue.

  Ralf
