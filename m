Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3FIfC8d008193
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 15 Apr 2002 11:41:12 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3FIfCjQ008192
	for linux-mips-outgoing; Mon, 15 Apr 2002 11:41:12 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ayrnetworks.com (64-166-72-141.ayrnetworks.com [64.166.72.141])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3FIf98d008182
	for <linux-mips@oss.sgi.com>; Mon, 15 Apr 2002 11:41:10 -0700
Received: (from wjhun@localhost)
	by  ayrnetworks.com (8.11.2/8.11.2) id g3FIciu21802
	for linux-mips@oss.sgi.com; Mon, 15 Apr 2002 11:38:44 -0700
Date: Mon, 15 Apr 2002 11:38:44 -0700
From: William Jhun <wjhun@ayrnetworks.com>
To: linux-mips@oss.sgi.com
Subject: rm7k flush_icache_line() in rm7k_dma_cache_*
Message-ID: <20020415113844.A21747@ayrnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

We've been experiencing some problems with our RM7k cache code which is
based on the sgi mm/rm7k.c from around kernel version 2.4.2. While
trying to track this down, we noticed that someone added a call to
flush_icache_line() in the rm7k_dma_cache_*() routines (now
mm/c-rm7k.c). What is the reason for this? It is our understanding that
the instruction cache does not write back, and so stale cache lines in
the icache which are later used for data/dma would seem innocuous. Is
this not true? We could not find a CVS log entry to explain this,
either. Did anyone experience problems without these calls to
flush_icache_line()?

Thanks,
Will
