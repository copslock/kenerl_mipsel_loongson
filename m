Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Sep 2007 19:53:38 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:25826 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20030450AbXI1Sxg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Sep 2007 19:53:36 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8SIrZow011058;
	Fri, 28 Sep 2007 19:53:35 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8SIrZMQ011057;
	Fri, 28 Sep 2007 19:53:35 +0100
Date:	Fri, 28 Sep 2007 19:53:35 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] hugetlb: Fix clear_user_highpage arguments
Message-ID: <20070928185335.GA10976@linux-mips.org>
References: <20070928163545.GA5933@linux-mips.org> <20070928114526.3398c462.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070928114526.3398c462.akpm@linux-foundation.org>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 28, 2007 at 11:45:26AM -0700, Andrew Morton wrote:

> 
> > The virtual address space argument of clear_user_highpage is supposed to
> > be the virtual address where the page being cleared will eventually be
> > mapped. This allows architectures with virtually indexed caches a few
> > clever tricks.  That sort of trick falls over in painful ways if the
> > virtual address argument is wrong.
> 
> yeah, but only if you're using a weird CPU architecture ;)

I guess once I convinced your employer that weird CPU architectures
deliver more punch for the watt they stop being so weird ;-)

> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 84c795e..eab8c42 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -42,7 +42,7 @@ static void clear_huge_page(struct page *page, unsigned long addr)
> >  	might_sleep();
> >  	for (i = 0; i < (HPAGE_SIZE/PAGE_SIZE); i++) {
> >  		cond_resched();
> > -		clear_user_highpage(page + i, addr);
> > +		clear_user_highpage(page + i, addr + i * PAGE_SIZE);
> >  	}
> >  }
> >  
> 
> I'll add this to the 2.6.23 queue.  Is it needed in 2.6.22.x?

It's totally theoretical atm, MIPS doesn't support hugetlb and I'm not
even working on it.  I just happened to spot the issue.

  Ralf
