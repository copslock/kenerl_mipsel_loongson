Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Apr 2003 07:33:26 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:3084 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225196AbTDKGdX>;
	Fri, 11 Apr 2003 07:33:23 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 193sBQ-0006Dv-00; Fri, 11 Apr 2003 07:38:44 +0100
Received: from gladsmuir.algor.co.uk ([172.20.192.66] helo=gladsmuir.mips.com)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 193s5x-0002XR-00; Fri, 11 Apr 2003 07:33:05 +0100
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16022.24992.314581.716649@gladsmuir.mips.com>
Date: Fri, 11 Apr 2003 07:33:04 +0100
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Mike Uhler <uhler@mips.com>, Jun Sun <jsun@mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: way selection bit for multi-way cache
In-Reply-To: <20030410225212.A3294@linux-mips.org>
References: <20030410220906.B519@linux-mips.org>
	<200304102028.h3AKSf211575@uhler-linux.mips.com>
	<20030410225212.A3294@linux-mips.org>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-1, required 4.5, AWL,
	IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES, SPAM_PHRASE_03_05)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Mike wrote:

> > I'm not sure what you mean by TLB translations required for hit
> > cacheops.  If you mean the Index Writeback or Index Invalidate
> > functions, note that you can (and should) use a kseg0 address to
> > do this.

Mike was proposing a kseg0 address translating to the right physical
address, and used with a hit-type cacheop.  I believe Ralf (and Linux)
are just assuming that's no good because it doesn't work if you have
cacheable memory above 512Mbytes physical address.

I wonder whether anything really bad would happen if you temporarily
changed the (machine) ASID to that of the address space you wanted to
invalidate?

--
Dominic
