Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2005 10:00:15 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:22301 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224904AbVDGI6f>; Thu, 7 Apr 2005 09:58:35 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j378wIAv003730;
	Thu, 7 Apr 2005 09:58:31 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j36K8mRn005011;
	Wed, 6 Apr 2005 21:08:48 +0100
Date:	Wed, 6 Apr 2005 21:08:48 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Greg Weeks <greg.weeks@timesys.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: memcpy prefetch
Message-ID: <20050406200848.GB4978@linux-mips.org>
References: <4253D67C.4010705@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4253D67C.4010705@timesys.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7619
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 06, 2005 at 08:30:52AM -0400, Greg Weeks wrote:

> In trying to understand the prefetch code in memcpy it looks like it's 
> prefetching too far out in front of the loop. In the main aligned loop 
> the loop copies 32 or 64 bytes of data and the prefetch is trying to 
> prefetch 256 bytes ahead of the current copy. The prefetches should also 
> pay attention to cache line size and they currently don't. If the line 
> size is less than the copy size we are skipping prefetches that should 
> be done. For the 4kc the line size is only 16 bytes. We should be doing 
> a prefetch for each line. The src_unaligned_dst_aligned loop is even 
> worse as it prefetches 288 bytes ahead of the copy and only copies 16 or 
> 32 bytes at a time.
> 
> Have I totally misunderstood the code?

Nope, you've understood that perfectly right.  The messy thing is that on
a whole bunch of system we don't know the cacheline size before runtime
so we have two choices a) work under worst case assumptions which would be
16 bytes.  Or do the same thing as we're already doing it for a bunch of
other performance sensitive functions, generating them at runtime.  Choose
your poison ;-)

  Ralf
