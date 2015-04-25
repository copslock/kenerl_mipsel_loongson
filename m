Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Apr 2015 20:55:57 +0200 (CEST)
Received: from resqmta-ch2-10v.sys.comcast.net ([69.252.207.42]:42936 "EHLO
        resqmta-ch2-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011231AbbDYSzzIuv3R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Apr 2015 20:55:55 +0200
Received: from resomta-ch2-18v.sys.comcast.net ([69.252.207.114])
        by resqmta-ch2-10v.sys.comcast.net with comcast
        id LJvZ1q0042Udklx01JvqZR; Sat, 25 Apr 2015 18:55:50 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-18v.sys.comcast.net with comcast
        id LJtp1q00E42s2jH01JtqA8; Sat, 25 Apr 2015 18:53:50 +0000
Message-ID: <553BE2A9.2090500@gentoo.org>
Date:   Sat, 25 Apr 2015 14:53:29 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: MIPS: BUG() in isolate_lru_pages in mm/vmscan.c?
References: <553BB91C.3010308@gentoo.org>
In-Reply-To: <553BB91C.3010308@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1429988150;
        bh=9KQjexfLhFSf2JDpzk8w6bwXrz9FPoiZye/10egcsdw=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=d7IV1FZsN4Reb0ovBJio8Pbvgdw7Z/XJCx0OErBjdOBRlFHo/ERiz75Cx3CpBB86L
         1G+YuR5v1jl8M0ojMWkCViFPwYPYuTTVdXa6OIaR3Zm9RtzTW5Aln8HInIhZS5QUbO
         ja5KZ2vr5Y1mnng7K0cpp65YOSktqvflEou+uFzl0InD8XBllzz8EBplExATxpLxXx
         ubyDeOF7oDAdZ9F3gG4Yffu32oDJqeqIU9mCYKTbPlYhIL61KHKfjfLP3iaAg74VqZ
         TL+PRbzsrh1YEM30zYsoaHPWyTce9fSoPZgz0lqpn6QXWtEesyS4gMqoWdpdxquuZL
         d50/Zksmk/BCg==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 04/25/2015 11:56, Joshua Kinard wrote:
> I keep tripping up a BUG() in isolate_lru_pages in mm/vmscan.c:1345:
> 
> 	switch (__isolate_lru_page(page, mode)) {
> 	case 0:
> 		nr_pages = hpage_nr_pages(page);
> 		mem_cgroup_update_lru_size(lruvec, lru, -nr_pages);
> 		list_move(&page->lru, dst);
> 		nr_taken += nr_pages;
> 		break;
> 
> 	case -EBUSY:
> 		/* else it is being freed elsewhere */
> 		list_move(&page->lru, src);
> 		continue;
> 
> 	default:
> 		BUG();
> 	}
> 
> This is on an SGI Onyx2 platform (MIPS, IP27), two node boards (4x R14000
> CPUs), and 8G of RAM.  The problem appears tied to heavy disk I/O, typically
> writes.  I can reproduce sometimes with a long bonnie++ run, but I haven't
> gotten a recent panic() message under 4.0 yet.  Most of the time, it silently
> hardlocks.  I only have serial console access at 9600bps, so it may lock too
> fast before the serial driver can dump the panic.
> 
> Is there any information behind the purpose or triggers of this BUG()?  I went
> back in git all the way to the initial 2006 commit that added this function,
> but could not find any comments or explanation of just what it's protecting
> against.  That makes it hard to know where to start debugging.
> 
> I've already tried switching filesystems, first ext4, now XFS.  Enabling
> CONFIG_NUMA seems to make it harder to trigger, but that's not an objective
> observation.  An md RAID resync doesn't appear to trigger it either.


This patch seems to explain things a little bit (from 20070316):
http://marc.info/?l=linux-mm-commits&m=117401513810763&w=2

> Subject: lumpy: back out removal of active check in isolate_lru_pages
> From: Andy Whitcroft <apw@shadowen.org>
> 
> As pointed out by Christop Lameter it should not be possible for a page to
> change its active/inactive state without taking the lru_lock.  Reinstate this
> safety net.
> 
> Signed-off-by: Andy Whitcroft <apw@shadowen.org>
> Acked-by: Mel Gorman <mel@csn.ul.ie>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  mm/vmscan.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff -puN mm/vmscan.c~lumpy-back-out-removal-of-active-check-in-isolate_lru_pages mm/vmscan.c
> --- a/mm/vmscan.c~lumpy-back-out-removal-of-active-check-in-isolate_lru_pages
> +++ a/mm/vmscan.c
> @@ -686,10 +686,13 @@ static unsigned long isolate_lru_pages(u
>  			nr_taken++;
>  			break;
>  
> -		default:
> -			/* page is being freed, or is a missmatch */
> +		case -EBUSY:
> +			/* else it is being freed elsewhere */
>  			list_move(&page->lru, src);
>  			continue;
> +
> +		default:
> +			BUG();
>  		}
>  
>  		if (!order)

So if my reading is correct, the BUG() is being triggered because a page might
be changing its active/inactive state w/o taking the lru_lock.  Given that the
SGI IP27 platform is an early NUMA machine and nodes can have a bit of physical
distance between them (thus some latency), could this be a sign of some kind of
SMP race condition specific to this platform?

--J
