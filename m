Received:  by oss.sgi.com id <S42226AbQFYVjK>;
	Sun, 25 Jun 2000 14:39:10 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:36922 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42183AbQFYVit>;
	Sun, 25 Jun 2000 14:38:49 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA03496; Sun, 25 Jun 2000 14:33:21 -0700 (PDT)
	mail_from (ulfc@calypso.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id OAA10715; Sun, 25 Jun 2000 14:36:34 -0700 (PDT)
Received: from calypso.engr.sgi.com (calypso.engr.sgi.com [163.154.5.113])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA27047;
	Sun, 25 Jun 2000 14:34:46 -0700 (PDT)
	mail_from (ulfc@calypso.engr.sgi.com)
Received: by calypso.engr.sgi.com (Postfix, from userid 37984)
	id 634AEA7875; Sun, 25 Jun 2000 14:33:50 -0700 (PDT)
From:   Ulf Carlsson <ulfc@calypso.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14678.31422.353864.773880@calypso.engr.sgi.com>
Date:   Sun, 25 Jun 2000 14:33:50 -0700 (PDT)
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     "Gleb O. Raiko" <raiko@niisi.msk.ru>,
        "Bradley D. LaRonde" <brad@ltc.com>,
        linux-mips <linux-mips@fnet.fr>,
        linux <linux@cthulhu.engr.sgi.com>
Subject: Re: XFree 4.0.1 on mips, mipsel
In-Reply-To: <20000625001255.C894@bacchus.dhis.org>
References: <20000623181736.A13410@bert.physik.uni-konstanz.de>
	<014f01bfdd33$8877b3c0$0701010a@ltc.com>
	<20000623185553.A20888@bert.physik.uni-konstanz.de>
	<019501bfdd35$bb301940$0701010a@ltc.com>
	<20000623190723.B20888@bert.physik.uni-konstanz.de>
	<01cb01bfdd3a$fc43b2c0$0701010a@ltc.com>
	<39547DB3.4FF35339@niisi.msk.ru>
	<20000624131218.A17554@bilbo.physik.uni-konstanz.de>
	<20000625001255.C894@bacchus.dhis.org>
X-Mailer: VM 6.75 under Emacs 20.5.1
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle writes:
 > On Sat, Jun 24, 2000 at 01:12:18PM +0200, Guido Guenther wrote:
 > 
 > > [..snip..] 
 > > > If you cross-compile, you just redefine most of the stuff like CcCmd,
 > > > ArCmd, etc, anyway.
 > > Yes, but you have to make sure the redefinitions don't get redefined
 > > again, therefore IMHO an "#ifdef AsCmd" is needed. Otherwise the
 > > definition in hosts.def will be overriden by the one in linux.cf.
 > 
 > Does X building ever need the hostcompiler?  If not, then you can easily
 > do crossbuilds like:
 > 
 >   PATH=<prefix>/<target>/bin:$PATH make ...

Yes.  You need the hostcompiler when you do X builds.  It is possible
to get around it though.  I have the commands that I used in two shell
scripts.

First I have to to prepare for the cross build:

#!/bin/sh
make clean
make Makefile.boot
make Makefiles
(cd config; make)
make includes
make depend
(cd fonts/bdf; for i in $(find -name 'Makefile'); do sed -e 's/\$(XBUILDBINDIR)\///' < $i > $i.tmp; mv $i.tmp $i; done)

Then I'm ready to build the rest with the cross compiler:

#!/bin/sh
export PATH=/usr/glibc-mips/bin:$PATH 
make -k CC=mips-linux-gcc LD=mips-linux-ld AS=mips-linux-as RANLIB=mips-linux-ranlib $@

You probably have a better solution though :-)

Ulf
