Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Jan 2011 01:01:45 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:43943 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491026Ab1AIABl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 9 Jan 2011 01:01:41 +0100
Date:   Sun, 9 Jan 2011 00:01:41 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
cc:     Linux MIPS org <linux-mips@linux-mips.org>,
        tsbogend@alpha.franken.de
Subject: Re: MIPS Malta and PCNet32 Driver
In-Reply-To: <4D28F1EE.8030609@paralogos.com>
Message-ID: <alpine.LFD.2.00.1101082343350.31930@eddie.linux-mips.org>
References: <4D28AFB4.7090108@paralogos.com> <4D28C2C7.2080005@paralogos.com> <alpine.LFD.2.00.1101082251440.31930@eddie.linux-mips.org> <4D28F1EE.8030609@paralogos.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 8 Jan 2011, Kevin D. Kissell wrote:

> >  With the Bonito I'd have assumed it was some low-level PCI code rewrite 
> > -- that seem to keep happening over and over again -- that missed a bit in 
> > the Bonito driver or the driver altogether.  With the Bonito core cards 
> > limited to the MIPS 20Kc core and some exotic (for the Malta) QED CPU 
> > options that would be no surprise at all to me.
> I don't think it's a "classic" Bonito, YAMON calls out:
> 
> MIPS SOC-it 101 OCP / 1.3   SDR-FW-1:1

 If it doesn't say "Bonito", then it's not a Bonito. ;)

 I've had a peek at the driver and I bet it's related to the "PCI iomap" 
thing.  The PCNet32 driver doesn't use it and goes for the traditional 
direct inw()/outw()/etc. approach.  I haven't been following the relevant 
discussions, so I can't say offhand whether PCI iomap has become mandatory 
now or not, but what I think is happening is that inw()/outw()/etc. no 
longer reach the PCI port I/O space from the driver on your system by 
default.

 Now the other driver presumably does use PCI iomap and when it 
initialises, it maps a piece of PCI port I/O space somewhere in the 
virtual address space (or initialises a KSEG/XKPHYS mapping in kernel's 
structures) making inw()/outw()/etc. see it.  And given due to PC/AT 
legacy PCI port I/O space ranges requested are typically small (256 
contiguous bytes are the guaranteed maximum on PC/AT-compatible systems), 
one MMU page spans more than one (as does obviously a kernel segment) 
making the other driver's mapping inadvertently valid for this driver too.  
This in turn magically makes it work.

 Note, while a plausible explanation, this is a pure guess on my side.  If 
it is indeed valid, then where the bug lies will depend on whether PCI 
iomap has become mandatory or not.

  Maciej
