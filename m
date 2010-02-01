Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2010 16:04:25 +0100 (CET)
Received: from kuber.nabble.com ([216.139.236.158]:35857 "EHLO
        kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492406Ab0BAPEV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2010 16:04:21 +0100
Received: from isper.nabble.com ([192.168.236.156])
        by kuber.nabble.com with esmtp (Exim 4.63)
        (envelope-from <lists@nabble.com>)
        id 1Nbxp3-0003ol-Gs
        for linux-mips@linux-mips.org; Mon, 01 Feb 2010 07:04:17 -0800
Message-ID: <27405624.post@talk.nabble.com>
Date:   Mon, 1 Feb 2010 07:04:17 -0800 (PST)
From:   Guenter Roeck <public@roeck-us.net>
To:     linux-mips@linux-mips.org
Subject: Re: Kernel crash in 2.6.32.6 / bcm1480 with 16k page size
In-Reply-To: <20100201021854.GA8572@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: public@roeck-us.net
References: <20100128155514.GA31611@ericsson.com> <20100129132406.GD5685@linux-mips.org> <20100129151220.GA3882@ericsson.com> <4B6316D2.1060006@caviumnetworks.com> <20100129180619.GA20113@linux-mips.org> <20100129183926.GB9895@ericsson.com> <4B632F60.4000604@caviumnetworks.com> <20100129192532.GA11123@ericsson.com> <4B6336F1.8070208@caviumnetworks.com> <20100129195801.GC11123@ericsson.com> <alpine.LFD.2.00.1001310907320.31764@eddie.linux-mips.org> <20100131165503.GA18523@ericsson.com> <20100201021854.GA8572@linux-mips.org>
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: public@roeck-us.net
Precedence: bulk
X-list: linux-mips



Ralf Baechle DL5RB wrote:
> 
> On Sun, Jan 31, 2010 at 08:55:03AM -0800, Guenter Roeck wrote:
> 
>> >  The size of the address space can be probed via CP0 registers (for
>> MIPS 
>> > architecture processors that is).  No need to add any CPU dependencies 
>> > (except from legacy 64-bit MIPS processors perhaps).
>> > 
>> That would help. Do you happen to know which CP0 register(s) to look for
>> ? 
>> I browsed through the MIPS 5K and 20Kc manuals, but didn't find it.
> 
> Write a value with all bits set to c0_entryhi, then read it back again.
> The set bits in the VPN2 bitfield will indicate the size of the virtual
> address range supported.  The MIPS64 documentation also calls this value
> SEGBITS.  The nice thing about this probe is that it is supported for
> all 64-bit MIPS processors except the R8000 which has an entirely
> different
> TLB scheme anyway.
> 
> Similarly it is possible to probe the physical address range in either
> c0_entrylo0 or c0_entrylo1.  This is also of interest on 32-bit
> processors.
> 
>   Ralf
> 
> 
> 

Ok, I'll try that and submit a new set of patches if it works.

Guenter

-- 
View this message in context: http://old.nabble.com/Kernel-crash-in-2.6.32.6---bcm1480-with-16k-page-size-tp27358179p27405624.html
Sent from the linux-mips main mailing list archive at Nabble.com.
