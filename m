Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBR4WcZ02547
	for linux-mips-outgoing; Wed, 26 Dec 2001 20:32:38 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fBR4WGX02544
	for <linux-mips@oss.sgi.com>; Wed, 26 Dec 2001 20:32:20 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBR3CMD19052;
	Thu, 27 Dec 2001 01:12:22 -0200
Date: Thu, 27 Dec 2001 01:12:22 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: dony.he@huawei.com, linux-mips@oss.sgi.com
Subject: Re: vmalloc bugs in 2.4.5???
Message-ID: <20011227011222.A16695@dea.linux-mips.net>
References: <20011106130839.B30219@dea.linux-mips.net> <20011107.103947.74756322.nemoto@toshiba-tops.co.jp> <20011226013221.A737@dea.linux-mips.net> <20011227.105518.74756316.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011227.105518.74756316.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Thu, Dec 27, 2001 at 10:55:18AM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Dec 27, 2001 at 10:55:18AM +0900, Atsushi Nemoto wrote:

> >> In somewhere between 2.4.6 and 2.4.9, the call to flush_cache_all()
> >> disappered from vmalloc_area_pages().  I have a data corruption
> >> problem in vmalloc()ed area without this call.  I think we still
> >> need this call.
> 
> ralf> Have you ever resolved this problem?  I've just doublechecked
> ralf> the vmalloc code and it seems as if it should be entirely safe
> ralf> without these two calls.  The tlb is flushed on vfree so no
> ralf> stale entries for a vmalloc address can ever be in the tlb at
> ralf> vmalloc time, so this flush_tlb_all() is just an expensive nop.
> ralf> And the same it true for flush_cache_all() no matter if caches
> ralf> are physically or virtually indexed.
> 
> I am still using the patch and have not tried without the two calls
> recently...
> 
> When I found this problem, I suppose that vmalloc called after
> free_pages causes the data corruption.  vmalloc can re-use pages freed
> by free_pages and it seems free_pages does not flush cache.  If
> vmalloc is to use a page which is associated with dirty cache and has
> different "color", virtual aliasing happens and data may be corrupt.
> Is this wrong?

Yes, you're right as for the cache.  But there is no reason for the
TLB flush, right?

  Ralf
