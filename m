Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Nov 2007 19:36:05 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:27666 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20023897AbXKQTf5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 17 Nov 2007 19:35:57 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 22D20D8D9; Sat, 17 Nov 2007 19:35:50 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id D239674171; Sat, 17 Nov 2007 20:35:29 +0100 (CET)
Date:	Sat, 17 Nov 2007 20:35:29 +0100
From:	Martin Michlmayr <tbm@cyrius.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>,
	mips kernel list <linux-mips@linux-mips.org>
Subject: Re: Preliminary patch for ip32 ttyS* device
Message-ID: <20071117193529.GA11798@deprecation.cyrius.com>
References: <20071030214015.050b7950.giuseppe@eppesuigoccas.homedns.org> <20071031130828.GE14187@linux-mips.org> <1194446585.5849.21.camel@scarafaggio> <Pine.LNX.4.64N.0711071716470.14970@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0711071716470.14970@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17523
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Maciej W. Rozycki <macro@linux-mips.org> [2007-11-07 17:21]:
> > If mapbase isn't mandatory, the second part of my patch is
> > probably right and fixes a bug.
> 
> You ought to use mapbase and ioremap() with new code as you are not
> allowed to use readb()/writeb()/etc. on addresses obtained otherwise
> than by calling ioremap().  The use of request_mem_region(), etc. is
> not strictly mandatory, but it is nice to have.  Many serial drivers
> use these functions, so I cannot see a reason why it would be a
> hassle for ip32.

Can someone propose a patch?  It's quote unfortuntely that serial on
IP32 is still broken (including 2.6.23).
-- 
Martin Michlmayr
http://www.cyrius.com/
