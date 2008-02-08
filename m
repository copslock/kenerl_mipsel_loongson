Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Feb 2008 14:44:21 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:38316 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28575756AbYBHOoT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 8 Feb 2008 14:44:19 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m18EiI4R022457;
	Fri, 8 Feb 2008 14:44:18 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m18EiHOD022456;
	Fri, 8 Feb 2008 14:44:17 GMT
Date:	Fri, 8 Feb 2008 14:44:17 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Florian Fainelli <florian.fainelli@telecomint.eu>,
	linux-mips@linux-mips.org
Subject: Re: early_ioremap for MIPS
Message-ID: <20080208144417.GA22331@linux-mips.org>
References: <200802071932.23965.florian.fainelli@telecomint.eu> <Pine.LNX.4.64N.0802081058350.7017@blysk.ds.pg.gda.pl> <20080208122858.GA8267@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080208122858.GA8267@alpha.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 08, 2008 at 01:28:59PM +0100, Thomas Bogendoerfer wrote:

> Jazz has the same problem. Right now it's solved by using wired tlb
> entries. Which is sort of an early_ioremap.

One with a totally awkward API requiring the user having to know about
the underlying TLB organization.  A better implementation wouldn't be
hard to do, for anything that's outside of KSEG1's address range grab
a new TLB entry if needed and wire an entry into it.  Use the same
API as good old ioremap() and call the result early_ioremap().

  Ralf
