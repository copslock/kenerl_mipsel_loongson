Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2003 12:38:38 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:63752 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225565AbTIWLif>;
	Tue, 23 Sep 2003 12:38:35 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1A1lUR-0002Hg-00; Tue, 23 Sep 2003 12:37:55 +0100
Received: from gladsmuir.algor.co.uk ([172.20.192.66] helo=gladsmuir.mips.com)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1A1lSO-0001xo-00; Tue, 23 Sep 2003 12:35:48 +0100
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16240.12304.556561.464629@gladsmuir.mips.com>
Date: Tue, 23 Sep 2003 12:35:44 +0100
To: "Finney, Steve" <Steve.Finney@SpirentCom.COM>
Cc: <linux-mips@linux-mips.org>
Subject: Re: User-mode drivers and TLB
In-Reply-To: <DC1BF43A8FAE654DA6B3FB7836DD3A56DEB750@iris.adtech-inc.com>
References: <DC1BF43A8FAE654DA6B3FB7836DD3A56DEB750@iris.adtech-inc.com>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-3.5, required 4, AWL,
	BAYES_10, QUOTED_EMAIL_TEXT, REFERENCES)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Steve,

> I am working on an app where I want to give one or more user
> processes access to a largish range of physical address space
> (specifically, this is a Broadcom 1125 running a 32 bit kernel, and
> for now the region is accessible via KSEG0/1 (physical address < 512
> MB)). mmap() on /dev/mem does this just fine, and setting (or not
> setting) O_SYNC on open seems to control caching. But I just
> realized a disadvantage to doing this in user space: the user
> process accesses have to be mapped (since a user process can't, I
> believe, use KSEG0 or KSEG1 addresses), so you have to go through
> the (64 entry) TLB, and if you had signficant non-locality of
> reference, you'd possibly risk thrashing the TLB (which doesn't
> happen in kernel space, since the region can be directly accessed).

As usual, I guess the first thing is to try doing it the standard way
and then try to measure how much time is being spent in extra TLB misses
generated by your application.  Some MIPS CPUs have "performance
counters" which might be able to count TLB misses, but you'll more
likely have to instrument the TLB miss code.

If it does turn out that TLB replacement is a big drain:

Most MIPS CPU hardware allows you to map large chunks of memory with a
single TLB entry: often up to 16Mbytes at a time.  But I don't know
how you'd persuade Linux how to do that.

--
Dominic Sweetman
MIPS Technologies.
