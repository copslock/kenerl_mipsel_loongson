Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2003 23:55:35 +0100 (BST)
Received: from p508B6582.dip.t-dialin.net ([IPv6:::ffff:80.139.101.130]:51844
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225197AbTDCWze>; Thu, 3 Apr 2003 23:55:34 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h33MtQY12664;
	Fri, 4 Apr 2003 00:55:26 +0200
Date: Fri, 4 Apr 2003 00:55:26 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Dominic Sweetman <dom@mips.com>, linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20030404005526.B6583@linux-mips.org>
References: <16012.25072.379410.787234@gladsmuir.mips.com> <Pine.GSO.3.96.1030403183957.19058J-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1030403183957.19058J-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Apr 03, 2003 at 06:47:21PM +0200
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 03, 2003 at 06:47:21PM +0200, Maciej W. Rozycki wrote:

> > The length of the burst is encoded in the bus command sent out by the
> > R4000 at the beginning of a read or write cycle.  For the system to
> > work, the memory controller has to be able to do the right thing for
> > both of the lengths which might happen...
> [...]
> > This is true: for L2-equipped chips I assume you can't see the
> > difference between I- and D-.
> 
>  Ah sure -- now I see where a fault in my consideration is.  While
> thinking of SC chips, I forgot of the existence of PC ones -- certainly if
> the Magnum used a PC configuration, its chipset could easily observe a
> change of a p-cache line size.

The Magum was using a PC processor.  There also was some server version of
the system based on the SC CPU but afair it was sold as Millenium 4000
but aside of the CPU it was essentially the same.

  Ralf
