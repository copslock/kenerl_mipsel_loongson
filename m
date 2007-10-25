Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 17:41:17 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:10925 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023074AbXJYQlP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Oct 2007 17:41:15 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9PGf4Il025296;
	Thu, 25 Oct 2007 17:41:04 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9PGf3We025295;
	Thu, 25 Oct 2007 17:41:03 +0100
Date:	Thu, 25 Oct 2007 17:41:03 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Jan Nikitenko <jan.nikitenko@gmail.com>, linux-mips@linux-mips.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: fix au1xxx UART0 irq setup
Message-ID: <20071025164103.GA25206@linux-mips.org>
References: <4720A11E.5060101@gmail.com> <20071025140940.GC23398@linux-mips.org> <Pine.LNX.4.64N.0710251548080.24086@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0710251548080.24086@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 25, 2007 at 03:57:01PM +0100, Maciej W. Rozycki wrote:

> > That said, irq 0 is imho totally valid (take the good old PIT timer
> > interrupt of the PC as the classic example) and treating it as an invalid 
> > interrupt number is broken.
> 
>  I would rather -1 stood for the invalid IRQ number -- unlike with 0 
> chances are nobody will need 4G of interrupt lines or vectors (as 
> applicable) in a single system.  We sort of escape the problem with the 
> MIPS processors because the IP0 bit of the Cause register is a software 
> interrupt that is not used by devices, but still some platforms bypass the 
> built-in interrupt "controller" as only a single source is used in the 
> Cause register and want to start the numbering of lines in the external 
> controller from 0.

Time to convert those platforms to irq_cpu.c as well.

Anyway, I recall there was an argument against using -1 as the invalid
irq number - but since -1 is not a valid index into the irq_desc array
for example I would consider such use broken.  But does anybody recall
the details?

  Ralf
