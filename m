Received:  by oss.sgi.com id <S553808AbRAXULh>;
	Wed, 24 Jan 2001 12:11:37 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:65007 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553805AbRAXULN>;
	Wed, 24 Jan 2001 12:11:13 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f0OK87I03182;
	Wed, 24 Jan 2001 12:08:07 -0800
Message-ID: <3A6F36B8.4F10759B@mvista.com>
Date:   Wed, 24 Jan 2001 12:10:32 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Pete Popov <ppopov@mvista.com>
CC:     Quinn Jensen <jensenq@Lineo.COM>, linux-mips@oss.sgi.com
Subject: Re: CONFIG_MIPS_UNCACHED
References: <3A6E132B.9000103@Lineo.COM> <3A6E1977.2B18484D@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Pete Popov wrote:
> 
> Quinn Jensen wrote:
> >
> > Ralf,
> >
> > On some machines with weird firmware (e.g. IDT 334 board)
> > the processor comes up with the cache already enabled for
> > kseg0.  In this case, the set_cp0_config() call in mips32.c
> > to turn off the cache (gated by CONFIG_MIPS_UNCACHED) should
> > probably come after the first call to flush_cache_all(),
> > which is safer but still not totally safe, I suppose.
> > Or am I totally hosed trying to turn the kseg0 cache off
> > after it was once on?
> 
> That's an issue not only when you're "turning off" the cache, but
> whenever you muck with the kseg0 cache coherency attribute.  The Galileo
> EV96100, running Galileo's pmon, comes up with kseg0 set to 3, which is
> the default linux kseg0 cache coherency attribute. However, calling
> set_cp0_config() without first flushing the cache destroys some data,
> eventhough the same exact kseg0 attribute is set.
>

It is really surprising to know this.  It sounds like a CPU bug to me.  Can
some MIPS "gods" clarify if such a behaviour is a bug or allowed?

BTW, the CPU in EV96100 is QED RM7000, I believe.

Jun
