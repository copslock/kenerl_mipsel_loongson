Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Mar 2003 19:26:15 +0000 (GMT)
Received: from p508B7656.dip.t-dialin.net ([IPv6:::ffff:80.139.118.86]:2539
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225202AbTCNT0P>; Fri, 14 Mar 2003 19:26:15 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h2EJQ9q04333;
	Fri, 14 Mar 2003 20:26:09 +0100
Date: Fri, 14 Mar 2003 20:26:09 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Wayne Gowcher <wgowcher@yahoo.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Tips on inspecting / debuging cache
Message-ID: <20030314202609.A3670@linux-mips.org>
References: <20030314021308.60082.qmail@web11905.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030314021308.60082.qmail@web11905.mail.yahoo.com>; from wgowcher@yahoo.com on Thu, Mar 13, 2003 at 06:13:08PM -0800
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 13, 2003 at 06:13:08PM -0800, Wayne Gowcher wrote:

> I am wondering if someone could point me towards
> articles / source code that would give me a little
> insight into how to debug cache problems in mips.
> 
> For example , how do I inspect the contents of the
> cache ? Are there routines to dump out the contents of
> the cache ?

Frankly, such code isn't to useful.  The problems in the cache code can
be fairly subtle.  The only thing that has worked halfway well is reading
the code 1,000 times more after having read it 1,000 times.  And because
it's such a nice job, read it another 1000 times when finished.

If you're refering to the current round of cache problems introduced about
three days ago when I eleminated flush_page_to_ram() and replace it
with flush_dcache_page() - the untested quickfix is changing the
definitions of clear_user_page() and copy_user_page() in <asm/page.h> to
flush the data cache after the operation, for example by invoking
flush_cache_all().  This particular problem affects all processors with
virtually indexed data caches except the R4000 and R4000 SC and MC
versions and the R10000 family.

And everybody's favorite question, was this necessary that late in 2.4?
Yes, it was.  The new mechanism deals is not only more efficient it also
deals better with aliases between the pagecache and userspace mappings.

  Ralf
