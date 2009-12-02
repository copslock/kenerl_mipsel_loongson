Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2009 19:52:42 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:44038 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493726AbZLBSwj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Dec 2009 19:52:39 +0100
Date:   Wed, 2 Dec 2009 18:52:39 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
cc:     Ales Mulej <Ales.Mulej@HSTX.com>, linux-mips@linux-mips.org
Subject: Re: Reserved instruction in kernel code
In-Reply-To: <4B16A7CC.3090305@caviumnetworks.com>
Message-ID: <alpine.LFD.2.00.0912021831270.7385@eddie.linux-mips.org>
References: <C5BD21D6E1A3114C8765C8FBBD0087BA330A85@exchtxuk2.HSTX.global.vpn> <4B16A7CC.3090305@caviumnetworks.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 2 Dec 2009, David Daney wrote:

> > Reserved instruction in kernel code[#1]:
> > 
> > Cpu 0
> > 
> > $ 0   : 00000000 1000fc00 802be630 00000001
> > 
> > $ 4   : 802be670 802be674 ffffffff 802f4d4c
> > 
> > $ 8   : 1000fc01 1000001f 00000001 0000002b
> > 
> > $12   : 00000000 000001f5 07a0d380 00000000
> > 
> > $16   : 00000000 00000000 00000000 1000fc00
> > 
> > $20   : 802e9674 bd030f04 3e490000 00000a72
> > 
> > $24   : 00000008 8000167c                 
> > $28   : 802ba000 802bbd30 ffffffff 802f4d4c
> > 
> > Hi    : 000000fb
> > 
> > Lo    : 00000001
> > 
> > epc   : 801013a0 handle_ri_int+0x18/0x38
> > 
> >     Not tainted
> > 
> > ra    : 802f4d4c __log_buf+0x0/0x20000
> > 
> > Status: 1000fc03    KERNEL EXL IE
> > 
> > Cause : 50808000
> > 
> > PrId  : 00019365 (MIPS 24Kc)
> > 
> > Modules linked in:
> > 
> > Process swapper (pid: 0, threadinfo=802ba000, task=802bc000, tls=00000000)
> > 
> > Stack : 1000fc00 1000001f 00000001 0000002b 00000000 000001f5 00000000
> > 1000fc00
> > 
> >         802be630 00000001 802be670 802be674 ffffffff 802f4d4c 1000fc00
> > 1000001f
> > 
> >         00000001 0000002b 00000000 000001f5 07a0d380 00000000 00000000
> > 00000000
> > 
> >         00000000 1000fc00 802e9674 bd030f04 3e490000 00000a72 00000008
> > 8000167c
> > 
> >         802bbe94 802a2954 802ba000 802bbde0 ffffffff 802f4d4c 1000fc02
> > 000000fb
> > 
> >         ...
> > 
> > Call Trace:
> > 
> > [<801013a0>] handle_ri_int+0x18/0x38
> > 
> >  
> >  
> > Code: 01094025  3908001e  40886000 <00000040> 00000040  00000040  
> 
>       ...   ssnop ssnop ssnop ...
> 
> One would think a 'PrId  : 00019365 (MIPS 24Kc)' would execute those.
> 
> The cause value indicates an 'Interrupt' but you are somehow executing in
> handle_ri_int, so it could be that multiple exceptions are messing up the OOPS
> output...

 Look at the preceding code -- the EXL bit has just been cleared (while 
executing handle_ri_int()) and the interrupt exception has been 
immediately taken, overwriting the EPC and Cause registers with what you 
can see above.  So either the original RI exception happened earlier 
elsewhere, or there is something completely broken somewhere resulting in 
this misleading dump (like stack corruption resulting in a jump to 
handle_ri() or whatever).

 To figure out which is the case I'd suggest running the RI handler with 
interrupts disabled for debugging and see if the correct values from EPC 
and Cause are reported.  If this runs correctly, then obviously the 
causing place of the RI exception has to be fixed, but also the interrupt 
exception handler has to be investigated to see why the values from EPC 
and Cause stored on the stack get corrupted.  Otherwise the new symptoms 
will (hopefully) suggest what to do next.

  Maciej
