Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jun 2011 20:00:49 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42293 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491088Ab1FCSAq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 3 Jun 2011 20:00:46 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p53I0eTj010963;
        Fri, 3 Jun 2011 19:00:40 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p53I0cSt010959;
        Fri, 3 Jun 2011 19:00:38 +0100
Date:   Fri, 3 Jun 2011 19:00:38 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Gerhard Pircher <gerhard_pircher@gmx.net>
Cc:     linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 00/14] Sort out i8253 and PC speaker locking and headers
Message-ID: <20110603180038.GA13239@linux-mips.org>
References: <20110601180456.801265664@duck.linux-mips.net>
 <20110602191119.302850@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110602191119.302850@gmx.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 2830

On Thu, Jun 02, 2011 at 09:11:19PM +0200, Gerhard Pircher wrote:

> > #if defined(CONFIG_MIPS) || defined(CONFIG_X86)
> > /* Use the global PIT lock ! */
> > #include <asm/i8253.h>
> > #else
> > #include <asm/8253pit.h>
> > static DEFINE_RAW_SPINLOCK(i8253_lock);
> > #endif
> > 
> > sound/drivers/pcsp/pcsp.h:
> > 
> > #if defined(CONFIG_MIPS) || defined(CONFIG_X86)
> > /* Use the global PIT lock ! */
> > #include <asm/i8253.h>
> > #else
> > #include <asm/8253pit.h>
> > static DEFINE_RAW_SPINLOCK(i8253_lock);
> > 
> > $ git grep -F pcsp.h sound/drivers/pcsp
> > sound/drivers/pcsp/pcsp.c:#include "pcsp.h"
> > sound/drivers/pcsp/pcsp_input.c:#include "pcsp.h"
> > sound/drivers/pcsp/pcsp_lib.c:#include "pcsp.h"
> > sound/drivers/pcsp/pcsp_mixer.c:#include "pcsp.h"
> > $ git grep -w i8253_lock sound/drivers/pcsp/
> > sound/drivers/pcsp/pcsp.h:static DEFINE_RAW_SPINLOCK(i8253_lock);
> > sound/drivers/pcsp/pcsp_input.c:        raw_spin_lock_irqsave(&i8253_lock,
> > flags
> > sound/drivers/pcsp/pcsp_input.c:       
> > raw_spin_unlock_irqrestore(&i8253_lock, 
> > sound/drivers/pcsp/pcsp_lib.c:          raw_spin_lock_irqsave(&i8253_lock,
> > flags
> > sound/drivers/pcsp/pcsp_lib.c:         
> > raw_spin_unlock_irqrestore(&i8253_lock, 
> > sound/drivers/pcsp/pcsp_lib.c:  raw_spin_lock(&i8253_lock);
> > sound/drivers/pcsp/pcsp_lib.c:  raw_spin_unlock(&i8253_lock);
> > sound/drivers/pcsp/pcsp_lib.c:  raw_spin_lock(&i8253_lock);
> > sound/drivers/pcsp/pcsp_lib.c:  raw_spin_unlock(&i8253_lock);
> > 
> > Locks are great, everybody should have their own lock!
> > 
> > $ find . -name 8253pit.h
> > ./arch/powerpc/include/asm/8253pit.h
> > ./arch/alpha/include/asm/8253pit.h
> > $ cat arch/*/include/asm/8253pit.h
> > /*
> >  * 8253/8254 Programmable Interval Timer
> >  */
> > /*
> >  * 8253/8254 Programmable Interval Timer
> >  */
> > $
> > 
> > Eh...
> > 
> > $ git grep -w PCSPKR_PLATFORM 
> > arch/mips/Kconfig:      select PCSPKR_PLATFORM
> > arch/mips/Kconfig:      select PCSPKR_PLATFORM
> > arch/mips/Kconfig:      select PCSPKR_PLATFORM
> > arch/powerpc/platforms/amigaone/Kconfig:        select PCSPKR_PLATFORM
> > drivers/input/misc/Kconfig:     depends on PCSPKR_PLATFORM
> > init/Kconfig:config PCSPKR_PLATFORM
> > sound/drivers/Kconfig:  depends on PCSPKR_PLATFORM && X86 &&
> > HIGH_RES_TIMERS
> > 
> > So the status is:
> > 
> >  Alpha:	There is no PCSPKR_PLATFORM so while a platform device is
> > 		being installed no drivers will be built.  I don't know
> > 		which Alpha platforms or even if all of Alpha should be
> > 		doing a PCSPKR_PLATFORM so I haven't even tried to sort
> > 		this.
> >  ARM:		No PC speaker supported, yeah :)
> >  PowerPC:	Should compile but the locking is wrong but only the 
> >    		AmigaOne platforms should be affected.
> The Kconfig dependencies cleanup patch for CHRP, PSERIES, etc. should
> also apply to the AmigaOne. Can you resend it with a fix for the
> AmigaOne, or should I send a patch?

I can sort that; it's easy enough.

> I'll check next week, if the PC speaker is still working on my AmigaOne.

I can't imagine that it's going to break - the code is sorta simple ;-)

One obscurity I noticed is this bit in the amigaone.dts:

        timer@40 {
                // Also adds pcspkr to platform devices.
                compatible = "pnpPNP,100";
                reg = <1 0x00000040 0x00000020>;
        };

Shouldn't that rather be something like the following?

        pcspeaker@61 {
                device_type = "sound";
                compatible = "pnpPNP,800";
                reg = <1 0x61 1>;
        };

pnpPNP,100 is the i8253 timer as I understand and pnpPNP,800 the PC speaker.
If you interpret pnpPNP,100 to imply the presence of a PC speaker you can't
express a system that has a i8253 but no PCspeaker in a DT so maybe
amigaone.dts and arch/powerpc/kernel/setup-common.c should be changed to
use pnpPNP,800 instead?

  Ralf
