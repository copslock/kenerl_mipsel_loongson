Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAU1vUM20567
	for linux-mips-outgoing; Thu, 29 Nov 2001 17:57:30 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fAU1vRo20562
	for <linux-mips@oss.sgi.com>; Thu, 29 Nov 2001 17:57:27 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fATFx2M09359;
	Fri, 30 Nov 2001 02:59:02 +1100
Date: Fri, 30 Nov 2001 02:59:02 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: calibrating MIPS counter frequency
Message-ID: <20011130025902.A8456@dea.linux-mips.net>
References: <20011130020240.F638@dea.linux-mips.net> <Pine.GSO.3.96.1011129161541.14485G-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1011129161541.14485G-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Nov 29, 2001 at 04:21:46PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Nov 29, 2001 at 04:21:46PM +0100, Maciej W. Rozycki wrote:

> > Better stick with the calibration procedure.  The crystal oscilators used
> > in most computer systems don't provide the high accuracy of frequency
> > that is required to keep the clock accurately over long time.  An RTC
> > chip which you'd probably use as reference clock is better at that so
> > should be used as the ultimate reference time in the kernel.
> 
>  On the contrary, the DECstation's undocumented I/O ASIC FCR (free running
> counter) driven by the TURBOchannel bus clock is said to be much more
> accurate than the DS1287 used there.  And it's David L. Mills who says so,
> thus we may safely assume it's true. :-)

Whooa, Master Secundus Minutius Hora himself ;-)

Actually the accuracy of crystal oscillators may differ wildly depending
on the use in a system and environmental conditions.  In case of the
SGI Indy the DS1387 RTC (which is rated at +/- 25ppm ~= 1 minute / month) is
actually more accurate.

  Ralf
