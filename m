Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jun 2008 14:16:21 +0100 (BST)
Received: from www.church-of-our-saviour.org ([69.25.196.31]:22442 "EHLO
	thunker.thunk.org") by ftp.linux-mips.org with ESMTP
	id S28585996AbYFFNQT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Jun 2008 14:16:19 +0100
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1K4bqH-000799-7j; Fri, 06 Jun 2008 09:18:53 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1K4bnH-0002rc-7l; Fri, 06 Jun 2008 09:15:47 -0400
Date:	Fri, 6 Jun 2008 09:15:47 -0400
From:	Theodore Tso <tytso@mit.edu>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	Vorobiev Dmitri <dmitri.vorobiev@movial.fi>,
	Martin Michlmayr <tbm@cyrius.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>,
	linux-mips@linux-mips.org, linux-ext4@vger.kernel.org
Subject: Re: ext4dev build failure on mips: "empty_zero_page" undefined
Message-ID: <20080606131547.GB9033@mit.edu>
References: <90edad820805120654n50f7a00cm3c7b4a4f9346d5ea@mail.gmail.com> <20080512143426.GB7029@mit.edu> <90edad820805120746l61e67362vbd177d63e8b05dc8@mail.gmail.com> <20080513045028.GC22226@linux-mips.org> <20080528070637.GA10393@deprecation.cyrius.com> <20080605111148.GA4483@deprecation.cyrius.com> <1212664977.4840.6.camel@sd048.hel.movial.fi> <20080605183854.GN25477@mit.edu> <38408.84.249.59.97.1212701650.squirrel@webmail.movial.fi> <20080605215152.GB15504@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080605215152.GB15504@networkno.de>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Return-Path: <tytso@mit.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tytso@mit.edu
Precedence: bulk
X-list: linux-mips

On Thu, Jun 05, 2008 at 10:51:52PM +0100, Thiemo Seufer wrote:
> > Ted, Ralf seems to be unwilling to accept the ZERO_PAGE() export. If you
> > send the MIPS-specific patch, I can do the testing for you as I have a
> > MIPS Malta board at my disposal.

Ralf sent me a private note saying he would take care of this, but
that he had been very busy with real-world life items.

> AFAIU the problematic case are systems with R4000/R4400 SC/MC CPUs
> since they use 8 zero pages of different color. Have a look at
> arch/mips/mm/init.c:setup_zero_pages.

Right.  So we're not actually going to ever write to the page, but we
are going to add the page to a bio and submit for writing.  I assume
that's not going to cause VECI/VCED exceptions, right?  If the act of
DMA'ing, or worse yet, for older devices/drivers which have to use PIO
to write out a block device is going to cause "thousand and thousands
of exceptions", it sounds like MIPS CPU designers need to be slapped
silly....

					- Ted
