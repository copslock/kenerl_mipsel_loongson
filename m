Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6MAZYZ10679
	for linux-mips-outgoing; Sun, 22 Jul 2001 03:35:34 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6MAZWV10674
	for <linux-mips@oss.sgi.com>; Sun, 22 Jul 2001 03:35:32 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (8.9.3/8.9.3) with ESMTP id MAA30016
	for <linux-mips@oss.sgi.com>; Sun, 22 Jul 2001 12:35:31 +0200 (MDT)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.22 #1 (Debian))
	id 15OGa7-0003hV-00
	for <linux-mips@oss.sgi.com>; Sun, 22 Jul 2001 12:35:27 +0200
Date: Sun, 22 Jul 2001 12:35:26 +0200
To: linux-mips@oss.sgi.com
Subject: Re: mips64 linker bug?
Message-ID: <20010722123526.K16278@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010722113923.A17752@tuxedo.skovlyporten.dk>
User-Agent: Mutt/1.3.18i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Lars Munch Christensen wrote:
> On Sat, Jul 21, 2001 at 09:07:37PM +0200, Ralf Baechle wrote:
> > On Sat, Jul 21, 2001 at 06:17:33PM +0200, Lars Munch Christensen wrote:
> > 
> > > Thanks...What should I do now? Change my code to mips32 or are there some
> > > patches to binutils that I can use, to get it working?
> > 
> > Depends on what you want to do?
> 
> I'm working on a very small, single address space, microkernel and I have
> the MIPS Malta with a 5Kc CPU to develop it on. The 5Kc is compatible
> with mips32 but I must admit, I really like to have my kernel
> running 64bit :).

An Kernel with 64bit addresses is less compact and likely to run slower.
OTOH, a 64bit Kernel has certainly some hack value. :-)

> Is there a working binutils for 64 bit code floating
> around somewhere or should I stick with the mips32 stuff?

Using 32bit is surely the easier way to go.

You might try the toolchain I use for my mips64-linux development.
Be warned: It's barely good enough to compile a linux kernel, no
pic code and therefore no libc. You have to compile it yourself,
the source is available at
http://www.csv.ica.uni-stuttgart.de/homes/ths/linux-mips/

Have fun. :-)


Thiemo
