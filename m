Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBQLgTE26226
	for linux-mips-outgoing; Wed, 26 Dec 2001 13:42:29 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fBQLgMX26223
	for <linux-mips@oss.sgi.com>; Wed, 26 Dec 2001 13:42:22 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBQ3WOe00764;
	Wed, 26 Dec 2001 01:32:24 -0200
Date: Wed, 26 Dec 2001 01:32:21 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: dony.he@huawei.com, linux-mips@oss.sgi.com
Subject: Re: vmalloc bugs in 2.4.5???
Message-ID: <20011226013221.A737@dea.linux-mips.net>
References: <013301c165cc$5d030fa0$4a1c690a@huawei.com> <20011106130839.B30219@dea.linux-mips.net> <20011107.103947.74756322.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011107.103947.74756322.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Wed, Nov 07, 2001 at 10:39:47AM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Nov 07, 2001 at 10:39:47AM +0900, Atsushi Nemoto wrote:

Time to revisit a pile of old problems in my mailfolder ...

> >>>>> On Tue, 6 Nov 2001 13:08:39 -0800, Ralf Baechle <ralf@oss.sgi.com> said:
> ralf> Vmalloc is probably innocent I'd rather guess cache flushing is
> ralf> broken on your platform.
> 
> In 2.4.5, flush_cache_all() (and flush_tlb_all()) is called in
> vmalloc_area_pages().  I think this call protect us from virtual
> aliasing problem.
> 
> By the way, does anybody have any problem with vmalloc on recent
> kernel?
> 
> In somewhere between 2.4.6 and 2.4.9, the call to flush_cache_all()
> disappered from vmalloc_area_pages().  I have a data corruption
> problem in vmalloc()ed area without this call.  I think we still need
> this call.
> 
> --- linux-sgi-cvs/mm/vmalloc.c	Tue Sep 18 05:16:31 2001
> +++ linux.new/mm/vmalloc.c	Wed Nov  7 10:33:47 2001
> @@ -144,6 +144,7 @@
>  	int ret;
>  
>  	dir = pgd_offset_k(address);
> +	flush_cache_all();
>  	spin_lock(&init_mm.page_table_lock);
>  	do {
>  		pmd_t *pmd;
> @@ -163,6 +164,7 @@
>  		ret = 0;
>  	} while (address && (address < end));
>  	spin_unlock(&init_mm.page_table_lock);
> + 	flush_tlb_all();
>  	return ret;
>  }

Have you ever resolved this problem?  I've just doublechecked the
vmalloc code and it seems as if it should be entirely safe without these
two calls.  The tlb is flushed on vfree so no stale entries for a
vmalloc address can ever be in the tlb at vmalloc time, so this
flush_tlb_all() is just an expensive nop.  And the same it true for
flush_cache_all() no matter if caches are physically or virtually
indexed.

  Ralf
