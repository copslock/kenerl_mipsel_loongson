Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Aug 2004 08:24:57 +0100 (BST)
Received: from www.kreatel.se ([IPv6:::ffff:212.214.69.146]:12539 "EHLO
	berntsson.kreatel.se") by linux-mips.org with ESMTP
	id <S8224916AbUHQHYw>; Tue, 17 Aug 2004 08:24:52 +0100
Received: by BERNTSSON with Internet Mail Service (5.5.2653.19)
	id <QFY123YN>; Tue, 17 Aug 2004 09:24:50 +0200
Message-ID: <5BB336130A66D7119DEF009027463C2C0F2CDA@BERNTSSON>
From: Marcus Gustafsson <marcus.gustafsson@kreatel.se>
To: linux-mips@linux-mips.org
Subject: RE: Busybox v0.60.2 insmod gives segmentation fault without any m
	essages when trying to load a loadable module
Date: Tue, 17 Aug 2004 09:24:49 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Return-Path: <marcus.gustafsson@kreatel.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5649
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcus.gustafsson@kreatel.se
Precedence: bulk
X-list: linux-mips


> Manish Lohani wrote:
> > I have a driver loadable module which i am compiling with 
> the same gcc
> > flags as used to compile a kernel for a MIPS R5432 based NEC board.
> > 
> > On the development machine, to compile files driver1.c and 
> driver2.c:
> > $ mips_fp_le-gcc -fomit-frame-pointer -fno-strict-aliasing -G 0
> > -mno-abicalls -fno-pic -pipe -mtune=r5000 -mlong-calls 
> -mips2 -Wall -c
> > driver1.c
> > 
> > $mips_fp_le-ld -r -o driver --printmap --cref driver1.o driver2.o
> > 
> > mips_fp_le-gcc (GCC) version 3.3.1
> > mips_fp_le-ld (GNU ld) version 2.14
> > 
> > I have Busybox v0.60.2 on the target.
> > 
> > On the target:
> > # insmod ./driver
> > Using driver
> > Segmentation fault
> > #
> > 
> > Does anybody have any suggestions as to what could be wrong?
> > 
> 
> BusyBox0.60.x's insmod does not work with gcc-3.3 and above.
> 
> I use a patched version of the real insmod:
> 
> # insmod --version
> insmod version 2.4.25
> 
> I forget where I put the patch, but the insmod author told me that the
> patches were in a later version.  So if I were you, I would 
> use version
> 2.4.26 or higher.
> 
> David Daney.

Im using gcc-3.3.3 and busybox-0.60.5 and insmod works if I strip the debug
symbols from the module.

/Marcus Gustafsson
