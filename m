Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA7AgPo05531
	for linux-mips-outgoing; Wed, 7 Nov 2001 02:42:26 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fA7AgN005528
	for <linux-mips@oss.sgi.com>; Wed, 7 Nov 2001 02:42:23 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fA7AfkZ17355;
	Wed, 7 Nov 2001 02:41:46 -0800
Date: Wed, 7 Nov 2001 02:41:46 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: dony.he@huawei.com, linux-mips@oss.sgi.com
Subject: Re: vmalloc bugs in 2.4.5???
Message-ID: <20011107024146.A1740@dea.linux-mips.net>
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

Entirely correct.  I'm just trying to find why this call got removed
in 2.4.10.  Clearly wrong;  I had not noticed that these two lines
got removed and thus was assuming the code of those two must somehow
be malfunctioning.

  Ralf
