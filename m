Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Aug 2003 18:08:44 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:19443 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225299AbTHRRIe>;
	Mon, 18 Aug 2003 18:08:34 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h7IH8VN16055;
	Mon, 18 Aug 2003 10:08:32 -0700
Date: Mon, 18 Aug 2003 10:08:31 -0700
From: Jun Sun <jsun@mvista.com>
To: "Sirotkin, Alexander" <demiurg@ti.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: tasklet latency and system calls on mips
Message-ID: <20030818100831.A16027@mvista.com>
References: <3F3A411C.70603@ti.com> <20030813095446.C9655@mvista.com> <3F3B53C0.30408@ti.com> <20030814094515.B1203@mvista.com> <3F40F0F0.1080106@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3F40F0F0.1080106@ti.com>; from demiurg@ti.com on Mon, Aug 18, 2003 at 06:29:52PM +0300
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3066
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Mon, Aug 18, 2003 at 06:29:52PM +0300, Sirotkin, Alexander wrote:
> 
> 
> 
> The tasklet should be executed at the return of interrupt handling.
> 
> If not, there is a bug.
> 
>   
> 
> I have a feeling that we are going in circles. Tasklets are executed at
> the return of interrupt handler.
> However, I suspect that this is not enough. 

If you follow this, plus "tasklet_schedule() is indeed called in an interrupt
handler", you will should see "executing tasklet at the return of interrupt
handler"  is _obviously_ enough.

> On mips (contrary to x86),
> system call is NOT an interrupt.
> It's a different exception with different handler. Therefore I suspect
> that tasklets are NOT called at 
> the end of system call exception handler (which is a different handler,
> not do_IRQ).
>

... which is fine, if you can follow the above logic.

Jun
