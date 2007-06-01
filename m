Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jun 2007 13:50:58 +0100 (BST)
Received: from sith.mimuw.edu.pl ([193.0.96.4]:28439 "EHLO sith.mimuw.edu.pl")
	by ftp.linux-mips.org with ESMTP id S20025593AbXFAMu4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Jun 2007 13:50:56 +0100
Received: by sith.mimuw.edu.pl (Postfix, from userid 1062)
	id 2E1E830A4B2; Fri,  1 Jun 2007 14:50:52 +0200 (CEST)
Date:	Fri, 1 Jun 2007 14:50:52 +0200
From:	Jan Rekorajski <baggins@sith.mimuw.edu.pl>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] zs: Move to the serial subsystem
Message-ID: <20070601125052.GA15787@sith.mimuw.edu.pl>
Mail-Followup-To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
References: <Pine.LNX.4.64N.0705291258390.14456@blysk.ds.pg.gda.pl> <20070530165842.GL29894@sith.mimuw.edu.pl> <Pine.LNX.4.64N.0705301802570.27697@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0705301802570.27697@blysk.ds.pg.gda.pl>
X-Operating-System: Linux 2.6.19.1 i686
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <baggins@sith.mimuw.edu.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baggins@sith.mimuw.edu.pl
Precedence: bulk
X-list: linux-mips

On Wed, 30 May 2007, Maciej W. Rozycki wrote:

> On Wed, 30 May 2007, Jan Rekorajski wrote:
> 
> > Look functional to me (just booted my DecStation 5000/240) :)
> 
>  Great!  Thanks for testing.
> 
> > Any chance to get LK201/401 keyboard and vsxxxaa mouse working with this?
> 
>  For the time being a solution is the patch below and then:
[...]

Keyboard works, I have functional console :)
Mouse looks good too, but I'll test it when I install a functional
system on that machine.

>  I am looking into a solution that would make it automatic without the 
> need of involving userland which just does not seem right here -- you do 
> want to run your kernel with "init=/bin/bash" or suchlike and have your 
> virtual terminal console usable.  I will remove the old lk201 bits then.

Why not do that in the driver? AFAIK there can't be anything else on
those ports.

Janek
-- 
Jan Rekorajski            |  ALL SUSPECTS ARE GUILTY. PERIOD!
baggins<at>mimuw.edu.pl   |  OTHERWISE THEY WOULDN'T BE SUSPECTS, WOULD THEY?
BOFH, MANIAC              |                   -- TROOPS by Kevin Rubio
