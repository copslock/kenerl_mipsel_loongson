Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Sep 2008 09:41:19 +0100 (BST)
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:36256
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20027669AbYI1IlM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 28 Sep 2008 09:41:12 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m8S8f8ss005947;
	Sun, 28 Sep 2008 09:41:08 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m8S8f6dV005945;
	Sun, 28 Sep 2008 09:41:06 +0100
Date:	Sun, 28 Sep 2008 09:41:06 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, sshtylyov@ru.mvista.com,
	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Message-ID: <20080928084106.GA5555@linux-mips.org>
References: <48C851ED.4090607@ru.mvista.com> <48CA8BEE.1090305@ru.mvista.com> <20080913.005904.07457691.anemo@mba.ocn.ne.jp> <200809271819.19510.bzolnier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200809271819.19510.bzolnier@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Sep 27, 2008 at 06:19:19PM +0200, Bartlomiej Zolnierkiewicz wrote:

> > > >>>+	__ide_flush_dcache_range((unsigned long)addr, size);
> > > 
> > > >>   Why is this needed BTW?
> > > 
> > > > Do you mean __ide_flush_dcache_range?  This is needed to avoid cache
> > > > inconsistency on PIO drive.  PIO transfer only writes to cache but
> > > > upper layers expects the data is in main memory.
> > > 
> > >     Hum, then I wonder why it's MIPS specific...
> > 
> > SPARC also have it.  And there were some discussions for ARM IIRC.

It should affect any architecture that has virtually indexed data caches
with aliases.

> I was under the impression that it has been addressed by Tejun at
> the higher-layer level (for both ide/libata) long time ago and that
> MIPS/SPARC code are just a left-overs which could be removed now?

I'd highly appreciate that.  The __ide_ins? / __ide_outs? ops don't know
if a page is mapped to userspace so will have to do unnecessary flushes.
A mechanism that allows flush_dcache_page to be used would be far
preferable.

  Ralf
