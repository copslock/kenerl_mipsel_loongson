Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jul 2007 14:14:47 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:3563 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021496AbXGJNOp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Jul 2007 14:14:45 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6AD49ZV018558;
	Tue, 10 Jul 2007 14:04:10 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6AD49Ki018548;
	Tue, 10 Jul 2007 14:04:09 +0100
Date:	Tue, 10 Jul 2007 14:04:09 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] DEC: Fix modpost warning.
Message-ID: <20070710130409.GA14723@linux-mips.org>
References: <S20022577AbXGJLug/20070710115036Z+13637@ftp.linux-mips.org> <Pine.LNX.4.64N.0707101401001.18036@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0707101401001.18036@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15666
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 10, 2007 at 02:07:21PM +0100, Maciej W. Rozycki wrote:
> From: "Maciej W. Rozycki" <macro@linux-mips.org>
> Date: Tue, 10 Jul 2007 14:07:21 +0100 (BST)
> To: linux-mips@linux-mips.org
> Subject: Re: [MIPS] DEC: Fix modpost warning.
> Content-Type: TEXT/PLAIN; charset=US-ASCII
> 
> On Tue, 10 Jul 2007, linux-mips@linux-mips.org wrote:
> 
> >   LD      vmlinux
> >   SYSMAP  System.map
> >   SYSMAP  .tmp_System.map
> >   MODPOST vmlinux
> > WARNING: drivers/built-in.o(.data+0x2480): Section mismatch: reference to .init.text: (between 'sercons' and 'ds_parms')
> > 
> > Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> > 
> > ---
> > 
> >  drivers/tc/zs.c |    6 +++---
> >  1 files changed, 3 insertions(+), 3 deletions(-)
> 
>  It looks like a bogus warning -- I presume it comes from a reference from 
> "sercons" to serial_console_setup() -- but the driver is going away, so I 
> could not care less...

Yes, the root cause was the reference to serial_console_setup.  It's hard
to teach modpost that this reference is bogus so I fixed the driver instead.
Other console drivers had the same issue.

  Ralf
