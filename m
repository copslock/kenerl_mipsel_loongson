Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3G0Tn8d027437
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 15 Apr 2002 17:29:49 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3G0TnLO027435
	for linux-mips-outgoing; Mon, 15 Apr 2002 17:29:49 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from orion.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3G0Tj8d027426
	for <linux-mips@oss.sgi.com>; Mon, 15 Apr 2002 17:29:45 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.9.3/8.9.3) id RAA16425
	for linux-mips@oss.sgi.com; Mon, 15 Apr 2002 17:30:32 -0700
X-Sieve: cmu-sieve 2.0
Received: from orion.mvista.com (IDENT:root@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g3G0DMB04171
	for <jsun@mvista.com>; Mon, 15 Apr 2002 17:13:22 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.9.3/8.9.3) id RAA16335;
	Mon, 15 Apr 2002 17:18:08 -0700
Date: Mon, 15 Apr 2002 17:18:07 -0700
From: Jun Sun <jsun@mvista.com>
To: Lanny DeVaney <ldevaney@redhat.com>
Subject: Re: RTC question
Message-ID: <20020415171807.A16300@mvista.com>
References: <3CBB4BA7.1010304@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3CBB4BA7.1010304@redhat.com>; from ldevaney@redhat.com on Mon, Apr 15, 2002 at 04:52:39PM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Ralf has not checked in the higher-level RTC driver yet.  You can either
build a kernel from the linux-mips project on sourceforge.net, where the driver
is included, or try to apply the outdated patch from

http://linux.junsun.net/patches/oss.sgi.com/submitted/011110.mips-rtc.011110.1900.patch

It was created on Nov 11, 2001.

Jun

On Mon, Apr 15, 2002 at 04:52:39PM -0500, Lanny DeVaney wrote:
> I've used the NEW_TIME_C method to implement support for the Dallas 1501 
> RTC in my MIPS port .  I now successfully read the hw clock, and the 
> date program works, and I can change the time.
> 
> However, the hwclock program tells me that it can't access the Hardware 
> Clock and tells me that /dev/rtc doesn't exist (although it actually 
> does) when running hwclock --debug.  Also, I see an oddity that may be 
> related - ping reports zero (as in 0 msec) round trip times always.  I 
> configured CONFIG_RTC into the kernel, and checked the major, minor of 
> /dev/rtc on my embedded ramdisk.  Also, I don't see /proc/driver/rtc.  
> 
> Is this normal behavior with NEW_TIME_C  configurations?  I've checked 
> my rtc_get_time and rtc_set_time, ..., like I said, the 'date' program 
> works, reading and writing to the clock.
> 
> Thanks,
> Lanny DeVaney
> 
> 
> 
