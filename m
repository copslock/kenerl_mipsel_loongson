Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fATGMWb19698
	for linux-mips-outgoing; Thu, 29 Nov 2001 08:22:32 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fATGMDo19685;
	Thu, 29 Nov 2001 08:22:15 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA20140;
	Thu, 29 Nov 2001 16:21:46 +0100 (MET)
Date: Thu, 29 Nov 2001 16:21:46 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: calibrating MIPS counter frequency
In-Reply-To: <20011130020240.F638@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1011129161541.14485G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 30 Nov 2001, Ralf Baechle wrote:

> Better stick with the calibration procedure.  The crystal oscilators used
> in most computer systems don't provide the high accuracy of frequency
> that is required to keep the clock accurately over long time.  An RTC
> chip which you'd probably use as reference clock is better at that so
> should be used as the ultimate reference time in the kernel.

 On the contrary, the DECstation's undocumented I/O ASIC FCR (free running
counter) driven by the TURBOchannel bus clock is said to be much more
accurate than the DS1287 used there.  And it's David L. Mills who says so,
thus we may safely assume it's true. :-)

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
