Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2007 17:51:10 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:55566 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021672AbXGKQvI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jul 2007 17:51:08 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id C5B15E1CC1;
	Wed, 11 Jul 2007 18:51:02 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h0-7nWT4ORsk; Wed, 11 Jul 2007 18:51:02 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 78335E1C67;
	Wed, 11 Jul 2007 18:51:02 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l6BGp8Vu025257;
	Wed, 11 Jul 2007 18:51:09 +0200
Date:	Wed, 11 Jul 2007 17:51:05 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Songmao Tian <tiansm@lemote.com>
cc:	LinuxBIOS Mailing List <linuxbios@linuxbios.org>,
	marc.jones@amd.com, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: about cs5536 interrupt ack
In-Reply-To: <Pine.LNX.4.64N.0707111634430.26459@blysk.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.64N.0707111729310.26459@blysk.ds.pg.gda.pl>
References: <4694A495.1050006@lemote.com> <Pine.LNX.4.64N.0707111347360.26459@blysk.ds.pg.gda.pl>
 <4694F4EB.8040000@lemote.com> <Pine.LNX.4.64N.0707111634430.26459@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.3/3635/Wed Jul 11 13:30:51 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 11 Jul 2007, Maciej W. Rozycki wrote:

> > > You can still dispatch interrupts manually by examining the IRR register,
> > > but having a way to ask the 8259A's prioritiser would be nice.  Although
> > > given such a lethal erratum you report I would not count on the prioritiser
> > > to provide any useful flexibility...
> > >   
> > yeah, that's a straight thought, tried but failed:(, patch followed.
> 
>  You may have to modify other functions from arch/mips/kernel/i8259.c; 
> yes, this makes the whole experience not as pretty as one would hope...

 BTW, have you considered skipping the whole 8259A legacy burden and using 
the interrupt mapper directly?  From a brief look at the datasheet I 
conclude you should be able to OR all the interrupt lines to a single 
8259A input (say IRQ0 for the sake of this consideration -- it does not 
matter), set it to the level triggered mode, mask all the 8259A inputs but 
this one and ignore the device from then on.

 It would work as a "virtual wire", using the Intel's terminology, with 
its INT output simply following its IR0 input.  You can type:

$ grep '8259A Virtual Wire' arch/i386/kernel/io_apic.c

for a reference; ;-) you can skip the AEOI setup as in a system based on a 
MIPS processor an INTA cycle will be unlikely to reach the 8259A by 
accident (which may happen in the wild world of broken PCs) -- which you 
have learnt the hard way by now already.

 You can then dispatch interrupts based on the interrupt mapper registers 
which has this nice side effect of much of the sharing having been 
removed.  It will not work with edge-triggered interrupts, but you do not 
need that 8254 timer, do you?

  Maciej
