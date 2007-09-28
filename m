Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Sep 2007 20:23:35 +0100 (BST)
Received: from smtp2.linux-foundation.org ([207.189.120.14]:3560 "EHLO
	smtp2.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S20030496AbXI1TX1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Sep 2007 20:23:27 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8SJNJAB002292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 28 Sep 2007 12:23:20 -0700
Received: from box (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id l8SJNIND013693;
	Fri, 28 Sep 2007 12:23:18 -0700
Date:	Fri, 28 Sep 2007 12:23:18 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] hugetlb: Fix clear_user_highpage arguments
Message-Id: <20070928122318.57b99a0a.akpm@linux-foundation.org>
In-Reply-To: <20070928185335.GA10976@linux-mips.org>
References: <20070928163545.GA5933@linux-mips.org>
	<20070928114526.3398c462.akpm@linux-foundation.org>
	<20070928185335.GA10976@linux-mips.org>
X-Mailer: Sylpheed 2.4.1 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Fri, 28 Sep 2007 19:53:35 +0100 Ralf Baechle <ralf@linux-mips.org> wrote:

> On Fri, Sep 28, 2007 at 11:45:26AM -0700, Andrew Morton wrote:
> 
> > 
> > > The virtual address space argument of clear_user_highpage is supposed to
> > > be the virtual address where the page being cleared will eventually be
> > > mapped. This allows architectures with virtually indexed caches a few
> > > clever tricks.  That sort of trick falls over in painful ways if the
> > > virtual address argument is wrong.
> > 
> > yeah, but only if you're using a weird CPU architecture ;)
> 
> I guess once I convinced your employer that weird CPU architectures
> deliver more punch for the watt they stop being so weird ;-)

<wonders what you've gone and done this time>

> > > 
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index 84c795e..eab8c42 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -42,7 +42,7 @@ static void clear_huge_page(struct page *page, unsigned long addr)
> > >  	might_sleep();
> > >  	for (i = 0; i < (HPAGE_SIZE/PAGE_SIZE); i++) {
> > >  		cond_resched();
> > > -		clear_user_highpage(page + i, addr);
> > > +		clear_user_highpage(page + i, addr + i * PAGE_SIZE);
> > >  	}
> > >  }
> > >  
> > 
> > I'll add this to the 2.6.23 queue.  Is it needed in 2.6.22.x?
> 
> It's totally theoretical atm, MIPS doesn't support hugetlb and I'm not
> even working on it.  I just happened to spot the issue.

sparc64 might care about this bug.

Anyway, I'll plop it in 2.6.23.
