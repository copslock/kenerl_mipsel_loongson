Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8SEmkN13721
	for linux-mips-outgoing; Fri, 28 Sep 2001 07:48:46 -0700
Received: from dea.linux-mips.net (lt200001.hrz.uni-oldenburg.de [134.106.156.150])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8SEmgD13716
	for <linux-mips@oss.sgi.com>; Fri, 28 Sep 2001 07:48:43 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f8SEm5a31225;
	Fri, 28 Sep 2001 16:48:05 +0200
Date: Fri, 28 Sep 2001 16:48:05 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Mike Manchip <michael.manchip@s3group.com>
Cc: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: having trouble installing exceptions
Message-ID: <20010928164805.A31094@dea.linux-mips.net>
References: <016601c1481c$be873260$845978c1@temple.leop.s3group.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <016601c1481c$be873260$845978c1@temple.leop.s3group.com>; from michael.manchip@s3group.com on Fri, Sep 28, 2001 at 01:54:43PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Sep 28, 2001 at 01:54:43PM +0100, Mike Manchip wrote:

> I'm currently trying to get the mips port to work on a galileo gt64115 board
> with a rm5231 chip.
> 
> I'm OK right until the point when I'm installing exceptions into
> non-cacheable space in arch/mips/kernel/traps.c
> 
> as soon as I memcpy except_vec3_generic to KSEG0 + 0x180 and flush the
> instruction cache, my machine hangs, and I can't see why!

KSEG0 is normally cached space.  If of some reason it's configured as
non-cachable and you're flushing caches funny things will happen.

> /* Copy the generic exception handler code to it's final destination. */
>  memcpy((void *)(KSEG0 + 0x80), &except_vec1_generic, 0x80);
>  memcpy((void *)(KSEG0 + 0x100), &except_vec2_generic, 0x80);
>  memcpy((void *)(KSEG0 + 0x180), &except_vec3_generic, 0x80);
>  flush_icache_range(KSEG0 + 0x80, KSEG0 + 0x200);
> 
> Is it possibly something to do with the monitor I'm using? I'm using both
> PROM and in desperation, a vxworks one (it can see the ethernet card, thus
> speeding up kernel loads tremendously).
> How does the monitor do exceptions? Do I have to do something special with
> exceptions when a monitor is present?

So firmware is operating with BEV set, thus won't use the vectors at
KSEG0 at all.

  Ralf
