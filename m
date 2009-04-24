Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2009 17:14:17 +0100 (BST)
Received: from mms1.broadcom.com ([216.31.210.17]:50183 "EHLO
	mms1.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S20023977AbZDXQOJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Apr 2009 17:14:09 +0100
Received: from [10.9.200.131] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Fri, 24 Apr 2009 09:13:53 -0700
X-Server-Uuid: 02CED230-5797-4B57-9875-D5D2FEE4708A
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.1.358.0; Fri, 24 Apr 2009 09:13:53 -0700
Received: from [10.28.6.13] (lab-mhtb-013.ne.broadcom.com [10.28.6.13])
 by mail-irva-13.broadcom.com (Postfix) with ESMTP id 2865774D04; Fri,
 24 Apr 2009 09:13:53 -0700 (PDT)
Subject: Re: HIGHMEM fix for r24k
From:	"Jon Fraser" <jfraser@broadcom.com>
Reply-to: jfraser@broadcom.com
To:	"Ralf Baechle" <ralf@linux-mips.org>
cc:	jfraser@broadcom.com,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <20090424154349.GB3614@linux-mips.org>
References: <1240525424.15448.33.camel@chaos.ne.broadcom.com>
 <20090424154349.GB3614@linux-mips.org>
Organization: Broadcom
Date:	Fri, 24 Apr 2009 12:13:52 -0400
Message-ID: <1240589632.15448.38.camel@chaos.ne.broadcom.com>
MIME-Version: 1.0
X-Mailer: Evolution 2.12.3 (2.12.3-5.fc8)
X-WSS-ID: 65EF3ACB3BW2500889-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jfraser@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jfraser@broadcom.com
Precedence: bulk
X-list: linux-mips


On Fri, 2009-04-24 at 08:43 -0700, Ralf Baechle wrote:
> On Thu, Apr 23, 2009 at 06:23:44PM -0400, Jon Fraser wrote:
> 
> > For all you guys working on HIGMEM.
> > 
> > I found a bug that was keeping HIGHMEM from working on mips 24k
> > processors starting at 2.6.26.  
> > 
> > 
> > 2008-04-28 Chris Dearman [MIPS] Allow setting of the cache attribute at
> > run ...
> > 
> > This commit introduces the variable _page_cachable_default, which
> > defaults to zero.
> > 
> > arch/mips/mm/cache.c:
> > 	unsigned long _page_cachable_default;
> > 
> > The variable is used to create the prototype PTE for __kmap_atomic in
> > arch/mips/mm/init.c:kmap_init.
> > 
> > The variable is initialized in arch/mips/mm/c-r4k.c:coherency_setup.
> > 
> > Unfortunately, the variable is used before it is initialized properly.
> > As a result, all kmap_atomic PTE have the cache coherency algorithm mode set to 0.  
> > Mode 0 is "cacheable, nocoherent, write-through, no write allocate".
> > This is not valid on my r24k and my not be on any r24k.
> > 
> > The result is that writes to kmap_atomic pages get corrupted.  This was confirmed
> > using a jtag probe, examining uncached memory, the D cache itself, and cached memory.
> > 
> > I've changed the variable declaration to be:
> >   unsigned long _page_cachable_default = _CACHE_CACHABLE_NONCOHERENT;
> 
> There is no safe value of _page_cachable_default; it's all processor and
> even platform dependent.  What you found is essentially an ordering bug
> so let's fix the ordering!
> 
>   Ralf
> 
That's why I haven't proposed a fix yet.  But there are other people
dealing with the same HIGHMEM issues and I wanted them to know about the
problem.

Jon
