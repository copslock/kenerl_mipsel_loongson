Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jul 2004 15:41:44 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:37901 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225010AbUGWOli>; Fri, 23 Jul 2004 15:41:38 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 28247E1C82; Fri, 23 Jul 2004 16:41:33 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06865-06; Fri, 23 Jul 2004 16:41:33 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id DD7DEE1C81; Fri, 23 Jul 2004 16:41:32 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.12.11/8.11.4) with ESMTP id i6NEfh55002842;
	Fri, 23 Jul 2004 16:41:44 +0200
Date: Fri, 23 Jul 2004 16:41:35 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Richard Henderson <rth@redhat.com>
Cc: Richard Sandiford <rsandifo@redhat.com>,
	Ralf Baechle <ralf@linux-mips.org>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
Subject: Re: [patch] MIPS/gcc: Revert removal of DImode shifts for 32-bit
 targets
In-Reply-To: <20040719213801.GD14931@redhat.com>
Message-ID: <Pine.LNX.4.55.0407201505330.14824@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0407191648451.3667@jurand.ds.pg.gda.pl>
 <87hds49bmo.fsf@redhat.com> <Pine.LNX.4.55.0407191907300.3667@jurand.ds.pg.gda.pl>
 <20040719213801.GD14931@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 19 Jul 2004, Richard Henderson wrote:

> >  Well, other targets, like the i386 (which didn't even have a 64-bit
> > variation till recently)...
> 
> Except that 80386 has 64-bit shifts in hardware.

 Indeed -- I tend to forget of these two, sigh...

> And in rebuttal to the "does not make linux jump through hoops"
> argument, see arch/*/lib/ for arm, h8300, m68k, sparc, v850.

 OK -- but then is there any way to convince gcc to embed a "static
inline" version of these functions instead of emitting a call?  Sometimes
putting these eight (or nine for ashrdi3) instructions inline would be a
performance win.

  Maciej
