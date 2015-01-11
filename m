Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Jan 2015 05:43:16 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:60681 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009730AbbAKEnOUq3O7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Jan 2015 05:43:14 +0100
Date:   Sun, 11 Jan 2015 04:43:14 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     =?ISO-8859-15?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        peter fuerst <post@pfrst.de>, linux-mips@linux-mips.org
Subject: Re: fast_iob() vs PHYS_OFFSET
In-Reply-To: <yw1xfvczebjc.fsf@unicorn.mansr.com>
Message-ID: <alpine.LFD.2.11.1501110242530.22270@eddie.linux-mips.org>
References: <yw1xsih2evgn.fsf@unicorn.mansr.com>        <Pine.LNX.4.64.1411300255520.2113@Opal.Peter>        <yw1xoaroev7i.fsf@unicorn.mansr.com>        <20141201104132.GA1973@alpha.franken.de> <yw1xfvczebjc.fsf@unicorn.mansr.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45061
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

On Mon, 1 Dec 2014, Måns Rullgård wrote:

> > there is really on-chip RAM for AR7 at address 0. The AR7 CPU core
> > is only MIPS32r1, so it doesn't have the exception vector base register
> > and needs ram at physical address 0 for exception handlers (which all
> > older cores do). I can't check right now, but even IP28 should have
> > some memory mirrored there. The problem on IP28 is that accessing
> > memory uncached requires reprogramming the memory controller (which
> > then doesn't fit the concept of fast_iob()).
> 
> Well, that explains why it works on AR7.  It still doesn't tell me the
> correct way to handle a 74k-based chip (MIPS32r2) with RAM starting at
> physical address 0x04000000.

 I defined the thing long ago (circa 2000), before such configurations 
were of concern, under the assumption there must be readable storage that 
behaves like memory (i.e. safe to read, no side effects) at the base of 
KSEG0/KSEG1 because this is where the exception handlers reside.  The 
definition should have been updated by whoever implemented support for 
newer processors for which the assumption does not stand anymore.

 For MIPSr2 and newer architectures you may define a variant that reads 
from CP0.EBase, masks out the unwanted fields and ORs in the KSEG1 bits.  
The natural way to implement this would be in C code, probably directly in 
the input operand's expression, replacing CKSEG1 hardcoded there now, so 
that the compiler can optimise the address calculation sequence (e.g. it 
can keep it around in a register rather than recalculating it every time 
if the piece is invoked repeatedly).

 FWIW I plan to rewrite our I/O barriers in an effort to make them 
portable across all Linux targets so that cross-platform drivers can use 
them.  I think I outlined the plan sometime ago, on LKML or maybe netdev.  
Such low-level handlers like this will obviously stay, but names can 
change and definitions may be shuffled around.  Right now we have quite a 
mess across various platforms whose access ordering strength varies for 
I/O (all the world is not PCI!), it's only memory access ordering strength 
handling that we've got nice and clean once DEC Alpha entered the game.

  Maciej
