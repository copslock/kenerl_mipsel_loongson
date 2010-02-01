Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2010 22:10:49 +0100 (CET)
Received: from imr1.ericy.com ([198.24.6.9]:59553 "EHLO imr1.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491886Ab0BAVKo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Feb 2010 22:10:44 +0100
Received: from eusaamw0707.eamcs.ericsson.se ([147.117.20.32])
        by imr1.ericy.com (8.13.1/8.13.1) with ESMTP id o11LBbCp003321;
        Mon, 1 Feb 2010 15:11:42 -0600
Received: from [155.53.128.103] (147.117.20.212) by
 eusaamw0707.eamcs.ericsson.se (147.117.20.92) with Microsoft SMTP Server id
 8.1.375.2; Mon, 1 Feb 2010 16:10:35 -0500
Subject: Re: Kernel crash in 2.6.32.6 / bcm1480 with 16k page size
From:   Guenter Roeck <guenter.roeck@ericsson.com>
Reply-To: guenter.roeck@ericsson.com
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <20100201204912.GC17381@linux-mips.org>
References: <20100129180619.GA20113@linux-mips.org>
         <20100129183926.GB9895@ericsson.com> <4B632F60.4000604@caviumnetworks.com>
         <20100129192532.GA11123@ericsson.com> <4B6336F1.8070208@caviumnetworks.com>
         <20100129195801.GC11123@ericsson.com>
         <alpine.LFD.2.00.1001310907320.31764@eddie.linux-mips.org>
         <20100131165503.GA18523@ericsson.com>
         <20100201021854.GA8572@linux-mips.org>
         <1265055677.5825.47.camel@groeck-laptop>
         <20100201204912.GC17381@linux-mips.org>
Content-Type: text/plain
Organization: Ericsson
Date:   Mon, 1 Feb 2010 13:12:17 -0800
Message-ID: <1265058737.5825.55.camel@groeck-laptop>
MIME-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <guenter.roeck@ericsson.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips

On Mon, 2010-02-01 at 15:49 -0500, Ralf Baechle wrote:
> On Mon, Feb 01, 2010 at 12:21:17PM -0800, Guenter Roeck wrote:
> 
> > > Write a value with all bits set to c0_entryhi, then read it back again.
> > > The set bits in the VPN2 bitfield will indicate the size of the virtual
> > > address range supported.  The MIPS64 documentation also calls this value
> > > SEGBITS.  The nice thing about this probe is that it is supported for
> > > all 64-bit MIPS processors except the R8000 which has an entirely different
> > > TLB scheme anyway.
> > 
> > Are you sure that this doesn't work for the R8000 ? From the user's
> > manual (section 2.1.9, EntryHi) it looks like it should work.
> 
> The probe itself will work if it's carefully written not to get fooled by
> difference in bits 12..18 but that's easy) but still the R8000 has a fairly
> different TLB architecture which Linux doesn't support - the machines are
> rare and none of the active developers has one.
> 
Looks like my code should work. I'll send out a patch in a couple of
minutes.

Guenter
