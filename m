Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Apr 2004 14:41:43 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:53996 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225780AbUDTNll>; Tue, 20 Apr 2004 14:41:41 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id D46264AD95; Tue, 20 Apr 2004 15:41:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id BA9FE4794B; Tue, 20 Apr 2004 15:41:32 +0200 (CEST)
Date: Tue, 20 Apr 2004 15:41:32 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [RFC] Separate time support for using cpu timer
In-Reply-To: <20040419180720.H14976@mvista.com>
Message-ID: <Pine.LNX.4.55.0404201522220.28193@jurand.ds.pg.gda.pl>
References: <20040419180720.H14976@mvista.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 19 Apr 2004, Jun Sun wrote:

> Solution
> --------
> 
> All the boards that I am really concerned right now have cpu count/compare
> registers.  I believe this will even more so in the future.
> 
> Therefore I like to propose a separate time support for systems that use
> cpu timer as their system timer.
> 
> As you can see from the patch, the new code is much simpler.

 It makes it separate again -- more maintenance burden and a bigger
opportunity to have functional divergence, sigh...

 Additionally I don't think using the CP0 Count & Compare registers for
the system timer is the way to go.  It's rather a way to escape when
there's no other possibility.  A lot of systems have a reliable external
timer interrupt source and using it actually would free the CP0 registers
for other uses, like profiling or a programmable interval timer.

> The hidden agenda
> -----------------
> 
> OK, I admit there is another motivation in all of this.  Linux is moving
> to have higher resolution timer.  For example, see the introduction of high resolution 
> posix timer (http://sourceforge.net/projects/high-res-timers/).  Having a MIPS common
> time routine based on cpu timer makes it much easier to support
> such a feature for MIPS boards.  We don't need to mess with individual board timer
> anymore.
> 
> In addition I think in 2.7 time frame Linux needs to replace its ancient jiffy
> time system with a natively higher resolution time system.  A MIPS cpu timer based 
> routine would evolve much better into the future.

 Well, I don't think the two issues are coupled together, although, there
may be certain dependencies.  E.g. an external time source may actually
have a good resolution.

 Anyway, the details may be worth discussing when 2.7 spins off,
preferably on the LKML, as this is about generic support.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
