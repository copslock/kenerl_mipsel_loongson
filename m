Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Apr 2003 01:04:08 +0100 (BST)
Received: from p508B7D9B.dip.t-dialin.net ([IPv6:::ffff:80.139.125.155]:24519
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225227AbTDRAEH>; Fri, 18 Apr 2003 01:04:07 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3I03ju17855;
	Fri, 18 Apr 2003 02:03:45 +0200
Date: Fri, 18 Apr 2003 02:03:45 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Dennis Castleman <DennisCastleman@oaktech.com>
Cc: linux-mips@linux-mips.org
Subject: Re: your mail
Message-ID: <20030418020345.A6962@linux-mips.org>
References: <56BEF0DBC8B9D611BFDB00508B5E2634102F10@TLEXMAIL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <56BEF0DBC8B9D611BFDB00508B5E2634102F10@TLEXMAIL>; from DennisCastleman@oaktech.com on Thu, Apr 17, 2003 at 10:53:57AM -0700
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2104
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 17, 2003 at 10:53:57AM -0700, Dennis Castleman wrote:

> Anybody know the performance differences I can expect using a MIPS 5K core
> @250 Mhz in 64bit mode versus 32bit mode?

As a rule of thumb - less performance.  64-bit code is typically larger
resulting in lower cache hit rate.  And since performance optimization
these days is essentially equivalent to maximising the cache hit rate
going 64-bit usually means a performance drop due to the drastically
larger size of code and data.

On the positive side for 64-bit stuff there's the possibility to do
64-bit computations with just one instruction, move data with less
instructions, use twice as many double precission fp registers that are
offered by 64-bit ABIs and more calling sequences.

The first two paragraphs were sort of a generic statement regarding
32-bit vs. 64-bit software on MIPS processors and affect both kernel and
userspace.  There's a few additional issues with the Linux kernel.
The 32-bit kernels requires all memory to be addressable through KSEG0
which limits it to at most 512MB; typically the limit is more like 256MB.
Memory above 512MB physical address can only be used as highmem.  That's
fairly inefficient and requires alot of special care when writing new
kernel software.  For processors that suffer from virtual aliases in
their data cache highmem currently is frighteningly inefficient - and
high memory pressure on lowmem doesn't help either.  So from a certain
point on that's simply making a 64-bit kernel is simply the better
idea - even for running 32-bit software.  That in particular applies
to very I/O intensive stuff.

In short - the right choice is a tradeoff between the hardware platform
and the application's requirements.  Choose wrong and you'll curse
loudly :-)

  Ralf
