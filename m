Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2010 22:33:18 +0100 (CET)
Received: from imr1.ericy.com ([198.24.6.9]:44007 "EHLO imr1.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492575Ab0A3VdN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 30 Jan 2010 22:33:13 +0100
Received: from eusaamw0706.eamcs.ericsson.se ([147.117.20.31])
        by imr1.ericy.com (8.13.1/8.13.1) with ESMTP id o0ULY3UT015670;
        Sat, 30 Jan 2010 15:34:06 -0600
Received: from localhost (147.117.20.212) by eusaamw0706.eamcs.ericsson.se
 (147.117.20.91) with Microsoft SMTP Server id 8.1.375.2; Sat, 30 Jan 2010
 16:33:03 -0500
Date:   Sat, 30 Jan 2010 13:34:45 -0800
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     David Daney <ddaney@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Kernel crash in 2.6.32.6 / bcm1480 with 16k page size
Message-ID: <20100130213445.GA19385@ericsson.com>
References: <20100128155514.GA31611@ericsson.com> <20100129132406.GD5685@linux-mips.org> <20100129151220.GA3882@ericsson.com> <4B6316D2.1060006@caviumnetworks.com> <20100129180619.GA20113@linux-mips.org> <20100129182119.GA9441@ericsson.com> <20100130020541.GA3045@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20100130020541.GA3045@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 25772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19576

On Fri, Jan 29, 2010 at 09:05:41PM -0500, Ralf Baechle wrote:
> On Fri, Jan 29, 2010 at 10:21:19AM -0800, Guenter Roeck wrote:
> 
> > On Fri, Jan 29, 2010 at 01:06:20PM -0500, Ralf Baechle wrote:
> > > On Fri, Jan 29, 2010 at 09:11:46AM -0800, David Daney wrote:
> > > 
> > > > >So first question would be: Has anyone successfully loaded a 64
> > > > >bit mips kernel with 2.6.32 and a page size of 16k or 64k ? This
> > > > >would at least help me reducing the problem to sb1.
> > > > 
> > > > Yes, I routinely run with both 64K and 16K page sizes on 2.6.32 and
> > > > 2.6.33-rc*.  I have not seen any crashes that can not be easily
> > > > explained.
> > > 
> > > I can reproduce it with today's 14b7baff3eb4b1b46a592630e6f85ded9264798a.
> > > 4K page size works ok, 16K without IPv6 works ok and 16K with IPv6 crashes.
> > > Note, I was testing with a non-16K capable userland so ok means userland is
> > > reached.
> > > 
> > Yes, I forgot to mention that IPv6 needs to be enabled. That has nothing to do
> > with the problem, though. IPv6 enabled just means that the percpu code needs to
> > allocate more memory. This memory allocation then crashes.
> > 
> > > Either way, that's good enought to look into things.
> > > 
> > Did you see the problem on a bcm1250/1480 or with some other mips core ?
> 
> That was on R10000.
> 
According to Wikipedia, R10k has a 44 bit virtual memory size limit.

So I think we have two options, assuming we go with the approach I used 
in the patch I sent out yesterday. We could either set the default to 44 bit
and override it with larger values for processors like the Octeon, or go with
a large default (eg with the 60 bit I proposed in the patch) and override it
with smaller values as needed (ie pretty much for all CPUs).

Seems to me if we would have fewer exceptions if we set the default to 44 bit.
Also, it would probably be better if the number of bits is too low for a given CPU,
since it would not result in a crash. So I would prefer to use 44 bit as default.

Thoughts ?

Guenter
