Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jun 2007 16:43:01 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:42718 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022483AbXFDPl5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 4 Jun 2007 16:41:57 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l54FfalG030940;
	Mon, 4 Jun 2007 16:41:36 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l54FfaBF030939;
	Mon, 4 Jun 2007 16:41:36 +0100
Date:	Mon, 4 Jun 2007 16:41:36 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Unify watch.S and remove arch/mips/lib-{32,64}
Message-ID: <20070604154135.GA30296@linux-mips.org>
References: <20070605.000239.31638706.anemo@mba.ocn.ne.jp> <20070604151048.GA30128@linux-mips.org> <Pine.LNX.4.64N.0706041620500.863@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0706041620500.863@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 04, 2007 at 04:23:29PM +0100, Maciej W. Rozycki wrote:

> > I think we can simply drop the entire watchpoint support.  This was
> > only ever working on R4000/R4400 and even there only somewhat useful
> > for kernel debugging.  So if we ever use watchpoint support I think
> > something needs to be developed from scratch.
> 
>  A long-term plan is to make them available to userland through ptrace() 
> in a uniform way covering MIPS32/64 watchpoints as well for gdb and 
> suchlike.

Sure, one of infinitly many things on the to do list.  However the code
we currently havee isn't very useful for that purpose.  For maintenance
sake it should rather be rewritten in C and it needs to learn about
processors of the post R4400 era.

  Ralf
