Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Feb 2003 00:37:00 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:46331 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225201AbTBGAg7>;
	Fri, 7 Feb 2003 00:36:59 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h170alO03746;
	Thu, 6 Feb 2003 16:36:47 -0800
Date: Thu, 6 Feb 2003 16:36:47 -0800
From: Jun Sun <jsun@mvista.com>
To: Vivien Chappelier <vivienc@nerim.net>
Cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: [PATCH 2.5] r4k_switch task_struct/thread_info fixes
Message-ID: <20030206163647.F13258@mvista.com>
References: <Pine.LNX.4.21.0302032311160.25421-100000@melkor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0302032311160.25421-100000@melkor>; from vivienc@nerim.net on Mon, Feb 03, 2003 at 11:21:50PM +0100
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


Actually the following hunks are not right.  ST_OFF
should be applied against the task_struct, which is a0,
not thread_info (t3).  Try to back off the change and see if things
are ok.

Also see my next email before you rush into trying :-)

Jun


On Mon, Feb 03, 2003 at 11:21:50PM +0100, Vivien Chappelier wrote:
<snip>
>  	/*
>  	 * clear saved user stack CU1 bit
>  	 */
> -	ld	t0, ST_OFF(a0)
> +	ld	t0, ST_OFF(t3)
>  	li	t1, ~ST0_CU1
>  	and	t0, t0, t1
> -	sd	t0, ST_OFF(a0)
> +	sd	t0, ST_OFF(t3)
>  
>  	
>  	sll	t2, t0, 5
> Index: arch/mips/kernel/r4k_switch.S
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/kernel/r4k_switch.S,v
> retrieving revision 1.29
> diff -u -r1.29 r4k_switch.S
> --- arch/mips/kernel/r4k_switch.S	5 Nov 2002 19:51:47 -0000	1.29
> +++ arch/mips/kernel/r4k_switch.S	3 Feb 2003 22:06:17 -0000
> @@ -67,10 +67,10 @@
>  	/*
>  	 * clear saved user stack CU1 bit
>  	 */
> -	lw	t0, ST_OFF(a0)
> +	lw	t0, ST_OFF(t3)
>  	li	t1, ~ST0_CU1
>  	and	t0, t0, t1
> -	sw	t0, ST_OFF(a0)
> +	sw	t0, ST_OFF(t3)
>  
>  	FPU_SAVE_DOUBLE(a0, t0)			# clobbers t0
>  
> 
