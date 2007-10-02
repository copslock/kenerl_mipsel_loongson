Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Oct 2007 17:04:09 +0100 (BST)
Received: from mail.bawue.net ([193.7.176.63]:56218 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20024338AbXJBQEA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 Oct 2007 17:04:00 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id A8506E014B;
	Tue,  2 Oct 2007 18:03:35 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1IckDT-00049Q-Qs; Tue, 02 Oct 2007 17:03:23 +0100
Date:	Tue, 2 Oct 2007 17:03:23 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
Message-ID: <20071002160323.GF16772@networkno.de>
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl> <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071002154918.GA11312@linux-mips.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16796
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Tue, Oct 02, 2007 at 03:11:26PM +0100, Thiemo Seufer wrote:
> 
> > Maciej W. Rozycki wrote:
> > >  Dump the generated code for clear/copy page calls like it is done for TLB 
> > > fault handlers.  Useful for debugging.
> > > 
> > > Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> > > ---
> > > Thiemo,
> > > 
> > >  It was your change to add ".set noreorder", etc. to the TLB fault 
> > > handlers -- what is it needed for?  I have thought gas does not try to 
> > > outsmart the user at the moment and does not reorder ".word" directives.
> > 
> > It is not strictly needed, but it is a hint to the user that he looks
> > at raw instructions.
> 
> I have a patch which makes the generated code accessible through a
> procfs file.  That can easily be converted back into a .o file and then
> be disassembled.  So it's now a question of which variant is preferable.

I prefer output at startup. If you are interested in the disassembly you
probably don't have access to /proc. :-)


Thiemo
