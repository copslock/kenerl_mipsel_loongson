Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Jan 2010 17:53:58 +0100 (CET)
Received: from imr1.ericy.com ([198.24.6.9]:47078 "EHLO imr1.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492052Ab0AaQxg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 31 Jan 2010 17:53:36 +0100
Received: from eusaamw0706.eamcs.ericsson.se ([147.117.20.31])
        by imr1.ericy.com (8.13.1/8.13.1) with ESMTP id o0VGsNRL018229;
        Sun, 31 Jan 2010 10:54:26 -0600
Received: from localhost (147.117.20.212) by eusaamw0706.eamcs.ericsson.se
 (147.117.20.91) with Microsoft SMTP Server id 8.1.375.2; Sun, 31 Jan 2010
 11:53:21 -0500
Date:   Sun, 31 Jan 2010 08:55:03 -0800
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     David Daney <ddaney@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Kernel crash in 2.6.32.6 / bcm1480 with 16k page size
Message-ID: <20100131165503.GA18523@ericsson.com>
References: <20100129132406.GD5685@linux-mips.org> <20100129151220.GA3882@ericsson.com> <4B6316D2.1060006@caviumnetworks.com> <20100129180619.GA20113@linux-mips.org> <20100129183926.GB9895@ericsson.com> <4B632F60.4000604@caviumnetworks.com> <20100129192532.GA11123@ericsson.com> <4B6336F1.8070208@caviumnetworks.com> <20100129195801.GC11123@ericsson.com> <alpine.LFD.2.00.1001310907320.31764@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1001310907320.31764@eddie.linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 25791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sun, Jan 31, 2010 at 04:10:10AM -0500, Maciej W. Rozycki wrote:
> On Fri, 29 Jan 2010, Guenter Roeck wrote:
> 
> > > I suspect you are hitting a maximum valid address bits limit and getting 
> > > the Address Exception.  Limiting VMALLOC_END so that you don't hit the 
> > > limit seems to be the solution.  I don't have the manual for the sibyte, 
> > > so I don't know what the limit is.  The architecture specification 
> > > doesn't state a fixed limit, although it tells what should happen when 
> > > the limit is reached.
> > > 
> > You mean there might be a CPU-specific limit ? I hope not - that would be quite messy.
> 
>  The size of the address space can be probed via CP0 registers (for MIPS 
> architecture processors that is).  No need to add any CPU dependencies 
> (except from legacy 64-bit MIPS processors perhaps).
> 
That would help. Do you happen to know which CP0 register(s) to look for ? 
I browsed through the MIPS 5K and 20Kc manuals, but didn't find it.

Guenter
