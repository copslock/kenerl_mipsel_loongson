Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jul 2004 16:56:04 +0100 (BST)
Received: from drum.kom.e-technik.tu-darmstadt.de ([IPv6:::ffff:130.83.139.190]:31720
	"EHLO mailserver.KOM.e-technik.tu-darmstadt.de") by linux-mips.org
	with ESMTP id <S8224943AbUGVPz7>; Thu, 22 Jul 2004 16:55:59 +0100
Received: from KOM.tu-darmstadt.de by mailserver.KOM.e-technik.tu-darmstadt.de (8.7.5/8.7.5) with ESMTP id RAA02189; Thu, 22 Jul 2004 17:55:54 +0200 (MEST)
Date: Thu, 22 Jul 2004 17:56:19 +0200 (CEST)
From: Ralf Ackermann <rac@KOM.tu-darmstadt.de>
X-X-Sender: rac@shofar.kom.e-technik.tu-darmstadt.de
To: linux-mips@linux-mips.org
cc: Ralf Ackermann <rac@KOM.tu-darmstadt.de>
Subject: Q: (cross)compiling for the Meshcube  (fwd)
Message-ID: <Pine.LNX.4.58.0407221756020.4845@shofar.kom.e-technik.tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Ralf.Ackermann@KOM.tu-darmstadt.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rac@KOM.tu-darmstadt.de
Precedence: bulk
X-list: linux-mips


Hello,

I'm trying to (cross)compile some more modules/applications for the 
meshcube - but failed so far.

I installed (on an i386 system):
	binutils-mipsel-linux-2.13.2.1-3.i386.rpm
	gcc-mipsel-linux-2.95.4-1.i386.rpm
(from ftp://ftp.linux-mips.org/pub/linux/mips/crossdev/)

Making a hello world program fails with:
	mipsel-linux-gcc hello.c -o hello
	/usr/mipsel-linux/bin/ld: cannot open crt1.o: No such file or directory
	collect2: ld returned 1 exit status

My questions:
 - Are there any specific hints for the cross-compile environment
	(or: "What are you using ... and would therefore suggest ?)
 - Is there any chance to use a native gcc on the cube itself?
	(could this e.g. been done by chrooting into a (which?)
	existing MIPS Linux distribution that is mounted via NFS)

Any hints are highly appreciated (I have worked with crosscompile/native 
environments for ARM so far, but these are my first experiences in the 
MIPS world).

regards
 Ralf
 
---------------------------------------------------------------
Dr. Ralf Ackermann            _         rac@KOM.tu-darmstadt.de
Multimedia Communications |/ | | |\/|           Merckstrasse 25
                          |\ |_| |  |  64283 Darmstadt, Germany
Tel.: (+49) 6151 16-6138                Fax: (+49) 6151 16-6152
---------------------------------------------------------------
             http://www.kom.tu-darmstadt.de/~rac
---------------------------------------------------------------
