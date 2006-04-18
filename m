Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Apr 2006 02:40:34 +0100 (BST)
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:38279 "EHLO
	ms-smtp-02.nyroc.rr.com") by ftp.linux-mips.org with ESMTP
	id S8133742AbWDRBkX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Apr 2006 02:40:23 +0100
Received: from [192.168.23.10] (cpe-24-94-51-176.stny.res.rr.com [24.94.51.176])
	by ms-smtp-02.nyroc.rr.com (8.13.4/8.13.4) with ESMTP id k3I1pNOW003024;
	Mon, 17 Apr 2006 21:51:23 -0400 (EDT)
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
From:	Steven Rostedt <rostedt@goodmis.org>
To:	Christoph Lameter <clameter@sgi.com>
Cc:	Ravikiran G Thirumalai <kiran@scalex86.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
	Martin Mares <mj@atrey.karlin.mff.cuni.cz>, bjornw@axis.com,
	schwidefsky@de.ibm.com, benedict.gaster@superh.com,
	lethal@linux-sh.org, Chris Zankel <chris@zankel.net>,
	Marc Gauthier <marc@tensilica.com>,
	Joe Taylor <joe@tensilica.com>,
	David Mosberger-Tang <davidm@hpl.hp.com>, rth@twiddle.net,
	spyro@f2s.com, starvik@axis.com, tony.luck@intel.com,
	linux-ia64@vger.kernel.org, ralf@linux-mips.org,
	linux-mips@linux-mips.org, grundler@parisc-linux.org,
	parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, linux390@de.ibm.com, davem@davemloft.net
In-Reply-To: <Pine.LNX.4.64.0604171647330.31773@schroedinger.engr.sgi.com>
References: <1145049535.1336.128.camel@localhost.localdomain>
	 <4440855A.7040203@yahoo.com.au>
	 <Pine.LNX.4.64.0604170953390.29732@schroedinger.engr.sgi.com>
	 <20060417220238.GD3945@localhost.localdomain>
	 <Pine.LNX.4.58.0604171936040.24264@gandalf.stny.rr.com>
	 <Pine.LNX.4.64.0604171647330.31773@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date:	Mon, 17 Apr 2006 21:51:23 -0400
Message-Id: <1145325083.17085.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Mon, 2006-04-17 at 16:48 -0700, Christoph Lameter wrote:
> On Mon, 17 Apr 2006, Steven Rostedt wrote:
> 
> > So now we can focus on a better solution.
> 
> Could you have a look at Kiran's work?
> 
> Maybe one result of your work could be that the existing indirection
> for alloc_percpu could be avoided?

Sure,  I'll spend some time looking at what others have done and see
what I can put together.  I'm also very busy on other stuff at the
moment, so this will be something I do more on the side.  Don't think
there's a rush here, but I stated in a previous post, I probably wont
have something out for a month or two.

-- Steve
