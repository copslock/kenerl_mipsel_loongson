Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Apr 2006 00:37:49 +0100 (BST)
Received: from omx2-ext.sgi.com ([192.48.171.19]:5296 "EHLO omx2.sgi.com")
	by ftp.linux-mips.org with ESMTP id S8133730AbWDQXhj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 18 Apr 2006 00:37:39 +0100
Received: from internal-mail-relay1.corp.sgi.com (internal-mail-relay1.corp.sgi.com [198.149.32.52])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id k3I229b4009982;
	Mon, 17 Apr 2006 19:02:09 -0700
Received: from spindle.corp.sgi.com (spindle.corp.sgi.com [198.29.75.13])
	by internal-mail-relay1.corp.sgi.com (8.12.9/8.12.10/SGI_generic_relay-1.2) with ESMTP id k3HNsgpG8012564;
	Mon, 17 Apr 2006 16:54:42 -0700 (PDT)
Received: from schroedinger.engr.sgi.com (schroedinger.engr.sgi.com [163.154.5.55])
	by spindle.corp.sgi.com (SGI-8.12.5/8.12.9/generic_config-1.2) with ESMTP id k3HNmqnB33074263;
	Mon, 17 Apr 2006 16:48:52 -0700 (PDT)
Received: from christoph (helo=localhost)
	by schroedinger.engr.sgi.com with local-esmtp (Exim 3.36 #1 (Debian))
	id 1FVdSe-0008HW-00; Mon, 17 Apr 2006 16:48:52 -0700
Date:	Mon, 17 Apr 2006 16:48:52 -0700 (PDT)
From:	Christoph Lameter <clameter@sgi.com>
To:	Steven Rostedt <rostedt@goodmis.org>
cc:	Ravikiran G Thirumalai <kiran@scalex86.org>,
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
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
In-Reply-To: <Pine.LNX.4.58.0604171936040.24264@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.64.0604171647330.31773@schroedinger.engr.sgi.com>
References: <1145049535.1336.128.camel@localhost.localdomain>
 <4440855A.7040203@yahoo.com.au> <Pine.LNX.4.64.0604170953390.29732@schroedinger.engr.sgi.com>
 <20060417220238.GD3945@localhost.localdomain> <Pine.LNX.4.58.0604171936040.24264@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <christoph@schroedinger.engr.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11148
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clameter@sgi.com
Precedence: bulk
X-list: linux-mips

On Mon, 17 Apr 2006, Steven Rostedt wrote:

> So now we can focus on a better solution.

Could you have a look at Kiran's work?

Maybe one result of your work could be that the existing indirection
for alloc_percpu could be avoided?
