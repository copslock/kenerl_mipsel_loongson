Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Apr 2006 17:44:00 +0100 (BST)
Received: from omx1-ext.sgi.com ([192.48.179.11]:15086 "EHLO
	omx1.americas.sgi.com") by ftp.linux-mips.org with ESMTP
	id S8133415AbWDQQnv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Apr 2006 17:43:51 +0100
Received: from imr2.americas.sgi.com (imr2.americas.sgi.com [198.149.16.18])
	by omx1.americas.sgi.com (8.12.10/8.12.9/linux-outbound_gateway-1.1) with ESMTP id k3HGt3nx026307;
	Mon, 17 Apr 2006 11:55:04 -0500
Received: from spindle.corp.sgi.com (spindle.corp.sgi.com [198.29.75.13])
	by imr2.americas.sgi.com (8.12.9/8.12.10/SGI_generic_relay-1.2) with ESMTP id k3HHDK7p24865408;
	Mon, 17 Apr 2006 10:13:21 -0700 (PDT)
Received: from schroedinger.engr.sgi.com (schroedinger.engr.sgi.com [163.154.5.55])
	by spindle.corp.sgi.com (SGI-8.12.5/8.12.9/generic_config-1.2) with ESMTP id k3HGt2nB33109877;
	Mon, 17 Apr 2006 09:55:02 -0700 (PDT)
Received: from christoph (helo=localhost)
	by schroedinger.engr.sgi.com with local-esmtp (Exim 3.36 #1 (Debian))
	id 1FVX0A-0007kz-00; Mon, 17 Apr 2006 09:55:02 -0700
Date:	Mon, 17 Apr 2006 09:55:02 -0700 (PDT)
From:	Christoph Lameter <clameter@sgi.com>
To:	kiran@scalex86.org
cc:	Nick Piggin <nickpiggin@yahoo.com.au>,
	Steven Rostedt <rostedt@goodmis.org>,
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
In-Reply-To: <4440855A.7040203@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0604170953390.29732@schroedinger.engr.sgi.com>
References: <1145049535.1336.128.camel@localhost.localdomain>
 <4440855A.7040203@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <christoph@schroedinger.engr.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clameter@sgi.com
Precedence: bulk
X-list: linux-mips

On Sat, 15 Apr 2006, Nick Piggin wrote:

> If I'm following you correctly, this adds another dependent load
> to a per-CPU data access, and from memory that isn't node-affine.

I am also concerned about that. Kiran has a patch to avoid allocpercpu
having to go through one level of indirection that I guess would no 
longer work with this scheme.
 
> If so, I think people with SMP and NUMA kernels would care more
> about performance and scalability than the few k of memory this
> saves.

Right.
