Received:  by oss.sgi.com id <S42224AbQHIJtc>;
	Wed, 9 Aug 2000 02:49:32 -0700
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:27846 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S42196AbQHIJtH>;
	Wed, 9 Aug 2000 02:49:07 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA11527;
	Wed, 9 Aug 2000 11:38:37 +0200 (MET DST)
Date:   Wed, 9 Aug 2000 11:38:37 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     "Gleb O. Raiko" <raiko@niisi.msk.ru>
cc:     Ralf Baechle <ralf@uni-koblenz.de>,
        Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        Craig P Prescott <prescott@phys.ufl.edu>, linux-mips@fnet.fr,
        linux-mips@oss.sgi.com
Subject: Re: BREAK and magic SysRq handling for Z8530
In-Reply-To: <39911193.672C7E59@niisi.msk.ru>
Message-ID: <Pine.GSO.3.96.1000809110212.11080A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Gleb,

> Have you tested the patch? The problem isn't in the patch itself, but as

 Sure I did, to an extent I was able to.  No problems noticed.

> I see the zs driver is broken for a long time. At least, I used to patch
> heavily this driver for my Baget taht has 2 zs chips on board. Harald

 Well, the driver seems to work good enough for now to use a serial
console.  And the SysRq support is an absolute must when trying to debug a
locked-up kernel -- the lack of this support is a sign for me nobody is
currently working on DECstations at the moment. 

> has the plans to implement new version of the driver, but I guess he is
> busy all the time. Or have I missed a cleanup of the driver ?

 Hmm, I haven't noticed any, either.  Fixing the driver is actually on my
TODO list -- all the 8530 drivers present in Linux currently need to be
merged into a single one.  Also DMA and synchronous mode support has to be
implemented.  It's not on the top of my list, though.

> Also, changes in sunkbd.c, keyboard.c, and serial.c isn't a good idea.
> :-)

 It's actually the reverse. ;-)  Without these (oh well, sunkbd.c is for
completeness, indeed) you cannot compile-in the magic SysRq support if you
do not include the virtual terminal driver.  This is an unnecessary
limitation -- I don't want the VT (well, actually I would, if I had a
driver for my console, but I haven't, yet). 

 Such changes actually went into the Linus' 2.4.0-test6-pre* (but not mine
-- someone overtook me, and he also missed one bit ;-) ).

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
