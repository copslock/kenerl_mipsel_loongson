Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3IGO5w05718
	for linux-mips-outgoing; Wed, 18 Apr 2001 09:24:05 -0700
Received: from stereotomy.lineo.com (stereotomy.lineo.com [64.50.107.151])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3IGO4M05715
	for <linux-mips@oss.sgi.com>; Wed, 18 Apr 2001 09:24:04 -0700
Received: from Lineo.COM (localhost.localdomain [127.0.0.1])
	by stereotomy.lineo.com (Postfix) with ESMTP id 6329A4C92E
	for <linux-mips@oss.sgi.com>; Wed, 18 Apr 2001 10:24:03 -0600 (MDT)
Message-ID: <3ADDBFA2.7030608@Lineo.COM>
Date: Wed, 18 Apr 2001 10:24:02 -0600
From: Quinn Jensen <jensenq@Lineo.COM>
Organization: Lineo, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-9mdk i686; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Re: Linux on LSI EZ4102
References: <15062.17293.403963.722517@valen.metzler>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Are the caches two-way (or more)?  If so, check
to see if the way select bit(s) are contiguous
with the offset for indexed cache operations.
If there is a hole, you have to flush in two
parts, or flush as if the cache was big enough
to span the hole.

Quinn

owner-linux-mips@oss.sgi.com wrote:

> Hi,
> 
> does anybody have experience with the LSI EZ41XX line of MIPS cores
> and Linux, especially regarding the cache handling?
> They have a R3000-like MMU architecture and most of the MIPS2 command
> set but a totally different cache.
> Without cache enabled the Linux port I did works fine but with cache
> the ethernet driver and the MMU behave badly. I thought I implemented
> the flushing routines correctly but it seems I missed something.
> If somebody already did work on this architecture please let me know.
> 
> Thanks,
> 
> Ralph
