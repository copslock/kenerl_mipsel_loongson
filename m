Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2005 13:35:42 +0000 (GMT)
Received: from sccrmhc14.comcast.net ([63.240.77.84]:5825 "EHLO
	sccrmhc14.comcast.net") by ftp.linux-mips.org with ESMTP
	id S8133467AbVKINfX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 9 Nov 2005 13:35:23 +0000
Received: from [192.168.1.15] (pcp04414054pcs.nrockv01.md.comcast.net[69.140.185.48])
          by comcast.net (sccrmhc14) with ESMTP
          id <200511091336260140035bahe>; Wed, 9 Nov 2005 13:36:36 +0000
Message-ID: <4371FB46.1000805@gentoo.org>
Date:	Wed, 09 Nov 2005 08:36:06 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 1.5 (Windows/20051025)
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: MIPS - 64bit woes
References: <436D0061.5070100@jg555.com> <Pine.LNX.4.55.0511071143210.28165@blysk.ds.pg.gda.pl> <4371B87A.9040101@jg555.com>
In-Reply-To: <4371B87A.9040101@jg555.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Jim Gifford wrote:
> Here is what I did to track down the errors.
> 
> I created a diff between the last working kernel 2.6.12 and the current 
> kernel. Started with cpu-probe.c, that to me seemed the logical choice.
> 
> After patching the rest of files needed to support the patch in 
> cpu-probe.c, I was finally able to produce a kernel under 2.6.12 with 
> the same problem.
> 
> The files that I ported from 2.6.14 to 2.6.12 are the following
> cpu-probe.c
> cpu.h
> mipsregs.h
> cache.c
> cpu-features.h
> 
> Here is a link to the patches I used http://ftp.jg555.com/errors
> 
> Looking at mipsregs.h, something doesn't look right for a 64 bit system. 
> But I'm not the expert.
> 
> Here are my findings, I hope someone out there has an idea.

Stanislaw pretty much figured it out last night.

See the if statement in the 'void __init cpu_cache_init(void)' function in 
arch/mips/mm/cache.c.  IP30, IP27, and cobalt didn't define the appropriate 
cache type in cpu-features.h, thus failed that check and panicked.  I believe 
it's fixed in the newest IP30 patches, of which I have yet to take a look at.


--Kumba

-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
