Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Apr 2006 17:59:33 +0100 (BST)
Received: from mx2.suse.de ([195.135.220.15]:53168 "HELO mx2.suse.de")
	by ftp.linux-mips.org with SMTP id S8133415AbWDQQ7X (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 17 Apr 2006 17:59:23 +0100
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id CC1C81EBCD;
	Mon, 17 Apr 2006 19:11:36 +0200 (CEST)
From:	Andi Kleen <ak@suse.de>
To:	Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
Date:	Mon, 17 Apr 2006 19:10:46 +0200
User-Agent: KMail/1.9.1
Cc:	Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
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
References: <1145049535.1336.128.camel@localhost.localdomain> <Pine.LNX.4.58.0604152323560.16853@gandalf.stny.rr.com> <4441ECE6.5010709@yahoo.com.au>
In-Reply-To: <4441ECE6.5010709@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604171910.48838.ak@suse.de>
Return-Path: <ak@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ak@suse.de
Precedence: bulk
X-list: linux-mips

On Sunday 16 April 2006 09:06, Nick Piggin wrote:

> I still don't understand what the justification is for slowing down
> this critical bit of infrastructure for something that is only a
> problem in the -rt patchset, and even then only a problem when tracing
> is enabled.

There are actually problems outside -rt. e.g. the Xen kernel was running
into a near overflow and as more and more code is using per cpu variables
others might too.

I'm confident the problem can be solved without adding more variables
though - e.g. in the way rusty proposed.

-Andi
