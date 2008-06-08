Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Jun 2008 20:59:38 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:49395 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20026468AbYFHT7g (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 8 Jun 2008 20:59:36 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m58JxTCt022439;
	Sun, 8 Jun 2008 21:59:29 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m58JxKia022435;
	Sun, 8 Jun 2008 20:59:28 +0100
Date:	Sun, 8 Jun 2008 20:59:19 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Luke -Jr <luke@dashjr.org>
cc:	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org
Subject: Re: bcm33xx port
In-Reply-To: <200806081357.02601.luke@dashjr.org>
Message-ID: <Pine.LNX.4.55.0806082041150.15673@cliff.in.clinika.pl>
References: <200806072113.26433.luke@dashjr.org> <200806072332.06460.luke@dashjr.org>
 <Pine.LNX.4.55.0806081332560.15673@cliff.in.clinika.pl> <200806081357.02601.luke@dashjr.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, 8 Jun 2008, Luke -Jr wrote:

> It's not? Guess it came from the bcm63xx patches OpenWrt has that I'm using as 
> a base for this... Either way, it seems unlikely something claiming to 
> be "VxWorks System Boot" is a standard firmware.

 It would be best if the patches you are referring to got merged with the
mainline.  Otherwise whoever uses them is essentially on their own --
people lack the resources needed to chase random changes out there in
general.

> >  That's grossly wrong.  If you need to preset it for the time being till
> > you debug calibration, then for a MIPS processor assume one instruction
> > per clock tick and two instructions per loop -- that may not be entirely
> > correct, but is a good approximation.  Otherwise you risk peripheral
> > devices are not driven correctly with all sorts of the nasty results.
> 
> Meaning this?
> 	preset_lpj = loops_per_jiffy = 2;

 Not exactly.  Try harder -- this is simple arithmetic and you've got all
the data given above already. :)

> >  Well, you've got the system and I have no crystal ball.  You have means
> > to debug it.  See how control is passed to the RI exception.  Find which
> > of the TLB exceptions happens and how it proceeds.  Etc...
> 
> Unfortunately, I don't understand how to "see how control is passed" or 
> finding TLB exceptions... Could you point me in the right direction to learn 
> about this?

 You can check how the return address is set at the function's entry point 
to see how it's called.

 As to the TLB exceptions -- well, read the MIPS architecture spec first.  
Then -- well, referring you to arch/mips/mm/tlbex.c would be pure cruelty
;) -- but have a look at do_page_fault(), which is where all the
processing important here is done -- the machine code generated from
tlbex.c handles the success paths only.

> > and (b) control being transferred to a block of memory that isn't actually
> > code, as can happen if exception vectors or global pointers-to-functions
> > aren't set up correctly, or if the kernel stack is being corrupted.   When
> > you say "the instruction in question is a store word", how do you know that? 
> 
> The RI error spits out a bunch of info, including epc which presumably points 
> to the instruction causing the problem: ac85ffc0; this is 'sw a1,-64(a0)'

 I have seen that already and wrote these stores in __bzero are protected.  
Perhaps the fixup fails for some reason, but you need to investigate it
and this is why I suggested to see how the RI handler is reached.  Since
this is a known point the failure leads to, you should be able to work
backwards from there quite easily.

  Maciej
