Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2006 13:51:46 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:6407 "EHLO sorrow.cyrius.com")
	by ftp.linux-mips.org with ESMTP id S8133654AbWBQNve (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 17 Feb 2006 13:51:34 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id E9D8A64D59; Fri, 17 Feb 2006 13:57:55 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id EE53F8F77; Fri, 17 Feb 2006 13:57:48 +0000 (GMT)
Date:	Fri, 17 Feb 2006 13:57:48 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: undefined reference to `__lshrdi3' error with GCC 4.0
Message-ID: <20060217135748.GA28319@deprecation.cyrius.com>
References: <20060117134838.GJ27047@deprecation.cyrius.com> <200601171617.16147.p_christ@hol.gr> <20060117190859.GA2061@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060117190859.GA2061@linux-mips.org>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Ralf Baechle <ralf@linux-mips.org> [2006-01-17 19:08]:
> > > arch/mips/kernel/built-in.o: In function `time_init':
> > > : undefined reference to `__lshrdi3'
> 
> Thanks to Martin Michlmayr's testing I now know this problem is limited
> to kernels built with gcc 4.0 and newer when optimizing for size.
...
> There is an awful lot of libgcc bits flying around in the kernel and I guess
> I'd be flamed for submitting even more ;-)  so I tried to come up with
> something to make most if not all unnecessary.  Still needs a little
> polishing but below for testing and commenting.

I think you've cleaned it up in the meantime.  Can you please send the
patch to lkml as a RFC?
-- 
Martin Michlmayr
http://www.cyrius.com/
