Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id NAA190882; Sat, 16 Aug 1997 13:33:43 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA02837 for linux-list; Sat, 16 Aug 1997 13:33:29 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA02833 for <linux@cthulhu.engr.sgi.com>; Sat, 16 Aug 1997 13:33:26 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id NAA02754
	for <linux@cthulhu.engr.sgi.com>; Sat, 16 Aug 1997 13:33:24 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.6/8.6.9) with SMTP id WAA20565; Sat, 16 Aug 1997 22:33:21 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199708162033.WAA20565@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id WAA07467; Sat, 16 Aug 1997 22:33:18 +0200
Subject: Re: boot linux - wish
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sat, 16 Aug 1997 22:33:17 +0200 (MET DST)
Cc: shaver@neon.ingenia.ca, miguel@nuclecu.unam.mx, ariel@sgi.com,
        linux@cthulhu.engr.sgi.com
In-Reply-To: <m0wzheO-0005FiC@lightning.swansea.linux.org.uk> from "Alan Cox" at Aug 16, 97 01:08:12 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> > If I stick all the RH stuff in an initrd and then they do FTP install,
> > then they should be able to use it via boot /vmlinux or boot -f
> > bootp()..., no?
> 
> 2.1.4x blows up with an initrd - hopefully fixed in 2.1.50/soon but that
> means the SGI one will corrupt and explode atm

There are also additional MIPS bugs in the RAMdisk / initrd stuff.
Shame on me, I have not used (-> debugged) it since the new style
ramdisk code was merged ...

  Ralf
