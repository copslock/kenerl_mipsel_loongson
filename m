Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Oct 2007 16:49:21 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:13521 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024323AbXJBPtT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 Oct 2007 16:49:19 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l92FnIoI014139;
	Tue, 2 Oct 2007 16:49:18 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l92FnIOP014138;
	Tue, 2 Oct 2007 16:49:18 +0100
Date:	Tue, 2 Oct 2007 16:49:18 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
Message-ID: <20071002154918.GA11312@linux-mips.org>
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl> <20071002141125.GC16772@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071002141125.GC16772@networkno.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16795
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 02, 2007 at 03:11:26PM +0100, Thiemo Seufer wrote:

> Maciej W. Rozycki wrote:
> >  Dump the generated code for clear/copy page calls like it is done for TLB 
> > fault handlers.  Useful for debugging.
> > 
> > Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> > ---
> > Thiemo,
> > 
> >  It was your change to add ".set noreorder", etc. to the TLB fault 
> > handlers -- what is it needed for?  I have thought gas does not try to 
> > outsmart the user at the moment and does not reorder ".word" directives.
> 
> It is not strictly needed, but it is a hint to the user that he looks
> at raw instructions.

I have a patch which makes the generated code accessible through a
procfs file.  That can easily be converted back into a .o file and then
be disassembled.  So it's now a question of which variant is preferable.

I don't mind - it's just that I've never been a friend of leaving much
debugging code or features around.  99% of the time it is just make the
code harder to read and maintain.

  Ralf
