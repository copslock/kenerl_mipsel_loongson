Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jul 2004 11:43:21 +0100 (BST)
Received: from grey.subnet.at ([IPv6:::ffff:193.170.141.20]:48397 "EHLO
	grey.subnet.at") by linux-mips.org with ESMTP id <S8225004AbUGWKnQ> convert rfc822-to-8bit;
	Fri, 23 Jul 2004 11:43:16 +0100
Received: from localhost ([193.170.141.4]) by grey.subnet.at ; Fri, 23 Jul 2004 12:43:11 +0200
From: Bruno Randolf <bruno.randolf@4g-systems.biz>
To: linux-mips@linux-mips.org, dev-list@meshcube.org
Subject: Re: Q: (cross)compiling for the Meshcube  (fwd)
Date: Fri, 23 Jul 2004 12:41:16 +0200
User-Agent: KMail/1.6.2
Cc: Ralf Ackermann <rac@KOM.tu-darmstadt.de>
References: <Pine.LNX.4.58.0407221756020.4845@shofar.kom.e-technik.tu-darmstadt.de>
In-Reply-To: <Pine.LNX.4.58.0407221756020.4845@shofar.kom.e-technik.tu-darmstadt.de>
Organization: 4G Systems
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407231241.16183.bruno.randolf@4g-systems.biz>
Return-Path: <bruno.randolf@4g-systems.biz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bruno.randolf@4g-systems.biz
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hi!

we use crosstool from http://www.kegel.com/crosstool/ to create a cross 
toolchain. it is also part of our build system, we have at 
http://www.meshcube.org/ in the CVS. if you check it out, you can cd into the 
build/ directory and "make toolchain". the cross prefix is then 
mipsel-mtx-linux-gnu-.

greetings,
bruno



On Thursday 22 July 2004 17:56, Ralf Ackermann wrote:
> Hello,
>
> I'm trying to (cross)compile some more modules/applications for the
> meshcube - but failed so far.
>
> I installed (on an i386 system):
> 	binutils-mipsel-linux-2.13.2.1-3.i386.rpm
> 	gcc-mipsel-linux-2.95.4-1.i386.rpm
> (from ftp://ftp.linux-mips.org/pub/linux/mips/crossdev/)
>
> Making a hello world program fails with:
> 	mipsel-linux-gcc hello.c -o hello
> 	/usr/mipsel-linux/bin/ld: cannot open crt1.o: No such file or directory
> 	collect2: ld returned 1 exit status
>
> My questions:
>  - Are there any specific hints for the cross-compile environment
> 	(or: "What are you using ... and would therefore suggest ?)
>  - Is there any chance to use a native gcc on the cube itself?
> 	(could this e.g. been done by chrooting into a (which?)
> 	existing MIPS Linux distribution that is mounted via NFS)
>
> Any hints are highly appreciated (I have worked with crosscompile/native
> environments for ARM so far, but these are my first experiences in the
> MIPS world).
>
> regards
>  Ralf
>
> ---------------------------------------------------------------
> Dr. Ralf Ackermann            _         rac@KOM.tu-darmstadt.de
> Multimedia Communications |/ | | |\/|           Merckstrasse 25
>
>                           |\ |_| |  |  64283 Darmstadt, Germany
>
> Tel.: (+49) 6151 16-6138                Fax: (+49) 6151 16-6152
> ---------------------------------------------------------------
>              http://www.kom.tu-darmstadt.de/~rac
> ---------------------------------------------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBAOtMfg2jtUL97G4RAqaVAJkBIcsWlDTyGUr4Py9AsL/3+lWxIQCffaLI
2H+9w74+YH2YkZbK4KJ4zwQ=
=7PWO
-----END PGP SIGNATURE-----
