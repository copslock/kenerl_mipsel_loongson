Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4FM1VnC002595
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 15 May 2002 15:01:31 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4FM1VMU002594
	for linux-mips-outgoing; Wed, 15 May 2002 15:01:31 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4FM1QnC002591
	for <linux-mips@oss.sgi.com>; Wed, 15 May 2002 15:01:26 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id PAA32360;
	Wed, 15 May 2002 15:01:12 -0700
Message-ID: <3CE2DA46.3070402@mvista.com>
Date: Wed, 15 May 2002 14:59:34 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: Matthew Dharm <mdharm@momenco.com>, Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: MIPS 64?
References: <NEBBLJGMNKKEEMNLHGAIOEPPCGAA.mdharm@momenco.com> <20020515214818.GA1991@nevyn.them.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Daniel Jacobowitz wrote:

> On Wed, May 15, 2002 at 02:34:47PM -0700, Matthew Dharm wrote:
> 
>>So... I'm looking at porting Linux to a system with 1.5GiB of RAM.
>>That kinda blows the 32-bit MIPS port option right out of the water...
>>
> 
> Not unless you count bits differently than I do... 32-bit is 4 GiB.  Is
> there any reason MIPS has special problems in this area?
> 


MIPS has lower 2GB fixed for user space.  Then you have kseg0, .5GB for cached 
physical address 0-0.5GB, and kseg1, 0.5GB uncached mapping of the same area. 
  You can map another 1GB of RAM into kseg2/3, but you will then have no space 
left for IO.

So you really can't do 1.5GB on 32 bit kernel.

It is interesting that PPC allows one to adjust user space size and kernel 
space size.  So on PPC you can get up to 2.5GB system RAM with 1GB user space.

Back to 64bit port, it seems to me much of the 32bit work we have done in the 
past a year or so needs to be moved over.  Or better yet, if we can clean up 
integer/long issues, we might be able to use 32bit kernel code straight for 
64bit kernel.


Jun
