Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Dec 2003 18:11:48 +0000 (GMT)
Received: from p508B5A82.dip.t-dialin.net ([IPv6:::ffff:80.139.90.130]:46571
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225240AbTL2SLr>; Mon, 29 Dec 2003 18:11:47 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hBTIBha5006179;
	Mon, 29 Dec 2003 19:11:43 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hBTIBdjU006178;
	Mon, 29 Dec 2003 19:11:39 +0100
Date: Mon, 29 Dec 2003 19:11:39 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Mark and Janice Juszczec <juszczec@hotmail.com>,
	linux-mips@linux-mips.org
Subject: Re: gdbserver and Re: hardware questions
Message-ID: <20031229181139.GA5946@linux-mips.org>
References: <Law10-F1098NvzHr4sR00062b5c@hotmail.com> <002401c3ce16$b44b1e10$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002401c3ce16$b44b1e10$10eca8c0@grendel>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 29, 2003 at 03:18:58PM +0100, Kevin D. Kissell wrote:

> If you want more of a "large format" mipsel platform
> to experiment with, you might be able to find an old
> "RISC PC" from Siemens or NEC with an R4000
> configured little-endian to run NT.  Maybe Ralf has
> one in his attic he'd care to sell you. ;o)

Unfortunately no.  Since Thomas Bogendoerfer stopped maintaining the Olivetti
support the support for MIPS Magnum 4000, MIPS Millenium, Olivetti M700-10
and Acer PICA is rotting away ...

> I've never used gdbserver myself.  I did manage to get
> some use out of the old 2.2-style kernel gdb hooks.
> I don't know that it's the root of your problem, but
> you should definitely get getty/shells off of whatever
> serial port you're trying to use for debug.  In theory,
> there are protocols to multiplex serial ports between
> gdb streams and other stuff, but I've never had any
> luck with them.   You may also need to make sure that
> you're starting gdb and gdbserver in the right order.
> Certainly, that was the case when booting with kgdb.

We have a special GDB console kernel option which is meant to support
exactly that kind of gdb + console multiplexing.

  Ralf
