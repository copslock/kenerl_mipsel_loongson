Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Aug 2006 13:11:45 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:29387 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S20038545AbWHXMLn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 24 Aug 2006 13:11:43 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.7/8.13.4) with ESMTP id k7OCC5Wj023115;
	Thu, 24 Aug 2006 13:12:05 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k7OCC5FQ023114;
	Thu, 24 Aug 2006 13:12:05 +0100
Date:	Thu, 24 Aug 2006 13:12:05 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	nigel@mips.com, linux-mips@linux-mips.org
Subject: Re: [PATCH] fix cache coherency issues
Message-ID: <20060824121205.GA22587@linux-mips.org>
References: <44EC87C9.8010402@mips.com> <20060824.101531.07643963.nemoto@toshiba-tops.co.jp> <20060824111515.GA4490@linux-mips.org> <20060824.203838.07455316.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824.203838.07455316.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Aug 24, 2006 at 08:38:38PM +0900, Atsushi Nemoto wrote:
> Date:	Thu, 24 Aug 2006 20:38:38 +0900 (JST)
> To:	ralf@linux-mips.org
> Cc:	nigel@mips.com, linux-mips@linux-mips.org
> Subject: Re: [PATCH] fix cache coherency issues
> From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> Content-Type: Text/Plain; charset=us-ascii
> 
> On Thu, 24 Aug 2006 12:15:15 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > Your patch also still contains copy_user_page().  The only user of it used
> > to be copy_user_highpage() so after our rewrite it can go away.  I've
> > already applied both fixes to my working version of the patch.
> 
> Yes, it is intentional.  I keep copy_user_page() just because it is
> described in cachetlb.txt and exported.
> 
> Of course we can remove it.  I do not care :-) Also I wondered we
> should export copy_user_highpage() or not ...
> 
> > Your patch only maps the source page.  I'm trying to map the destination
> > page also and I'm hitting a few issues with it.
> 
> If you wanted to map the destination, you must writeback the dcache
> via kernel mapping first.  The dcache can contain dirty data for the
> page by previous usage.  And if the page was executable, we must flush
> the destination page after copy_page() (via coherent mapping) anyway
> for I/D coherency.
> 
> So now I think mapping the destination is not worth to do.

I figured it was worth a try.  It means the process will start running with
a hot copy of the COW page instead of a cold copy and I can use hit
invalidates instead of hit wbinv on the kernel address of the to page.

Lmbenching now, stay tuned ...

  Ralf
