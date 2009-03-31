Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2009 18:12:32 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:37353 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20022706AbZCaRMa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2009 18:12:30 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n2VHCSJu031516;
	Tue, 31 Mar 2009 19:12:28 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n2VHCPFp031514;
	Tue, 31 Mar 2009 19:12:25 +0200
Date:	Tue, 31 Mar 2009 19:12:25 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	=?utf-8?B?5p6X5bu65a6J?= <colin@realtek.com.tw>,
	linux-mips@linux-mips.org
Subject: Re: The impact to change page size to 16k for cache alias
Message-ID: <20090331171225.GC24154@linux-mips.org>
References: <9BDA961341E843F29C1C1ECDB54FD0CF@realtek.com.tw> <20090330082414.GA4797@adriano.hkcable.com.hk> <20090331081113.GA17934@linux-mips.org> <20090331165412.GA4918@adriano.hkcable.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090331165412.GA4918@adriano.hkcable.com.hk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 01, 2009 at 12:54:12AM +0800, Zhang Le wrote:

> > > Linux on Loongson 2E and 2F uses 16k page size to avoid cache alias problem, too.
> > > However, I haven't encountered any problem on Linux kernel itself due to 16k page
> > > size.
> > > 
> > > Anyway, I am not 100% familiar with Loongson patches, so I am not sure whether
> > > the page size problem is already been taken care of in the patch. If you are
> > > interested to find out yourself, you can get the whole source here:
> > > http://repo.or.cz/w/linux-2.6/linux-loongson.git
> > 
> > I've got a report that Fulong is currently only working with 16k pages.  So
> > 4k is no longer the bullet proof choice for all cases :)
> 
> Yes, at least from what I can tell.
> I have tried 4k before, because I heard someone told me the aliasing problem
> already can be taken care by software, namely Linux. But as it turned out, 16k
> is still necessary for the Loongson boxes to function properly.

Linux knows how to handle aliasing caches - the vast majority of MIPS
systems have aliasing caches and are running at 4k page size.  So the
issue is Loongson-specific.  This might be due to processor detection
not detecting the cache size, cache line size, number of ways correctly
or because loongson's caches has some unusual cache properties which the
Linux kernel is not designed to handle yet.

Btw, I just noticed that there is no
arch/mips/include/asm/mach-lemote/cpu-feature-overrides.h which is going
to impact code size and performance.

  Ralf
