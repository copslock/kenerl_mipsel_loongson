Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jun 2004 23:57:58 +0100 (BST)
Received: from smtp.seznam.cz ([IPv6:::ffff:212.80.76.43]:17571 "HELO
	smtp.seznam.cz") by linux-mips.org with SMTP id <S8225867AbUFHW5y>;
	Tue, 8 Jun 2004 23:57:54 +0100
Received: (qmail 13276 invoked from network); 8 Jun 2004 22:40:31 -0000
Received: from unknown (HELO umax645sx) (Ladislav.Michl@160.218.40.14)
  by smtp.seznam.cz with SMTP; 8 Jun 2004 22:40:31 -0000
Received: from ladis by umax645sx with local (Exim 3.36 #1 (Debian))
	id 1BXojj-0000i1-00
	for <linux-mips@linux-mips.org>; Wed, 09 Jun 2004 00:06:27 +0200
Date: Wed, 9 Jun 2004 00:06:04 +0200
To: Linux MIPS <linux-mips@linux-mips.org>
Subject: Re: VINO
Message-ID: <20040608220604.GA2578@umax645sx>
References: <20040608125437.GC19965@hydrogen.boeventronie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040608125437.GC19965@hydrogen.boeventronie.net>
User-Agent: Mutt/1.5.6+20040523i
From: Ladislav Michl <ladis@linux-mips.org>
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 08, 2004 at 02:54:37PM +0200, Jorik Jonker wrote:
> Hi,
> 
> I have been playing around a bit with my Indycam, but it seems that some work
> needs to be done to get a nice picture. I've read that it has something to do
> with clipping and that the brightness control register is silently ignored. I
> happen to have an IRIX installtion on my Indy as well, and I tried finding
> out how to read the VINO registers from IRIX, but with no luck.

Indeed, there's probably no easy way to read VINO registers from
userspace.

> I suppose that there must be some kernel-space piece of code to read the GIO
> (?) memory around adress 0x00080000, but I am not able to figure out how to
> do this in IRIX. Perhaps someone (with al little bit more kernel-hacking
> experience) could guide me a little bit on doing this?

That's right idea ((?) - EISA memory space)

> Are there other people beside ladis who are attemping to enhance the VINO
> driver in the linux kernel, and if so, what are your findings?
> I would really like to contribute to VINO development, but it's quite opaque
> matter to me, as the VINO spec is quite unclear and I am not certain what's
> exactly going wrong in the VINO driver.

If you're seriously considering to help with VINO development this link:
http://www.ac3.edu.au/SGI_Developer/books/DevDriver_PG/sgi_html/ch09.html
looks like a good starting point. It's easy, just write driver which
allows you to read VINO registers while capture in progress :)

	ladis
