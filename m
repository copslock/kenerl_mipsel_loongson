Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Aug 2003 13:32:37 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:14720 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225303AbTHPMcc>; Sat, 16 Aug 2003 13:32:32 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA15430;
	Sat, 16 Aug 2003 14:32:18 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Sat, 16 Aug 2003 14:32:17 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [patch] Generic time trailing clean-ups
In-Reply-To: <20030814095246.C1203@mvista.com>
Message-ID: <Pine.GSO.3.96.1030816142004.15339A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 14 Aug 2003, Jun Sun wrote:

> > > 1) get rid of calibrate_*() function
> > > 2) introduce a generic counter frequence calibration routine, which
> > >    is only invoked when mips_counter_frequency is 0.
> > > 3) If any board is not happy with this calibration, it is free to
> > >    do its calibration in board_timer_init(), which would set
> > >    mips_counter_frequency to be non-zero.
> > 
> >  So I am lost, too.  What I proposed with the patch is exactly what you
> > describe above.  So what's wrong with it?
> >
> 
> Oh, really? :)
> 
> 1) I don't see you " get rid of calibrate_*() function"

 The patch is for 2.4.  I won't cook a patch for 2.6 before applying this
one, sorry.  Feel free to do that yourself, based on my proposal.  If the
plan I've presented was unclear, then please tell me exactly, where. 

> 2) oh, why? because your "generic counter frequence" is not generic -
>    it requires board-specific routines.  I was referring to using
>    jiffies to calibrate frequency.

 The calibration routine is generic -- every backend can use it without
duplicating the code privately.  You cannot throw all platforms into a
single bag because of different timer IRQ sources.

 I have already written why jiffies cannot be used directly. 

> 3) I also don't see picky boards "do its calibration in board_timer_init()".

 If mips_hpt_frequency is non zero after calling board_time_init(), it's
not recalibrated -- have you actually read the code???

> Your proposal differs in every count. :)

 The details may differ a bit.  The principles are the same.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
