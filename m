Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fATGQpp19854
	for linux-mips-outgoing; Thu, 29 Nov 2001 08:26:51 -0800
Received: from the-village.bc.nu (lightning.swansea.linux.org.uk [194.168.151.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fATGQko19845;
	Thu, 29 Nov 2001 08:26:46 -0800
Received: from alan by the-village.bc.nu with local (Exim 3.22 #1)
	id 169TCZ-0000Lk-00; Thu, 29 Nov 2001 15:34:15 +0000
Subject: Re: calibrating MIPS counter frequency
To: macro@ds2.pg.gda.pl (Maciej W. Rozycki)
Date: Thu, 29 Nov 2001 15:34:15 +0000 (GMT)
Cc: ralf@oss.sgi.com (Ralf Baechle), jsun@mvista.com (Jun Sun),
   linux-mips@oss.sgi.com
In-Reply-To: <Pine.GSO.3.96.1011129161541.14485G-100000@delta.ds2.pg.gda.pl> from "Maciej W. Rozycki" at Nov 29, 2001 04:21:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E169TCZ-0000Lk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>  On the contrary, the DECstation's undocumented I/O ASIC FCR (free running
> counter) driven by the TURBOchannel bus clock is said to be much more
> accurate than the DS1287 used there.  And it's David L. Mills who says so,
> thus we may safely assume it's true. :-)

The old DEC hardware guaranteed good time quality. But thats rather unusual
beyond DEC. 
