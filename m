Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2007 09:57:12 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:38856 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022417AbXKHJ5K (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Nov 2007 09:57:10 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lA89vAvq011106;
	Thu, 8 Nov 2007 09:57:10 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lA89v9Aq011105;
	Thu, 8 Nov 2007 09:57:09 GMT
Date:	Thu, 8 Nov 2007 09:57:09 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] IP22: Disable EARLY PRINTK, because it breaks serial
	console
Message-ID: <20071108095709.GC10665@linux-mips.org>
References: <20070911104459.GB7624@alpha.franken.de> <20071030073349.GA15984@deprecation.cyrius.com> <Pine.LNX.4.64N.0711071648040.14970@blysk.ds.pg.gda.pl> <20071107215423.GA11915@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071107215423.GA11915@alpha.franken.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 07, 2007 at 10:54:23PM +0100, Thomas Bogendoerfer wrote:

> >  Ideally, of course, all the SCC drivers should get merged eventually, but 
> > due to subtle (and sometimes broken, as it is the case with the 
> > DECstation) differences in wiring for various systems it may never really 
> > happen, sigh...
> 
> having a more generic zilog driver with platform backends is quite high on
> my todo list. But I won't make promisses when this happens...

Right now there are alot of artificial differences between the sun and IP22
8530 drivers by just different prefixes.  A good start would already be
to unify all these needless differences which is largely a mechanical job.
Once that is that is it will become easier to spot all the relevant
functional differences - there aren't that many but by now they're well
hidden.

  Ralf
