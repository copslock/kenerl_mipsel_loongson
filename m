Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jan 2003 18:14:45 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:3316 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8224851AbTAUSOp>;
	Tue, 21 Jan 2003 18:14:45 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h0LIDcZ16722;
	Tue, 21 Jan 2003 10:13:38 -0800
Date: Tue, 21 Jan 2003 10:13:38 -0800
From: Jun Sun <jsun@mvista.com>
To: Gilad Benjamini <gilad@riverhead.com>
Cc: Gilad Benjamini <yaelgilad@myrealbox.com>,
	linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: Getting Time Difference
Message-ID: <20030121101338.W2100@mvista.com>
References: <328392AA673C0A49B54DABA457E37DAA08C300@exchange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <328392AA673C0A49B54DABA457E37DAA08C300@exchange>; from gilad@riverhead.com on Tue, Jan 21, 2003 at 07:48:57AM +0200
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Jan 21, 2003 at 07:48:57AM +0200, Gilad Benjamini wrote:
> > In mvsita kernel we introduced an abstraction layer which consists
> > of the following:
> > 
> > readclock_init()
> > readclock()
> > clock_to_usecs()
> > 
> > For MIPS in general, we use the following implementation:
> > 
> > #define readclock_init()
> > #define readclock(low)   do {                           \
> >         db_assert(mips_cpu.options & MIPS_CPU_COUNTER); \
> >         low = read_32bit_cp0_register(CP0_COUNT);       \
> >         } while (0)     
> > #define clock_to_usecs(clocks) ((clocks) / 
> > ((mips_counter_frequency / 1000000)))
> > 
> 
> Thx.
> How would I go about doing readclock to a 64 bit variable ?
> The 32 bit can wrap around pretty fast in today's processors.
>

This interface is meant for short and precise kernel timing
measurement.  Wraping around once does not cause problem as
long as the elapsed clock cycles is less than 2^32.  That gives 
you about 40 secs max interval on a CPU with 100MHz counter
frequency.

Jun
