Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Jun 2005 06:52:50 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:53768 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225719AbVFYFwa>;
	Sat, 25 Jun 2005 06:52:30 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1Dm3rU-00083h-00; Sat, 25 Jun 2005 07:09:52 +0100
Received: from olympia.mips.com ([192.168.192.128] helo=boris)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Dm3ZW-00024w-00; Sat, 25 Jun 2005 06:51:18 +0100
From:	Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17084.61658.662352.432937@mips.com>
Date:	Sat, 25 Jun 2005 06:51:22 +0100
To:	madprops@gmx.net
Cc:	linux-mips@linux-mips.org
Subject: Re: tlb magic
In-Reply-To: <18788.1118764826@www21.gmx.net>
References: <17069.62407.584863.185198@mips.com>
	<18788.1118764826@www21.gmx.net>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.838,
	required 4, AWL, BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8191
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Long ago...

> yes, I'm reading "See MIPS Run". So thanks for the online support that comes
> with it. Now, if I got it correctly, the exception routing described in
> section 6.7 uses per-process mappings for kseg2, i.e. that e.g. the first
> 2MB of (each) kseg2 are used  as page table of the corresponding process and
> maybe another few kb for process related stuff. Provided the page tables are
> continuously at the same address ( e.g. KSEG2_BASE ) a change of ASID in
> EntryHi would indeed make a change of the kseg2 pointer in Context
> unnecessary ( it always points to KSEG2_BASE ). The mapping of kseg2 would
> automatically change as the global bit is set to zero. 

Yes.  I think I recall that the first BSD4.3 ports for MIPS had a
fixed-virtual address per-process structure which was extended to
include the L2 page table.

> Using the standard page table approach I would now need an additional page
> table for each process in order to map those 2+x MB in kseg2 which I could
> put in kseg0/1 or in kseg2 with 'wired' TLB entries.
> 
> If that's the way to go - why is it only used in early BSD ports of like
> 1987 ? Are there any troubles with it or have other mechanisms turned out to
> be better for any reason ?

It's rather a lot of assumptions to build into architecture-dependent
code, not very flexible, not very SMP-friendly, and in other ways not
as scalable as one would like.

Current Linux systems accept more computation in the TLB miss
handler in order to use largely portable data structures for keeping
page tables.  You can always push at that trade-off...

--
Dominic Sweetman
MIPS Technologies
