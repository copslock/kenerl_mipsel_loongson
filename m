Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2010 03:05:37 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:51941 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492958Ab0A3CFd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 30 Jan 2010 03:05:33 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0U25hF7015781;
        Sat, 30 Jan 2010 03:05:44 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0U25g1S015778;
        Sat, 30 Jan 2010 03:05:42 +0100
Date:   Sat, 30 Jan 2010 03:05:41 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Guenter Roeck <guenter.roeck@ericsson.com>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Kernel crash in 2.6.32.6 / bcm1480 with 16k page size
Message-ID: <20100130020541.GA3045@linux-mips.org>
References: <20100128155514.GA31611@ericsson.com>
 <20100129132406.GD5685@linux-mips.org>
 <20100129151220.GA3882@ericsson.com>
 <4B6316D2.1060006@caviumnetworks.com>
 <20100129180619.GA20113@linux-mips.org>
 <20100129182119.GA9441@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100129182119.GA9441@ericsson.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19274

On Fri, Jan 29, 2010 at 10:21:19AM -0800, Guenter Roeck wrote:

> On Fri, Jan 29, 2010 at 01:06:20PM -0500, Ralf Baechle wrote:
> > On Fri, Jan 29, 2010 at 09:11:46AM -0800, David Daney wrote:
> > 
> > > >So first question would be: Has anyone successfully loaded a 64
> > > >bit mips kernel with 2.6.32 and a page size of 16k or 64k ? This
> > > >would at least help me reducing the problem to sb1.
> > > 
> > > Yes, I routinely run with both 64K and 16K page sizes on 2.6.32 and
> > > 2.6.33-rc*.  I have not seen any crashes that can not be easily
> > > explained.
> > 
> > I can reproduce it with today's 14b7baff3eb4b1b46a592630e6f85ded9264798a.
> > 4K page size works ok, 16K without IPv6 works ok and 16K with IPv6 crashes.
> > Note, I was testing with a non-16K capable userland so ok means userland is
> > reached.
> > 
> Yes, I forgot to mention that IPv6 needs to be enabled. That has nothing to do
> with the problem, though. IPv6 enabled just means that the percpu code needs to
> allocate more memory. This memory allocation then crashes.
> 
> > Either way, that's good enought to look into things.
> > 
> Did you see the problem on a bcm1250/1480 or with some other mips core ?

That was on R10000.

  Ralf
