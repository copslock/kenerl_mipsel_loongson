Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Aug 2003 17:45:22 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:27126 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225209AbTHNQpT>;
	Thu, 14 Aug 2003 17:45:19 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h7EGjF601287;
	Thu, 14 Aug 2003 09:45:15 -0700
Date: Thu, 14 Aug 2003 09:45:15 -0700
From: Jun Sun <jsun@mvista.com>
To: "Sirotkin, Alexander" <demiurg@ti.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: tasklet latency and system calls on mips
Message-ID: <20030814094515.B1203@mvista.com>
References: <3F3A411C.70603@ti.com> <20030813095446.C9655@mvista.com> <3F3B53C0.30408@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3F3B53C0.30408@ti.com>; from demiurg@ti.com on Thu, Aug 14, 2003 at 12:17:52PM +0300
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, Aug 14, 2003 at 12:17:52PM +0300, Sirotkin, Alexander wrote:
> 
> I suspect that what happens is as follows :
> 
> system call arrives and while it's being processed and interrupt to one
> of the drivers arrives. This interrupt 
> schedules a tasklet which however is not executed after the system call
> finishes, 

The tasklet should be executed at the return of interrupt handling.
If not, there is a bug.


> only after the next timer
> interrupt which causes up to 10 ms latency (not all the time, only when
> somebody makes a system call).
> 

BTW, make sure tasklet_schedule() is indeed called in an interrupt handler.
I am not sure why will happen otherwise.

If you suspect it is a bug, you can easily trace them.  You may my
little tracing tool useful,

	http://linux.junsun.net/patches/generic/experimental/030716.a-jstrace.patch

Jun
