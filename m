Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id KAA17077; Mon, 7 Jul 1997 10:56:05 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA21671 for linux-list; Mon, 7 Jul 1997 10:55:49 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA21648 for <linux@cthulhu.engr.sgi.com>; Mon, 7 Jul 1997 10:55:45 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA00342
	for <linux@cthulhu.engr.sgi.com>; Mon, 7 Jul 1997 10:55:42 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id TAA11889; Mon, 7 Jul 1997 19:55:40 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199707071755.TAA11889@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id TAA26876; Mon, 7 Jul 1997 19:55:39 +0200
Subject: Re: MIPS Distribution status (Was: Status ...)
To: davem@jenolan.rutgers.edu (David S. Miller)
Date: Mon, 7 Jul 1997 19:55:39 +0200 (MET DST)
Cc: ralf@mailhost.uni-koblenz.de, linux@cthulhu.engr.sgi.com
In-Reply-To: <199707071619.MAA20927@jenolan.caipgeneral> from "David S. Miller" at Jul 7, 97 12:19:28 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>    From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
>    Date: Mon, 7 Jul 1997 18:10:24 +0200 (MET DST)
> 
>     - Package doesn't build for unknown reasons:
>        Emacs getty_ps e2fsprogs bdflush 
> 
> Emacs should build strictly out of the box in an of itself, I know
> because I specifically sent RMS patches for linux-mips support the
> moment I got it working last summer with GLIBC.  (I even then logged
> in to the gnu project machines and made sure those changes made it
> into his tree ;-)
> 
> If it isn't compiling at all, tell me how it is failing.

Ok, special service for the Emacs people.  I'll check out why the RPM
didn't build.  I didn't care about that yet because my favourite
editor still is the prophet of Rock'n'Roll ...

  Ralf
