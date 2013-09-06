Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Sep 2013 23:47:55 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:44446 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822195Ab3IFVrjcVOyQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Sep 2013 23:47:39 +0200
Date:   Fri, 6 Sep 2013 22:47:39 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: DECstation HRT calibration bug fixes
In-Reply-To: <20130905180825.GB11592@linux-mips.org>
Message-ID: <alpine.LFD.2.03.1309052118560.11570@linux-mips.org>
References: <alpine.LFD.2.03.1309041410160.11570@linux-mips.org> <20130905180825.GB11592@linux-mips.org>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37774
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

On Thu, 5 Sep 2013, Ralf Baechle wrote:

> > This change corrects DECstation HRT calibration, by removing the following 
> > bugs:
> 
> Hmm...  Seems this needs to be applied to virtually every older kernel
> as well almost back to the dawn?

 Yeah, any version that's still considered maintained; regrettably I've 
lost track of what the current practices are.  What about the R4k timer 
erratum workaround fix I sent the other day?  I'll have another small fix 
in this area yet, for a hopefully better decision on what to select from 
the timers available on various DECstation systems that have small 
differences among them.

> Great to see you backon the DECstations!

 I'm glad to have some time to have a look.

 The platform seems to suffer from surprisingly little bitrot, there are 
some issues with the system clock as handled with these patches and with 
the RTC -- regrettably drivers/char/rtc.c isn't selectable anymore (any 
particular reason for that?) and the potential rtclib drivers 
(drivers/rtc/rtc-cmos.c or drivers/rtc/rtc-m48t86.c) refuse to cooperate 
with hardware.  Also the IRQ handling latency has become high enough now 
for the serial driver to lose characters received at 115200bps on the 
R3400 system (the R4400 one is fast enough to cope).  Other than these I 
haven't noticed any issues with the 32-bit kernel -- that in a proper 
classic style netboots smoothly albeit a bit slowly via MOP over FDDI and 
fully cooperates with the userland.

 Unfortunately that can't be said of the 64-bit kernel that hangs solidly 
(reset does not help, need to power-cycle) early on, after:

Linux version 3.11.0-rc2 (macro@tp) (gcc version 4.1.2) #1 Sun Sep 1 18:06:20 BST 2013
bootconsole [prom0] enabled

has been printed.  The next line should be:

This is a DECstation 5000/2x0

So the hang happens somewhere between register_prom_console and 
prom_identify_arch, both called from prom_init, very early indeed.  I'll 
have a look into it next; hopefully it's something silly rather than my 
old trusty compiler getting confused with something added somewhere 
meanwhile.  This is an R4400SC BTW, initial revision (PRId: 00000440).

 I'm not sure what to do about the RTC yet, and the Zilog SCC@115200bps 
case is probably lost even though the chip has been wired for DMA in the 
DECstation.

  Maciej
