Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2010 21:49:06 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:36914 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492082Ab0BAUtC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Feb 2010 21:49:02 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o11KnEFA019425;
        Mon, 1 Feb 2010 21:49:14 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o11KnDRU019421;
        Mon, 1 Feb 2010 21:49:13 +0100
Date:   Mon, 1 Feb 2010 21:49:12 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Guenter Roeck <guenter.roeck@ericsson.com>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Kernel crash in 2.6.32.6 / bcm1480 with 16k page size
Message-ID: <20100201204912.GC17381@linux-mips.org>
References: <20100129180619.GA20113@linux-mips.org>
 <20100129183926.GB9895@ericsson.com>
 <4B632F60.4000604@caviumnetworks.com>
 <20100129192532.GA11123@ericsson.com>
 <4B6336F1.8070208@caviumnetworks.com>
 <20100129195801.GC11123@ericsson.com>
 <alpine.LFD.2.00.1001310907320.31764@eddie.linux-mips.org>
 <20100131165503.GA18523@ericsson.com>
 <20100201021854.GA8572@linux-mips.org>
 <1265055677.5825.47.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1265055677.5825.47.camel@groeck-laptop>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 01, 2010 at 12:21:17PM -0800, Guenter Roeck wrote:

> > Write a value with all bits set to c0_entryhi, then read it back again.
> > The set bits in the VPN2 bitfield will indicate the size of the virtual
> > address range supported.  The MIPS64 documentation also calls this value
> > SEGBITS.  The nice thing about this probe is that it is supported for
> > all 64-bit MIPS processors except the R8000 which has an entirely different
> > TLB scheme anyway.
> 
> Are you sure that this doesn't work for the R8000 ? From the user's
> manual (section 2.1.9, EntryHi) it looks like it should work.

The probe itself will work if it's carefully written not to get fooled by
difference in bits 12..18 but that's easy) but still the R8000 has a fairly
different TLB architecture which Linux doesn't support - the machines are
rare and none of the active developers has one.

  Ralf
