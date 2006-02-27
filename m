Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Feb 2006 13:02:02 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:49435 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133484AbWB0NBx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Feb 2006 13:01:53 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1RD4j1Q005378;
	Mon, 27 Feb 2006 13:05:25 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1RCrhR0004989;
	Mon, 27 Feb 2006 12:53:43 GMT
Date:	Mon, 27 Feb 2006 12:53:43 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Martin Michlmayr <tbm@cyrius.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>,
	jblache@debian.org, rmk+serial@arm.linux.org.uk
Subject: Re: IP22 doesn't shutdown properly
Message-ID: <20060227125342.GA924@linux-mips.org>
References: <20060217225824.GE20785@deprecation.cyrius.com> <20060223221350.GA5239@deprecation.cyrius.com> <20060224190517.GA28013@lst.de> <20060227105236.GI12044@deprecation.cyrius.com> <Pine.LNX.4.62.0602271222120.18095@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0602271222120.18095@pademelon.sonytel.be>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10659
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 27, 2006 at 12:22:57PM +0100, Geert Uytterhoeven wrote:

> On Mon, 27 Feb 2006, Martin Michlmayr wrote:
> > * Christoph Hellwig <hch@lst.de> [2006-02-24 20:05]:
> > > This patch was dropped when a real fix went into one of the sun serial
> > > drivers with which this issue was seen before.  Please look through
> > > the drivers/serial/sun* changelogs and see what fix needs to be
> > > ported to the ip22zilog driver.
> > 
> > Ralf suggested to see what other changes have been made to the
> > sunzilog driver recently and update the ip22zilog driver accordingly.
> > Russell, please queue the following patch for 2.6.17.
> 
> Any chance they can be merged, to avoid such missed updates in the future?

I'm somewhat pessimistic on mergin.  I don't have a Sparc to test this and
in the past it didn't happen either - instead the kernel was living with
a bucketload of Zilog UART drivers.  Yet it's something that really should
be done.

  Ralf
