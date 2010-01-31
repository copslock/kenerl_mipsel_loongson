Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Jan 2010 10:10:14 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:33732 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492118Ab0AaJKK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 31 Jan 2010 10:10:10 +0100
Date:   Sun, 31 Jan 2010 09:10:10 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Guenter Roeck <guenter.roeck@ericsson.com>
cc:     David Daney <ddaney@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Kernel crash in 2.6.32.6 / bcm1480 with 16k page size
In-Reply-To: <20100129195801.GC11123@ericsson.com>
Message-ID: <alpine.LFD.2.00.1001310907320.31764@eddie.linux-mips.org>
References: <20100128155514.GA31611@ericsson.com> <20100129132406.GD5685@linux-mips.org> <20100129151220.GA3882@ericsson.com> <4B6316D2.1060006@caviumnetworks.com> <20100129180619.GA20113@linux-mips.org> <20100129183926.GB9895@ericsson.com>
 <4B632F60.4000604@caviumnetworks.com> <20100129192532.GA11123@ericsson.com> <4B6336F1.8070208@caviumnetworks.com> <20100129195801.GC11123@ericsson.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 25776
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, 29 Jan 2010, Guenter Roeck wrote:

> > I suspect you are hitting a maximum valid address bits limit and getting 
> > the Address Exception.  Limiting VMALLOC_END so that you don't hit the 
> > limit seems to be the solution.  I don't have the manual for the sibyte, 
> > so I don't know what the limit is.  The architecture specification 
> > doesn't state a fixed limit, although it tells what should happen when 
> > the limit is reached.
> > 
> You mean there might be a CPU-specific limit ? I hope not - that would be quite messy.

 The size of the address space can be probed via CP0 registers (for MIPS 
architecture processors that is).  No need to add any CPU dependencies 
(except from legacy 64-bit MIPS processors perhaps).

  Maciej
