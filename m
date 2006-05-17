Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 May 2006 19:41:34 +0200 (CEST)
Received: from omx1-ext.sgi.com ([192.48.179.11]:54680 "EHLO
	omx1.americas.sgi.com") by ftp.linux-mips.org with ESMTP
	id S8133816AbWEQRlY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 May 2006 19:41:24 +0200
Received: from imr2.americas.sgi.com (imr2.americas.sgi.com [198.149.16.18])
	by omx1.americas.sgi.com (8.12.10/8.12.9/linux-outbound_gateway-1.1) with ESMTP id k4HHe5nx000726;
	Wed, 17 May 2006 12:40:06 -0500
Received: from spindle.corp.sgi.com (spindle.corp.sgi.com [198.29.75.13])
	by imr2.americas.sgi.com (8.12.9/8.12.10/SGI_generic_relay-1.2) with ESMTP id k4HHx77p29646354;
	Wed, 17 May 2006 10:59:07 -0700 (PDT)
Received: from schroedinger.engr.sgi.com (schroedinger.engr.sgi.com [163.154.5.55])
	by spindle.corp.sgi.com (SGI-8.12.5/8.12.9/generic_config-1.2) with ESMTP id k4HHe4nB29472097;
	Wed, 17 May 2006 10:40:04 -0700 (PDT)
Received: from christoph (helo=localhost)
	by schroedinger.engr.sgi.com with local-esmtp (Exim 3.36 #1 (Debian))
	id 1FgQ0C-0003g3-00; Wed, 17 May 2006 10:40:04 -0700
Date:	Wed, 17 May 2006 10:40:04 -0700 (PDT)
From:	Christoph Lameter <clameter@sgi.com>
To:	Steven Rostedt <rostedt@goodmis.org>
cc:	LKML <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Paul Mackerras <paulus@samba.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
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
	linux390@de.ibm.com, davem@davemloft.net, arnd@arndb.de,
	kenneth.w.chen@intel.com, sam@ravnborg.org, kiran@scalex86.org
Subject: Re: [RFC PATCH 00/09] robust VM per_cpu variables
In-Reply-To: <Pine.LNX.4.58.0605171152190.15798@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.64.0605171038160.13767@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
 <Pine.LNX.4.64.0605170744360.13021@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0605171104100.13160@gandalf.stny.rr.com>
 <Pine.LNX.4.64.0605170846190.13337@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0605171152190.15798@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <christoph@schroedinger.engr.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clameter@sgi.com
Precedence: bulk
X-list: linux-mips

On Wed, 17 May 2006, Steven Rostedt wrote:

> > Well I'd like to see a comprehensive solution including a fix for the
> > problems with allocper_cpu() allocations (allocper_cpu has to allocate
> > memory for potential processors... which could be a lot on
> > some types of systems and its allocated somewhere not on the nodes of the
> > processor since they may not yet be online).
> 
> OK, now you're beyond what I'm working with ;)  No hot plug CPUs for me.
> Well, at least not yet!

You need to at least consider how this could be handled by the per_cpu 
memory manangement. The VM thingie with dynamic per cpu memory would allow 
a fixup of allocpercpu.
