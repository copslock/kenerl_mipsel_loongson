Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2003 21:20:00 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:16382 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225211AbTDVUUA>;
	Tue, 22 Apr 2003 21:20:00 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id NAA00853;
	Tue, 22 Apr 2003 13:19:55 -0700
Subject: Re: Improperly handled case in arch/mips/au1000/common/time.c
From: Pete Popov <ppopov@mvista.com>
To: baitisj@evolution.com
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <20030422125450.E10148@luca.pas.lab>
References: <20030422125450.E10148@luca.pas.lab>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1051042821.511.296.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 Apr 2003 13:20:21 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

Jeff,

Thanks, I'll get to this this week. Are there other outstanding Au
patches that you have sent me and I haven't applied yet? I just got back
from vacation so I'll get to them.

Pete

On Tue, 2003-04-22 at 12:54, Jeff Baitis wrote:
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
