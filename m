Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 17:54:01 +0100 (BST)
Received: from relay01.mx.bawue.net ([193.7.176.67]:43213 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20022664AbXJYQxw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Oct 2007 17:53:52 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id EC8C248EA5;
	Thu, 25 Oct 2007 18:46:38 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.68)
	(envelope-from <ths@networkno.de>)
	id 1Il5xJ-0007pQ-7T; Thu, 25 Oct 2007 17:53:13 +0100
Date:	Thu, 25 Oct 2007 17:53:13 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Use a sensible tlbex default for unknown CPUs
Message-ID: <20071025165313.GE3994@networkno.de>
References: <20071025155912.GD3994@networkno.de> <20071025161023.GA24715@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071025161023.GA24715@linux-mips.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Thu, Oct 25, 2007 at 04:59:12PM +0100, Thiemo Seufer wrote:
> 
> > currently the kernel panics when it boots on an unknown CPU model
> > (with an unknown PRID). Based on the assumption that the majority
> > of newly supported CPU will conform to Release 2 standard, I wrote
> > the appended patch which handles unknown CPUs as R2. It isn't
> > completely bulletproof, as (yet unsupported) non-R1/R2 CPUs may
> > use the AT config bits for different purposes. I still think this
> > is good enough a test.
> > 
> > This patch allows me to boot Linux on a "generic" MIPS64R2 Qemu
> > without making up a potentially conflicting PRID. All-zeroes
> > like for other undefined fields does fine.
> 
> It's a little more elegant with cpu_has_mips_r2.  So how about below patch.

Fine with me.


Thiemo
