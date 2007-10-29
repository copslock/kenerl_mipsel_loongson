Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Oct 2007 11:44:53 +0000 (GMT)
Received: from relay01.mx.bawue.net ([193.7.176.67]:38335 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20022236AbXJ2Loo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Oct 2007 11:44:44 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 6804048FB7;
	Mon, 29 Oct 2007 11:56:17 +0100 (CET)
Received: from ths by lagash with local (Exim 4.68)
	(envelope-from <ths@networkno.de>)
	id 1ImT2M-0006i0-NR; Mon, 29 Oct 2007 11:44:06 +0000
Date:	Mon, 29 Oct 2007 11:44:06 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Fix (workaround?) for BCM Bigsur
Message-ID: <20071029114406.GB18384@networkno.de>
References: <20071028202249.GC22287@networkno.de> <20071028204328.GB16898@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071028204328.GB16898@linux-mips.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Sun, Oct 28, 2007 at 08:22:49PM +0000, Thiemo Seufer wrote:
> 
> > Hello All,
> > 
> > the appended patchlet allows to boot current HEAD on a BCM1480.
> > Without it the kernel dies in an unhandled interrupt loop.
> 
> I think it's a bugfix.  The whole {sb1250,bcm1250}_steal_irq() irq seems
> to be a hack papering needed only to paper over other implementation
> issues.

FYI, I removed all the *_steal_irq stuff in my tree, the resulting
kernel works fine on a BCM1480.


Thiemo
