Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Nov 2002 20:33:49 +0100 (CET)
Received: from p508B6A78.dip.t-dialin.net ([80.139.106.120]:21126 "EHLO
	p508B6A78.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S1123920AbSKHTds>; Fri, 8 Nov 2002 20:33:48 +0100
Received: (ralf@3ffe:8260:2020:2::20) by ralf.linux-mips.org
	id <S868139AbSKHTb6>; Fri, 8 Nov 2002 20:31:58 +0100
Date: Fri, 8 Nov 2002 20:31:58 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Jun Sun <jsun@mvista.com>,
	Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@linux-mips.org
Subject: Re: make xmenuconfig is broken
Message-ID: <20021108203158.A30956@bacchus.dhis.org>
References: <20021108183549.A9711@bacchus.dhis.org> <Pine.GSO.3.96.1021108192005.3217J-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1021108192005.3217J-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Nov 08, 2002 at 07:30:15PM +0100
X-Accept-Language: de,en,fr
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 08, 2002 at 07:30:15PM +0100, Maciej W. Rozycki wrote:

> > >  Renaming CONFIG_SERIAL_CONSOLE to CONFIG_SGI_SERIAL_CONSOLE where
> > > appropriate should suffice.
> > 
> > That's my part to fix, I guess.  However since not all SGI's are
> 
>  Yes, please -- I can do that myself, but it'd better be done by someone
> familiar with SGI hardware, so that all details are handled right.
> 
> > using the Zilog 8530 for their serial interfaces I'll rename it
> > CONFIG_IP22_SERIAL_CONSOLE.
> 
>  Well, the name of a variable doesn't matter (as my analysis professor
> used to say). ;-)

With no more generic stuff like CONFIG_SERIAL_CONSOLE in use by the Indy
code there will be less subtilities ...

  Ralf
