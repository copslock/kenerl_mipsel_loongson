Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2006 16:22:35 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:263 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133801AbWCBQWQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2006 16:22:16 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k22GTgWb013062;
	Thu, 2 Mar 2006 16:29:42 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k22GTgA8013061;
	Thu, 2 Mar 2006 16:29:42 GMT
Date:	Thu, 2 Mar 2006 16:29:42 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: DDB5074 and DDB5476 eval boards
Message-ID: <20060302162942.GB8487@linux-mips.org>
References: <20060302161136.GA12460@linux-mips.org> <Pine.LNX.4.62.0603021717360.22852@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0603021717360.22852@pademelon.sonytel.be>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 02, 2006 at 05:18:59PM +0100, Geert Uytterhoeven wrote:

> On Thu, 2 Mar 2006, Ralf Baechle wrote:
> > Both boards don't compile anymore since include/linux/kbd_ll.h was removed
> > and nobody did complain making them perfect candidates for somebody who
> > either wants to take over maintenance or alternatively, removal of the
> > code.  Anybody still interested?
> 
> Since I finally moved last week, I hope to have more spare time in the future
> and revive my DDB5074. So please don't remove it yet.

If anything I'd be planning to remove the code after 2.6.17 has been
released which would leave several months.  But of course until then
you and Peter De Schrijver who also raised his hand for the DDB5074
will have fixed things ;-)

Any takers for the DDB5476?

  Ralf
