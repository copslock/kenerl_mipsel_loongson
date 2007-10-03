Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Oct 2007 02:00:56 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:36320 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024228AbXJCBAy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Oct 2007 02:00:54 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9310r1u025772;
	Wed, 3 Oct 2007 02:00:53 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9310r6s025771;
	Wed, 3 Oct 2007 02:00:53 +0100
Date:	Wed, 3 Oct 2007 02:00:53 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
Message-ID: <20071003010053.GA25603@linux-mips.org>
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl> <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org> <Pine.LNX.4.64N.0710021651490.32726@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0710021651490.32726@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 02, 2007 at 05:08:05PM +0100, Maciej W. Rozycki wrote:

> > I have a patch which makes the generated code accessible through a
> > procfs file.  That can easily be converted back into a .o file and then
> > be disassembled.  So it's now a question of which variant is preferable.
> 
>  There is no need to go through such hassle even:
> 
> $ objdump -b binary -m mips:4000 -d /proc/foo
> 
> or suchlike should work (the program seems to be sensitive to the file 
> size though, so it better be non-zero).
> 
> > I don't mind - it's just that I've never been a friend of leaving much
> > debugging code or features around.  99% of the time it is just make the
> > code harder to read and maintain.
> 
>  In this case I would let these bits stay in though.  The bootstrap log 
> always works and can be captured with the serial console or read from the 
> screen, and if there is a subtle breakage in these generated bits then the 
> system may never get far enough for procfs to be accessible.  It is these 
> moments it matters the most.

I originally wrote my variant as a tool for optimization.

Anyway, queued for 2.6.24.  That is if 2.6.23 is ever released ;-)

  Ralf
