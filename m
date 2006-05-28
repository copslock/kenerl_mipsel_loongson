Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 May 2006 09:42:55 +0200 (CEST)
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:52918 "EHLO
	rwcrmhc12.comcast.net") by ftp.linux-mips.org with ESMTP
	id S8133138AbWE1Hmq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 28 May 2006 09:42:46 +0200
Received: from [127.0.0.1] (unknown[69.140.185.142])
          by comcast.net (rwcrmhc12) with ESMTP
          id <20060528074239m1200iu25fe>; Sun, 28 May 2006 07:42:40 +0000
Message-ID: <44795470.4030403@gentoo.org>
Date:	Sun, 28 May 2006 03:42:40 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To:	Andrew Morton <akpm@osdl.org>
CC:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: Commit 78eef01b0fae087c5fadbd85dd4fe2918c3a015f (on_each_cpu():
 disable local interrupts) Breaks SGI IP32
References: <4478C0F1.8000006@gentoo.org>	<20060528010603.GA24997@linux-mips.org>	<20060527194243.a8157338.akpm@osdl.org>	<4479250E.3080604@gentoo.org> <20060527213150.33443188.akpm@osdl.org>
In-Reply-To: <20060527213150.33443188.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Andrew Morton wrote:
> 
> Yup.  But again, the reasons for that change to on_each_cpu() were to make
> all instances of the the callback function run under the same environment
> in all cases.  That's a good change.
> 
> If the platform _knows_ that it's safe to do normally-unsafe things then as
> I say, it shold special-case that case.
> 
> Here, if the call is in O2-only code then we don't need on_each_cpu() at
> all - just call the function instead.
> 
> If the call is in board-neutral MIPS code then things get more complicated.
> Sure, the code is safe on UP, but it might be deadlocky on SMP.  It needs
> to be thought about and a suitable UP&&SMP fix needs to be found.
> 
> Can someone point me at the code we're talking about here?  file-n-line?

The farthest I can track the lock up is to line ~290 in mm/bootmem.c, in 
__alloc_bootmem_core.  It's when it goes off to try and invoke that memset() 
function that the machine hangs, and gets put into a state only a cold boot can 
recover.

Since discovering the this change that introduces this oddity, I think it's what 
explains the hang happening in the "dark void between function calls" -- control 
attempts to pass to the memset(), but never reaches it (a printk() before that 
memset() will get called, but a printk inside the memset() never gets called, 
even if it's the very first instruction inside the function).  Turning off the 
IRQs, then calling func() while 'info' contains the pointer to the memset() just 
goes *poof* as Ralf mentioned.

I tried putting printk()'s in the on_each_cpu() macro, before all three 
instructions, but none of those fired.  So whether control even reaches that 
point, I'm not sure.  Ralf mentioned (I think) it could be a cache flush 
happening after IRQs are disabled that knocks the machine out or something to 
that effect.

It's tricky to say -- I ran into the exact same hang back in ~2.6.15.2, but it 
silently vanished before I could pin it down, so I don't even know if it's 
related.  I'm good at tracking down some problems, but even this one's done a 
fine job of eluding me up until now :)


--Kumba

-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
