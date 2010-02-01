Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2010 03:18:52 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:42434 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1493297Ab0BACSo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Feb 2010 03:18:44 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o112Iu6R009066;
        Mon, 1 Feb 2010 03:18:57 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o112ItGc009062;
        Mon, 1 Feb 2010 03:18:55 +0100
Date:   Mon, 1 Feb 2010 03:18:54 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Guenter Roeck <guenter.roeck@ericsson.com>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Kernel crash in 2.6.32.6 / bcm1480 with 16k page size
Message-ID: <20100201021854.GA8572@linux-mips.org>
References: <20100129151220.GA3882@ericsson.com>
 <4B6316D2.1060006@caviumnetworks.com>
 <20100129180619.GA20113@linux-mips.org>
 <20100129183926.GB9895@ericsson.com>
 <4B632F60.4000604@caviumnetworks.com>
 <20100129192532.GA11123@ericsson.com>
 <4B6336F1.8070208@caviumnetworks.com>
 <20100129195801.GC11123@ericsson.com>
 <alpine.LFD.2.00.1001310907320.31764@eddie.linux-mips.org>
 <20100131165503.GA18523@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100131165503.GA18523@ericsson.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25796
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jan 31, 2010 at 08:55:03AM -0800, Guenter Roeck wrote:

> >  The size of the address space can be probed via CP0 registers (for MIPS 
> > architecture processors that is).  No need to add any CPU dependencies 
> > (except from legacy 64-bit MIPS processors perhaps).
> > 
> That would help. Do you happen to know which CP0 register(s) to look for ? 
> I browsed through the MIPS 5K and 20Kc manuals, but didn't find it.

Write a value with all bits set to c0_entryhi, then read it back again.
The set bits in the VPN2 bitfield will indicate the size of the virtual
address range supported.  The MIPS64 documentation also calls this value
SEGBITS.  The nice thing about this probe is that it is supported for
all 64-bit MIPS processors except the R8000 which has an entirely different
TLB scheme anyway.

Similarly it is possible to probe the physical address range in either
c0_entrylo0 or c0_entrylo1.  This is also of interest on 32-bit processors.

  Ralf
