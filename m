Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Jun 2009 09:35:16 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:58297 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492282AbZFMHfI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 13 Jun 2009 09:35:08 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5CNDRlp006158;
	Sat, 13 Jun 2009 00:16:08 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5CNDRXf006156;
	Sat, 13 Jun 2009 00:13:27 +0100
Date:	Sat, 13 Jun 2009 00:13:27 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: MIPS: Sibyte: Remove irritating printk from set_affinity
Message-ID: <20090612231327.GA5299@linux-mips.org>
References: <S20023844AbZFIMUh/20090609122037Z+10394@ftp.linux-mips.org> <alpine.LFD.1.10.0906091702530.8994@ftp.linux-mips.org> <20090612124150.GB21878@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090612124150.GB21878@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 12, 2009 at 01:41:50PM +0100, Ralf Baechle wrote:

> On Tue, Jun 09, 2009 at 05:07:15PM +0100, Maciej W. Rozycki wrote:
> > From: "Maciej W. Rozycki" <macro@linux-mips.org>
> > Date: Tue, 9 Jun 2009 17:07:15 +0100 (WEST)
> > To: linux-mips@linux-mips.org
> > Subject: Re: MIPS: Sibyte: Remove irritating printk from set_affinity
> > Content-Type: TEXT/PLAIN; charset=US-ASCII
> > 
> > On Tue, 9 Jun 2009, linux-mips@linux-mips.org wrote:
> > 
> > > set_affinity() will be called with cpui masks, which have more than one
> > > cpu set.  Instead of generating noise we now select the first set
> > > cpu and use that for setting affinity.  The printk was being triggered
> > > frequently by recent distributions running on recent kernels.
> > 
> >  For the record: I don't think it relates to a distribution being "recent" 
> > at all -- the noise happens with my board with recent kernels and does not 
> > with older ones even though the userland is always the same.  Something 
> > must have changed within the kernel itself and it may be worth 
> > investigating what, why and whether it is legitimate.  I fear the change 
> > may be papering over some bug elsewhere.
> 
> You're right - I realized that after having hit the commit button ...
> 
> I don't think there really is a kernel bug there.  The function we changed
> is free to reject arguments.  The reason why the Sibyte kernel has this
> check is that its hardware routing capabilities allow it to route an
> interrupt to _all_ CPUs of a certain set while this Linux API assumes an
> interrupt to be sent to just _one_ of the CPUs contained in the set.  On
> Sibyte this would result in usually all CPUs taking an interrupt exception.
> Only one can take the interrupt lock for that interrupt; the other will
> return from exception without having done any useful work.  While it may
> give the lowest latencies this certainly involves a high overhead.  Yes,
> a closer look into why things are being done this way is probably justified.

And now there is a cleaner way to deal with this sort of issue, see
d5dedd4507d307eb3f35f21b6e16f336fdc0d82a.  The printk itself was a bug
in itself.  When do people learn that printk isn't stderr.

  Ralf
