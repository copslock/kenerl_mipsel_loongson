Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2003 23:56:30 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:41711 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225201AbTDVW43>;
	Tue, 22 Apr 2003 23:56:29 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h3MMuPD31006;
	Tue, 22 Apr 2003 15:56:25 -0700
Date: Tue, 22 Apr 2003 15:56:25 -0700
From: Jun Sun <jsun@mvista.com>
To: Jeff Baitis <baitisj@evolution.com>
Cc: Pete Popov <ppopov@mvista.com>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: Improperly handled case in arch/mips/au1000/common/time.c
Message-ID: <20030422155625.E28544@mvista.com>
References: <20030422125450.E10148@luca.pas.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030422125450.E10148@luca.pas.lab>; from baitisj@evolution.com on Tue, Apr 22, 2003 at 12:54:50PM -0700
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


I think this is a good example to show benefit of code sharing.
There is no good reason for au1x00 boards of not using new time.c.
You get to write less board code, fewer bugs and future proof.

Jun

On Tue, Apr 22, 2003 at 12:54:50PM -0700, Jeff Baitis wrote:
> Pete:
> 
> While struggling to get Linux up on Evolution's custom board based on the
> Au1500, I discovered a poorly handled case in time.c; null interrupts are
> handled should not affect the local IRQ count. (if the local IRQ count is not
> decremented, tests for in_irq() fail.)
> 
> Thanks for taking a look at my patch!
> 
> -Jeff
> 
> Index: time.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/au1000/common/time.c,v
> retrieving revision 1.5.2.10
> diff -u -r1.5.2.10 time.c
> --- time.c      25 Mar 2003 14:30:19 -0000      1.5.2.10
> +++ time.c      22 Apr 2003 19:47:24 -0000
> @@ -114,6 +114,7 @@
>         return;
>  
>  null:
> +       irq_exit(cpu, irq);
>         ack_r4ktimer(0);
>  }
> 
> 
