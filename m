Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2010 15:50:31 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:47152 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492407Ab0BAOu1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2010 15:50:27 +0100
Date:   Mon, 1 Feb 2010 14:50:27 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Guenter Roeck <guenter.roeck@ericsson.com>,
        David Daney <ddaney@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Kernel crash in 2.6.32.6 / bcm1480 with 16k page size
In-Reply-To: <20100201021854.GA8572@linux-mips.org>
Message-ID: <alpine.LFD.2.00.1002011448050.26199@eddie.linux-mips.org>
References: <20100129151220.GA3882@ericsson.com> <4B6316D2.1060006@caviumnetworks.com> <20100129180619.GA20113@linux-mips.org> <20100129183926.GB9895@ericsson.com> <4B632F60.4000604@caviumnetworks.com> <20100129192532.GA11123@ericsson.com>
 <4B6336F1.8070208@caviumnetworks.com> <20100129195801.GC11123@ericsson.com> <alpine.LFD.2.00.1001310907320.31764@eddie.linux-mips.org> <20100131165503.GA18523@ericsson.com> <20100201021854.GA8572@linux-mips.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 1 Feb 2010, Ralf Baechle wrote:

> Write a value with all bits set to c0_entryhi, then read it back again.
> The set bits in the VPN2 bitfield will indicate the size of the virtual
> address range supported.  The MIPS64 documentation also calls this value
> SEGBITS.  The nice thing about this probe is that it is supported for
> all 64-bit MIPS processors except the R8000 which has an entirely different
> TLB scheme anyway.
> 
> Similarly it is possible to probe the physical address range in either
> c0_entrylo0 or c0_entrylo1.  This is also of interest on 32-bit processors.

 Indeed -- IIRC the architecture spec calls this value PABITS.  I wasn't 
sure about the legacy processors -- if that works with them too, then it's 
even better.

  Maciej
