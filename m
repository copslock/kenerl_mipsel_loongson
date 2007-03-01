Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Mar 2007 19:10:22 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:57247 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039452AbXCATKV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Mar 2007 19:10:21 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l21JAK1F024287;
	Thu, 1 Mar 2007 19:10:20 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l21JAJKL024286;
	Thu, 1 Mar 2007 19:10:19 GMT
Date:	Thu, 1 Mar 2007 19:10:19 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Untangle the rest of the prom_printf mess and convert to early printk
Message-ID: <20070301191019.GA23843@linux-mips.org>
References: <S20039493AbXCASgj/20070301183639Z+38846@ftp.linux-mips.org> <Pine.LNX.4.64N.0703011853230.25556@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0703011853230.25556@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 01, 2007 at 06:55:30PM +0000, Maciej W. Rozycki wrote:

> >  arch/mips/dec/prom/console.c             |   38 +--------
> 
>  Any particular reason for replacing an optimised version with this 
> miserable contraption?

I doubt anybody will notice when the first few lines of bootup messages
take a few cycles extra.  For the moment it did matter to get rid of
the impressive barbed wire fence made from several independant early
printk implementations and macros, functions and function pointers being
named prom_printf with no apparent pattern.

If you think the code really needs to be optimized as the next step, I
take patches.

  Ralf
