Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id AAA18785; Thu, 31 Jul 1997 00:25:46 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA03893 for linux-list; Thu, 24 Jul 1997 15:09:27 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA03459 for <linux@cthulhu.engr.sgi.com>; Thu, 24 Jul 1997 15:07:06 -0700
Received: from swan.ml.org (eerandy.swan.ac.uk [137.44.4.77]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA07224
	for <linux@cthulhu.engr.sgi.com>; Thu, 24 Jul 1997 15:07:03 -0700
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (surd [137.44.10.205]) by swan.ml.org (8.7.4/8.7.3) with SMTP id XAA21402; Thu, 24 Jul 1997 23:06:35 +0100
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0wrT66-0005FxC; Thu, 24 Jul 97 19:58 BST
Message-Id: <m0wrT66-0005FxC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: SGI 68k machines?
To: ralf@mailhost.uni-koblenz.de (Ralf Baechle)
Date: Thu, 24 Jul 1997 19:58:46 +0100 (BST)
Cc: knobi@munich.sgi.com, ralf@mailhost.uni-koblenz.de,
        linux@cthulhu.engr.sgi.com
In-Reply-To: <199707241300.PAA12689@informatik.uni-koblenz.de> from "Ralf Baechle" at Jul 24, 97 03:00:21 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> >  Build from 83/84 until probably 88. Not a bad system for
> > that time.
> 
> I wonder if there is still documentation for these beasts around such
> that some dino freak can hack Linux for them?

Linux 68K current has an absolute need for an FPU. Thats one of the big
macintrash problems we are facing as the 68LC040 not only has no FPU but
for many motorola broke the exception handling so you can't even emulate it

Alan
