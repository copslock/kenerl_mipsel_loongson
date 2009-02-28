Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Feb 2009 21:13:17 +0000 (GMT)
Received: from gate.crashing.org ([63.228.1.57]:62632 "EHLO gate.crashing.org")
	by ftp.linux-mips.org with ESMTP id S20807994AbZB1VNP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 28 Feb 2009 21:13:15 +0000
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n1SL9eWu029375;
	Sat, 28 Feb 2009 15:09:41 -0600
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
From:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:	Linus Torvalds <torvalds@linux-foundation.org>
Cc:	Roland McGrath <roland@redhat.com>, linux-mips@linux-mips.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, stable@kernel.org
In-Reply-To: <alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
References: <20090228030226.C0D34FC3DA@magilla.sf.frob.com>
	 <20090228030413.5B915FC3DA@magilla.sf.frob.com>
	 <alpine.LFD.2.00.0902271932520.3111@localhost.localdomain>
	 <alpine.LFD.2.00.0902271948570.3111@localhost.localdomain>
	 <20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
	 <alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
Content-Type: text/plain
Date:	Sun, 01 Mar 2009 08:09:39 +1100
Message-Id: <1235855379.7388.113.camel@pasglop>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <benh@kernel.crashing.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benh@kernel.crashing.org
Precedence: bulk
X-list: linux-mips

On Sat, 2009-02-28 at 09:23 -0800, Linus Torvalds wrote:
> 
> On Fri, 27 Feb 2009, Roland McGrath wrote:
> > 
> > I don't know any other arch well enough to be sure that TIF_32BIT isn't the
> > wrong test there too.  I'd like to leave that worry to the arch maintainers.
> 
> Agreed - it may be that others will want to not use TIF_32BIT too. It 
> really does make much more sense to have it as a thread-local status flag 
> than as an atomic (and thus expensive to modify) thread-flag, not just on 
> x86.

FYI. _TIF_32BIT is the right test on powerpc (it's also what entry_64.S
tests to pick the appropriate syscall table).

Cheers,
Ben.
