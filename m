Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Aug 2003 17:52:53 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:21497 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225209AbTHNQwv>;
	Thu, 14 Aug 2003 17:52:51 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h7EGqku01328;
	Thu, 14 Aug 2003 09:52:46 -0700
Date: Thu, 14 Aug 2003 09:52:46 -0700
From: Jun Sun <jsun@mvista.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: [patch] Generic time trailing clean-ups
Message-ID: <20030814095246.C1203@mvista.com>
References: <20030814091326.A1203@mvista.com> <Pine.GSO.3.96.1030814182619.17768B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1030814182619.17768B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Aug 14, 2003 at 06:35:28PM +0200
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, Aug 14, 2003 at 06:35:28PM +0200, Maciej W. Rozycki wrote:
> On Thu, 14 Aug 2003, Jun Sun wrote:
> 
> > I am completely lost in your arguments.  Let us keep it to the basic.
> > 
> > Tell me what is wrong with the following, and why your proposal
> > is better than this:
> > 
> > 1) get rid of calibrate_*() function
> > 2) introduce a generic counter frequence calibration routine, which
> >    is only invoked when mips_counter_frequency is 0.
> > 3) If any board is not happy with this calibration, it is free to
> >    do its calibration in board_timer_init(), which would set
> >    mips_counter_frequency to be non-zero.
> 
>  So I am lost, too.  What I proposed with the patch is exactly what you
> describe above.  So what's wrong with it?
>

Oh, really? :)

1) I don't see you " get rid of calibrate_*() function"
2) oh, why? because your "generic counter frequence" is not generic -
   it requires board-specific routines.  I was referring to using
   jiffies to calibrate frequency.
3) I also don't see picky boards "do its calibration in board_timer_init()".

Your proposal differs in every count. :)

Jun
