Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id HAA537734 for <linux-archive@neteng.engr.sgi.com>; Fri, 28 Nov 1997 07:06:47 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id HAA13834 for linux-list; Fri, 28 Nov 1997 07:02:26 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA13819 for <linux@cthulhu.engr.sgi.com>; Fri, 28 Nov 1997 07:02:16 -0800
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id HAA01278
	for <linux@cthulhu.engr.sgi.com>; Fri, 28 Nov 1997 07:02:14 -0800
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (the-great-packet-bucket-in-the-sky [163.164.160.21] (may be forged)) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id OAA16294; Fri, 28 Nov 1997 14:56:53 GMT
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0xbRqY-0005FvC; Fri, 28 Nov 97 14:56 GMT
Message-Id: <m0xbRqY-0005FvC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: Bintuils
To: ralf@uni-koblenz.de (Ralf Baechle)
Date: Fri, 28 Nov 1997 14:56:45 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, ralf@mailhost.uni-koblenz.de,
        linux@cthulhu.engr.sgi.com
In-Reply-To: <19971128145410.36065@thoma.uni-koblenz.de> from "Ralf Baechle" at Nov 28, 97 02:54:11 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>   - manually rebuild binutils 2.8.1 + patch.  When configuring binutils
>     2.8.1 do not use the --enable-shared option, it will make binutils
>     2.7 generate bad libraries.

Done that. I get a static and apparently workable binutils if I also turn
gcc optimisation off (otherwise gcc dumps)

>   - install the binutils just built

Done that

>   - You should now be able to rebuild the rpm without problems

gcc still dumps, if I fix that I get back to the original problem. This
is the 2.8.1 off sgi.com and has a "mips patch" listed in the spec file.

Im guessing the gcc one is a link bug that damaged gcc just slightly - zsh
also dumps gcc.

Alan
