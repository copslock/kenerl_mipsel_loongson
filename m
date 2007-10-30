Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2007 09:27:05 +0000 (GMT)
Received: from host87-170-dynamic.9-87-r.retail.telecomitalia.it ([87.9.170.87]:9111
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20023018AbXJ3J04 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 30 Oct 2007 09:26:56 +0000
Received: from eppesuig3 ([192.168.2.50])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1ImnN6-0004Gq-1b; Tue, 30 Oct 2007 10:26:53 +0100
Subject: Re: 2.4.24-rc1 does not boot on SGI
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20071030090943.GB17714@deprecation.cyrius.com>
References: <1193468825.7474.6.camel@scarafaggio>
	 <20071030083106.GA16763@deprecation.cyrius.com>
	 <1193733706.7731.15.camel@scarafaggio>
	 <20071030090943.GB17714@deprecation.cyrius.com>
Content-Type: text/plain
Date:	Tue, 30 Oct 2007 10:27:20 +0100
Message-Id: <1193736440.7731.40.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Il giorno mar, 30/10/2007 alle 10.09 +0100, Martin Michlmayr ha scritto:
> * Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org> [2007-10-30 09:41]:
> > 1. serial line does not work
> 
> What exactly is not working?  I see kernel messages but serial doesn't
> work when I reach user land.  Do you see the same?

Yes. I understood that the serial line is correctly setup at startup,
then when the serial8250 device is started, it scan all registered
drivers (including the "platform" one), it tries to assign the two uarts
registered from ip32-platform.c, but here it get lost because the first
line is correctly registered, but the second line overlap the first one.

What happens is that when registering the second uart, the serial device
look for an unused uart and it gets the one used by ttyS0. I think that
the device think the uart is free because our uarts are UPIO_MEM but
mapbase isn't used.

Beside this, there is an error in ip32-platform:uart8250_init() since
the two uart structures are initialised with the same
&mace->isa.serial1. (this has already been pointed out in a previous
message on this list.)

A solution would be to change the initialisation in
ip32-platform:uart8250_init() in order to use mapbase instead of
membase, but I don't know how to translate the two numbers to mapbase.
Infact, if you use mapbase, the serial device know how to translate it
to membase and will correctly find the uart as used.

Bye,
Giuseppe
