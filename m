Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8SI0St17991
	for linux-mips-outgoing; Fri, 28 Sep 2001 11:00:28 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8SI0QD17988
	for <linux-mips@oss.sgi.com>; Fri, 28 Sep 2001 11:00:26 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f8SI3KB31992;
	Fri, 28 Sep 2001 11:03:20 -0700
Message-ID: <3BB4B8BA.9541C530@mvista.com>
Date: Fri, 28 Sep 2001 10:51:54 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Manchip <michael.manchip@s3group.com>
CC: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: having trouble installing exceptions
References: <016601c1481c$be873260$845978c1@temple.leop.s3group.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Mike Manchip wrote:
> 
> Hi all
> 
> I'm currently trying to get the mips port to work on a galileo gt64115 board
> with a rm5231 chip.
> 
> I'm OK right until the point when I'm installing exceptions into
> non-cacheable space in arch/mips/kernel/traps.c
> 
What do you mean by "non-cachable space"?  KSEG0 is cacheable by default.

> as soon as I memcpy except_vec3_generic to KSEG0 + 0x180 and flush the
> instruction cache, my machine hangs, and I can't see why!
>

Most likely it hangs in flush_icache_range().  Put some printk there.

Jun
