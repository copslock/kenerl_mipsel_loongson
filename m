Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Feb 2005 16:16:28 +0000 (GMT)
Received: from alg138.algor.co.uk ([IPv6:::ffff:62.254.210.138]:29380 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224921AbVBFQQO>; Sun, 6 Feb 2005 16:16:14 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j16GBQR5016521;
	Sun, 6 Feb 2005 16:11:26 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j16GBQdi016520;
	Sun, 6 Feb 2005 16:11:26 GMT
Date:	Sun, 6 Feb 2005 16:11:26 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
Cc:	linux-mips@linux-mips.org
Subject: Re: patch like kexec for MIPS possible?
Message-ID: <20050206161126.GA16351@linux-mips.org>
References: <20050206155649.GA11452@linux-mips.org> <Pine.GSO.4.10.10502061710140.20130-100000@helios.et.put.poznan.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.10.10502061710140.20130-100000@helios.et.put.poznan.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Feb 06, 2005 at 05:11:53PM +0100, Stanislaw Skowronek wrote:

> > I guess only the big iron fraction among us will really be missing
> > something like kexec - firmware reinitialization may take minutes on that
> > calibre of system so being able to get around that would be a good thing.
> 
> Well, a firmware reinitialization on my Octane (the old one) takes
> minutes. Still, the kernel requires the hardware to be initalized by PROM
> (just like on Origins, really) so kexec is of no help here.

That's something that could be dealt with.

On Origins I usually disable memory test which helps a little but still
is slower than I'd like.  For general hacking eval boards that need like
a second to reset just rock :-)

  Ralf
