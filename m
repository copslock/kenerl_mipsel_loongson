Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Nov 2014 07:13:52 +0100 (CET)
Received: from resqmta-ch2-01v.sys.comcast.net ([69.252.207.33]:57286 "EHLO
        resqmta-ch2-01v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013470AbaKUGNu4vGjQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Nov 2014 07:13:50 +0100
Received: from resomta-ch2-02v.sys.comcast.net ([69.252.207.98])
        by resqmta-ch2-01v.sys.comcast.net with comcast
        id J6DJ1p00227uzMh016DfS0; Fri, 21 Nov 2014 06:13:39 +0000
Received: from [192.168.1.13] ([76.100.35.31])
        by resomta-ch2-02v.sys.comcast.net with comcast
        id J6De1p00F0gJalY016DeEz; Fri, 21 Nov 2014 06:13:39 +0000
Message-ID: <546ED802.7090108@gentoo.org>
Date:   Fri, 21 Nov 2014 01:13:22 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: IP30: SMP Help
References: <5457187D.6030708@gentoo.org> <54607499.2070806@gentoo.org> <546B11C0.90805@gentoo.org> <alpine.LFD.2.11.1411180946130.4773@eddie.linux-mips.org> <546B3D9C.6000104@gentoo.org> <alpine.LFD.2.11.1411181255420.4773@eddie.linux-mips.org> <546C77F6.4030101@gentoo.org> <alpine.LFD.2.11.1411191139300.4773@eddie.linux-mips.org> <20141119152211.GH24165@linux-mips.org>
In-Reply-To: <20141119152211.GH24165@linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1416550419;
        bh=xwyE9Xt0QgnVPUN3tOveLZJDNuM0TYCPOFy2Y+fo1kE=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=CaEuxpKd2uXHDh9GY6mwHilZh0ikt36fpsQS6Tw3x1QcIfAcWwXYMPeIDDOr6dmgH
         Pqz57fbCqAPhuxK1sqm1fQvtBdSVKAEtNp/KIiIQeumEWddckE9rW6mnak0isMyjea
         7b54lWFRbMGJtX+kpApqVkZp4sdvooKezMzygiXktVo6B584czqHunmH0c/STUA/QE
         eAxuQaix+5HBKnSznvAT5/qNNmQuknid/cfLqgsom0hpn5kTUKm0JS1oR0GfYEq8Sd
         MHUoaTl2iYSlLachNcrPEweZZaS9TprHfcCqV707t8txetBkpG0D/JycA92yZlAhr+
         d9YY7JBmDKysQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 11/19/2014 10:22, Ralf Baechle wrote:
> On Wed, Nov 19, 2014 at 12:06:59PM +0000, Maciej W. Rozycki wrote:
>>  I highly doubt spinlocks have any significance here, they're used and 
>> work just fine across many systems.  If anything this will probably be 
>> either a bug in platform code somewhere or a critical part of hardware 
>> having not been correctly initialised.
> 
> For testing purposes one could disable the secondary CPU - I believe that's
> possible on IP30, too?  Then build an SMP kernel with NR_CPUS set to 1.
> That's basically a glorified uniprocessor kernel on glorified uniprocessor
> hardware then.

That's what I did, actually.  "disable 1" in the PROM and a reset to turn off
the extra CPU.  The register dump in my earlier mail in this thread is from an
SMP kernel running with CPU1 disabled in PROM.  NR_CPUS=2 in that build,
though, but Octane has some data available via MP_CONF registers that can tell
you if a CPU is online or offline, and the SMP setup code uses that to
enumerate the possible CPUs.

I can still trigger the corrupted memory addresses in that situation.  Which is
why I'm thinking there is something else, possibly not in the core IP30 code,
that's causing the problem.  I've stripped the test kernel of everything else
(no block drivers, no SCSI, no networking, etc).  I guess I can remove PCI &
IOC3 support next and see if loading an initramfs triggers the memory
corruption.  Might have to look closer at the memory probing code, too.


>>  Does the system have any standard bus like PCI?  If so then you could get 
>> an NVRAM card then and log some activity there like CPU status on entry to 
>> exception handlers.  Once a crash has happened you could boot with that 
>> logging disabled and retrieve your data.  Accessing hardware is easy on 
>> MIPS, you can do it via XKPHYS without a need to have the MMU working, IOW 
>> you'll be able to poke at hardware even if your TLB/page tables got 
>> botched for some reason.  And you can bypass the cache too, which is 
>> another possible place for breakage.
> 
> IP27 reserves a part of its FLASH memory for logging.  However Linux doesn't
> support that.

I did add a different RTC to my Octane, DS17887, which has 8KB of NVRAM
available.  The driver I wrote for it can access that NVRAM, too.  Uses PIO to
write an address to a port register and then reads a data register to get data
in/out from the RTC (unlike O2, which can ioremap the RTC registers directly).
 Can't store much in 8KB, though.  I'll look for an NVRAM card in that case then.

Is it possible for Linux, upon a kernel crash, to actually create a full dump
of all available memory and write that out somewhere?  NetWare had this
capability to designate a spare volume as a crash volume, which a core dump
could be written to using low-level access, and then you could do offline
analysis of the dump via the NW kernel debugger on a separate workstation
(after rebooting and copying the crash dump out).


>>  Of course if you have PCI then you can add an ordinary serial port card 
>> there as well if the onboard port is difficult to access for some reason, 
>> but serial port logging has its limitations, mainly the complexity to 
>> access it and throughput.
> 
> While the system has 16550 UARTs a PCI card might indeed make things
> slightly sinpler - the setup of the IOC3 + SuperIO combo is complex,
> even for a simple PIO driver.  However I think he shouldn't have to go
> to such an extreme!

Already got a PCI serial card installed in the PCI 'shoebox' module.
Unfortunately, it's a Moschip, so the driver for that is part of the parallel
port code, and that doesn't appear to be big-endian safe.  Last time I tried
the driver, it crashed when probing for the card.  Seems most of the cheap PCI
Serial card these days are Moschips.

--J


-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
