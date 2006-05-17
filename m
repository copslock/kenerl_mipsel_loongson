Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 May 2006 16:54:34 +0200 (CEST)
Received: from omx2-ext.sgi.com ([192.48.171.19]:27315 "EHLO omx2.sgi.com")
	by ftp.linux-mips.org with ESMTP id S8133399AbWEQOyP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 May 2006 16:54:15 +0200
Received: from internal-mail-relay1.corp.sgi.com (internal-mail-relay1.corp.sgi.com [198.149.32.52])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id k4HHAFmm014673;
	Wed, 17 May 2006 10:10:15 -0700
Received: from spindle.corp.sgi.com (spindle.corp.sgi.com [198.29.75.13])
	by internal-mail-relay1.corp.sgi.com (8.12.9/8.12.10/SGI_generic_relay-1.2) with ESMTP id k4HEqc8s5772724;
	Wed, 17 May 2006 07:52:38 -0700 (PDT)
Received: from schroedinger.engr.sgi.com (schroedinger.engr.sgi.com [163.154.5.55])
	by spindle.corp.sgi.com (SGI-8.12.5/8.12.9/generic_config-1.2) with ESMTP id k4HEqcnB37051143;
	Wed, 17 May 2006 07:52:38 -0700 (PDT)
Received: from christoph (helo=localhost)
	by schroedinger.engr.sgi.com with local-esmtp (Exim 3.36 #1 (Debian))
	id 1FgNOA-0003Oz-00; Wed, 17 May 2006 07:52:38 -0700
Date:	Wed, 17 May 2006 07:52:38 -0700 (PDT)
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
In-Reply-To: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.64.0605170744360.13021@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <christoph@schroedinger.engr.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clameter@sgi.com
Precedence: bulk
X-list: linux-mips

On Wed, 17 May 2006, Steven Rostedt wrote:

> My first attempt to fix this introduced another dereference, to allow
> for modules to allocate their own memory.  This was quickly shot down,
> and for good reason, because dereferences kill performance, and don't
> play nice with large SMP systems that depend on per_cpu being fast.

> I now place the per_cpu variables into VM, such that the pages are
> only allocated when needed. All the architecture needs to do is
> supply a VM address range, size for each CPU to use (note this
> implementation expects all the VM CPU areas to be together), and
> three functions to allow for allocating page tables at bootup.

So now instead of an explicit indirection we use an implicit one 
through the page tables for this. This happens during early boot which 
requires additional page table functions? And it requires the use of an 
additional TLB entry? I guess that the additional TLB pressure alone will 
result in a performance drop of 3%?

See http://www.gelato.unsw.edu.au/archives/linux-ia64/0602/17311.html
