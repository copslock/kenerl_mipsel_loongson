Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Sep 2010 17:39:04 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:57150 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491163Ab0I3PjB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Sep 2010 17:39:01 +0200
Date:   Thu, 30 Sep 2010 16:39:01 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: RE: How to setup interrupts for a new board?
In-Reply-To: <AEA634773855ED4CAD999FBB1A66D0760115A95C@CORPEXCH1.na.ads.idt.com>
Message-ID: <alpine.LFD.2.00.1009301557460.21189@eddie.linux-mips.org>
References: <AEA634773855ED4CAD999FBB1A66D0760115A5BC@CORPEXCH1.na.ads.idt.com> <4CA36859.2050506@caviumnetworks.com> <AEA634773855ED4CAD999FBB1A66D0760115A691@CORPEXCH1.na.ads.idt.com> <alpine.LFD.2.00.1009300306230.21189@eddie.linux-mips.org>
 <AEA634773855ED4CAD999FBB1A66D0760115A95C@CORPEXCH1.na.ads.idt.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 27906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 24313

Hi Andrei,

> I have read all the books you suggested and I work having all of them on
> my desk. I come back to them frequently to check diverse stuff. My
> problems are: 
> - Why Malta implementation doesn't activate cpu_has_veic although they
> have 8259 external interrupt controller? Malta implementation doesn't
> activate cpu_has_vint too although Vectored interrupt mode should be the
> minimum recommended mode if external controller is not present.

 I am fairly sure at least some configurations with the Malta do use the 
VEIC or VINT mode; probably both, though not at a time of course, 
depending on the exact setup.  Please note however that the Malta supports 
a diverse set of CPU cards, some of which not even featuring a MIPS 
architecture processor (such as the QED RM5261 CPU that is only the legacy 
MIPS IV ISA).  Therefore for the Malta you cannot simply override our 
default of the dynamic interrupt configuration by hardcoding cpu_has_veic 
or cpu_has_vint to 1.  The value has to be determined at the run time 
(note that by default cpu_has_veic, etc. macros expand to variable 
references).

 The design of the Malta itself (which is from ~2000) also predates the 
second revision of the MIPS architecture that introduced the VEIC mode and 
does not allow the 8259 to be used in a manner that would give any 
advantage for vectored interrupts -- the output of the PIC is simply wired 
to one of the core card's inputs, that is then routed to one of the CPU 
interrupt lines, perhaps via the system controller (depending on the exact 
one used -- they vary significantly between core cards too), and the 
actual originating source at the 8259 can only be determined either by 
poking at a special register in the system controller that makes it 
generate a PCI INTA cycle and returns the vector the 8259 responded with 
or by the PIC's OCW3 command.

> - Looking at Malta_xxxx specific files, it seems to me that they do not
> follow Linux Porting Guide document I have read on MIPS Linux.

 No surprise as I'd expect them to predate the document by many years.

> In addition, my company pays Timesys for support and regarding
> cpu-feature.h define switches, they said that they know nothing.

 Hmm, change your support provider then?  If I paid someone for support, 
then I'd expect them to be able to figure out the details I ask them 
about.  And I wouldn't care if they did that themselves or asked someone 
else in turn.

> What I was hoping was to find a MIPS Linux implementation which uses
> Vectored Interrupt Mode (VI) with few h/w interrupts including the timer
> routed to the MIPS processor or at least some document with some details
> of implementation. That will shorten significantly my porting. Sure, if
> I find nothing, I'll write from scratch as I understand, but it takes
> for sure much longer and is worth to try first finding a close example.

 While a reasonably comprehensive choice, with its complexity and 
diversity the Malta is certainly not the simplest one to start with.  You 
may be able to find a simpler one, but I don't know which one that would 
be (I seem to tend to stick to the complicated bits ;) ) so I cannot point 
you at that, sorry.  You may be able to figure it out yourself -- I 
suggest starting by checking platforms that do not hardcode cpu_has_veic 
to 0 (I'm assuming you have verified none sets it to 1 already as 
otherwise you wouldn't be asking these questions, would you?).  Also 
someone else, more familiar with some platforms that we support, may be 
able to help you with that.

 Anyway, good luck!

  Maciej
