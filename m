Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 May 2003 10:56:20 +0100 (BST)
Received: from nx5.HRZ.Uni-Dortmund.DE ([IPv6:::ffff:129.217.131.21]:61802
	"EHLO nx5.hrz.uni-dortmund.de") by linux-mips.org with ESMTP
	id <S8225278AbTEJJ4S> convert rfc822-to-8bit; Sat, 10 May 2003 10:56:18 +0100
Received: from unimail.uni-dortmund.de (mx1.HRZ.Uni-Dortmund.DE [129.217.128.51])
	by nx5.hrz.uni-dortmund.de (Postfix) with ESMTP
	id E61154AA981; Sat, 10 May 2003 11:56:15 +0200 (MET DST)
Received: from linuxpc1 (p508EFB9C.dip.t-dialin.net [80.142.251.156])
	(authenticated (0 bits))
	by unimail.uni-dortmund.de (8.12.9+Sun/8.11.6) with ESMTP id h4A9u9tC011079
	(using TLSv1/SSLv3 with cipher RC4-MD5 (128 bits) verified NOT);
	Sat, 10 May 2003 11:56:10 +0200 (MEST)
From: Benjamin =?iso-8859-1?q?Menk=FCc?= <benmen@gmx.de>
Reply-To: menkuec@auto-intern.com
To: Daniel Jacobowitz <dan@debian.org>
Subject: Re: compiling glibc
Date: Sat, 10 May 2003 11:56:08 +0200
User-Agent: KMail/1.5.1
References: <200305092145.43690.benmen@gmx.de> <200305100303.48870.benmen@gmx.de> <20030510042535.GA2336@nevyn.them.org>
In-Reply-To: <20030510042535.GA2336@nevyn.them.org>
Cc: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200305101156.08254.benmen@gmx.de>
X-MailScanner-Information: UniDo-UniMail
X-MailScanner: Found to be clean
Return-Path: <benmen@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benmen@gmx.de
Precedence: bulk
X-list: linux-mips

Okay, it works now when I set CC=mipsel-linux-gcc and AS=mipsel-linux-as

[benmen@linuxpc1 mipsel-glibc] LD_LIBRARY_PATH="" CFLAGS="-O2 -g 
-finline-limit=10000" CC="mipsel-linux-gcc" AS="mipsel-linux-as" 
../glibc-2.3.2/configure --build=i686-linux --host=mipsel-linux 
--enable-add-ons --prefix=/home/benmen/mipsel 
--with-headers=/home/benmen/mips/kernel/mips-2.4.20/include

until this comes:

make[2]: Entering directory `/home/benmen/mips/glibc-2.3.2/misc'
make[2]: *** Keine Regel vorhanden, um das Target 
»/home/benmen/mips/mipsel-glibc/misc/cachectl.o«,
  benötigt von »/home/benmen/mips/mipsel-glibc/misc/stamp.o«, zu erstellen.  
Schluss.
make[2]: Leaving directory `/home/benmen/mips/glibc-2.3.2/misc'
make[1]: *** [misc/subdir_lib] Fehler 2
make[1]: Leaving directory `/home/benmen/mips/glibc-2.3.2'
make: *** [all] Fehler 2
Verzeichnis: ~/mips/mipsel-glibc
[benmen@linuxpc1 mipsel-glibc]

PS: shouldn't the Makefile take care of the CC and AS variables?

regards,

Ben
