Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2010 19:21:34 +0100 (CET)
Received: from mgate.redback.com ([155.53.3.41]:22832 "EHLO mgate.redback.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492803Ab0A2SV2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 29 Jan 2010 19:21:28 +0100
X-IronPort-AV: E=Sophos;i="4.49,370,1262592000"; 
   d="scan'208";a="7711889"
Received: from prattle.redback.com ([155.53.12.9])
  by mgate.redback.com with ESMTP; 29 Jan 2010 10:21:25 -0800
Received: from localhost (localhost [127.0.0.1])
        by prattle.redback.com (Postfix) with ESMTP id 1DE251067B7E;
        Fri, 29 Jan 2010 10:21:25 -0800 (PST)
Received: from prattle.redback.com ([127.0.0.1])
 by localhost (prattle [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 19569-03; Fri, 29 Jan 2010 10:21:25 -0800 (PST)
Received: from lxlogin-3-300 (lxlogin-3-300.redback.com [155.53.12.218])
        by prattle.redback.com (Postfix) with SMTP id 742E51067B7D;
        Fri, 29 Jan 2010 10:21:19 -0800 (PST)
Received: by lxlogin-3-300 (sSMTP sendmail emulation); Fri, 29 Jan 2010 10:21:19 -0800
Date:   Fri, 29 Jan 2010 10:21:19 -0800
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Kernel crash in 2.6.32.6 / bcm1480 with 16k page size
Message-ID: <20100129182119.GA9441@ericsson.com>
References: <20100128155514.GA31611@ericsson.com> <20100129132406.GD5685@linux-mips.org> <20100129151220.GA3882@ericsson.com> <4B6316D2.1060006@caviumnetworks.com> <20100129180619.GA20113@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100129180619.GA20113@linux-mips.org>
User-Agent: Mutt/1.5.4i
X-archive-position: 25742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19043

On Fri, Jan 29, 2010 at 01:06:20PM -0500, Ralf Baechle wrote:
> On Fri, Jan 29, 2010 at 09:11:46AM -0800, David Daney wrote:
> 
> > >So first question would be: Has anyone successfully loaded a 64
> > >bit mips kernel with 2.6.32 and a page size of 16k or 64k ? This
> > >would at least help me reducing the problem to sb1.
> > 
> > Yes, I routinely run with both 64K and 16K page sizes on 2.6.32 and
> > 2.6.33-rc*.  I have not seen any crashes that can not be easily
> > explained.
> 
> I can reproduce it with today's 14b7baff3eb4b1b46a592630e6f85ded9264798a.
> 4K page size works ok, 16K without IPv6 works ok and 16K with IPv6 crashes.
> Note, I was testing with a non-16K capable userland so ok means userland is
> reached.
> 
Yes, I forgot to mention that IPv6 needs to be enabled. That has nothing to do
with the problem, though. IPv6 enabled just means that the percpu code needs to
allocate more memory. This memory allocation then crashes.

> Either way, that's good enought to look into things.
> 
Did you see the problem on a bcm1250/1480 or with some other mips core ?

Guenter
