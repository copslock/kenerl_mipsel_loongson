Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jan 2003 19:51:02 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:44029 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225264AbTATTvB>;
	Mon, 20 Jan 2003 19:51:01 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h0KJoxr01662;
	Mon, 20 Jan 2003 11:50:59 -0800
Date: Mon, 20 Jan 2003 11:50:59 -0800
From: Jun Sun <jsun@mvista.com>
To: Gilad Benjamini <yaelgilad@myrealbox.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: Getting Time Difference
Message-ID: <20030120115059.U2100@mvista.com>
References: <ECEPLLMMNGHMFBLHCLMAGEGDDIAA.yaelgilad@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <ECEPLLMMNGHMFBLHCLMAGEGDDIAA.yaelgilad@myrealbox.com>; from yaelgilad@myrealbox.com on Thu, Jan 16, 2003 at 06:48:09PM +0200
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, Jan 16, 2003 at 06:48:09PM +0200, Gilad Benjamini wrote:
> Hi,
> I am porting code from a x86 platform.
> That code uses rdtsc and cpu_khz to compute
> the time difference between two events. Jiffies aren't good enough in this 
> case.
> 
> Looking through header files I can find a few MIPS replacements.
> What is the "right" one to use ?
> 
> What is the best way to change the code so it can compile
> and run on both platforms ?
>

I assume you are doing this inside kernel for some performance
measurement.

In mvsita kernel we introduced an abstraction layer which consists
of the following:

readclock_init()
readclock()
clock_to_usecs()

For MIPS in general, we use the following implementation:

#define readclock_init()
#define readclock(low)   do {                           \
        db_assert(mips_cpu.options & MIPS_CPU_COUNTER); \
        low = read_32bit_cp0_register(CP0_COUNT);       \
        } while (0)     
#define clock_to_usecs(clocks) ((clocks) / ((mips_counter_frequency / 1000000)))

In mvl kernel we always calibrate mips_counter_frequency even if it
is not specified by board code.  This is different from the current
linux-mips.org tree.

Jun 
