Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f650WNC02871
	for linux-mips-outgoing; Wed, 4 Jul 2001 17:32:23 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f650WMV02852
	for <linux-mips@oss.sgi.com>; Wed, 4 Jul 2001 17:32:22 -0700
Received: from dea.waldorf-gmbh.de (u-157-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.157]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA00252
	for <linux-mips@oss.sgi.com>; Wed, 4 Jul 2001 06:44:21 -0700 (PDT)
	mail_from (ralf@dea.waldorf-gmbh.de)
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f64DTuG04889;
	Wed, 4 Jul 2001 15:29:56 +0200
Date: Wed, 4 Jul 2001 15:29:56 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Steven Liu <stevenliu@psdc.com>
Cc: linux-mips@oss.sgi.com, "stevenliu@psdc.com" <jeff@moke.com>
Subject: Re: sti() does not work.
Message-ID: <20010704152956.F3829@bacchus.dhis.org>
References: <84CE342693F11946B9F54B18C1AB837B05CE09@ex2k.pcs.psdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <84CE342693F11946B9F54B18C1AB837B05CE09@ex2k.pcs.psdc.com>; from stevenliu@psdc.com on Tue, Jul 03, 2001 at 03:48:04PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 03, 2001 at 03:48:04PM -0700, Steven Liu wrote:

> I am working on the porting Linux to mips R3000 and  have a problem
> about sti( ) which is called in start_kernel( ).

> Before calling this function, status_register = 0x1000fc00 and
> cause_register=0x00008000. 
> Clearly, this is an interrupt of the CPU timer. 

R3000 doesn't have a CPU timer, so either you're porting to something else
than the R3000 or you don't have a CPU timer.

> When mtc0 instruction above is executed, the system hangs and the
> control does not go to the timer handler.

When the mtc0 gets executed you take the pending interrupt which goes to
the general exception vector at 0x80000180.  That's magic done in hardware.
So it looks like your interrupt handler is buggy.

  Ralf
