Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6F9c5Rw027388
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 15 Jul 2002 02:38:05 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6F9c5pc027387
	for linux-mips-outgoing; Mon, 15 Jul 2002 02:38:05 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from columba.www.eur.3com.com (ip-161-71-171-238.corp-eur.3com.com [161.71.171.238])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6F9c0Rw027375
	for <linux-mips@oss.sgi.com>; Mon, 15 Jul 2002 02:38:01 -0700
Received: from toucana.eur.3com.com (toucana.EUR.3Com.COM [140.204.220.50])
	by columba.www.eur.3com.com  with ESMTP id g6F9iRE18283;
	Mon, 15 Jul 2002 10:44:32 +0100 (BST)
Received: from notesmta.eur.3com.com (eurmta1.EUR.3Com.COM [140.204.220.206])
	by toucana.eur.3com.com  with SMTP id g6F9hHR17003;
	Mon, 15 Jul 2002 10:43:17 +0100 (BST)
Received: by notesmta.eur.3com.com(Lotus SMTP MTA v4.6.3  (733.2 10-16-1998))  id 80256BF7.0035BDDA ; Mon, 15 Jul 2002 10:47:00 +0100
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   "Gleb O. Raiko" <raiko@niisi.msk.ru>
cc: linux-mips@oss.sgi.com
Message-ID: <80256BF7.0035BD49.00@notesmta.eur.3com.com>
Date: Mon, 15 Jul 2002 10:42:31 +0100
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



On Fri, 12 Jul 2002, Gleb O. Raiko wrote:
> instruction. CPU knows the stalled instruction is in I-cache, but,
> unfortunately, caches have been swapped already. The same cacheline in
> the D-cache was valid bit set. CPU get data instead of code.

I'm glad this cache swapping mess is not necessary for mips32 chips. I imagine
that when the caches are swapped the instruction fetch will examine the D-cache
so it will not 'know' the instruction is in the I-cache. If the address is
present in both caches then the content should be the same. If the cache
routines have some self-modifying code then this really is asking for trouble.

     Jon
