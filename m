Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f650WPp02898
	for linux-mips-outgoing; Wed, 4 Jul 2001 17:32:25 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f650WNV02879
	for <linux-mips@oss.sgi.com>; Wed, 4 Jul 2001 17:32:23 -0700
Received: from dea.waldorf-gmbh.de (u-157-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.157]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA01162
	for <linux-mips@oss.sgi.com>; Wed, 4 Jul 2001 06:44:21 -0700 (PDT)
	mail_from (ralf@dea.waldorf-gmbh.de)
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f64DQJP04877;
	Wed, 4 Jul 2001 15:26:19 +0200
Date: Wed, 4 Jul 2001 15:26:19 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: linux-mips@oss.sgi.com
Subject: Re: sti() does not work.
Message-ID: <20010704152619.E3829@bacchus.dhis.org>
References: <84CE342693F11946B9F54B18C1AB837B05CE09@ex2k.pcs.psdc.com> <20010704122329.B30713@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010704122329.B30713@rembrandt.csv.ica.uni-stuttgart.de>; from ica2_ts@csv.ica.uni-stuttgart.de on Wed, Jul 04, 2001 at 12:23:29PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jul 04, 2001 at 12:23:29PM +0200, Thiemo Seufer wrote:

> > extern __inline__ void  __sti(void)
> > {
> > 	__asm__ __volatile__(
> > 		".set\tnoreorder\n\t"
> > 		".set\tnoat\n\t"
> > 		"mfc0\t$1,$12\n\t"
> > 		"ori\t$1,0x1f\n\t"
> > 		"xori\t$1,0x1e\n\t"
> > 		"mtc0\t$1,$12\n\t"               /* <----- problem  here! */
> 
> Here should follow some nop's on a MIPS I system to make sure $12
> is written

There are no nops there since we simply don't care how how many cycles
after the mtc0 the interrupts actually get enabled.  Worst case is the
R4000's 8 stage pipeline where we have a latency of 3 cycles, clearly
nothing that justifies wasting memory and cycles for nops.

> (why is noreorder used here?).

Without the .set noreorder the assembler would be free to do arbitrary
reordering of the object code generated.  Gas doesn't do that but there
are other assemblers that do flow analysis and may generate object code
that doesn't look very much like the source they were fed with.

  Ralf
