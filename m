Received:  by oss.sgi.com id <S42209AbQGGAqm>;
	Thu, 6 Jul 2000 17:46:42 -0700
Received: from u-145.karlsruhe.ipdial.viaginterkom.de ([62.180.10.145]:14596
        "EHLO u-145.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42203AbQGGAqN>; Thu, 6 Jul 2000 17:46:13 -0700
Received:  by lappi.waldorf-gmbh.de id <S407622AbQGGAqI>;
	Fri, 7 Jul 2000 02:46:08 +0200
Date:   Fri, 7 Jul 2000 02:46:08 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jeff Harrell <jharrell@ti.com>
Cc:     linux-mips@oss.sgi.com, bbrown@ti.com
Subject: Re: Question concerning necessary libraries for 2.4.x kernel upgrade
Message-ID: <20000707024608.D2303@bacchus.dhis.org>
References: <3964C025.623F7F5@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3964C025.623F7F5@ti.com>; from jharrell@ti.com on Thu, Jul 06, 2000 at 11:21:41AM -0600
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Jul 06, 2000 at 11:21:41AM -0600, Jeff Harrell wrote:

> I am currently upgrading my MIPS development board (Atlas) that contains
> a R4Kc (jade core)
> and version 2.2.12 of the Linux kernel to a 2.4.x series kernel.   I
> believe the  libraries and applications
> were built off of the hardhat distribution.  We are able to run the
> 2.4.x version of the kernel on the Atlas
> board but are seeing problems with some of the executables.  I examined
> the Changes file and am in the
> process of upgrading the following binaries/libraries..
> 
> GNU C  2.7.2.3

2.7.2.3 may work or not.  Most people are using egcs 1.0.3a, so I recommend
using that one.

> binutils 2.9.1.0.22

DON'T touch, stick with 2.8.1.

> util-linux 2.10g
> modutils 2.3.0

I have no reports about modutils 2.3.0.

> e2fsprogs 1.18
> pcmcia-cs 3.1.13
> ppp 2.4.0b1
> 
> I am seeing problems with executables such as awk, groff, troff, etc.
> Will I need to rebuild each of these
> applications  against the new libraries to run or should they still
> function after I have upgraded the previously
> mentioned packages?  Are there mipsel version of these packages (either
> source or binaries) available somewhere?

You can try the DECstation package (see howto) or get the src.rpm
packages from oss.sgi.com which has a preliminary RH 6.0 port.  The packages
should build for little endian also.

  Ralf
