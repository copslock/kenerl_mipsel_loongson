Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5QD9qe29192
	for linux-mips-outgoing; Tue, 26 Jun 2001 06:09:52 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5QD9oV29189
	for <linux-mips@oss.sgi.com>; Tue, 26 Jun 2001 06:09:51 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA17610;
	Tue, 26 Jun 2001 15:11:42 +0200 (MET DST)
Date: Tue, 26 Jun 2001 15:11:41 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: carlson@sibyte.com, linux-mips@oss.sgi.com
Subject: Re: CONFIG_MIPS_UNCACHED
In-Reply-To: <008a01c0fe1d$1fbd9a00$0deca8c0@Ulysses>
Message-ID: <Pine.GSO.3.96.1010626145139.11763B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 26 Jun 2001, Kevin D. Kissell wrote:

> code into every MIPS/Linux kernel!  I wouldn't dream of preventing
> some one else from putting their full faith in the perfectly understood
> and well-documented bootloaders on their Indy or DECstation. ;-)

 With functions like malloc(), strlen(), strcpy(), printf(), getenv(),
etc. I wouldn't name the DECstation's firmware (the REX one) just a
bootloader.  It's more like a minimal libc with additional functionality
to interface to hw, it's very well documented indeed (as opposed to most
of DECstations' hw, sigh...) and it appears to present a kernel an
interface that conforms to published docs.

 Of course, I don't expect anyone to put a libc into their embedded
system's ROM.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
