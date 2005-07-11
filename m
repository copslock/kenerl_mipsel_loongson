Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jul 2005 08:13:27 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:24586 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226519AbVGLHMP>; Tue, 12 Jul 2005 08:12:15 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j6C7D7mT002013;
	Tue, 12 Jul 2005 08:13:08 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j6BMZC2e003003;
	Mon, 11 Jul 2005 23:35:12 +0100
Date:	Mon, 11 Jul 2005 23:35:12 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
Cc:	linux-mips@linux-mips.org
Subject: Re: Origin 200 Status
Message-ID: <20050711223512.GA2808@linux-mips.org>
References: <20050711135718.GU2765@linux-mips.org> <Pine.GSO.4.10.10507111605570.23550-100000@helios.et.put.poznan.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.10.10507111605570.23550-100000@helios.et.put.poznan.pl>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 11, 2005 at 04:08:00PM +0200, Stanislaw Skowronek wrote:

> > Of course there's a NIC.  The driver has no special handling for IP27 and
> > is capable of reading the NICs on some machines at least.  That would be
> > a rather suprising ability if there was no NIC associated with that IOC3 ;-)
> 
> There is only a MAC NIC on a machine ths has. Remember that the Octane
> does not have the BaseIO NIC at the IOC3; both NICs placed there are
> actually hacks because of XBOW MicroLAN bug.

I was speaking of IP27, obviously.

> > > This is weird. This means the keyboard will not be operational, and I wish
> > > somebody (Ralf) looks into this. The IOC3 on IP27 BaseIO is a dual-slot
> > > device (takes two IRQs, the INTA and INTA+2).
> > All information that I have says only INTA is being used for IP27.  It
> > will probably take a bit of testing.
> 
> Yeah, change the interrupt assignments in ioc3.c, plug in a keyboard and
> try. If it works, everybody wins :)

I could do - but the plane ticket to plug the keyboard is on you ;-)

  Ralf
