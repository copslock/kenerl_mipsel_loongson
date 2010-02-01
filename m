Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2010 16:25:59 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:42517 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492503Ab0BAPZv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Feb 2010 16:25:51 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o11FQ48q030359;
        Mon, 1 Feb 2010 16:26:04 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o11FQ28g030351;
        Mon, 1 Feb 2010 16:26:02 +0100
Date:   Mon, 1 Feb 2010 16:26:01 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Guenter Roeck <guenter.roeck@ericsson.com>,
        David Daney <ddaney@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Kernel crash in 2.6.32.6 / bcm1480 with 16k page size
Message-ID: <20100201152601.GA22640@linux-mips.org>
References: <20100129180619.GA20113@linux-mips.org>
 <20100129183926.GB9895@ericsson.com>
 <4B632F60.4000604@caviumnetworks.com>
 <20100129192532.GA11123@ericsson.com>
 <4B6336F1.8070208@caviumnetworks.com>
 <20100129195801.GC11123@ericsson.com>
 <alpine.LFD.2.00.1001310907320.31764@eddie.linux-mips.org>
 <20100131165503.GA18523@ericsson.com>
 <20100201021854.GA8572@linux-mips.org>
 <alpine.LFD.2.00.1002011448050.26199@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1002011448050.26199@eddie.linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 01, 2010 at 02:50:27PM +0000, Maciej W. Rozycki wrote:

> > Write a value with all bits set to c0_entryhi, then read it back again.
> > The set bits in the VPN2 bitfield will indicate the size of the virtual
> > address range supported.  The MIPS64 documentation also calls this value
> > SEGBITS.  The nice thing about this probe is that it is supported for
> > all 64-bit MIPS processors except the R8000 which has an entirely different
> > TLB scheme anyway.
> > 
> > Similarly it is possible to probe the physical address range in either
> > c0_entrylo0 or c0_entrylo1.  This is also of interest on 32-bit processors.
> 
>  Indeed -- IIRC the architecture spec calls this value PABITS.  I wasn't 
> sure about the legacy processors -- if that works with them too, then it's 
> even better.

The probing method was undocumented until MIPS64 but if you look at the
format of the EntryLo register it's always been possible.  The R10000
needs special treatment though - it has the UC (Uncache Attribute) field
in the bits 62..63 of EntryLo; this field needs to be ignored.

  Ralf
