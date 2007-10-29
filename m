Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Oct 2007 12:17:43 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:15317 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022348AbXJ2MRk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Oct 2007 12:17:40 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9TCHaWq015735;
	Mon, 29 Oct 2007 12:17:36 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9TCHQib015734;
	Mon, 29 Oct 2007 12:17:26 GMT
Date:	Mon, 29 Oct 2007 12:17:26 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: Fix (workaround?) for BCM Bigsur
Message-ID: <20071029121726.GA15726@linux-mips.org>
References: <20071028202249.GC22287@networkno.de> <20071028204328.GB16898@linux-mips.org> <20071029114406.GB18384@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071029114406.GB18384@networkno.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 29, 2007 at 11:44:06AM +0000, Thiemo Seufer wrote:

> > > the appended patchlet allows to boot current HEAD on a BCM1480.
> > > Without it the kernel dies in an unhandled interrupt loop.
> > 
> > I think it's a bugfix.  The whole {sb1250,bcm1250}_steal_irq() irq seems
> > to be a hack papering needed only to paper over other implementation
> > issues.
> 
> FYI, I removed all the *_steal_irq stuff in my tree, the resulting
> kernel works fine on a BCM1480.

Thanks.  I already have f514a361491aea38160f2c9eb4f7494f06b8263a which
deletes the thing in my tree and queued for Linus.

  Ralf
