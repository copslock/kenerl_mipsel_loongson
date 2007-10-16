Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Oct 2007 17:16:25 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:25544 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023139AbXJPQQX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Oct 2007 17:16:23 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9GGGIQ5025655;
	Tue, 16 Oct 2007 17:16:18 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9GGGI7U025654;
	Tue, 16 Oct 2007 17:16:18 +0100
Date:	Tue, 16 Oct 2007 17:16:18 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Fix aliasing bug in copy_user_highpage, take 2.
Message-ID: <20071016161618.GB23986@linux-mips.org>
References: <20071015182811.GA20157@linux-mips.org> <20071017.002916.07645039.anemo@mba.ocn.ne.jp> <20071016153806.GA23986@linux-mips.org> <20071017.011349.03977690.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071017.011349.03977690.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 17, 2007 at 01:13:49AM +0900, Atsushi Nemoto wrote:

> On Tue, 16 Oct 2007 16:38:06 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > > Hmm, setting SetPageDcacheDirty() will not make sure the modified data
> > > flushed before reading via the kernel mapping.  The flush_dcache_page()
> > > should be used for such case, shouldn't it?
> > 
> > You're right - and the intent is to _not_ flush the page.  But we're
> > bringing it into the cache, so we better flush it before it will be mapped
> > to userspace.  We want to delay the flush operation.
> 
> I see, but I'm afraid of unnecessary flushing might hide another
> bug...
> 
> Setting SetPageDcacheDirty() for non-modified page looks a bit
> overkill for me.  For example, in copy_user_highpage() we do not flush
> the source page if the page was not mapped to userspace.

kunmap_atomic() is supposed to deal with that.

It doesn't quite on the MIPS implementation so the kernel refuses highmem
with aliasing caches.

  Ralf
