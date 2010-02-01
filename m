Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2010 21:19:59 +0100 (CET)
Received: from imr1.ericy.com ([198.24.6.9]:34821 "EHLO imr1.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492772Ab0BAUTw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Feb 2010 21:19:52 +0100
Received: from eusaamw0706.eamcs.ericsson.se ([147.117.20.31])
        by imr1.ericy.com (8.13.1/8.13.1) with ESMTP id o11KKWjo011497;
        Mon, 1 Feb 2010 14:20:41 -0600
Received: from [155.53.128.103] (147.117.20.212) by
 eusaamw0706.eamcs.ericsson.se (147.117.20.91) with Microsoft SMTP Server id
 8.1.375.2; Mon, 1 Feb 2010 15:19:35 -0500
Subject: Re: Kernel crash in 2.6.32.6 / bcm1480 with 16k page size
From:   Guenter Roeck <guenter.roeck@ericsson.com>
Reply-To: guenter.roeck@ericsson.com
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <20100201021854.GA8572@linux-mips.org>
References: <20100129151220.GA3882@ericsson.com>
         <4B6316D2.1060006@caviumnetworks.com>
         <20100129180619.GA20113@linux-mips.org>
         <20100129183926.GB9895@ericsson.com> <4B632F60.4000604@caviumnetworks.com>
         <20100129192532.GA11123@ericsson.com> <4B6336F1.8070208@caviumnetworks.com>
         <20100129195801.GC11123@ericsson.com>
         <alpine.LFD.2.00.1001310907320.31764@eddie.linux-mips.org>
         <20100131165503.GA18523@ericsson.com>
         <20100201021854.GA8572@linux-mips.org>
Content-Type: text/plain
Organization: Ericsson
Date:   Mon, 1 Feb 2010 12:21:17 -0800
Message-ID: <1265055677.5825.47.camel@groeck-laptop>
MIME-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <guenter.roeck@ericsson.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips

On Sun, 2010-01-31 at 21:18 -0500, Ralf Baechle wrote:
> On Sun, Jan 31, 2010 at 08:55:03AM -0800, Guenter Roeck wrote:
> 
> > >  The size of the address space can be probed via CP0 registers (for MIPS 
> > > architecture processors that is).  No need to add any CPU dependencies 
> > > (except from legacy 64-bit MIPS processors perhaps).
> > > 
> > That would help. Do you happen to know which CP0 register(s) to look for ? 
> > I browsed through the MIPS 5K and 20Kc manuals, but didn't find it.
> 
> Write a value with all bits set to c0_entryhi, then read it back again.
> The set bits in the VPN2 bitfield will indicate the size of the virtual
> address range supported.  The MIPS64 documentation also calls this value
> SEGBITS.  The nice thing about this probe is that it is supported for
> all 64-bit MIPS processors except the R8000 which has an entirely different
> TLB scheme anyway.

Are you sure that this doesn't work for the R8000 ? From the user's
manual (section 2.1.9, EntryHi) it looks like it should work.

Guenter
