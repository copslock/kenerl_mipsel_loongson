Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2010 00:11:56 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:56445 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492772Ab0BAXLw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Feb 2010 00:11:52 +0100
Date:   Mon, 1 Feb 2010 23:11:52 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Guenter Roeck <guenter.roeck@ericsson.com>,
        David Daney <ddaney@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Kernel crash in 2.6.32.6 / bcm1480 with 16k page size
In-Reply-To: <20100201152601.GA22640@linux-mips.org>
Message-ID: <alpine.LFD.2.00.1002012305390.3578@eddie.linux-mips.org>
References: <20100129180619.GA20113@linux-mips.org> <20100129183926.GB9895@ericsson.com> <4B632F60.4000604@caviumnetworks.com> <20100129192532.GA11123@ericsson.com> <4B6336F1.8070208@caviumnetworks.com> <20100129195801.GC11123@ericsson.com>
 <alpine.LFD.2.00.1001310907320.31764@eddie.linux-mips.org> <20100131165503.GA18523@ericsson.com> <20100201021854.GA8572@linux-mips.org> <alpine.LFD.2.00.1002011448050.26199@eddie.linux-mips.org> <20100201152601.GA22640@linux-mips.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 1 Feb 2010, Ralf Baechle wrote:

> >  Indeed -- IIRC the architecture spec calls this value PABITS.  I wasn't 
> > sure about the legacy processors -- if that works with them too, then it's 
> > even better.
> 
> The probing method was undocumented until MIPS64 but if you look at the
> format of the EntryLo register it's always been possible.  The R10000

 Frankly, I would be concerned about some reserved bits left floating 
rather than hardwired to any particular logical state, but the number of 
chips to check is limited.  At least for some of them documentation is 
explicit the value reported is fixed and we can take it as an indication 
it is likely actually the case.

> needs special treatment though - it has the UC (Uncache Attribute) field
> in the bits 62..63 of EntryLo; this field needs to be ignored.

 Well, I think masking out everything beyond what would become the bit #63 
of the physical address unconditionally is a safe and reasonable way to 
make the approach automagically work for the R10k too.

  Maciej
