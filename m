Received:  by oss.sgi.com id <S553717AbRAWXxV>;
	Tue, 23 Jan 2001 15:53:21 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:26103 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553657AbRAWXxB>;
	Tue, 23 Jan 2001 15:53:01 -0800
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f0NNnvI29135;
	Tue, 23 Jan 2001 15:49:57 -0800
Message-ID: <3A6E1977.2B18484D@mvista.com>
Date:   Tue, 23 Jan 2001 15:53:27 -0800
From:   Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: bg, en
MIME-Version: 1.0
To:     Quinn Jensen <jensenq@Lineo.COM>
CC:     linux-mips@oss.sgi.com
Subject: Re: CONFIG_MIPS_UNCACHED
References: <3A6E132B.9000103@Lineo.COM>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Quinn Jensen wrote:
> 
> Ralf,
> 
> On some machines with weird firmware (e.g. IDT 334 board)
> the processor comes up with the cache already enabled for
> kseg0.  In this case, the set_cp0_config() call in mips32.c
> to turn off the cache (gated by CONFIG_MIPS_UNCACHED) should
> probably come after the first call to flush_cache_all(),
> which is safer but still not totally safe, I suppose.
> Or am I totally hosed trying to turn the kseg0 cache off
> after it was once on?

That's an issue not only when you're "turning off" the cache, but
whenever you muck with the kseg0 cache coherency attribute.  The Galileo
EV96100, running Galileo's pmon, comes up with kseg0 set to 3, which is
the default linux kseg0 cache coherency attribute. However, calling
set_cp0_config() without first flushing the cache destroys some data,
eventhough the same exact kseg0 attribute is set. 

I think a complete cache flush is in order before calling
set_cp0_config() and that's a change we should make for all cpus.

Pete
