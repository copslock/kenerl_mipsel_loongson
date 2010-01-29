Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2010 16:10:59 +0100 (CET)
Received: from imr1.ericy.com ([198.24.6.9]:36044 "EHLO imr1.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492096Ab0A2PKv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 29 Jan 2010 16:10:51 +0100
Received: from eusaamw0706.eamcs.ericsson.se ([147.117.20.31])
        by imr1.ericy.com (8.13.1/8.13.1) with ESMTP id o0TFBaiK016001;
        Fri, 29 Jan 2010 09:11:39 -0600
Received: from localhost (147.117.20.212) by eusaamw0706.eamcs.ericsson.se
 (147.117.20.91) with Microsoft SMTP Server id 8.1.375.2; Fri, 29 Jan 2010
 10:10:38 -0500
Date:   Fri, 29 Jan 2010 07:12:20 -0800
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Kernel crash in 2.6.32.6 / bcm1480 with 16k page size
Message-ID: <20100129151220.GA3882@ericsson.com>
References: <20100128155514.GA31611@ericsson.com> <20100129132406.GD5685@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20100129132406.GD5685@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 25737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18869

On Fri, Jan 29, 2010 at 08:24:07AM -0500, Ralf Baechle wrote:
> On Thu, Jan 28, 2010 at 07:55:14AM -0800, Guenter Roeck wrote:
> > 
> > I get the following kernel crash when running a 2.6.32.6 kernel on a bcm1480 cpu.
> > It only happens if I configure a page size of 16k or 64k; 4k page size is fine.
> > 
> > A similar problem was recently fixed for ppc. It turned out to be a problem in ppc
> > specific memory management code, so that fix won't help here.
> > 
> > Has anyone else seen this before ? Any idea where to start looking for the problem ?
> 
> Supposedly this was working for SB1.  I suggest you find an older kernel
> version that works for your with 16k pages then use git bisect to find
> the problem.
> 
It used to work with 2.6.27.

However, bisect won't work, because the code in question (per cpu memory allocation) was
completely rewritten since then.

The new percpu code tries to allocate memory just below VMALLOC_END. This works on sb1 for
a page size of 4k, but not for a page size of 16k and 64k. The value of VMALLOC_END depends
on the page size.

ppc had a similar problem. It had nothing to do with the new percpu memory allocation code,
but with memory alocation close to VMALLOC_END. In other words, it was a day-one bug which
was never noticed because allocating memory in that address space is highly unlikely.

I suspect the same is the case here. I could write some code for 2.6.27, to test the same
memory allocation there, but I am quite sure the problem is going to show up there as well.

So first question would be: Has anyone successfully loaded a 64 bit mips kernel with 2.6.32 
and a page size of 16k or 64k ? This would at least help me reducing the problem to sb1.

Thanks,
Guenter
