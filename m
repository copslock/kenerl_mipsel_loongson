Received:  by oss.sgi.com id <S553774AbRAHQCI>;
	Mon, 8 Jan 2001 08:02:08 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:18917 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553736AbRAHQBz>;
	Mon, 8 Jan 2001 08:01:55 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA03849;
	Mon, 8 Jan 2001 16:40:07 +0100 (MET)
Date:   Mon, 8 Jan 2001 16:40:06 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     "Kevin D. Kissell" <kevink@mips.com>
cc:     linux-mips@oss.sgi.com, Carsten Langgaard <carstenl@mips.com>,
        Michael Shmulevich <michaels@jungo.com>
Subject: Re: User applications
In-Reply-To: <010701c07986$ac768180$0deca8c0@Ulysses>
Message-ID: <Pine.GSO.3.96.1010108162406.23234I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, 8 Jan 2001, Kevin D. Kissell wrote:

> >  Obviously, you don't want to allow unprivileged users to flush caches as
> > a whole as it could lead to a DoS.
> 
> By that logic, we should not allow users to allocate more virtual
> memory than there is physical memory in the system!  A pathological
> swap program is arguably far a far worse denial of service attack

 There are limits -- see `info setrlimit'.  There is no way to prevent a
program from executing:

while (1) flush_cache_all();

though but the system's performance would suffer much.  Remember there is
real world out there... 

 Which means sysmips(FLUSH_CACHE, ...) needs to be fixed or removed. 

> than flushing the caches - so long as by "flush" we mean invalidate
> with writeback (on copyback caches), of course.

 What's wrong with cacheflush(addr, count, which) that actually checks if
<addr; addr+count> lies within the caller's address space before
performing the flush and returns -EPERM otherwise?  It would make the
caller crawl like a turtle if it wished to but it would leave other
processes alone. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
