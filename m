Received:  by oss.sgi.com id <S554100AbRBAPt0>;
	Thu, 1 Feb 2001 07:49:26 -0800
Received: from mail.sonytel.be ([193.74.243.200]:30883 "EHLO mail.sonytel.be")
	by oss.sgi.com with ESMTP id <S554081AbRBAPtE>;
	Thu, 1 Feb 2001 07:49:04 -0800
Received: from escobaria.sonytel.be (escobaria.sonytel.be [10.34.80.3])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id QAA09260;
	Thu, 1 Feb 2001 16:48:09 +0100 (MET)
Date:   Thu, 1 Feb 2001 16:48:09 +0100 (MET)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc:     Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: glibc 2.2 on MIPS
In-Reply-To: <Pine.GSO.3.96.1010201162756.17657K-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.4.10.10102011646500.1855-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 1 Feb 2001, Maciej W. Rozycki wrote:
> On Thu, 1 Feb 2001, Geert Uytterhoeven wrote:
> > Now it aborts later at:
> > | /bin/sh ./genscripts.sh . /usr/local/lib sparc-sun-solaris2.6 mipsel-unknown-linux-gnu mipsel-linux "elf32lsmip" "/usr/ccs/lib" elf32lsmip "mipsel-linux"
> > | ./genscripts.sh: ./emulparams/mipsel-linux.sh: not found
> > | make[3]: *** [eelf32lsmip.c] Error 1
> > | make[3]: Leaving directory `/usr/people/geert.nba/mipsel-linux-binutils-2.10.1-3/binutils-2.10.1/ld'
> > 
> > ld/emulparams/ doesn't seem to contain any mipsel-related files.
> 
>  Now you didn't run automake in bfd. ;-)  You need to run it in ld as

Thanks!

> well.  How about looking at the included spec file? 

Sorry, I didn't realize you had anything to do besides applying the patches,
configure and make (like I did last time).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
